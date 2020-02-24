Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD8616AC69
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 17:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgBXQ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 11:58:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36894 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgBXQ61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:58:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id a6so52061wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 08:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brixit-nl.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qtL/A0NxvdmVrbp5VWhXe/4VC/boWsW7Z2GIwfkPEJ8=;
        b=h156OzvfhxrD2vJ0bBbrChXHEA+eozI/EjjG90aPwwine90jeYBKeXqVsNdBD+CsQG
         b0LIBTIDGuy/trF4XBUQM4ttgWjSb2KqxtIxzsVjBEAQHT6qqUb9Fze7VZQqtwncP9MU
         aaPF90UtgXuotqakbgK4LAZXq7HSZR6fVwpaDZcU/sOM4VCE1SX+RsPkY1RmXw6YjqmD
         fAUF8pYfzAPLjcrKbihz+bXx/oESOO7k3sL2pJwJcKXgwx7dsIyx07Utlruo9vmy+I4q
         qBjlEXn1lNuGwDL/wkf8VTfyj1EpFcIUy5tZQtDPIlbnFo9Q+F95OafnwqO0jGrrc4HD
         crUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qtL/A0NxvdmVrbp5VWhXe/4VC/boWsW7Z2GIwfkPEJ8=;
        b=g7m7qlO0gz5+Jmo9i2bJauPSfijDYfFs6xLtj5dLqlw1+LdYCp7Jbl5ebwH2y2dVGv
         s16O5Up9py4WXBHaMlI7DbbwtCwigNWEbvLKWSfttWDhkCZ44mEpmkbi29oBP1MPFyjI
         DAQVEK9K9EunKOzDZmlsLXGYcrvYsqUCnaIfdTjF9jSgEOfrcuFriOw/Q+Q+UO1h3Bvb
         raZNgtxHuQLUPGp4MFPZDJ0BLBU8R6TKygnsINlttvyB2za0xZbsCdRfx3h6FarhLKc0
         KYVwL0yldDHWOCc+OkaMA1/57tOQivzpBOgO9eOggK637XmQ+E/GTc/ri8geB6CSf4kI
         jQvw==
X-Gm-Message-State: APjAAAWXsnupgbMhD3kByR3z1Qr7iarENj8RSsRxSFslU9v97t3pHmKu
        XFpxgEfP0bU7rAXflhe44nBtMsfxgGibtw==
X-Google-Smtp-Source: APXvYqxFjB6KX5pBSxYCOM2KXZtEVnjCOi1pN58quBTw2E5vBr5+t5+Eihp/taAfsR0sG28beZYQYg==
X-Received: by 2002:a1c:b457:: with SMTP id d84mr2551wmf.172.1582563502682;
        Mon, 24 Feb 2020 08:58:22 -0800 (PST)
Received: from [192.168.2.43] ([185.54.207.135])
        by smtp.gmail.com with ESMTPSA id h18sm20112446wrv.78.2020.02.24.08.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 08:58:22 -0800 (PST)
Subject: Re: [PATCH 3/3] arm64: dts: allwinner: Add initial support for Pine64
 PinePhone
To:     Maxime Ripard <maxime@cerno.tech>, linux-sunxi@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Samuel Holland <samuel@sholland.org>,
        Luca Weiss <luca@z3ntu.xyz>, Bhushan Shah <bshah@kde.org>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200223172916.843379-1-megous@megous.com>
 <20200223172916.843379-4-megous@megous.com>
 <20200224110027.ry3v7ms76hwbdn22@gilmour.lan>
 <20200224125652.pd666ltpvdjctvsd@core.my.home>
