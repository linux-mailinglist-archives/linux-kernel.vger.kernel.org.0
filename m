Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3BCC1261C6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 13:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfLSMOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 07:14:38 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:39231 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726668AbfLSMOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:14:37 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ihuhJ-00076z-VD; Thu, 19 Dec 2019 13:14:29 +0100
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH V2 0/2] irqchip: add NXP INTMUX interrupt controller
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Dec 2019 12:14:29 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <linux-imx@nxp.com>, <linux-kernel@vger.kernel.org>,
        <fugang.duan@nxp.com>, <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <1576750865-14442-1-git-send-email-qiangqing.zhang@nxp.com>
References: <1576750865-14442-1-git-send-email-qiangqing.zhang@nxp.com>
Message-ID: <f80a236884aeba78dfa45596dcb20255@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: qiangqing.zhang@nxp.com, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com, linux-kernel@vger.kernel.org, fugang.duan@nxp.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-19 10:21, Joakim Zhang wrote:
> Hi Marc,
>
>    Registering domain for each channel is indeed a bit unreasonable, 
> I have
> changed the driver to support only one channel (channel 0 by default) 
> as
> muti-channels is designed to route interrupt to different cores. The 
> fixed
> channel is enough for us.

But that's not what the HW does, right? Next time, you will post
the patches that enabled multiple channels, and the interrupt specifier
will have to change, which will impact all existing DTs.

So please do the right thing from the start. Add channel selection to
the interrupt specifier. Pick the right irq domain with a .select()
callback, and your driver will magically work.

Thanks,

         M.

>   Thanks for your kindly review.
>
> ChangeLog:
> V1->V2:	*squash patches:
> 		drivers/irqchip: enable INTMUX interrupt controller driver
>  		drivers/irqchip: add NXP INTMUX interrupt multiplexer support
> 	*remove properity "fsl,intmux_chans", only support channel 0 by
> 	default.
> 	*delete two unused macros.
> 	*align the various field in struct intmux_data.
> 	*turn to spin lock _irqsave version.
> 	*delete struct intmux_irqchip_data
> 	*disable interrupt in probe stage and clear pending status in remove
> 	stage
>
> Joakim Zhang (2):
>   dt-bindings/irq: add binding for NXP INTMUX interrupt multiplexer
>   drivers/irqchip: add NXP INTMUX interrupt multiplexer support
>
>  .../interrupt-controller/fsl,intmux.txt       |  28 ++
>  drivers/irqchip/Kconfig                       |   6 +
>  drivers/irqchip/Makefile                      |   1 +
>  drivers/irqchip/irq-imx-intmux.c              | 240 
> ++++++++++++++++++
>  4 files changed, 275 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
>  create mode 100644 drivers/irqchip/irq-imx-intmux.c

-- 
Jazz is not dead. It just smells funny...
