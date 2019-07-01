Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFCD2CB3C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 18:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfE1QLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 12:11:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:57142 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726604AbfE1QLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:11:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 08E1FAF3B;
        Tue, 28 May 2019 16:11:11 +0000 (UTC)
Date:   Tue, 28 May 2019 18:11:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 1/7] mm: introduce MADV_COOL
Message-ID: <20190528161109.GF1658@dhcp22.suse.cz>
References: <20190528153811.7684-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528153811.7684-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-05-19 23:38:11, Hillf Danton wrote:
> 
> On Tue, 28 May 2019 20:39:36 +0800 Minchan Kim wrote:
> > On Tue, May 28, 2019 at 08:15:23PM +0800, Hillf Danton wrote:
> > < snip >
> > > > > > +	orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> > > > > > +	for (pte = orig_pte; addr < end; pte++, addr += PAGE_SIZE) {
> > > > >
> > > > > s/end/next/ ?
> > > >
> > > > Why do you think it should be next?
> > > >
> > > Simply based on the following line, and afraid that next != end
> > > 	> > > +	next = pmd_addr_end(addr, end);
> > 
> > pmd_addr_end will return smaller address so end is more proper.
> > 
> Fair.
> 
> > > > > > +static long madvise_cool(struct vm_area_struct *vma,
> > > > > > +			unsigned long start_addr, unsigned long end_addr)
> > > > > > +{
> > > > > > +	struct mm_struct *mm = vma->vm_mm;
> > > > > > +	struct mmu_gather tlb;
> > > > > > +
> > > > > > +	if (vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP))
> > > > > > +		return -EINVAL;
> > > > >
> > > > > No service in case of VM_IO?
> > > >
> > > > I don't know VM_IO would have regular LRU pages but just follow normal
> > > > convention for DONTNEED and FREE.
> > > > Do you have anything in your mind?
> > > >
> > > I want to skip a mapping set up for DMA.
> > 
> > What you meant is those pages in VM_IO vma are not in LRU list?
> 
> What I concern is the case that there are IO pages on lru list.
> > Or
> > pages in the vma are always pinned so no worth to deactivate or reclaim?
> > 
> I will not be nervous or paranoid if they are pinned.
> 
> In short, I prefer to skip IO mapping since any kind of address range
> can be expected from userspace, and it may probably cover an IO mapping.
> And things can get out of control, if we reclaim some IO pages while
> underlying device is trying to fill data into any of them, for instance.

What do you mean by IO pages why what is the actual problem?
-- 
Michal Hocko
SUSE Labs
