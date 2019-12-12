Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD4E211D222
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 17:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfLLQWj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Dec 2019 11:22:39 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45036 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729744AbfLLQWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:22:39 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sjoerd)
        with ESMTPSA id A04012901B1
Received: by beast.luon.net (Postfix, from userid 1000)
        id 40B3A3E1F0D; Thu, 12 Dec 2019 17:22:35 +0100 (CET)
Message-ID: <e9c3d1d5f8b57d92e5823f74762a2de2b20f8e88.camel@collabora.co.uk>
Subject: Re: [PATCH] ARM: dts: imx6qdl: Enable egalax touch screen
From:   Sjoerd Simons <sjoerd.simons@collabora.co.uk>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Date:   Thu, 12 Dec 2019 17:22:35 +0100
In-Reply-To: <20191212160722.wgqjeeknvm257hwi@pengutronix.de>
References: <20191212160220.2265521-1-sjoerd.simons@collabora.co.uk>
         <20191212160722.wgqjeeknvm257hwi@pengutronix.de>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-12-12 at 17:07 +0100, Marco Felsch wrote:
> Hi Sjoerd,
> 
> On 19-12-12 17:02, Sjoerd Simons wrote:
> > Sabrelite boards can have an lvds screen attached with a built-in
> > i2c touch
> > screen. Enable this in the dtsi.
> 
> Can this be any screen available on the market?

I guess i should have been more clear here; This is the touchscreen in
the hannstar display (already part of the dts) that was sold as an
accessoiry to the sabrelite.

Same as the screen that can be used on the boundary nitrogen6 boards
(which do have the touch part already enabled in the dts)

> 
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > ---
> > 
> >  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> > b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
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
-- 
Sjoerd Simons
Collabora Ltd.
