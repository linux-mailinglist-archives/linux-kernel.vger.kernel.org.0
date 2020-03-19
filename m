Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5B9418AA19
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 01:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCSAzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 20:55:42 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:53443 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbgCSAzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 20:55:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tt-aiy1_1584579330;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tt-aiy1_1584579330)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 Mar 2020 08:55:36 +0800
Subject: Re: [PATCH] mm: khugepaged: fix potential page state corruption
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1584573582-116702-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200319001258.creziw6ffw4jvwl3@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <2cdc734c-c222-4b9d-9114-1762b29dafb4@linux.alibaba.com>
Date:   Wed, 18 Mar 2020 17:55:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200319001258.creziw6ffw4jvwl3@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/20 5:12 PM, Kirill A. Shutemov wrote:
> On Thu, Mar 19, 2020 at 07:19:42AM +0800, Yang Shi wrote:
>> When khugepaged collapses anonymous pages, the base pages would be freed
>> via pagevec or free_page_and_swap_cache().  But, the anonymous page may
>> be added back to LRU, then it might result in the below race:
>>
>> 	CPU A				CPU B
>> khugepaged:
>>    unlock page
>>    putback_lru_page
>>      add to lru
>> 				page reclaim:
>> 				  isolate this page
>> 				  try_to_unmap
>>    page_remove_rmap <-- corrupt _mapcount
>>
>> It looks nothing would prevent the pages from isolating by reclaimer.
> Hm. Why should it?
>
> try_to_unmap() doesn't exclude parallel page unmapping. _mapcount is
> protected by ptl. And this particular _mapcount pin is reachable for
> reclaim as it's not part of usual page table tree. Basically
> try_to_unmap() will never succeeds until we give up the _mapcount on
> khugepaged side.

I don't quite get. What does "not part of usual page table tree" means?

How's about try_to_unmap() acquires ptl before khugepaged?

>
> I don't see the issue right away.
>
>> The other problem is the page's active or unevictable flag might be
>> still set when freeing the page via free_page_and_swap_cache().
> So what?

The flags may leak to page free path then kernel may complain if 
DEBUG_VM is set.

>
>> The putback_lru_page() would not clear those two flags if the pages are
>> released via pagevec, it sounds nothing prevents from isolating active
>> or unevictable pages.
> Again, why should it? vmscan is equipped to deal with this.

I don't mean vmscan, I mean khugepaged may isolate active and 
unevictable pages since it just simply walks page table.

>
>> However I didn't really run into these problems, just in theory by visual
>> inspection.
>>
>> And, it also seems unnecessary to have the pages add back to LRU again since
>> they are about to be freed when reaching this point.  So, clearing active
>> and unevictable flags, unlocking and dropping refcount from isolate
>> instead of calling putback_lru_page() as what page cache collapse does.
> Hm? But we do call putback_lru_page() on the way out. I do not follow.

It just calls putback_lru_page() at error path, not success path. 
Putting pages back to lru on error path definitely makes sense. Here it 
is the success path.

>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>>   mm/khugepaged.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index b679908..f42fa4e 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -673,7 +673,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>>   			src_page = pte_page(pteval);
>>   			copy_user_highpage(page, src_page, address, vma);
>>   			VM_BUG_ON_PAGE(page_mapcount(src_page) != 1, src_page);
>> -			release_pte_page(src_page);
>>   			/*
>>   			 * ptl mostly unnecessary, but preempt has to
>>   			 * be disabled to update the per-cpu stats
>> @@ -687,6 +686,15 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>>   			pte_clear(vma->vm_mm, address, _pte);
>>   			page_remove_rmap(src_page, false);
>>   			spin_unlock(ptl);
>> +
>> +			dec_node_page_state(src_page,
>> +				NR_ISOLATED_ANON + page_is_file_cache(src_page));
>> +			ClearPageActive(src_page);
>> +			ClearPageUnevictable(src_page);
>> +			unlock_page(src_page);
>> +			/* Drop refcount from isolate */
>> +			put_page(src_page);
>> +
>>   			free_page_and_swap_cache(src_page);
>>   		}
>>   	}
>> -- 
>> 1.8.3.1
>>
>>

