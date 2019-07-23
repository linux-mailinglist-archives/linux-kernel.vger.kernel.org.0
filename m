Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3CE3715CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 12:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387939AbfGWKOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 06:14:38 -0400
Received: from foss.arm.com ([217.140.110.172]:52166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730145AbfGWKOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:14:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A171337;
        Tue, 23 Jul 2019 03:14:37 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29D043F71A;
        Tue, 23 Jul 2019 03:14:35 -0700 (PDT)
Date:   Tue, 23 Jul 2019 11:14:33 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 11/21] mm: pagewalk: Add p4d_entry() and pgd_entry()
Message-ID: <20190723101432.GC8085@lakrids.cambridge.arm.com>
References: <20190722154210.42799-1-steven.price@arm.com>
 <20190722154210.42799-12-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722154210.42799-12-steven.price@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 04:42:00PM +0100, Steven Price wrote:
> pgd_entry() and pud_entry() were removed by commit 0b1fbfe50006c410
> ("mm/pagewalk: remove pgd_entry() and pud_entry()") because there were
> no users. We're about to add users so reintroduce them, along with
> p4d_entry() as we now have 5 levels of tables.
> 
> Note that commit a00cc7d9dd93d66a ("mm, x86: add support for
> PUD-sized transparent hugepages") already re-added pud_entry() but with
> different semantics to the other callbacks. Since there have never
> been upstream users of this, revert the semantics back to match the
> other callbacks. This means pud_entry() is called for all entries, not
> just transparent huge pages.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  include/linux/mm.h | 15 +++++++++------
>  mm/pagewalk.c      | 27 ++++++++++++++++-----------
>  2 files changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0334ca97c584..b22799129128 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1432,15 +1432,14 @@ void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
>  
>  /**
>   * mm_walk - callbacks for walk_page_range
> - * @pud_entry: if set, called for each non-empty PUD (2nd-level) entry
> - *	       this handler should only handle pud_trans_huge() puds.
> - *	       the pmd_entry or pte_entry callbacks will be used for
> - *	       regular PUDs.
> - * @pmd_entry: if set, called for each non-empty PMD (3rd-level) entry
> + * @pgd_entry: if set, called for each non-empty PGD (top-level) entry
> + * @p4d_entry: if set, called for each non-empty P4D entry
> + * @pud_entry: if set, called for each non-empty PUD entry
> + * @pmd_entry: if set, called for each non-empty PMD entry

How are these expected to work with folding?

For example, on arm64 with 64K pages and 42-bit VA, you can have 2-level
tables where the PGD is P4D, PUD, and PMD. IIUC we'd invoke the
callbacks for each of those levels where we found an entry in the pgd.

Either the callee handle that, or we should inhibit the callbacks when
levels are folded, and I think that needs to be explcitly stated either
way.

IIRC on x86 the p4d folding is dynamic depending on whether the HW
supports 5-level page tables. Maybe that implies the callee has to
handle that.

Thanks,
Mark.


>   *	       this handler is required to be able to handle
>   *	       pmd_trans_huge() pmds.  They may simply choose to
>   *	       split_huge_page() instead of handling it explicitly.
> - * @pte_entry: if set, called for each non-empty PTE (4th-level) entry
> + * @pte_entry: if set, called for each non-empty PTE (lowest-level) entry
>   * @pte_hole: if set, called for each hole at all levels
>   * @hugetlb_entry: if set, called for each hugetlb entry
>   * @test_walk: caller specific callback function to determine whether
> @@ -1455,6 +1454,10 @@ void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
>   * (see the comment on walk_page_range() for more details)
>   */
>  struct mm_walk {
> +	int (*pgd_entry)(pgd_t *pgd, unsigned long addr,
> +			 unsigned long next, struct mm_walk *walk);
> +	int (*p4d_entry)(p4d_t *p4d, unsigned long addr,
> +			 unsigned long next, struct mm_walk *walk);
>  	int (*pud_entry)(pud_t *pud, unsigned long addr,
>  			 unsigned long next, struct mm_walk *walk);
>  	int (*pmd_entry)(pmd_t *pmd, unsigned long addr,
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index c3084ff2569d..98373a9f88b8 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -90,15 +90,9 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>  		}
>  
>  		if (walk->pud_entry) {
> -			spinlock_t *ptl = pud_trans_huge_lock(pud, walk->vma);
> -
> -			if (ptl) {
> -				err = walk->pud_entry(pud, addr, next, walk);
> -				spin_unlock(ptl);
> -				if (err)
> -					break;
> -				continue;
> -			}
> +			err = walk->pud_entry(pud, addr, next, walk);
> +			if (err)
> +				break;
>  		}
>  
>  		split_huge_pud(walk->vma, pud, addr);
> @@ -131,7 +125,12 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
>  				break;
>  			continue;
>  		}
> -		if (walk->pmd_entry || walk->pte_entry)
> +		if (walk->p4d_entry) {
> +			err = walk->p4d_entry(p4d, addr, next, walk);
> +			if (err)
> +				break;
> +		}
> +		if (walk->pud_entry || walk->pmd_entry || walk->pte_entry)
>  			err = walk_pud_range(p4d, addr, next, walk);
>  		if (err)
>  			break;
> @@ -157,7 +156,13 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
>  				break;
>  			continue;
>  		}
> -		if (walk->pmd_entry || walk->pte_entry)
> +		if (walk->pgd_entry) {
> +			err = walk->pgd_entry(pgd, addr, next, walk);
> +			if (err)
> +				break;
> +		}
> +		if (walk->p4d_entry || walk->pud_entry || walk->pmd_entry ||
> +				walk->pte_entry)
>  			err = walk_p4d_range(pgd, addr, next, walk);
>  		if (err)
>  			break;
> -- 
> 2.20.1
> 
