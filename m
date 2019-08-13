Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1BF98B54D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 12:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfHMKUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 06:20:53 -0400
Received: from foss.arm.com ([217.140.110.172]:33324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbfHMKUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:20:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9537344;
        Tue, 13 Aug 2019 03:20:52 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 189DE3F694;
        Tue, 13 Aug 2019 03:20:51 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:20:50 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] microblaze: switch to generic version of pte allocation
Message-ID: <20190813102049.GC866@lakrids.cambridge.arm.com>
References: <1565690952-32158-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565690952-32158-1-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 01:09:12PM +0300, Mike Rapoport wrote:
> The microblaze implementation of pte_alloc_one() has a provision to
> allocated PTEs from high memory, but neither CONFIG_HIGHPTE nor pte_map*()
> versions for suitable for HIGHPTE are defined.
> 
> Except that, microblaze version of pte_alloc_one() is identical to the
> generic one as well as the implementations of pte_free() and
> pte_free_kernel().
> 
> Switch microblaze to use the generic versions of these functions.
> Also remove pte_free_slow() that is not referenced anywhere in the code.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> The patch is vs. mmots/master since this tree contains bothi "mm: remove
> quicklist page table caches" and "mm: treewide: clarify
> pgtable_page_{ctor,dtor}() naming" patches that had a conflict resulting in
> a build failure [1].
> 
> [1] https://lore.kernel.org/linux-mm/201908131204.B910fkl1%25lkp@intel.com/

This looks sane to me, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

I guess Andrew will pick this up and fix up the conflict?

Thanks,
Mark.

> 
>  arch/microblaze/include/asm/pgalloc.h | 39 +++--------------------------------
>  1 file changed, 3 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/include/asm/pgalloc.h
> index dbf25a3..7ecb05b 100644
> --- a/arch/microblaze/include/asm/pgalloc.h
> +++ b/arch/microblaze/include/asm/pgalloc.h
> @@ -21,6 +21,9 @@
>  #include <asm/cache.h>
>  #include <asm/pgtable.h>
>  
> +#define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
> +#include <asm-generic/pgalloc.h>
> +
>  extern void __bad_pte(pmd_t *pmd);
>  
>  static inline pgd_t *get_pgd(void)
> @@ -47,42 +50,6 @@ static inline void free_pgd(pgd_t *pgd)
>  
>  extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
>  
> -static inline struct page *pte_alloc_one(struct mm_struct *mm)
> -{
> -	struct page *ptepage;
> -
> -#ifdef CONFIG_HIGHPTE
> -	int flags = GFP_KERNEL | __GFP_ZERO | __GFP_HIGHMEM;
> -#else
> -	int flags = GFP_KERNEL | __GFP_ZERO;
> -#endif
> -
> -	ptepage = alloc_pages(flags, 0);
> -	if (!ptepage)
> -		return NULL;
> -	if (!pgtable_page_ctor(ptepage)) {
> -		__free_page(ptepage);
> -		return NULL;
> -	}
> -	return ptepage;
> -}
> -
> -static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> -{
> -	free_page((unsigned long)pte);
> -}
> -
> -static inline void pte_free_slow(struct page *ptepage)
> -{
> -	__free_page(ptepage);
> -}
> -
> -static inline void pte_free(struct mm_struct *mm, struct page *ptepage)
> -{
> -	pgtable_pte_page_dtor(ptepage);
> -	__free_page(ptepage);
> -}
> -
>  #define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, (pte))
>  
>  #define pmd_populate(mm, pmd, pte) \
> -- 
> 2.7.4
> 
