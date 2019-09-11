Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA7AAF612
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 08:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfIKGp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 02:45:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:38344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726657AbfIKGp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 02:45:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CEC72AF93;
        Wed, 11 Sep 2019 06:45:23 +0000 (UTC)
Date:   Wed, 11 Sep 2019 08:45:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Nitin Gupta <nigupta@nvidia.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "khalid.aziz@oracle.com" <khalid.aziz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Allison Randal <allison@lohutok.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arun KS <arunks@codeaurora.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: Add callback for defining compaction completion
Message-ID: <20190911064520.GI4023@dhcp22.suse.cz>
References: <20190910200756.7143-1-nigupta@nvidia.com>
 <20190910201905.GG4023@dhcp22.suse.cz>
 <MN2PR12MB30229414332206E25B9F3B8BD8B60@MN2PR12MB3022.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR12MB30229414332206E25B9F3B8BD8B60@MN2PR12MB3022.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-09-19 22:27:53, Nitin Gupta wrote:
[...]
> > On Tue 10-09-19 13:07:32, Nitin Gupta wrote:
> > > For some applications we need to allocate almost all memory as
> > > hugepages.
> > > However, on a running system, higher order allocations can fail if the
> > > memory is fragmented. Linux kernel currently does on-demand
> > > compaction
> > > as we request more hugepages but this style of compaction incurs very
> > > high latency. Experiments with one-time full memory compaction
> > > (followed by hugepage allocations) shows that kernel is able to
> > > restore a highly fragmented memory state to a fairly compacted memory
> > > state within <1 sec for a 32G system. Such data suggests that a more
> > > proactive compaction can help us allocate a large fraction of memory
> > > as hugepages keeping allocation latencies low.
> > >
> > > In general, compaction can introduce unexpected latencies for
> > > applications that don't even have strong requirements for contiguous
> > > allocations.

Could you expand on this a bit please? Gfp flags allow to express how
much the allocator try and compact for a high order allocations. Hugetlb
allocations tend to require retrying and heavy compaction to succeed and
the success rate tends to be pretty high from my experience.  Why that
is not case in your case?

> > > It is also hard to efficiently determine if the current
> > > system state can be easily compacted due to mixing of unmovable
> > > memory. Due to these reasons, automatic background compaction by the
> > > kernel itself is hard to get right in a way which does not hurt unsuspecting
> > applications or waste CPU cycles.
> > 
> > We do trigger background compaction on a high order pressure from the
> > page allocator by waking up kcompactd. Why is that not sufficient?
> > 
> 
> Whenever kcompactd is woken up, it does just enough work to create
> one free page of the given order (compaction_control.order) or higher.

This is an implementation detail IMHO. I am pretty sure we can do a
better auto tuning when there is an indication of a constant flow of
high order requests. This is no different from the memory reclaim in
principle. Just because the kswapd autotuning not fitting with your
particular workload you wouldn't want to export direct reclaim
functionality and call it from a random module. That is just doomed to
fail because different subsystems in control just leads to decisions
going against each other.

> Such a design causes very high latency for workloads where we want
> to allocate lots of hugepages in short period of time. With pro-active
> compaction we can hide much of this latency. For some more background
> discussion and data, please see this thread:
> 
> https://patchwork.kernel.org/patch/11098289/

I am aware of that thread. And there are two things. You claim the
allocation success rate is unnecessarily lower and that the direct
latency is high. You simply cannot assume both low latency and high
success rate. Compaction is not free. Somebody has to do the work.
Hiding it into the background means that you are eating a lot of cycles
from everybody else (think of a workload running in a restricted cpu
controller just doing a lot of work in an unaccounted context).

That being said you really have to be prepared to pay a price for
precious resource like high order pages.

On the other hand I do understand that high latency is not really
desired for a more optimistic allocation requests with a reasonable
fallback strategy. Those would benefit from kcompactd not giving up too
early.
 
> > > Even with these caveats, pro-active compaction can still be very
> > > useful in certain scenarios to reduce hugepage allocation latencies.
> > > This callback interface allows drivers to drive compaction based on
> > > their own policies like the current level of external fragmentation
> > > for a particular order, system load etc.
> > 
> > So we do not trust the core MM to make a reasonable decision while we give
> > a free ticket to modules. How does this make any sense at all? How is a
> > random module going to make a more informed decision when it has less
> > visibility on the overal MM situation.
> >
> 
> Embedding any specific policy (like: keep external fragmentation for order-9
> between 30-40%) within MM core looks like a bad idea.

Agreed

> As a driver, we
> can easily measure parameters like system load, current fragmentation level
> for any order in any zone etc. to make an informed decision.
> See the thread I refereed above for more background discussion.

Do that from the userspace then. If there is an insufficient interface
to do that then let's talk about what is missing.

> > If you need to control compaction from the userspace you have an interface
> > for that.  It is also completely unexplained why you need a completion
> > callback.
> > 
> 
> /proc/sys/vm/compact_memory does whole system compaction which is
> often too much as a pro-active compaction strategy. To get more control
> over how to compaction work to do, I have added a compaction callback
> which controls how much work is done in one compaction cycle.

Why is a more fine grained control really needed? Sure compacting
everything is heavy weight but how often do you have to do that. Your
changelog starts with a usecase when there is a high demand for large
pages at the startup. What prevents you do compaction at that time. If
the workload is longterm then the initial price should just pay back,
no?

-- 
Michal Hocko
SUSE Labs
