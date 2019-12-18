Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D91CA12438C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 10:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfLRJpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 04:45:23 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:56745 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbfLRJpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:45:23 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ihVtN-0004U6-2R; Wed, 18 Dec 2019 10:45:17 +0100
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings/irq: add binding for NXP INTMUX  interrupt multiplexer
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Dec 2019 09:45:16 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <shengjiu.wang@nxp.com>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <fugang.duan@nxp.com>,
        <aisheng.dong@nxp.com>
In-Reply-To: <1576653615-27954-2-git-send-email-qiangqing.zhang@nxp.com>
References: <1576653615-27954-1-git-send-email-qiangqing.zhang@nxp.com>
 <1576653615-27954-2-git-send-email-qiangqing.zhang@nxp.com>
Message-ID: <254925e345493019c3e1e558b37e46f2@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: qiangqing.zhang@nxp.com, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, shengjiu.wang@nxp.com, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fugang.duan@nxp.com, aisheng.dong@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-18 07:20, Joakim Zhang wrote:
> This patch adds the DT bindings for the NXP INTMUX interrupt 
> multiplexer
> found in the i.MX8 family SoCs.
>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  .../interrupt-controller/fsl,intmux.txt       | 34 
> +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
>
> diff --git
> 
> a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
> 
> b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
> new file mode 100644
> index 000000000000..be3c6848f36c
> --- /dev/null
> +++ 
> b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
> @@ -0,0 +1,34 @@
> +Freescale INTMUX interrupt multiplexer
> +
> +Required properties:
> +
> +- compatible: Should be:
> +	- "fsl,imx-intmux"
> +- reg: Physical base address and size of registers.
> +- interrupts: Should contain the parent interrupt lines (up to 8) 
> used to
> +  multiplex the input interrupts.
> +- clocks: Should contain one clock for entry in clock-names.
> +- clock-names:
> +   - "ipg": main logic clock
> +- interrupt-controller: Identifies the node as an interrupt 
> controller.
> +- #interrupt-cells: Specifies the number of cells needed to encode 
> an
> +  interrupt source. The value must be 1.
> +
> +Optional properties:
> +
> +- fsl,intmux_chans: The number of channels used for interrupt 
> source. The
> +  Maximum value is 8.
> +
> +Example:
> +
> +	intmux@37400000 {
> +		compatible = "fsl,imx-intmux";
> +		reg = <0x37400000 0x1000>;
> +		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&clk IMX8QM_CM40_IPG_CLK>;
> +		clock-names = "ipg";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		fsl,intmux_chans = <1>;
> +	};
> +

What I don't understand is how the interrupt descriptor can indicate
which channel it is multiplexed on. The driver doesn't makes this
clear either, and I strongly suspect that it was never tested with
more than a single channel...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
