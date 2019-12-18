Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2854D12437E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 10:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfLRJlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 04:41:07 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:59461 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbfLRJlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:41:07 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ihVpB-0004Mi-LQ; Wed, 18 Dec 2019 10:40:57 +0100
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH 3/3] drivers/irqchip: enable INTMUX interrupt controller  driver
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Dec 2019 09:40:57 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <shengjiu.wang@nxp.com>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <fugang.duan@nxp.com>,
        <aisheng.dong@nxp.com>
In-Reply-To: <1576653615-27954-4-git-send-email-qiangqing.zhang@nxp.com>
References: <1576653615-27954-1-git-send-email-qiangqing.zhang@nxp.com>
 <1576653615-27954-4-git-send-email-qiangqing.zhang@nxp.com>
Message-ID: <30431cce4c9e59ab11043c991493c368@www.loen.fr>
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
> Enable INTMUX interrupt controller driver for i.MX platforms.
>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/irqchip/Kconfig  | 6 ++++++
>  drivers/irqchip/Makefile | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index ba152954324b..7e2b1e9d0b45 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -457,6 +457,12 @@ config IMX_IRQSTEER
>  	help
>  	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
>
> +config IMX_INTMUX
> +	def_bool y if ARCH_MXC
> +	select IRQ_DOMAIN
> +	help
> +	  Support for the i.MX INTMUX interrupt multiplexer.
> +
>  config LS1X_IRQ
>  	bool "Loongson-1 Interrupt Controller"
>  	depends on MACH_LOONGSON32
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index e806dda690ea..af976a79d1fb 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -100,6 +100,7 @@ obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
>  obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
>  obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
>  obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
> +obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
>  obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
>  obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
>  obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o

Please merge this with the previous patch, it doesn't really warrant
a separate patch.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
