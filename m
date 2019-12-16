Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B788E1206AD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 14:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfLPNKm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Dec 2019 08:10:42 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55449 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfLPNKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:10:42 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1ADC860011;
        Mon, 16 Dec 2019 13:10:37 +0000 (UTC)
Date:   Mon, 16 Dec 2019 14:10:36 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] drm/panel: simple: Support reset GPIOs
Message-ID: <20191216141036.24c22899@xps13>
In-Reply-To: <20191216130615.qs6ub7bwqofwvhr7@gilmour.lan>
References: <20191213181325.26228-1-miquel.raynal@bootlin.com>
        <20191216130615.qs6ub7bwqofwvhr7@gilmour.lan>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Maxime Ripard <maxime@cerno.tech> wrote on Mon, 16 Dec 2019 14:06:15
+0100:

> Hi,
> 
> On Fri, Dec 13, 2019 at 07:13:25PM +0100, Miquel Raynal wrote:
> > The panel common bindings provide a gpios-reset property which is
> > active low by default. Let's support it in the simple driver.
> >
> > De-asserting the reset pin implies a physical high, which in turns is
> > a logic low.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> 
> The GPIOd API asks for a logical state, so it doesn't really matter
> what the polarity of the GPIO, OUT_LOW will always mean that the reset
> is deasserted (and thus, it will work even if the reset pin is active
> high).
> 
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index 5d487686d25c..15dd495c347d 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -110,6 +110,7 @@ struct panel_simple {
> >  	struct i2c_adapter *ddc;
> >
> >  	struct gpio_desc *enable_gpio;
> > +	struct gpio_desc *reset_gpio;
> >
> >  	struct drm_display_mode override_mode;
> >  };
> > @@ -433,12 +434,21 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
> >  	if (IS_ERR(panel->supply))
> >  		return PTR_ERR(panel->supply);
> >
> > +	panel->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> > +						    GPIOD_OUT_LOW);
> > +	if (IS_ERR(panel->reset_gpio)) {
> > +		err = PTR_ERR(panel->reset_gpio);
> > +		if (err != -EPROBE_DEFER)
> > +			dev_err(dev, "failed to request reset pin: %d\n", err);
> > +		return err;
> > +	}
> > +  
> 
> However, I'm wondering if it wouldn't be better to just have the
> device maintained in reset at probe (so OUT_HIGH) and moved out of
> reset during either the prepare or enable callbacks.
> 
> This is pretty much what is happening with the enable-gpios already.
> 
> Also, panels usually need to wait for a minimum time after you
> deassert the reset line. How is that dealt with?
> 
> I guess a good way to do that would be to add that duration to the
> panel description, since this is pretty much device specific.

What about the case were your Bootloader displays something and you
don't want the panel to blink ?

Right now I am just forcing the reset to be deasserted.

Thanks,
Miquèl
