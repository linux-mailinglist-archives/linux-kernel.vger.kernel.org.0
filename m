Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E37511D225
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 17:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfLLQXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 11:23:05 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50189 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729813AbfLLQXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:23:05 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ifRF0-0005wC-P8; Thu, 12 Dec 2019 17:23:02 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1ifRF0-0007P2-6J; Thu, 12 Dec 2019 17:23:02 +0100
Date:   Thu, 12 Dec 2019 17:23:02 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6qdl: Enable egalax touch screen
Message-ID: <20191212162302.7i5zev3ksdkjk4ze@pengutronix.de>
References: <20191212160220.2265521-1-sjoerd.simons@collabora.co.uk>
 <20191212160722.wgqjeeknvm257hwi@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212160722.wgqjeeknvm257hwi@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:22:11 up 27 days,  7:40, 37 users,  load average: 0.01, 0.02,
 0.06
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-12-12 17:07, Marco Felsch wrote:
> Hi Sjoerd,
> 
> On 19-12-12 17:02, Sjoerd Simons wrote:
> > Sabrelite boards can have an lvds screen attached with a built-in i2c touch
> > screen. Enable this in the dtsi.
> 
> Can this be any screen available on the market?

At least you should adapt the title to: "ARM: dts: imx6qdl-sabrelite: ..."

Regards,
  Marco


> 
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > ---
> > 
> >  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> > index 8468216dae9b..382b127b2251 100644
> > --- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> > @@ -416,6 +416,14 @@ &i2c3 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&pinctrl_i2c3>;
> >  	status = "okay";
> > +
> > +	touchscreen@4 {
> > +		compatible = "eeti,egalax_ts";
> > +		reg = <0x04>;
> > +		interrupt-parent = <&gpio1>;
> > +		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
> > +		wakeup-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
> 
> The wakeup-gpio and the irq-line are sharing the same gpio line?
> 
> Regards,
>   Marco 
> 
> > +	};
> >  };
> >  
> >  &iomuxc {
> > -- 
> > 2.24.0
> > 
> > 
> > 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
