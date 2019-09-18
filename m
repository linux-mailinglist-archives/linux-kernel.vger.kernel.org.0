Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEBC6B6A25
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 20:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfIRSAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 14:00:40 -0400
Received: from foss.arm.com ([217.140.110.172]:46294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbfIRSAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:00:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 547971000;
        Wed, 18 Sep 2019 11:00:39 -0700 (PDT)
Received: from iMac.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58E363F59C;
        Wed, 18 Sep 2019 11:00:36 -0700 (PDT)
Date:   Wed, 18 Sep 2019 19:00:30 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Jia He <justin.he@arm.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v4 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190918180029.GB20601@iMac.local>
References: <20190918131914.38081-1-justin.he@arm.com>
 <20190918131914.38081-4-justin.he@arm.com>
 <20190918140027.ckj32xnryyyesc23@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918140027.ckj32xnryyyesc23@box>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 05:00:27PM +0300, Kirill A. Shutemov wrote:
> On Wed, Sep 18, 2019 at 09:19:14PM +0800, Jia He wrote:
> > @@ -2152,20 +2163,34 @@ static inline void cow_user_page(struct page *dst, struct page *src, unsigned lo
> >  	 */
> >  	if (unlikely(!src)) {
> >  		void *kaddr = kmap_atomic(dst);
> > -		void __user *uaddr = (void __user *)(va & PAGE_MASK);
> > +		void __user *uaddr = (void __user *)(addr & PAGE_MASK);
> > +		pte_t entry;
> >  
> >  		/*
> >  		 * This really shouldn't fail, because the page is there
> >  		 * in the page tables. But it might just be unreadable,
> >  		 * in which case we just give up and fill the result with
> > -		 * zeroes.
> > +		 * zeroes. On architectures with software "accessed" bits,
> > +		 * we would take a double page fault here, so mark it
> > +		 * accessed here.
> >  		 */
> > +		if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
> > +			spin_lock(vmf->ptl);
> > +			if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
> > +				entry = pte_mkyoung(vmf->orig_pte);
> > +				if (ptep_set_access_flags(vma, addr,
> > +							  vmf->pte, entry, 0))
> > +					update_mmu_cache(vma, addr, vmf->pte);
> > +			}
> 
> I don't follow.
> 
> So if pte has changed under you, you don't set the accessed bit, but never
> the less copy from the user.
> 
> What makes you think it will not trigger the same problem?
> 
> I think we need to make cow_user_page() fail in this case and caller --
> wp_page_copy() -- return zero. If the fault was solved by other thread, we
> are fine. If not userspace would re-fault on the same address and we will
> handle the fault from the second attempt.

It would be nice to clarify the semantics of this function and do as
you suggest but the current comment is slightly confusing:

	/*
	 * If the source page was a PFN mapping, we don't have
	 * a "struct page" for it. We do a best-effort copy by
	 * just copying from the original user address. If that
	 * fails, we just zero-fill it. Live with it.
	 */

Would any user-space rely on getting a zero-filled page here instead of
a recursive fault?

-- 
Catalin
