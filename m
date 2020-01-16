Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5291213D9AB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 13:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgAPMIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 07:08:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51485 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAPMIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:08:22 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1is3wf-00065E-PM; Thu, 16 Jan 2020 13:08:17 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 6FF84101B66; Thu, 16 Jan 2020 13:08:17 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/isolation: isolate from handling managed interrupt
In-Reply-To: <20200116094806.25372-1-ming.lei@redhat.com>
References: <20200116094806.25372-1-ming.lei@redhat.com>
Date:   Thu, 16 Jan 2020 13:08:17 +0100
Message-ID: <875zhbwqmm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ming,

Ming Lei <ming.lei@redhat.com> writes:

> @@ -212,12 +213,29 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
>  {
>  	struct irq_desc *desc = irq_data_to_desc(data);
>  	struct irq_chip *chip = irq_data_get_irq_chip(data);
> +	const struct cpumask *housekeeping_mask =
> +		housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
>  	int ret;
> +	cpumask_var_t tmp_mask = (struct cpumask *)mask;
>  
>  	if (!chip || !chip->irq_set_affinity)
>  		return -EINVAL;
>  
> -	ret = chip->irq_set_affinity(data, mask, force);
> +	zalloc_cpumask_var(&tmp_mask, GFP_ATOMIC);

I clearly told you:

    "That's wrong. This code is called with interrupts disabled, so
     GFP_KERNEL is wrong. And NO, we won't do a GFP_ATOMIC allocation
     here."

Is that last sentence unclear in any way?

Thanks,

        tglx

