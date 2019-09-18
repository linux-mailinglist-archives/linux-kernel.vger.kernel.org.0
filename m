Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5720BB666E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 16:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbfIROwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 10:52:39 -0400
Received: from foss.arm.com ([217.140.110.172]:43432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731141AbfIROwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:52:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B5A51000;
        Wed, 18 Sep 2019 07:52:38 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73CFE3F67D;
        Wed, 18 Sep 2019 07:52:37 -0700 (PDT)
Date:   Wed, 18 Sep 2019 15:52:35 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Alessio Balsini <balsini@android.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: rt: Make RT capacity aware
Message-ID: <20190918145233.kgntor5nb2gmnczd@e107158-lin.cambridge.arm.com>
References: <20190903103329.24961-1-qais.yousef@arm.com>
 <20190904072524.09de28aa@oasis.local.home>
 <20190904154052.ygbhtduzkfj3xs5d@e107158-lin.cambridge.arm.com>
 <f25c1f61-f246-22c7-e627-4c4d39301af2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f25c1f61-f246-22c7-e627-4c4d39301af2@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/19 14:30, Dietmar Eggemann wrote:
> On 9/4/19 4:40 PM, Qais Yousef wrote:
> > On 09/04/19 07:25, Steven Rostedt wrote:
> >> On Tue,  3 Sep 2019 11:33:29 +0100
> >> Qais Yousef <qais.yousef@arm.com> wrote:
> 
> [...]
> 
> >>> @@ -1614,7 +1660,8 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
> >>>  static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
> >>>  {
> >>>  	if (!task_running(rq, p) &&
> >>> -	    cpumask_test_cpu(cpu, p->cpus_ptr))
> >>> +	    cpumask_test_cpu(cpu, p->cpus_ptr) &&
> >>> +	    rt_task_fits_capacity(p, cpu))
> >>
> >> Hmm, so if a CPU goes idle, and looks for CPUS with more than one RT
> >> task queued (overloaded), it will skip pulling RT tasks if they are
> >> below capacity. Is that the desired effect? I think we could end up
> >> with a small idle CPUs with RT tasks waiting to run.
> > 
> > The intention was not to pull this task that doesn't fit. But not to abort the
> > whole pull operation. pick_highest_pushable_task() should still iterate through
> > the remaining tasks, or did I miss something?
> 
> On a big.LITTLE system (6 CPUs with [446 1024 1024 446 466 466] CPU
> capacity vector) I try to trace the handling of the 3rd big task
> (big2-2, util_min: 800, util_max: 1024) of an rt-app workload running 3
> of them.
> 
> rt_task_fits_capacity() call in:
> 
> tag 1: select_task_rq_rt(), 3-7: 1st till 5th in find_lowest_rq()
> 
> [   37.505325] rt_task_fits_capacity: CPU3 tag=1 [big2-2 285] ret=0
> [   37.505882] find_lowest_rq: CPU3 [big2-2 285] tag=1 find_lowest_rq
> [   37.506509] CPU3 [big2-2 285] lowest_mask=0,3-5
> [   37.507971] rt_task_fits_capacity: CPU3 tag=3 [big2-2 285] ret=0
> [   37.508200] rt_task_fits_capacity: CPU3 tag=4 [big2-2 285] ret=0
> [   37.509486] rt_task_fits_capacity: CPU0 tag=5 [big2-2 285] ret=0
> [   37.510191] rt_task_fits_capacity: CPU3 tag=5 [big2-2 285] ret=0
> [   37.511334] rt_task_fits_capacity: CPU4 tag=5 [big2-2 285] ret=0
> [   37.512194] rt_task_fits_capacity: CPU5 tag=5 [big2-2 285] ret=0
> [   37.513210] rt_task_fits_capacity: CPU0 tag=6 [big2-2 285] ret=0
> [   37.514085] rt_task_fits_capacity: CPU3 tag=7 [big2-2 285] ret=0
> [   37.514732] --> select_task_rq_rt: CPU3 [big2-2 285] cpu=0
> 
> Since CPU 0,3-5 can't run big2-2, it takes up to the test that the
> fitness hasn't changed. In case a capacity-aware (with fallback CPU)
> cpupri_find() would have returned a suitable lowest_mask, less work
> would have been needed.

rt_task_fits_capacity() is inlined and I'd expect all the data it accesses to
be cache hot, so it should be fast.

I had 2 concerns with using cpupri_find()

	1. find_lowest_rq() is not the only user

	2. The fallback mechanism means we either have to call cpupri_find()
	   twice once to find filtered lowest_rq and the other to return the
	   none filtered version.

	   ie:

		cpupri_find(..., check_fitness = true);
		// returns lowest_mask that is filtered for cap fitness

		fallback:
			cpupri_find(..., check_fitness = false);
			// returns lowest_mask without check for cap fitness

	   Or we can pass 2 masks to cpupri_find() so that we fill the filtered
	   and non-filtered results in one go and use the one that is
	   relevant.

	   ie:

	   	cpupri_find(... , struct cpumask *lowest_mask,
	   			  struct cpumask *lowest_mask_filtered)
		// Use lowest_mask_filtered

		fallback:
			// Use lowest_mask

So the way I see it it's not actually making things neater and in my eyes looks
more involved/complex.

Happy to explore this path further if maintainers advocate for it too though.

> 
> The snippet is repeating itself for the whole run of the workload since
> all the rt-tasks run for the same time and I'm only faking big.LITTLE on
> qemu.
> 
> [...]
> 
> >>>  	rcu_read_lock();
> >>>  	for_each_domain(cpu, sd) {
> >>> @@ -1692,11 +1747,15 @@ static int find_lowest_rq(struct task_struct *task)
> >>>  				return this_cpu;
> >>>  			}
> >>>  
> >>> -			best_cpu = cpumask_first_and(lowest_mask,
> >>> -						     sched_domain_span(sd));
> >>> -			if (best_cpu < nr_cpu_ids) {
> >>> -				rcu_read_unlock();
> >>> -				return best_cpu;
> >>> +			for_each_cpu_and(best_cpu, lowest_mask,
> >>> +					 sched_domain_span(sd)) {
> >>> +				if (best_cpu >= nr_cpu_ids)
> >>
> >> Can that happen in this loop?
> > 
> > I kept the condition that was originally here but inverted the logic so we
> > don't mindlessly iterate through the rest of the CPUs. IOW, tried to retain the
> > original behavior of `if (best_cpu < nr_cpu_ids)` logic.
> > 
> > Whether we can remove this check I don't know to be honest. Similar check exist
> > below and I did wonder under what conditions this could happen but didn't try
> > to follow the thread.
> > 
> > The only case I can think about is if we set nr_cpu_ids through command line
> > to a lower value. Then if cpu_possible_mask and family aren't updated
> > accordingly then yeah this check will protect against scheduling on cpus the
> > users said they don't want to use? Just guessing.
> 
> Why don't you build the capacity awareness into cpupri_find(...,
> lowest_mask)?

Hopefully my answer above covered this.

> You would have to add a fallback strategy in case p doesn't fit on any
> CPUs cpupri_find() returns today as lowest_mask. (return the CPU with
> the max capacity).
> 
> Luca proposed something like this for SCHED_DEADLINE in "[RFC PATCH 0/6]
> Capacity awareness for SCHED_DEADLINE" (patch 2/6 and 5/6)
> 
> https://lkml.kernel.org/r/20190506044836.2914-1-luca.abeni@santannapisa.it

It would be nice to keep implementation the similar. I haven't looked closely
at deadline code. I'm not sure if it has similar complexities like RT or not.
I'll have a closer look to see if I can borrow ideas from there.

> 
> In this case you could get rid of all the newly introduced
> rt_task_fits_capacity() logic in find_lowest_rq().
> 
> ---
> 
> I can't see the
> 
> for_each_domain(cpu, sd) {
> 	for_each_cpu_and(best_cpu, lowest_mask, sched_domain_span(sd)) {
>                 ...
> 	}
> }
> 
> other than we want to pick a CPU from the lowest_mask first which is
> closer to task_cpu(task).
> 
> Qemu doesn't give me cluster:
> 
> # cat /proc/sys/kernel/sched_domain/cpu0/domain*/name
> MC

I'm not sure I get what you're trying to get at here. Can you please elaborate
more?

Thanks!

--
Qais Yousef
