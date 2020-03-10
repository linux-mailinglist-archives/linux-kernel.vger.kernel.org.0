Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3EE17F237
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 09:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCJIpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 04:45:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34892 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgCJIpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 04:45:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id m3so317388wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 01:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Irapte2jMjBTf5tgiU8rGS0JL18ZdOQCDd6Y5nxOecc=;
        b=ciamwfiO9I2t4HvS+6mDrHs9cKjsRDfPef/FSthRCjR3g/cxOJTaCZia8/NeKoKXGV
         kZtiPp++HpvIXpHVvqzGxak4pq6wek541JBAl8LLuMAsoECkFZJpd3cSNHKWBentCiGL
         wfnKsFncycpA+bQ6Wsh9SanwFi6qQRNDFISaH92Xf/F/oG/Becvi4JbA8D9wZJDdFnFj
         ELyAnn9mmDE/k5FuwQTCvMix/1ceVvLHQ1WFlu9hrD+c8/vhASPK7lPM4yoImyDvmjhY
         8wea4zAStLUyt7cd/Hs9oU7cMAKXvCk3UV7JLTCAm3iqNkRL2yJWDZ6gFOmt4UgD8GT5
         Qfig==
X-Gm-Message-State: ANhLgQ3gDfwUUMGGnPEIjnJUJ6IUInJdYJnui8Cmvct1MkHcoxkKQEMQ
        VkhSYrBOlmZSX1yr6EUXNTE=
X-Google-Smtp-Source: ADFU+vtXTNBR7lK8Ag9Lxs5wN9/TAgFNzpZ3ovJGPL7xKkc9q2dIuYlzN561ULfL95Mv+Y9AsEFZAQ==
X-Received: by 2002:a7b:c944:: with SMTP id i4mr956259wml.77.1583829946756;
        Tue, 10 Mar 2020 01:45:46 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id s14sm53401881wrv.44.2020.03.10.01.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 01:45:45 -0700 (PDT)
Date:   Tue, 10 Mar 2020 09:45:44 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
Message-ID: <20200310084544.GY8447@dhcp22.suse.cz>
References: <20200310002524.2291595-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310002524.2291595-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Mike as hugetlb maintainer and keeping the full context for his
reference]

On Mon 09-03-20 17:25:24, Roman Gushchin wrote:
> Commit 944d9fec8d7a ("hugetlb: add support for gigantic page allocation
> at runtime") has added the run-time allocation of gigantic pages. However
> it actually works only at early stages of the system loading, when
> the majority of memory is free. After some time the memory gets
> fragmented by non-movable pages, so the chances to find a contiguous
> 1 GB block are getting close to zero. Even dropping caches manually
> doesn't help a lot.
> 
> At large scale rebooting servers in order to allocate gigantic hugepages
> is quite expensive and complex. At the same time keeping some constant
> percentage of memory in reserved hugepages even if the workload isn't
> using it is a big waste: not all workloads can benefit from using 1 GB
> pages.
> 
> The following solution can solve the problem:
> 1) On boot time a dedicated cma area* is reserved. The size is passed
>    as a kernel argument.
> 2) Run-time allocations of gigantic hugepages are performed using the
>    cma allocator and the dedicated cma area
> 
> In this case gigantic hugepages can be allocated successfully with a
> high probability, however the memory isn't completely wasted if nobody
> is using 1GB hugepages: it can be used for pagecache, anon memory,
> THPs, etc.
> 
> * On a multi-node machine a per-node cma area is allocated on each node.
>   Following gigantic hugetlb allocation are using the first available
>   numa node if the mask isn't specified by a user.
> 
> Usage:
> 1) configure the kernel to allocate a cma area for hugetlb allocations:
>    pass hugetlb_cma=10G as a kernel argument
> 
> 2) allocate hugetlb pages as usual, e.g.
>    echo 10 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> 
> If the option isn't enabled or the allocation of the cma area failed,
> the current behavior of the system is preserved.
> 
> Only x86 is covered by this patch, but it's trivial to extend it to
> cover other architectures as well.

