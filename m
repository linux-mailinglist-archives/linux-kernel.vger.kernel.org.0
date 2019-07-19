Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284826E622
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 15:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfGSNNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 09:13:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51918 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbfGSNNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R8CHtZotJfwBOkWhtpvqusr0kSsOrStTm7h1H2oxd18=; b=nYbIXYFXh6er0KuzU0gYkY6Y6
        JsO4ajRSAHwcttM/f+bd9lAhE6vZYMHtN39SYwIC+8vgBdjrQZyDvBjLL8uOVZr2FgchLGHdRA79U
        4y5i5GpSpRPvUgCw+dJoVcUJ5mrwxgCnPWSG6g/5F5WvKD5dYILkXXWDJ6ZWVgBbaCeeqipWtoA3P
        sZcBG9b/f7ngxHd/CdAKkd3DkoyI+GEZHoiFQzEWDAii0nTMl2YNG0BOE68b+lR0ucSyVzVSxi3LS
        JQmwqlNQ0gCKEv1G0rSgvCjV+3ELaIHvVSpcXx3a0Xq6ZkbRLpQPX3rhfAGqA+MdEc8sx2MPsX6qu
        iHWqn3TyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hoSgy-0007vs-IC; Fri, 19 Jul 2019 13:12:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5158020B99A76; Fri, 19 Jul 2019 15:12:55 +0200 (CEST)
Date:   Fri, 19 Jul 2019 15:12:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, pauld@redhat.com
Subject: Re: [PATCH 3/5] sched/fair: rework load_balance
Message-ID: <20190719131255.GL3419@hirez.programming.kicks-ass.net>
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 09:58:23AM +0200, Vincent Guittot wrote:

> @@ -8029,17 +8063,24 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		}
>  	}
>  
> -	/* Adjust by relative CPU capacity of the group */
> -	sgs->group_capacity = group->sgc->capacity;
> -	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
> +	/* Check if dst cpu is idle and preferred to this group */
> +	if (env->sd->flags & SD_ASYM_PACKING &&
> +	    env->idle != CPU_NOT_IDLE &&
> +	    sgs->sum_h_nr_running &&
> +	    sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
> +		sgs->group_asym_capacity = 1;
> +	}
>  
> -	if (sgs->sum_h_nr_running)
> -		sgs->load_per_task = sgs->group_load / sgs->sum_h_nr_running;
> +	sgs->group_capacity = group->sgc->capacity;
>  
>  	sgs->group_weight = group->group_weight;
>  
> -	sgs->group_no_capacity = group_is_overloaded(env, sgs);
> -	sgs->group_type = group_classify(group, sgs);
> +	sgs->group_type = group_classify(env, group, sgs);
> +
> +	/* Computing avg_load makes sense only when group is overloaded */
> +	if (sgs->group_type != group_overloaded)

The comment seems to suggest you meant: ==

> +		sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) /
> +				sgs->group_capacity;
>  }
>  
>  /**
> @@ -8070,7 +8111,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  	 */
>  	if (sgs->group_type == group_misfit_task &&
>  	    (!group_smaller_max_cpu_capacity(sg, sds->local) ||
> -	     !group_has_capacity(env, &sds->local_stat)))
> +	     sds->local_stat.group_type != group_has_spare))
>  		return false;
>  
>  	if (sgs->group_type > busiest->group_type)
> @@ -8079,11 +8120,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  	if (sgs->group_type < busiest->group_type)
>  		return false;
>  
> -	if (sgs->avg_load <= busiest->avg_load)
> +	/* Select the overloaded group with highest avg_load */
> +	if (sgs->group_type == group_overloaded &&
> +	    sgs->avg_load <= busiest->avg_load)

And this code does too; because with the above '!=', you're comparing
uninitialized data here, no?

> +		return false;
> +
> +	/* Prefer to move from lowest priority CPU's work */
> +	if (sgs->group_type == group_asym_capacity && sds->busiest &&
> +	    sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
>  		return false;
>  
>  	if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
> -		goto asym_packing;
> +		goto spare_capacity;
>  
>  	/*
>  	 * Candidate sg has no more than one task per CPU and
