Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD21687FB4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 18:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437106AbfHIQVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 12:21:33 -0400
Received: from foss.arm.com ([217.140.110.172]:49872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfHIQVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:21:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 314DE15A2;
        Fri,  9 Aug 2019 09:21:32 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD9AB3F575;
        Fri,  9 Aug 2019 09:21:26 -0700 (PDT)
Subject: Re: [tip:sched/core] sched/fair: Use rq_lock/unlock in
 online_fair_sched_group
To:     pauld@redhat.com, vincent.guittot@linaro.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        linux-tip-commits@vger.kernel.org
References: <20190801133749.11033-1-pauld@redhat.com>
 <tip-6b8fd01b21f5f2701b407a7118f236ba4c41226d@git.kernel.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <dfc8f652-ca98-e30a-546f-e6a2df36e33a@arm.com>
Date:   Fri, 9 Aug 2019 18:21:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <tip-6b8fd01b21f5f2701b407a7118f236ba4c41226d@git.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/19 1:01 PM, tip-bot for Phil Auld wrote:

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 19c58599e967..d9407517dae9 100644
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
> +		rq_lock(rq, &rf);
>  		update_rq_clock(rq);
>  		attach_entity_cfs_rq(se);
>  		sync_throttle(tg, i);
> -		raw_spin_unlock_irq(&rq->lock);
> +		rq_unlock(rq, &rf);
>  	}
>  }

Shouldn't this be:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d9407517dae9..1054d2cf6aaa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10288,11 +10288,11 @@ void online_fair_sched_group(struct task_group
*tg)
        for_each_possible_cpu(i) {
                rq = cpu_rq(i);
                se = tg->se[i];
-               rq_lock(rq, &rf);
+               rq_lock_irq(rq, &rf);
                update_rq_clock(rq);
                attach_entity_cfs_rq(se);
                sync_throttle(tg, i);
-               rq_unlock(rq, &rf);
+               rq_unlock_irq(rq, &rf);
        }
 }

Currently, you should get a 'inconsistent lock state' warning with
CONFIG_PROVE_LOCKING.
