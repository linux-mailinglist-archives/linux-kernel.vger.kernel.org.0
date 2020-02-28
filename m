Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 110781734D8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 11:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgB1KCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 05:02:31 -0500
Received: from foss.arm.com ([217.140.110.172]:35868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgB1KCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:02:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 530401FB;
        Fri, 28 Feb 2020 02:02:30 -0800 (PST)
Received: from [10.37.12.207] (unknown [10.37.12.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EEEF3F73B;
        Fri, 28 Feb 2020 02:02:27 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Fix kernel build warning in test_idle_cores()
 for !SMT NUMA
To:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200227140222.GH3818@techsingularity.net>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <9e7a3ed4-82ec-5691-807c-66a8a881f1ef@arm.com>
Date:   Fri, 28 Feb 2020 10:02:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200227140222.GH3818@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/20 2:02 PM, Mel Gorman wrote:
> Building against tip/sched/core as of as ff7db0bf24db ("sched/numa: Prefer
> using an idle CPU as a migration target instead of comparing tasks") with
> the arm64 defconfig (which doesn't have CONFIG_SCHED_SMT set) leads to:
> 
>    kernel/sched/fair.c:1525:20: warning: ‘test_idle_cores’ declared ‘static’ but never defined [-Wunused-function]
>     static inline bool test_idle_cores(int cpu, bool def);
> 		      ^~~~~~~~~~~~~~~
> 
> Rather than define it in its own CONFIG_SCHED_SMT #define island, bunch it
> up with test_idle_cores().
> 
> Fixes: ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a migration target instead of comparing tasks")
> [mgorman@techsingularity.net: Edit changelog, minor style change]
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>   kernel/sched/fair.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fcc968669aea..10f9e6729fcf 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1520,9 +1520,6 @@ static inline bool is_core_idle(int cpu)
>   	return true;
>   }
>   
> -/* Forward declarations of select_idle_sibling helpers */
> -static inline bool test_idle_cores(int cpu, bool def);
> -
>   struct task_numa_env {
>   	struct task_struct *p;
>   
> @@ -1558,9 +1555,11 @@ numa_type numa_classify(unsigned int imbalance_pct,
>   	return node_fully_busy;
>   }
>   
> +#ifdef CONFIG_SCHED_SMT
> +/* Forward declarations of select_idle_sibling helpers */
> +static inline bool test_idle_cores(int cpu, bool def);
>   static inline int numa_idle_core(int idle_core, int cpu)
>   {
> -#ifdef CONFIG_SCHED_SMT
>   	if (!static_branch_likely(&sched_smt_present) ||
>   	    idle_core >= 0 || !test_idle_cores(cpu, false))
>   		return idle_core;
> @@ -1571,10 +1570,15 @@ static inline int numa_idle_core(int idle_core, int cpu)
>   	 */
>   	if (is_core_idle(cpu))
>   		idle_core = cpu;
> -#endif
>   
>   	return idle_core;
>   }
> +#else
> +static inline int numa_idle_core(int idle_core, int cpu)
> +{
> +	return idle_core;
> +}
> +#endif
>   
>   /*
>    * Gather all necessary information to make NUMA balancing placement
> 

Looks good (apart from odd formatting got in '’') and calms down
yesterday's build of next (next-20200227 were I spotted it) and today's
also.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
