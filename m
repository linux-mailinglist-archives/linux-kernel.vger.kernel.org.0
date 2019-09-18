Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48607B5FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 11:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfIRJMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 05:12:41 -0400
Received: from foss.arm.com ([217.140.110.172]:37876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfIRJMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:12:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 098C5337;
        Wed, 18 Sep 2019 02:12:40 -0700 (PDT)
Received: from [10.162.40.136] (p8cg001049571a15.blr.arm.com [10.162.40.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4B083F59C;
        Wed, 18 Sep 2019 02:12:33 -0700 (PDT)
Subject: Re: [PATCH V7 2/3] arm64/mm: Hold memory hotplug lock while walking
 for kernel page table dump
To:     Balbir Singh <bsingharora@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com, will@kernel.org
Cc:     mark.rutland@arm.com, mhocko@suse.com, ira.weiny@intel.com,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com, steve.capper@arm.com,
        broonie@kernel.org, valentin.schneider@arm.com,
        Robin.Murphy@arm.com, steven.price@arm.com, suzuki.poulose@arm.com
References: <1567503958-25831-1-git-send-email-anshuman.khandual@arm.com>
 <1567503958-25831-3-git-send-email-anshuman.khandual@arm.com>
 <66922798-9de7-a230-8548-1f205e79ea50@gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8e47831f-c28e-a174-24b3-b3bbf1f365ec@arm.com>
Date:   Wed, 18 Sep 2019 14:42:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <66922798-9de7-a230-8548-1f205e79ea50@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/15/2019 08:05 AM, Balbir Singh wrote:
> 
> 
> On 3/9/19 7:45 pm, Anshuman Khandual wrote:
>> The arm64 page table dump code can race with concurrent modification of the
>> kernel page tables. When a leaf entries are modified concurrently, the dump
>> code may log stale or inconsistent information for a VA range, but this is
>> otherwise not harmful.
>>
>> When intermediate levels of table are freed, the dump code will continue to
>> use memory which has been freed and potentially reallocated for another
>> purpose. In such cases, the dump code may dereference bogus addresses,
>> leading to a number of potential problems.
>>
>> Intermediate levels of table may by freed during memory hot-remove,
>> which will be enabled by a subsequent patch. To avoid racing with
>> this, take the memory hotplug lock when walking the kernel page table.
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/mm/ptdump_debugfs.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
>> index 064163f25592..b5eebc8c4924 100644
>> --- a/arch/arm64/mm/ptdump_debugfs.c
>> +++ b/arch/arm64/mm/ptdump_debugfs.c
>> @@ -1,5 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  #include <linux/debugfs.h>
>> +#include <linux/memory_hotplug.h>
>>  #include <linux/seq_file.h>
>>  
>>  #include <asm/ptdump.h>
>> @@ -7,7 +8,10 @@
>>  static int ptdump_show(struct seq_file *m, void *v)
>>  {
>>  	struct ptdump_info *info = m->private;
>> +
>> +	get_online_mems();
>>  	ptdump_walk_pgd(m, info);
>> +	put_online_mems();
> 
> Looks sane, BTW, checking other arches they might have the same race.

The problem can be present on other architectures which can dump kernel page
table during memory hot-remove operation where it actually frees up page table
pages. If there is no freeing involved the race condition here could cause
inconsistent or garbage information capture for a given VA range. Same is true
even for concurrent vmalloc() operations as well. But removal of page tables
pages can make it worse. Freeing page table pages during hot-remove is a platform
decision, so would be adding these locks while walking kernel page table during
ptdump.

> Is there anything special about the arch?

AFAICS, no.

> 
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> 
> 
