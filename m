Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67273DAD5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 05:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfD2Dgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Apr 2019 23:36:33 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:36970 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbfD2Dgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 23:36:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0TQTCbEl_1556508982;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TQTCbEl_1556508982)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 29 Apr 2019 11:36:28 +0800
Date:   Mon, 29 Apr 2019 11:36:22 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
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
Subject: Re: [RFC PATCH v2 11/17] sched: Basic tracking of matching tasks
Message-ID: <20190429033620.GA128241@aaronlu>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <2364f2b65bf50826d881c84d7634b6565dfee527.1556025155.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2364f2b65bf50826d881c84d7634b6565dfee527.1556025155.git.vpillai@digitalocean.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 04:18:16PM +0000, Vineeth Remanan Pillai wrote:
> +/*
> + * l(a,b)
> + * le(a,b) := !l(b,a)
> + * g(a,b)  := l(b,a)
> + * ge(a,b) := !l(a,b)
> + */
> +
> +/* real prio, less is less */
> +static inline bool __prio_less(struct task_struct *a, struct task_struct *b, bool core_cmp)
> +{
> +	u64 vruntime;
> +
> +	int pa = __task_prio(a), pb = __task_prio(b);
> +
> +	if (-pa < -pb)
> +		return true;
> +
> +	if (-pb < -pa)
> +		return false;
> +
> +	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
> +		return !dl_time_before(a->dl.deadline, b->dl.deadline);
> +
> +	vruntime = b->se.vruntime;
> +	if (core_cmp) {
> +		vruntime -= task_cfs_rq(b)->min_vruntime;
> +		vruntime += task_cfs_rq(a)->min_vruntime;
> +	}
> +	if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
> +		return !((s64)(a->se.vruntime - vruntime) <= 0);
> +
> +	return false;
> +}

This unfortunately still doesn't work.

Consider the following task layout on two sibling CPUs(cpu0 and cpu1):

    rq0.cfs_rq    rq1.cfs_rq
        |             |
     se_bash        se_hog

se_hog is the sched_entity for a cpu intensive task and se_bash is the
sched_entity for bash.

There are two problems:
1 SCHED_DEBIT
when user execute some commands through bash, say ls, bash will fork.
The newly forked ls' vruntime is set in the future due to SCHED_DEBIT.
This made 'ls' lose in __prio_less() when compared with hog, whose
vruntime may very likely be the same as its cfs_rq's min_vruntime.

This is OK since we do not want forked process to starve already running
ones. The problem is, since hog keeps running, its vruntime will always
sync with its cfs_rq's min_vruntime. OTOH, 'ls' can not run, its
cfs_rq's min_vruntime doesn't proceed, making 'ls' always lose to hog.

2 who schedules, who wins
so I disabled SCHED_DEBIT, for testing's purpose. When cpu0 schedules,
ls could win where both sched_entity's vruntime is the same as their
cfs_rqs' min_vruntime. So does hog: when cpu1 schedules, hog can preempt
ls in the same way. The end result is, interactive task can lose to cpu
intensive task and ls can feel "dead".

I haven't figured out a way to solve this yet. A core wide cfs_rq's
min_vruntime can probably solve this. Your suggestions are appreciated.
