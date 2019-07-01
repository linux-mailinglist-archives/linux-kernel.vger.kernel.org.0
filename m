Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED204266E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 17:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbfEVPa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 11:30:29 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:55056 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728638AbfEVPa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:30:29 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id D12932E0993;
        Wed, 22 May 2019 18:30:24 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id u0oNPspX6E-UOkeHk5m;
        Wed, 22 May 2019 18:30:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1558539024; bh=AARDsc+qKR1tiSZQnznuyXjsYF8+lb0Jab821k1urZ0=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=XRudIStPFGmb/HtlqM4I2M1uA0By0RU3+o4Z6zLDd6mZ3kynjOpzCw4PhkN5tBFHu
         jRn3K7+MPQAUfIyZvhVE2zVdX/fMJ8FRdyqlf+FmVVFg7sw7x0zLRjzBHV0n7Qscj2
         iHMO5ULOWUNm43Syo5hztv4Cf2LIf66AUZXJNDe0=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:e47f:4b1d:b053:2762])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id PG7C45att4-UN849cun;
        Wed, 22 May 2019 18:30:24 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] proc/meminfo: add MemKernel counter
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <155853600919.381.8172097084053782598.stgit@buzz>
 <529aa7fd-2dc2-6979-4ea0-d40dfc7e3fde@suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <1ce9b1af-27bd-f1ea-14cb-57ce40475f38@yandex-team.ru>
Date:   Wed, 22 May 2019 18:30:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <529aa7fd-2dc2-6979-4ea0-d40dfc7e3fde@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.2019 18:01, Vlastimil Babka wrote:
> On 5/22/19 4:40 PM, Konstantin Khlebnikov wrote:
>> Some kinds of kernel allocations are not accounted or not show in meminfo.
>> For example vmalloc allocations are tracked but overall size is not shown
> 
> I think Roman's vmalloc patch [1] is on its way?
> 
>> for performance reasons. There is no information about network buffers.
> 
> xfs buffers can also occupy a lot, from my experience
> 
>> In most cases detailed statistics is not required. At first place we need
>> information about overall kernel memory usage regardless of its structure.
>>
>> This patch estimates kernel memory usage by subtracting known sizes of
>> free, anonymous, hugetlb and caches from total memory size: MemKernel =
>> MemTotal - MemFree - Buffers - Cached - SwapCached - AnonPages - Hugetlb.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> 
> I've tried this once in [2]. The name was Unaccounted and one of the objections
> was that people would get worried. Yours is a bit better, perhaps MemKernMisc
> would be even more descriptive? Michal Hocko worried about maintainability, that
> we forget something, but I don't think that's a big issue.

I've started with Misc/Unaccounted too
https://lore.kernel.org/lkml/155792098821.1536.17069603544573830315.stgit@buzz/

But this version simply shows all kernel memory.

> 
> Vlastimil
> 
> [1] https://lore.kernel.org/linux-mm/20190514235111.2817276-2-guro@fb.com/T/#u
> [2] https://lore.kernel.org/linux-mm/20161020121149.9935-1-vbabka@suse.cz/T/#u
> 
>> ---
>>   Documentation/filesystems/proc.txt |    5 +++++
>>   fs/proc/meminfo.c                  |   20 +++++++++++++++-----
>>   2 files changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
>> index 66cad5c86171..a0ab7f273ea0 100644
>> --- a/Documentation/filesystems/proc.txt
>> +++ b/Documentation/filesystems/proc.txt
>> @@ -860,6 +860,7 @@ varies by architecture and compile options.  The following is from a
>>   
>>   MemTotal:     16344972 kB
>>   MemFree:      13634064 kB
>> +MemKernel:      862600 kB
>>   MemAvailable: 14836172 kB
>>   Buffers:          3656 kB
>>   Cached:        1195708 kB
>> @@ -908,6 +909,10 @@ MemAvailable: An estimate of how much memory is available for starting new
>>                 page cache to function well, and that not all reclaimable
>>                 slab will be reclaimable, due to items being in use. The
>>                 impact of those factors will vary from system to system.
>> +   MemKernel: The sum of all kinds of kernel memory allocations: Slab,
>> +              Vmalloc, Percpu, KernelStack, PageTables, socket buffers,
>> +              and some other untracked allocations. Does not include
>> +              MemFree, Buffers, Cached, SwapCached, AnonPages, Hugetlb.
>>        Buffers: Relatively temporary storage for raw disk blocks
>>                 shouldn't get tremendously large (20MB or so)
>>         Cached: in-memory cache for files read from the disk (the
>> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
>> index 568d90e17c17..b27d56dd619a 100644
>> --- a/fs/proc/meminfo.c
>> +++ b/fs/proc/meminfo.c
>> @@ -39,17 +39,27 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>>   	long available;
>>   	unsigned long pages[NR_LRU_LISTS];
>>   	unsigned long sreclaimable, sunreclaim;
>> +	unsigned long anon_pages, file_pages, swap_cached;
>> +	long kernel_pages;
>>   	int lru;
>>   
>>   	si_meminfo(&i);
>>   	si_swapinfo(&i);
>>   	committed = percpu_counter_read_positive(&vm_committed_as);
>>   
>> -	cached = global_node_page_state(NR_FILE_PAGES) -
>> -			total_swapcache_pages() - i.bufferram;
>> +	anon_pages = global_node_page_state(NR_ANON_MAPPED);
>> +	file_pages = global_node_page_state(NR_FILE_PAGES);
>> +	swap_cached = total_swapcache_pages();
>> +
>> +	cached = file_pages - swap_cached - i.bufferram;
>>   	if (cached < 0)
>>   		cached = 0;
>>   
>> +	kernel_pages = i.totalram - i.freeram - anon_pages - file_pages -
>> +		       hugetlb_total_pages();
>> +	if (kernel_pages < 0)
>> +		kernel_pages = 0;
>> +
>>   	for (lru = LRU_BASE; lru < NR_LRU_LISTS; lru++)
>>   		pages[lru] = global_node_page_state(NR_LRU_BASE + lru);
>>   
>> @@ -60,9 +70,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>>   	show_val_kb(m, "MemTotal:       ", i.totalram);
>>   	show_val_kb(m, "MemFree:        ", i.freeram);
>>   	show_val_kb(m, "MemAvailable:   ", available);
>> +	show_val_kb(m, "MemKernel:      ", kernel_pages);
>>   	show_val_kb(m, "Buffers:        ", i.bufferram);
>>   	show_val_kb(m, "Cached:         ", cached);
>> -	show_val_kb(m, "SwapCached:     ", total_swapcache_pages());
>> +	show_val_kb(m, "SwapCached:     ", swap_cached);
>>   	show_val_kb(m, "Active:         ", pages[LRU_ACTIVE_ANON] +
>>   					   pages[LRU_ACTIVE_FILE]);
>>   	show_val_kb(m, "Inactive:       ", pages[LRU_INACTIVE_ANON] +
>> @@ -92,8 +103,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>>   		    global_node_page_state(NR_FILE_DIRTY));
>>   	show_val_kb(m, "Writeback:      ",
>>   		    global_node_page_state(NR_WRITEBACK));
>> -	show_val_kb(m, "AnonPages:      ",
>> -		    global_node_page_state(NR_ANON_MAPPED));
>> +	show_val_kb(m, "AnonPages:      ", anon_pages);
>>   	show_val_kb(m, "Mapped:         ",
>>   		    global_node_page_state(NR_FILE_MAPPED));
>>   	show_val_kb(m, "Shmem:          ", i.sharedram);
>>
> 
