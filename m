Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 380166CDD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 14:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfGRMFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 08:05:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:34390 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726715AbfGRMFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 08:05:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1FAC3AD4D;
        Thu, 18 Jul 2019 12:05:50 +0000 (UTC)
Date:   Thu, 18 Jul 2019 14:05:47 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, david@redhat.com,
        pasha.tatashin@soleen.com, mhocko@suse.com,
        aneesh.kumar@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm,memory_hotplug: Fix shrink_{zone,node}_span
Message-ID: <20190718120543.GA8500@linux>
References: <20190715081549.32577-1-osalvador@suse.de>
 <20190715081549.32577-3-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715081549.32577-3-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 10:15:49AM +0200, Oscar Salvador wrote:
> Since [1], shrink_{zone,node}_span work on PAGES_PER_SUBSECTION granularity.
> The problem is that deactivation of the section occurs later on in
> sparse_remove_section, so pfn_valid()->pfn_section_valid() will always return
> true before we deactivate the {sub}section.
> 
> I spotted this during hotplug hotremove tests, there I always saw that
> spanned_pages was, at least, left with PAGES_PER_SECTION, even if we
> removed all memory linked to that zone.
> 
> Fix this by decoupling section_deactivate from sparse_remove_section, and
> re-order the function calls.
> 
> Now, __remove_section will:
> 
> 1) deactivate section
> 2) shrink {zone,node}'s pages
> 3) remove section
> 
> [1] https://patchwork.kernel.org/patch/11003467/

Hi Andrew,

Please, drop this patch as patch [1] is the easiest way to fix this.

thanks a lot

[1] https://patchwork.kernel.org/patch/11047499/

