Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8572C706
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 14:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfE1MwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 08:52:01 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58045 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfE1MwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:52:01 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hVbZz-0003P1-Qv; Tue, 28 May 2019 14:51:47 +0200
Message-ID: <1559047905.4039.15.camel@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: fsl: imx8mq: enable the svns power key
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>, angus.ainslie@puri.sm
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 28 May 2019 14:51:45 +0200
In-Reply-To: <20190528124406.29730-1-angus@akkea.ca>
References: <20190528124406.29730-1-angus@akkea.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angus,

Am Dienstag, den 28.05.2019, 05:44 -0700 schrieb Angus Ainslie (Purism):
> Add the snvs power key.
> 
> > Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 45d10d8efd14..5f93fd9662ae 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/power/imx8mq-power.h>
>  #include <dt-bindings/reset/imx8mq-reset.h>
>  #include <dt-bindings/gpio/gpio.h>
> +#include "dt-bindings/input/input.h"
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/thermal/thermal.h>
>  #include "imx8mq-pinfunc.h"
> @@ -463,6 +464,14 @@
> >  					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> >  						<GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> >  				};
> +
> > +				snvs_pwrkey: snvs-powerkey {
> > +					compatible = "fsl,sec-v4.0-pwrkey";
> > +					regmap = <&snvs>;
> > +					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> > +					linux,keycode = <KEY_POWER>;
> +					wakeup-source;

Not all i.MX8MQ systems will have this functionality wired up at the
board level, so this node needs to be disabled by default. The existing
 i.MX6 and i.MX7 DTs seem to get this wrong.

Regards,
Lucas

> +				};
> >  			};
>  
> > >  			clk: clock-controller@30380000 {
