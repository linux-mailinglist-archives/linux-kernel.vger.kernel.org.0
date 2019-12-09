Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBAB4116713
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 07:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfLIGoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 01:44:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:51440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfLIGoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:44:14 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B136C206E0;
        Mon,  9 Dec 2019 06:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575873853;
        bh=satcp7pvBEkmw0YjKfECaSFQJOr6tyXzvyx3YGw6ZHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DmNA/+/H631bjUIVQXGdULprDWxbrnAXnICRc5ZyYbq9W1cKvGzdbnY0XHmvHLZeJ
         UX2HeP56Vz3bcchoj3GyJaoyLG0Wy7neBtnFHkBukXMqA6MskNEevrBkx2woEKu1Su
         qCVkFVPhz2FMiafNBnuWo7fziZ0TsHn8KhCrznFw=
Date:   Mon, 9 Dec 2019 14:43:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 4/4] arm64: dts: freescale: add Kontron sl28 support
Message-ID: <20191209064356.GD3365@dragon>
References: <20191123201317.25861-1-michael@walle.cc>
 <20191123201317.25861-5-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191123201317.25861-5-michael@walle.cc>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 09:13:17PM +0100, Michael Walle wrote:
> Add device tree files for the Kontron SMARC-sAL28 board and its
> carriers.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   4 +
>  .../fsl-ls1028a-kontron-kbox-a-230-ls.dts     |  27 +++
>  .../fsl-ls1028a-kontron-sl28-var3-ads2.dts    |  73 ++++++++
>  .../fsl-ls1028a-kontron-sl28-var4.dts         |  34 ++++
>  .../freescale/fsl-ls1028a-kontron-sl28.dts    | 158 ++++++++++++++++++
>  5 files changed, 296 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 93fce8f0c66d..080c5a59d6bd 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -4,6 +4,10 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frwy.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-oxalis.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-kbox-a-230-ls.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var3-ads2.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var4.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-qds.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
> new file mode 100644
> index 000000000000..97e72c94b7fc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Device Tree File for the Kontron KBox A-230-LS.
> + *
> + * This consists of a Kontron SMARC-sAL28 (Dual PHY) and a special
> + * carrier (s1914).
> + *
> + * Copyright (C) 2019 Michael Walle <michael@walle.cc>
> + *
> + */
> +
> +/dts-v1/;
> +#include "fsl-ls1028a-kontron-sl28-var4.dts"
> +
> +/ {
> +	model = "Kontron KBox A-230-LS";
> +	compatible = "kontron,kbox-a-230-ls", "kontron,sl28-var3",
> +		     "kontron,sl28", "fsl,ls1028a";

Any new compatible needs to be documented.

> +};
> +
> +&i2c4 {
> +	eeprom@50 {
> +		compatible = "atmel,24c32";
> +		reg = <0x50>;
> +		pagesize = <32>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
> new file mode 100644
> index 000000000000..a4640e6b3928
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Device Tree file for the Kontron SMARC-sAL28 board on a SMARC Eval 2.0
> + * carrier (ADS2).
> + *
> + * Copyright (C) 2019 Michael Walle <michael@walle.cc>
> + *
> + */
> +
> +/dts-v1/;
> +#include "fsl-ls1028a-kontron-sl28.dts"
> +
> +/ {
> +	model = "Kontron SMARC-sAL28 (Single PHY) on SMARC Eval 2.0 carrier";
> +	compatible = "kontron,sl28-var3-ads2", "kontron,sl28", "fsl,ls1028a";
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,widgets =
> +			"Headphone", "Headphone Jack",
> +			"Line", "Line Out Jack";
> +		simple-audio-card,routing =
> +			"Line Out Jack", "LINEOUTR",
> +			"Line Out Jack", "LINEOUTL",
> +			"Headphone Jack", "HPOUTR",
> +			"Headphone Jack", "HPOUTL";
> +		simple-audio-card,mclk-fs = <256>;
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&sai6>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&wm8904>;
> +			frame-master;
> +			bitclock-master;
> +		};
> +	};
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +
> +	wm8904: wm8904@1a {

audio-codec for node name.

> +		#sound-dai-cells = <0>;
> +		compatible = "wlf,wm8904";
> +		reg = <0x1a>;
> +		clocks = <&wm8904_mclk>;
> +		clock-names = "mclk";
> +		assigned-clocks = <&wm8904_mclk>;
> +		assigned-clock-rates = <1250000>;
> +	};
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c32";
> +		reg = <0x50>;
> +		pagesize = <32>;
> +	};
> +};
> +
> +&sai6 {
> +	status = "okay";
> +};
> +
> +&soc {
> +	wm8904_mclk: wm8904-mclk@f130080 {
> +		compatible = "fsl,vf610-sai-clock";

Unsupported/undocumented binding?

> +		reg = <0x0 0xf130080 0x0 0x80>;
> +		clocks = <&clockgen 4 1>;
> +		#clock-cells = <0>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
> new file mode 100644
> index 000000000000..5c8b13108e4d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Device Tree file for the Kontron SMARC-sAL28 board.
> + *
> + * This is for the network variant 4 which has two ethernet ports. It
> + * extends the base and provides one more port connected via RGMII.
> + *
> + * Copyright (C) 2019 Michael Walle <michael@walle.cc>
> + *
> + */
> +
> +/dts-v1/;
> +#include "fsl-ls1028a-kontron-sl28.dts"
> +
> +/ {
> +	model = "Kontron SMARC-sAL28 (Dual PHY)";
> +	compatible = "kontron,sl28-var4", "kontron,sl28", "fsl,ls1028a";
> +};
> +
> +&enetc_port1 {
> +	phy-handle = <&phy1>;
> +	phy-connection-type = "rgmii-id";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		phy1: ethernet-phy@4 {
> +			reg = <0x4>;
> +			eee-broken-1000t;
> +			eee-broken-100tx;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> new file mode 100644
> index 000000000000..a18cb4395ad0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Device Tree file for the Kontron SMARC-sAL28 board.
> + *
> + * Copyright (C) 2019 Michael Walle <michael@walle.cc>
> + *
> + */
> +
> +/dts-v1/;
> +#include "fsl-ls1028a.dtsi"
> +
> +/ {
> +	model = "Kontron SMARC-sAL28";
> +	compatible = "kontron,sl28", "fsl,ls1028a";
> +
> +	aliases {
> +		crypto = &crypto;
> +		serial0 = &duart0;
> +		serial1 = &duart1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&duart0 {
> +	status = "okay";
> +};
> +
> +&duart1 {
> +	status = "okay";
> +};
> +
> +&enetc_port0 {
> +	phy-handle = <&phy0>;
> +	phy-connection-type = "sgmii";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		phy0: ethernet-phy@5 {
> +			reg = <0x5>;
> +			eee-broken-1000t;
> +			eee-broken-100tx;
> +		};
> +	};
> +};
> +
> +&esdhc {
> +	sd-uhs-sdr104;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr12;
> +	status = "okay";
> +};
> +
> +&esdhc1 {
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	bus-width = <8>;
> +	status = "okay";
> +};
> +
> +&fspi {
> +	status = "okay";
> +
> +	w25q32jw@0 {

Use a generic node name.

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "w25q32jw", "jedec,spi-nor";

Is "w25q32jw" documented somewhere?

Shawn

> +		m25p,fast-read;
> +		spi-max-frequency = <133000000>;
> +		reg = <0>;
> +		/* The following setting enables 1-1-2 (CMD-ADDR-DATA) mode */
> +		spi-rx-bus-width = <2>; /* 2 SPI Rx lines */
> +		spi-tx-bus-width = <1>; /* 1 SPI Tx line */
> +
> +		partition@0 {
> +			reg = <0x000000 0x010000>;
> +			label = "rcw";
> +			read-only;
> +		};
> +
> +		partition@10000 {
> +			reg = <0x010000 0x0f0000>;
> +			label = "failsafe bootloader";
> +			read-only;
> +		};
> +
> +		partition@100000 {
> +			reg = <0x100000 0x040000>;
> +			label = "failsafe DP firmware";
> +			read-only;
> +		};
> +
> +		partition@140000 {
> +			reg = <0x140000 0x0a0000>;
> +			label = "failsafe trusted firmware";
> +			read-only;
> +		};
> +
> +		partition@1e0000 {
> +			reg = <0x1e0000 0x020000>;
> +			label = "reserved";
> +			read-only;
> +		};
> +
> +		partition@200000 {
> +			reg = <0x200000 0x010000>;
> +			label = "configuration store";
> +		};
> +
> +		partition@210000 {
> +			reg = <0x210000 0x0f0000>;
> +			label = "bootloader";
> +		};
> +
> +		partition@300000 {
> +			reg = <0x300000 0x040000>;
> +			label = "DP firmware";
> +		};
> +
> +		partition@340000 {
> +			reg = <0x340000 0x0a0000>;
> +			label = "trusted firmware";
> +		};
> +
> +		partition@3e0000 {
> +			reg = <0x3e0000 0x020000>;
> +			label = "bootloader environment";
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	rtc@32 {
> +		compatible = "microcrystal,rv8803";
> +		reg = <0x32>;
> +	};
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c32";
> +		reg = <0x50>;
> +		pagesize = <32>;
> +	};
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +};
> -- 
> 2.20.1
> 
