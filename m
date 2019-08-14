Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 983AA8D21A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 13:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfHNL0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 07:26:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:38606 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbfHNL0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:26:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7AA8AD0B;
        Wed, 14 Aug 2019 11:26:29 +0000 (UTC)
Date:   Wed, 14 Aug 2019 13:26:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] mm: memcontrol: flush percpu vmstats before
 releasing memcg
Message-ID: <20190814112629.GU17933@dhcp22.suse.cz>
References: <20190812222911.2364802-1-guro@fb.com>
 <20190812222911.2364802-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812222911.2364802-2-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12-08-19 15:29:10, Roman Gushchin wrote:
> Percpu caching of local vmstats with the conditional propagation
> by the cgroup tree leads to an accumulation of errors on non-leaf
> levels.
> 
> Let's imagine two nested memory cgroups A and A/B. Say, a process
> belonging to A/B allocates 100 pagecache pages on the CPU 0.
> The percpu cache will spill 3 times, so that 32*3=96 pages will be
> accounted to A/B and A atomic vmstat counters, 4 pages will remain
> in the percpu cache.
> 
> Imagine A/B is nearby memory.max, so that every following allocation
> triggers a direct reclaim on the local CPU. Say, each such attempt
> will free 16 pages on a new cpu. That means every percpu cache will
> have -16 pages, except the first one, which will have 4 - 16 = -12.
> A/B and A atomic counters will not be touched at all.
> 
> Now a user removes A/B. All percpu caches are freed and corresponding
> vmstat numbers are forgotten. A has 96 pages more than expected.
> 
> As memory cgroups are created and destroyed, errors do accumulate.
> Even 1-2 pages differences can accumulate into large numbers.
> 
> To fix this issue let's accumulate and propagate percpu vmstat
> values before releasing the memory cgroup. At this point these
> numbers are stable and cannot be changed.

It is worth spending a word or two on why this doesn't matter during the
memcg life time.

> Since on cpu hotplug we do flush percpu vmstats anyway, we can
> iterate only over online cpus.
> 
> Fixes: 42a300353577 ("mm: memcontrol: fix recursive statistics correctness & scalabilty")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 3e821f34399f..348f685ab94b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3412,6 +3412,41 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
>  	return 0;
>  }
>  
> +static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg)
> +{
> +	unsigned long stat[MEMCG_NR_STAT];
> +	struct mem_cgroup *mi;
> +	int node, cpu, i;
> +
> +	for (i = 0; i < MEMCG_NR_STAT; i++)
> +		stat[i] = 0;
> +
> +	for_each_online_cpu(cpu)
> +		for (i = 0; i < MEMCG_NR_STAT; i++)
> +			stat[i] += raw_cpu_read(memcg->vmstats_percpu->stat[i]);
> +
> +	for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
> +		for (i = 0; i < MEMCG_NR_STAT; i++)
> +			atomic_long_add(stat[i], &mi->vmstats[i]);
> +
> +	for_each_node(node) {
> +		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
> +		struct mem_cgroup_per_node *pi;
> +
> +		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> +			stat[i] = 0;
> +
> +		for_each_online_cpu(cpu)
> +			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> +				stat[i] += raw_cpu_read(
> +					pn->lruvec_stat_cpu->count[i]);
> +
> +		for (pi = pn; pi; pi = parent_nodeinfo(pi, node))
> +			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> +				atomic_long_add(stat[i], &pi->lruvec_stat[i]);
> +	}
> +}
> +
>  static void memcg_offline_kmem(struct mem_cgroup *memcg)
>  {
>  	struct cgroup_subsys_state *css;
> @@ -4805,6 +4840,11 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
>  {
>  	int node;
>  
> +	/*
> +	 * Flush percpu vmstats to guarantee the value correctness
> +	 * on parent's and all ancestor levels.
> +	 */
> +	memcg_flush_percpu_vmstats(memcg);
>  	for_each_node(node)
>  		free_mem_cgroup_per_node_info(memcg, node);
>  	free_percpu(memcg->vmstats_percpu);
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
