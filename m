Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B13218BDE2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 18:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgCSRXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 13:23:02 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:45456 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727434AbgCSRXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:23:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tt2d.wo_1584638566;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tt2d.wo_1584638566)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 20 Mar 2020 01:22:48 +0800
Subject: Re: [PATCH] mm: khugepaged: fix potential page state corruption
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1584573582-116702-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200319001258.creziw6ffw4jvwl3@box>
 <2cdc734c-c222-4b9d-9114-1762b29dafb4@linux.alibaba.com>
 <db660bef-c927-b793-7a79-a88df197a756@linux.alibaba.com>
 <20200319104938.vphyajoyz6ob6jtl@box>
 <e716c8c6-898e-5199-019c-161ea3ec06c3@linux.alibaba.com>
Message-ID: <cf33f9c8-4ea9-a6ef-b445-83344729d4e4@linux.alibaba.com>
Date:   Thu, 19 Mar 2020 10:22:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e716c8c6-898e-5199-019c-161ea3ec06c3@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/20 9:57 AM, Yang Shi wrote:
>
>
> On 3/19/20 3:49 AM, Kirill A. Shutemov wrote:
>> On Wed, Mar 18, 2020 at 10:39:21PM -0700, Yang Shi wrote:
>>>
>>> On 3/18/20 5:55 PM, Yang Shi wrote:
>>>>
>>>> On 3/18/20 5:12 PM, Kirill A. Shutemov wrote:
>>>>> On Thu, Mar 19, 2020 at 07:19:42AM +0800, Yang Shi wrote:
>>>>>> When khugepaged collapses anonymous pages, the base pages would
>>>>>> be freed
>>>>>> via pagevec or free_page_and_swap_cache().  But, the anonymous 
>>>>>> page may
>>>>>> be added back to LRU, then it might result in the below race:
>>>>>>
>>>>>>      CPU A                CPU B
>>>>>> khugepaged:
>>>>>>     unlock page
>>>>>>     putback_lru_page
>>>>>>       add to lru
>>>>>>                  page reclaim:
>>>>>>                    isolate this page
>>>>>>                    try_to_unmap
>>>>>>     page_remove_rmap <-- corrupt _mapcount
>>>>>>
>>>>>> It looks nothing would prevent the pages from isolating by 
>>>>>> reclaimer.
>>>>> Hm. Why should it?
>>>>>
>>>>> try_to_unmap() doesn't exclude parallel page unmapping. _mapcount is
>>>>> protected by ptl. And this particular _mapcount pin is reachable for
>>>>> reclaim as it's not part of usual page table tree. Basically
>>>>> try_to_unmap() will never succeeds until we give up the _mapcount on
>>>>> khugepaged side.
>>>> I don't quite get. What does "not part of usual page table tree" 
>>>> means?
>>>>
>>>> How's about try_to_unmap() acquires ptl before khugepaged?
>> The page table we are dealing with was detached from the process' page
>> table tree: see pmdp_collapse_flush(). try_to_unmap() will not see the
>> pte.
>>
>> try_to_unmap() can only reach the ptl if split ptl is disabled
>> (mm->page_table_lock is used), but it still will not be able to reach 
>> pte.
>
> Aha, got it. Thanks for explaining. I definitely missed this point. 
> Yes, pmdp_collapse_flush() would clear the pmd, then others won't see 
> the page table.
>
> However, it looks the vmscan would not stop at try_to_unmap() at all, 
> try_to_unmap() would just return true since pmd_present() should 
> return false in pvmw. Then it would go all the way down to 
> __remove_mapping(), but freezing the page would fail since 
> try_to_unmap() doesn't actually drop the refcount from the pte map.
>
> It would not result in any critical problem AFAICT, but suboptimal and 
> it may causes some unnecessary I/O due to swap.

To correct, it would not reach __remove_mapping() since refcount check 
in pageout() would fail.

>
>>
>>>>> I don't see the issue right away.
>>>>>
>>>>>> The other problem is the page's active or unevictable flag might be
>>>>>> still set when freeing the page via free_page_and_swap_cache().
>>>>> So what?
>>>> The flags may leak to page free path then kernel may complain if
>>>> DEBUG_VM is set.
>> Could you elaborate on what codepath you are talking about?
>
> __put_page ->
>     __put_single_page ->
>         free_unref_page ->
>             put_unref_page_prepare ->
>                 free_pcp_prepare ->
>                     free_pages_prepare ->
>                         free_pages_check
>
> This check would just be run when DEBUG_VM is enabled.
>
>>
>>>>>> The putback_lru_page() would not clear those two flags if the 
>>>>>> pages are
>>>>>> released via pagevec, it sounds nothing prevents from isolating 
>>>>>> active
>>> Sorry, this is a typo. If the page is freed via pagevec, active and
>>> unevictable flag would get cleared before freeing by page_off_lru().
>>>
>>> But, if the page is freed by free_page_and_swap_cache(), these two 
>>> flags are
>>> not cleared. But, it seems this path is hit rare, the pages are 
>>> freed by
>>> pagevec for the most cases.
>>>
>>>>>> or unevictable pages.
>>>>> Again, why should it? vmscan is equipped to deal with this.
>>>> I don't mean vmscan, I mean khugepaged may isolate active and
>>>> unevictable pages since it just simply walks page table.
>> Why it is wrong? lru_cache_add() only complains if both flags set, it
>> shouldn't happen.
>
> Noting wrong about isolating active or unevictable pages. I just mean 
> it seems possible active or unevictable flag may be there if the page 
> is freed via free_page_add_swap_cache() path.
>
>>
>>>>>> However I didn't really run into these problems, just in theory
>>>>>> by visual
>>>>>> inspection.
>>>>>>
>>>>>> And, it also seems unnecessary to have the pages add back to LRU
>>>>>> again since
>>>>>> they are about to be freed when reaching this point. So,
>>>>>> clearing active
>>>>>> and unevictable flags, unlocking and dropping refcount from isolate
>>>>>> instead of calling putback_lru_page() as what page cache collapse 
>>>>>> does.
>>>>> Hm? But we do call putback_lru_page() on the way out. I do not 
>>>>> follow.
>>>> It just calls putback_lru_page() at error path, not success path.
>>>> Putting pages back to lru on error path definitely makes sense. 
>>>> Here it
>>>> is the success path.
>> I agree that putting the apage on LRU just before free the page is
>> suboptimal, but I don't see it as a critical issue.
>
> Yes, given the code analysis above, I agree. If you thought the patch 
> is a fine micro-optimization, I would like to re-submit it with 
> rectified commit log. Thank you for your time.
>
>>
>>
>

