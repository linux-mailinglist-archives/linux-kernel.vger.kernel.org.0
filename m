Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B54514CA78
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 13:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgA2MMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 07:12:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgA2MLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:11:54 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74DF520716;
        Wed, 29 Jan 2020 12:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580299914;
        bh=zniqdCZxaIJn3f/xGVHfAtC3ydz67Kil2D8QuNxdBn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDkcL9hdZPJzN/cfFXh6NdRjVCewejSuzjbp8fmzj7BjJjBWktcL4dv9A8v7qXdnH
         nZSfs7DPwfatIEuvORGPc6XOpsc5JwcMTjDmiDFzwT081PbeLH26gPK8prOSz7xGO+
         mOEPB+zBwMnqnYoSwvqo/nPWAbTsB/RsRvSvXUlU=
Date:   Wed, 29 Jan 2020 12:11:50 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] m68k,mm: Use table allocator for pgtables
Message-ID: <20200129121149.GA31582@willie-the-truck>
References: <20200129103941.304769381@infradead.org>
 <20200129104345.434705552@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129104345.434705552@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 11:39:44AM +0100, Peter Zijlstra wrote:
> With the new page-table layout, using full (4k) pages for (256 byte)
> pte-tables is immensely wastefull. Move the pte-tables over to the
> same allocator already used for the (512 byte) higher level tables
> (pgd/pmd).
> 
> This reduces the pte-table waste from 15x to 2x.
> 
> Due to no longer being bound to 16 consecutive tables, this might
> actually already be more efficient than the old code for sparse
> tables.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/m68k/include/asm/motorola_pgalloc.h |   54 ++++++-------------------------
>  arch/m68k/include/asm/motorola_pgtable.h |    8 ++++
>  arch/m68k/include/asm/page.h             |    2 -
>  3 files changed, 19 insertions(+), 45 deletions(-)
> 
> --- a/arch/m68k/include/asm/motorola_pgalloc.h
> +++ b/arch/m68k/include/asm/motorola_pgalloc.h
> @@ -10,60 +10,28 @@ extern int free_pointer_table(pmd_t *);
>  
>  static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>  {
> -	pte_t *pte;
> -
> -	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
> -	if (pte) {
> -		__flush_page_to_ram(pte);
> -		flush_tlb_kernel_page(pte);
> -		nocache_page(pte);
> -	}
> -
> -	return pte;
> +	return (pte_t *)get_pointer_table();

Weirdly, get_pointer_table() seems to elide the __flush_page_to_ram()
call, so you're missing that for ptes with this change. I think it's
probably needed for the higher levels too (and kernel_page_table()
does it for example) so I'd be inclined to add it unconditionally
rather than predicate it on the allocation type introduced by your later
patch.

> --- a/arch/m68k/include/asm/page.h
> +++ b/arch/m68k/include/asm/page.h
> @@ -30,7 +30,7 @@ typedef struct { unsigned long pmd; } pm
>  typedef struct { unsigned long pte; } pte_t;
>  typedef struct { unsigned long pgd; } pgd_t;
>  typedef struct { unsigned long pgprot; } pgprot_t;
> -typedef struct page *pgtable_t;
> +typedef pte_t *pgtable_t;

Urgh, this is a big (cross-arch) mess that we should fix later.

Will
