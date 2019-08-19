Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCD19494E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 17:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfHSP6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 11:58:32 -0400
Received: from foss.arm.com ([217.140.110.172]:56840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfHSP63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:58:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4C5A344;
        Mon, 19 Aug 2019 08:58:28 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1D7B3F718;
        Mon, 19 Aug 2019 08:58:26 -0700 (PDT)
Date:   Mon, 19 Aug 2019 16:58:24 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 03/14] arm64, hibernate: add trans_table public
 functions
Message-ID: <20190819155824.GE9927@lakrids.cambridge.arm.com>
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
 <20190817024629.26611-4-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817024629.26611-4-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:46:18PM -0400, Pavel Tatashin wrote:
> trans_table_create_copy() and trans_table_map_page() are going to be
> the basis for public interface of new subsystem that handles page
> tables for cases which are between kernels: kexec, and hibernate.

While the architecture uses the term 'translation table', in the kernel
we generally use 'pgdir' or 'pgd' to refer to the tables, so please keep
to that naming scheme.

For example, in arch/arm64/mm/mmu.c we have a somewhat analagous
function called create_pgd_mapping() -- could we use that here, to crate
the mapping?

Thanks,
Mark.

> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/kernel/hibernate.c | 96 ++++++++++++++++++++++-------------
>  1 file changed, 61 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 96b6f8da7e49..449d69b5651c 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -182,39 +182,15 @@ int arch_hibernation_header_restore(void *addr)
>  }
>  EXPORT_SYMBOL(arch_hibernation_header_restore);
>  
> -/*
> - * Copies length bytes, starting at src_start into an new page,
> - * perform cache maintentance, then maps it at the specified address low
> - * address as executable.
> - *
> - * This is used by hibernate to copy the code it needs to execute when
> - * overwriting the kernel text. This function generates a new set of page
> - * tables, which it loads into ttbr0.
> - *
> - * Length is provided as we probably only want 4K of data, even on a 64K
> - * page system.
> - */
> -static int create_safe_exec_page(void *src_start, size_t length,
> -				 unsigned long dst_addr,
> -				 phys_addr_t *phys_dst_addr)
> +int trans_table_map_page(pgd_t *trans_table, void *page,
> +			 unsigned long dst_addr,
> +			 pgprot_t pgprot)
>  {
> -	void *page = (void *)get_safe_page(GFP_ATOMIC);
> -	pgd_t *trans_table;
>  	pgd_t *pgdp;
>  	pud_t *pudp;
>  	pmd_t *pmdp;
>  	pte_t *ptep;
>  
> -	if (!page)
> -		return -ENOMEM;
> -
> -	memcpy((void *)page, src_start, length);
> -	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
> -
> -	trans_table = (void *)get_safe_page(GFP_ATOMIC);
> -	if (!trans_table)
> -		return -ENOMEM;
> -
>  	pgdp = pgd_offset_raw(trans_table, dst_addr);
>  	if (pgd_none(READ_ONCE(*pgdp))) {
>  		pudp = (void *)get_safe_page(GFP_ATOMIC);
> @@ -242,6 +218,44 @@ static int create_safe_exec_page(void *src_start, size_t length,
>  	ptep = pte_offset_kernel(pmdp, dst_addr);
>  	set_pte(ptep, pfn_pte(virt_to_pfn(page), PAGE_KERNEL_EXEC));
>  
> +	return 0;
> +}
> +
> +/*
> + * Copies length bytes, starting at src_start into an new page,
> + * perform cache maintentance, then maps it at the specified address low
> + * address as executable.
> + *
> + * This is used by hibernate to copy the code it needs to execute when
> + * overwriting the kernel text. This function generates a new set of page
> + * tables, which it loads into ttbr0.
> + *
> + * Length is provided as we probably only want 4K of data, even on a 64K
> + * page system.
> + */
> +static int create_safe_exec_page(void *src_start, size_t length,
> +				 unsigned long dst_addr,
> +				 phys_addr_t *phys_dst_addr)
> +{
> +	void *page = (void *)get_safe_page(GFP_ATOMIC);
> +	pgd_t *trans_table;
> +	int rc;
> +
> +	if (!page)
> +		return -ENOMEM;
> +
> +	memcpy(page, src_start, length);
> +	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
> +
> +	trans_table = (void *)get_safe_page(GFP_ATOMIC);
> +	if (!trans_table)
> +		return -ENOMEM;
> +
> +	rc = trans_table_map_page(trans_table, page, dst_addr,
> +				  PAGE_KERNEL_EXEC);
> +	if (rc)
> +		return rc;
> +
>  	/*
>  	 * Load our new page tables. A strict BBM approach requires that we
>  	 * ensure that TLBs are free of any entries that may overlap with the
> @@ -259,7 +273,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
>  	write_sysreg(phys_to_ttbr(virt_to_phys(trans_table)), ttbr0_el1);
>  	isb();
>  
> -	*phys_dst_addr = virt_to_phys((void *)page);
> +	*phys_dst_addr = virt_to_phys(page);
>  
>  	return 0;
>  }
> @@ -462,6 +476,24 @@ static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
>  	return 0;
>  }
>  
> +int trans_table_create_copy(pgd_t **dst_pgdp, unsigned long start,
> +			    unsigned long end)
> +{
> +	int rc;
> +	pgd_t *trans_table = (pgd_t *)get_safe_page(GFP_ATOMIC);
> +
> +	if (!trans_table) {
> +		pr_err("Failed to allocate memory for temporary page tables.\n");
> +		return -ENOMEM;
> +	}
> +
> +	rc = copy_page_tables(trans_table, start, end);
> +	if (!rc)
> +		*dst_pgdp = trans_table;
> +
> +	return rc;
> +}
> +
>  /*
>   * Setup then Resume from the hibernate image using swsusp_arch_suspend_exit().
>   *
> @@ -483,13 +515,7 @@ int swsusp_arch_resume(void)
>  	 * Create a second copy of just the linear map, and use this when
>  	 * restoring.
>  	 */
> -	tmp_pg_dir = (pgd_t *)get_safe_page(GFP_ATOMIC);
> -	if (!tmp_pg_dir) {
> -		pr_err("Failed to allocate memory for temporary page tables.\n");
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -	rc = copy_page_tables(tmp_pg_dir, PAGE_OFFSET, 0);
> +	rc = trans_table_create_copy(&tmp_pg_dir, PAGE_OFFSET, 0);
>  	if (rc)
>  		goto out;
>  
> -- 
> 2.22.1
> 
