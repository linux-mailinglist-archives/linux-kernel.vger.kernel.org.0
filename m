Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9467B7BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 03:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfGaBqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 21:46:34 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5552 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaBqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 21:46:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d40f2f60000>; Tue, 30 Jul 2019 18:46:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 30 Jul 2019 18:46:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 30 Jul 2019 18:46:30 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul
 2019 01:46:25 +0000
Subject: Re: [PATCH 1/9] mm: turn migrate_vma upside down
To:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
CC:     Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20190729142843.22320-1-hch@lst.de>
 <20190729142843.22320-2-hch@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <33b82c28-74be-8767-08fa-e41516d11c7e@nvidia.com>
Date:   Tue, 30 Jul 2019 18:46:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190729142843.22320-2-hch@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564537590; bh=7MnDm07YA6/1EF6oVCMUMBB8+x954QrCMPztN0HT8/8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HJmaqb114um9V7s2fZ7rRmnRB/Xz1+k534bbIQW+SWqz9jGawtMNsHCgkCLquQvfU
         CSDAPe1knJGwRwbeGCsG5FL7hF+x5RovCFoD7h7E3/jppKYytMc/WXWZK20e8d6AF3
         TRtKeRJ6K7rbD06ceb40dzik6PqqUOv08vP5nyArzGu9ZvFDaVGCj82qFgIXnGNE7L
         zTqFaY6boNyzagK2gBjRZrdEIyDuxJYkN0JW3KuoP7/Hsus0ZrMOn4g9/SfffIkXrT
         gaJNNlUNWC5Zq3BgRXEZUrAy9d9l3Thvwltji41CFJrWivHZj+itFmL0fnGehx3hko
         lqUWnNdOaRMnQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/29/19 7:28 AM, Christoph Hellwig wrote:
