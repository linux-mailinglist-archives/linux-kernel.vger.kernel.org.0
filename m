Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E07568D7AE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 18:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfHNQHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 12:07:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:37950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbfHNQHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:07:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 61C21AB92;
        Wed, 14 Aug 2019 16:07:53 +0000 (UTC)
Date:   Wed, 14 Aug 2019 18:07:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 3/5] mm/memory_hotplug: Simplify online_pages_range()
Message-ID: <20190814160751.GI17933@dhcp22.suse.cz>
References: <20190814154109.3448-1-david@redhat.com>
 <20190814154109.3448-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814154109.3448-4-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-08-19 17:41:07, David Hildenbrand wrote:
> online_pages always corresponds to nr_pages. Simplify the code, getting
> rid of online_pages_blocks(). Add some comments.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memory_hotplug.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 10ad970f3f14..63b1775f7cf8 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -632,31 +632,27 @@ static void generic_online_page(struct page *page, unsigned int order)
>  #endif
>  }
>  
> -static int online_pages_blocks(unsigned long start, unsigned long nr_pages)
> -{
> -	unsigned long end = start + nr_pages;
> -	int order, onlined_pages = 0;
> -
> -	while (start < end) {
> -		order = min(MAX_ORDER - 1,
> -			get_order(PFN_PHYS(end) - PFN_PHYS(start)));
> -		(*online_page_callback)(pfn_to_page(start), order);
> -
> -		onlined_pages += (1UL << order);
> -		start += (1UL << order);
> -	}
> -	return onlined_pages;
> -}
> -
>  static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
>  			void *arg)
>  {
> -	unsigned long onlined_pages = *(unsigned long *)arg;
> +	const unsigned long end_pfn = start_pfn + nr_pages;
> +	unsigned long pfn;
> +	int order;
> +
> +	/*
> +	 * Online the pages. The callback might decide to keep some pages
> +	 * PG_reserved (to add them to the buddy later), but we still account
> +	 * them as being online/belonging to this zone ("present").
> +	 */
> +	for (pfn = start_pfn; pfn < end_pfn; pfn += 1ul << order) {
> +		order = min(MAX_ORDER - 1, get_order(PFN_PHYS(end_pfn - pfn)));
> +		(*online_page_callback)(pfn_to_page(pfn), order);
> +	}
>  
> -	onlined_pages += online_pages_blocks(start_pfn, nr_pages);
> -	online_mem_sections(start_pfn, start_pfn + nr_pages);
> +	/* mark all involved sections as online */
> +	online_mem_sections(start_pfn, end_pfn);
>  
> -	*(unsigned long *)arg = onlined_pages;
> +	*(unsigned long *)arg += nr_pages;
>  	return 0;
>  }
>  
> -- 
> 2.21.0
> 

-- 
Michal Hocko
SUSE Labs
