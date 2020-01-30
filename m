Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CC014DB0D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 13:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgA3MzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 07:55:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43618 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3MzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:55:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so3868076wre.10;
        Thu, 30 Jan 2020 04:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oYvcmUjSmLBUQ9U5VYc0aSLEVqma0gKOwWNxEUmmA20=;
        b=sPQ6x09r3kyPDssq7UTetnRy82leK1vvtJ6BBfUr5xZcB1bfuEgCdCLuwWofUcmehw
         H5cte50SpobEJD8jmBqEAsZfiXMRKbG+DTDPmZNJ8j/cseMcACtOZvF9siPQBr5x239A
         0HqvRELihi1qLrVCvV8SNBm8FAiXWpdj58hSze/CwEDhH5P8HbN3itSj88/f0xGESC61
         SmQ0O2V/WhPylXSs70M9jqnn2wMD0XaGHzQfVkwjZM9gWv562jdhj1LHgJwzOzA1/hgP
         qYLf6DltuV/pdEEKVL5VLqmKeogxb1gAaDs29eUFhRJSxX8Ueovb+mUBmcktSDT73HKd
         kyfA==
X-Gm-Message-State: APjAAAVnvyT19dTcrZmzWJyM6lmiR0+uNncsRWct/Mhdf/xRNcn2W/v/
        E66jR4UYe6hyYQzlR8L/fvM=
X-Google-Smtp-Source: APXvYqzFIK6la+Pc01qIm05eJVN1m6wNbazLvMGwS3c2BqV2o00UIYhJL+QJQYg3qkxz/6TyUVfwog==
X-Received: by 2002:adf:e906:: with SMTP id f6mr586169wrm.258.1580388897911;
        Thu, 30 Jan 2020 04:54:57 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id g7sm7189301wrq.21.2020.01.30.04.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 04:54:56 -0800 (PST)
Date:   Thu, 30 Jan 2020 13:54:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/3] mm: memcontrol: clean up and document effective
 low/min calculations
Message-ID: <20200130125455.GV24244@dhcp22.suse.cz>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-3-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219200718.15696-3-hannes@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-12-19 15:07:17, Johannes Weiner wrote:
> The effective protection of any given cgroup is a somewhat complicated
> construct that depends on the ancestor's configuration, siblings'
> configurations, as well as current memory utilization in all these
> groups. It's done this way to satisfy hierarchical delegation
> requirements while also making the configuration semantics flexible
> and expressive in complex real life scenarios.
> 
> Unfortunately, all the rules and requirements are sparsely documented,
> and the code is a little too clever in merging different scenarios
> into a single min() expression. This makes it hard to reason about the
> implementation and avoid breaking semantics when making changes to it.
> 
> This patch documents each semantic rule individually and splits out
> the handling of the overcommit case from the regular case.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

