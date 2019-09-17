Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E121B5116
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 17:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfIQPKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 11:10:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42193 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbfIQPKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:10:48 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iAF7n-0000cH-La; Tue, 17 Sep 2019 17:10:39 +0200
Date:   Tue, 17 Sep 2019 17:10:39 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT 5/8] sched/deadline: Reclaim cpuset bandwidth in
 .migrate_task_rq()
Message-ID: <20190917151039.ukplro66tzgxg6xt@linutronix.de>
References: <20190727055638.20443-1-swood@redhat.com>
 <20190727055638.20443-6-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190727055638.20443-6-swood@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-27 00:56:35 [-0500], Scott Wood wrote:
> With the changes to migrate disabling, ->set_cpus_allowed() no longer
> gets deferred until migrate_enable().  To avoid releasing the bandwidth
> while the task may still be executing on the old CPU, move the subtraction
> to ->migrate_task_rq().

I assume this is still valid for the !RT case.
Could someone from the scheduler/DL department please comment on this
one?

> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
>  kernel/sched/deadline.c | 67 +++++++++++++++++++++++--------------------------
>  1 file changed, 31 insertions(+), 36 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index c18be51f7608..2f18d0cf1b56 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1606,14 +1606,42 @@ static void yield_task_dl(struct rq *rq)
>  	return cpu;
>  }
>  
> +static void free_old_cpuset_bw_dl(struct rq *rq, struct task_struct *p)
> +{
> +	struct root_domain *src_rd = rq->rd;
> +
> +	/*
> +	 * Migrating a SCHED_DEADLINE task between exclusive
> +	 * cpusets (different root_domains) entails a bandwidth
> +	 * update. We already made space for us in the destination
> +	 * domain (see cpuset_can_attach()).
> +	 */
> +	if (!cpumask_intersects(src_rd->span, p->cpus_ptr)) {
> +		struct dl_bw *src_dl_b;
> +
> +		src_dl_b = dl_bw_of(cpu_of(rq));
> +		/*
> +		 * We now free resources of the root_domain we are migrating
> +		 * off. In the worst case, sched_setattr() may temporary fail
> +		 * until we complete the update.
> +		 */
> +		raw_spin_lock(&src_dl_b->lock);
> +		__dl_sub(src_dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
> +		raw_spin_unlock(&src_dl_b->lock);
> +	}
> +}
> +
>  static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused)
>  {
>  	struct rq *rq;
>  
> -	if (p->state != TASK_WAKING)
> +	rq = task_rq(p);
> +
> +	if (p->state != TASK_WAKING) {
> +		free_old_cpuset_bw_dl(rq, p);
>  		return;
> +	}
>  
> -	rq = task_rq(p);
>  	/*
>  	 * Since p->state == TASK_WAKING, set_task_cpu() has been called
>  	 * from try_to_wake_up(). Hence, p->pi_lock is locked, but
> @@ -2220,39 +2248,6 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
>  	}
>  }
>  
> -static void set_cpus_allowed_dl(struct task_struct *p,
> -				const struct cpumask *new_mask)
> -{
> -	struct root_domain *src_rd;
> -	struct rq *rq;
> -
> -	BUG_ON(!dl_task(p));
> -
> -	rq = task_rq(p);
> -	src_rd = rq->rd;
> -	/*
> -	 * Migrating a SCHED_DEADLINE task between exclusive
> -	 * cpusets (different root_domains) entails a bandwidth
> -	 * update. We already made space for us in the destination
> -	 * domain (see cpuset_can_attach()).
> -	 */
> -	if (!cpumask_intersects(src_rd->span, new_mask)) {
> -		struct dl_bw *src_dl_b;
> -
> -		src_dl_b = dl_bw_of(cpu_of(rq));
> -		/*
> -		 * We now free resources of the root_domain we are migrating
> -		 * off. In the worst case, sched_setattr() may temporary fail
> -		 * until we complete the update.
> -		 */
> -		raw_spin_lock(&src_dl_b->lock);
> -		__dl_sub(src_dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
> -		raw_spin_unlock(&src_dl_b->lock);
> -	}
> -
> -	set_cpus_allowed_common(p, new_mask);
> -}
> -
>  /* Assumes rq->lock is held */
>  static void rq_online_dl(struct rq *rq)
>  {
> @@ -2407,7 +2402,7 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
>  #ifdef CONFIG_SMP
>  	.select_task_rq		= select_task_rq_dl,
>  	.migrate_task_rq	= migrate_task_rq_dl,
> -	.set_cpus_allowed       = set_cpus_allowed_dl,
> +	.set_cpus_allowed       = set_cpus_allowed_common,
>  	.rq_online              = rq_online_dl,
>  	.rq_offline             = rq_offline_dl,
>  	.task_woken		= task_woken_dl,
> -- 
> 1.8.3.1
> 

Sebastian
