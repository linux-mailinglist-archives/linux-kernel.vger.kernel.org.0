Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC289188A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 20:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfHRR6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 13:58:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42096 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRR6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 13:58:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id y1so4655239plp.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 10:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lpXT5jgyPqX3dLnOucpewMYDw91Zhangu/vs1bm1UA4=;
        b=cB/T8JxD2gaPLDiZ4yWgXIiaf2c6ezdTY081pE3OHA/Zlm7wJPNHeuajM3+bw4yJ04
         U8MNrjAWLrpzd36kDlJBQYe5Z/7GwjHeJnfvP0/FGRl8OIDhuBf0ul9UrE3NXa6PrMr5
         jFOrzjxwI3hgBM3H3yt7Y0E00PzJJ5mvQ35UPtkyZzYmLPt0mNr0tNroO7DQysctYYVZ
         xtP1iL36KbJCkqgEtqZzHZK+MmAUIkGx36jXc75M9MMaKKm7eEeo8ZJSCo07iLq7aQgm
         o11FVO60WbRgdBCHK9mk6HAHu2Gr3/JoYBVyfrWwJ/SFB0qzOfVemBbSEUXvdPN0XRMN
         SI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lpXT5jgyPqX3dLnOucpewMYDw91Zhangu/vs1bm1UA4=;
        b=f9ogiQlEhsoQXwgyxGezlTQikptRuZ9yFmngWkEzIr46gujODTbKFOxPxuESxeIhBw
         h2i9SItHo0VeAHo++j9KAqqYsO28tMqTwCIrNtAqoyo8xWfiI7TlvviSxNHOI7EYeFfF
         whA5LAze2Y3oWAnRgqCmIZYwtjuvNRRiJ1yxA0aZYUQRWkR7JFBcm/4LhAp2CBHMoWT4
         uAK+5HGFnw1TqwRx9gwm2Hn9ubUCgkgYByrbWIIm7jW6CJwZaihq2hH32rI1myUlm7VS
         +/4V/RUc4z6Ev5LdfFwOW+YBvjq7eDQflrZ6XribMQ1utOhnGacGzJqdsQrCPF3w0uQE
         g1KQ==
X-Gm-Message-State: APjAAAV+wT6GjORSK6s9wlEEGXWRjUGwbx8blQDb83bjm9Xwm2rLwl0P
        1bcMiPYqeO+gqQVHqoo41hLrMbhJ
X-Google-Smtp-Source: APXvYqxOdwwV8NfH7Oea0jEcmCO7jmM2+yqmPAgrMcod0AxVkHlQVyZ4TVsvabcTYNtA8Rqjcdppew==
X-Received: by 2002:a17:902:7842:: with SMTP id e2mr18407716pln.49.1566151112258;
        Sun, 18 Aug 2019 10:58:32 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.36])
        by smtp.gmail.com with ESMTPSA id j15sm12983313pfe.3.2019.08.18.10.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 10:58:31 -0700 (PDT)
Date:   Sun, 18 Aug 2019 23:28:24 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     jhubbard@nvidia.com, gregkh@linuxfoundation.org, sivanich@sgi.com,
        arnd@arndb.de
Cc:     ira.weiny@intel.com, jglisse@redhat.com,
        william.kucharski@oracle.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees][PATCH v5 1/1] sgi-gru: Remove *pte_lookup
 functions, Convert to get_user_page*()
Message-ID: <20190818175824.GA6635@bharath12345-Inspiron-5559>
References: <1565379497-29266-1-git-send-email-linux.bhar@gmail.com>
 <1565379497-29266-2-git-send-email-linux.bhar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1565379497-29266-2-git-send-email-linux.bhar@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dimitri,

Can you confirm that this driver will run gru_vtop() in interrupt
context?

If so, I ll send you another set of patches in which I don't change the
*pte_lookup functions but only change put_page to put_user_page and
remove the ifdef for CONFIG_HUGETLB_PAGE.

Thank you for your time.

Thank you
Bharath

