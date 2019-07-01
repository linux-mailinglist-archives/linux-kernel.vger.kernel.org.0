Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 231DF290B9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 08:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388804AbfEXGGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 02:06:31 -0400
Received: from foss.arm.com ([217.140.101.70]:34388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387622AbfEXGGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:06:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DCD5374;
        Thu, 23 May 2019 23:06:30 -0700 (PDT)
Received: from [10.162.42.134] (p8cg001049571a15.blr.arm.com [10.162.42.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB13C3F5AF;
        Thu, 23 May 2019 23:06:24 -0700 (PDT)
Subject: Re: [PATCH V3 2/4] arm64/mm: Hold memory hotplug lock while walking
 for kernel page table dump
To:     Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mgorman@techsingularity.net,
        james.morse@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        ira.weiny@intel.com
References: <1557824407-19092-1-git-send-email-anshuman.khandual@arm.com>
 <1557824407-19092-3-git-send-email-anshuman.khandual@arm.com>
 <20190515165847.GH16651@dhcp22.suse.cz>
 <20190516102354.GB40960@lakrids.cambridge.arm.com>
 <20190516110529.GQ16651@dhcp22.suse.cz>
 <20190522164212.GD23592@lakrids.cambridge.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c3be0539-2ffe-07b6-f106-12ccb93bbe2f@arm.com>
Date:   Fri, 24 May 2019 11:36:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190522164212.GD23592@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/22/2019 10:12 PM, Mark Rutland wrote:
> On Thu, May 16, 2019 at 01:05:29PM +0200, Michal Hocko wrote:
>> On Thu 16-05-19 11:23:54, Mark Rutland wrote:
>>> Hi Michal,
>>>
>>> On Wed, May 15, 2019 at 06:58:47PM +0200, Michal Hocko wrote:
>>>> On Tue 14-05-19 14:30:05, Anshuman Khandual wrote:
>>>>> The arm64 pagetable dump code can race with concurrent modification of the
>>>>> kernel page tables. When a leaf entries are modified concurrently, the dump
>>>>> code may log stale or inconsistent information for a VA range, but this is
>>>>> otherwise not harmful.
>>>>>
>>>>> When intermediate levels of table are freed, the dump code will continue to
>>>>> use memory which has been freed and potentially reallocated for another
>>>>> purpose. In such cases, the dump code may dereference bogus addressses,
>>>>> leading to a number of potential problems.
>>>>>
>>>>> Intermediate levels of table may by freed during memory hot-remove, or when
>>>>> installing a huge mapping in the vmalloc region. To avoid racing with these
>>>>> cases, take the memory hotplug lock when walking the kernel page table.
>>>>
>>>> Why is this a problem only on arm64 
>>>
>>> It looks like it's not -- I think we're just the first to realise this.
>>>
>>> AFAICT x86's debugfs ptdump has the same issue if run conccurently with
>>> memory hot remove. If 32-bit arm supported hot-remove, its ptdump code
>>> would have the same issue.
>>>
>>>> and why do we even care for debugfs? Does anybody rely on this thing
>>>> to be reliable? Do we even need it? Who is using the file?
>>>
>>> The debugfs part is used intermittently by a few people working on the
>>> arm64 kernel page tables. We use that both to sanity-check that kernel
>>> page tables are created/updated correctly after changes to the arm64 mmu
>>> code, and also to debug issues if/when we encounter issues that appear
>>> to be the result of kernel page table corruption.
>>
>> OK, I see. Thanks for the clarification.
>>
>>> So while it's rare to need it, it's really useful to have when we do
>>> need it, and I'd rather not remove it. I'd also rather that it didn't
>>> have latent issues where we can accidentally crash the kernel when using
>>> it, which is what this patch is addressing.
>>
>> While I agree, do we rather want to document that you shouldn't be using
>> the debugging tool while the hotplug is ongoing because you might get a
>> garbage or crash the kernel in the worst case? In other words is the
>> absolute correctness worth the additional maint. burden wrt. to future
>> hotplug changes?
> 
> I don't think that it's reasonable for this code to bring down the
> kernel unless the kernel page tables are already corrupt. I agree we
> should minimize the impact on other code, and I'm happy to penalize
> ptdump so long as it's functional and safe.
> 
> I would like it to be possible to use the ptdump code to debug
> hot-remove, so I'd rather not make the two mutually exclusive. I'd also
> like it to be possible to use this in-the-field, and for that asking an
> admin to potentially crash their system isn't likely to fly.
> 
>>>> I am asking because I would really love to make mem hotplug locking less
>>>> scattered outside of the core MM than more. Most users simply shouldn't
>>>> care. Pfn walkers should rely on pfn_to_online_page.
> 
> Jut to check, is your plan to limit access to the hotplug lock, or to
> redesign the locking scheme?
> 
>>> I'm not sure if that would help us here; IIUC pfn_to_online_page() alone
>>> doesn't ensure that the page remains online. Is there a way to achieve
>>> that other than get_online_mems()?
>>
>> You have to pin the page to make sure the hotplug is not going to
>> offline it.
> 
> I'm not exactly sure how pinning works -- is there a particular set of
> functions I should look at for that?
> 
> I guess that if/when we allocate the vmemmap from hotpluggable memory
> that will require the pinning code to take the hotplug lock internally
> to ensure that the struct page is accessible while we attempt to pin it?

I am bit confused here.

Which pages are we trying to pin ?

1) init_mm page table pages (vmemmap + linear) for the range to be hot-removed
2) struct pages for the PFN range to be hot-removed

We need hot-remove process to be blocked enough not to free the intermediate
level page table pages which will ensure kernel does not crash during ptdump.

AFAICT

1) Holding reference on (1) prevent freeing of pgtable pages during hot-remove
2) Holding reference on (2) prevent range PFN from being hot removed which in
   turn can prevent forward progress for hot-remove process and hence possibly
   prevent freeing of intermediate level pgtable pages.

But both the above solutions are bit complex and will consume more cycles as
compared to just take a memory_hotplug_lock. In case of (1) it is bit tricker
as ptdump code has to first walk init_mm to get to all the pgtable pages for
taking a reference/lock on them. Just wondering if it is worth the trouble.
