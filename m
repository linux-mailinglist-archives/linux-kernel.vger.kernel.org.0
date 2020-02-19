Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E57616437C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 12:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgBSLfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 06:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgBSLfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:35:06 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E02E924656;
        Wed, 19 Feb 2020 11:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582112106;
        bh=UIvBZfPVB1MJ+WLKE+hivv130ujtqRVP9KGVtwZNXZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AO9Jo86XecVBRXWeRr9PHZrHwXrN6LZiWjZiBkmEU5Izw1Po7++b0Rc0QnwF44Fir
         gqF1pwVuaNwNm6hs/aLYkKJideVPx+gsNUMidHV4DOL/RDhuanijyyh0ATHKkMHEQM
         4jxJ/3fH3m4bVP0jxEOcbX6LvxDgFcXiH8q6VNpk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j4NdA-006UcL-91; Wed, 19 Feb 2020 11:35:04 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Feb 2020 11:35:04 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] irqchip: vic: Support cascaded VIC in device tree
In-Reply-To: <20200213124757.35385-1-linus.walleij@linaro.org>
References: <20200213124757.35385-1-linus.walleij@linaro.org>
Message-ID: <a2079c252f7c87753e957aa8a09c3824@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linus.walleij@linaro.org, tglx@linutronix.de, marc.zyngier@arm.com, jason@lakedaemon.net, linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please use my kernel.org email address, I just rescued this email
from the ML...

On 2020-02-13 12:47, Linus Walleij wrote:
> When transitioning some elder platforms to device tree it
> becomes necessary to cascade VIC IRQ chips off another
> interrupt controller.
> 
> Tested with the cascaded VIC on the Integrator/AP attached
> logic module IM-PD1.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/irqchip/irq-vic.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
> index f3f20a3cff50..caff21b4bac6 100644
> --- a/drivers/irqchip/irq-vic.c
> +++ b/drivers/irqchip/irq-vic.c
> @@ -509,9 +509,7 @@ static int __init vic_of_init(struct device_node 
> *node,
>  	void __iomem *regs;
>  	u32 interrupt_mask = ~0;
>  	u32 wakeup_mask = ~0;
> -
> -	if (WARN(parent, "non-root VICs are not supported"))
> -		return -EINVAL;
> +	int parent_irq = 0;

nit: Do you need this to be initialized to zero?

> 
>  	regs = of_iomap(node, 0);
>  	if (WARN_ON(!regs))
> @@ -519,11 +517,14 @@ static int __init vic_of_init(struct device_node 
> *node,
> 
>  	of_property_read_u32(node, "valid-mask", &interrupt_mask);
>  	of_property_read_u32(node, "valid-wakeup-mask", &wakeup_mask);
> +	parent_irq = of_irq_get(node, 0);
> +	if (parent_irq < 0)
> +		parent_irq = 0;
> 
>  	/*
>  	 * Passing 0 as first IRQ makes the simple domain allocate 
> descriptors
>  	 */
> -	__vic_init(regs, 0, 0, interrupt_mask, wakeup_mask, node);
> +	__vic_init(regs, parent_irq, 0, interrupt_mask, wakeup_mask, node);
> 
>  	return 0;
>  }

Do you want this as a fix?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
