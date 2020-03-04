Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 051391792EB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 16:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgCDPBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 10:01:51 -0500
Received: from foss.arm.com ([217.140.110.172]:35468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgCDPBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:01:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B86231B;
        Wed,  4 Mar 2020 07:01:50 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD8FF3F6CF;
        Wed,  4 Mar 2020 07:01:48 -0800 (PST)
Date:   Wed, 4 Mar 2020 15:01:46 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] sched: fair: Use the earliest break even
Message-ID: <20200304150145.agekdwrpvvamttk6@e107158-lin.cambridge.arm.com>
References: <20200304114844.17700-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200304114844.17700-1-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel

Adding Rafael to CC as I think he might be interested in this too.

On 03/04/20 12:48, Daniel Lezcano wrote:
> In the idle CPU selection process occuring in the slow path via the
> find_idlest_group_cpu() function, we pick up in priority an idle CPU
> with the shallowest idle state otherwise we fall back to the least
> loaded CPU.
> 
> In order to be more energy efficient but without impacting the
> performances, let's use another criteria: the break even deadline.

What is the break even deadline?

> 
> At idle time, when we store the idle state the CPU is entering in, we
> compute the next deadline where the CPU could be woken up without
> spending more energy to sleep.

I think that's its definition, but could do with more explanation.

So the break even deadline is the time window during which we can abort the CPU
while entering its shallowest idle state?

So if we have 2 cpus entering the shallowest idle state, we pick the one that
has a faster abort? And the energy saving comes from the fact we avoided
unnecessary sleep-just-to-wakeup-immediately cycle?

> 
> At the selection process, we use the shallowest CPU but in addition we
> choose the one with the minimal break even deadline instead of relying
> on the idle_timestamp. When the CPU is idle, the timestamp has less
> meaning because the CPU could have wake up and sleep again several times
> without exiting the idle loop. In this case the break even deadline is
> more relevant as it increases the probability of choosing a CPU which
> reached its break even.
> 
> Tested on a synquacer 24 cores, 6 sched domains:
> 
> sched/perf and messaging does not show a performance regression. Ran
> 10 times schbench and adrestia.
> 
> with break-even deadline:
> -------------------------
> schbench *99.0th        : 14844.8
> adrestia / periodic     : 57.95
> adrestia / single       : 49.3
> 
> Without break-even deadline:
> ----------------------------
> schbench / *99.0th      : 15017.6
> adrestia / periodic     : 57
> adrestia / single       : 55.4

Lower is better or worse? The numbers might be popular and maybe I should have
known them, but adding some explanation will always help.

Do you have any energy measurement on the impact of this patch?

> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  kernel/sched/fair.c  | 18 ++++++++++++++++--
>  kernel/sched/idle.c  |  9 ++++++++-
>  kernel/sched/sched.h | 20 ++++++++++++++++++++
>  3 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fcc968669aea..520c5e822fdd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5793,6 +5793,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>  {
>  	unsigned long load, min_load = ULONG_MAX;
>  	unsigned int min_exit_latency = UINT_MAX;
> +	s64 min_break_even = S64_MAX;
>  	u64 latest_idle_timestamp = 0;
>  	int least_loaded_cpu = this_cpu;
>  	int shallowest_idle_cpu = -1;
> @@ -5810,6 +5811,8 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>  		if (available_idle_cpu(i)) {
>  			struct rq *rq = cpu_rq(i);
>  			struct cpuidle_state *idle = idle_get_state(rq);
> +			s64 break_even = idle_get_break_even(rq);
> +			
>  			if (idle && idle->exit_latency < min_exit_latency) {
>  				/*
>  				 * We give priority to a CPU whose idle state
> @@ -5817,10 +5820,21 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
>  				 * of any idle timestamp.
>  				 */
>  				min_exit_latency = idle->exit_latency;
> +				min_break_even = break_even;
>  				latest_idle_timestamp = rq->idle_stamp;
>  				shallowest_idle_cpu = i;
> -			} else if ((!idle || idle->exit_latency == min_exit_latency) &&
> -				   rq->idle_stamp > latest_idle_timestamp) {
> +			} else if ((idle && idle->exit_latency == min_exit_latency) &&
> +				   break_even < min_break_even) {
> +				/*
> +				 * We give priority to the shallowest
> +				 * idle states with the minimal break
> +				 * even deadline to decrease the
> +				 * probability to choose a CPU which
> +				 * did not reach its break even yet
> +				 */
> +				min_break_even = break_even;
> +				shallowest_idle_cpu = i;
> +			} else if (!idle && rq->idle_stamp > latest_idle_timestamp) {

Shouldn't you retain the original if condition here? You omitted the 2nd part
of this check compared to the original condition

	(!idle || >>>idle->exit_latency == min_exit_latency<<<)

>  				/*
>  				 * If equal or no active idle state, then
>  				 * the most recently idled CPU might have
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index b743bf38f08f..189cd51cd474 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -19,7 +19,14 @@ extern char __cpuidle_text_start[], __cpuidle_text_end[];
>   */
>  void sched_idle_set_state(struct cpuidle_state *idle_state)
>  {
> -	idle_set_state(this_rq(), idle_state);
> +	struct rq *rq = this_rq();
> +	ktime_t kt;
> +
> +	if (likely(idle_state)) {
> +		kt = ktime_add_ns(ktime_get(), idle_state->exit_latency_ns);
> +		idle_set_state(rq, idle_state);

This changes the behavior of the function.

There's a call to sched_idle_set_state(NULL), so with this it'd be a NOP.

Is this intentional?

Don't you need to reset the break_even value if idle_state is NULL too?


Thanks

--
Qais Yousef

> +		idle_set_break_even(rq, ktime_to_ns(kt));
> +	}
>  }
>  
>  static int __read_mostly cpu_idle_force_poll;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 2a0caf394dd4..abf2d2e73575 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1015,6 +1015,7 @@ struct rq {
>  #ifdef CONFIG_CPU_IDLE
>  	/* Must be inspected within a rcu lock section */
>  	struct cpuidle_state	*idle_state;
> +	s64			break_even;
>  #endif
>  };
>  
> @@ -1850,6 +1851,16 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
>  
>  	return rq->idle_state;
>  }
> +
> +static inline void idle_set_break_even(struct rq *rq, s64 break_even)
> +{
> +	rq->break_even = break_even;
> +}
> +
> +static inline s64 idle_get_break_even(struct rq *rq)
> +{
> +	return rq->break_even;
> +}
>  #else
>  static inline void idle_set_state(struct rq *rq,
>  				  struct cpuidle_state *idle_state)
> @@ -1860,6 +1871,15 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
>  {
>  	return NULL;
>  }
> +
> +static inline void idle_set_break_even(struct rq *rq, s64 break_even)
> +{
> +}
> +
> +static inline s64 idle_get_break_even(struct rq *rq)
> +{
> +	return 0;
> +}
>  #endif
>  
>  extern void schedule_idle(void);
> -- 
> 2.17.1
> 
