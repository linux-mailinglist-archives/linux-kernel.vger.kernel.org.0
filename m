Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D61BBF203
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 13:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfIZLoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 07:44:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43867 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfIZLoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 07:44:04 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iDSBf-0001Os-K8; Thu, 26 Sep 2019 13:43:55 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iDSBe-0005y7-FA; Thu, 26 Sep 2019 13:43:54 +0200
Date:   Thu, 26 Sep 2019 13:43:54 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Support Opensource <Support.Opensource@diasemi.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
Message-ID: <20190926114354.qvv2rs7mc4xh6lkp@pengutronix.de>
References: <20190917124246.11732-1-m.felsch@pengutronix.de>
 <20190917124246.11732-3-m.felsch@pengutronix.de>
 <AM5PR1001MB0994ABEF9C32BFB7BEA099B680840@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20190925155151.75uaxfiiei3i23tz@pengutronix.de>
 <AM5PR1001MB09941810C3AE97110DD82E0F80870@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20190926080956.a3k2z4gf3n6m3n4s@pengutronix.de>
 <AM5PR1001MB09944C0F9A4F547BF9E175CF80860@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR1001MB09944C0F9A4F547BF9E175CF80860@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:32:59 up 131 days, 17:51, 85 users,  load average: 0.13, 0.10,
 0.04
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-09-26 10:17, Adam Thomson wrote:
> On 26 September 2019 09:10, Marco Felsch wrote:
> 
> > On 19-09-25 16:18, Adam Thomson wrote:
> > > On 25 September 2019 16:52, Marco Felsch wrote:
> > >
> > > > Hi Adam,
> > > >
> > > > On 19-09-24 09:23, Adam Thomson wrote:
> > > > > On 17 September 2019 13:43, Marco Felsch wrote:
> > > > >
> > > > > > Add the documentation which describe the voltage selection gpio
> > support.
> > > > > > This property can be applied to each subnode within the 'regulators'
> > > > > > node so each regulator can be configured differently.
> > > > > >
> > > > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/mfd/da9062.txt | 9 +++++++++
> > > > > >  1 file changed, 9 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > > b/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > > index edca653a5777..9d9820d8177d 100644
> > > > > > --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > > +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> > > > > > @@ -66,6 +66,15 @@ Sub-nodes:
> > > > > >    details of individual regulator device can be found in:
> > > > > >    Documentation/devicetree/bindings/regulator/regulator.txt
> > > > > >
> > > > > > +  Optional regulator device-specific properties:
> > > > > > +  - dlg,vsel-sense-gpios : The GPIO reference which should be used by
> > the
> > > > > > +    regulator to switch the voltage between active/suspend voltage
> > settings.
> > > > If
> > > > > > +    the signal is active the active-settings are applied else the suspend
> > > > > > +    settings are applied. Attention: Sharing the same gpio for other
> > purposes
> > > > > > +    or across multiple regulators is possible but the gpio settings must be
> > the
> > > > > > +    same. Also the gpio phandle must refer to to the dlg,da9062-gpio
> > device
> > > > > > +    other gpios are not allowed and make no sense.
> > > > > > +
> > > > >
> > > > > Should we not use the binding names that are defined in 'gpio-
> > regulator.yaml'
> > > > as
> > > > > these seem to be generic and would probably serve the purpose here?
> > > >
> > > > Hm.. as the description says:
> > > >
> > > > 8<--------------------------------------------------
> > > > gpios:
> > > >    description: Array of one or more GPIO pins used to select the
> > > >    regulator voltage/current listed in "states".
> > > > 8<--------------------------------------------------
> > > >
> > > > But we don't have a "states" property and we can't select between
> > > > voltage or current.
> > >
> > > Yes I think I was at cross purposes when I made this remark. The bindings there
> > > describe the GPOs that are used to enable/disable and set voltage/current for
> > > regulators and the supported voltage/current levels that can be configured in
> > > this manner. What you're describing is the GPI for DA9061/2. If you look at
> > > GPIO handling in existing regulator drivers I believe they all deal with external
> > > GPOs that are configured to enable/disable and set voltage/current limits
> > rather
> > > than the GPI on the PMIC itself. That's why I'm thinking that the configurations
> > > you're doing here should actually be in a pinctrl or GPIO driver.
> > 
> > That's true, the common gpio bindings are from the view of the
> > processor, e.g. which gpio must the processor drive to enable/switch the
> > regualtor. So one reasone more to use a non-common binding.
> > 
> > Please take a look on my other comment I made :) I don't use the
> > gpio-alternative function. I use it as an input.
> 
> I know in the datasheet this isn't marked as an alternate function specifically
> but to me having regulator control by the chip's own GPI is an alternative
> function for that GPIO pin, in the same way a specific pin can be used for
> SYS_EN or Watchdog control. It's a dedicated purpose rather than being a normal
> GPI.

Nope, SYS_EN or Watchdog is a special/alternate function and not a
normal input.

> See the following as an example of what I'm suggesting:
> 
> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt
> 
> You could then pass the pinctrl information to the regulator driver and use
> that rather than having device specific bindings for this. That's at least my
> current interpretation of this anyway.

For me pinctrl decides which function should be assigned to a pin. So in
our case this would be:
  - alternate
  - gpo
  - gpi

In our use-case it is a gpi..

An other reason why pinctrl seems not be the right solution is that the
regulator must be configured to use this gpi. This decision can't be
made globally because each regulator can be configured differently.. For
me its just a local gpio.

Regards,
  Marco

> > 
> > Regards,
> >   Marco
> > 
> > 
> > > I'd be interested in hearing Mark's view on this though as he has far more
> > > experience in this area than I do.
> > >
> > > >
> > > > Regards,
> > > >   Marco
> > > >
> > > > > >  - rtc : This node defines settings required for the Real-Time Clock
> > associated
> > > > > >    with the DA9062. There are currently no entries in this binding, however
> > > > > >    compatible = "dlg,da9062-rtc" should be added if a node is created.
> > > > > > --
> > > > > > 2.20.1
> > > > >
> > > > >
> > > >
> > > > --
> > > > Pengutronix e.K.                           |                             |
> > > > Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> > > > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> > > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> > >
> > 
> > --
> > Pengutronix e.K.                           |                             |
> > Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
