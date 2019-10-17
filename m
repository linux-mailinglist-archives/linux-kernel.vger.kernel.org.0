Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4703DB8D7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 23:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441334AbfJQVO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 17:14:27 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17237 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394781AbfJQVO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 17:14:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da8d9b10000>; Thu, 17 Oct 2019 14:14:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 17 Oct 2019 14:14:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 17 Oct 2019 14:14:22 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Oct
 2019 21:14:21 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Oct
 2019 21:14:21 +0000
Subject: Re: [PATCH V3] mm/page_alloc: Add alloc_contig_pages()
To:     Anshuman Khandual <anshuman.khandual@arm.com>, <linux-mm@kvack.org>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        "David Hildenbrand" <david@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <1571300646-32240-1-git-send-email-anshuman.khandual@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <d0b4a92b-825f-7b2f-4624-c76f218f064e@nvidia.com>
Date:   Thu, 17 Oct 2019 14:14:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1571300646-32240-1-git-send-email-anshuman.khandual@arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571346865; bh=HnqpavetdbJgc/OJGv/GBKTTizohF9vHaaPQ4Z3Dp74=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=RV6nB+uHlZRz97UWqIcnO9ktKJrORpKtEepi0FgWKkPbQ0ah+jDUY4J4WuXxNhAnW
         SZ+QDuJO4Mwu7UxVAtMp3cyp6xVGOzV2kRauNtDlBLNEL70s+mcqbpChTWSjaXkYoE
         OqF/MiQDv9ZKUZr1Lg97EWWd86fNzm0fexsay8IrtQp0KRo+nXAWG6L0eur7+b1ePA
         3RyQZT+Psdx980ZBfda0/Kza3SamgAbKjYdxNVW+MR2ctU3+R9QmkSbcHpz+zOpqI5
         renaQL/ZAqpiuEj50IfGg/ERTYw0XIoBiJdXf8G9lNAzoap3tU4q2oVq4c82fhqtAX
         8VoLXoGkW7u1Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/19 1:24 AM, Anshuman Khandual wrote:
> HugeTLB helper alloc_gigantic_page() implements fairly generic allocation
> method where it scans over various zones looking for a large contiguous pfn
> range before trying to allocate it with alloc_contig_range(). Other than
> deriving the requested order from 'struct hstate', there is nothing HugeTLB
> specific in there. This can be made available for general use to allocate
> contiguous memory which could not have been allocated through the buddy
> allocator.
> 
> alloc_gigantic_page() has been split carving out actual allocation method
> which is then made available via new alloc_contig_pages() helper wrapped
> under CONFIG_CONTIG_ALLOC. All references to 'gigantic' have been replaced
> with more generic term 'contig'. Allocated pages here should be freed with
> free_contig_range() or by calling __free_page() on each allocated page.
> 
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This is based on https://patchwork.kernel.org/patch/11190213/

Hi Anshuman,

I'm having trouble finding a tree that this applies cleanly too,
which one did you use? (latest linux-next, or linux.git would be
nice).


thanks,

John Hubbard
NVIDIA


