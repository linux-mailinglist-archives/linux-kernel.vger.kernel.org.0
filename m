Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 572E4E8A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 19:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfD2RR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 13:17:58 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12535 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbfD2RRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:17:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc731c30001>; Mon, 29 Apr 2019 10:17:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 29 Apr 2019 10:17:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 29 Apr 2019 10:17:49 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Apr
 2019 17:17:48 +0000
Subject: Re: [PATCH 3/9] mm: Add write-protect and clean utilities for address
 space ranges v3
To:     Thomas Hellstrom <thellstrom@vmware.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Pv-drivers <Pv-drivers@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20190424115918.3380-4-thellstrom@vmware.com>
 <20190427150023.52756-1-thellstrom@vmware.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <6157cdda-05cc-e1cc-9928-dcf98ef29eb2@nvidia.com>
Date:   Mon, 29 Apr 2019 10:17:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190427150023.52756-1-thellstrom@vmware.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556558276; bh=LWvVCVi0lSyNy2mHK4cK7KgvOHxSFS0SY1xqRgBIoAw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=r00GhsVb2gXEKDEwXGN3pMtmUs+qR2m+euvNVj3yZC0AGZiYnKiLUHk+2tUcVVard
         T6B82VAW5dm+MertxhWlWqhil6TqD2o/Clvcf6XrGQE7lyj2AAJWEpDWCAdjMrTUqE
         6ehtfTr++bn7RljNBA0chUarPwfEvyGaf8ymYmtf4LfcFCnL2hVHczswaEEHECnmMa
         Ig837XT2b/YRh9EwnyBvtsnvNYF21KHw2hqKEP2MItIxIx8FuexvLRA01MAIDKCOhb
         Elwo4Z7Eh519X0Ibm7aEjAybIgNLX8F1bo3Nc6TnAgGi+dM9OU18qQP9HiXbvcHkBv
         e/sAQtvtZp44A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: the subject line should be [PATCH v3 3/9] ... instead of putting=20
v3 at the end of the subject line.
There are tools that parse the subject line and expect this convention.
See Documentation/process/submitting-patches.rst
Thanks.

