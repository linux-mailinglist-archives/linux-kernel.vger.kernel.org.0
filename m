Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 083ED141FF1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 21:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgASUSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jan 2020 15:18:14 -0500
Received: from gloria.sntech.de ([185.11.138.130]:45850 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728783AbgASUSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 15:18:14 -0500
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1itH0z-0002ec-GB; Sun, 19 Jan 2020 21:17:46 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dianders@chromium.org,
        andy.yan@rock-chips.com, robin.murphy@arm.com, mka@chromium.org,
        jagan@amarulasolutions.com, nick@khadas.com,
        kever.yang@rock-chips.com, m.reichl@fivetechno.de,
        aballier@gentoo.org, pbrobinson@gmail.com, vicencb@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add initial support for Pinebook Pro
Date:   Sun, 19 Jan 2020 21:17:39 +0100
Message-ID: <2816238.fSnfubHXRg@diego>
In-Reply-To: <20200116225617.6318-2-manu@freebsd.org>
References: <20200116225617.6318-1-manu@freebsd.org> <20200116225617.6318-2-manu@freebsd.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

overall looks good, but some small things below

Am Donnerstag, 16. Januar 2020, 23:56:17 CET schrieb Emmanuel Vadot:
> From: Peter Robinson <pbrobinson@gmail.com>
> 
> Pinebook Pro is a RK3399 based laptop produced by Pine64.
> 
> Add a basic DTS for it.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3399-pinebook-pro.dts | 626 ++++++++++++++++++
>  2 files changed, 627 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 48fb631d5451..9099fb7e2073 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -28,6 +28,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-m4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-neo4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-orangepi.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinebook-pro.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> new file mode 100644
> index 000000000000..d2e3d7b35cc6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> @@ -0,0 +1,626 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.

You might want to clarify the copyright ... 2020 and Pine64-something?

> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include "rk3399.dtsi"
> +#include "rk3399-opp.dtsi"
> +
> +/ {
> +	model = "Pine64 Pinebook Pro";
> +	compatible = "pine64,pinebook-pro", "rockchip,rk3399";
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	aliases {
> +		spi0 = &spi1;

why is this needed ... I'd think spi can just enumerate itself?

> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		enable-gpios = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
> +		pwms = <&pwm0 0 740740 0>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		autorepeat;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwrbtn>;
> +
> +		power {
> +			debounce-interval = <100>;
> +			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
> +			label = "GPIO Key Power";
> +			linux,code = <KEY_POWER>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	leds {
> +		status = "okay";

new board-specific nodes don't need a status property

> +		compatible = "gpio-leds";
> +
> +		work-led {
> +			label = "work";
> +			gpios = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		standby-led {
> +			label = "standby";
> +			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc1v8_s3";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_1v8>;
> +	};
> +
> +	dc_12v: dc-12v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "dc_12v";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	vcc3v3_sys: vcc3v3-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_sys>;
> +	};
> +
> +	vcc5v0_host: vcc5v0-host-regulator {
> +		compatible = "regulator-fixed";
> +		gpio = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&host_vbus_drv>;
> +		regulator-name = "vcc5v0_host";
> +	};
> +
> +	vcc5v0_usb3_host: vcc5v0-usb3-host-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&host_usb3_drv>;
> +		regulator-name = "vcc5v0_usb3_host";
> +		regulator-always-on;
> +	};
> +
> +	vcc3v3_s0: vcc3v3-s0-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio1 RK_PC6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&lcdvcc_en>;
> +		regulator-name = "vcc3v3_s0";
> +		regulator-always-on;
> +	};
> +
> +	vcc_sys: vcc-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dc_12v>;
> +	};
> +
> +	vdd_log: vdd-log {
> +		compatible = "pwm-regulator";
> +		pwms = <&pwm2 0 25000 1>;
> +		pwm-supply = <&vcc_sys>;
> +		regulator-name = "vdd_log";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-init-microvolt = <950000>;

There is no init-microvolt property in mainline, I'd think bootloader should
already setup the pwm to a suitable setting?

Not

> +		regulator-min-microvolt = <800000>;
> +		regulator-max-microvolt = <1400000>;
> +	};
> +};
> +
> +&cpu_l0 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_l1 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_l2 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_l3 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};

what happened to cpu_b0 and cpu_b1 supplies?
Should probably reference the cpu_b regulator below?

> +
> +&emmc_phy {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	clock-frequency = <400000>;
> +	i2c-scl-rising-time-ns = <168>;
> +	i2c-scl-falling-time-ns = <4>;
> +	status = "okay";

[...]

> +	vdd_cpu_b: regulator@40 {
> +		compatible = "silergy,syr827";
> +		reg = <0x40>;
> +		fcs,suspend-voltage-selector = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vsel1_gpio>;
> +		vsel-gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;

This is not yet specified in the syr82x (fan5355) bindings and
also unknown to the driver

> +		regulator-compatible = "fan53555-reg";
> +		regulator-name = "vdd_cpu_b";
> +		regulator-min-microvolt = <712500>;
> +		regulator-max-microvolt = <1500000>;
> +		regulator-ramp-delay = <1000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	vdd_gpu: regulator@41 {
> +		compatible = "silergy,syr828";
> +		reg = <0x41>;
> +		fcs,suspend-voltage-selector = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vsel2_gpio>;
> +		vsel-gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_HIGH>;

same

> +		regulator-compatible = "fan53555-reg";
> +		regulator-name = "vdd_gpu";
> +		regulator-min-microvolt = <712500>;
> +		regulator-max-microvolt = <1500000>;
> +		regulator-ramp-delay = <1000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +};

[...]

> +&saradc {
> +	status = "okay";

needs a vref-supply

> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	status = "okay";
> +	max-frequency = <20000000>;

vmmc / vqmmc supplies?
Especially if one wants to achieve higher speeds on uhs cards.

Heiko


