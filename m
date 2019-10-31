Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4F8BEB58D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 17:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfJaQ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 12:57:45 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39638 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbfJaQ5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:57:45 -0400
Received: from dhcp-64-28.ens-lyon.fr ([140.77.64.28] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iQDlQ-0006YQ-Kx; Thu, 31 Oct 2019 17:57:36 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add PCIe node on rk3399-roc-pc
Date:   Thu, 31 Oct 2019 17:57:35 +0100
Message-ID: <1719506.vT9a8mQdzu@phil>
In-Reply-To: <09300c2d-4298-1b01-ac41-d1b2610589d4@fivetechno.de>
References: <09300c2d-4298-1b01-ac41-d1b2610589d4@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Montag, 28. Oktober 2019, 15:47:27 CET schrieb Markus Reichl:
> rk3399-roc-pc has a PCIe interface. Enable it for use with
> the M.2 NGFF M_KEY slot on roc-rk3399-mezzanine board.
> Tested with Samsung 970 evo plus SSD.
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> ---
>  .../arm64/boot/dts/rockchip/rk3399-roc-pc.dts | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> index 9313251765c7..2d637d54994b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> @@ -158,6 +158,21 @@
>  		regulator-max-microvolt = <1400000>;
>  		vin-supply = <&vcc_sys>;
>  	};
> +
> +	/* on roc-rk3399-mezzanine board */

I'm undecided on this. From what I've seen that mezzanine board is some
sort of addon, like a raspberry pi hat. Therefore it's not always present,
so probably should not be part of the base board dts.

I'm thinking a dt-overlay that can then be activated might be the solution
of choice, but I've reached out to arm-soc poeple on irc to determine the
correct course.


Heiko

> +	vcc3v3_pcie: vcc3v3-pcie {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_pcie";
> +		enable-active-high;
> +		gpio = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc3v3_pcie_en>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&dc_12v>;
> +	};
>  };
>  
>  &cpu_l0 {
> @@ -514,6 +529,19 @@
>  	status = "okay";
>  };
>  
> +&pcie_phy {
> +	status = "okay";
> +};
> +
> +&pcie0 {
> +	ep-gpios = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
> +	num-lanes = <4>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_perst>;
> +	vpcie3v3-supply = <&vcc3v3_pcie>;
> +	status = "okay";
> +};
> +
>  &pinctrl {
>  	lcd-panel {
>  		lcd_panel_reset: lcd-panel-reset {
> @@ -535,6 +563,16 @@
>  		};
>  	};
>  
> +	pcie {
> +		vcc3v3_pcie_en: vcc3v3-pcie-en {
> +			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie_perst: pcie-perst {
> +			rockchip,pins = <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
>  	pmic {
>  		vsel1_gpio: vsel1-gpio {
>  			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
> 




