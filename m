Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 071E01623FD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 10:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgBRJyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 04:54:16 -0500
Received: from foss.arm.com ([217.140.110.172]:48864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgBRJyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:54:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49AB91FB;
        Tue, 18 Feb 2020 01:54:15 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C04E63F6CF;
        Tue, 18 Feb 2020 01:54:13 -0800 (PST)
Subject: Re: [PATCH 1/3] sched/rt: cpupri_find: implement fallback mechanism
 for !fit case
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <20200214163949.27850-1-qais.yousef@arm.com>
 <20200214163949.27850-2-qais.yousef@arm.com>
 <c0772fca-0a4b-c88d-fdf2-5715fcf8447b@arm.com>
 <20200217234549.rpv3ns7bd7l6twqu@e107158-lin>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <50eee4ae-a733-d8e4-9f57-ab05678545fc@arm.com>
Date:   Tue, 18 Feb 2020 10:53:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217234549.rpv3ns7bd7l6twqu@e107158-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2020 00:45, Qais Yousef wrote:
> On 02/17/20 20:09, Dietmar Eggemann wrote:
>> On 14/02/2020 17:39, Qais Yousef wrote:
>>
>> [...]
>>
>>>  /**
>>>   * cpupri_find - find the best (lowest-pri) CPU in the system
>>>   * @cp: The cpupri context
>>> @@ -62,80 +115,72 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
>>>  		struct cpumask *lowest_mask,
>>>  		bool (*fitness_fn)(struct task_struct *p, int cpu))
>>>  {
>>> -	int idx = 0;
>>>  	int task_pri = convert_prio(p->prio);
>>> +	int best_unfit_idx = -1;
>>> +	int idx = 0, cpu;
>>>  
>>>  	BUG_ON(task_pri >= CPUPRI_NR_PRIORITIES);
>>>  
>>>  	for (idx = 0; idx < task_pri; idx++) {
>>> -		struct cpupri_vec *vec  = &cp->pri_to_cpu[idx];
>>> -		int skip = 0;
>>>  
>>> -		if (!atomic_read(&(vec)->count))
>>> -			skip = 1;
>>> -		/*
>>> -		 * When looking at the vector, we need to read the counter,
>>> -		 * do a memory barrier, then read the mask.
>>> -		 *
>>> -		 * Note: This is still all racey, but we can deal with it.
>>> -		 *  Ideally, we only want to look at masks that are set.
>>> -		 *
>>> -		 *  If a mask is not set, then the only thing wrong is that we
>>> -		 *  did a little more work than necessary.
>>> -		 *
>>> -		 *  If we read a zero count but the mask is set, because of the
>>> -		 *  memory barriers, that can only happen when the highest prio
>>> -		 *  task for a run queue has left the run queue, in which case,
>>> -		 *  it will be followed by a pull. If the task we are processing
>>> -		 *  fails to find a proper place to go, that pull request will
>>> -		 *  pull this task if the run queue is running at a lower
>>> -		 *  priority.
>>> -		 */
>>> -		smp_rmb();
>>> -
>>> -		/* Need to do the rmb for every iteration */
>>> -		if (skip)
>>> -			continue;
>>> -
>>> -		if (cpumask_any_and(p->cpus_ptr, vec->mask) >= nr_cpu_ids)
>>> +		if (!__cpupri_find(cp, p, lowest_mask, idx))
>>>  			continue;
>>>  
>>> -		if (lowest_mask) {
>>> -			int cpu;
>>
>> Shouldn't we add an extra condition here?
>>
>> +               if (!static_branch_unlikely(&sched_asym_cpucapacity))
>> +                       return 1;
>> +
>>
>> Otherwise non-heterogeneous systems have to got through this
>> for_each_cpu(cpu, lowest_mask) further below for no good reason.
> 
> Hmm below is the best solution I can think of at the moment. Works for you?
> 
> It's independent of what this patch tries to fix, so I'll add as a separate
> patch to the series in the next update.

OK.

Since we can't set it as early as init_sched_rt_class()

root@juno:~# dmesg | grep "\*\*\*"
[    0.501697] *** set sched_asym_cpucapacity <-- CPU cap asym by uArch
[    0.505847] *** init_sched_rt_class()
[    1.796706] *** set sched_asym_cpucapacity <-- CPUfreq kicked in

we probably have to do it either by bailing out of cpupri_find() early
with this extra condition (above) or by initializing the func pointer
dynamically (your example).

[...]

> @@ -1708,6 +1710,7 @@ static int find_lowest_rq(struct task_struct *task)
>         struct cpumask *lowest_mask = this_cpu_cpumask_var_ptr(local_cpu_mask);
>         int this_cpu = smp_processor_id();
>         int cpu      = task_cpu(task);
> +       fitness_fn_t fitness_fn;
> 
>         /* Make sure the mask is initialized first */
>         if (unlikely(!lowest_mask))
> @@ -1716,8 +1719,17 @@ static int find_lowest_rq(struct task_struct *task)
>         if (task->nr_cpus_allowed == 1)
>                 return -1; /* No other targets possible */
> 
> +       /*
> +        * Help cpupri_find avoid the cost of looking for a fitting CPU when
> +        * not really needed.
> +        */

In case the commend is really needed, for me it would work better
logically inverse.

[...]
