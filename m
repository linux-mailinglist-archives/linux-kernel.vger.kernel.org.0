Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8377EB0DBF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 13:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbfILL1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 07:27:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:42436 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731278AbfILL1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:27:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41BCAACFE;
        Thu, 12 Sep 2019 11:27:38 +0000 (UTC)
Date:   Thu, 12 Sep 2019 13:27:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Nitin Gupta <nigupta@nvidia.com>
Cc:     "willy@infradead.org" <willy@infradead.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cai@lca.pw" <cai@lca.pw>,
        "arunks@codeaurora.org" <arunks@codeaurora.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "richard.weiyang@gmail.com" <richard.weiyang@gmail.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "khalid.aziz@oracle.com" <khalid.aziz@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm: Add callback for defining compaction completion
Message-ID: <20190912112736.GR4023@dhcp22.suse.cz>
References: <20190910200756.7143-1-nigupta@nvidia.com>
 <20190910201905.GG4023@dhcp22.suse.cz>
 <MN2PR12MB30229414332206E25B9F3B8BD8B60@MN2PR12MB3022.namprd12.prod.outlook.com>
 <20190911064520.GI4023@dhcp22.suse.cz>
 <4ba8a6810cb481204deae4a7171dded1d8b5e736.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ba8a6810cb481204deae4a7171dded1d8b5e736.camel@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-09-19 22:33:39, Nitin Gupta wrote:
> On Wed, 2019-09-11 at 08:45 +0200, Michal Hocko wrote:
> > On Tue 10-09-19 22:27:53, Nitin Gupta wrote:
> > [...]
> > > > On Tue 10-09-19 13:07:32, Nitin Gupta wrote:
> > > > > For some applications we need to allocate almost all memory as
> > > > > hugepages.
> > > > > However, on a running system, higher order allocations can fail if the
> > > > > memory is fragmented. Linux kernel currently does on-demand
> > > > > compaction
> > > > > as we request more hugepages but this style of compaction incurs very
> > > > > high latency. Experiments with one-time full memory compaction
> > > > > (followed by hugepage allocations) shows that kernel is able to
> > > > > restore a highly fragmented memory state to a fairly compacted memory
> > > > > state within <1 sec for a 32G system. Such data suggests that a more
> > > > > proactive compaction can help us allocate a large fraction of memory
> > > > > as hugepages keeping allocation latencies low.
> > > > > 
> > > > > In general, compaction can introduce unexpected latencies for
> > > > > applications that don't even have strong requirements for contiguous
> > > > > allocations.
> > 
> > Could you expand on this a bit please? Gfp flags allow to express how
> > much the allocator try and compact for a high order allocations. Hugetlb
> > allocations tend to require retrying and heavy compaction to succeed and
> > the success rate tends to be pretty high from my experience.  Why that
> > is not case in your case?
> > 
> 
> Yes, I have the same observation: with `GFP_TRANSHUGE |
> __GFP_RETRY_MAYFAIL` I get very good success rate (~90% of free RAM
> allocated as hugepages). However, what I'm trying to point out is that this
> high success rate comes with high allocation latencies (90th percentile
> latency of 2206us). On the same system, the same high-order allocations
> which hit the fast path have latency <5us.

Sure, that is no free cake. Unless the direct compaction can do
something fundamentally different than the background one this is the
amount of the work that has to be done for those situation no matter
what. Lower latency is certainly attractive but the other part of the
equation is _who_ is going to pay for that.

> > > > > It is also hard to efficiently determine if the current
> > > > > system state can be easily compacted due to mixing of unmovable
> > > > > memory. Due to these reasons, automatic background compaction by the
> > > > > kernel itself is hard to get right in a way which does not hurt
> > > > > unsuspecting
> > > > applications or waste CPU cycles.
> > > > 
> > > > We do trigger background compaction on a high order pressure from the
> > > > page allocator by waking up kcompactd. Why is that not sufficient?
> > > > 
> > > 
> > > Whenever kcompactd is woken up, it does just enough work to create
> > > one free page of the given order (compaction_control.order) or higher.
> > 
> > This is an implementation detail IMHO. I am pretty sure we can do a
> > better auto tuning when there is an indication of a constant flow of
> > high order requests. This is no different from the memory reclaim in
> > principle. Just because the kswapd autotuning not fitting with your
> > particular workload you wouldn't want to export direct reclaim
> > functionality and call it from a random module. That is just doomed to
> > fail because different subsystems in control just leads to decisions
> > going against each other.
> > 
> 
> I don't want to go the route of adding any auto-tuning/perdiction code to
> control compaction in the kernel. I'm more inclined towards extending
> existing interfaces to allow compaction behavior to be controlled either
> from userspace or a kernel driver. Letting a random module control
> compaction or a root process pumping new tunables from sysfs is the same in
> principle.

Then I would start by listing shortcomings of the existing interfaces
and examples how it could be extended for specific usecases.

> This patch is in the spirit of simple extension to existing
> compaction_zone_order() which allows either a kernel driver or userspace
> (through sysfs) to control compaction.
> 
> Also, we should avoid driving hard parallels between reclaim and
> compaction: the former is often necessary for forward progress while the
> latter is often an optimization. Since contiguous allocations are mostly
> optimizations it's good to expose hooks from the kernel that let user
> (through a driver or userspace) control it using its own heuristics.

This really depends on the allocation failure fallback strategy. If your
specific case can gracefully fallback to smaller allocations then all
fine, this is just an optimization. But if you are an order-3 GFP_KERNEL
request then not making a forward progress is a matter of an OOM killer.
So no, we are not only talking about optimization.
 
> I thought hard about whats lacking in current userspace interface (sysfs):
>  - /proc/sys/vm/compact_memory: full system compaction is not an option as
>    a viable pro-active compaction strategy.

Because...

>  - possibly expose [low, high] threshold values for each node and let
>    kcompactd act on them. This was my approach for my original patch I
>    linked earlier. Problem here is that it introduces too many tunables.

I was playing with a similar idea as well in the past as well. But this
is quite tricky. Watermark api makes sense if you can somehow enforce
them. What if the low watermark cannot be achieved due to excessive
fragmentation that cannot be handled? Should the background daemon try
endlessly consuming an unbound amount of cpu cycles? The reclaim can act
by triggering OOM killer and free up some memory. There is nothing
actionable like that for the compaction.

> Considering the above, I came up with this callback approach which make it
> trivial to introduce user specific policies for compaction. It puts the
> onus of system stability, responsive in the hands of user without burdening
> admins with more tunables or adding crystal balls to kernel.

It might seem trivial to use but I am not really sure that consequences
of using is are trivial to argue about.

[...]
> > Do that from the userspace then. If there is an insufficient interface
> > to do that then let's talk about what is missing.
> > 
> 
> Currently we only have a proc interface to do full system compaction.
> Here's what missing from this interface: ability to set per-node, per-zone,
> per-order, [low, high] extfrag thresholds.

I would agree about per-node interface because we already do allow
per-node policies and that's why high order demand might differ. But I
would be really against any per-zone interfaces because zones are an
internal implementation detail of the page allocator. We've made
mistakes to expose that into the userspace in the past and we shouldn't
repeat them. Per-order is quite questionable without seeing explicit
usecases and data. E.g. are there usecases to save (how much) cycles to
only compact up to order-3 comparing to full flagged compaction?
-- 
Michal Hocko
SUSE Labs