On 4/27/19 8:01 AM, Thomas Hellstrom wrote:
> Add two utilities to a) write-protect and b) clean all ptes pointing into
> a range of an address space.
> The utilities are intended to aid in tracking dirty pages (either
> driver-allocated system memory or pci device memory).
> The write-protect utility should be used in conjunction with
> page_mkwrite() and pfn_mkwrite() to trigger write page-faults on page
> accesses. Typically one would want to use this on sparse accesses into
> large memory regions. The clean utility should be used to utilize
> hardware dirtying functionality and avoid the overhead of page-faults,
> typically on large accesses into small memory regions.
>=20
> The added file "as_dirty_helpers.c" is initially listed as maintained by
> VMware under our DRM driver. If somebody would like it elsewhere,
> that's of course no problem.
>=20
> Notable changes since RFC:
> - Added comments to help avoid the usage of these function for VMAs
>    it's not intended for. We also do advisory checks on the vm_flags and
>    warn on illegal usage.
> - Perform the pte modifications the same way softdirty does.
> - Add mmu_notifier range invalidation calls.
> - Add a config option so that this code is not unconditionally included.
> - Tell the mmu_gather code about pending tlb flushes.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
>=20
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com> #v1
> ---
> v2: Fix formatting and typos.
>      Change file-name of the added file, and don't compile it unless
>      configured to do so.
> v3: Adapt to new arguments to ptep_modify_prot_[start|commit]
> ---
>   MAINTAINERS           |   1 +
>   include/linux/mm.h    |   9 +-
>   mm/Kconfig            |   3 +
>   mm/Makefile           |   1 +
>   mm/as_dirty_helpers.c | 298 ++++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 311 insertions(+), 1 deletion(-)
>   create mode 100644 mm/as_dirty_helpers.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e233b3c48546..dd647a68580f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5100,6 +5100,7 @@ T:	git git://people.freedesktop.org/~thomash/linux
>   S:	Supported
>   F:	drivers/gpu/drm/vmwgfx/
>   F:	include/uapi/drm/vmwgfx_drm.h
> +F:	mm/as_dirty_helpers.c
>  =20
>   DRM DRIVERS
>   M:	David Airlie <airlied@linux.ie>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 34338ee70317..e446af9732f6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2610,7 +2610,14 @@ struct pfn_range_apply {
>   };
>   extern int apply_to_pfn_range(struct pfn_range_apply *closure,
>   			      unsigned long address, unsigned long size);
> -
> +unsigned long apply_as_wrprotect(struct address_space *mapping,
> +				 pgoff_t first_index, pgoff_t nr);
> +unsigned long apply_as_clean(struct address_space *mapping,
> +			     pgoff_t first_index, pgoff_t nr,
> +			     pgoff_t bitmap_pgoff,
> +			     unsigned long *bitmap,
> +			     pgoff_t *start,
> +			     pgoff_t *end);
>   #ifdef CONFIG_PAGE_POISONING
>   extern bool page_poisoning_enabled(void);
>   extern void kernel_poison_pages(struct page *page, int numpages, int en=
able);
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 25c71eb8a7db..80e41cdbb4ae 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -758,4 +758,7 @@ config GUP_BENCHMARK
>   config ARCH_HAS_PTE_SPECIAL
>   	bool
>  =20
> +config AS_DIRTY_HELPERS
> +        bool
> +
>   endmenu
> diff --git a/mm/Makefile b/mm/Makefile
> index d210cc9d6f80..4bf396ba3a00 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -99,3 +99,4 @@ obj-$(CONFIG_HARDENED_USERCOPY) +=3D usercopy.o
>   obj-$(CONFIG_PERCPU_STATS) +=3D percpu-stats.o
>   obj-$(CONFIG_HMM) +=3D hmm.o
>   obj-$(CONFIG_MEMFD_CREATE) +=3D memfd.o
> +obj-$(CONFIG_AS_DIRTY_HELPERS) +=3D as_dirty_helpers.o
> diff --git a/mm/as_dirty_helpers.c b/mm/as_dirty_helpers.c
> new file mode 100644
> index 000000000000..88a1ac0d5da9
> --- /dev/null
> +++ b/mm/as_dirty_helpers.c
> @@ -0,0 +1,298 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/mm.h>
> +#include <linux/mm_types.h>
> +#include <linux/hugetlb.h>
> +#include <linux/bitops.h>
> +#include <linux/mmu_notifier.h>
> +#include <asm/cacheflush.h>
> +#include <asm/tlbflush.h>
> +
> +/**
> + * struct apply_as - Closure structure for apply_as_range
> + * @base: struct pfn_range_apply we derive from
> + * @start: Address of first modified pte
> + * @end: Address of last modified pte + 1
> + * @total: Total number of modified ptes
> + * @vma: Pointer to the struct vm_area_struct we're currently operating =
on
> + */
> +struct apply_as {
> +	struct pfn_range_apply base;
> +	unsigned long start;
> +	unsigned long end;
> +	unsigned long total;
> +	struct vm_area_struct *vma;
> +};
> +
> +/**
> + * apply_pt_wrprotect - Leaf pte callback to write-protect a pte
> + * @pte: Pointer to the pte
> + * @token: Page table token, see apply_to_pfn_range()
> + * @addr: The virtual page address
> + * @closure: Pointer to a struct pfn_range_apply embedded in a
> + * struct apply_as
> + *
> + * The function write-protects a pte and records the range in
> + * virtual address space of touched ptes for efficient range TLB flushes=
.
> + *
> + * Return: Always zero.
> + */
> +static int apply_pt_wrprotect(pte_t *pte, pgtable_t token,
> +			      unsigned long addr,
> +			      struct pfn_range_apply *closure)
> +{
> +	struct apply_as *aas =3D container_of(closure, typeof(*aas), base);
> +	pte_t ptent =3D *pte;
> +
> +	if (pte_write(ptent)) {
> +		pte_t old_pte =3D ptep_modify_prot_start(aas->vma, addr, pte);
> +
> +		ptent =3D pte_wrprotect(old_pte);
> +		ptep_modify_prot_commit(aas->vma, addr, pte, old_pte, ptent);
> +		aas->total++;
> +		aas->start =3D min(aas->start, addr);
> +		aas->end =3D max(aas->end, addr + PAGE_SIZE);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * struct apply_as_clean - Closure structure for apply_as_clean
> + * @base: struct apply_as we derive from
> + * @bitmap_pgoff: Address_space Page offset of the first bit in @bitmap
> + * @bitmap: Bitmap with one bit for each page offset in the address_spac=
e range
> + * covered.
> + * @start: Address_space page offset of first modified pte relative
> + * to @bitmap_pgoff
> + * @end: Address_space page offset of last modified pte relative
> + * to @bitmap_pgoff
> + */
> +struct apply_as_clean {
> +	struct apply_as base;
> +	pgoff_t bitmap_pgoff;
> +	unsigned long *bitmap;
> +	pgoff_t start;
> +	pgoff_t end;
> +};
> +
> +/**
> + * apply_pt_clean - Leaf pte callback to clean a pte
> + * @pte: Pointer to the pte
> + * @token: Page table token, see apply_to_pfn_range()
> + * @addr: The virtual page address
> + * @closure: Pointer to a struct pfn_range_apply embedded in a
> + * struct apply_as_clean
> + *
> + * The function cleans a pte and records the range in
> + * virtual address space of touched ptes for efficient TLB flushes.
> + * It also records dirty ptes in a bitmap representing page offsets
> + * in the address_space, as well as the first and last of the bits
> + * touched.
> + *
> + * Return: Always zero.
> + */
> +static int apply_pt_clean(pte_t *pte, pgtable_t token,
> +			  unsigned long addr,
> +			  struct pfn_range_apply *closure)
> +{
> +	struct apply_as *aas =3D container_of(closure, typeof(*aas), base);
> +	struct apply_as_clean *clean =3D container_of(aas, typeof(*clean), base=
);
> +	pte_t ptent =3D *pte;
> +
> +	if (pte_dirty(ptent)) {
> +		pgoff_t pgoff =3D ((addr - aas->vma->vm_start) >> PAGE_SHIFT) +
> +			aas->vma->vm_pgoff - clean->bitmap_pgoff;
> +		pte_t old_pte =3D ptep_modify_prot_start(aas->vma, addr, pte);
> +
> +		ptent =3D pte_mkclean(old_pte);
> +		ptep_modify_prot_commit(aas->vma, addr, pte, old_pte, ptent);
> +
> +		aas->total++;
> +		aas->start =3D min(aas->start, addr);
> +		aas->end =3D max(aas->end, addr + PAGE_SIZE);
> +
> +		__set_bit(pgoff, clean->bitmap);
> +		clean->start =3D min(clean->start, pgoff);
> +		clean->end =3D max(clean->end, pgoff + 1);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * apply_as_range - Apply a pte callback to all PTEs pointing into a ran=
ge
> + * of an address_space.
> + * @mapping: Pointer to the struct address_space
> + * @aas: Closure structure
> + * @first_index: First page offset in the address_space
> + * @nr: Number of incremental page offsets to cover
> + *
> + * Return: Number of ptes touched. Note that this number might be larger
> + * than @nr if there are overlapping vmas
> + */
> +static unsigned long apply_as_range(struct address_space *mapping,
> +				    struct apply_as *aas,
> +				    pgoff_t first_index, pgoff_t nr)
> +{
> +	struct vm_area_struct *vma;
> +	pgoff_t vba, vea, cba, cea;
> +	unsigned long start_addr, end_addr;
> +	struct mmu_notifier_range range;
> +
> +	i_mmap_lock_read(mapping);
> +	vma_interval_tree_foreach(vma, &mapping->i_mmap, first_index,
> +				  first_index + nr - 1) {
> +		unsigned long vm_flags =3D READ_ONCE(vma->vm_flags);
> +
> +		/*
> +		 * We can only do advisory flag tests below, since we can't
> +		 * require the vm's mmap_sem to be held to protect the flags.
> +		 * Therefore, callers that strictly depend on specific mmap
> +		 * flags to remain constant throughout the operation must
> +		 * either ensure those flags are immutable for all relevant
> +		 * vmas or can't use this function. Fixing this properly would
> +		 * require the vma::vm_flags to be protected by a separate
> +		 * lock taken after the i_mmap_lock
> +		 */
> +
> +		/* Skip non-applicable VMAs */
> +		if ((vm_flags & (VM_SHARED | VM_WRITE)) !=3D
> +		    (VM_SHARED | VM_WRITE))
> +			continue;
> +
> +		/* Warn on and skip VMAs whose flags indicate illegal usage */
> +		if (WARN_ON((vm_flags & (VM_HUGETLB | VM_IO)) !=3D VM_IO))
> +			continue;
> +
> +		/* Clip to the vma */
> +		vba =3D vma->vm_pgoff;
> +		vea =3D vba + vma_pages(vma);
> +		cba =3D first_index;
> +		cba =3D max(cba, vba);
> +		cea =3D first_index + nr;
> +		cea =3D min(cea, vea);
> +
> +		/* Translate to virtual address */
> +		start_addr =3D ((cba - vba) << PAGE_SHIFT) + vma->vm_start;
> +		end_addr =3D ((cea - vba) << PAGE_SHIFT) + vma->vm_start;
> +		if (start_addr >=3D end_addr)
> +			continue;
> +
> +		aas->base.mm =3D vma->vm_mm;
> +		aas->vma =3D vma;
> +		aas->start =3D end_addr;
> +		aas->end =3D start_addr;
> +
> +		mmu_notifier_range_init(&range, vma->vm_mm,
> +					start_addr, end_addr);
> +		mmu_notifier_invalidate_range_start(&range);
> +
> +		/* Needed when we only change protection? */
> +		flush_cache_range(vma, start_addr, end_addr);
> +
> +		/*
> +		 * We're not using tlb_gather_mmu() since typically
> +		 * only a small subrange of PTEs are affected.
> +		 */
> +		inc_tlb_flush_pending(vma->vm_mm);
> +
> +		/* Should not error since aas->base.alloc =3D=3D 0 */
> +		WARN_ON(apply_to_pfn_range(&aas->base, start_addr,
> +					   end_addr - start_addr));
> +		if (aas->end > aas->start)
> +			flush_tlb_range(vma, aas->start, aas->end);
> +
> +		mmu_notifier_invalidate_range_end(&range);
> +		dec_tlb_flush_pending(vma->vm_mm);
> +	}
> +	i_mmap_unlock_read(mapping);
> +
> +	return aas->total;
> +}
> +
> +/**
> + * apply_as_wrprotect - Write-protect all ptes in an address_space range
> + * @mapping: The address_space we want to write protect
> + * @first_index: The first page offset in the range
> + * @nr: Number of incremental page offsets to cover
> + *
> + * WARNING: This function should only be used for address spaces that
> + * completely own the pages / memory the page table points to. Typically=
 a
> + * device file.
> + *
> + * Return: The number of ptes actually write-protected. Note that
> + * already write-protected ptes are not counted.
> + */
> +unsigned long apply_as_wrprotect(struct address_space *mapping,
> +				 pgoff_t first_index, pgoff_t nr)
> +{
> +	struct apply_as aas =3D {
> +		.base =3D {
> +			.alloc =3D 0,
> +			.ptefn =3D apply_pt_wrprotect,
> +		},
> +		.total =3D 0,
> +	};
> +
> +	return apply_as_range(mapping, &aas, first_index, nr);
> +}
> +EXPORT_SYMBOL(apply_as_wrprotect);
> +
> +/**
> + * apply_as_clean - Clean all ptes in an address_space range
> + * @mapping: The address_space we want to clean
> + * @first_index: The first page offset in the range
> + * @nr: Number of incremental page offsets to cover
> + * @bitmap_pgoff: The page offset of the first bit in @bitmap
> + * @bitmap: Pointer to a bitmap of at least @nr bits. The bitmap needs t=
o
> + * cover the whole range @first_index..@first_index + @nr.
> + * @start: Pointer to number of the first set bit in @bitmap.
> + * is modified as new bits are set by the function.
> + * @end: Pointer to the number of the last set bit in @bitmap.
> + * none set. The value is modified as new bits are set by the function.
> + *
> + * Note: When this function returns there is no guarantee that a CPU has
> + * not already dirtied new ptes. However it will not clean any ptes not
> + * reported in the bitmap.
> + *
> + * If a caller needs to make sure all dirty ptes are picked up and none
> + * additional are added, it first needs to write-protect the address-spa=
ce
> + * range and make sure new writers are blocked in page_mkwrite() or
> + * pfn_mkwrite(). And then after a TLB flush following the write-protect=
ion
> + * pick up all dirty bits.
> + *
> + * WARNING: This function should only be used for address spaces that
> + * completely own the pages / memory the page table points to. Typically=
 a
> + * device file.
> + *
> + * Return: The number of dirty ptes actually cleaned.
> + */
> +unsigned long apply_as_clean(struct address_space *mapping,
> +			     pgoff_t first_index, pgoff_t nr,
> +			     pgoff_t bitmap_pgoff,
> +			     unsigned long *bitmap,
> +			     pgoff_t *start,
> +			     pgoff_t *end)
> +{
> +	bool none_set =3D (*start >=3D *end);
> +	struct apply_as_clean clean =3D {
> +		.base =3D {
> +			.base =3D {
> +				.alloc =3D 0,
> +				.ptefn =3D apply_pt_clean,
> +			},
> +			.total =3D 0,
> +		},
> +		.bitmap_pgoff =3D bitmap_pgoff,
> +		.bitmap =3D bitmap,
> +		.start =3D none_set ? nr : *start,
> +		.end =3D none_set ? 0 : *end,
> +	};
> +	unsigned long ret =3D apply_as_range(mapping, &clean.base, first_index,
> +					   nr);
> +
> +	*start =3D clean.start;
> +	*end =3D clean.end;
> +	return ret;
> +}
> +EXPORT_SYMBOL(apply_as_clean);
>=20
