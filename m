Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB7D812A13
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 10:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfECIqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 04:46:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:35034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727315AbfECIqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:46:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06A8CACAE;
        Fri,  3 May 2019 08:46:07 +0000 (UTC)
Date:   Fri, 3 May 2019 10:46:03 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/12] mm/sparsemem: Convert kmalloc_section_memmap()
 to populate_section_memmap()
Message-ID: <20190503084603.GE15740@linux>
References: <155677652226.2336373.8700273400832001094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155677654842.2336373.17000900051843592636.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155677654842.2336373.17000900051843592636.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 10:55:48PM -0700, Dan Williams wrote:
> Allow sub-section sized ranges to be added to the memmap.
> populate_section_memmap() takes an explict pfn range rather than
> assuming a full section, and those parameters are plumbed all the way
> through to vmmemap_populate(). There should be no sub-section usage in
> current deployments. New warnings are added to clarify which memmap
> allocation paths are sub-section capable.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/mm/init_64.c |    4 ++-
>  include/linux/mm.h    |    4 ++-
>  mm/sparse-vmemmap.c   |   21 +++++++++++------
>  mm/sparse.c           |   61 +++++++++++++++++++++++++++++++------------------
>  4 files changed, 57 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 20d14254b686..bb018d09d2dc 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1457,7 +1457,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  {
>  	int err;
>  
> -	if (boot_cpu_has(X86_FEATURE_PSE))
> +	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
maybe just:

	if (PHYS_PFN(end) - PHYS_PFN(start) < PAGES_PER_SECTION) ?
> +		err = vmemmap_populate_basepages(start, end, node);
> +	else if (boot_cpu_has(X86_FEATURE_PSE))
>  		err = vmemmap_populate_hugepages(start, end, node, altmap);
>  	else if (altmap) {
>  		pr_err_once("%s: no cpu support for altmap allocations\n",

Although the following looks more clear to me:

int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
                struct vmem_altmap *altmap)
{
        int err;
        bool partial_section = (PHYS_PFN(end) - PFN_PHYS(start)) < PAGES_PER_SECTION;

        if (partial_section || !boot_cpu_has(X86_FEATURE_PSE))
                err = vmemmap_populate_basepages(start, end, node);
        else if (boot_cpu_has(X86_FEATURE_PSE))
                err = vmemmap_populate_hugepages(start, end, node, altmap);
        else if (altmap) {
                pr_err_once("%s: no cpu support for altmap allocations\n",
                                __func__);
                err = -ENOMEM;
        }

        if (!err)
                sync_global_pgds(start, end - 1);
        return err;
}

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0e8834ac32b7..5360a0e4051d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2748,8 +2748,8 @@ const char * arch_vma_name(struct vm_area_struct *vma);
>  void print_vma_addr(char *prefix, unsigned long rip);
>  
>  void *sparse_buffer_alloc(unsigned long size);
> -struct page *sparse_mem_map_populate(unsigned long pnum, int nid,
> -		struct vmem_altmap *altmap);
> +struct page * __populate_section_memmap(unsigned long pfn,
> +		unsigned long nr_pages, int nid, struct vmem_altmap *altmap);
>  pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
>  p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
>  pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 7fec05796796..dcb023aa23d1 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -245,19 +245,26 @@ int __meminit vmemmap_populate_basepages(unsigned long start,
>  	return 0;
>  }
>  
> -struct page * __meminit sparse_mem_map_populate(unsigned long pnum, int nid,
> -		struct vmem_altmap *altmap)
> +struct page * __meminit __populate_section_memmap(unsigned long pfn,
> +		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>  {
>  	unsigned long start;
>  	unsigned long end;
> -	struct page *map;
>  
> -	map = pfn_to_page(pnum * PAGES_PER_SECTION);
> -	start = (unsigned long)map;
> -	end = (unsigned long)(map + PAGES_PER_SECTION);
> +	/*
> +	 * The minimum granularity of memmap extensions is
> +	 * SECTION_ACTIVE_SIZE as allocations are tracked in the
> +	 * 'map_active' bitmap of the section.
> +	 */
> +	end = ALIGN(pfn + nr_pages, PHYS_PFN(SECTION_ACTIVE_SIZE));

I would use PAGES_PER_SUB_SECTION directly:

	 end = ALIGN(pfn + nr_pages, PAGES_PER_SUB_SECTION);

> +	pfn &= PHYS_PFN(SECTION_ACTIVE_MASK);

	pfn &= PAGE_SUB_SECTION_MASK ?

[...]
> -static struct page *__kmalloc_section_memmap(void)
> +struct page *populate_section_memmap(unsigned long pfn,
> +		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>  {
>  	struct page *page, *ret;
>  	unsigned long memmap_size = sizeof(struct page) * PAGES_PER_SECTION;
>  
> +	if ((pfn & ~PAGE_SECTION_MASK) || nr_pages != PAGES_PER_SECTION) {
> +		WARN(1, "%s: called with section unaligned parameters\n",
> +				__func__);
> +		return NULL;
> +	}

Can this actually happen? We need CONFIG_SPARSEMEM_VMEMMAP in order to use nvdimm,
right?

But I guess it is fine to have a safety net just in case.

> +
>  	page = alloc_pages(GFP_KERNEL|__GFP_NOWARN, get_order(memmap_size));
>  	if (page)
>  		goto got_map_page;
> @@ -682,15 +692,17 @@ static struct page *__kmalloc_section_memmap(void)
>  	return ret;
>  }
>  
> -static inline struct page *kmalloc_section_memmap(unsigned long pnum, int nid,
> +static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
>  		struct vmem_altmap *altmap)
>  {
> -	return __kmalloc_section_memmap();
> -}
> +	struct page *memmap = pfn_to_page(pfn);
> +
> +	if ((pfn & ~PAGE_SECTION_MASK) || nr_pages != PAGES_PER_SECTION) {
> +		WARN(1, "%s: called with section unaligned parameters\n",
> +				__func__);
> +		return;
> +	}
>  
> -static void __kfree_section_memmap(struct page *memmap,
> -		struct vmem_altmap *altmap)
> -{
>  	if (is_vmalloc_addr(memmap))
>  		vfree(memmap);
>  	else
> @@ -761,12 +773,13 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
>  	if (ret < 0 && ret != -EEXIST)
>  		return ret;
>  	ret = 0;
> -	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
> +	memmap = populate_section_memmap(start_pfn, PAGES_PER_SECTION, nid,
> +			altmap);
>  	if (!memmap)
>  		return -ENOMEM;
>  	usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
>  	if (!usage) {
> -		__kfree_section_memmap(memmap, altmap);
> +		depopulate_section_memmap(start_pfn, PAGES_PER_SECTION, altmap);
>  		return -ENOMEM;
>  	}
>  
> @@ -788,7 +801,7 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
>  out:
>  	if (ret < 0) {
>  		kfree(usage);
> -		__kfree_section_memmap(memmap, altmap);
> +		depopulate_section_memmap(start_pfn, PAGES_PER_SECTION, altmap);
>  	}
>  	return ret;
>  }
> @@ -825,7 +838,8 @@ static inline void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
>  #endif
>  
>  static void free_section_usage(struct page *memmap,
> -		struct mem_section_usage *usage, struct vmem_altmap *altmap)
> +		struct mem_section_usage *usage, unsigned long pfn,
> +		unsigned long nr_pages, struct vmem_altmap *altmap)
>  {
>  	struct page *usage_page;
>  
> @@ -839,7 +853,7 @@ static void free_section_usage(struct page *memmap,
>  	if (PageSlab(usage_page) || PageCompound(usage_page)) {
>  		kfree(usage);
>  		if (memmap)
> -			__kfree_section_memmap(memmap, altmap);
> +			depopulate_section_memmap(pfn, nr_pages, altmap);
>  		return;
>  	}
>  
> @@ -868,7 +882,8 @@ void sparse_remove_one_section(struct zone *zone, struct mem_section *ms,
>  
>  	clear_hwpoisoned_pages(memmap + map_offset,
>  			PAGES_PER_SECTION - map_offset);
> -	free_section_usage(memmap, usage, altmap);
> +	free_section_usage(memmap, usage, section_nr_to_pfn(__section_nr(ms)),
> +			PAGES_PER_SECTION, altmap);
>  }
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>  #endif /* CONFIG_MEMORY_HOTPLUG */
> 

-- 
Oscar Salvador
SUSE L3
