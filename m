Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83CD2289C3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 21:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390407AbfEWTl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 15:41:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42075 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389165AbfEWTTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:19:37 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 26E8F803D1; Thu, 23 May 2019 21:19:25 +0200 (CEST)
Date:   Thu, 23 May 2019 21:19:26 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 2/4] arm64: dts: fsl: librem5: Add a device tree for
 the Librem5 devkit
Message-ID: <20190523191926.GB3803@xo-6d-61-c0.localdomain>
References: <20190520142330.3556-1-angus@akkea.ca>
 <20190520142330.3556-3-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520142330.3556-3-angus@akkea.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - LEDs
> - gyro
> - magnetometer

> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_leds>;
> +
> +		led1 {
> +			label = "LED 1";

So, what kind of LED do you have, and what color is it? label should probably be something like
notify:green.

> +	charger@6b { /* bq25896 */
> +		compatible = "ti,bq25890";
> +		reg = <0x6b>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_charger>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +		ti,battery-regulation-voltage = <4192000>; /* 4.192V */
> +		ti,charge-current = <1600000>; /* 1.6 A */

No space before A, for consistency.

> +		ti,termination-current = <66000>;  /* 66mA */
> +		ti,precharge-current = <1300000>; /* 1.3A */

I thought precharge is usually something low, because you are not yet sure of battery health...?

> +		ti,minimum-sys-voltage = <2750000>; /* 2.75V */

Are you sure? Normally systems shut down at 3.2V, 3V or so. Li-ion batteries don't
really like to be discharged _this_ deep.

										Pavel
