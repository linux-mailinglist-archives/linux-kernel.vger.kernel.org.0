Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B20710D212
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 08:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfK2Huc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 02:50:32 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51741 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfK2Huc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 02:50:32 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iab2s-0003x1-FL; Fri, 29 Nov 2019 08:50:30 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iab2r-0002eU-Fz; Fri, 29 Nov 2019 08:50:29 +0100
Date:   Fri, 29 Nov 2019 08:50:29 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        kernel@pengutronix.de, Adam.Thomson.Opensource@diasemi.com,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/5] gpio: add support to get local gpio number
Message-ID: <20191129075029.gs42pdwehjarem6y@pengutronix.de>
References: <20191127135932.7223-1-m.felsch@pengutronix.de>
 <20191127135932.7223-2-m.felsch@pengutronix.de>
 <CAMpxmJXzBphmW7SWD05wtLjSAR7VBzVAgnYJYd3Sd49Bp6AmgQ@mail.gmail.com>
 <20191128124942.4ddyi5eeclvxmqbg@pengutronix.de>
 <20191129074524.dipo37u6lv7vzfhc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191129074524.dipo37u6lv7vzfhc@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:49:56 up 13 days, 23:08, 28 users,  load average: 0.00, 0.04,
 0.02
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-29 08:45, Uwe Kleine-König wrote:
> On Thu, Nov 28, 2019 at 01:49:42PM +0100, Marco Felsch wrote:
> > On 19-11-28 11:46, Bartosz Golaszewski wrote:
> > > śr., 27 lis 2019 o 14:59 Marco Felsch <m.felsch@pengutronix.de> napisał(a):
> > > >
> > > > Sometimes consumers needs to know the gpio-chip local gpio number of a
> > > > 'struct gpio_desc' for further configuration. This is often the case for
> > > > mfd devices.
> > > >
> > > 
> > > We already have this support. It's just a matter of exporting it, so
> > > maybe adjust the commit message to not be confusing.
> > 
> > Therefore I mentioned the consumers.
> > 
> > > That being said: I'm not really a fan of this - the whole idea of gpio
> > > descriptors was to make them opaque and their hardware offsets
> > > irrelevant. :(
> > 
> > I know therefore I added a driver local helper but this wasn't the way
> > Linus wanted to go..
> > 
> > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > ---
> > > >  drivers/gpio/gpiolib.c        |  6 ++++++
> > > >  include/linux/gpio/consumer.h | 10 ++++++++++
> > > >  2 files changed, 16 insertions(+)
> > > >
> > > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > > index 104ed299d5ea..7709648313fc 100644
> > > > --- a/drivers/gpio/gpiolib.c
> > > > +++ b/drivers/gpio/gpiolib.c
> > > > @@ -4377,6 +4377,12 @@ int gpiod_count(struct device *dev, const char *con_id)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(gpiod_count);
> > > >
> > > > +int gpiod_to_offset(struct gpio_desc *desc)
> > > 
> > > Maybe call it: gpiod_desc_to_offset()?
> > 
> > The function name is proposed by Linus too so Linus what's your
> > oppinion?
> 
> INAL (I'm not a Linus) but I wonder what the 'd' in gpiod stands for.
> Assuming it already meand "desc" I'd prefer gpiod_to_offset.

Yes, that was my assumption too.

Regards,
  Marco

> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
