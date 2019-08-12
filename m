Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79CAB89F55
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 15:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfHLNNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 09:13:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728887AbfHLNNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:13:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F06AC7BDAE;
        Mon, 12 Aug 2019 13:13:15 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C3EF17B46;
        Mon, 12 Aug 2019 13:13:15 +0000 (UTC)
Date:   Mon, 12 Aug 2019 09:13:13 -0400
From:   Phil Auld <pauld@redhat.com>
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, mingo@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org
Subject: Re: [tip:sched/core] sched/fair: Use rq_lock/unlock in
 online_fair_sched_group
Message-ID: <20190812131313.GA11058@pauld.bos.csb>
References: <20190801133749.11033-1-pauld@redhat.com>
 <tip-a46d14eca7b75fffe35603aa8b81df654353d80f@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-a46d14eca7b75fffe35603aa8b81df654353d80f@git.kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 12 Aug 2019 13:13:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 05:52:04AM -0700 tip-bot for Phil Auld wrote:
> Commit-ID:  a46d14eca7b75fffe35603aa8b81df654353d80f
> Gitweb:     https://git.kernel.org/tip/a46d14eca7b75fffe35603aa8b81df654353d80f
> Author:     Phil Auld <pauld@redhat.com>
> AuthorDate: Thu, 1 Aug 2019 09:37:49 -0400
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Mon, 12 Aug 2019 14:45:34 +0200
> 
> sched/fair: Use rq_lock/unlock in online_fair_sched_group
> 
> Enabling WARN_DOUBLE_CLOCK in /sys/kernel/debug/sched_features causes
> warning to fire in update_rq_clock. This seems to be caused by onlining
> a new fair sched group not using the rq lock wrappers.
> 
>   [] rq->clock_update_flags & RQCF_UPDATED
>   [] WARNING: CPU: 5 PID: 54385 at kernel/sched/core.c:210 update_rq_clock+0xec/0x150
> 
>   [] Call Trace:
>   []  online_fair_sched_group+0x53/0x100
>   []  cpu_cgroup_css_online+0x16/0x20
>   []  online_css+0x1c/0x60
>   []  cgroup_apply_control_enable+0x231/0x3b0
>   []  cgroup_mkdir+0x41b/0x530
>   []  kernfs_iop_mkdir+0x61/0xa0
>   []  vfs_mkdir+0x108/0x1a0
>   []  do_mkdirat+0x77/0xe0
>   []  do_syscall_64+0x55/0x1d0
>   []  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Using the wrappers in online_fair_sched_group instead of the raw locking
> removes this warning.
> 
> [ tglx: Use rq_*lock_irq() ]
> 
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Link: https://lkml.kernel.org/r/20190801133749.11033-1-pauld@redhat.com
> ---
>  kernel/sched/fair.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 19c58599e967..1054d2cf6aaa 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10281,18 +10281,18 @@ err:
>  void online_fair_sched_group(struct task_group *tg)
>  {
>  	struct sched_entity *se;
> +	struct rq_flags rf;
>  	struct rq *rq;
>  	int i;
>  
>  	for_each_possible_cpu(i) {
>  		rq = cpu_rq(i);
>  		se = tg->se[i];
> -
> -		raw_spin_lock_irq(&rq->lock);
> +		rq_lock_irq(rq, &rf);
>  		update_rq_clock(rq);
>  		attach_entity_cfs_rq(se);
>  		sync_throttle(tg, i);
> -		raw_spin_unlock_irq(&rq->lock);
> +		rq_unlock_irq(rq, &rf);
>  	}
>  }
>  

Thanks Thomas!

-- 

