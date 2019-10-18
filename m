Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22CE0DC2FD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 12:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393192AbfJRKoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 06:44:11 -0400
Received: from relay.sw.ru ([185.231.240.75]:32934 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389040AbfJRKoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:44:11 -0400
Received: from [172.16.25.5]
        by relay.sw.ru with esmtp (Exim 4.92.2)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iLPjg-0004Zn-5t; Fri, 18 Oct 2019 13:43:56 +0300
Subject: Re: [PATCH v8 1/5] kasan: support backing vmalloc space with real
 shadow memory
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Daniel Axtens <dja@axtens.net>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, x86@kernel.org, glider@google.com,
        luto@kernel.org, linux-kernel@vger.kernel.org, dvyukov@google.com,
        christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
        gor@linux.ibm.com
References: <20191001065834.8880-1-dja@axtens.net>
 <20191001065834.8880-2-dja@axtens.net>
 <352cb4fa-2e57-7e3b-23af-898e113bbe22@virtuozzo.com>
 <87ftjvtoo7.fsf@dja-thinkpad.axtens.net>
 <8f573b40-3a5a-ed36-dffb-4a54faf3c4e1@virtuozzo.com>
 <20191016132233.GA46264@lakrids.cambridge.arm.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <95c87ba1-9c15-43fb-dba7-f3ecd01be8e0@virtuozzo.com>
Date:   Fri, 18 Oct 2019 13:43:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016132233.GA46264@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/19 4:22 PM, Mark Rutland wrote:
> Hi Andrey,
> 
> On Wed, Oct 16, 2019 at 03:19:50PM +0300, Andrey Ryabinin wrote:
>> On 10/14/19 4:57 PM, Daniel Axtens wrote:
>>>>> +	/*
>>>>> +	 * Ensure poisoning is visible before the shadow is made visible
>>>>> +	 * to other CPUs.
>>>>> +	 */
>>>>> +	smp_wmb();
>>>>
>>>> I'm not quite understand what this barrier do and why it needed.
>>>> And if it's really needed there should be a pairing barrier
>>>> on the other side which I don't see.
>>>
>>> Mark might be better able to answer this, but my understanding is that
>>> we want to make sure that we never have a situation where the writes are
>>> reordered so that PTE is installed before all the poisioning is written
>>> out. I think it follows the logic in __pte_alloc() in mm/memory.c:
>>>
>>> 	/*
>>> 	 * Ensure all pte setup (eg. pte page lock and page clearing) are
>>> 	 * visible before the pte is made visible to other CPUs by being
>>> 	 * put into page tables.
>>> 	 *
>>> 	 * The other side of the story is the pointer chasing in the page
>>> 	 * table walking code (when walking the page table without locking;
>>> 	 * ie. most of the time). Fortunately, these data accesses consist
>>> 	 * of a chain of data-dependent loads, meaning most CPUs (alpha
>>> 	 * being the notable exception) will already guarantee loads are
>>> 	 * seen in-order. See the alpha page table accessors for the
>>> 	 * smp_read_barrier_depends() barriers in page table walking code.
>>> 	 */
>>> 	smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
>>>
>>> I can clarify the comment.
>>
>> I don't see how is this relevant here.
> 
> The problem isn't quite the same, but it's a similar shape. See below
> for more details.
> 
>> barrier in __pte_alloc() for very the following case:
>>
>> CPU 0							CPU 1
>> __pte_alloc():                                          pte_offset_kernel(pmd_t * dir, unsigned long address):
>>      pgtable_t new = pte_alloc_one(mm);                        pte_t *new = (pte_t *) pmd_page_vaddr(*dir) + ((address >> PAGE_SHIFT) & (PTRS_PER_PAGE - 1));  
>>      smp_wmb();                                                smp_read_barrier_depends();
>>      pmd_populate(mm, pmd, new);
>> 							/* do something with pte, e.g. check if (pte_none(*new)) */
>>
>>
>> It's needed to ensure that if CPU1 sees pmd_populate() it also sees initialized contents of the 'new'.
>>
>> In our case the barrier would have been needed if we had the other side like this:
>>
>> if (!pte_none(*vmalloc_shadow_pte)) {
>> 	shadow_addr = (unsigned long)__va(pte_pfn(*vmalloc_shadow_pte) << PAGE_SHIFT);
>> 	smp_read_barrier_depends();
>> 	*shadow_addr; /* read the shadow, barrier ensures that if we see installed pte, we will see initialized shadow memory. */
>> }
>>
>>
>> Without such other side the barrier is pointless.
> 
> The barrier isn't pointless, but we are relying on a subtlety that is
> not captured in LKMM, as one of the observers involved is the TLB (and
> associated page table walkers) of the CPU.
> 
> Until the PTE written by CPU 0 has been observed by the TLB of CPU 1, it
> is not possible for CPU 1 to satisfy loads from the memory that PTE
> maps, as it doesn't yet know which memory that is.
> 
> Once the PTE written by CPU has been observed by the TLB of CPU 1, it is
> possible for CPU 1 to satisfy those loads. At this instant, CPU 1 must
> respect the smp_wmb() before the PTE was written, and hence sees zeroes
                                                                 s/zeroes/poison values

> written before this. Note that if this were not true, we could not
> safely swap userspace memory.
> 
> There is the risk (as laid out in [1]) that CPU 1 attempts to hoist the
> loads of the shadow memory above the load of the PTE, samples a stale
> (faulting) status from the TLB, then performs the load of the PTE and
> sees a valid value. In this case (on arm64) a spurious fault could be
> taken when the access is architecturally performed.
> 
> It is possible on arm64 to use a barrier here to prevent the spurious
> fault, but this is not smp_read_barrier_depends(), as that does nothing
> for everyone but alpha. On arm64 We have a spurious fault handler to fix
> this up.
>  

None of that really explains how the race looks like.
Please, describe concrete race race condition diagram starting with something like

CPU0                   CPU1
p0 = vmalloc()         p1 = vmalloc()
...




Or let me put it this way. Let's assume that CPU0 accesses shadow and CPU1 did the memset() and installed pte.
CPU0 may not observe memset() only if it dereferences completely random vmalloc addresses
or it performs out-of-bounds access which crosses KASAN_SHADOW_SCALE*PAGE_SIZE boundary, i.e. access to shadow crosses page boundary.
In both cases it will be hard to avoid crashes. OOB crossing the page boundary in vmalloc pretty much guarantees crash because of guard page,
and derefencing random address isn't going to last for long.

If CPU0 obtained pointer via vmalloc() call and it's doing out-of-bounds (within boundaries of the page) or use-after-free,
than the spin_[un]lock(&init_mm.page_table_lock) should allow CPU0 to see the memset done by CPU1 without any additional barrier.

