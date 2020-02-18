Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 668FF162AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 17:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgBRQrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 11:47:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:32838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgBRQrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:47:01 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8E15208C4;
        Tue, 18 Feb 2020 16:46:59 +0000 (UTC)
Date:   Tue, 18 Feb 2020 11:46:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/rt: cpupri_find: implement fallback mechanism
 for !fit case
Message-ID: <20200218114658.74236b3c@gandalf.local.home>
In-Reply-To: <20200217234549.rpv3ns7bd7l6twqu@e107158-lin>
References: <20200214163949.27850-1-qais.yousef@arm.com>
        <20200214163949.27850-2-qais.yousef@arm.com>
        <c0772fca-0a4b-c88d-fdf2-5715fcf8447b@arm.com>
        <20200217234549.rpv3ns7bd7l6twqu@e107158-lin>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 23:45:49 +0000
Qais Yousef <qais.yousef@arm.com> wrote:

> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -14,6 +14,8 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
> 
>  struct rt_bandwidth def_rt_bandwidth;
> 
> +typedef bool (*fitness_fn_t)(struct task_struct *p, int cpu);
> +
>  static enum hrtimer_restart sched_rt_period_timer(struct hrtimer *timer)
>  {
>         struct rt_bandwidth *rt_b =
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
> +       if (static_branch_unlikely(&sched_asym_cpucapacity))
> +               fitness_fn = rt_task_fits_capacity;
> +       else
> +               fitness_fn = NULL;
> +
>         if (!cpupri_find(&task_rq(task)->rd->cpupri, task, lowest_mask,
> -                        rt_task_fits_capacity))
> +                        fitness_fn))
>                 return -1; /* No targets found */
> 
>         /*


If we are going to use static branches, then lets just remove the
parameter totally. That is, make two functions (with helpers), where
one needs this fitness function the other does not.

	if (static_branch_unlikely(&sched_asym_cpu_capacity))
		ret = cpupri_find_fitness(...);
	else
		ret = cpupri_find(...);

	if (!ret)
		return -1;

Something like that?

-- Steve