> There isn't any good reason to pass callbacks to migrate_vma.  Instead
> we can just export the three steps done by this function to drivers and
> let them sequence the operation without callbacks.  This removes a lot
> of boilerplate code as-is, and will allow the drivers to drastically
> improve code flow and error handling further on.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   Documentation/vm/hmm.rst               |  55 +-----
>   drivers/gpu/drm/nouveau/nouveau_dmem.c | 122 +++++++------
>   include/linux/migrate.h                | 118 ++----------
>   mm/migrate.c                           | 242 +++++++++++--------------
>   4 files changed, 193 insertions(+), 344 deletions(-)
> 
> diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
> index ddcb5ca8b296..ad880e3996b1 100644
> --- a/Documentation/vm/hmm.rst
> +++ b/Documentation/vm/hmm.rst
> @@ -339,58 +339,9 @@ Migration to and from device memory
>   ===================================
>   
>   Because the CPU cannot access device memory, migration must use the device DMA
> -engine to perform copy from and to device memory. For this we need a new
> -migration helper::
> -
> - int migrate_vma(const struct migrate_vma_ops *ops,
> -                 struct vm_area_struct *vma,
> -                 unsigned long mentries,
> -                 unsigned long start,
> -                 unsigned long end,
> -                 unsigned long *src,
> -                 unsigned long *dst,
> -                 void *private);
> -
> -Unlike other migration functions it works on a range of virtual address, there
> -are two reasons for that. First, device DMA copy has a high setup overhead cost
> -and thus batching multiple pages is needed as otherwise the migration overhead
> -makes the whole exercise pointless. The second reason is because the
> -migration might be for a range of addresses the device is actively accessing.
> -
> -The migrate_vma_ops struct defines two callbacks. First one (alloc_and_copy())
> -controls destination memory allocation and copy operation. Second one is there
> -to allow the device driver to perform cleanup operations after migration::
> -
> - struct migrate_vma_ops {
> -     void (*alloc_and_copy)(struct vm_area_struct *vma,
> -                            const unsigned long *src,
> -                            unsigned long *dst,
> -                            unsigned long start,
> -                            unsigned long end,
> -                            void *private);
> -     void (*finalize_and_map)(struct vm_area_struct *vma,
> -                              const unsigned long *src,
> -                              const unsigned long *dst,
> -                              unsigned long start,
> -                              unsigned long end,
> -                              void *private);
> - };
> -
> -It is important to stress that these migration helpers allow for holes in the
> -virtual address range. Some pages in the range might not be migrated for all
> -the usual reasons (page is pinned, page is locked, ...). This helper does not
> -fail but just skips over those pages.
> -
> -The alloc_and_copy() might decide to not migrate all pages in the
> -range (for reasons under the callback control). For those, the callback just
> -has to leave the corresponding dst entry empty.
> -
> -Finally, the migration of the struct page might fail (for file backed page) for
> -various reasons (failure to freeze reference, or update page cache, ...). If
> -that happens, then the finalize_and_map() can catch any pages that were not
> -migrated. Note those pages were still copied to a new page and thus we wasted
> -bandwidth but this is considered as a rare event and a price that we are
> -willing to pay to keep all the code simpler.
> +engine to perform copy from and to device memory. For this we need a new to
> +use migrate_vma_setup(), migrate_vma_pages(), and migrate_vma_finalize()
> +helpers.
>   
>   
>   Memory cgroup (memcg) and rss accounting
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index 345c63cb752a..38416798abd4 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -131,9 +131,8 @@ nouveau_dmem_fault_alloc_and_copy(struct vm_area_struct *vma,
>   				  unsigned long *dst_pfns,
>   				  unsigned long start,
>   				  unsigned long end,
> -				  void *private)
> +				  struct nouveau_dmem_fault *fault)
>   {
> -	struct nouveau_dmem_fault *fault = private;
>   	struct nouveau_drm *drm = fault->drm;
>   	struct device *dev = drm->dev->dev;
>   	unsigned long addr, i, npages = 0;
> @@ -230,14 +229,9 @@ nouveau_dmem_fault_alloc_and_copy(struct vm_area_struct *vma,
>   	}
>   }
>   
> -void nouveau_dmem_fault_finalize_and_map(struct vm_area_struct *vma,
> -					 const unsigned long *src_pfns,
> -					 const unsigned long *dst_pfns,
> -					 unsigned long start,
> -					 unsigned long end,
> -					 void *private)
> +static void
> +nouveau_dmem_fault_finalize_and_map(struct nouveau_dmem_fault *fault)
>   {
> -	struct nouveau_dmem_fault *fault = private;
>   	struct nouveau_drm *drm = fault->drm;
>   
>   	if (fault->fence) {
> @@ -257,29 +251,35 @@ void nouveau_dmem_fault_finalize_and_map(struct vm_area_struct *vma,
>   	kfree(fault->dma);
>   }
>   
> -static const struct migrate_vma_ops nouveau_dmem_fault_migrate_ops = {
> -	.alloc_and_copy		= nouveau_dmem_fault_alloc_and_copy,
> -	.finalize_and_map	= nouveau_dmem_fault_finalize_and_map,
> -};
> -
>   static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
>   {
>   	struct nouveau_dmem *dmem = page_to_dmem(vmf->page);
>   	unsigned long src[1] = {0}, dst[1] = {0};
> +	struct migrate_vma args = {
> +		.vma		= vmf->vma,
> +		.start		= vmf->address,
> +		.end		= vmf->address + PAGE_SIZE,
> +		.src		= src,
> +		.dst		= dst,
> +	};
>   	struct nouveau_dmem_fault fault = { .drm = dmem->drm };
> -	int ret;
>   
>   	/*
>   	 * FIXME what we really want is to find some heuristic to migrate more
>   	 * than just one page on CPU fault. When such fault happens it is very
>   	 * likely that more surrounding page will CPU fault too.
>   	 */
> -	ret = migrate_vma(&nouveau_dmem_fault_migrate_ops, vmf->vma,
> -			vmf->address, vmf->address + PAGE_SIZE,
> -			src, dst, &fault);
> -	if (ret)
> +	if (migrate_vma_setup(&args) < 0)
>   		return VM_FAULT_SIGBUS;
> +	if (!args.cpages)
> +		return 0;
> +
> +	nouveau_dmem_fault_alloc_and_copy(args.vma, src, dst, args.start,
> +			args.end, &fault);
> +	migrate_vma_pages(&args);
> +	nouveau_dmem_fault_finalize_and_map(&fault);
>   
> +	migrate_vma_finalize(&args);
>   	if (dst[0] == MIGRATE_PFN_ERROR)
>   		return VM_FAULT_SIGBUS;
>   
> @@ -648,9 +648,8 @@ nouveau_dmem_migrate_alloc_and_copy(struct vm_area_struct *vma,
>   				    unsigned long *dst_pfns,
>   				    unsigned long start,
>   				    unsigned long end,
> -				    void *private)
> +				    struct nouveau_migrate *migrate)
>   {
> -	struct nouveau_migrate *migrate = private;
>   	struct nouveau_drm *drm = migrate->drm;
>   	struct device *dev = drm->dev->dev;
>   	unsigned long addr, i, npages = 0;
> @@ -747,14 +746,9 @@ nouveau_dmem_migrate_alloc_and_copy(struct vm_area_struct *vma,
>   	}
>   }
>   
> -void nouveau_dmem_migrate_finalize_and_map(struct vm_area_struct *vma,
> -					   const unsigned long *src_pfns,
> -					   const unsigned long *dst_pfns,
> -					   unsigned long start,
> -					   unsigned long end,
> -					   void *private)
> +static void
> +nouveau_dmem_migrate_finalize_and_map(struct nouveau_migrate *migrate)
>   {
> -	struct nouveau_migrate *migrate = private;
>   	struct nouveau_drm *drm = migrate->drm;
>   
>   	if (migrate->fence) {
> @@ -779,10 +773,15 @@ void nouveau_dmem_migrate_finalize_and_map(struct vm_area_struct *vma,
>   	 */
>   }
>   
> -static const struct migrate_vma_ops nouveau_dmem_migrate_ops = {
> -	.alloc_and_copy		= nouveau_dmem_migrate_alloc_and_copy,
> -	.finalize_and_map	= nouveau_dmem_migrate_finalize_and_map,
> -};
> +static void nouveau_dmem_migrate_chunk(struct migrate_vma *args,
> +		struct nouveau_migrate *migrate)
> +{
> +	nouveau_dmem_migrate_alloc_and_copy(args->vma, args->src, args->dst,
> +			args->start, args->end, migrate);
> +	migrate_vma_pages(args);
> +	nouveau_dmem_migrate_finalize_and_map(migrate);
> +	migrate_vma_finalize(args);
> +}
>   
>   int
>   nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
> @@ -790,40 +789,45 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
>   			 unsigned long start,
>   			 unsigned long end)
>   {
> -	unsigned long *src_pfns, *dst_pfns, npages;
> -	struct nouveau_migrate migrate = {0};
> -	unsigned long i, c, max;
> -	int ret = 0;
> -
> -	npages = (end - start) >> PAGE_SHIFT;
> -	max = min(SG_MAX_SINGLE_ALLOC, npages);
> -	src_pfns = kzalloc(sizeof(long) * max, GFP_KERNEL);
> -	if (src_pfns == NULL)
> -		return -ENOMEM;
> -	dst_pfns = kzalloc(sizeof(long) * max, GFP_KERNEL);
> -	if (dst_pfns == NULL) {
> -		kfree(src_pfns);
> -		return -ENOMEM;
> -	}
> +	unsigned long npages = (end - start) >> PAGE_SHIFT;
> +	unsigned long max = min(SG_MAX_SINGLE_ALLOC, npages);
> +	struct migrate_vma args = {
> +		.vma		= vma,
> +		.start		= start,
> +	};
> +	struct nouveau_migrate migrate = {
> +		.drm		= drm,
> +		.vma		= vma,
> +		.npages		= npages,
> +	};
> +	unsigned long c, i;
> +	int ret = -ENOMEM;
> +
> +	args.src = kzalloc(sizeof(long) * max, GFP_KERNEL);
> +	if (!args.src)
> +		goto out;
> +	args.dst = kzalloc(sizeof(long) * max, GFP_KERNEL);
> +	if (!args.dst)
> +		goto out_free_src;
>   
> -	migrate.drm = drm;
> -	migrate.vma = vma;
> -	migrate.npages = npages;
>   	for (i = 0; i < npages; i += c) {
> -		unsigned long next;
> -
>   		c = min(SG_MAX_SINGLE_ALLOC, npages);
> -		next = start + (c << PAGE_SHIFT);
> -		ret = migrate_vma(&nouveau_dmem_migrate_ops, vma, start,
> -				  next, src_pfns, dst_pfns, &migrate);
> +		args.end = start + (c << PAGE_SHIFT);

Since migrate_vma_setup() is called in a loop, either args.cpages and
args.npages need to be cleared here or cleared in migrate_vma_setup().

> +		ret = migrate_vma_setup(&args);
>   		if (ret)
> -			goto out;
> -		start = next;
> +			goto out_free_dst;
> +
> +		if (args.cpages)
> +			nouveau_dmem_migrate_chunk(&args, &migrate);
> +		args.start = args.end;
>   	}
>   
> +	ret = 0;
> +out_free_dst:
> +	kfree(args.dst);
> +out_free_src:
> +	kfree(args.src);
>   out:
> -	kfree(dst_pfns);
> -	kfree(src_pfns);
>   	return ret;
>   }
>   
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 7f04754c7f2b..093d67fcf6dd 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -182,107 +182,27 @@ static inline unsigned long migrate_pfn(unsigned long pfn)
>   	return (pfn << MIGRATE_PFN_SHIFT) | MIGRATE_PFN_VALID;
>   }
>   
> -/*
> - * struct migrate_vma_ops - migrate operation callback
> - *
> - * @alloc_and_copy: alloc destination memory and copy source memory to it
> - * @finalize_and_map: allow caller to map the successfully migrated pages
> - *
> - *
> - * The alloc_and_copy() callback happens once all source pages have been locked,
> - * unmapped and checked (checked whether pinned or not). All pages that can be
> - * migrated will have an entry in the src array set with the pfn value of the
> - * page and with the MIGRATE_PFN_VALID and MIGRATE_PFN_MIGRATE flag set (other
> - * flags might be set but should be ignored by the callback).
> - *
> - * The alloc_and_copy() callback can then allocate destination memory and copy
> - * source memory to it for all those entries (ie with MIGRATE_PFN_VALID and
> - * MIGRATE_PFN_MIGRATE flag set). Once these are allocated and copied, the
> - * callback must update each corresponding entry in the dst array with the pfn
> - * value of the destination page and with the MIGRATE_PFN_VALID and
> - * MIGRATE_PFN_LOCKED flags set (destination pages must have their struct pages
> - * locked, via lock_page()).
> - *
> - * At this point the alloc_and_copy() callback is done and returns.
> - *
> - * Note that the callback does not have to migrate all the pages that are
> - * marked with MIGRATE_PFN_MIGRATE flag in src array unless this is a migration
> - * from device memory to system memory (ie the MIGRATE_PFN_DEVICE flag is also
> - * set in the src array entry). If the device driver cannot migrate a device
> - * page back to system memory, then it must set the corresponding dst array
> - * entry to MIGRATE_PFN_ERROR. This will trigger a SIGBUS if CPU tries to
> - * access any of the virtual addresses originally backed by this page. Because
> - * a SIGBUS is such a severe result for the userspace process, the device
> - * driver should avoid setting MIGRATE_PFN_ERROR unless it is really in an
> - * unrecoverable state.
> - *
> - * For empty entry inside CPU page table (pte_none() or pmd_none() is true) we
> - * do set MIGRATE_PFN_MIGRATE flag inside the corresponding source array thus
> - * allowing device driver to allocate device memory for those unback virtual
> - * address. For this the device driver simply have to allocate device memory
> - * and properly set the destination entry like for regular migration. Note that
> - * this can still fails and thus inside the device driver must check if the
> - * migration was successful for those entry inside the finalize_and_map()
> - * callback just like for regular migration.
> - *
> - * THE alloc_and_copy() CALLBACK MUST NOT CHANGE ANY OF THE SRC ARRAY ENTRIES
> - * OR BAD THINGS WILL HAPPEN !
> - *
> - *
> - * The finalize_and_map() callback happens after struct page migration from
> - * source to destination (destination struct pages are the struct pages for the
> - * memory allocated by the alloc_and_copy() callback).  Migration can fail, and
> - * thus the finalize_and_map() allows the driver to inspect which pages were
> - * successfully migrated, and which were not. Successfully migrated pages will
> - * have the MIGRATE_PFN_MIGRATE flag set for their src array entry.
> - *
> - * It is safe to update device page table from within the finalize_and_map()
> - * callback because both destination and source page are still locked, and the
> - * mmap_sem is held in read mode (hence no one can unmap the range being
> - * migrated).
> - *
> - * Once callback is done cleaning up things and updating its page table (if it
> - * chose to do so, this is not an obligation) then it returns. At this point,
> - * the HMM core will finish up the final steps, and the migration is complete.
> - *
> - * THE finalize_and_map() CALLBACK MUST NOT CHANGE ANY OF THE SRC OR DST ARRAY
> - * ENTRIES OR BAD THINGS WILL HAPPEN !
> - */
> -struct migrate_vma_ops {
> -	void (*alloc_and_copy)(struct vm_area_struct *vma,
> -			       const unsigned long *src,
> -			       unsigned long *dst,
> -			       unsigned long start,
> -			       unsigned long end,
> -			       void *private);
> -	void (*finalize_and_map)(struct vm_area_struct *vma,
> -				 const unsigned long *src,
> -				 const unsigned long *dst,
> -				 unsigned long start,
> -				 unsigned long end,
> -				 void *private);
> +struct migrate_vma {
> +	struct vm_area_struct	*vma;
> + 	/*
> +	 * Both src and dst array must be big enough for
> +	 * (end - start) >> PAGE_SHIFT entries.
> +	 *
> +	 * The src array must not be modified by the caller after
> +	 * migrate_vma_setup(), and must not change the dst array after
> +	 * migrate_vma_pages() returns.
> +	 */
> +	unsigned long		*dst;
> +	unsigned long		*src;
> +	unsigned long		cpages;
> +	unsigned long		npages;
> +	unsigned long		start;
> +	unsigned long		end;
>   };
>   
> -#if defined(CONFIG_MIGRATE_VMA_HELPER)
> -int migrate_vma(const struct migrate_vma_ops *ops,
> -		struct vm_area_struct *vma,
> -		unsigned long start,
> -		unsigned long end,
> -		unsigned long *src,
> -		unsigned long *dst,
> -		void *private);
> -#else
> -static inline int migrate_vma(const struct migrate_vma_ops *ops,
> -			      struct vm_area_struct *vma,
> -			      unsigned long start,
> -			      unsigned long end,
> -			      unsigned long *src,
> -			      unsigned long *dst,
> -			      void *private)
> -{
> -	return -EINVAL;
> -}
> -#endif /* IS_ENABLED(CONFIG_MIGRATE_VMA_HELPER) */
> +int migrate_vma_setup(struct migrate_vma *args);
> +void migrate_vma_pages(struct migrate_vma *migrate);
> +void migrate_vma_finalize(struct migrate_vma *migrate);
>   
>   #endif /* CONFIG_MIGRATION */
>   
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8992741f10aa..dc4e60a496f2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2118,16 +2118,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
>   #endif /* CONFIG_NUMA */
>   
>   #if defined(CONFIG_MIGRATE_VMA_HELPER)
> -struct migrate_vma {
> -	struct vm_area_struct	*vma;
> -	unsigned long		*dst;
> -	unsigned long		*src;
> -	unsigned long		cpages;
> -	unsigned long		npages;
> -	unsigned long		start;
> -	unsigned long		end;
> -};
> -
>   static int migrate_vma_collect_hole(unsigned long start,
>   				    unsigned long end,
>   				    struct mm_walk *walk)
> @@ -2578,6 +2568,108 @@ static void migrate_vma_unmap(struct migrate_vma *migrate)
>   	}
>   }
>   
> +/**
> + * migrate_vma_setup() - prepare to migrate a range of memory
> + * @args: contains the vma, start, and and pfns arrays for the migration
> + *
> + * Returns: negative errno on failures, 0 when 0 or more pages were migrated
> + * without an error.
> + *
> + * Prepare to migrate a range of memory virtual address range by collecting all
> + * the pages backing each virtual address in the range, saving them inside the
> + * src array.  Then lock those pages and unmap them. Once the pages are locked
> + * and unmapped, check whether each page is pinned or not.  Pages that aren't
> + * pinned have the MIGRATE_PFN_MIGRATE flag set (by this function) in the
> + * corresponding src array entry.  Then restores any pages that are pinned, by
> + * remapping and unlocking those pages.
> + *
> + * The caller should then allocate destination memory and copy source memory to
> + * it for all those entries (ie with MIGRATE_PFN_VALID and MIGRATE_PFN_MIGRATE
> + * flag set).  Once these are allocated and copied, the caller must update each
> + * corresponding entry in the dst array with the pfn value of the destination
> + * page and with the MIGRATE_PFN_VALID and MIGRATE_PFN_LOCKED flags set
> + * (destination pages must have their struct pages locked, via lock_page()).
> + *
> + * Note that the caller does not have to migrate all the pages that are marked
> + * with MIGRATE_PFN_MIGRATE flag in src array unless this is a migration from
> + * device memory to system memory.  If the caller cannot migrate a device page
> + * back to system memory, then it must return VM_FAULT_SIGBUS, which will
> + * might have severe consequences for the userspace process, so it should best
> + * be avoided if possible.
> + *
> + * For empty entries inside CPU page table (pte_none() or pmd_none() is true) we
> + * do set MIGRATE_PFN_MIGRATE flag inside the corresponding source array thus
> + * allowing the caller to allocate device memory for those unback virtual
> + * address.  For this the caller simply havs to allocate device memory and
> + * properly set the destination entry like for regular migration.  Note that
> + * this can still fails and thus inside the device driver must check if the
> + * migration was successful for those entries after calling migrate_vma_pages()
> + * just like for regular migration.
> + *
> + * After that, the callers must call migrate_vma_pages() to go over each entry
> + * in the src array that has the MIGRATE_PFN_VALID and MIGRATE_PFN_MIGRATE flag
> + * set. If the corresponding entry in dst array has MIGRATE_PFN_VALID flag set,
> + * then migrate_vma_pages() to migrate struct page information from the source
> + * struct page to the destination struct page.  If it fails to migrate the
> + * struct page information, then it clears the MIGRATE_PFN_MIGRATE flag in the
> + * src array.
> + *
> + * At this point all successfully migrated pages have an entry in the src
> + * array with MIGRATE_PFN_VALID and MIGRATE_PFN_MIGRATE flag set and the dst
> + * array entry with MIGRATE_PFN_VALID flag set.
> + *
> + * Once migrate_vma_pages() returns the caller may inspect which pages were
> + * successfully migrated, and which were not.  Successfully migrated pages will
> + * have the MIGRATE_PFN_MIGRATE flag set for their src array entry.
> + *
> + * It is safe to update device page table from within the finalize_and_map()
> + * callback because both destination and source page are still locked, and the
> + * mmap_sem is held in read mode (hence no one can unmap the range being
> + * migrated).
> + *
> + * Once the caller is done cleaning up things and updating its page table (if it
> + * chose to do so, this is not an obligation) it finally calls
> + * migrate_vma_finalize() to update the CPU page table to point to new pages
> + * for successfully migrated pages or otherwise restore the CPU page table to
> + * point to the original source pages.
> + */
> +int migrate_vma_setup(struct migrate_vma *args)
> +{
> +	long nr_pages = (args->end - args->start) >> PAGE_SHIFT;
> +
> +	args->start &= PAGE_MASK;
> +	args->end &= PAGE_MASK;
> +	if (!args->vma || is_vm_hugetlb_page(args->vma) ||
> +	    (args->vma->vm_flags & VM_SPECIAL) || vma_is_dax(args->vma))
> +		return -EINVAL;
> +	if (nr_pages <= 0)
> +		return -EINVAL;
> +	if (args->start < args->vma->vm_start ||
> +	    args->start >= args->vma->vm_end)
> +		return -EINVAL;
> +	if (args->end <= args->vma->vm_start || args->end > args->vma->vm_end)
> +		return -EINVAL;
> +	if (!args->src || !args->dst)
> +		return -EINVAL;
> +
> +	memset(args->src, 0, sizeof(*args->src) * nr_pages);
> +
> +	migrate_vma_collect(args);
> +	if (args->cpages)
> +		migrate_vma_prepare(args);
> +	if (args->cpages)
> +		migrate_vma_unmap(args);
> +
> +	/*
> +	 * At this point pages are locked and unmapped, and thus they have
> +	 * stable content and can safely be copied to destination memory that
> +	 * is allocated by the drivers.
> +	 */
> +	return 0;
> +
> +}
> +EXPORT_SYMBOL(migrate_vma_setup);
> +
>   static void migrate_vma_insert_page(struct migrate_vma *migrate,
>   				    unsigned long addr,
>   				    struct page *page,
> @@ -2709,7 +2801,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
>   	*src &= ~MIGRATE_PFN_MIGRATE;
>   }
>   
> -/*
> +/**
>    * migrate_vma_pages() - migrate meta-data from src page to dst page
>    * @migrate: migrate struct containing all migration information
>    *
> @@ -2717,7 +2809,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
>    * struct page. This effectively finishes the migration from source page to the
>    * destination page.
>    */
> -static void migrate_vma_pages(struct migrate_vma *migrate)
> +void migrate_vma_pages(struct migrate_vma *migrate)
>   {
>   	const unsigned long npages = migrate->npages;
>   	const unsigned long start = migrate->start;
> @@ -2791,8 +2883,9 @@ static void migrate_vma_pages(struct migrate_vma *migrate)
>   	if (notified)
>   		mmu_notifier_invalidate_range_only_end(&range);
>   }
> +EXPORT_SYMBOL(migrate_vma_pages);
>   
> -/*
> +/**
>    * migrate_vma_finalize() - restore CPU page table entry
>    * @migrate: migrate struct containing all migration information
>    *
> @@ -2803,7 +2896,7 @@ static void migrate_vma_pages(struct migrate_vma *migrate)
>    * This also unlocks the pages and puts them back on the lru, or drops the extra
>    * refcount, for device pages.
>    */
> -static void migrate_vma_finalize(struct migrate_vma *migrate)
> +void migrate_vma_finalize(struct migrate_vma *migrate)
>   {
>   	const unsigned long npages = migrate->npages;
>   	unsigned long i;
> @@ -2846,124 +2939,5 @@ static void migrate_vma_finalize(struct migrate_vma *migrate)
>   		}
>   	}
>   }
> -
> -/*
> - * migrate_vma() - migrate a range of memory inside vma
> - *
> - * @ops: migration callback for allocating destination memory and copying
> - * @vma: virtual memory area containing the range to be migrated
> - * @start: start address of the range to migrate (inclusive)
> - * @end: end address of the range to migrate (exclusive)
> - * @src: array of hmm_pfn_t containing source pfns
> - * @dst: array of hmm_pfn_t containing destination pfns
> - * @private: pointer passed back to each of the callback
> - * Returns: 0 on success, error code otherwise
> - *
> - * This function tries to migrate a range of memory virtual address range, using
> - * callbacks to allocate and copy memory from source to destination. First it
> - * collects all the pages backing each virtual address in the range, saving this
> - * inside the src array. Then it locks those pages and unmaps them. Once the pages
> - * are locked and unmapped, it checks whether each page is pinned or not. Pages
> - * that aren't pinned have the MIGRATE_PFN_MIGRATE flag set (by this function)
> - * in the corresponding src array entry. It then restores any pages that are
> - * pinned, by remapping and unlocking those pages.
> - *
> - * At this point it calls the alloc_and_copy() callback. For documentation on
> - * what is expected from that callback, see struct migrate_vma_ops comments in
> - * include/linux/migrate.h
> - *
> - * After the alloc_and_copy() callback, this function goes over each entry in
> - * the src array that has the MIGRATE_PFN_VALID and MIGRATE_PFN_MIGRATE flag
> - * set. If the corresponding entry in dst array has MIGRATE_PFN_VALID flag set,
> - * then the function tries to migrate struct page information from the source
> - * struct page to the destination struct page. If it fails to migrate the struct
> - * page information, then it clears the MIGRATE_PFN_MIGRATE flag in the src
> - * array.
> - *
> - * At this point all successfully migrated pages have an entry in the src
> - * array with MIGRATE_PFN_VALID and MIGRATE_PFN_MIGRATE flag set and the dst
> - * array entry with MIGRATE_PFN_VALID flag set.
> - *
> - * It then calls the finalize_and_map() callback. See comments for "struct
> - * migrate_vma_ops", in include/linux/migrate.h for details about
> - * finalize_and_map() behavior.
> - *
> - * After the finalize_and_map() callback, for successfully migrated pages, this
> - * function updates the CPU page table to point to new pages, otherwise it
> - * restores the CPU page table to point to the original source pages.
> - *
> - * Function returns 0 after the above steps, even if no pages were migrated
> - * (The function only returns an error if any of the arguments are invalid.)
> - *
> - * Both src and dst array must be big enough for (end - start) >> PAGE_SHIFT
> - * unsigned long entries.
> - */
> -int migrate_vma(const struct migrate_vma_ops *ops,
> -		struct vm_area_struct *vma,
> -		unsigned long start,
> -		unsigned long end,
> -		unsigned long *src,
> -		unsigned long *dst,
> -		void *private)
> -{
> -	struct migrate_vma migrate;
> -
> -	/* Sanity check the arguments */
> -	start &= PAGE_MASK;
> -	end &= PAGE_MASK;
> -	if (!vma || is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_SPECIAL) ||
> -			vma_is_dax(vma))
> -		return -EINVAL;
> -	if (start < vma->vm_start || start >= vma->vm_end)
> -		return -EINVAL;
> -	if (end <= vma->vm_start || end > vma->vm_end)
> -		return -EINVAL;
> -	if (!ops || !src || !dst || start >= end)
> -		return -EINVAL;
> -
> -	memset(src, 0, sizeof(*src) * ((end - start) >> PAGE_SHIFT));
> -	migrate.src = src;
> -	migrate.dst = dst;
> -	migrate.start = start;
> -	migrate.npages = 0;
> -	migrate.cpages = 0;
> -	migrate.end = end;
> -	migrate.vma = vma;
> -
> -	/* Collect, and try to unmap source pages */
> -	migrate_vma_collect(&migrate);
> -	if (!migrate.cpages)
> -		return 0;
> -
> -	/* Lock and isolate page */
> -	migrate_vma_prepare(&migrate);
> -	if (!migrate.cpages)
> -		return 0;
> -
> -	/* Unmap pages */
> -	migrate_vma_unmap(&migrate);
> -	if (!migrate.cpages)
> -		return 0;
> -
> -	/*
> -	 * At this point pages are locked and unmapped, and thus they have
> -	 * stable content and can safely be copied to destination memory that
> -	 * is allocated by the callback.
> -	 *
> -	 * Note that migration can fail in migrate_vma_struct_page() for each
> -	 * individual page.
> -	 */
> -	ops->alloc_and_copy(vma, src, dst, start, end, private);
> -
> -	/* This does the real migration of struct page */
> -	migrate_vma_pages(&migrate);
> -
> -	ops->finalize_and_map(vma, src, dst, start, end, private);
> -
> -	/* Unlock and remap pages */
> -	migrate_vma_finalize(&migrate);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(migrate_vma);
> +EXPORT_SYMBOL(migrate_vma_finalize);
>   #endif /* defined(MIGRATE_VMA_HELPER) */
> 
