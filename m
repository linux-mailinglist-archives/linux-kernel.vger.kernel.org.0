Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD608B36EF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 11:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbfIPJQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 05:16:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40281 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731764AbfIPJQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 05:16:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id v38so32412060edm.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 02:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vBZCS9nU1fSH+kmSCYigm2Yq8YU/srN9xKPMLdxx9uA=;
        b=yNH4GN7LaJOP3yS9aV4fF11ma1PFEb7h83O4Jf9wGnCAwQ3sIB0HjqygkTPkLbIX4i
         fpzZFr9Ng8cKCy3x990mhweiHyLCASKWNlnkwpho9OSGlLFttD271s7WNCgaDENT5il7
         6LScrSQDK35mJXcuHW16ivhg6hD9hRDBcPp0a4CIxMBbCnau5Ijn3LRBS7HJ5NxH96Xm
         T9cm3x8hG9/hCBdsRQ4+RiD1j1PDzIzWfU5wGcU0clDw5lAiWT+qS+6kBai15OK2tuXI
         j3Vc+mNUlZL8X1pfK/Pp4igTpzakDaZNk//o1k0AcgB8w0tKGOglAuPzSFVBsTeTCHRF
         CQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vBZCS9nU1fSH+kmSCYigm2Yq8YU/srN9xKPMLdxx9uA=;
        b=L2ClC2I+rCZK7jDuWAsk+T/hGQsCx5oIupw18G7uRMXSTMKUCtC8v1xipnrRS9gjO2
         ney9+Gy7TCXsgkNkXYm+d0Em3RivAe3OxYmjzWs6R4J8JDArFfe5gxlxNiIXB5T10UAG
         NqQksQmCCKwfW04Uj7H8OxQpyzxCDr6a+12ygCA38uBGusXUtXPT7dtfOv8p74h+wk+x
         8XjqBEMzXDCbMh8+1WIADtojEsJOI+T8VI2lVHwxp8dc5S5cutWurP5eSeyDf6P6Xzka
         /enby9n1qzutehYhID8HeRK6SnQuqrIAHaI/dpGHQ0pZma/VVjqi2oEE7fMZVX9PNaKV
         1FQQ==
X-Gm-Message-State: APjAAAVv+grURKirFuCX2QgjSyTPSQrnCQnyx86bo3CKc3MUVQHDOFEh
        fiNNSw8cD7O1l6vXtIMEWstnIA==
X-Google-Smtp-Source: APXvYqyGScQN03qDrXuVbBMNDdbJlq+zqcHgLnsomhbDkQ6dQ4qNnJhT5ZwIkawoSd3+haiCNIOt4w==
X-Received: by 2002:a50:87ca:: with SMTP id 10mr9263258edz.77.1568625387310;
        Mon, 16 Sep 2019 02:16:27 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id br15sm3577556ejb.2.2019.09.16.02.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 02:16:26 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 85A0A104174; Mon, 16 Sep 2019 12:16:28 +0300 (+03)
Date:   Mon, 16 Sep 2019 12:16:28 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jia He <justin.he@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com
Subject: Re: [PATCH v3 2/2] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190916091628.bkuvd3g3ie3x6qav@box.shutemov.name>
References: <20190913163239.125108-1-justin.he@arm.com>
 <20190913163239.125108-3-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913163239.125108-3-justin.he@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 12:32:39AM +0800, Jia He wrote:
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
>  mm/memory.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index e2bb51b6242e..a64af6495f71 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -118,6 +118,13 @@ int randomize_va_space __read_mostly =
>  					2;
>  #endif
>  
> +#ifndef arch_faults_on_old_pte
> +static inline bool arch_faults_on_old_pte(void)
> +{
> +	return false;
> +}
> +#endif
> +
>  static int __init disable_randmaps(char *s)
>  {
>  	randomize_va_space = 0;
> @@ -2140,7 +2147,8 @@ static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
>  	return same;
>  }
>  
> -static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
> +static inline void cow_user_page(struct page *dst, struct page *src,
> +				struct vm_fault *vmf)
>  {
>  	debug_dma_assert_idle(src);
>  
> @@ -2152,20 +2160,32 @@ static inline void cow_user_page(struct page *dst, struct page *src, unsigned lo
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
> +		if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
> +			spin_lock(vmf->ptl);
> +			entry = pte_mkyoung(vmf->orig_pte);

Should't you re-validate that orig_pte after re-taking ptl? It can be
stale by now.

> +			if (ptep_set_access_flags(vmf->vma, vmf->address,
> +						  vmf->pte, entry, 0))
> +				update_mmu_cache(vmf->vma, vmf->address,
> +						 vmf->pte);
> +			spin_unlock(vmf->ptl);
> +		}
> +
>  		if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
>  			clear_page(kaddr);
>  		kunmap_atomic(kaddr);
>  		flush_dcache_page(dst);
>  	} else
> -		copy_user_highpage(dst, src, va, vma);
> +		copy_user_highpage(dst, src, vmf->address, vmf->vma);
>  }
>  
>  static gfp_t __get_fault_gfp_mask(struct vm_area_struct *vma)
> @@ -2318,7 +2338,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  				vmf->address);
>  		if (!new_page)
>  			goto oom;
> -		cow_user_page(new_page, old_page, vmf->address, vma);
> +		cow_user_page(new_page, old_page, vmf);
>  	}
>  
>  	if (mem_cgroup_try_charge_delay(new_page, mm, GFP_KERNEL, &memcg, false))
> -- 
> 2.17.1
> 
> 

-- 
 Kirill A. Shutemov