> 
> Changes in V3:
> 
> - Added an in-code comment per Michal and David
> 
> Changes in V2:
> 
> - Rephrased patch subject per David
> - Fixed all typos per David
> - s/order/contiguous
> 
> Changes from [V5,1/2] mm/hugetlb: Make alloc_gigantic_page()...
> 
> - alloc_contig_page() takes nr_pages instead of order per Michal
> - s/gigantic/contig on all related functions
> 
>  include/linux/gfp.h |   2 +
>  mm/hugetlb.c        |  77 +--------------------------------
>  mm/page_alloc.c     | 101 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+), 75 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index fb07b503dc45..1a11d4857027 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -589,6 +589,8 @@ static inline bool pm_suspended_storage(void)
>  /* The below functions must be run on a range from a single zone. */
>  extern int alloc_contig_range(unsigned long start, unsigned long end,
>  			      unsigned migratetype, gfp_t gfp_mask);
> +extern struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
> +				       int nid, nodemask_t *nodemask);
>  #endif
>  void free_contig_range(unsigned long pfn, unsigned int nr_pages);
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 985ee15eb04b..a5c2c880af27 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1023,85 +1023,12 @@ static void free_gigantic_page(struct page *page, unsigned int order)
>  }
>  
>  #ifdef CONFIG_CONTIG_ALLOC
> -static int __alloc_gigantic_page(unsigned long start_pfn,
> -				unsigned long nr_pages, gfp_t gfp_mask)
> -{
> -	unsigned long end_pfn = start_pfn + nr_pages;
> -	return alloc_contig_range(start_pfn, end_pfn, MIGRATE_MOVABLE,
> -				  gfp_mask);
> -}
> -
> -static bool pfn_range_valid_gigantic(struct zone *z,
> -			unsigned long start_pfn, unsigned long nr_pages)
> -{
> -	unsigned long i, end_pfn = start_pfn + nr_pages;
> -	struct page *page;
> -
> -	for (i = start_pfn; i < end_pfn; i++) {
> -		page = pfn_to_online_page(i);
> -		if (!page)
> -			return false;
> -
> -		if (page_zone(page) != z)
> -			return false;
> -
> -		if (PageReserved(page))
> -			return false;
> -
> -		if (page_count(page) > 0)
> -			return false;
> -
> -		if (PageHuge(page))
> -			return false;
> -	}
> -
> -	return true;
> -}
> -
> -static bool zone_spans_last_pfn(const struct zone *zone,
> -			unsigned long start_pfn, unsigned long nr_pages)
> -{
> -	unsigned long last_pfn = start_pfn + nr_pages - 1;
> -	return zone_spans_pfn(zone, last_pfn);
> -}
> -
>  static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
>  		int nid, nodemask_t *nodemask)
>  {
> -	unsigned int order = huge_page_order(h);
> -	unsigned long nr_pages = 1 << order;
> -	unsigned long ret, pfn, flags;
> -	struct zonelist *zonelist;
> -	struct zone *zone;
> -	struct zoneref *z;
> -
> -	zonelist = node_zonelist(nid, gfp_mask);
> -	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nodemask) {
> -		spin_lock_irqsave(&zone->lock, flags);
> +	unsigned long nr_pages = 1UL << huge_page_order(h);
>  
> -		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
> -		while (zone_spans_last_pfn(zone, pfn, nr_pages)) {
> -			if (pfn_range_valid_gigantic(zone, pfn, nr_pages)) {
> -				/*
> -				 * We release the zone lock here because
> -				 * alloc_contig_range() will also lock the zone
> -				 * at some point. If there's an allocation
> -				 * spinning on this lock, it may win the race
> -				 * and cause alloc_contig_range() to fail...
> -				 */
> -				spin_unlock_irqrestore(&zone->lock, flags);
> -				ret = __alloc_gigantic_page(pfn, nr_pages, gfp_mask);
> -				if (!ret)
> -					return pfn_to_page(pfn);
> -				spin_lock_irqsave(&zone->lock, flags);
> -			}
> -			pfn += nr_pages;
> -		}
> -
> -		spin_unlock_irqrestore(&zone->lock, flags);
> -	}
> -
> -	return NULL;
> +	return alloc_contig_pages(nr_pages, gfp_mask, nid, nodemask);
>  }
>  
>  static void prep_new_huge_page(struct hstate *h, struct page *page, int nid);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cd1dd0712624..fe76be55c9d5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8499,6 +8499,107 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  				pfn_max_align_up(end), migratetype);
>  	return ret;
>  }
> +
> +static int __alloc_contig_pages(unsigned long start_pfn,
> +				unsigned long nr_pages, gfp_t gfp_mask)
> +{
> +	unsigned long end_pfn = start_pfn + nr_pages;
> +
> +	return alloc_contig_range(start_pfn, end_pfn, MIGRATE_MOVABLE,
> +				  gfp_mask);
> +}
> +
> +static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
> +				   unsigned long nr_pages)
> +{
> +	unsigned long i, end_pfn = start_pfn + nr_pages;
> +	struct page *page;
> +
> +	for (i = start_pfn; i < end_pfn; i++) {
> +		page = pfn_to_online_page(i);
> +		if (!page)
> +			return false;
> +
> +		if (page_zone(page) != z)
> +			return false;
> +
> +		if (PageReserved(page))
> +			return false;
> +
> +		if (page_count(page) > 0)
> +			return false;
> +
> +		if (PageHuge(page))
> +			return false;
> +	}
> +	return true;
> +}
> +
> +static bool zone_spans_last_pfn(const struct zone *zone,
> +				unsigned long start_pfn, unsigned long nr_pages)
> +{
> +	unsigned long last_pfn = start_pfn + nr_pages - 1;
> +
> +	return zone_spans_pfn(zone, last_pfn);
> +}
> +
> +/**
> + * alloc_contig_pages() -- tries to find and allocate contiguous range of pages
> + * @nr_pages:	Number of contiguous pages to allocate
> + * @gfp_mask:	GFP mask to limit search and used during compaction
> + * @nid:	Target node
> + * @nodemask:	Mask for other possible nodes
> + *
> + * This routine is a wrapper around alloc_contig_range(). It scans over zones
> + * on an applicable zonelist to find a contiguous pfn range which can then be
> + * tried for allocation with alloc_contig_range(). This routine is intended
> + * for allocation requests which can not be fulfilled with the buddy allocator.
> + *
> + * The allocated memory is always aligned to a page boundary. If nr_pages is a
> + * power of two then the alignment is guaranteed to be to the given nr_pages
> + * (e.g. 1GB request would be aligned to 1GB).
> + *
> + * Allocated pages can be freed with free_contig_range() or by manually calling
> + * __free_page() on each allocated page.
> + *
> + * Return: pointer to contiguous pages on success, or NULL if not successful.
> + */
> +struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
> +				int nid, nodemask_t *nodemask)
> +{
> +	unsigned long ret, pfn, flags;
> +	struct zonelist *zonelist;
> +	struct zone *zone;
> +	struct zoneref *z;
> +
> +	zonelist = node_zonelist(nid, gfp_mask);
> +	for_each_zone_zonelist_nodemask(zone, z, zonelist,
> +					gfp_zone(gfp_mask), nodemask) {
> +		spin_lock_irqsave(&zone->lock, flags);
> +
> +		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
> +		while (zone_spans_last_pfn(zone, pfn, nr_pages)) {
> +			if (pfn_range_valid_contig(zone, pfn, nr_pages)) {
> +				/*
> +				 * We release the zone lock here because
> +				 * alloc_contig_range() will also lock the zone
> +				 * at some point. If there's an allocation
> +				 * spinning on this lock, it may win the race
> +				 * and cause alloc_contig_range() to fail...
> +				 */
> +				spin_unlock_irqrestore(&zone->lock, flags);
> +				ret = __alloc_contig_pages(pfn, nr_pages,
> +							gfp_mask);
> +				if (!ret)
> +					return pfn_to_page(pfn);
> +				spin_lock_irqsave(&zone->lock, flags);
> +			}
> +			pfn += nr_pages;
> +		}
> +		spin_unlock_irqrestore(&zone->lock, flags);
> +	}
> +	return NULL;
> +}
>  #endif /* CONFIG_CONTIG_ALLOC */
>  
>  void free_contig_range(unsigned long pfn, unsigned int nr_pages)
> 
