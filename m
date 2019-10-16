Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7770BD8EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 13:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404816AbfJPLGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 07:06:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:45938 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388896AbfJPLGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:06:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF7F3B1ED;
        Wed, 16 Oct 2019 11:06:05 +0000 (UTC)
Date:   Wed, 16 Oct 2019 13:06:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 2/3] mm/vmalloc: respect passed gfp_mask when do
 preloading
Message-ID: <20191016110604.GT317@dhcp22.suse.cz>
References: <20191016095438.12391-1-urezki@gmail.com>
 <20191016095438.12391-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016095438.12391-2-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-10-19 11:54:37, Uladzislau Rezki (Sony) wrote:
> alloc_vmap_area() is given a gfp_mask for the page allocator.
> Let's respect that mask and consider it even in the case when
> doing regular CPU preloading, i.e. where a context can sleep.

This is explaining what but it doesn't say why. I would go with
"
Allocation functions should comply with the given gfp_mask as much as
possible. The preallocation code in alloc_vmap_area doesn't follow that
pattern and it is using a hardcoded GFP_KERNEL. Although this doesn't
really make much difference because vmalloc is not GFP_NOWAIT compliant
in general (e.g. page table allocations are GFP_KERNEL) there is no
reason to spread that bad habit and it is good to fix the antipattern.
"
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmalloc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index b7b443bfdd92..593bf554518d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1064,9 +1064,9 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  		return ERR_PTR(-EBUSY);
>  
>  	might_sleep();
> +	gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
>  
> -	va = kmem_cache_alloc_node(vmap_area_cachep,
> -			gfp_mask & GFP_RECLAIM_MASK, node);
> +	va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
>  	if (unlikely(!va))
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -1074,7 +1074,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	 * Only scan the relevant parts containing pointers to other objects
>  	 * to avoid false negatives.
>  	 */
> -	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask & GFP_RECLAIM_MASK);
> +	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
>  
>  retry:
>  	/*
> @@ -1100,7 +1100,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  		 * Just proceed as it is. If needed "overflow" path
>  		 * will refill the cache we allocate from.
>  		 */
> -		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
> +		pva = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
>  
>  	spin_lock(&vmap_area_lock);
>  
> -- 
> 2.20.1
> 

-- 
Michal Hocko
SUSE Labs
