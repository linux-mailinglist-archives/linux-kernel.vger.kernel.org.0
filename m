Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF171345F6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 16:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgAHPUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 10:20:11 -0500
Received: from foss.arm.com ([217.140.110.172]:45920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbgAHPUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:20:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 119CA31B;
        Wed,  8 Jan 2020 07:20:10 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C66493F703;
        Wed,  8 Jan 2020 07:20:08 -0800 (PST)
Subject: Re: [PATCH 2/2] arm: use swiotlb for bounce buffer on LPAE configs
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
References: <20190709142011.24984-1-hch@lst.de>
 <20190709142011.24984-3-hch@lst.de>
 <9bbd87c2-5b6c-069c-dd22-5105dc827428@ti.com> <20191219150259.GA3003@lst.de>
 <20106a84-8247-fa78-2381-2c94fad9cb6a@ti.com>
 <eca457b6-c685-59ac-1dec-5b28e4430e1d@ti.com>
 <d3921764-840c-4d1c-f240-b974b9b83ec8@arm.com>
 <27450c0e-c8aa-d59b-aa32-37f23c232eb7@ti.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0e6decce-c54e-9791-473e-0aef05650f39@arm.com>
Date:   Wed, 8 Jan 2020 15:20:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <27450c0e-c8aa-d59b-aa32-37f23c232eb7@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2020 2:00 pm, Peter Ujfalusi wrote:
> Robin,
> 
> On 08/01/2020 14.21, Robin Murphy wrote:
>> On 08/01/2020 8:28 am, Peter Ujfalusi via iommu wrote:
>>> Hi Christoph,
>>>
>>> On 19/12/2019 17.20, Peter Ujfalusi wrote:
>>>> Hi Christoph,
>>>>
>>>> On 19/12/2019 17.02, Christoph Hellwig wrote:
>>>>> Hi Peter,
>>>>>
>>>>> can you try the patch below (it will need to be split into two):
>>>>
>>>> Thank you!
>>>>
>>>> Unfortunately it does not help:
>>>> [    0.596208] edma: probe of 2700000.edma failed with error -5
>>>> [    0.596626] edma: probe of 2728000.edma failed with error -5
>>>> ...
>>>> [    2.108602] sdhci-omap 23000000.mmc: Got CD GPIO
>>>> [    2.113899] mmc0: Failed to set 32-bit DMA mask.
>>>> [    2.118592] mmc0: No suitable DMA available - falling back to PIO
>>>> [    2.159038] mmc0: SDHCI controller on 23000000.mmc [23000000.mmc]
>>>> using PIO
>>>> [    2.167531] mmc1: Failed to set 32-bit DMA mask.
>>>> [    2.172192] mmc1: No suitable DMA available - falling back to PIO
>>>> [    2.213841] mmc1: SDHCI controller on 23100000.mmc [23100000.mmc]
>>>> using PIO
>>>
>>> Do you have idea on how to fix this in a proper way?
>>>
>>> IMHO when drivers are setting the dma_mask and coherent_mask the
>>> dma_pfn_offset should not be applied to the mask at all.
>>>
>>> If I understand it correctly for EDMA as example:
>>>
>>> I set dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>>> since it can only address memory in this range.
>>>
>>> It does not matter if dma_pfn_offset is 0 or not 0 (like in k2g, where
>>> it is 0x780000) the EDMA still can only address within 32 bits.
>>>
>>> The dma_pfn_offset will tell us that the memory location's physical
>>> address is seen by the DMA at (phys_pfn - dma_pfn_offset) -> dma_pfn.
>>>
>>> The dma_mask should be checked against the dma_pfn.
>>
>> That's exactly what dma_direct_supported() does, though.
> 
> Yes, this is my understanding as well.
> 
>> What it doesn't
>> do, AFAICS, is account for weird cases where the DMA zone *starts* way,
>> way above 32 physical address bits because of an implicit assumption
>> that *all* devices have a dma_pfn_offset equal to min_low_pfn.
> 
> The problem - I think - is that the DMA_BIT_MASK(32) from
> dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32)) is treated as physical
> address along the call path so the dma_pfn_offset is applied to it and
> the check will fail, saying that DMA_BIT_MASK(32) can not be supported.

