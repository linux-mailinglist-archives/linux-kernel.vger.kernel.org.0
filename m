Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0790F6987
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2019 15:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfKJOx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 09:53:28 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:58757 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726402AbfKJOx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 09:53:28 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iToaY-0002r6-32; Sun, 10 Nov 2019 15:53:14 +0100
Date:   Sun, 10 Nov 2019 14:53:12 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        andrew@aj.id.au, joel@jms.id.au, jason@lakedaemon.net,
        tglx@linutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 02/12] irqchip: Add Aspeed SCU interrupt controller
Message-ID: <20191110145312.3805b25b@why>
In-Reply-To: <1573244313-9190-3-git-send-email-eajames@linux.ibm.com>
References: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
        <1573244313-9190-3-git-send-email-eajames@linux.ibm.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: eajames@linux.ibm.com, linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, andrew@aj.id.au, joel@jms.id.au, jason@lakedaemon.net, tglx@linutronix.de, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Nov 2019 14:18:23 -0600
Eddie James <eajames@linux.ibm.com> wrote:

Hi Eddie,

> The Aspeed SOCs provide some interrupts through the System Control
> Unit registers. Add an interrupt controller that provides these
> interrupts to the system.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  MAINTAINERS                         |   1 +
>  drivers/irqchip/Makefile            |   2 +-
>  drivers/irqchip/irq-aspeed-scu-ic.c | 233 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 235 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/irqchip/irq-aspeed-scu-ic.c

[...]

> +static int aspeed_scu_ic_map(struct irq_domain *domain, unsigned int irq,
> +			     irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &aspeed_scu_ic_chip, handle_simple_irq);

handle_simple_irq is usually wrong, and works badly with threaded
interrupts. I suggest you'd change it to handle_level_irq, which
probably matches the behaviour of the controller.

Otherwise, this looks good.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