From:   Martijn Braam <martijn@brixit.nl>
Message-ID: <6d29ec53-9ebd-49d6-8b33-d722de5f03f1@brixit.nl>
Date:   Mon, 24 Feb 2020 17:58:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224125652.pd666ltpvdjctvsd@core.my.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-02-24 13:56, Ondřej Jirman wrote:
> Hello Maxime,
> 
> On Mon, Feb 24, 2020 at 12:00:27PM +0100, Maxime Ripard wrote:
>> Hi,
>>
>> On Sun, Feb 23, 2020 at 06:29:16PM +0100, Ondrej Jirman wrote:
>>> At them moment PinePhone comes in two slightly incompatible variants:
>>>
>>> - 1.0: Early Developer Batch
>>> - 1.1: Braveheart Batch
>>>
>>> There will be at least one more incompatible variant in the very near
>>> future, so let's start by sharing the dtsi among multiple variants,
>>> right away, even though the HW description doesn't yet include the
>>> different bits.
>>>
>>> This is a basic DT that includes only features that are already
>>> supported by mainline drivers.
>>
>> What are those incompatibilities? It's not really obvious from your
>> patch.
> 
> The changes are listed here:
> 
> https://wiki.pine64.org/index.php/PinePhone_v1.1_-_Braveheart#Changes_from_1.0
> 
> Substantial ones are:
> 
> 2. Swap PC3 to FLASH_EN and PD24 to FLASH_TRIGOUT, where previously they were reversed
> 5. Set the EG25G's PWRKEY on by default (see resistor R1526)
> 6. Add R630 resistor location, populate with 0K by default. Allows adjusting to
>    different battery thermistors in case this is not possible in software.
> 
> The incompatiblilities between 1.1 and 1.2 will be more extensive:
> 
> https://wiki.pine64.org/index.php/PinePhone/Power_Management#Suggested_GPIO_Hardware_Changes
> 
>>> Co-developed-by: Samuel Holland <samuel@sholland.org>
>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>> Co-developed-by: Martijn Braam <martijn@brixit.nl>
>>> Signed-off-by: Martijn Braam <martijn@brixit.nl>
>>> Co-developed-by: Luca Weiss <luca@z3ntu.xyz>
>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>> Signed-off-by: Bhushan Shah <bshah@kde.org>
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> Signed-off-by: Ondrej Jirman <megous@megous.com>
>>> ---
>>>  arch/arm64/boot/dts/allwinner/Makefile        |   2 +
>>>  .../allwinner/sun50i-a64-pinephone-1.0.dts    |  11 +
>>>  .../allwinner/sun50i-a64-pinephone-1.1.dts    |  11 +
>>>  .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 385 ++++++++++++++++++
>>>  4 files changed, 409 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
>>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
>>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
>>> index cf4f78617c3f3..79ca263672c38 100644
>>> --- a/arch/arm64/boot/dts/allwinner/Makefile
>>> +++ b/arch/arm64/boot/dts/allwinner/Makefile
>>> @@ -9,6 +9,8 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-lts.dtb
>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinebook.dtb
>>> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinephone-1.0.dtb
>>> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinephone-1.1.dtb
>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-bananapi-m2-plus.dtb
>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
>>> new file mode 100644
>>> index 0000000000000..0c42272106afa
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
>>> @@ -0,0 +1,11 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +// Copyright (C) 2020 Ondrej Jirman <megous@megous.com>
>>
>> Given the list of authors, surely you're not the sole copyright owner
>> here?
> 
> Yes, I made this and the 1.1 dts file by myself. It's not really a meaningful
> contribution, since at the moment it's basically empty. I suppose to have
> a license, the file requires some author.
> 
> Collaborative work is mostly in the dtsi.
> 
>>> +/dts-v1/;
>>> +
>>> +#include "sun50i-a64-pinephone.dtsi"
>>> +
>>> +/ {
>>> +	model = "Pine64 PinePhone Developer Batch (1.0)";
>>> +	compatible = "pine64,pinephone-1.0", "allwinner,sun50i-a64";
>>> +};
>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
>>> new file mode 100644
>>> index 0000000000000..06a775c41664b
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
>>> @@ -0,0 +1,11 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +// Copyright (C) 2020 Ondrej Jirman <megous@megous.com>
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "sun50i-a64-pinephone.dtsi"
>>> +
>>> +/ {
>>> +	model = "Pine64 PinePhone Braveheart (1.1)";
>>> +	compatible = "pine64,pinephone-1.1", "allwinner,sun50i-a64";
>>> +};
>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>>> new file mode 100644
>>> index 0000000000000..d0cf21d82c9e9
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>>> @@ -0,0 +1,385 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +// Copyright (C) 2019 Icenowy Zheng <icenowy@aosc.xyz>
>>> +// Copyright (C) 2020 Ondrej Jirman <megous@megous.com>
> 
> For the record. Originally I took this file from:
> 
> https://gitlab.com/pine64-org/linux/commits/pine64-kernel-5.4.y
> https://gitlab.com/pine64-org/linux/-/blob/pine64-kernel-5.4.y/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dts
> 
> about a month ago, and kept working on it in my trees for 5.5 and 5.6:
> 
> https://megous.com/git/linux/log/?h=pp-5.5
> https://megous.com/git/linux/log/?h=pp-5.6
> 
> Adding support for using multiple cameras, bugfixing, and integrating work from
> others, and now doing the legwork to strip the more complete DTS and make it
> into a mainlainable state, so that collaboration can continue in the mainline
> tree.
> 
> AFAIK, at this point (after stripdown), most of the work comes from Icenowy.
> With some people contributing "smaller" things. I say "smaller" in quotes, since
> I know that there can be a weekend of debugging behind changing a 2-3 lines, and
> don't want to minimize anyone's contribution.
> 
> IANAL and I don't know what's entirely apropriate to do here. I've disucssed
> this briefly on the IRC with involved people (that are also CCed in this
> series), and there was a suggestion to adding a bunch of Cob/SoB tags, based on
> some even older DTS file for dontbeevil (developer kit for PinePhone), that the
> Icenowy's file was based on. So I did.
> 
> The more copyright holders the better, I guess. :) So if CCed people want to
> be added here, and made the contribution to the present file, please state
> so for the record again here on the mailing list, and I'll add you to the
> header, or anywhere you wish.
> 
Yes please :), I have at least some i2c sensor nodes in this file,
probably also a bunch of other minor changes but it's pretty hard to
track through the history of the various files and branches.