But that's the thing - in isolation, that is entirely correct. 
Considering ZONE_DMA32 for simplicity, in general the zone is expected 
to cover the physical address range 0x0000_0000 - 0xffff_ffff (because 
DMA offsets are relatively rare), and a device with a dma_pfn_offset of 
more than (0x1_0000_0000 >> PAGE_SHIFT) *cannot* support that range with 
any mask, because the DMA address itself would have to be negative.

The problem is that platforms with esoteric memory maps have no right 
thing to do. If the base of RAM is at at 0x1_0000_0000 or higher, the 
"correct" ZONE_DMA32 would be empty while ZONE_NORMAL above it would 
not, and last time I looked that makes the page allocator break badly. 
So the standard bodge on such platforms is to make ZONE_DMA32 cover not 
the first 4GB of *PA space*, but the first 4GB of *RAM*, wherever that 
happens to be. That then brings different problems - now the page 
allocator is happy and successfully returns GFP_DMA32 allocations from 
the range 0x8_0000_0000 - 0x8_ffff_ffff that are utterly useless to 
32-bit devices with zero dma_pfn_offset - see the AMD Seattle SoC for 
the prime example of that. If on the other hand all devices are 
guaranteed to have a dma_pfn_offset that puts the base of RAM at DMA 
address 0 then GFP_DMA32 allocations do end up working as expected, but 
now the original assumption of where ZONE_DMA32 actually is is broken, 
so generic code unaware of the platform/architecture-specific bodge will 
be misled - that's the case you're running into.

Having thought this far, if there's a non-hacky way to reach in and grab 
ZONE_DMA{32} such that dma_direct_supported() could use zone_end_pfn() 
instead of trying to assume either way, that might be the most robust 
general solution.

Robin.

