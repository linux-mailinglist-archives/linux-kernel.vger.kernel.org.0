Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9952056707
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 12:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfFZKkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 06:40:31 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:54662 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfFZKka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:40:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id DE6ACFB03;
        Wed, 26 Jun 2019 12:40:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ERi-EqMGy_Mt; Wed, 26 Jun 2019 12:40:27 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 72BD248EAB; Wed, 26 Jun 2019 12:40:27 +0200 (CEST)
Date:   Wed, 26 Jun 2019 12:40:27 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Purism Kernel Team <kernel@puri.sm>
Subject: Re: [PATCH 4/4] drm/panel: jh057n0090: Add regulator support
Message-ID: <20190626104027.GA12710@bogon.m.sigxcpu.org>
References: <cover.1561482165.git.agx@sigxcpu.org>
 <b239f1db7a1f67988a9bd1ed62f6a1cf1dce944c.1561482165.git.agx@sigxcpu.org>
 <20190625212419.GB20625@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190625212419.GB20625@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,
On Tue, Jun 25, 2019 at 11:24:19PM +0200, Sam Ravnborg wrote:
> On Tue, Jun 25, 2019 at 07:05:19PM +0200, Guido G�nther wrote:
> > Allow to specify regulators for vcc and iovcc. According to the data
> > sheet the panel wants vcc (2.8V) and iovcc (1.8V) and there's no startup
> > dependency between the two.
> s/jh057n0090/jh057n00900
> 
> > 
> > Signed-off-by: Guido G�nther <agx@sigxcpu.org>
> > ---
> >  .../drm/panel/panel-rocktech-jh057n00900.c    | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> > index b8a069055fbc..f8f6f087b9bc 100644
> > --- a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> > +++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/media-bus-format.h>
> >  #include <linux/module.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <video/display_timing.h>
> >  #include <video/mipi_display.h>
> >  
> > @@ -47,6 +48,8 @@ struct jh057n {
> >  	struct drm_panel panel;
> >  	struct gpio_desc *reset_gpio;
> >  	struct backlight_device *backlight;
> > +	struct regulator *vcc;
> > +	struct regulator *iovcc;
> >  	bool prepared;
> >  
> >  	struct dentry *debugfs;
> > @@ -160,6 +163,8 @@ static int jh057n_unprepare(struct drm_panel *panel)
> >  		return 0;
> >  
> >  	mipi_dsi_dcs_set_display_off(dsi);
> > +	regulator_disable(ctx->iovcc);
> > +	regulator_disable(ctx->vcc);
> >  	ctx->prepared = false;
> >  
> >  	return 0;
> > @@ -174,6 +179,13 @@ static int jh057n_prepare(struct drm_panel *panel)
> >  		return 0;
> >  
> >  	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Resetting the panel\n");
> > +	ret = regulator_enable(ctx->vcc);
> > +	if (ret < 0)
> > +		return ret;
> > +	ret = regulator_enable(ctx->iovcc);
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> >  	usleep_range(20, 40);
> >  	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> > @@ -301,6 +313,13 @@ static int jh057n_probe(struct mipi_dsi_device *dsi)
> >  	if (IS_ERR(ctx->backlight))
> >  		return PTR_ERR(ctx->backlight);
> >  
> > +	ctx->vcc = devm_regulator_get(dev, "vcc");
> > +	if (IS_ERR(ctx->vcc))
> > +		return PTR_ERR(ctx->vcc);
> > +	ctx->iovcc = devm_regulator_get(dev, "iovcc");
> > +	if (IS_ERR(ctx->iovcc))
> > +		return PTR_ERR(ctx->iovcc);
> > +
> Consider to write an error message.
> The regulators are now mandatory, but they be missing in some device
> trees. So it would be good to help them to understand why it fails.

I've fixed this and your other comments in v2.
> 
> With this considered:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Thanks! I've not added this yet since I made two more changes:

- also print an error when regulator_enable() fails
- disable vcc if enabling iovcc fails afterwards

Hope this looks sane now.

Cheers,
 -- Guido

> 
> 	Sam
> 
