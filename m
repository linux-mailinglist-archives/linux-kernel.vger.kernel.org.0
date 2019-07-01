Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 171D359EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 17:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfF1PRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 11:17:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:36224 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726795AbfF1PRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:17:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6AD17ACB4;
        Fri, 28 Jun 2019 15:17:52 +0000 (UTC)
Date:   Fri, 28 Jun 2019 17:17:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH] mm: fix regression with deferred struct page init
Message-ID: <20190628151749.GA2880@dhcp22.suse.cz>
References: <20190620160821.4210-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620160821.4210-1-jgross@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20-06-19 18:08:21, Juergen Gross wrote:
> Commit 0e56acae4b4dd4a9 ("mm: initialize MAX_ORDER_NR_PAGES at a time
> instead of doing larger sections") is causing a regression on some
> systems when the kernel is booted as Xen dom0.
> 
> The system will just hang in early boot.
> 
> Reason is an endless loop in get_page_from_freelist() in case the first
> zone looked at has no free memory. deferred_grow_zone() is always

Could you explain how we ended up with the zone having no memory? Is
xen "stealing" memblock memory without adding it to memory.reserved?
In other words, how do we end up with an empty zone that has non zero
end_pfn?

> returning true due to the following code snipplet:
> 
>   /* If the zone is empty somebody else may have cleared out the zone */
>   if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
>                                            first_deferred_pfn)) {
>           pgdat->first_deferred_pfn = ULONG_MAX;
>           pgdat_resize_unlock(pgdat, &flags);
>           return true;
>   }
> 
> This in turn results in the loop as get_page_from_freelist() is
> assuming forward progress can be made by doing some more struct page
> initialization.

The patch looks correct. The code is subtle but the comment helps.

> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Fixes: 0e56acae4b4dd4a9 ("mm: initialize MAX_ORDER_NR_PAGES at a time instead of doing larger sections")
> Suggested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/page_alloc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d66bc8abe0af..8e3bc949ebcc 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1826,7 +1826,8 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
>  						 first_deferred_pfn)) {
>  		pgdat->first_deferred_pfn = ULONG_MAX;
>  		pgdat_resize_unlock(pgdat, &flags);
> -		return true;
> +		/* Retry only once. */
> +		return first_deferred_pfn != ULONG_MAX;
>  	}
>  
>  	/*
> -- 
> 2.16.4

-- 
Michal Hocko
SUSE Labs
