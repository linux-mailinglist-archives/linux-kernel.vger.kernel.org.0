Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03D0630D14
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 13:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfEaLJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 07:09:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59738 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaLJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 07:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8FodIdoRggqYpcfQ8IzxUymg8eKDtRxFytfKCu5DB9o=; b=xu2eMCvpPsW5sOGQjGrgPouad
        Sj/Oj86A4dMjx7iMebMebAizyuYOW3QMwVmGxrADtL2Ca/k+dY2rlO9NreoOLfg95LpG0bYGsIxI8
        CtEthcD7L40SrBvDIPy7L86mY3aoR31mettwPQ3wtTwTXKcv0bRlxbsGMeh8miik97qACtRR7PDEy
        JIeEw+wg4hhqM0nHEFK0LBcbUIivq8qfkg7Z3grUK4IzYHufz8NpSJNEtj3gsFV/H4HFfVZDwTorf
        G55cTnOMWKf0rF5VrbJ7s88OpckRH77nPbe3Wx7IvuxaJZrSPM8M8RXvIsGXtWMzabjrGmcCvUQo1
        ITJRfMwvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWfOZ-0004hP-FW; Fri, 31 May 2019 11:08:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7B55201B8CFE; Fri, 31 May 2019 13:08:20 +0200 (CEST)
Date:   Fri, 31 May 2019 13:08:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 10/16] sched: Core-wide rq->lock
Message-ID: <20190531110820.GP2623@hirez.programming.kicks-ass.net>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <a03795e66ed45469ac5b3c1b1d01c8ed33be299f.1559129225.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a03795e66ed45469ac5b3c1b1d01c8ed33be299f.1559129225.git.vpillai@digitalocean.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 08:36:46PM +0000, Vineeth Remanan Pillai wrote:

> + * The static-key + stop-machine variable are needed such that:
> + *
> + *	spin_lock(rq_lockp(rq));
> + *	...
> + *	spin_unlock(rq_lockp(rq));
> + *
> + * ends up locking and unlocking the _same_ lock, and all CPUs
> + * always agree on what rq has what lock.

> @@ -5790,8 +5854,15 @@ int sched_cpu_activate(unsigned int cpu)
>  	/*
>  	 * When going up, increment the number of cores with SMT present.
>  	 */
> -	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
> +	if (cpumask_weight(cpu_smt_mask(cpu)) == 2) {
>  		static_branch_inc_cpuslocked(&sched_smt_present);
> +#ifdef CONFIG_SCHED_CORE
> +		if (static_branch_unlikely(&__sched_core_enabled)) {
> +			rq->core_enabled = true;
> +		}
> +#endif
> +	}
> +
>  #endif
>  	set_cpu_active(cpu, true);
>  
> @@ -5839,8 +5910,16 @@ int sched_cpu_deactivate(unsigned int cpu)
>  	/*
>  	 * When going down, decrement the number of cores with SMT present.
>  	 */
> -	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
> +	if (cpumask_weight(cpu_smt_mask(cpu)) == 2) {
> +#ifdef CONFIG_SCHED_CORE
> +		struct rq *rq = cpu_rq(cpu);
> +		if (static_branch_unlikely(&__sched_core_enabled)) {
> +			rq->core_enabled = false;
> +		}
> +#endif
>  		static_branch_dec_cpuslocked(&sched_smt_present);
> +
> +	}
>  #endif

I'm confused, how doesn't this break the invariant above?

That is, all CPUs must at all times agree on the value of rq_lockp(),
and I'm not seeing how that is true with the above changes.