> Fyi, this is what I have gathered on k2g via prints:
> 
> dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> 
> Prints inside dma_direct_supported():
> sdhci-omap 23000000.mmc: max_pfn: 880000
> sdhci-omap 23000000.mmc: min_mask #1: ffffff
> sdhci-omap 23000000.mmc: min_mask #2: ffffff
> sdhci-omap 23000000.mmc: dev->dma_pfn_offset: 780000
> sdhci-omap 23000000.mmc: PAGE_SHIFT: 12
> sdhci-omap 23000000.mmc: __phys_to_dma(dev, min_mask): ff880ffffff
> sdhci-omap 23000000.mmc: mask: ffffffff
> 
> Print in dma_supported() after returning from dma_direct_supported():
> sdhci-omap 23000000.mmc: dma_is_direct, ret = 0
> 
> sdhci-omap 23100000.mmc: DMA is not supported for the device
> 
> keystone-k2g have this in soc0 node:
> dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;
> 
> DDR starts at 0x8 0000 0000 (8G) and 2G is aliased at 0x8000 0000.
> 
> This gives the 0x780000 for dma_pfn_offset for all devices underneath it.
> 
> The DMA_BIT_MASK(24) is passed to __phys_to_dma() because
> CONFIG_ZONE_DMA is enabled.
> 
> SWIOTLB is enabled in kconfig.
> 
>> I'm not sure how possible it is to cope with that generically.
> 
> Me neither, but k2g is failing since v5.3-rc3 and the bisect pointed to
> this commit.
> 
>>
>> Robin.
>>
>>> We can not 'move' the dma_mask with dma_pfn_offset when setting the mask
>>> since it is not correct. The DMA can access in 32 bits range and we have
>>> the peripherals under 0x8000 0000.
>>>
>>> I might be missing something, but it looks to me that the way we set the
>>> dma_mask and the coherent_mask is the place where this can be fixed.
>>>
>>> Best regards,
>>> - Péter
>>>
>>>>
>>>> - Péter
>>>>
>>>>
>>>>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>>>>> index e822af0d9219..30b9c6786ce3 100644
>>>>> --- a/arch/arm/mm/dma-mapping.c
>>>>> +++ b/arch/arm/mm/dma-mapping.c
>>>>> @@ -221,7 +221,8 @@ EXPORT_SYMBOL(arm_coherent_dma_ops);
>>>>>      static int __dma_supported(struct device *dev, u64 mask, bool warn)
>>>>>    {
>>>>> -    unsigned long max_dma_pfn = min(max_pfn, arm_dma_pfn_limit);
>>>>> +    unsigned long max_dma_pfn =
>>>>> +        min_t(unsigned long, max_pfn, zone_dma_limit >> PAGE_SHIFT);
>>>>>          /*
>>>>>         * Translate the device's DMA mask to a PFN limit.  This
>>>>> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
>>>>> index 3ef204137e73..dd0e169a1bb1 100644
>>>>> --- a/arch/arm/mm/init.c
>>>>> +++ b/arch/arm/mm/init.c
>>>>> @@ -19,6 +19,7 @@
>>>>>    #include <linux/gfp.h>
>>>>>    #include <linux/memblock.h>
>>>>>    #include <linux/dma-contiguous.h>
>>>>> +#include <linux/dma-direct.h>
>>>>>    #include <linux/sizes.h>
>>>>>    #include <linux/stop_machine.h>
>>>>>    #include <linux/swiotlb.h>
>>>>> @@ -84,15 +85,6 @@ static void __init find_limits(unsigned long
>>>>> *min, unsigned long *max_low,
>>>>>    phys_addr_t arm_dma_zone_size __read_mostly;
>>>>>    EXPORT_SYMBOL(arm_dma_zone_size);
>>>>>    -/*
>>>>> - * The DMA mask corresponding to the maximum bus address allocatable
>>>>> - * using GFP_DMA.  The default here places no restriction on DMA
>>>>> - * allocations.  This must be the smallest DMA mask in the system,
>>>>> - * so a successful GFP_DMA allocation will always satisfy this.
>>>>> - */
>>>>> -phys_addr_t arm_dma_limit;
>>>>> -unsigned long arm_dma_pfn_limit;
>>>>> -
>>>>>    static void __init arm_adjust_dma_zone(unsigned long *size,
>>>>> unsigned long *hole,
>>>>>        unsigned long dma_size)
>>>>>    {
>>>>> @@ -108,14 +100,14 @@ static void __init
>>>>> arm_adjust_dma_zone(unsigned long *size, unsigned long *hole,
>>>>>      void __init setup_dma_zone(const struct machine_desc *mdesc)
>>>>>    {
>>>>> -#ifdef CONFIG_ZONE_DMA
>>>>> -    if (mdesc->dma_zone_size) {
>>>>> +    if (!IS_ENABLED(CONFIG_ZONE_DMA)) {
>>>>> +        zone_dma_limit = ((phys_addr_t)~0);
>>>>> +    } else if (mdesc->dma_zone_size) {
>>>>>            arm_dma_zone_size = mdesc->dma_zone_size;
>>>>> -        arm_dma_limit = PHYS_OFFSET + arm_dma_zone_size - 1;
>>>>> -    } else
>>>>> -        arm_dma_limit = 0xffffffff;
>>>>> -    arm_dma_pfn_limit = arm_dma_limit >> PAGE_SHIFT;
>>>>> -#endif
>>>>> +        zone_dma_limit = PHYS_OFFSET + arm_dma_zone_size - 1;
>>>>> +    } else {
>>>>> +        zone_dma_limit = 0xffffffff;
>>>>> +    }
>>>>>    }
>>>>>      static void __init zone_sizes_init(unsigned long min, unsigned
>>>>> long max_low,
>>>>> @@ -279,7 +271,7 @@ void __init arm_memblock_init(const struct
>>>>> machine_desc *mdesc)
>>>>>        early_init_fdt_scan_reserved_mem();
>>>>>          /* reserve memory for DMA contiguous allocations */
>>>>> -    dma_contiguous_reserve(arm_dma_limit);
>>>>> +    dma_contiguous_reserve(zone_dma_limit);
>>>>>          arm_memblock_steal_permitted = false;
>>>>>        memblock_dump_all();
>>>>> diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
>>>>> index 88c121ac14b3..7dbd77554273 100644
>>>>> --- a/arch/arm/mm/mm.h
>>>>> +++ b/arch/arm/mm/mm.h
>>>>> @@ -82,14 +82,6 @@ extern __init void add_static_vm_early(struct
>>>>> static_vm *svm);
>>>>>      #endif
>>>>>    -#ifdef CONFIG_ZONE_DMA
>>>>> -extern phys_addr_t arm_dma_limit;
>>>>> -extern unsigned long arm_dma_pfn_limit;
>>>>> -#else
>>>>> -#define arm_dma_limit ((phys_addr_t)~0)
>>>>> -#define arm_dma_pfn_limit (~0ul >> PAGE_SHIFT)
>>>>> -#endif
>>>>> -
>>>>>    extern phys_addr_t arm_lowmem_limit;
>>>>>      void __init bootmem_init(void);
>>>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>>>> index b65dffdfb201..7a7501acd763 100644
>>>>> --- a/arch/arm64/mm/init.c
>>>>> +++ b/arch/arm64/mm/init.c
>>>>> @@ -441,7 +441,7 @@ void __init arm64_memblock_init(void)
>>>>>        early_init_fdt_scan_reserved_mem();
>>>>>          if (IS_ENABLED(CONFIG_ZONE_DMA)) {
>>>>> -        zone_dma_bits = ARM64_ZONE_DMA_BITS;
>>>>> +        zone_dma_limit = DMA_BIT_MASK(ARM64_ZONE_DMA_BITS);
>>>>>            arm64_dma_phys_limit = max_zone_phys(ARM64_ZONE_DMA_BITS);
>>>>>        }
>>>>>    diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
>>>>> index 9488b63dfc87..337ace03d3f0 100644
>>>>> --- a/arch/powerpc/mm/mem.c
>>>>> +++ b/arch/powerpc/mm/mem.c
>>>>> @@ -223,7 +223,7 @@ static int __init mark_nonram_nosave(void)
>>>>>     * everything else. GFP_DMA32 page allocations automatically fall
>>>>> back to
>>>>>     * ZONE_DMA.
>>>>>     *
>>>>> - * By using 31-bit unconditionally, we can exploit zone_dma_bits to
>>>>> inform the
>>>>> + * By using 31-bit unconditionally, we can exploit zone_dma_limit
>>>>> to inform the
>>>>>     * generic DMA mapping code.  32-bit only devices (if not handled
>>>>> by an IOMMU
>>>>>     * anyway) will take a first dip into ZONE_NORMAL and get
>>>>> otherwise served by
>>>>>     * ZONE_DMA.
>>>>> @@ -257,18 +257,20 @@ void __init paging_init(void)
>>>>>        printk(KERN_DEBUG "Memory hole size: %ldMB\n",
>>>>>               (long int)((top_of_ram - total_ram) >> 20));
>>>>>    +#ifdef CONFIG_ZONE_DMA
>>>>>        /*
>>>>>         * Allow 30-bit DMA for very limited Broadcom wifi chips on many
>>>>>         * powerbooks.
>>>>>         */
>>>>> -    if (IS_ENABLED(CONFIG_PPC32))
>>>>> -        zone_dma_bits = 30;
>>>>> -    else
>>>>> -        zone_dma_bits = 31;
>>>>> -
>>>>> -#ifdef CONFIG_ZONE_DMA
>>>>> -    max_zone_pfns[ZONE_DMA]    = min(max_low_pfn,
>>>>> -                      1UL << (zone_dma_bits - PAGE_SHIFT));
>>>>> +    if (IS_ENABLED(CONFIG_PPC32)) {
>>>>> +        zone_dma_limit = DMA_BIT_MASK(30);
>>>>> +        max_zone_pfns[ZONE_DMA]    = min(max_low_pfn,
>>>>> +                          1UL << (30 - PAGE_SHIFT));
>>>>> +    } else {
>>>>> +        zone_dma_limit = DMA_BIT_MASK(31);
>>>>> +        max_zone_pfns[ZONE_DMA]    = min(max_low_pfn,
>>>>> +                          1UL << (31 - PAGE_SHIFT));
>>>>> +    }
>>>>>    #endif
>>>>>        max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
>>>>>    #ifdef CONFIG_HIGHMEM
>>>>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>>>>> index f0ce22220565..c403f61cb56b 100644
>>>>> --- a/arch/s390/mm/init.c
>>>>> +++ b/arch/s390/mm/init.c
>>>>> @@ -118,7 +118,7 @@ void __init paging_init(void)
>>>>>          sparse_memory_present_with_active_regions(MAX_NUMNODES);
>>>>>        sparse_init();
>>>>> -    zone_dma_bits = 31;
>>>>> +    zone_dma_limit = DMA_BIT_MASK(31);
>>>>>        memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
>>>>>        max_zone_pfns[ZONE_DMA] = PFN_DOWN(MAX_DMA_ADDRESS);
>>>>>        max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
>>>>> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
>>>>> index 24b8684aa21d..20d56d597506 100644
>>>>> --- a/include/linux/dma-direct.h
>>>>> +++ b/include/linux/dma-direct.h
>>>>> @@ -6,7 +6,7 @@
>>>>>    #include <linux/memblock.h> /* for min_low_pfn */
>>>>>    #include <linux/mem_encrypt.h>
>>>>>    -extern unsigned int zone_dma_bits;
>>>>> +extern phys_addr_t zone_dma_limit;
>>>>>      #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
>>>>>    #include <asm/dma-direct.h>
>>>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>>>> index 6af7ae83c4ad..5ea1bed2ba6f 100644
>>>>> --- a/kernel/dma/direct.c
>>>>> +++ b/kernel/dma/direct.c
>>>>> @@ -21,7 +21,7 @@
>>>>>     * it for entirely different regions. In that case the arch code
>>>>> needs to
>>>>>     * override the variable below for dma-direct to work properly.
>>>>>     */
>>>>> -unsigned int zone_dma_bits __ro_after_init = 24;
>>>>> +phys_addr_t zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
>>>>>      static void report_addr(struct device *dev, dma_addr_t dma_addr,
>>>>> size_t size)
>>>>>    {
>>>>> @@ -74,7 +74,7 @@ static gfp_t __dma_direct_optimal_gfp_mask(struct
>>>>> device *dev, u64 dma_mask,
>>>>>         * Note that GFP_DMA32 and GFP_DMA are no ops without the
>>>>> corresponding
>>>>>         * zones.
>>>>>         */
>>>>> -    if (*phys_limit <= DMA_BIT_MASK(zone_dma_bits))
>>>>> +    if (*phys_limit <= zone_dma_limit)
>>>>>            return GFP_DMA;
>>>>>        if (*phys_limit <= DMA_BIT_MASK(32))
>>>>>            return GFP_DMA32;
>>>>> @@ -483,7 +483,7 @@ int dma_direct_supported(struct device *dev, u64
>>>>> mask)
>>>>>        u64 min_mask;
>>>>>          if (IS_ENABLED(CONFIG_ZONE_DMA))
>>>>> -        min_mask = DMA_BIT_MASK(zone_dma_bits);
>>>>> +        min_mask = zone_dma_limit;
>>>>>        else
>>>>>            min_mask = DMA_BIT_MASK(32);
>>>>>   
>>>>> _______________________________________________
>>>>> linux-arm-kernel mailing list
>>>>> linux-arm-kernel@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>>
>>>>
>>>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>>>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
>>>
>>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>> _______________________________________________
>>> iommu mailing list
>>> iommu@lists.linux-foundation.org
>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>>
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
