Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEF6917251C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 18:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgB0Rax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 12:30:53 -0500
Received: from foss.arm.com ([217.140.110.172]:55242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729948AbgB0Raw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:30:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C50C1FB;
        Thu, 27 Feb 2020 09:30:52 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E41E3F73B;
        Thu, 27 Feb 2020 09:30:51 -0800 (PST)
References: <1582812549.7365.134.camel@lca.pw> <1582814862.7365.135.camel@lca.pw> <jhjimjsvyoe.mognet@arm.com> <1582821327.7365.137.camel@lca.pw> <1582822024.7365.139.camel@lca.pw> <20200227171934.GI3818@techsingularity.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: suspicious RCU due to "Prefer using an idle CPU as a migration target instead of comparing tasks"
In-reply-to: <20200227171934.GI3818@techsingularity.net>
Date:   Thu, 27 Feb 2020 17:30:40 +0000
Message-ID: <jhjeeugvsxr.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27 2020, Mel Gorman wrote:
> Thanks for reporting this!
>
> The proposed fix would be a lot of rcu locks and unlocks. While they are
> cheap, they're not free and it's a fairly standard pattern to acquire
> the rcu lock when scanning CPUs during a domain search (load balancing,
> nohz balance, idle balance etc). While in this context the lock is only
> needed for SMT, I do not think it's worthwhile fine-graining this or
> conditionally acquiring the rcu lock so will we keep it simple?
>
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 11cdba201425..d34ac4ea5cee 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1592,6 +1592,7 @@ static void update_numa_stats(struct task_numa_env *env,
>       memset(ns, 0, sizeof(*ns));
>       ns->idle_cpu = -1;
>
> +	rcu_read_lock();
>       for_each_cpu(cpu, cpumask_of_node(nid)) {
>               struct rq *rq = cpu_rq(cpu);
>
> @@ -1611,6 +1612,7 @@ static void update_numa_stats(struct task_numa_env *env,
>                       idle_core = numa_idle_core(idle_core, cpu);
>               }
>       }
> +	rcu_read_unlock();
>
>       ns->weight = cpumask_weight(cpumask_of_node(nid));
>


That's closer to what I was trying to suggest (i.e. broaden the section
rather than reduce it).
