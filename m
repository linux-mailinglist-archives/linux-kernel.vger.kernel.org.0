Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A65DF1893FE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 03:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgCRCY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 22:24:28 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:55920 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbgCRCY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 22:24:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Tsuy4fR_1584498229;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0Tsuy4fR_1584498229)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Mar 2020 10:23:50 +0800
Subject: Re: [PATCH v2] sched: avoid scale real weight down to zero
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <38e8e212-59a1-64b2-b247-b6d0b52d8dc1@linux.alibaba.com>
Message-ID: <234bfc8a-c60d-c375-f681-e4230d8c5a20@linux.alibaba.com>
Date:   Wed, 18 Mar 2020 10:23:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <38e8e212-59a1-64b2-b247-b6d0b52d8dc1@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Vincent

My apologies to missing the case when CONFIG_FAIR_GROUP_SCHED
is disabled, I've replaced the MIN_SHARE with 2UL as it was
defined, sorry for the trouble...

Regards,
Michael Wang

On 2020/3/18 上午10:15, 王贇 wrote:
> During our testing, we found a case that shares no longer
> working correctly, the cgroup topology is like:
> 
>   /sys/fs/cgroup/cpu/A		(shares=102400)
>   /sys/fs/cgroup/cpu/A/B	(shares=2)
>   /sys/fs/cgroup/cpu/A/B/C	(shares=1024)
> 
>   /sys/fs/cgroup/cpu/D		(shares=1024)
>   /sys/fs/cgroup/cpu/D/E	(shares=1024)
>   /sys/fs/cgroup/cpu/D/E/F	(shares=1024)
> 
> The same benchmark is running in group C & F, no other tasks are
> running, the benchmark is capable to consumed all the CPUs.
> 
> We suppose the group C will win more CPU resources since it could
> enjoy all the shares of group A, but it's F who wins much more.
> 
> The reason is because we have group B with shares as 2, since
> A->cfs_rq.load.weight == B->se.load.weight == B->shares/nr_cpus,
> so A->cfs_rq.load.weight become very small.
> 
> And in calc_group_shares() we calculate shares as:
> 
>   load = max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg);
>   shares = (tg_shares * load) / tg_weight;
> 
> Since the 'cfs_rq->load.weight' is too small, the load become 0
> after scale down, although 'tg_shares' is 102400, shares of the se
> which stand for group A on root cfs_rq become 2.
> 
> While the se of D on root cfs_rq is far more bigger than 2, so it
> wins the battle.
> 
> Thus when scale_load_down() scale real weight down to 0, it's no
> longer telling the real story, the caller will have the wrong
> information and the calculation will be buggy.
> 
> This patch add check in scale_load_down(), so the real weight will
> be >= MIN_SHARES after scale, after applied the group C wins as
> expected.
> 
> Cc: Ben Segall <bsegall@google.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> ---
> v2:
>   * replace MIN_SHARE with 2UL to cover CONFIG_FAIR_GROUP_SCHED=n case
> 
>  kernel/sched/sched.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 2a0caf394dd4..9bca26bd60d9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -118,7 +118,13 @@ extern long calc_load_fold_active(struct rq *this_rq, long adjust);
>  #ifdef CONFIG_64BIT
>  # define NICE_0_LOAD_SHIFT	(SCHED_FIXEDPOINT_SHIFT + SCHED_FIXEDPOINT_SHIFT)
>  # define scale_load(w)		((w) << SCHED_FIXEDPOINT_SHIFT)
> -# define scale_load_down(w)	((w) >> SCHED_FIXEDPOINT_SHIFT)
> +# define scale_load_down(w) \
> +({ \
> +	unsigned long __w = (w); \
> +	if (__w) \
> +		__w = max(2UL, __w >> SCHED_FIXEDPOINT_SHIFT); \
> +	__w; \
> +})
>  #else
>  # define NICE_0_LOAD_SHIFT	(SCHED_FIXEDPOINT_SHIFT)
>  # define scale_load(w)		(w)
> 
