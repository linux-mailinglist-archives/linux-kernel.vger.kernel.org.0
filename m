Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29A8EABC2A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 17:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394719AbfIFPVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 11:21:00 -0400
Received: from foss.arm.com ([217.140.110.172]:58214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394706AbfIFPU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:20:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93B9728;
        Fri,  6 Sep 2019 08:20:58 -0700 (PDT)
Received: from [10.1.196.105] (unknown [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85E793F59C;
        Fri,  6 Sep 2019 08:20:56 -0700 (PDT)
Subject: Re: [PATCH v3 10/17] arm64, trans_pgd: adjust trans_pgd_create_copy
 interface
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-11-pasha.tatashin@soleen.com>
From:   James Morse <james.morse@arm.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com
Message-ID: <21f6eb6f-be3a-a715-a37c-2f59183ed183@arm.com>
Date:   Fri, 6 Sep 2019 16:20:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190821183204.23576-11-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 21/08/2019 19:31, Pavel Tatashin wrote:
> Make trans_pgd_create_copy inline with the other functions in
> trans_pgd: use the trans_pgd_info argument, and also use the
> trans_pgd_create_empty.
> 
> Note, that the functions that are called by trans_pgd_create_copy are
> not yet adjusted to be compliant with trans_pgd: they do not yet use
> the provided allocator, do not check for generic errors, and do not yet
> use the flags in info argument.


> diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
> index 26e5a63676b5..f4a5f255d4a7 100644
> --- a/arch/arm64/include/asm/trans_pgd.h
> +++ b/arch/arm64/include/asm/trans_pgd.h
> @@ -43,7 +43,12 @@ struct trans_pgd_info {
>  /* Create and empty trans_pgd page table */
>  int trans_pgd_create_empty(struct trans_pgd_info *info, pgd_t **trans_pgd);
>  
> -int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
> +/*
> + * Create trans_pgd and copy entries from from_table to trans_pgd in range
> + * [start, end)
> + */
> +int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
> +			  pgd_t *from_table, unsigned long start,
>  			  unsigned long end);

This creates a copy of the linear-map. Why does it need to be told from_table?


> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 8c2641a9bb09..8bb602e91065 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -323,15 +323,42 @@ int swsusp_arch_resume(void)
>  	phys_addr_t phys_hibernate_exit;
>  	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *,
>  					  void *, phys_addr_t, phys_addr_t);
> +	struct trans_pgd_info trans_info = {
> +		.trans_alloc_page	= hibernate_page_alloc,
> +		.trans_alloc_arg	= (void *)GFP_ATOMIC,
> +		/*
> +		 * Resume will overwrite areas that may be marked read only
> +		 * (code, rodata). Clear the RDONLY bit from the temporary
> +		 * mappings we use during restore.
> +		 */
> +		.trans_flags		= TRANS_MKWRITE,
> +	};


> +	/*
> +	 * debug_pagealloc will removed the PTE_VALID bit if the page isn't in
> +	 * use by the resume kernel. It may have been in use by the original
> +	 * kernel, in which case we need to put it back in our copy to do the
> +	 * restore.
> +	 *
> +	 * Before marking this entry valid, check the pfn should be mapped.
> +	 */
> +	if (debug_pagealloc_enabled())
> +		trans_info.trans_flags |= (TRANS_MKVALID | TRANS_CHECKPFN);

The debug_pagealloc_enabled() check should be with the code that generates a different
entry. Whether the different entry is correct needs to be considered with
debug_pagealloc_enabled() in mind. You are making this tricky logic less clear.

There is no way the existing code invents an entry for a !pfn_valid() page. With your
'checkpfn' flag, this thing can. You don't need to generalise this for hypothetical users.


If kexec needs to create mappings for bogus pages, I'd like to know why.


>  	/*
>  	 * Restoring the memory image will overwrite the ttbr1 page tables.
>  	 * Create a second copy of just the linear map, and use this when
>  	 * restoring.
>  	 */
> -	rc = trans_pgd_create_copy(&tmp_pg_dir, PAGE_OFFSET, 0);
> -	if (rc)
> +	rc = trans_pgd_create_copy(&trans_info, &tmp_pg_dir, init_mm.pgd,
> +				   PAGE_OFFSET, 0);

> +	if (rc) {
> +		if (rc == -ENOMEM)
> +			pr_err("Failed to allocate memory for temporary page tables.\n");
> +		else if (rc == -ENXIO)
> +			pr_err("Tried to set PTE for PFN that does not exist\n");
>  		goto out;
> +	}

If you think the distinction for this error message is useful, it would be clearer to
change it in the current hibernate code before you move it. (_copy_pte() to return an
error, instead of silently failing). Done here, this is unrelated noise.

I doubt this is specific to kexec.


Thanks,

James
