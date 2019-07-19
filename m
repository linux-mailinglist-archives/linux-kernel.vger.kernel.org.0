Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01B146E643
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 15:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfGSNWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 09:22:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51954 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfGSNWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=heSgUEgwwZVwPRlcrwuAKV3YHsVoFYbXW0qS0nSCgqs=; b=ANfG1lWgiuD3mxhc0B4YGgTSn
        FzY2QgfvQiNKpQrX/hO4NwPgtkef526MS0GJf/n05m5eBvGtRCKwzPg7WXM0P92t7JkpuKOatO9WO
        CwqhkKDOEYrY+8ZL8M7Q+lMLvCHIfPzc8W3boH1/qQQKaiITbooQXRVp5lpSA5f3+KlVFdzhyToFk
        N4MxVWV9+6GLUyl9+4Jwa/JNuZNgk/7DabvMpRFqQ5Xa/ATNLIuYelDId4Ke4OJDZTQnfxw3DE8yE
        40fekNNwSF7nojXxiYxWwQURTP0OJ1o0CyuVA6msp5DG/yw2DtsGfue1NR3GlmfLgO5oADVTEHqRj
        J17h+tL1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hoSpt-00081n-6T; Fri, 19 Jul 2019 13:22:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC08F20B4B7AC; Fri, 19 Jul 2019 15:22:07 +0200 (CEST)
Date:   Fri, 19 Jul 2019 15:22:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, pauld@redhat.com
Subject: Re: [PATCH 3/5] sched/fair: rework load_balance
Message-ID: <20190719132207.GM3419@hirez.programming.kicks-ass.net>
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
>  enum group_type {
> -	group_other = 0,
> +	group_has_spare = 0,
> +	group_fully_busy,
>  	group_misfit_task,
> +	group_asym_capacity,
>  	group_imbalanced,
>  	group_overloaded,
>  };

The order of this group_type is important, maybe add a few words on how
this order got to be.

>  static inline enum
> -group_type group_classify(struct sched_group *group,
> +group_type group_classify(struct lb_env *env,
> +			  struct sched_group *group,
>  			  struct sg_lb_stats *sgs)
>  {
> -	if (sgs->group_no_capacity)
> +	if (group_is_overloaded(env, sgs))
>  		return group_overloaded;
>  
>  	if (sg_imbalanced(group))
> @@ -7953,7 +7975,13 @@ group_type group_classify(struct sched_group *group,
>  	if (sgs->group_misfit_task_load)
>  		return group_misfit_task;
>  
> -	return group_other;
> +	if (sgs->group_asym_capacity)
> +		return group_asym_capacity;
> +
> +	if (group_has_capacity(env, sgs))
> +		return group_has_spare;
> +
> +	return group_fully_busy;
>  }

OCD is annoyed that this function doesn't have the same / reverse order
of the one in the enum.

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

from reading the patch it wasn't obvious that at this point
sgs->group_type == busiest->group_type, and I wondered if
busiest->avg_load below was pointing to garbage, it isn't.

> -	if (sgs->avg_load <= busiest->avg_load)
> +	/* Select the overloaded group with highest avg_load */
> +	if (sgs->group_type == group_overloaded &&
> +	    sgs->avg_load <= busiest->avg_load)
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

Can we do a switch (sds->group_type) here? it seems to have most of them
listed.
