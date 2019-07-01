Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41DDD2C1E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 10:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfE1I61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 04:58:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52688 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfE1I61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:58:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6506A341;
        Tue, 28 May 2019 01:58:26 -0700 (PDT)
Received: from [192.168.1.27] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9EFD3F59C;
        Tue, 28 May 2019 01:58:23 -0700 (PDT)
Subject: Re: [PATCH 2/4] arm64/mm: wire up CONFIG_ARCH_HAS_SET_DIRECT_MAP
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com, marc.zyngier@arm.com,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20190523102256.29168-1-ard.biesheuvel@arm.com>
 <20190523102256.29168-3-ard.biesheuvel@arm.com>
 <e63e7367-3a37-9ebc-d17c-e1cef2948c6e@arm.com>
 <7ab5edf6-e538-f052-471a-8e56f62bcfef@arm.com>
 <ffbe4590-d362-1f3d-81fa-4783b603f8d1@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
Message-ID: <9be05b0a-6ef1-7f60-e900-08f45114ecf7@arm.com>
Date:   Tue, 28 May 2019 10:58:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ffbe4590-d362-1f3d-81fa-4783b603f8d1@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/19 10:41 AM, Anshuman Khandual wrote:
> 
> 
> On 05/28/2019 01:50 PM, Ard Biesheuvel wrote:
>> On 5/28/19 10:10 AM, Anshuman Khandual wrote:
>>>
>>>
>>> On 05/23/2019 03:52 PM, Ard Biesheuvel wrote:
>>>> Wire up the special helper functions to manipulate aliases of vmalloc
>>>> regions in the linear map.
>>>
>>> IMHO the commit message here could be bit more descriptive because of the
>>> amount of changes this patch brings in.
>>>
>>>>
>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
>>>> ---
>>>>    arch/arm64/Kconfig                  |  1 +
>>>>    arch/arm64/include/asm/cacheflush.h |  3 ++
>>>>    arch/arm64/mm/pageattr.c            | 48 ++++++++++++++++----
>>>>    mm/vmalloc.c                        | 11 -----
>>>>    4 files changed, 44 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>> index ca9c175fb949..4ab32180eabd 100644
>>>> --- a/arch/arm64/Kconfig
>>>> +++ b/arch/arm64/Kconfig
>>>> @@ -26,6 +26,7 @@ config ARM64
>>>>        select ARCH_HAS_MEMBARRIER_SYNC_CORE
>>>>        select ARCH_HAS_PTE_SPECIAL
>>>>        select ARCH_HAS_SETUP_DMA_OPS
>>>> +    select ARCH_HAS_SET_DIRECT_MAP
>>>>        select ARCH_HAS_SET_MEMORY
>>>>        select ARCH_HAS_STRICT_KERNEL_RWX
>>>>        select ARCH_HAS_STRICT_MODULE_RWX
>>>> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
>>>> index 19844211a4e6..b9ee5510067f 100644
>>>> --- a/arch/arm64/include/asm/cacheflush.h
>>>> +++ b/arch/arm64/include/asm/cacheflush.h
>>>> @@ -187,4 +187,7 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
>>>>      int set_memory_valid(unsigned long addr, int numpages, int enable);
>>>>    +int set_direct_map_invalid_noflush(struct page *page);
>>>> +int set_direct_map_default_noflush(struct page *page);
>>>> +
>>>>    #endif
>>>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>>>> index 6cd645edcf35..9c6b9039ec8f 100644
>>>> --- a/arch/arm64/mm/pageattr.c
>>>> +++ b/arch/arm64/mm/pageattr.c
>>>> @@ -159,17 +159,48 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
>>>>                        __pgprot(PTE_VALID));
>>>>    }
>>>>    -#ifdef CONFIG_DEBUG_PAGEALLOC
>>>> +int set_direct_map_invalid_noflush(struct page *page)
>>>> +{
>>>> +    struct page_change_data data = {
>>>> +        .set_mask = __pgprot(0),
>>>> +        .clear_mask = __pgprot(PTE_VALID),
>>>> +    };
>>>> +
>>>> +    if (!rodata_full)
>>>> +        return 0;
>>>
>>> Why rodata_full needs to be probed here ? Should not we still require the following
>>> transition even if rodata_full is not enabled. Just wondering whether we can use
>>> VM_FLUSH_RESET_PERMS feature without these required transitions.
>>>
>>>           /*
>>>            * Set direct map to something invalid so that it won't be cached if
>>>            * there are any accesses after the TLB flush, then flush the TLB and
>>>            * reset the direct map permissions to the default.
>>>            */
>>>           set_area_direct_map(area, set_direct_map_invalid_noflush);
>>>           _vm_unmap_aliases(start, end, 1);
>>>           set_area_direct_map(area, set_direct_map_default_noflush);
>>>
>>>    > +
>>
>> How would that work? With rodata_full disabled, the linear region is not mapped down to pages, and so there is no way we can manipulate linear aliases at page granularity.
> 
> Then should not we check debug_pagealloc_enabled() as well as in case
> for __kernel_map_pages() later in the patch.
> 

Yes, what we could do technically is to permit the direct_map_xx() calls 
to proceed if debug_pagealloc_enabled() returns true, since we are 
guaranteed to have a page granular mapping of the entire linear region.

However, that means we will be manipulating the linear aliases of 
vmalloc mappings even if the user has requested us not to, i.e., by 
passing rodata=on rather than rodata=full, so I don't think we should be 
doing that.


>>
>>>> +    return apply_to_page_range(&init_mm,
>>>> +                   (unsigned long)page_address(page),
>>>> +                   PAGE_SIZE, change_page_range, &data);
>>>> +}
>>>> +
>>>> +int set_direct_map_default_noflush(struct page *page)
>>>> +{
>>>> +    struct page_change_data data = {
>>>> +        .set_mask = __pgprot(PTE_VALID | PTE_WRITE),
>>>> +        .clear_mask = __pgprot(PTE_RDONLY),
>>>
>>> Replace __pgprot(PTE_VALID | PTE_WRITE) with PAGE_KERNEL instead !
>>>
>>
>> This is a delta mask, so no need to pull in the PTE_MAYBE_NG or other attributes that we know we haven't changed.
>>
>>>> +    };
>>>> +
>>>> +    if (!rodata_full)
>>>> +        return 0;
>>>> +
>>>> +    return apply_to_page_range(&init_mm,
>>>> +                   (unsigned long)page_address(page),
>>>> +                   PAGE_SIZE, change_page_range, &data);
>>>> +}
>>>> +
>>>
>>> IIUC set_direct_map_invalid_noflush() and set_direct_map_default_noflush()
>>> should set *appropriate* permissions as seen fit from platform perspective
>>> to implement this transition.
>>>
>>> In here set_direct_map_invalid_noflush() makes the entry invalid preventing
>>> further MMU walks (hence new TLB entries). set_direct_map_default_noflush()
>>> makes it a valid write entry. Though it looks similar to PAGE_KERNEL which
>>> is the default permission for linear mapping on arm64 via __map_memblock().
>>> Should not PAGE_KERNEL be used explicitly as suggested above.
>>>
>>
>> No. We should restore the attributes that we cleared when manipulating the linear aliases. There isn't a lot of code that does that, so I don't see the need to use PAGE_KERNEL here.
> 
> Fair enough.
> 
>>
>>>>    void __kernel_map_pages(struct page *page, int numpages, int enable)
>>>>    {
>>>> +    if (!debug_pagealloc_enabled() && !rodata_full)
>>>> +        return;
>>>> +
>>>
>>> I guess this is not related to CONFIG_ARCH_HAS_SET_DIRECT_MAP here and should
>>> be a fix or an enhancement to CONFIG_DEBUG_PAGEALLOC implementation. Just
>>> curious, !rodata_full check here to ensure that linear mapping does not have
>>> block or contig mappings and should be backed by regular pages only ?
>>>
>>
>> It is related. CONFIG_ARCH_HAS_SET_DIRECT_MAP introduces references to __kernel_map_pages() in generic code, so enabling CONFIG_ARCH_HAS_SET_DIRECT_MAP should make __kernel_map_pages() available unconditionally as well.
> 
> Ahh, got it.
> 
>>
>>>>        set_memory_valid((unsigned long)page_address(page), numpages, enable);
>>>>    }
>>>> -#ifdef CONFIG_HIBERNATION
>>>> +
>>>>    /*
>>>> - * When built with CONFIG_DEBUG_PAGEALLOC and CONFIG_HIBERNATION, this function
>>>> - * is used to determine if a linear map page has been marked as not-valid by
>>>> - * CONFIG_DEBUG_PAGEALLOC. Walk the page table and check the PTE_VALID bit.
>>>> - * This is based on kern_addr_valid(), which almost does what we need.
>>>> + * This function is used to determine if a linear map page has been marked as
>>>> + * not-valid. Walk the page table and check the PTE_VALID bit. This is based
>>>> + * on kern_addr_valid(), which almost does what we need.
>>>>     *
>>>>     * Because this is only called on the kernel linear map,  p?d_sect() implies
>>>>     * p?d_present(). When debug_pagealloc is enabled, sections mappings are
>>>> @@ -183,6 +214,9 @@ bool kernel_page_present(struct page *page)
>>>>        pte_t *ptep;
>>>>        unsigned long addr = (unsigned long)page_address(page);
>>>>    +    if (!debug_pagealloc_enabled() && !rodata_full)
>>>> +        return true;
>>>> +
>>>
>>> Ditto, not related to CONFIG_ARCH_HAS_SET_DIRECT_MAP.
>>>
>>
>> It is related.
> 
> Never mind.
> 

