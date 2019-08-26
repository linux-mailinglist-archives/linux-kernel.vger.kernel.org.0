Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E0D9D4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 19:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732950AbfHZROx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 13:14:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:31564 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731490AbfHZROw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 13:14:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 10:14:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="204654982"
Received: from mgross-mobl.amr.corp.intel.com (HELO localhost) ([10.7.198.58])
  by fmsmga004.fm.intel.com with ESMTP; 26 Aug 2019 10:14:50 -0700
Date:   Mon, 26 Aug 2019 10:14:50 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [RFC PATCH v3 09/16] sched: Introduce sched_class::pick_task()
Message-ID: <20190826171450.GG2680@u1904>
Reply-To: mgross@linux.intel.com
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <b480899e572857c3392d1176811a084084b4cf7f.1559129225.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b480899e572857c3392d1176811a084084b4cf7f.1559129225.git.vpillai@digitalocean.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 08:36:45PM +0000, Vineeth Remanan Pillai wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Because sched_class::pick_next_task() also implies
> sched_class::set_next_task() (and possibly put_prev_task() and
> newidle_balance) it is not state invariant. This makes it unsuitable
> for remote task selection.
It would be cool if the commit comment would explain what the change is going
to do about pick_next_task being unsuitable for remote task selection.

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
> Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
> ---
> 
> Chnages in v3
> -------------
> - Minor refactor to remove redundant NULL checks
> 
> Changes in v2
> -------------
> - Fixes a NULL pointer dereference crash
>   - Subhra Mazumdar
>   - Tim Chen
> 
> ---
>  kernel/sched/deadline.c  | 21 ++++++++++++++++-----
>  kernel/sched/fair.c      | 36 +++++++++++++++++++++++++++++++++---
>  kernel/sched/idle.c      | 10 +++++++++-
>  kernel/sched/rt.c        | 21 ++++++++++++++++-----
>  kernel/sched/sched.h     |  2 ++
>  kernel/sched/stop_task.c | 21 ++++++++++++++++-----
>  6 files changed, 92 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d3904168857a..64fc444f44f9 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1722,15 +1722,12 @@ static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
>  	return rb_entry(left, struct sched_dl_entity, rb_node);
>  }
>  
> -static struct task_struct *
> -pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> +static struct task_struct *pick_task_dl(struct rq *rq)
>  {
>  	struct sched_dl_entity *dl_se;
>  	struct task_struct *p;
>  	struct dl_rq *dl_rq;
>  
> -	WARN_ON_ONCE(prev || rf);
> -
>  	dl_rq = &rq->dl;
>  
>  	if (unlikely(!dl_rq->dl_nr_running))
> @@ -1741,7 +1738,19 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  
>  	p = dl_task_of(dl_se);
>  
> -	set_next_task_dl(rq, p);
> +	return p;
> +}
> +
> +static struct task_struct *
> +pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> +{
> +	struct task_struct *p;
> +
> +	WARN_ON_ONCE(prev || rf);
What is an admin to do with this warnding if it shows up in there logs?
maybe include some text here to help folks that might hit this warn_on.


> +
> +	p = pick_task_dl(rq);
> +	if (p)
> +		set_next_task_dl(rq, p);
>  
>  	return p;
>  }
> @@ -2388,6 +2397,8 @@ const struct sched_class dl_sched_class = {
>  	.set_next_task		= set_next_task_dl,
>  
>  #ifdef CONFIG_SMP
> +	.pick_task		= pick_task_dl,
> +
>  	.select_task_rq		= select_task_rq_dl,
>  	.migrate_task_rq	= migrate_task_rq_dl,
>  	.set_cpus_allowed       = set_cpus_allowed_dl,
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e65f2dfda77a..02e5dfb85e7d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4136,7 +4136,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  	 * Avoid running the skip buddy, if running something else can
>  	 * be done without getting too unfair.
>  	 */
> -	if (cfs_rq->skip == se) {
> +	if (cfs_rq->skip && cfs_rq->skip == se) {
>  		struct sched_entity *second;
>  
>  		if (se == curr) {
> @@ -4154,13 +4154,13 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  	/*
>  	 * Prefer last buddy, try to return the CPU to a preempted task.
>  	 */
> -	if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
> +	if (left && cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
>  		se = cfs_rq->last;
>  
>  	/*
>  	 * Someone really wants this to run. If it's not unfair, run it.
>  	 */
> -	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
> +	if (left && cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
>  		se = cfs_rq->next;
>  
>  	clear_buddies(cfs_rq, se);
> @@ -6966,6 +6966,34 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>  		set_last_buddy(se);
>  }
>  
> +static struct task_struct *
> +pick_task_fair(struct rq *rq)
> +{
> +	struct cfs_rq *cfs_rq = &rq->cfs;
> +	struct sched_entity *se;
> +
> +	if (!cfs_rq->nr_running)
> +		return NULL;
> +
> +	do {
> +		struct sched_entity *curr = cfs_rq->curr;
> +
> +		se = pick_next_entity(cfs_rq, NULL);
> +
> +		if (curr) {
> +			if (se && curr->on_rq)
> +				update_curr(cfs_rq);
> +
> +			if (!se || entity_before(curr, se))
> +				se = curr;
> +		}
> +
> +		cfs_rq = group_cfs_rq(se);
> +	} while (cfs_rq);
> +
> +	return task_of(se);
> +}
> +
>  static struct task_struct *
>  pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
> @@ -10677,6 +10705,8 @@ const struct sched_class fair_sched_class = {
>  	.set_next_task          = set_next_task_fair,
>  
>  #ifdef CONFIG_SMP
> +	.pick_task		= pick_task_fair,
> +
>  	.select_task_rq		= select_task_rq_fair,
>  	.migrate_task_rq	= migrate_task_rq_fair,
>  
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 7ece8e820b5d..e7f38da60373 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -373,6 +373,12 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
>  	resched_curr(rq);
>  }
>  
> +static struct task_struct *
> +pick_task_idle(struct rq *rq)
> +{
> +	return rq->idle;
> +}
> +
>  static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
>  }
> @@ -386,11 +392,12 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next)
>  static struct task_struct *
>  pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
> -	struct task_struct *next = rq->idle;
> +	struct task_struct *next;
>  
>  	if (prev)
>  		put_prev_task(rq, prev);
>  
> +	next = pick_task_idle(rq);
>  	set_next_task_idle(rq, next);
>  
>  	return next;
> @@ -458,6 +465,7 @@ const struct sched_class idle_sched_class = {
>  	.set_next_task          = set_next_task_idle,
>  
>  #ifdef CONFIG_SMP
> +	.pick_task		= pick_task_idle,
>  	.select_task_rq		= select_task_rq_idle,
>  	.set_cpus_allowed	= set_cpus_allowed_common,
>  #endif
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 79f2e60516ef..81557224548c 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1548,20 +1548,29 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
>  	return rt_task_of(rt_se);
>  }
>  
> -static struct task_struct *
> -pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> +static struct task_struct *pick_task_rt(struct rq *rq)
>  {
>  	struct task_struct *p;
>  	struct rt_rq *rt_rq = &rq->rt;
>  
> -	WARN_ON_ONCE(prev || rf);
> -
>  	if (!rt_rq->rt_queued)
>  		return NULL;
>  
>  	p = _pick_next_task_rt(rq);
>  
> -	set_next_task_rt(rq, p);
> +	return p;
> +}
> +
> +static struct task_struct *
> +pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> +{
> +	struct task_struct *p;
> +
> +	WARN_ON_ONCE(prev || rf);
what does it mean if this warn on goes off to an admin?

> +
> +	p = pick_task_rt(rq);
> +	if (p)
> +		set_next_task_rt(rq, p);
>  
>  	return p;
>  }
> @@ -2364,6 +2373,8 @@ const struct sched_class rt_sched_class = {
>  	.set_next_task          = set_next_task_rt,
>  
>  #ifdef CONFIG_SMP
> +	.pick_task		= pick_task_rt,
> +
>  	.select_task_rq		= select_task_rq_rt,
>  
>  	.set_cpus_allowed       = set_cpus_allowed_common,
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 460dd04e76af..a024dd80eeb3 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1682,6 +1682,8 @@ struct sched_class {
>  	void (*set_next_task)(struct rq *rq, struct task_struct *p);
>  
>  #ifdef CONFIG_SMP
> +	struct task_struct * (*pick_task)(struct rq *rq);
> +
>  	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
>  	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
>  
> diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
> index 7e1cee4e65b2..fb6c436cba6c 100644
> --- a/kernel/sched/stop_task.c
> +++ b/kernel/sched/stop_task.c
> @@ -29,20 +29,30 @@ static void set_next_task_stop(struct rq *rq, struct task_struct *stop)
>  }
>  
>  static struct task_struct *
> -pick_next_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> +pick_task_stop(struct rq *rq)
>  {
>  	struct task_struct *stop = rq->stop;
>  
> -	WARN_ON_ONCE(prev || rf);
> -
>  	if (!stop || !task_on_rq_queued(stop))
>  		return NULL;
>  
> -	set_next_task_stop(rq, stop);
> -
>  	return stop;
>  }
>  
> +static struct task_struct *
> +pick_next_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> +{
> +	struct task_struct *p;
> +
> +	WARN_ON_ONCE(prev || rf);
> +
> +	p = pick_task_stop(rq);
> +	if (p)
> +		set_next_task_stop(rq, p);
> +
> +	return p;
> +}
> +
>  static void
>  enqueue_task_stop(struct rq *rq, struct task_struct *p, int flags)
>  {
> @@ -129,6 +139,7 @@ const struct sched_class stop_sched_class = {
>  	.set_next_task          = set_next_task_stop,
>  
>  #ifdef CONFIG_SMP
> +	.pick_task		= pick_task_stop,
>  	.select_task_rq		= select_task_rq_stop,
>  	.set_cpus_allowed	= set_cpus_allowed_common,
>  #endif
> -- 
> 2.17.1
> 
