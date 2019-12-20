Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954CA127628
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 08:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfLTHF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 02:05:56 -0500
Received: from [167.172.186.51] ([167.172.186.51]:59442 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbfLTHF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:05:56 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0DF50DFCAD;
        Fri, 20 Dec 2019 07:05:58 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ec2LtoIMGUBq; Fri, 20 Dec 2019 07:05:57 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 64008DFCAE;
        Fri, 20 Dec 2019 07:05:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x5VQM8rDFpF5; Fri, 20 Dec 2019 07:05:57 +0000 (UTC)
Received: from nedofet.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id D7B33DFCAD;
        Fri, 20 Dec 2019 07:05:56 +0000 (UTC)
Message-ID: <186ca73e408654981e08f7f12ae543ba51debb68.camel@v3.sk>
Subject: Re: [PATCH 4/5] ARM: dts: mmp3: Add HSIC controllers
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        soc@kernel.org
Date:   Fri, 20 Dec 2019 08:05:50 +0100
In-Reply-To: <20191220065314.237624-5-lkundrak@v3.sk>
References: <20191220065314.237624-1-lkundrak@v3.sk>
         <20191220065314.237624-5-lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-12-20 at 07:53 +0100, Lubomir Rintel wrote:
> There are two on MMP3, along with the PHYs. The PHYs are made compatible
> with the NOP transceiver, since there's no driver for the time being and
> they're likely configured by the firmware.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  arch/arm/boot/dts/mmp3.dtsi | 44 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/mmp3.dtsi
> index d9762de0ed34b..36c50706e60e0 100644
> --- a/arch/arm/boot/dts/mmp3.dtsi
> +++ b/arch/arm/boot/dts/mmp3.dtsi
> @@ -201,6 +201,50 @@ usb_otg0: usb-otg@d4208000 {
>  				status = "disabled";
>  			};
>  
> +			hsic_phy0: hsic-phy@f0001800 {
> +				compatible = "marvell,mmp3-hsic-phy",
> +					     "usb-nop-xceiv",

I managed to mess this up right before sending it out.     ^^^
Sorry for that. There should be a semicolon there. I'll fix this up on
next patch spin.

> +				reg = <0xf0001800 0x40>;
> +				#phy-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			hsic0: hsic@f0001000 {
> +				compatible = "marvell,pxau2o-ehci";
> +				reg = <0xf0001000 0x200>;
> +				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&soc_clocks MMP2_CLK_USBHSIC0>;
> +				clock-names = "USBCLK";
> +				phys = <&hsic_phy0>;
> +				phy-names = "usb";
> +				phy_type = "hsic";
> +				#address-cells = <0x01>;
> +				#size-cells = <0x00>;
> +				status = "disabled";
> +			};
> +
> +			hsic_phy1: hsic-phy@f0002800 {
> +				compatible = "marvell,mmp3-hsic-phy",
> +					     "usb-nop-xceiv",
> +				reg = <0xf0002800 0x40>;
> +				#phy-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			hsic1: hsic@f0002000 {
> +				compatible = "marvell,pxau2o-ehci";
> +				reg = <0xf0002000 0x200>;
> +				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&soc_clocks MMP2_CLK_USBHSIC1>;
> +				clock-names = "USBCLK";
> +				phys = <&hsic_phy1>;
> +				phy-names = "usb";
> +				phy_type = "hsic";
> +				#address-cells = <0x01>;
> +				#size-cells = <0x00>;
> +				status = "disabled";
> +			};
> +
>  			mmc1: mmc@d4280000 {
>  				compatible = "mrvl,pxav3-mmc";
>  				reg = <0xd4280000 0x120>;

