Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA4EE9989D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 17:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389647AbfHVP5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 11:57:20 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:53683 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbfHVP5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:57:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Ta589JE_1566489424;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Ta589JE_1566489424)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 22 Aug 2019 23:57:07 +0800
Subject: Re: [v2 PATCH -mm] mm: account deferred split THPs into MemAvailable
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        kirill.shutemov@linux.intel.com
Cc:     hannes@cmpxchg.org, rientjes@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1566410125-66011-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190822080434.GF12785@dhcp22.suse.cz>
 <ee048bbf-3563-d695-ea58-5f1504aee35c@suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <85a18643-4583-38aa-645d-87b28033ab67@linux.alibaba.com>
Date:   Thu, 22 Aug 2019 08:57:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ee048bbf-3563-d695-ea58-5f1504aee35c@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/19 5:56 AM, Vlastimil Babka wrote:
> On 8/22/19 10:04 AM, Michal Hocko wrote:
>> On Thu 22-08-19 01:55:25, Yang Shi wrote:
>>> Available memory is one of the most important metrics for memory
>>> pressure.
>> I would disagree with this statement. It is a rough estimate that tells
>> how much memory you can allocate before going into a more expensive
>> reclaim (mostly swapping). Allocating that amount still might result in
>> direct reclaim induced stalls. I do realize that this is simple metric
>> that is attractive to use and works in many cases though.
>>
>>> Currently, the deferred split THPs are not accounted into
>>> available memory, but they are reclaimable actually, like reclaimable
>>> slabs.
>>>
>>> And, they seems very common with the common workloads when THP is
>>> enabled.  A simple run with MariaDB test of mmtest with THP enabled as
>>> always shows it could generate over fifteen thousand deferred split THPs
>>> (accumulated around 30G in one hour run, 75% of 40G memory for my VM).
>>> It looks worth accounting in MemAvailable.
>> OK, this makes sense. But your above numbers are really worrying.
>> Accumulating such a large amount of pages that are likely not going to
>> be used is really bad. They are essentially blocking any higher order
>> allocations and also push the system towards more memory pressure.
>>
>> IIUC deferred splitting is mostly a workaround for nasty locking issues
>> during splitting, right? This is not really an optimization to cache
>> THPs for reuse or something like that. What is the reason this is not
>> done from a worker context? At least THPs which would be freed
>> completely sound like a good candidate for kworker tear down, no?
> Agreed that it's a good question. For Kirill :) Maybe with kworker approach we
> also wouldn't need the cgroup awareness?
>
>>> Record the number of freeable normal pages of deferred split THPs into
>>> the second tail page, and account it into KReclaimable.  Although THP
>>> allocations are not exactly "kernel allocations", once they are unmapped,
>>> they are in fact kernel-only.  KReclaimable has been accounted into
>>> MemAvailable.
>> This sounds reasonable to me.
>>   
>>> When the deferred split THPs get split due to memory pressure or freed,
>>> just decrease by the recorded number.
>>>
>>> With this change when running program which populates 1G address space
>>> then madvise(MADV_DONTNEED) 511 pages for every THP, /proc/meminfo would
>>> show the deferred split THPs are accounted properly.
>>>
>>> Populated by before calling madvise(MADV_DONTNEED):
>>> MemAvailable:   43531960 kB
>>> AnonPages:       1096660 kB
>>> KReclaimable:      26156 kB
>>> AnonHugePages:   1056768 kB
>>>
>>> After calling madvise(MADV_DONTNEED):
>>> MemAvailable:   44411164 kB
>>> AnonPages:         50140 kB
>>> KReclaimable:    1070640 kB
>>> AnonHugePages:     10240 kB
>>>
>>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>>> Cc: Michal Hocko <mhocko@kernel.org>
>>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: David Rientjes <rientjes@google.com>
>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Thanks, looks like it wasn't too difficult with the 2nd tail page use :)
>
> ...
>
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -524,6 +524,7 @@ void prep_transhuge_page(struct page *page)
>>>   
>>>   	INIT_LIST_HEAD(page_deferred_list(page));
>>>   	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
>>> +	page[2].nr_freeable = 0;
>>>   }
>>>   
>>>   static unsigned long __thp_get_unmapped_area(struct file *filp, unsigned long len,
>>> @@ -2766,6 +2767,10 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>>>   		if (!list_empty(page_deferred_list(head))) {
>>>   			ds_queue->split_queue_len--;
>>>   			list_del(page_deferred_list(head));
>>> +			__mod_node_page_state(page_pgdat(page),
>>> +					NR_KERNEL_MISC_RECLAIMABLE,
>>> +					-head[2].nr_freeable);
>>> +			head[2].nr_freeable = 0;
>>>   		}
>>>   		if (mapping)
>>>   			__dec_node_page_state(page, NR_SHMEM_THPS);
>>> @@ -2816,11 +2821,14 @@ void free_transhuge_page(struct page *page)
>>>   		ds_queue->split_queue_len--;
>>>   		list_del(page_deferred_list(page));
>>>   	}
>>> +	__mod_node_page_state(page_pgdat(page), NR_KERNEL_MISC_RECLAIMABLE,
>>> +			      -page[2].nr_freeable);
>>> +	page[2].nr_freeable = 0;
> Wouldn't it be safer to fully tie the nr_freeable use to adding the page to the
> deffered list? So here the code would be in the if (!list_empty()) { } part above.

