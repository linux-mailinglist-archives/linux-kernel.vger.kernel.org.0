Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B64214EA90
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 11:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgAaKWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 05:22:45 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33084 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgAaKWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=91AMxLljo6V/7OqP2TOzkIcpGrjx29tvuETRIfnVXtQ=; b=wW0CuviRHijQfoPaBF8aalYIT
        7VA+ZMOXIIs88C182aS4sJoCpybKT7h4CSvd0DefGVuLK30WvOyW50qk4A1ub5fDCa5CJGqGBnhwA
        UOVfL/BdlIqaH3rVin4Y4pt3QgYQa0iKAzF05zWUtTzEH1NnhxGXJh0twJCH6kSbh4NVkXWwVvZ7h
        /YZ+0zq8UuqVZLMubOMUpxg2xiTQ+JQ5EGesjgee2oppfCuiJQ0VrW10V2QO2JnEL2UKLhXbxXnrN
        hKix8zHwpUC7j1I6HAt/UEkXVy2ZQbpVYqyeZFbgMeJuGd5BVjE7ILZzwrAVo+SQoB6LJeQRfDKkC
        O2Ev+UIow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixTRi-0001Ws-7Z; Fri, 31 Jan 2020 10:22:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB3453007F2;
        Fri, 31 Jan 2020 11:20:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 691CE201E6BC5; Fri, 31 Jan 2020 11:22:39 +0100 (CET)
Date:   Fri, 31 Jan 2020 11:22:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Rewrite Motorola MMU page-table layout
Message-ID: <20200131102239.GB14914@hirez.programming.kicks-ass.net>
References: <20200129103941.304769381@infradead.org>
 <8a81e075-d3bd-80c1-d869-9935fdd73162@linux-m68k.org>
 <20200131093813.GA3938@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131093813.GA3938@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 09:38:13AM +0000, Will Deacon wrote:

> > This series breaks compilation for the ColdFire (with MMU) variant of
> > the m68k family:

That's like the same I had reported by the build robots for sun3, which
I fixed by frobbing pgtable_t. That said, this is probably a more
consistent change.

One note below:


> -static inline struct page *pte_alloc_one(struct mm_struct *mm)
> +static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
>  {
>  	struct page *page = alloc_pages(GFP_DMA, 0);
>  	pte_t *pte;
> @@ -54,20 +55,19 @@ static inline struct page *pte_alloc_one(struct mm_struct *mm)
>  		return NULL;
>  	}
>  
> -	pte = kmap(page);
> -	if (pte) {
> -		clear_page(pte);
> -		__flush_page_to_ram(pte);
> -		flush_tlb_kernel_page(pte);
> -		nocache_page(pte);
> -	}
> -	kunmap(page);
> +	pte = page_address(page);
> +	clear_page(pte);
> +	__flush_page_to_ram(pte);
> +	flush_tlb_kernel_page(pte);
> +	nocache_page(pte);

See how it does the nocache dance ^

>  
> -	return page;
> +	return pte;
>  }
>  
> -static inline void pte_free(struct mm_struct *mm, struct page *page)
> +static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
>  {
> +	struct page *page = virt_to_page(pgtable);
> +

but never sets it cached again!

>  	pgtable_pte_page_dtor(page);
>  	__free_page(page);
>  }

Also, the alloc_one_kernel() also suspicioudly doesn't do the nocache
thing.

So either, alloc_one() shouldn't either, or it's all buggered.
