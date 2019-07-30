Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4B27B375
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 21:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfG3TmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 15:42:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45666 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfG3TmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:42:12 -0400
Received: from X1 (unknown [76.191.170.112])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 878213336;
        Tue, 30 Jul 2019 19:42:09 +0000 (UTC)
Date:   Tue, 30 Jul 2019 12:42:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm: release the spinlock on zap_pte_range
Message-Id: <20190730124207.da70f92f19dc021bf052abd0@linux-foundation.org>
In-Reply-To: <20190729082052.GA258885@google.com>
References: <20190729071037.241581-1-minchan@kernel.org>
        <20190729074523.GC9330@dhcp22.suse.cz>
        <20190729082052.GA258885@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019 17:20:52 +0900 Minchan Kim <minchan@kernel.org> wrote:

> > > @@ -1022,7 +1023,16 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > >  	flush_tlb_batched_pending(mm);
> > >  	arch_enter_lazy_mmu_mode();
> > >  	do {
> > > -		pte_t ptent = *pte;
> > > +		pte_t ptent;
> > > +
> > > +		if (progress >= 32) {
> > > +			progress = 0;
> > > +			if (need_resched())
> > > +				break;
> > > +		}
> > > +		progress += 8;
> > 
> > Why 8?
> 
> Just copied from copy_pte_range.

copy_pte_range() does

		if (pte_none(*src_pte)) {
			progress++;
			continue;
		}
		entry.val = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte,
							vma, addr, rss);
		if (entry.val)
			break;
		progress += 8;

which appears to be an attempt to balance the cost of copy_one_pte()
against the cost of not calling copy_one_pte().

Your code doesn't do this balancing and hence can be simpler.

It all seems a bit overdesigned.  need_resched() is cheap.  It's
possibly a mistake to check need_resched() on *every* loop because some
crazy scheduling load might livelock us.  But surely it would be enough
to do something like

	if (progress++ && need_resched()) {
		<reschedule>
		progress = 0;
	}

and leave it at that?
