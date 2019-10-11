Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9286D37A3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 04:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfJKC4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 22:56:17 -0400
Received: from foss.arm.com ([217.140.110.172]:47710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfJKC4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 22:56:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52B0028;
        Thu, 10 Oct 2019 19:56:16 -0700 (PDT)
Received: from [10.162.41.129] (p8cg001049571a15.blr.arm.com [10.162.41.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AD603F71A;
        Thu, 10 Oct 2019 19:56:09 -0700 (PDT)
Subject: Re: [PATCH V9 2/2] arm64/mm: Enable memory hot remove
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        will@kernel.org, mark.rutland@arm.com, david@redhat.com,
        cai@lca.pw, logang@deltatee.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com,
        mgorman@techsingularity.net, osalvador@suse.de,
        ard.biesheuvel@arm.com, steve.capper@arm.com, broonie@kernel.org,
        valentin.schneider@arm.com, Robin.Murphy@arm.com,
        steven.price@arm.com, suzuki.poulose@arm.com, ira.weiny@intel.com
References: <1570609308-15697-1-git-send-email-anshuman.khandual@arm.com>
 <1570609308-15697-3-git-send-email-anshuman.khandual@arm.com>
 <20191010113433.GI28269@mbp>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f51cdb20-ddc4-4fb7-6c45-791d2e1e690c@arm.com>
Date:   Fri, 11 Oct 2019 08:26:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191010113433.GI28269@mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2019 05:04 PM, Catalin Marinas wrote:
> Hi Anshuman,
> 
> On Wed, Oct 09, 2019 at 01:51:48PM +0530, Anshuman Khandual wrote:
>> +static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
>> +				    unsigned long end, bool free_mapped)
>> +{
>> +	unsigned long next;
>> +	pmd_t *pmdp, pmd;
>> +
>> +	do {
>> +		next = pmd_addr_end(addr, end);
>> +		pmdp = pmd_offset(pudp, addr);
>> +		pmd = READ_ONCE(*pmdp);
>> +		if (pmd_none(pmd))
>> +			continue;
>> +
>> +		WARN_ON(!pmd_present(pmd));
>> +		if (pmd_sect(pmd)) {
>> +			pmd_clear(pmdp);
>> +			flush_tlb_kernel_range(addr, next);
> 
> The range here could be a whole PMD_SIZE. Since we are invalidating a
> single block entry, one TLBI should be sufficient:
> 
> 			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);

Sure, will change.

> 
>> +			if (free_mapped)
>> +				free_hotplug_page_range(pmd_page(pmd),
>> +							PMD_SIZE);
>> +			continue;
>> +		}
>> +		WARN_ON(!pmd_table(pmd));
>> +		unmap_hotplug_pte_range(pmdp, addr, next, free_mapped);
>> +	} while (addr = next, addr < end);
>> +}
>> +
>> +static void unmap_hotplug_pud_range(pgd_t *pgdp, unsigned long addr,
>> +				    unsigned long end, bool free_mapped)
>> +{
>> +	unsigned long next;
>> +	pud_t *pudp, pud;
>> +
>> +	do {
>> +		next = pud_addr_end(addr, end);
>> +		pudp = pud_offset(pgdp, addr);
>> +		pud = READ_ONCE(*pudp);
>> +		if (pud_none(pud))
>> +			continue;
>> +
>> +		WARN_ON(!pud_present(pud));
>> +		if (pud_sect(pud)) {
>> +			pud_clear(pudp);
>> +			flush_tlb_kernel_range(addr, next);
> 			^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);

Will change.

> 
> [...]
>> +static void free_empty_pte_table(pmd_t *pmdp, unsigned long addr,
>> +				 unsigned long end, unsigned long floor,
>> +				 unsigned long ceiling)
>> +{
>> +	pte_t *ptep, pte;
>> +	unsigned long i, start = addr;
>> +
>> +	do {
>> +		ptep = pte_offset_kernel(pmdp, addr);
>> +		pte = READ_ONCE(*ptep);
>> +		WARN_ON(!pte_none(pte));
>> +	} while (addr += PAGE_SIZE, addr < end);
> 
> So this loop is just a sanity check (pte clearing having been done by
> the unmap loops). That's fine, maybe a comment for future reference.

Sure, will add.
> 
>> +
>> +	if (!pgtable_range_aligned(start, end, floor, ceiling, PMD_MASK))
>> +		return;
>> +
>> +	ptep = pte_offset_kernel(pmdp, 0UL);
>> +	for (i = 0; i < PTRS_PER_PTE; i++) {
>> +		if (!pte_none(READ_ONCE(ptep[i])))
>> +			return;
>> +	}
> 
> We could do with a comment for this loop along the lines of:
> 
> 	Check whether we can free the pte page if the rest of the
> 	entries are empty. Overlap with other regions have been handled
> 	by the floor/ceiling check.

Sure, will add.

> 
> Apart from the comments above, the rest of the patch looks fine. Once
> fixed:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Mark Rutland mentioned at some point that, as a preparatory patch to
> this series, we'd need to make sure we don't hot-remove memory already
> given to the kernel at boot. Any plans here?

Hmm, this series just enables platform memory hot remove as required from
generic memory hotplug framework. The path here is triggered either from
remove_memory() or __remove_memory() which takes physical memory range
arguments like (nid, start, size) and do the needful. arch_remove_memory()
should never be required to test given memory range for anything including
being part of the boot memory.

IIUC boot memory added to system with memblock_add() lose all it's identity
after the system is up and running. In order to reject any attempt to hot
remove boot memory, platform needs to remember all those memory that came
early in the boot and then scan through it during arch_remove_memory().

Ideally, it is the responsibility of [_]remove_memory() callers like ACPI
driver, DAX etc to make sure they never attempt to hot remove a memory
range, which never got hot added by them in the first place. Also, unlike
/sys/devices/system/memory/probe there is no 'unprobe' interface where the
user can just trigger boot memory removal. Hence, unless there is a bug in
ACPI, DAX or other callers, there should never be any attempt to hot remove
boot memory in the first place.

> 
> Thanks.
> 