>>> +#include "sun50i-a64.dtsi"
>>> +#include "sun50i-a64-cpu-opp.dtsi"
>>> +
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/input/input.h>
>>> +#include <dt-bindings/leds/common.h>
>>> +#include <dt-bindings/pwm/pwm.h>
>>> +
>>> +/ {
>>> +	aliases {
>>> +		serial0 = &uart0;
>>> +	};
>>> +
>>> +	chosen {
>>> +		stdout-path = "serial0:115200n8";
>>> +	};
>>> +
>>> +	leds {
>>> +		compatible = "gpio-leds";
>>> +
>>> +		blue {
>>> +			function = LED_FUNCTION_INDICATOR;
>>> +			function-enumerator = <1>;
>>> +			color = <LED_COLOR_ID_BLUE>;
>>> +			gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
>>> +		};
>>> +
>>> +		green {
>>> +			function = LED_FUNCTION_INDICATOR;
>>> +			function-enumerator = <2>;
>>> +			color = <LED_COLOR_ID_GREEN>;
>>> +			gpios = <&pio 3 18 GPIO_ACTIVE_HIGH>; /* PD18 */
>>> +		};
>>> +
>>> +		red {
>>> +			function = LED_FUNCTION_INDICATOR;
>>> +			function-enumerator = <3>;
>>> +			color = <LED_COLOR_ID_RED>;
>>> +			gpios = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
>>> +		};
>>> +	};
>>
>> LEDs should be named using the $color:$board:$usage pattern
> 
> Do you mean using a label? It seems label is deprecated, and bindings should
> start using function/function-enumerator/color properties now:
> 
> https://elixir.bootlin.com/linux/v5.6-rc2/source/Documentation/devicetree/bindings/leds/common.yaml#L57
> 
> It doesn't look like the new bindings are used much, yet. I've found:
> 
> https://elixir.bootlin.com/linux/v5.6-rc2/source/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
> 
> and
> 
> https://elixir.bootlin.com/linux/v5.6-rc2/source/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi#L96
> 
> On PinePhone these are indicator leds with no pre-defined meaning, for
> use by the apps to indicate things like a new SMS, or missed call, or
> whatever people desire.
> 
>>> +
>>> +	speaker_amp: audio-amplifier {
>>> +		compatible = "simple-audio-amplifier";
>>> +		enable-gpios = <&pio 2 7 GPIO_ACTIVE_HIGH>; /* PC7 */
>>> +		sound-name-prefix = "Speaker Amp";
>>> +	};
>>> +
>>> +	vibrator {
>>> +		compatible = "gpio-vibrator";
>>> +		enable-gpios = <&pio 3 2 GPIO_ACTIVE_HIGH>; /* PD2 */
>>> +		vcc-supply = <&reg_dcdc1>;
>>> +	};
>>> +};
>>> +
>>> +&codec {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&codec_analog {
>>> +	cpvdd-supply = <&reg_eldo1>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&cpu0 {
>>> +	cpu-supply = <&reg_dcdc2>;
>>> +};
>>> +
>>> +&cpu1 {
>>> +	cpu-supply = <&reg_dcdc2>;
>>> +};
>>> +
>>> +&cpu2 {
>>> +	cpu-supply = <&reg_dcdc2>;
>>> +};
>>> +
>>> +&cpu3 {
>>> +	cpu-supply = <&reg_dcdc2>;
>>> +};
>>> +
>>> +&dai {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&ehci0 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&ehci1 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&i2c1 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&i2c1_pins>;
>>
>> That's the default
> 
> Ok.
> 
>>> +	status = "okay";
>>> +
>>> +	/* Magnetometer */
>>> +	lis3mdl@1e {
>>> +		compatible = "st,lis3mdl-magn";
>>> +		reg = <0x1e>;
>>> +		vdd-supply = <&reg_dldo1>;
>>> +		vddio-supply = <&reg_dldo1>;
>>> +	};
>>> +
>>> +	/* Accelerometer/gyroscope */
>>> +	mpu6050@68 {
>>> +		compatible = "invensense,mpu6050";
>>> +		reg = <0x68>;
>>> +		interrupt-parent = <&pio>;
>>> +		interrupts = <7 5 IRQ_TYPE_EDGE_RISING>; /* PH5 */
>>> +		vdd-supply = <&reg_dldo1>;
>>> +		vddio-supply = <&reg_dldo1>;
>>> +	};
>>> +};
>>> +
>>> +/* Connected to pogo pins */
>>> +&i2c2 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&i2c2_pins>;
>>
>> That's the default as well
> 
> Actually it is not. There's not i2c2_pins at all in the mainline yet.
> 
>>> +	status = "okay";
>>> +};
>>
>> And I'm not sure what the pogo pins are?
> 
> It's a common name for spring-loaded pin headers that can be used to connect the
> phone to auxiliary devices. 6 pins are visible on this image near the top:
> 
> https://wiki.pine64.org/index.php/File:PinePhone_switches.jpeg
> 
>>> +
>>> +&lradc {
>>> +	vref-supply = <&reg_aldo3>;
>>> +	status = "okay";
>>> +
>>> +	button-200 {
>>> +		label = "Volume Up";
>>> +		linux,code = <KEY_VOLUMEUP>;
>>> +		channel = <0>;
>>> +		voltage = <200000>;
>>> +	};
>>> +
>>> +	button-400 {
>>> +		label = "Volume Down";
>>> +		linux,code = <KEY_VOLUMEDOWN>;
>>> +		channel = <0>;
>>> +		voltage = <400000>;
>>> +	};
>>> +};
>>> +
>>> +&mmc0 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&mmc0_pins>;
>>
>> That's the default
> 
> Ok.
> 
>>> +	vmmc-supply = <&reg_dcdc1>;
>>> +	vqmmc-supply = <&reg_dcdc1>;
>>> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
>>> +	disable-wp;
>>> +	bus-width = <4>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&mmc2 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&mmc2_pins>;
>>
>> Ditto
> 
> Will remove.
> 
>>> +	vmmc-supply = <&reg_dcdc1>;
>>> +	vqmmc-supply = <&reg_dcdc1>;
>>> +	bus-width = <8>;
>>> +	non-removable;
>>> +	cap-mmc-hw-reset;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&ohci0 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&ohci1 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&pio {
>>> +	vcc-pb-supply = <&reg_dcdc1>;
>>> +	vcc-pc-supply = <&reg_dcdc1>;
>>> +	vcc-pd-supply = <&reg_dcdc1>;
>>> +	vcc-pe-supply = <&reg_aldo1>;
>>> +	vcc-pf-supply = <&reg_dcdc1>;
>>> +	vcc-pg-supply = <&reg_dldo4>;
>>> +	vcc-ph-supply = <&reg_dcdc1>;
>>> +};
>>> +
>>> +&r_pio {
>>> +	/*
>>> +	 * FIXME: We can't add that supply for now since it would
>>> +	 * create a circular dependency between pinctrl, the regulator
>>> +	 * and the RSB Bus.
>>> +	 *
>>> +	 * vcc-pl-supply = <&reg_aldo2>;
>>> +	 */
>>> +};
>>> +
>>> +&r_rsb {
>>> +	status = "okay";
>>> +
>>> +	axp803: pmic@3a3 {
>>> +		compatible = "x-powers,axp803";
>>> +		reg = <0x3a3>;
>>> +		interrupt-parent = <&r_intc>;
>>> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>>> +	};
>>> +};
>>> +
>>> +#include "axp803.dtsi"
>>> +
>>> +&ac_power_supply {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&battery_power_supply {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&reg_aldo1 {
>>> +	regulator-min-microvolt = <1800000>;
>>> +	regulator-max-microvolt = <1800000>;
>>> +	regulator-name = "dovdd-csi";
>>> +};
>>> +
>>> +&reg_aldo2 {
>>> +	regulator-always-on;
>>> +	regulator-min-microvolt = <1800000>;
>>> +	regulator-max-microvolt = <1800000>;
>>> +	regulator-name = "vcc-pl";
>>> +};
>>> +
>>> +&reg_aldo3 {
>>> +	regulator-always-on;
>>> +	regulator-min-microvolt = <2700000>;
>>> +	regulator-max-microvolt = <3300000>;
>>> +	regulator-name = "vcc-pll-avcc";
>>> +};
>>> +
>>> +&reg_dcdc1 {
>>> +	regulator-always-on;
>>> +	regulator-min-microvolt = <3300000>;
>>> +	regulator-max-microvolt = <3300000>;
>>> +	regulator-name = "vcc-3v3";
>>> +};
>>> +
>>> +&reg_dcdc2 {
>>> +	regulator-always-on;
>>> +	regulator-min-microvolt = <1000000>;
>>> +	regulator-max-microvolt = <1300000>;
>>> +	regulator-name = "vdd-cpux";
>>> +};
>>> +
>>> +/* DCDC3 is polyphased with DCDC2 */
>>> +
>>> +&reg_dcdc5 {
>>> +	regulator-always-on;
>>> +	regulator-min-microvolt = <1200000>;
>>> +	regulator-max-microvolt = <1200000>;
>>> +	regulator-name = "vcc-dram";
>>> +};
>>> +
>>> +&reg_dcdc6 {
>>> +	regulator-always-on;
>>> +	regulator-min-microvolt = <1100000>;
>>> +	regulator-max-microvolt = <1100000>;
>>> +	regulator-name = "vdd-sys";
>>> +};
>>> +
>>> +&reg_dldo1 {
>>> +	regulator-min-microvolt = <3300000>;
>>> +	regulator-max-microvolt = <3300000>;
>>> +	regulator-name = "vcc-dsi-sensor";
>>> +};
>>> +
>>> +&reg_dldo2 {
>>> +	regulator-min-microvolt = <1800000>;
>>> +	regulator-max-microvolt = <1800000>;
>>> +	regulator-name = "vcc-mipi-io";
>>> +};
>>> +
>>> +&reg_dldo3 {
>>> +	regulator-min-microvolt = <2800000>;
>>> +	regulator-max-microvolt = <2800000>;
>>> +	regulator-name = "avdd-csi";
>>> +};
>>> +
>>> +&reg_dldo4 {
>>> +	regulator-min-microvolt = <1800000>;
>>> +	regulator-max-microvolt = <3300000>;
>>> +	regulator-name = "vcc-wifi-io";
>>> +};
>>> +
>>> +&reg_eldo1 {
>>> +	regulator-always-on;
>>> +	regulator-min-microvolt = <1800000>;
>>> +	regulator-max-microvolt = <1800000>;
>>> +	regulator-name = "vcc-lpddr";
>>> +};
>>> +
>>> +&reg_eldo3 {
>>> +	regulator-min-microvolt = <1800000>;
>>> +	regulator-max-microvolt = <1800000>;
>>> +	regulator-name = "dvdd-1v8-csi";
>>> +};
>>> +
>>> +&reg_fldo1 {
>>> +	regulator-min-microvolt = <1200000>;
>>> +	regulator-max-microvolt = <1200000>;
>>> +	regulator-name = "vcc-1v2-hsic";
>>> +};
>>> +
>>> +&reg_fldo2 {
>>> +	regulator-always-on;
>>> +	regulator-min-microvolt = <1100000>;
>>> +	regulator-max-microvolt = <1100000>;
>>> +	regulator-name = "vdd-cpus";
>>> +};
>>> +
>>> +&reg_ldo_io0 {
>>> +	regulator-min-microvolt = <3300000>;
>>> +	regulator-max-microvolt = <3300000>;
>>> +	regulator-name = "vcc-lcd-ctp-stk";
>>> +	status = "okay";
>>> +};
>>> +
>>> +&reg_ldo_io1 {
>>> +	regulator-min-microvolt = <1800000>;
>>> +	regulator-max-microvolt = <1800000>;
>>> +	regulator-name = "vcc-1v8-typec";
>>> +	status = "okay";
>>> +};
>>> +
>>> +&reg_rtc_ldo {
>>> +	regulator-name = "vcc-rtc";
>>> +};
>>> +
>>> +&sound {
>>> +	status = "okay";
>>> +	simple-audio-card,aux-devs = <&codec_analog>, <&speaker_amp>;
>>> +	simple-audio-card,widgets = "Microphone", "Headset Microphone",
>>> +				    "Microphone", "Internal Microphone",
>>> +				    "Headphone", "Headphone Jack",
>>> +				    "Speaker", "Internal Earpiece",
>>> +				    "Speaker", "Internal Speaker";
>>> +	simple-audio-card,routing =
>>> +			"Headphone Jack", "HP",
>>> +			"Internal Earpiece", "EARPIECE",
>>> +			"Internal Speaker", "Speaker Amp OUTL",
>>> +			"Internal Speaker", "Speaker Amp OUTR",
>>> +			"Speaker Amp INL", "LINEOUT",
>>> +			"Speaker Amp INR", "LINEOUT",
>>> +			"Left DAC", "AIF1 Slot 0 Left",
>>> +			"Right DAC", "AIF1 Slot 0 Right",
>>> +			"AIF1 Slot 0 Left ADC", "Left ADC",
>>> +			"AIF1 Slot 0 Right ADC", "Right ADC",
>>> +			"Internal Microphone", "MBIAS",
>>> +			"MIC1", "Internal Microphone",
>>> +			"Headset Microphone", "HBIAS",
>>> +			"MIC2", "Headset Microphone";
>>> +};
>>> +
>>> +&uart0 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&uart0_pb_pins>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +/* Connected to the modem */
>>> +&uart3 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&uart3_pins>;
>>
>> That's the default too, and I guess you'd need hardware flow control
>> here?
> 
> Hardware flow control is routed badly on the board, and can't be used at the
> moment on any of the submitted versions. It may be added in 1.2.
> 
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usb_otg {
>>> +	dr_mode = "peripheral";
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usb_power_supply {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usbphy {
>>> +	status = "okay";
>>> +};
>>> --
>>> 2.25.1
>>>
>>
>> Looks good otherwise, thanks!
>> Maxime
> 
> Thank you for the review. :)
> 
> regards,
> 	o.
> 