IMHO, having it outside (!list_empty()) sounds safer actually since we'd 
better dec nr_freeable unconditionally in free path.

>
>>>   	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>>>   	free_compound_page(page);
>>>   }
>>>   
>>> -void deferred_split_huge_page(struct page *page)
>>> +void deferred_split_huge_page(struct page *page, unsigned int nr)
>>>   {
>>>   	struct deferred_split *ds_queue = get_deferred_split_queue(page);
>>>   #ifdef CONFIG_MEMCG
>>> @@ -2844,6 +2852,9 @@ void deferred_split_huge_page(struct page *page)
>>>   		return;
>>>   
>>>   	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>>> +	page[2].nr_freeable += nr;
>>> +	__mod_node_page_state(page_pgdat(page), NR_KERNEL_MISC_RECLAIMABLE,
>>> +			      nr);
> Same here, only do this when adding to the list, below? Or we might perhaps
> account base pages multiple times?

page_remove_rmap() might be called for a whole THP (i.e. 
do_huge_pmd_wp_page()), or the sub pages of THP (i.e. 
madvise(MADV_DONTNEED) -> zap_pte_range).

When it is called for sub pages of THP, the THP would be added into 
deferred split queue at the first time, then next time (the other sub 
pages are unmapped), since the THP is already on deferred split queue, 
list_empty() will return false, so this may cause we just account one 
subpage even though the most sub pages are unmapped.

I don't think they would be accounted multiple times, since 
deferred_split_huge_page() is just called when there is no map at all. 
Unmapping a unmapped page should be a bug.

>
>>>   	if (list_empty(page_deferred_list(page))) {
>>>   		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>>>   		list_add_tail(page_deferred_list(page), &ds_queue->split_queue);
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index e5dfe2a..6008fab 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1286,7 +1286,7 @@ static void page_remove_anon_compound_rmap(struct page *page)
>>>   
>>>   	if (nr) {
>>>   		__mod_node_page_state(page_pgdat(page), NR_ANON_MAPPED, -nr);
>>> -		deferred_split_huge_page(page);
>>> +		deferred_split_huge_page(page, nr);
>>>   	}
>>>   }
>>>   
>>> @@ -1320,7 +1320,7 @@ void page_remove_rmap(struct page *page, bool compound)
>>>   		clear_page_mlock(page);
>>>   
>>>   	if (PageTransCompound(page))
>>> -		deferred_split_huge_page(compound_head(page));
>>> +		deferred_split_huge_page(compound_head(page), 1);
>>>   
>>>   	/*
>>>   	 * It would be tidy to reset the PageAnon mapping here,
>>> -- 
>>> 1.8.3.1

