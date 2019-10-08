Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A61CCF27E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 08:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfJHGNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 02:13:07 -0400
Received: from foss.arm.com ([217.140.110.172]:55774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbfJHGNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 02:13:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7279D142F;
        Mon,  7 Oct 2019 23:13:06 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C3313F6C4;
        Mon,  7 Oct 2019 23:15:46 -0700 (PDT)
Date:   Tue, 8 Oct 2019 07:13:03 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Alessio Balsini <balsini@android.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: rt: Make RT capacity aware
Message-ID: <20191008061300.qematjkuqmhpuqbj@e107158-lin.cambridge.arm.com>
References: <20190903103329.24961-1-qais.yousef@arm.com>
 <20190904072524.09de28aa@oasis.local.home>
 <20190904154052.ygbhtduzkfj3xs5d@e107158-lin.cambridge.arm.com>
 <f25c1f61-f246-22c7-e627-4c4d39301af2@arm.com>
 <20190918145233.kgntor5nb2gmnczd@e107158-lin.cambridge.arm.com>
 <d307c2f6-f16c-4e9e-0476-91d49d115480@arm.com>
 <20190923115223.a5fwrrxmg5dj765q@e107158-lin.cambridge.arm.com>
 <3e054f2e-75f5-ed87-8640-766828a2fbfb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e054f2e-75f5-ed87-8640-766828a2fbfb@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/19 11:14, Dietmar Eggemann wrote:
> On 23/09/2019 13:52, Qais Yousef wrote:
> > On 09/20/19 14:52, Dietmar Eggemann wrote:
> >>> 	2. The fallback mechanism means we either have to call cpupri_find()
> >>> 	   twice once to find filtered lowest_rq and the other to return the
> >>> 	   none filtered version.
> >>
> >> This is what I have in mind. (Only compile tested! ... and the 'if
> >> (cpumask_any(lowest_mask) >= nr_cpu_ids)' condition has to be considered
> >> as well):
> >>
> >> @@ -98,8 +103,26 @@ int cpupri_find(struct cpupri *cp, struct
> >> task_struct *p,
> >>                         continue;
> >>
> >>                 if (lowest_mask) {
> >> +                       int cpu, max_cap_cpu = -1;
> >> +                       unsigned long max_cap = 0;
> >> +
> >>                         cpumask_and(lowest_mask, p->cpus_ptr, vec->mask);
> >>
> >> +                       for_each_cpu(cpu, lowest_mask) {
> >> +                               unsigned long cap =
> >> arch_scale_cpu_capacity(cpu);
> >> +
> >> +                               if (!rt_task_fits_capacity(p, cpu))
> >> +                                       cpumask_clear_cpu(cpu, lowest_mask);
> >> +
> >> +                               if (cap > max_cap) {
> >> +                                       max_cap = cap;
> >> +                                       max_cap_cpu = cpu;
> >> +                               }
> >> +                       }
> >> +
> >> +                       if (cpumask_empty(lowest_mask) && max_cap)
> >> +                               cpumask_set_cpu(max_cap_cpu, lowest_mask);
> > 
> > I had a patch that I was testing but what I did is to continue rather than
> > return a max_cap_cpu.
> 
> Continuing is the correct thing to do here. I just tried to illustrate
> the idea.
> 
> > e.g:
> > 
> > 	if no cpu at current priority fits the task:
> > 		continue;
> > 	else:
> > 		return the lowest_mask which contains fitting cpus only
> > 
> > 	if no fitting cpu was find:
> > 		return 0;
> 
> I guess this is what we want to achieve here. It's unavoidable that we
> will run sooner (compared to an SMP system) into a situation in which we
> have to go higher in the rd->cpupri->pri_to_cpu[] array or in which we
> can't return a lower mask at all.
> 
> > Or we can tweak your approach to be
> > 
> > 	if no cpu at current priority fits the task:
> > 		if the cpu the task is currently running on doesn't fit it:
> > 			return lowest_mask with max_cap_cpu set;
> 
> I wasn't aware of the pri_to_cpu[] array and how cpupri_find(,
> lowest_mask) tries to return the lowest_mask of the lowest priority
> (pri_to_cpu[] index).
> 
> > So we either:
> > 
> > 	1. Continue the search until we find a fitting CPU; bail out otherwise.
> 
> If this describes the solution in which we concentrate the
> capacity-awareness in cpupri_find(), then I'm OK with it.
> find_lowest_rq() already favours task_cpu(task), this_cpu and finally
> cpus in sched_groups (from the viewpoint of task_cpu(task)).
> 
> > 	2. Or we attempt to return a CPU only if the CPU the task is currently
> > 	   running on doesn't fit it. We don't want to migrate the task from a
> > 	   fitting to a non-fitting one.
> 
> I would prefer 1., keeping the necessary changes confined in
> cpupri_find() if possible.

We are in agreement then.

> 
> > We can also do something hybrid like:
> > 
> > 	3. Remember the outcome of 2 but don't return immediately and attempt
> > 	   to find a fitting CPU at a different priority level.
> > 
> > 
> > Personally I see 1 is the simplest and good enough solution. What do you think?
> 
> Agreed. We would potentially need a fast lookup for p -> uclamp_cpumask
> though?

We can extend task_struct to store a cpumask of the cpus that fit the uclamp
settings and keep it up-to-date whenever the uclamp values change. I did
consider that but it seemed better to keep the implementation confined. I could
have been too conservative - so I'd be happy to look at that.

Thanks

--
Qais Yousef

> 
> > I think this is 'continue' to search makes doing it at cpupri_find() more
> > robust than having to deal with whatever mask we first found in
> > find_lowest_rq() - so I'm starting to like this approach better. Thanks for
> > bringing it up.
> 
> My main concern is that having rt_task_fits_capacity() added to almost
> every condition in the code makes it hard to understand what capacity
> awareness in RT wants to achieve.
> 
> [...]
