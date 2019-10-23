Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31836E1C59
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 15:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405791AbfJWNWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 09:22:44 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:37145 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405084AbfJWNWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:22:44 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iNGaz-0002vU-Ap; Wed, 23 Oct 2019 15:22:37 +0200
To:     Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH RFC 2/2] irqchip/gic: Allow the use of SGI interrupts
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Oct 2019 14:22:34 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thanu Rangarajan <thanu.rangarajan@arm.com>
In-Reply-To: <20191023000547.7831-3-f.fainelli@gmail.com>
References: <20191023000547.7831-1-f.fainelli@gmail.com>
 <20191023000547.7831-3-f.fainelli@gmail.com>
Message-ID: <112a725164b7fe321f27357fd4cd772f@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: f.fainelli@gmail.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com, bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, souvik.chakravarty@arm.com, james.quinlan@broadcom.com, sudeep.holla@arm.com, thanu.rangarajan@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Needless to say, I mostly have questions...

On 2019-10-23 01:05, Florian Fainelli wrote:
> SGI interrupts are a convenient way for trusted firmware to target a
> specific set of CPUs. Update the ARM GIC code to allow the 
> translation
> and mapping of SGI interrupts.
>
> Since the kernel already uses SGIs for various inter-processor 
> interrupt
> activities, we specifically make sure that we do not let users of the
> IRQ API to even try to map those.
>
> Internal IPIs remain dispatched through handle_IPI() while public 
> SGIs
> get promoted to a normal interrupt flow management.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/irqchip/irq-gic.c | 41 
> +++++++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 30ab623343d3..dcfdbaacdd64 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -385,7 +385,10 @@ static void __exception_irq_entry
> gic_handle_irq(struct pt_regs *regs)
>  			 * Pairs with the write barrier in gic_raise_softirq
>  			 */
>  			smp_rmb();
> -			handle_IPI(irqnr, regs);
> +			if (irqnr < NR_IPI)
> +				handle_IPI(irqnr, regs);
> +			else
> +				handle_domain_irq(gic->domain, irqnr, regs);

Double EOI, UNPREDICTABLE territory, your state machine is now dead.

>  #endif
>  			continue;
>  		}
> @@ -1005,20 +1008,34 @@ static int gic_irq_domain_translate(struct
> irq_domain *d,
>  		if (fwspec->param_count < 3)
>  			return -EINVAL;
>
> -		/* Get the interrupt number and add 16 to skip over SGIs */
> -		*hwirq = fwspec->param[1] + 16;
> -
> -		/*
> -		 * For SPIs, we need to add 16 more to get the GIC irq
> -		 * ID number
> -		 */
> -		if (!fwspec->param[0])
> +		*hwirq = fwspec->param[1];
> +		switch (fwspec->param[0]) {
> +		case 0:
> +			/*
> +			 * For SPIs, we need to add 16 more to get the GIC irq
> +			 * ID number
> +			 */
> +			*hwirq += 16;
> +			/* fall through */
> +		case 1:
> +			/* Add 16 to skip over SGIs */
>  			*hwirq += 16;
> +			*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
>
> -		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
> +			/* Make it clear that broken DTs are... broken */
> +			WARN_ON(*type == IRQ_TYPE_NONE);
> +			break;
> +		case 2:
> +			/* Refuse to map internal IPIs */
> +			if (*hwirq < NR_IPI)

So depending on how the kernel uses SGIs, you can or cannot use these 
SGIs.
That looks like a good way to corner ourselves into not being to change 
much.

Also, do you expect this to work for both Group-0 and Group-1 
interrupts
(since you imply that this works as a communication medium with the 
secure
side)? Given that the kernel running in NS has no way to enable/disable
Group-0 interrupts, this looks terminally flawed. Or is that Group-1 
only?

How do we describe which SGIs are guaranteed to be available to Linux?

> +				return -EPERM;
> +
> +			*type = IRQ_TYPE_NONE;

Or not. SGI are edge triggered, by definition.

> +			break;
> +		default:
> +			break;
> +		}
>
> -		/* Make it clear that broken DTs are... broken */
> -		WARN_ON(*type == IRQ_TYPE_NONE);

Really?

         M.
-- 
Jazz is not dead. It just smells funny...
