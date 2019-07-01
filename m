Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0E629DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 20:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfEXSIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 14:08:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48186 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbfEXSIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:08:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49589A78;
        Fri, 24 May 2019 11:08:11 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5C8A3F703;
        Fri, 24 May 2019 11:08:09 -0700 (PDT)
Date:   Fri, 24 May 2019 19:08:05 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] arm64: mm: Implement pte_devmap support
Message-ID: <20190524180805.GA9697@fuggles.cambridge.arm.com>
References: <cover.1558547956.git.robin.murphy@arm.com>
 <817d92886fc3b33bcbf6e105ee83a74babb3a5aa.1558547956.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <817d92886fc3b33bcbf6e105ee83a74babb3a5aa.1558547956.git.robin.murphy@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 04:03:16PM +0100, Robin Murphy wrote:
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 2c41b04708fe..a6378625d47c 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -90,6 +90,7 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>  #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
>  #define pte_user_exec(pte)	(!(pte_val(pte) & PTE_UXN))
>  #define pte_cont(pte)		(!!(pte_val(pte) & PTE_CONT))
> +#define pte_devmap(pte)		(!!(pte_val(pte) & PTE_DEVMAP))
>  
>  #define pte_cont_addr_end(addr, end)						\
>  ({	unsigned long __boundary = ((addr) + CONT_PTE_SIZE) & CONT_PTE_MASK;	\
> @@ -217,6 +218,11 @@ static inline pmd_t pmd_mkcont(pmd_t pmd)
>  	return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
>  }
>  
> +static inline pte_t pte_mkdevmap(pte_t pte)
> +{
> +	return set_pte_bit(pte, __pgprot(PTE_DEVMAP));
> +}
> +
>  static inline void set_pte(pte_t *ptep, pte_t pte)
>  {
>  	WRITE_ONCE(*ptep, pte);
> @@ -381,6 +387,9 @@ static inline int pmd_protnone(pmd_t pmd)
>  
>  #define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
>  
> +#define pmd_devmap(pmd)		pte_devmap(pmd_pte(pmd))
> +#define pmd_mkdevmap(pmd)	pte_pmd(pte_mkdevmap(pmd_pte(pmd)))
> +
>  #define __pmd_to_phys(pmd)	__pte_to_phys(pmd_pte(pmd))
>  #define __phys_to_pmd_val(phys)	__phys_to_pte_val(phys)
>  #define pmd_pfn(pmd)		((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT)
> @@ -537,6 +546,11 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
>  	return __pud_to_phys(pud);
>  }
>  
> +static inline int pud_devmap(pud_t pud)
> +{
> +	return 0;
> +}
> +
>  /* Find an entry in the second-level page table. */
>  #define pmd_index(addr)		(((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
>  
> @@ -624,6 +638,11 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
>  
>  #define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
>  
> +static inline int pgd_devmap(pgd_t pgd)
> +{
> +	return 0;
> +}

I think you need to guard this and pXd_devmap() with
CONFIG_TRANSPARENT_HUGEPAGE, otherwise you'll conflict with the dummy
definitions in mm.h and the build will fail.

Will
