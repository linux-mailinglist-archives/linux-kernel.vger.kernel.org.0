Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8AFC817E6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 13:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfHELLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 07:11:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:52442 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727158AbfHELLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:11:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 735B0AEF3;
        Mon,  5 Aug 2019 11:11:38 +0000 (UTC)
Date:   Mon, 5 Aug 2019 13:11:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v2] mm: memcontrol: switch to rcu protection in
 drain_all_stock()
Message-ID: <20190805111135.GE7597@dhcp22.suse.cz>
References: <20190802192241.3253165-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802192241.3253165-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-08-19 12:22:41, Roman Gushchin wrote:
> Commit 72f0184c8a00 ("mm, memcg: remove hotplug locking from try_charge")
> introduced css_tryget()/css_put() calls in drain_all_stock(),
> which are supposed to protect the target memory cgroup from being
> released during the mem_cgroup_is_descendant() call.
> 
> However, it's not completely safe. In theory, memcg can go away
> between reading stock->cached pointer and calling css_tryget().
> 
> This can happen if drain_all_stock() races with drain_local_stock()
> performed on the remote cpu as a result of a work, scheduled
> by the previous invocation of drain_all_stock().

Maybe I am still missing something but I do not see how 72f0184c8a00
changed the existing race. get_online_cpus doesn't prevent the same race
right? If this is the case then it would be great to clarify that. I
know that you are mostly after clarifying that css_tryget is
insufficient but the above sounds like 72f0184c8a00 has introduced a
regression.

> The race is a bit theoretical and there are few chances to trigger
> it, but the current code looks a bit confusing, so it makes sense
> to fix it anyway. The code looks like as if css_tryget() and
> css_put() are used to protect stocks drainage. It's not necessary
> because stocked pages are holding references to the cached cgroup.
> And it obviously won't work for works, scheduled on other cpus.
> 
> So, let's read the stock->cached pointer and evaluate the memory
> cgroup inside a rcu read section, and get rid of
> css_tryget()/css_put() calls.
> 
> v2: added some explanations to the commit message, no code changes
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Hillf Danton <hdanton@sina.com>

Other than that.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5c7b9facb0eb..d856b64426b7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2235,21 +2235,22 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
>  	for_each_online_cpu(cpu) {
>  		struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
>  		struct mem_cgroup *memcg;
> +		bool flush = false;
>  
> +		rcu_read_lock();
>  		memcg = stock->cached;
> -		if (!memcg || !stock->nr_pages || !css_tryget(&memcg->css))
> -			continue;
> -		if (!mem_cgroup_is_descendant(memcg, root_memcg)) {
> -			css_put(&memcg->css);
> -			continue;
> -		}
> -		if (!test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
> +		if (memcg && stock->nr_pages &&
> +		    mem_cgroup_is_descendant(memcg, root_memcg))
> +			flush = true;
> +		rcu_read_unlock();
> +
> +		if (flush &&
> +		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
>  			if (cpu == curcpu)
>  				drain_local_stock(&stock->work);
>  			else
>  				schedule_work_on(cpu, &stock->work);
>  		}
> -		css_put(&memcg->css);
>  	}
>  	put_cpu();
>  	mutex_unlock(&percpu_charge_mutex);
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
