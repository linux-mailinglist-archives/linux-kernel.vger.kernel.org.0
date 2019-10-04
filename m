Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78A71CB754
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 11:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbfJDJ2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 05:28:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:38036 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727611AbfJDJ2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:28:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65DCAAC16;
        Fri,  4 Oct 2019 09:28:09 +0000 (UTC)
Date:   Fri, 4 Oct 2019 11:28:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [rfc] mm, hugetlb: allow hugepage allocations to excessively
 reclaim
Message-ID: <20191004092808.GC9578@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1910021556270.187014@chino.kir.corp.google.com>
 <d7752ddf-ccdc-9ff4-ab9f-529c2cd7f041@suse.cz>
 <alpine.DEB.2.21.1910031243050.88296@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910031243050.88296@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-10-19 12:52:33, David Rientjes wrote:
> On Thu, 3 Oct 2019, Vlastimil Babka wrote:
> 
> > I think the key differences between Mike's tests and Michal's is this part
> > from Mike's mail linked above:
> > 
> > "I 'tested' by simply creating some background activity and then seeing
> > how many hugetlb pages could be allocated. Of course, many tries over
> > time in a loop."
> > 
> > - "some background activity" might be different than Michal's pre-filling
> >   of the memory with (clean) page cache
> > - "many tries over time in a loop" could mean that kswapd has time to 
> >   reclaim and eventually the new condition for pageblock order will pass
> >   every few retries, because there's enough memory for compaction and it
> >   won't return COMPACT_SKIPPED
> > 
> 
> I'll rely on Mike, the hugetlb maintainer, to assess the trade-off between 
> the potential for encountering very expensive reclaim as Andrea did and 
> the possibility of being able to allocate additional hugetlb pages at 
> runtime if we did that expensive reclaim.

That tradeoff has been expressed by __GFP_RETRY_MAYFAIL which got broken
by b39d0ee2632d.

> For parity with previous kernels it seems reasonable to ask that this 
> remains unchanged since allocating large amounts of hugetlb pages has 
> different latency expectations than during page fault.  This patch is 
> available if he'd prefer to go that route.
> 
> On the other hand, userspace could achieve similar results if it were to 
> use vm.drop_caches and explicitly triggered compaction through either 
> procfs or sysfs before writing to vm.nr_hugepages, and that would be much 
> faster because it would be done in one go.  Users who allocate through the 
> kernel command line would obviously be unaffected.

Requesting the userspace to drop _all_ page cache in order allocate a
number of hugetlb pages or any other affected __GFP_RETRY_MAYFAIL
requests is simply not reasonable IMHO.
-- 
Michal Hocko
SUSE Labs