On Sat, Aug 10, 2019 at 01:08:17AM +0530, Bharath Vedartham wrote:
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page() or
> release_pages().
> 
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").
> 
> As part of this conversion, the *pte_lookup functions can be removed and
> be easily replaced with get_user_pages_fast() functions. In the case of
> atomic lookup, __get_user_pages_fast() is used, because it does not fall
> back to the slow path: get_user_pages(). get_user_pages_fast(), on the other
> hand, first calls __get_user_pages_fast(), but then falls back to the
> slow path if __get_user_pages_fast() fails.
> 
> Also: remove unnecessary CONFIG_HUGETLB ifdefs.
> 
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: J�r�me Glisse <jglisse@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Dimitri Sivanich <sivanich@sgi.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: William Kucharski <william.kucharski@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel-mentees@lists.linuxfoundation.org
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
> This is a fold of the 3 patches in the v2 patch series.
> The review tags were given to the individual patches.
> 
> Changes since v3
> 	- Used gup flags in get_user_pages_fast rather than
> 	boolean flags.
> Changes since v4
> 	- Updated changelog according to John Hubbard.
> ---
>  drivers/misc/sgi-gru/grufault.c | 112 +++++++++-------------------------------
>  1 file changed, 24 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> index 4b713a8..304e9c5 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -166,96 +166,20 @@ static void get_clear_fault_map(struct gru_state *gru,
>  }
>  
>  /*
> - * Atomic (interrupt context) & non-atomic (user context) functions to
> - * convert a vaddr into a physical address. The size of the page
> - * is returned in pageshift.
> - * 	returns:
> - * 		  0 - successful
> - * 		< 0 - error code
> - * 		  1 - (atomic only) try again in non-atomic context
> - */
> -static int non_atomic_pte_lookup(struct vm_area_struct *vma,
> -				 unsigned long vaddr, int write,
> -				 unsigned long *paddr, int *pageshift)
> -{
> -	struct page *page;
> -
> -#ifdef CONFIG_HUGETLB_PAGE
> -	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
> -#else
> -	*pageshift = PAGE_SHIFT;
> -#endif
> -	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
> -		return -EFAULT;
> -	*paddr = page_to_phys(page);
> -	put_page(page);
> -	return 0;
> -}
> -
> -/*
> - * atomic_pte_lookup
> + * mmap_sem is already helod on entry to this function. This guarantees
> + * existence of the page tables.
>   *
> - * Convert a user virtual address to a physical address
>   * Only supports Intel large pages (2MB only) on x86_64.
> - *	ZZZ - hugepage support is incomplete
> - *
> - * NOTE: mmap_sem is already held on entry to this function. This
> - * guarantees existence of the page tables.
> + *	ZZZ - hugepage support is incomplete.
>   */
> -static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
> -	int write, unsigned long *paddr, int *pageshift)
> -{
> -	pgd_t *pgdp;
> -	p4d_t *p4dp;
> -	pud_t *pudp;
> -	pmd_t *pmdp;
> -	pte_t pte;
> -
> -	pgdp = pgd_offset(vma->vm_mm, vaddr);
> -	if (unlikely(pgd_none(*pgdp)))
> -		goto err;
> -
> -	p4dp = p4d_offset(pgdp, vaddr);
> -	if (unlikely(p4d_none(*p4dp)))
> -		goto err;
> -
> -	pudp = pud_offset(p4dp, vaddr);
> -	if (unlikely(pud_none(*pudp)))
> -		goto err;
> -
> -	pmdp = pmd_offset(pudp, vaddr);
> -	if (unlikely(pmd_none(*pmdp)))
> -		goto err;
> -#ifdef CONFIG_X86_64
> -	if (unlikely(pmd_large(*pmdp)))
> -		pte = *(pte_t *) pmdp;
> -	else
> -#endif
> -		pte = *pte_offset_kernel(pmdp, vaddr);
> -
> -	if (unlikely(!pte_present(pte) ||
> -		     (write && (!pte_write(pte) || !pte_dirty(pte)))))
> -		return 1;
> -
> -	*paddr = pte_pfn(pte) << PAGE_SHIFT;
> -#ifdef CONFIG_HUGETLB_PAGE
> -	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
> -#else
> -	*pageshift = PAGE_SHIFT;
> -#endif
> -	return 0;
> -
> -err:
> -	return 1;
> -}
> -
>  static int gru_vtop(struct gru_thread_state *gts, unsigned long vaddr,
>  		    int write, int atomic, unsigned long *gpa, int *pageshift)
>  {
>  	struct mm_struct *mm = gts->ts_mm;
>  	struct vm_area_struct *vma;
>  	unsigned long paddr;
> -	int ret, ps;
> +	int ret;
> +	struct page *page;
>  
>  	vma = find_vma(mm, vaddr);
>  	if (!vma)
> @@ -263,21 +187,33 @@ static int gru_vtop(struct gru_thread_state *gts, unsigned long vaddr,
>  
>  	/*
>  	 * Atomic lookup is faster & usually works even if called in non-atomic
> -	 * context.
> +	 * context. get_user_pages_fast does atomic lookup before falling back to
> +	 * slow gup.
>  	 */
>  	rmb();	/* Must/check ms_range_active before loading PTEs */
> -	ret = atomic_pte_lookup(vma, vaddr, write, &paddr, &ps);
> -	if (ret) {
> -		if (atomic)
> +	if (atomic) {
> +		ret = __get_user_pages_fast(vaddr, 1, write, &page);
> +		if (!ret)
>  			goto upm;
> -		if (non_atomic_pte_lookup(vma, vaddr, write, &paddr, &ps))
> +	} else {
> +		ret = get_user_pages_fast(vaddr, 1, write ? FOLL_WRITE : 0, &page);
> +		if (!ret)
>  			goto inval;
>  	}
> +
> +	paddr = page_to_phys(page);
> +	put_user_page(page);
> +
> +	if (unlikely(is_vm_hugetlb_page(vma)))
> +		*pageshift = HPAGE_SHIFT;
> +	else
> +		*pageshift = PAGE_SHIFT;
> +
>  	if (is_gru_paddr(paddr))
>  		goto inval;
> -	paddr = paddr & ~((1UL << ps) - 1);
> +	paddr = paddr & ~((1UL << *pageshift) - 1);
>  	*gpa = uv_soc_phys_ram_to_gpa(paddr);
> -	*pageshift = ps;
> +
>  	return VTOP_SUCCESS;
>  
>  inval:
> -- 
> 2.7.4
> 
