Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6AED75028
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 15:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403764AbfGYNvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 09:51:39 -0400
Received: from foss.arm.com ([217.140.110.172]:57786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfGYNvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:51:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDC2928;
        Thu, 25 Jul 2019 06:51:37 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 504813F71F;
        Thu, 25 Jul 2019 06:51:35 -0700 (PDT)
Date:   Thu, 25 Jul 2019 14:51:33 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com, mhocko@suse.com,
        ira.weiny@intel.com, david@redhat.com, cai@lca.pw,
        logang@deltatee.com, james.morse@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com,
        mgorman@techsingularity.net, osalvador@suse.de,
        ard.biesheuvel@arm.com, steve.capper@arm.com
Subject: Re: [PATCH V6 RESEND 0/3] arm64/mm: Enable memory hot remove
Message-ID: <20190725135132.GH14347@lakrids.cambridge.arm.com>
References: <1563171470-3117-1-git-send-email-anshuman.khandual@arm.com>
 <20190723105636.GA5004@lakrids.cambridge.arm.com>
 <a69ed426-98ff-32ed-82ce-8216dd56daba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a69ed426-98ff-32ed-82ce-8216dd56daba@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 12:28:50PM +0530, Anshuman Khandual wrote:
> On 07/23/2019 04:26 PM, Mark Rutland wrote:
> > On Mon, Jul 15, 2019 at 11:47:47AM +0530, Anshuman Khandual wrote:
> >> This series enables memory hot remove on arm64 after fixing a memblock
> >> removal ordering problem in generic try_remove_memory() and a possible
> >> arm64 platform specific kernel page table race condition. This series
> >> is based on linux-next (next-20190712).
> >>
> >> Concurrent vmalloc() and hot-remove conflict:
> >>
> >> As pointed out earlier on the v5 thread [2] there can be potential conflict
> >> between concurrent vmalloc() and memory hot-remove operation. This can be
> >> solved or at least avoided with some possible methods. The problem here is
> >> caused by inadequate locking in vmalloc() which protects installation of a
> >> page table page but not the walk or the leaf entry modification.
> >>
> >> Option 1: Making locking in vmalloc() adequate
> >>
> >> Current locking scheme protects installation of page table pages but not the
> >> page table walk or leaf entry creation which can conflict with hot-remove.
> >> This scheme is sufficient for now as vmalloc() works on mutually exclusive
> >> ranges which can proceed concurrently only if their shared page table pages
> >> can be created while inside the lock. It achieves performance improvement
> >> which will be compromised if entire vmalloc() operation (even if with some
> >> optimization) has to be completed under a lock.
> >>
> >> Option 2: Making sure hot-remove does not happen during vmalloc()
> >>
> >> Take mem_hotplug_lock in read mode through [get|put]_online_mems() constructs
> >> for the entire duration of vmalloc(). It protects from concurrent memory hot
> >> remove operation and does not add any significant overhead to other concurrent
> >> vmalloc() threads. It solves the problem in right way unless we do not want to
> >> extend the usage of mem_hotplug_lock in generic MM.
> >>
> >> Option 3: Memory hot-remove does not free (conflicting) page table pages
> >>
> >> Don't not free page table pages (if any) for vmemmap mappings after unmapping
> >> it's virtual range. The only downside here is that some page table pages might
> >> remain empty and unused until next memory hot-add operation of the same memory
> >> range.
> >>
> >> Option 4: Dont let vmalloc and vmemmap share intermediate page table pages
> >>
> >> The conflict does not arise if vmalloc and vmemap range do not share kernel
> >> page table pages to start with. If such placement can be ensured in platform
> >> kernel virtual address layout, this problem can be successfully avoided.
> >>
> >> There are two generic solutions (Option 1 and 2) and two platform specific
> >> solutions (Options 2 and 3). This series has decided to go with (Option 3)
> 
> s/Option 2 and 3/Option 3 and 4/
> 
> >> which requires minimum changes while self-contained inside the functionality.
> > 
> > ... while also leaking memory, right?
> 
> This is not a memory leak. In the worst case where an empty page table page could
> have been freed after parts of it's kernel virtual range span's vmemmap mapping has
> been taken down still remains attached to the higher level page table entry. This
> empty page table page will be completely reusable during future vmalloc() allocations
> or vmemmap mapping for newly hot added memory in overlapping memory range. It is just
> an empty data structure sticking around which could (probably would) be reused later.
> This problem will not scale and get worse because its part of kernel page table not
> user process which could get multiplied. Its a small price we are paying to remain
> safe from a vmalloc() and memory hot remove potential collisions on the kernel page
> table. IMHO that is fair enough.

I appreciate that we can reuse the memory if we hotplug the same
phyiscal range.

Regardless, I think it's important to note that this approach leaves
that memory around. Could you please quantify how much memory this
would be? i.e. for a 4K 48-bit VA kernel, how many pages would be left
over for a 1GiB region of memory?

> > In my view, option 2 or 4 would have been preferable. Were there
> 
> I would say option 2 is the ideal solution where we make sure that each vmalloc()
> instance is protected against concurrent memory hot remove through a read side lock
> via [get|put]_online_mems().

I agree that this would be simple to reason about. However, even taking
a read lock could significantly change the performance of operations in
the vmalloc space, so that would need to be quantified. Additionally,
hotplug operations would stall all vmalloc space operations, which is
unfortunate.

> Option 4 is very much platform specific and each platform has to make sure that they
> remain compliant all the time which is not ideal. Its is also an a work around which
> avoids the problem and does not really fix it.

I understand that you don't like this solution.

I think it should be simple to verify that the layout is safe via
BUILD_BUG_ON() checking the regions we care about don't overlap, so I
don't buy that it's all that difficult to ensure going forward if it's
naturally the case today.

> > specific technical reasons to not go down either of those routes? I'm
> 
> Option 2 will require wider agreement as it involves a very critical hot-path vmalloc()
> which can affect many workloads.

I agree that this would need to be quantified.

> IMHO Option 4 is neither optimal and not does it solve the problem
> correctly. Like this approach it just avoids it but unlike this
> touches upon another code area.

I disagree that option 4 wouldn't be correct; it's just avoiding the
issue at a different level.

> > not sure that minimizing changes is the right rout given that this same
> > problem presumably applies to other architectures, which will need to be
> > fixed.
> 
> Yes this needs to be fixed but we can get there one step at a time. vmemmap tear
> down process can start freeing empty page table pages when this gets solved. But
> why should it prevent entire memory hot remove functionality from being available.

My experience has been that people rarely go back to solve the edge
cases once the feature they care about has been merged, and we're left
with more edge cases...

I think we at least need to have a clear idea that we can fix the
problem before we punt it on as later cleanup. Especially given that
this seems like it is an existing problem affecting other architectures.

> > Do we know why we aren't seeing issues on other architectures? e.g. is
> > the issue possible but rare (and hence not reported), or masked by
> > something else (e.g. the layout of the kernel VA space)?
> 
> I would believe so but we can only get more insights from respective architecture folks.

Could you please investigate, e.g. have a look at how this works on x86?

You should be able to figure out if the VA ranges overlap, and I suspect
that if there is a problem youi can deliberately trigger it within a
QEMU VM.

> >> Testing:
> >>
> >> Memory hot remove has been tested on arm64 for 4K, 16K, 64K page config
> >> options with all possible CONFIG_ARM64_VA_BITS and CONFIG_PGTABLE_LEVELS
> >> combinations. Its only build tested on non-arm64 platforms.
> > 
> > Could you please share how you've tested this?
> > 
> > Having instructions so that I could reproduce this locally would be very
> > helpful.
> 
> Please find the series rebased on v5.3-rc1 along with test patches which
> enable sysfs interfaces for memory hot add and remove used for testing.
> 
> git://linux-arm.org/linux-anshuman.git (memory_hotremove/v6_resend_v5.3-rc1)
> 
> Sample Testing Procedure:
> 
> echo offline > /sys/devices/system/memory/auto_online_blocks
> echo 0x680000000 > /sys/devices/system/memory/probe
> echo online_movable > /sys/devices/system/memory/memory26/state
> echo 0x680000000 > /sys/devices/system/memory/unprobe
> 
> Writing into unprobe trigger offlining first followed by actual memory removal.
> 
> NOTE:
> 
> This assumes that 0x680000000 is valid memory block starting physical address
> and memory26 gets created because of the preceding memory hot addition. Please
> use appropriate values based on your local setup. Let me know how it goes and
> if I could provide more information.

Thanks for these notes; they're very helpful!

Mark.
