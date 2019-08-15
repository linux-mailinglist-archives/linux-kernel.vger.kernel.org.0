Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43FE88F358
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 20:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732611AbfHOS1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 14:27:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729855AbfHOS1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:27:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E6C586663;
        Thu, 15 Aug 2019 18:27:23 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 60A1C5C1D6;
        Thu, 15 Aug 2019 18:27:21 +0000 (UTC)
Date:   Thu, 15 Aug 2019 14:27:19 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/5] kernel.h: Add non_block_start/end()
Message-ID: <20190815182719.GB4920@redhat.com>
References: <20190815084429.GE9477@dhcp22.suse.cz>
 <20190815130415.GD21596@ziepe.ca>
 <CAKMK7uE9zdmBuvxa788ONYky=46GN=5Up34mKDmsJMkir4x7MQ@mail.gmail.com>
 <20190815143759.GG21596@ziepe.ca>
 <CAKMK7uEJQ6mPQaOWbT_6M+55T-dCVbsOxFnMC6KzLAMQNa-RGg@mail.gmail.com>
 <20190815151028.GJ21596@ziepe.ca>
 <CAKMK7uG33FFCGJrDV4-FHT2FWi+Z5SnQ7hoyBQd4hignzm1C-A@mail.gmail.com>
 <20190815173557.GN21596@ziepe.ca>
 <20190815173922.GH30916@redhat.com>
 <20190815180159.GO21596@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190815180159.GO21596@ziepe.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 15 Aug 2019 18:27:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 03:01:59PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 15, 2019 at 01:39:22PM -0400, Jerome Glisse wrote:
> > On Thu, Aug 15, 2019 at 02:35:57PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Aug 15, 2019 at 06:25:16PM +0200, Daniel Vetter wrote:
> > > 
> > > > I'm not really well versed in the details of our userptr, but both
> > > > amdgpu and i915 wait for the gpu to complete from
> > > > invalidate_range_start. Jerome has at least looked a lot at the amdgpu
> > > > one, so maybe he can explain what exactly it is we're doing ...
> > > 
> > > amdgpu is (wrongly) using hmm for something, I can't really tell what
> > > it is trying to do. The calls to dma_fence under the
> > > invalidate_range_start do not give me a good feeling.
> > > 
> > > However, i915 shows all the signs of trying to follow the registration
> > > cache model, it even has a nice comment in
> > > i915_gem_userptr_get_pages() explaining that the races it has don't
> > > matter because it is a user space bug to change the VA mapping in the
> > > first place. That just screams registration cache to me.
> > > 
> > > So it is fine to run HW that way, but if you do, there is no reason to
> > > fence inside the invalidate_range end. Just orphan the DMA buffer and
> > > clean it up & release the page pins when all DMA buffer refs go to
> > > zero. The next access to that VA should get a new DMA buffer with the
> > > right mapping.
> > > 
> > > In other words the invalidation should be very simple without
> > > complicated locking, or wait_event's. Look at hfi1 for example.
> > 
> > This would break the today usage model of uptr and it will
> > break userspace expectation ie if GPU is writting to that
> > memory and that memory then the userspace want to make sure
> > that it will see what the GPU write.
> 
> How exactly? This is holding the page pin, so the only way the VA
> mapping can be changed is via explicit user action.
> 
> ie:
> 
>    gpu_write_something(va, size)
>    mmap(.., va, size, MMAP_FIXED);
>    gpu_wait_done()
> 
> This is racy and indeterminate with both models.
> 
> Based on the comment in i915 it appears to be going on the model that
> changes to the mmap by userspace when the GPU is working on it is a
> programming bug. This is reasonable, lots of systems use this kind of
> consistency model.

Well userspace process doing munmap(), mremap(), fork() and things like
that are a bug from the i915 kernel and userspace contract point of view.

But things like migration or reclaim are not cover under that contract
and for those the expectation is that CPU access to the same virtual address
should allow to get what was last written to it either by the GPU or the
CPU.

> 
> Since the driver seems to rely on a dma_fence to block DMA access, it
> looks to me like the kernel has full visibility to the
> 'gpu_write_something()' and 'gpu_wait_done()' markers.

So let's only consider the case where GPU wants to write to the memory
(the read only case is obviously right and not need any notifier in
fact) and like above the only thing we care about is reclaim or migration
(for instance because of some numa compaction) as the rest is cover by
i915 userspace contract.

So in the write case we do GUPfast(write=true) which will be "safe" from
any concurrent CPU page table update ie if GUPfast get a reference for
the page then any racing CPU page table update will not be able to migrate
or reclaim the page and thus the virtual address to page association will
be preserve.

This is only true because of GUPfast(), now if GUPfast() fails it will
fallback to the slow GUP case which make the same thing safe by taking
the page table lock.

Because of the reference on the page the i915 driver can forego the mmu
notifier end callback. The thing here is that taking a page reference
is pointless if we have better synchronization and tracking of mmu
notifier. Hence converting to hmm mirror allows to avoid taking a ref
on the page while still keeping the same functionality as of today.


> I think trying to use hmm_range_fault on HW that can't do HW page
> faulting and HW 'TLB shootdown' is a very, very bad idea. I fear that
> is what amd gpu is trying to do.
> 
> I haven't yet seen anything that looks like 'TLB shootdown' in i915??

GPU driver have complex usage pattern the tlb shootdown is implicit
once the GEM object associated with the uptr is invalidated it means
next time userspace submit command against that GEM object it will
have to re-validate it which means re-program the GPU page table to
point to the proper address (and re-call GUP).

So the whole GPU page table update is all hidden behind GEM function
like i915_gem_object_unbind() (or ttm invalidate for amd/radeon).

Technicaly those GPU do not support page faulting but because of the
way GPU works you know that you have frequent checkpoint where you
can unbind things. This is what is happening here.

Also not all GPU engines can handle page fault, this is true of all
GPU with page fault AFAIK (AMD and NVidia so far). This is why
uptr is a limited form of SVM (share virtual memory) that can be
use on all GPUs engine including the dma engine. When using the
full SVM power (like hmm mirror with nouveau) this is only use in
GPU engine that supports page fault (but updating the page table
still require locking and waiting on acknowledge).

Cheers,
J�r�me