Overall idea makes sense to me. I am worried about the configuration
side of the thing. Not only I would stick with the absolute size for now
for simplicity and because percentage usecase is not really explained
anywhere. I am also worried about the resulting memory layout you will
get when using the parameter.

Let's scroll down to the setup code ...

> v2: fixed !CONFIG_CMA build, suggested by Andrew Morton
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |   7 ++
>  arch/x86/kernel/setup.c                       |   3 +
>  include/linux/hugetlb.h                       |   2 +
>  mm/hugetlb.c                                  | 115 ++++++++++++++++++
>  4 files changed, 127 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0c9894247015..d3349ec1dbef 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1452,6 +1452,13 @@
>  	hpet_mmap=	[X86, HPET_MMAP] Allow userspace to mmap HPET
>  			registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
>  
> +	hugetlb_cma=	[x86-64] The size of a cma area used for allocation
> +			of gigantic hugepages.
> +			Format: nn[GTPE] | nn%
> +
> +			If enabled, boot-time allocation of gigantic hugepages
> +			is skipped.
> +
>  	hugepages=	[HW,X86-32,IA-64] HugeTLB pages to allocate at boot.
>  	hugepagesz=	[HW,IA-64,PPC,X86-64] The size of the HugeTLB pages.
>  			On x86-64 and powerpc, this option can be specified
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index a74262c71484..ceeb06ddfd41 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -16,6 +16,7 @@
>  #include <linux/pci.h>
>  #include <linux/root_dev.h>
>  #include <linux/sfi.h>
> +#include <linux/hugetlb.h>
>  #include <linux/tboot.h>
>  #include <linux/usb/xhci-dbgp.h>
>  
> @@ -1158,6 +1159,8 @@ void __init setup_arch(char **cmdline_p)
>  	initmem_init();
>  	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
>  
> +	hugetlb_cma_reserve();
> +
>  	/*
>  	 * Reserve memory for crash kernel after SRAT is parsed so that it
>  	 * won't consume hotpluggable memory.
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 50480d16bd33..50050c981ab9 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -157,6 +157,8 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud);
>  extern int sysctl_hugetlb_shm_group;
>  extern struct list_head huge_boot_pages;
>  
> +extern void __init hugetlb_cma_reserve(void);
> +
>  /* arch callbacks */
>  
>  pte_t *huge_pte_alloc(struct mm_struct *mm,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7fb31750e670..c6f58bab879c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -28,6 +28,7 @@
>  #include <linux/jhash.h>
>  #include <linux/numa.h>
>  #include <linux/llist.h>
> +#include <linux/cma.h>
>  
>  #include <asm/page.h>
>  #include <asm/pgtable.h>
> @@ -44,6 +45,9 @@
>  int hugetlb_max_hstate __read_mostly;
>  unsigned int default_hstate_idx;
>  struct hstate hstates[HUGE_MAX_HSTATE];
> +
> +static struct cma *hugetlb_cma[MAX_NUMNODES];
> +
>  /*
>   * Minimum page order among possible hugepage sizes, set to a proper value
>   * at boot time.
> @@ -1228,6 +1232,11 @@ static void destroy_compound_gigantic_page(struct page *page,
>  
>  static void free_gigantic_page(struct page *page, unsigned int order)
>  {
> +	if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
> +		cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order);
> +		return;
> +	}
> +
>  	free_contig_range(page_to_pfn(page), 1 << order);
>  }
>  
> @@ -1237,6 +1246,23 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
>  {
>  	unsigned long nr_pages = 1UL << huge_page_order(h);
>  
> +	if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
> +		struct page *page;
> +		int nid;
> +
> +		for_each_node_mask(nid, *nodemask) {
> +			if (!hugetlb_cma[nid])
> +				break;
> +
> +			page = cma_alloc(hugetlb_cma[nid], nr_pages,
> +					 huge_page_order(h), true);
> +			if (page)
> +				return page;
> +		}
> +
> +		return NULL;
> +	}
> +
>  	return alloc_contig_pages(nr_pages, gfp_mask, nid, nodemask);
>  }
>  
> @@ -2439,6 +2465,10 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>  
>  	for (i = 0; i < h->max_huge_pages; ++i) {
>  		if (hstate_is_gigantic(h)) {
> +			if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
> +				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
> +				break;
> +			}
>  			if (!alloc_bootmem_huge_page(h))
>  				break;
>  		} else if (!alloc_pool_huge_page(h,
> @@ -5372,3 +5402,88 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
>  		spin_unlock(&hugetlb_lock);
>  	}
>  }
> +
> +#ifdef CONFIG_CMA
> +static unsigned long hugetlb_cma_size __initdata;
> +static unsigned long hugetlb_cma_percent __initdata;
> +
> +static int __init cmdline_parse_hugetlb_cma(char *p)
> +{
> +	unsigned long long val;
> +	char *endptr;
> +
> +	if (!p)
> +		return -EINVAL;
> +
> +	/* Value may be a percentage of total memory, otherwise bytes */
> +	val = simple_strtoull(p, &endptr, 0);
> +	if (*endptr == '%')
> +		hugetlb_cma_percent = clamp_t(unsigned long, val, 0, 100);
> +	else
> +		hugetlb_cma_size = memparse(p, &p);
> +
> +	return 0;
> +}
> +
> +early_param("hugetlb_cma", cmdline_parse_hugetlb_cma);
> +
> +void __init hugetlb_cma_reserve(void)
> +{
> +	unsigned long totalpages = 0;
> +	unsigned long start_pfn, end_pfn;
> +	phys_addr_t size;
> +	int nid, i, res;
> +
> +	if (!hugetlb_cma_size && !hugetlb_cma_percent)
> +		return;
> +
> +	if (hugetlb_cma_percent) {
> +		for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn,
> +				       NULL)
> +			totalpages += end_pfn - start_pfn;
> +
> +		size = PAGE_SIZE * (hugetlb_cma_percent * 100 * totalpages) /
> +			10000UL;
> +	} else {
> +		size = hugetlb_cma_size;
> +	}
> +
> +	pr_info("hugetlb_cma: reserve %llu, %llu per node\n", size,
> +		size / nr_online_nodes);
> +
> +	size /= nr_online_nodes;
> +
> +	for_each_node_state(nid, N_ONLINE) {
> +		unsigned long min_pfn = 0, max_pfn = 0;
> +
> +		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> +			if (!min_pfn)
> +				min_pfn = start_pfn;
> +			max_pfn = end_pfn;
> +		}

Do you want to compare the range to the size? But besides that, I
believe this really needs to be much more careful. I believe you do not
want to eat a considerable part of the kernel memory because the
resulting configuration will really struggle (yeah all the low mem/high
mem problems all over again).

> +
> +		res = cma_declare_contiguous(PFN_PHYS(min_pfn), size,
> +					     PFN_PHYS(max_pfn), (1UL << 30),
> +					     0, false,
> +					     "hugetlb", &hugetlb_cma[nid]);
> +		if (res) {
> +			pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%llu, %llu)",
> +				res, nid, PFN_PHYS(min_pfn), PFN_PHYS(max_pfn));
> +
> +			for (; nid >= 0; nid--)
> +				hugetlb_cma[nid] = NULL;
> +
> +			break;
> +		}
> +
> +		pr_info("hugetlb_cma: successfully reserved %llu on node %d\n",
> +			size, nid);
> +	}
> +}
> +
> +#else /* CONFIG_CMA */
> +void __init hugetlb_cma_reserve(void)
> +{
> +}
> +
> +#endif /* CONFIG_CMA */
> -- 
> 2.24.1

-- 
Michal Hocko
SUSE Labs