> 
> Fixes: mmotm ("mm/hotplug: prepare shrink_{zone, pgdat}_span for sub-section removal")
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/memory_hotplug.h |  7 ++--
>  mm/memory_hotplug.c            |  6 +++-
>  mm/sparse.c                    | 77 +++++++++++++++++++++++++++++-------------
>  3 files changed, 62 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index f46ea71b4ffd..d2eb917aad5f 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -348,9 +348,10 @@ extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>  extern bool is_memblock_offlined(struct memory_block *mem);
>  extern int sparse_add_section(int nid, unsigned long pfn,
>  		unsigned long nr_pages, struct vmem_altmap *altmap);
> -extern void sparse_remove_section(struct mem_section *ms,
> -		unsigned long pfn, unsigned long nr_pages,
> -		unsigned long map_offset, struct vmem_altmap *altmap);
> +int sparse_deactivate_section(unsigned long pfn, unsigned long nr_pages);
> +void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
> +                           unsigned long map_offset, struct vmem_altmap *altmap,
> +                           int section_empty);
>  extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
>  					  unsigned long pnum);
>  extern bool allow_online_pfn_range(int nid, unsigned long pfn, unsigned long nr_pages,
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b9ba5b85f9f7..03d535eee60d 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -517,12 +517,16 @@ static void __remove_section(struct zone *zone, unsigned long pfn,
>  		struct vmem_altmap *altmap)
>  {
>  	struct mem_section *ms = __nr_to_section(pfn_to_section_nr(pfn));
> +	int ret;
>  
>  	if (WARN_ON_ONCE(!valid_section(ms)))
>  		return;
>  
> +	ret = sparse_deactivate_section(pfn, nr_pages);
>  	__remove_zone(zone, pfn, nr_pages);
> -	sparse_remove_section(ms, pfn, nr_pages, map_offset, altmap);
> +	if (ret >= 0)
> +		sparse_remove_section(pfn, nr_pages, map_offset, altmap,
> +				      ret);
>  }
>  
>  /**
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 1e224149aab6..d4953ee1d087 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -732,16 +732,47 @@ static void free_map_bootmem(struct page *memmap)
>  }
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>  
> -static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> -		struct vmem_altmap *altmap)
> +static void section_remove(unsigned long pfn, unsigned long nr_pages,
> +			   struct vmem_altmap *altmap, int section_empty)
> +{
> +	struct mem_section *ms = __pfn_to_section(pfn);
> +	bool section_early = early_section(ms);
> +	struct page *memmap = NULL;
> +
> +	if (section_empty) {
> +		unsigned long section_nr = pfn_to_section_nr(pfn);
> +
> +		if (!section_early) {
> +			kfree(ms->usage);
> +			ms->usage = NULL;
> +		}
> +		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> +		ms->section_mem_map = sparse_encode_mem_map(NULL, section_nr);
> +	}
> +
> +        if (section_early && memmap)
> +		free_map_bootmem(memmap);
> +        else
> +		depopulate_section_memmap(pfn, nr_pages, altmap);
> +}
> +
> +/**
> + * section_deactivate: Deactivate a {sub}section.
> + *
> + * Return:
> + * * -1         - {sub}section has already been deactivated.
> + * * 0          - Section is not empty
> + * * 1          - Section is empty
> + */
> +
> +static int section_deactivate(unsigned long pfn, unsigned long nr_pages)
>  {
>  	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
>  	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
>  	struct mem_section *ms = __pfn_to_section(pfn);
> -	bool section_is_early = early_section(ms);
> -	struct page *memmap = NULL;
>  	unsigned long *subsection_map = ms->usage
>  		? &ms->usage->subsection_map[0] : NULL;
> +	int section_empty = 0;
>  
>  	subsection_mask_set(map, pfn, nr_pages);
>  	if (subsection_map)
> @@ -750,7 +781,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
>  				"section already deactivated (%#lx + %ld)\n",
>  				pfn, nr_pages))
> -		return;
> +		return -1;
>  
>  	/*
>  	 * There are 3 cases to handle across two configurations
> @@ -770,21 +801,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
>  	 */
>  	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> -	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
> -		unsigned long section_nr = pfn_to_section_nr(pfn);
> -
> -		if (!section_is_early) {
> -			kfree(ms->usage);
> -			ms->usage = NULL;
> -		}
> -		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> -		ms->section_mem_map = sparse_encode_mem_map(NULL, section_nr);
> -	}
> +	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
> +		section_empty = 1;
>  
> -	if (section_is_early && memmap)
> -		free_map_bootmem(memmap);
> -	else
> -		depopulate_section_memmap(pfn, nr_pages, altmap);
> +	return section_empty;
>  }
>  
>  static struct page * __meminit section_activate(int nid, unsigned long pfn,
> @@ -834,7 +854,11 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
>  
>  	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap);
>  	if (!memmap) {
> -		section_deactivate(pfn, nr_pages, altmap);
> +		int ret;
> +
> +		ret = section_deactivate(pfn, nr_pages);
> +		if (ret >= 0)
> +			section_remove(pfn, nr_pages, altmap, ret);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> @@ -919,12 +943,17 @@ static inline void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
>  }
>  #endif
>  
> -void sparse_remove_section(struct mem_section *ms, unsigned long pfn,
> -		unsigned long nr_pages, unsigned long map_offset,
> -		struct vmem_altmap *altmap)
> +int sparse_deactivate_section(unsigned long pfn, unsigned long nr_pages)
> +{
> +	return section_deactivate(pfn, nr_pages);
> +}
> +
> +void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
> +			   unsigned long map_offset, struct vmem_altmap *altmap,
> +			   int section_empty)
>  {
>  	clear_hwpoisoned_pages(pfn_to_page(pfn) + map_offset,
>  			nr_pages - map_offset);
> -	section_deactivate(pfn, nr_pages, altmap);
> +	section_remove(pfn, nr_pages, altmap, section_empty);
>  }
>  #endif /* CONFIG_MEMORY_HOTPLUG */
> -- 
> 2.12.3
> 

-- 
Oscar Salvador
SUSE L3
