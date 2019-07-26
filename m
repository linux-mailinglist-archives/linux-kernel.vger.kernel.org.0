Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 261237614A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 10:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfGZIs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 04:48:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfGZIs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:48:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E50030917AC;
        Fri, 26 Jul 2019 08:48:57 +0000 (UTC)
Received: from [10.36.116.244] (ovpn-116-244.ams2.redhat.com [10.36.116.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B39587B6;
        Fri, 26 Jul 2019 08:48:55 +0000 (UTC)
Subject: Re: [PATCH v3 2/5] mm: Introduce a new Vmemmap page-type
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, pasha.tatashin@soleen.com,
        mhocko@suse.com, anshuman.khandual@arm.com,
        Jonathan.Cameron@huawei.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190725160207.19579-1-osalvador@suse.de>
 <20190725160207.19579-3-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <7e8746ac-6a66-d73c-9f2a-4fc53c7e4c04@redhat.com>
Date:   Fri, 26 Jul 2019 10:48:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725160207.19579-3-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 26 Jul 2019 08:48:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.19 18:02, Oscar Salvador wrote:
> This patch introduces a new Vmemmap page-type.
> 
> It also introduces some functions to ease the handling of vmemmap pages:
> 
> - vmemmap_nr_sections: Returns the number of sections that used vmemmap.
> 
> - vmemmap_nr_pages: Allows us to retrieve the amount of vmemmap pages
>   derivated from any vmemmap-page in the section. Useful for accounting
>   and to know how much to we have to skip in the case where vmemmap pages
>   need to be ignored.
> 
> - vmemmap_head: Returns the vmemmap head page
> 
> - SetPageVmemmap: Sets Reserved flag bit, and sets page->type to Vmemmap.
>   Setting the Reserved flag bit is just for extra protection, actually
>   we do not expect anyone to use these pages for anything.
> 
> - ClearPageVmemmap: Clears Reserved flag bit and page->type.
>   Only used when sections containing vmemmap pages are removed.
> 
> These functions will be used for the code handling Vmemmap pages.
> 

Much cleaner using the page type :)

> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/mm.h         | 17 +++++++++++++++++
>  include/linux/mm_types.h   |  5 +++++
>  include/linux/page-flags.h | 19 +++++++++++++++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 45f0ab0ed4f7..432175f8f8d2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2904,6 +2904,23 @@ static inline bool debug_guardpage_enabled(void) { return false; }
>  static inline bool page_is_guard(struct page *page) { return false; }
>  #endif /* CONFIG_DEBUG_PAGEALLOC */
>  
> +static __always_inline struct page *vmemmap_head(struct page *page)
> +{
> +	return (struct page *)page->vmemmap_head;
> +}
> +
> +static __always_inline unsigned long vmemmap_nr_sections(struct page *page)
> +{
> +	struct page *head = vmemmap_head(page);
> +	return head->vmemmap_sections;
> +}
> +
> +static __always_inline unsigned long vmemmap_nr_pages(struct page *page)
> +{
> +	struct page *head = vmemmap_head(page);
> +	return head->vmemmap_pages - (page - head);
> +}
> +
>  #if MAX_NUMNODES > 1
>  void __init setup_nr_node_ids(void);
>  #else
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 6a7a1083b6fb..51dd227f2a6b 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -170,6 +170,11 @@ struct page {
>  			 * pmem backed DAX files are mapped.
>  			 */
>  		};
> +		struct {        /* Vmemmap pages */
> +			unsigned long vmemmap_head;
> +			unsigned long vmemmap_sections; /* Number of sections */
> +			unsigned long vmemmap_pages;    /* Number of pages */
> +		};
>  
>  		/** @rcu_head: You can use this to free a page by RCU. */
>  		struct rcu_head rcu_head;
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index f91cb8898ff0..75f302a532f9 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -708,6 +708,7 @@ PAGEFLAG_FALSE(DoubleMap)
>  #define PG_kmemcg	0x00000200
>  #define PG_table	0x00000400
>  #define PG_guard	0x00000800
> +#define PG_vmemmap     0x00001000
>  
>  #define PageType(page, flag)						\
>  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
> @@ -764,6 +765,24 @@ PAGE_TYPE_OPS(Table, table)
>   */
>  PAGE_TYPE_OPS(Guard, guard)
>  
> +/*
> + * Vmemmap pages refers to those pages that are used to create the memmap
> + * array, and reside within the same memory range that was hotppluged, so
> + * they are self-hosted. (see include/linux/memory_hotplug.h)
> + */
> +PAGE_TYPE_OPS(Vmemmap, vmemmap)
> +static __always_inline void SetPageVmemmap(struct page *page)
> +{
> +	__SetPageVmemmap(page);
> +	__SetPageReserved(page);

So, the issue with some vmemmap pages is that the "struct pages" reside
on the memory they manage. (it is nice, but complicated - e.g. when
onlining/offlining)

I would expect that you properly initialize the struct pages for the
vmemmap pages (now it gets confusing :) ) when adding memory. The other
struct pages are initialized when onlining/offlining.

So, at this point, the pages should already be marked reserved, no? Or
are the struct pages for the vmemmap never initialized?

What zone do these vmemmap pages have? They are not assigned to any zone
and will never be :/

> +}
> +
> +static __always_inline void ClearPageVmemmap(struct page *page)
> +{
> +	__ClearPageVmemmap(page);
> +	__ClearPageReserved(page);

You sure you want to clear the reserved flag here? Is this function
really needed?

(when you add memory, you can mark all relevant pages as vmemmap pages,
which is valid until removing the memory)

Let's draw a picture so I am not confused

[ ------ added memory ------ ]
[ vmemmap]

The first page of the added memory is a vmemmap page AND contains its
own vmemmap, right?

When adding memory, you would initialize set all struct pages of the
vmemmap (residing on itself) and set them to SetPageVmemmap().

When removing memory, there is nothing to do, all struct pages are
dropped. So why do we need the ClearPageVmemmap() ?

-- 

Thanks,

David / dhildenb
