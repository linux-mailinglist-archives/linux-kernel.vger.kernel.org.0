Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 612275642F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 10:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFZINb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 04:13:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:56048 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbfFZINa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:13:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2E32AAD0;
        Wed, 26 Jun 2019 08:13:28 +0000 (UTC)
Date:   Wed, 26 Jun 2019 10:13:25 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, pasha.tatashin@soleen.com,
        Jonathan.Cameron@huawei.com, anshuman.khandual@arm.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mm,memory_hotplug: allocate memmap from the added
 memory range for sparse-vmemmap
Message-ID: <20190626081325.GB30863@linux>
References: <20190625075227.15193-1-osalvador@suse.de>
 <20190625075227.15193-5-osalvador@suse.de>
 <80f8afcf-0934-33e5-5dc4-a0d19ec2b910@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80f8afcf-0934-33e5-5dc4-a0d19ec2b910@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:49:10AM +0200, David Hildenbrand wrote:
> On 25.06.19 09:52, Oscar Salvador wrote:
> > Physical memory hotadd has to allocate a memmap (struct page array) for
> > the newly added memory section. Currently, alloc_pages_node() is used
> > for those allocations.
> > 
> > This has some disadvantages:
> >  a) an existing memory is consumed for that purpose
> >     (~2MB per 128MB memory section on x86_64)
> >  b) if the whole node is movable then we have off-node struct pages
> >     which has performance drawbacks.
> > 
> > a) has turned out to be a problem for memory hotplug based ballooning
> >    because the userspace might not react in time to online memory while
> >    the memory consumed during physical hotadd consumes enough memory to
> >    push system to OOM. 31bc3858ea3e ("memory-hotplug: add automatic onlining
> >    policy for the newly added memory") has been added to workaround that
> >    problem.
> > 
> > I have also seen hot-add operations failing on powerpc due to the fact
> > that we try to use order-8 pages. If the base page size is 64KB, this
> > gives us 16MB, and if we run out of those, we simply fail.
> > One could arge that we can fall back to basepages as we do in x86_64, but
> > we can do better when CONFIG_SPARSEMEM_VMEMMAP is enabled.
> > 
> > Vmemap page tables can map arbitrary memory.
> > That means that we can simply use the beginning of each memory section and
> > map struct pages there.
> > struct pages which back the allocated space then just need to be treated
> > carefully.
> > 
> > Implementation wise we reuse vmem_altmap infrastructure to override
> > the default allocator used by __vmemap_populate. Once the memmap is
> > allocated we need a way to mark altmap pfns used for the allocation.
> > If MHP_MEMMAP_{DEVICE,MEMBLOCK} flag was passed, we set up the layout of the
> > altmap structure at the beginning of __add_pages(), and then we call
> > mark_vmemmap_pages().
> > 
> > Depending on which flag is passed (MHP_MEMMAP_DEVICE or MHP_MEMMAP_MEMBLOCK),
> > mark_vmemmap_pages() gets called at a different stage.
> > With MHP_MEMMAP_MEMBLOCK, we call it once we have populated the sections
> > fitting in a single memblock, while with MHP_MEMMAP_DEVICE we wait until all
> > sections have been populated.
> 
> So, only MHP_MEMMAP_DEVICE will be used. Would it make sense to only
> implement one for now (after we decide which one to use), to make things
> simpler?
> 
> Or do you have a real user in mind for the other?

Currently, only MHP_MEMMAP_DEVICE will be used, as we only pass flags from
acpi memory-hotplug path.

All the others: hyper-v, Xen,... will have to be evaluated to see which one
do they want to use.

Although MHP_MEMMAP_DEVICE is the only one used right now, I introduced
MHP_MEMMAP_MEMBLOCK to give the callers the choice of using MHP_MEMMAP_MEMBLOCK
if they think that a strategy where hot-removing works in a different granularity
makes sense.

Moreover, since they both use the same API, there is no extra code needed to
handle it. (Just two lines in __add_pages())

This arose here [1].

[1] https://patchwork.kernel.org/project/linux-mm/list/?submitter=137061

-- 
Oscar Salvador
SUSE L3