It took me a while to double check that the new code is indeed
equivalent but the result is easier to grasp indeed.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 190 ++++++++++++++++++++++++++----------------------
>  1 file changed, 104 insertions(+), 86 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 874a0b00f89b..9c771c4d6339 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6204,65 +6204,55 @@ struct cgroup_subsys memory_cgrp_subsys = {
>  	.early_init = 0,
>  };
>  
> -/**
> - * mem_cgroup_protected - check if memory consumption is in the normal range
> - * @root: the top ancestor of the sub-tree being checked
> - * @memcg: the memory cgroup to check
> - *
> - * WARNING: This function is not stateless! It can only be used as part
> - *          of a top-down tree iteration, not for isolated queries.
> - *
> - * Returns one of the following:
> - *   MEMCG_PROT_NONE: cgroup memory is not protected
> - *   MEMCG_PROT_LOW: cgroup memory is protected as long there is
> - *     an unprotected supply of reclaimable memory from other cgroups.
> - *   MEMCG_PROT_MIN: cgroup memory is protected
> - *
> - * @root is exclusive; it is never protected when looked at directly
> +/*
> + * This function calculates an individual cgroup's effective
> + * protection which is derived from its own memory.min/low, its
> + * parent's and siblings' settings, as well as the actual memory
> + * distribution in the tree.
>   *
> - * To provide a proper hierarchical behavior, effective memory.min/low values
> - * are used. Below is the description of how effective memory.low is calculated.
> - * Effective memory.min values is calculated in the same way.
> + * The following rules apply to the effective protection values:
>   *
> - * Effective memory.low is always equal or less than the original memory.low.
> - * If there is no memory.low overcommittment (which is always true for
> - * top-level memory cgroups), these two values are equal.
> - * Otherwise, it's a part of parent's effective memory.low,
> - * calculated as a cgroup's memory.low usage divided by sum of sibling's
> - * memory.low usages, where memory.low usage is the size of actually
> - * protected memory.
> + * 1. At the first level of reclaim, effective protection is equal to
> + *    the declared protection in memory.min and memory.low.
>   *
> - *                                             low_usage
> - * elow = min( memory.low, parent->elow * ------------------ ),
> - *                                        siblings_low_usage
> + * 2. To enable safe delegation of the protection configuration, at
> + *    subsequent levels the effective protection is capped to the
> + *    parent's effective protection.
>   *
> - * low_usage = min(memory.low, memory.current)
> + * 3. To make complex and dynamic subtrees easier to configure, the
> + *    user is allowed to overcommit the declared protection at a given
> + *    level. If that is the case, the parent's effective protection is
> + *    distributed to the children in proportion to how much protection
> + *    they have declared and how much of it they are utilizing.
>   *
> + *    This makes distribution proportional, but also work-conserving:
> + *    if one cgroup claims much more protection than it uses memory,
> + *    the unused remainder is available to its siblings.
>   *
> - * Such definition of the effective memory.low provides the expected
> - * hierarchical behavior: parent's memory.low value is limiting
> - * children, unprotected memory is reclaimed first and cgroups,
> - * which are not using their guarantee do not affect actual memory
> - * distribution.
> + *    Consider the following example tree:
>   *
> - * For example, if there are memcgs A, A/B, A/C, A/D and A/E:
> + *        A      A/memory.low = 2G, A/memory.current = 6G
> + *       //\\
> + *      BC  DE   B/memory.low = 3G  B/memory.current = 2G
> + *               C/memory.low = 1G  C/memory.current = 2G
> + *               D/memory.low = 0   D/memory.current = 2G
> + *               E/memory.low = 10G E/memory.current = 0
>   *
> - *     A      A/memory.low = 2G, A/memory.current = 6G
> - *    //\\
> - *   BC  DE   B/memory.low = 3G  B/memory.current = 2G
> - *            C/memory.low = 1G  C/memory.current = 2G
> - *            D/memory.low = 0   D/memory.current = 2G
> - *            E/memory.low = 10G E/memory.current = 0
> + *    and memory pressure is applied, the following memory
> + *    distribution is expected (approximately*):
>   *
> - * and the memory pressure is applied, the following memory distribution
> - * is expected (approximately):
> + *      A/memory.current = 2G
> + *      B/memory.current = 1.3G
> + *      C/memory.current = 0.6G
> + *      D/memory.current = 0
> + *      E/memory.current = 0
>   *
> - *     A/memory.current = 2G
> + *    *assuming equal allocation rate and reclaimability
>   *
> - *     B/memory.current = 1.3G
> - *     C/memory.current = 0.6G
> - *     D/memory.current = 0
> - *     E/memory.current = 0
> + * 4. Conversely, when the declared protection is undercommitted at a
> + *    given level, the distribution of the larger parental protection
> + *    budget is NOT proportional. A cgroup's protection from a sibling
> + *    is capped to its own memory.min/low setting.
>   *
>   * These calculations require constant tracking of the actual low usages
>   * (see propagate_protected_usage()), as well as recursive calculation of
> @@ -6272,12 +6262,63 @@ struct cgroup_subsys memory_cgrp_subsys = {
>   * for next usage. This part is intentionally racy, but it's ok,
>   * as memory.low is a best-effort mechanism.
>   */
> +static unsigned long effective_protection(unsigned long usage,
> +					  unsigned long setting,
> +					  unsigned long parent_effective,
> +					  unsigned long siblings_protected)
> +{
> +	unsigned long protected;
> +
> +	protected = min(usage, setting);
> +	/*
> +	 * If all cgroups at this level combined claim and use more
> +	 * protection then what the parent affords them, distribute
> +	 * shares in proportion to utilization.
> +	 *
> +	 * We are using actual utilization rather than the statically
> +	 * claimed protection in order to be work-conserving: claimed
> +	 * but unused protection is available to siblings that would
> +	 * otherwise get a smaller chunk than what they claimed.
> +	 */
> +	if (siblings_protected > parent_effective)
> +		return protected * parent_effective / siblings_protected;
> +
> +	/*
> +	 * Ok, utilized protection of all children is within what the
> +	 * parent affords them, so we know whatever this child claims
> +	 * and utilizes is effectively protected.
> +	 *
> +	 * If there is unprotected usage beyond this value, reclaim
> +	 * will apply pressure in proportion to that amount.
> +	 *
> +	 * If there is unutilized protection, the cgroup will be fully
> +	 * shielded from reclaim, but we do return a smaller value for
> +	 * protection than what the group could enjoy in theory. This
> +	 * is okay. With the overcommit distribution above, effective
> +	 * protection is always dependent on how memory is actually
> +	 * consumed among the siblings anyway.
> +	 */
> +	return protected;
> +}
> +
> +/**
> + * mem_cgroup_protected - check if memory consumption is in the normal range
> + * @root: the top ancestor of the sub-tree being checked
> + * @memcg: the memory cgroup to check
> + *
> + * WARNING: This function is not stateless! It can only be used as part
> + *          of a top-down tree iteration, not for isolated queries.
> + *
> + * Returns one of the following:
> + *   MEMCG_PROT_NONE: cgroup memory is not protected
> + *   MEMCG_PROT_LOW: cgroup memory is protected as long there is
> + *     an unprotected supply of reclaimable memory from other cgroups.
> + *   MEMCG_PROT_MIN: cgroup memory is protected
> + */
>  enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>  						struct mem_cgroup *memcg)
>  {
>  	struct mem_cgroup *parent;
> -	unsigned long emin, parent_emin;
> -	unsigned long elow, parent_elow;
>  	unsigned long usage;
>  
>  	if (mem_cgroup_disabled())
> @@ -6292,52 +6333,29 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>  	if (!usage)
>  		return MEMCG_PROT_NONE;
>  
> -	emin = memcg->memory.min;
> -	elow = memcg->memory.low;
> -
>  	parent = parent_mem_cgroup(memcg);
>  	/* No parent means a non-hierarchical mode on v1 memcg */
>  	if (!parent)
>  		return MEMCG_PROT_NONE;
>  
> -	if (parent == root)
> -		goto exit;
> -
> -	parent_emin = READ_ONCE(parent->memory.emin);
> -	emin = min(emin, parent_emin);
> -	if (emin && parent_emin) {
> -		unsigned long min_usage, siblings_min_usage;
> -
> -		min_usage = min(usage, memcg->memory.min);
> -		siblings_min_usage = atomic_long_read(
> -			&parent->memory.children_min_usage);
> -
> -		if (min_usage && siblings_min_usage)
> -			emin = min(emin, parent_emin * min_usage /
> -				   siblings_min_usage);
> +	if (parent == root) {
> +		memcg->memory.emin = memcg->memory.min;
> +		memcg->memory.elow = memcg->memory.low;
> +		goto out;
>  	}
>  
> -	parent_elow = READ_ONCE(parent->memory.elow);
> -	elow = min(elow, parent_elow);
> -	if (elow && parent_elow) {
> -		unsigned long low_usage, siblings_low_usage;
> -
> -		low_usage = min(usage, memcg->memory.low);
> -		siblings_low_usage = atomic_long_read(
> -			&parent->memory.children_low_usage);
> +	memcg->memory.emin = effective_protection(usage,
> +			memcg->memory.min, READ_ONCE(parent->memory.emin),
> +			atomic_long_read(&parent->memory.children_min_usage));
>  
> -		if (low_usage && siblings_low_usage)
> -			elow = min(elow, parent_elow * low_usage /
> -				   siblings_low_usage);
> -	}
> -
> -exit:
> -	memcg->memory.emin = emin;
> -	memcg->memory.elow = elow;
> +	memcg->memory.elow = effective_protection(usage,
> +			memcg->memory.low, READ_ONCE(parent->memory.elow),
> +			atomic_long_read(&parent->memory.children_low_usage));
>  
> -	if (usage <= emin)
> +out:
> +	if (usage <= memcg->memory.emin)
>  		return MEMCG_PROT_MIN;
> -	else if (usage <= elow)
> +	else if (usage <= memcg->memory.elow)
>  		return MEMCG_PROT_LOW;
>  	else
>  		return MEMCG_PROT_NONE;
> -- 
> 2.24.1
> 

-- 
Michal Hocko
SUSE Labs
