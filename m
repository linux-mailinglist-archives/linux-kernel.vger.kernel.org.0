Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B213B1776
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 05:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfIMDb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 23:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfIMDb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 23:31:56 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B7E62084D;
        Fri, 13 Sep 2019 03:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568345515;
        bh=xe/JQYqK2joRWmcoEKC69faO00pRfkUSxLsZFzljHx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oOgasMqDODc+/kPGQTMrlSa8enwJYrsd2Ov9O9jP0QnVdULOh56TqcyOuZ8hTfVaV
         Uzjj1aeO59WeNJtEkBmwa9FzGw8T8qXW1sSlEHtScKu8WvdSpwfYfag2sgnjk9lcOI
         io9N4+DGPlePxXUyAFnEvjFHLvdCBC0pRusMovM8=
Date:   Fri, 13 Sep 2019 11:31:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Draszik <git@andred.net>
Cc:     linux-kernel@vger.kernel.org, Ilya Ledvich <ilya@compulab.co.il>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/12] ARM: dts: imx7d: cl-som-imx7 imx7d-sbc-imx7: move
 USB
Message-ID: <20190913033145.GG17142@dragon>
References: <20190826153800.35400-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190826153800.35400-1-git@andred.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 04:37:49PM +0100, André Draszik wrote:
> Whether and which USB port is enabled and how they
> are powered is a function of the carrier board, not
> of the SoM. Different carrier boards can have different
> ports enabled / wired up, and power them differently;
> so this should really move into the respective DTS.
> 
> Do so and update the USB power supply to reflect
> the actual situation on the sbc-imx7 carrier board.
> 
> Signed-off-by: André Draszik <git@andred.net>
> Cc: Ilya Ledvich <ilya@compulab.co.il>
> Cc: Igor Grinberg <grinberg@compulab.co.il>

Ilya, Igor, can you have a look at the series?

Shawn

> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 24 ------------------------
>  arch/arm/boot/dts/imx7d-sbc-imx7.dts    | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
> index 62d5e9a4a781..6f7e85cf0c28 100644
> --- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
> +++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
> @@ -22,15 +22,6 @@
>  		device_type = "memory";
>  		reg = <0x80000000 0x10000000>; /* 256 MB - minimal configuration */
>  	};
> -
> -	reg_usb_otg1_vbus: regulator-vbus {
> -		compatible = "regulator-fixed";
> -		regulator-name = "usb_otg1_vbus";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -	};
>  };
>  
>  &cpu0 {
> @@ -193,13 +184,6 @@
>  	status = "okay";
>  };
>  
> -&usbotg1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_usbotg1>;
> -	vbus-supply = <&reg_usb_otg1_vbus>;
> -	status = "okay";
> -};
> -
>  &usdhc3 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usdhc3>;
> @@ -278,11 +262,3 @@
>  		>;
>  	};
>  };
> -
> -&iomuxc_lpsr {
> -	pinctrl_usbotg1: usbotg1grp {
> -		fsl,pins = <
> -			MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x14 /* OTG PWREN */
> -		>;
> -	};
> -};
> diff --git a/arch/arm/boot/dts/imx7d-sbc-imx7.dts b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
> index f8a868552707..aab646903de3 100644
> --- a/arch/arm/boot/dts/imx7d-sbc-imx7.dts
> +++ b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
> @@ -15,6 +15,14 @@
>  / {
>  	model = "CompuLab SBC-iMX7";
>  	compatible = "compulab,sbc-imx7", "compulab,cl-som-imx7", "fsl,imx7d";
> +
> +	reg_usb_vbus: regulator-usb-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
>  };
>  
>  &usdhc1 {
> @@ -26,6 +34,11 @@
>  	status = "okay";
>  };
>  
> +&&usbotg1 {
> +	vbus-supply = <&reg_usb_vbus>;
> +	status = "okay";
> +};
> +
>  &iomuxc {
>  	pinctrl_usdhc1: usdhc1grp {
>  		fsl,pins = <
> -- 
> 2.23.0.rc1
> 
