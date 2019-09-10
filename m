Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01B8CAE6F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 11:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387808AbfIJJ3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 05:29:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39958 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfIJJ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:29:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id v38so16390391edm.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 02:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z/cdLAzBda13RGP5im2f2+BozlMcjcxm4mRau+s018M=;
        b=vVQOht/unk4bOuEDHmhAo9uZ9HMFHWCW7HuUC8L0F96RCxHrWIY+bH9noXtZe8t0Tp
         NeV5VamJ/Y09SoPGTjHM/yH3OKiclea7ICciUigrCEKH+uny5GKgJWQLWLAQr/+ZvBwC
         l1hlv6qWI50rVGGZqVsbkiBf56Ve8ye7OHatXsO0for3wY7ns7AIndTCwEGfhXexm0r2
         c9MwQxRXo4ez2/FZ8aLLrkfSUJ6VrMYLwdvtdLV7LIBtNWhCBh+Vg8vRvZmE9lfWpf7/
         gSLaNrzfrm9+/ix1yAUytl66zhS7Q3ghc+c5rh3h7yvGIkkzm5Z11m6vpSghs16vXaoy
         ARvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z/cdLAzBda13RGP5im2f2+BozlMcjcxm4mRau+s018M=;
        b=cxhcY51yS3qbrau0INMxuF9qySzDK6cMO6dAWFDrmS9TvskUHcqmVxWVEZEZnvWMvU
         5V//qKd8wu5erk042SjCwtFzgmq5wLiASsa0nAHtInWVd/TnfGqmhSmkunjEbnHpZ0gb
         5VVXxN2SqkuPTwKd5UGyq81jbQzxlZlw3nC1Veq5yNmT7+i30wSCkt827y/k3/lpeRhB
         t57Fgf1P6mrtUlqiNkdCA6E5zsd9qZ+pZV1z/u26IgitppaLraZCAerEa5MQ9pgqSU4y
         KaFZQf7Al7sqpWNWgYp2AateQunZdD/1cKj2ccjJs+FqUV93+3xUM5cEHY1ayZfxBKXs
         oeTw==
X-Gm-Message-State: APjAAAUv3CYr28GBFRUjIeUpbdTVcMTh3p1jQuynTJ8auUE5NadNG2qM
        j2KdPhRZfuzvOrFGKDQ1try2PQ==
X-Google-Smtp-Source: APXvYqyor9fEciT7R6lMsL8pix5iwEgltlCCo9vjMLU8wdF0pbHxfhUVtUbuwUzk4OShp0zWQa6sFg==
X-Received: by 2002:a05:6402:154e:: with SMTP id p14mr29393223edx.101.1568107785387;
        Tue, 10 Sep 2019 02:29:45 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e52sm3477168eda.36.2019.09.10.02.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 02:29:44 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D61751009F6; Tue, 10 Sep 2019 12:29:44 +0300 (+03)
Date:   Tue, 10 Sep 2019 12:29:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jia He <justin.he@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <Catalin.Marinas@arm.com>
Subject: Re: [PATCH v2] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190910092944.3c3tducgsq673wp4@box.shutemov.name>
References: <20190906135747.211836-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906135747.211836-1-justin.he@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 09:57:47PM +0800, Jia He wrote:
> When we tested pmdk unit test [1] vmmalloc_fork TEST1 in arm64 guest, there
> will be a double page fault in __copy_from_user_inatomic of cow_user_page.
> 
> Below call trace is from arm64 do_page_fault for debugging purpose
> [  110.016195] Call trace:
> [  110.016826]  do_page_fault+0x5a4/0x690
> [  110.017812]  do_mem_abort+0x50/0xb0
> [  110.018726]  el1_da+0x20/0xc4
> [  110.019492]  __arch_copy_from_user+0x180/0x280
> [  110.020646]  do_wp_page+0xb0/0x860
> [  110.021517]  __handle_mm_fault+0x994/0x1338
> [  110.022606]  handle_mm_fault+0xe8/0x180
> [  110.023584]  do_page_fault+0x240/0x690
> [  110.024535]  do_mem_abort+0x50/0xb0
> [  110.025423]  el0_da+0x20/0x24
> 
> The pte info before __copy_from_user_inatomic is (PTE_AF is cleared):
> [ffff9b007000] pgd=000000023d4f8003, pud=000000023da9b003, pmd=000000023d4b3003, pte=360000298607bd3
> 
> As told by Catalin: "On arm64 without hardware Access Flag, copying from
> user will fail because the pte is old and cannot be marked young. So we
> always end up with zeroed page after fork() + CoW for pfn mappings. we
> don't always have a hardware-managed access flag on arm64."
> 
> This patch fix it by calling pte_mkyoung. Also, the parameter is
> changed because vmf should be passed to cow_user_page()
> 
> [1] https://github.com/pmem/pmdk/tree/master/src/test/vmmalloc_fork
> 
> Reported-by: Yibo Cai <Yibo.Cai@arm.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
> Changes
> v2: remove FAULT_FLAG_WRITE when setting pte access flag (by Catalin)
> 
>  mm/memory.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index e2bb51b6242e..63d4fd285e8e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2140,7 +2140,8 @@ static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
>  	return same;
>  }
>  
> -static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
> +static inline void cow_user_page(struct page *dst, struct page *src,
> +				struct vm_fault *vmf)
>  {
>  	debug_dma_assert_idle(src);
>  
> @@ -2152,20 +2153,30 @@ static inline void cow_user_page(struct page *dst, struct page *src, unsigned lo
>  	 */
>  	if (unlikely(!src)) {
>  		void *kaddr = kmap_atomic(dst);
> -		void __user *uaddr = (void __user *)(va & PAGE_MASK);
> +		void __user *uaddr = (void __user *)(vmf->address & PAGE_MASK);
> +		pte_t entry;
>  
>  		/*
>  		 * This really shouldn't fail, because the page is there
>  		 * in the page tables. But it might just be unreadable,
>  		 * in which case we just give up and fill the result with
> -		 * zeroes.
> +		 * zeroes. If PTE_AF is cleared on arm64, it might
> +		 * cause double page fault. So makes pte young here
>  		 */
> +		if (!pte_young(vmf->orig_pte)) {
> +			entry = pte_mkyoung(vmf->orig_pte);
> +			if (ptep_set_access_flags(vmf->vma, vmf->address,
> +				vmf->pte, entry, 0))
> +				update_mmu_cache(vmf->vma, vmf->address,
> +						vmf->pte);
> +		}
> +

I don't see where you take ptl.

-- 
 Kirill A. Shutemov
