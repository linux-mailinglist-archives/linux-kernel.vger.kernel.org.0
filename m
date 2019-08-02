Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75E1A7FC2D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 16:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394886AbfHBO1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 10:27:22 -0400
Received: from foss.arm.com ([217.140.110.172]:52790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfHBO1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:27:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D47C1570;
        Fri,  2 Aug 2019 07:27:21 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC2593F575;
        Fri,  2 Aug 2019 07:27:19 -0700 (PDT)
Subject: Re: [PATCH v3] sched/fair: use utilization to select misfit task
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, Thomas Gleixner <tglx@linutronix.de>
References: <1564670424-26023-9-git-send-email-vincent.guittot@linaro.org>
 <1564750572-20251-1-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <af73850c-5f62-3688-8892-907a84cabafc@arm.com>
Date:   Fri, 2 Aug 2019 15:27:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564750572-20251-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2019 13:56, Vincent Guittot wrote:
> utilization is used to detect a misfit task but the load is then used to
> select the task on the CPU which can lead to select a small task with
> high weight instead of the task that triggered the misfit migration.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> Keep tracking load instead of utilization but check that 
> task doesn't fit CPU's capacity when selecting the task to detach as
> suggested by Valentin 
> 

I find that one much better :) The very same fix could be applied
regardless of the rework, so FWIW (providing the changelog gets a bit
clearer - maybe squash the comment in it):
Acked-by: Valentin Schneider <valentin.schneider@arm.com>


One more thing though: we actually face the same problem in active balance,
i.e. the misfit task could sleep/get preempted before the CPU stopper
actually runs, and that latter would migrate $random.

I was thinking of passing the lb_env to stop_one_cpu_nowait() - we'd have
to rebuild it in active_load_balance_cpu_stop() anyway, but we could copy
things like env.migration_type so that we remember that we should be
picking a misfit task and have a similar detach guard.

Sadly, the lb_env struct is on load_balance()'s stack, and that's a nowait
call :/

Peter/Thomas, would there be much hate in adding some sort of flags field
to struct cpu_stop_work? Or if you see a better alternative, I'm all ears.


>  kernel/sched/fair.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 53e64a7..8496118 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7487,15 +7487,9 @@ static int detach_tasks(struct lb_env *env)
>  			break;
>  
>  		case migrate_misfit:
> -			load = task_h_load(p);
> -
> -			/*
> -			 * utilization of misfit task might decrease a bit
> -			 * since it has been recorded. Be conservative in the
> -			 * condition.
> -			 */
> -			if (load < env->imbalance)
> -				goto next;
> +			/* This is not a misfit task */
> +                       if (task_fits_capacity(p, capacity_of(env->src_cpu)))
> +			       goto next;
>  
>  			env->imbalance = 0;
>  			break;
> 
