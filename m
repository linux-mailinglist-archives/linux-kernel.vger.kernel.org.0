Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1DC15CF24
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 01:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgBNAiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 19:38:12 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:44978 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727665AbgBNAiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 19:38:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TpvPLj7_1581640683;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TpvPLj7_1581640683)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Feb 2020 08:38:07 +0800
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP
 partially
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     Hugh Dickins <hughd@google.com>, kirill.shutemov@linux.intel.com
Cc:     aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.LSU.2.11.1912041601270.12930@eggly.anvils>
 <00f0bb7d-3c25-a65f-ea94-3e2de8e9bcdd@linux.alibaba.com>
 <33768a7e-837d-3bcd-fb98-19727921d6fd@linux.alibaba.com>
Message-ID: <cd21f6a6-32a5-7d31-3bcd-4fc3f6cc0a84@linux.alibaba.com>
Date:   Thu, 13 Feb 2020 16:38:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <33768a7e-837d-3bcd-fb98-19727921d6fd@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,


Would you please help review this patch? I don't know why Hugh didn't 
response though I pinged him twice.


Thanks,

Yang



On 2/4/20 3:27 PM, Yang Shi wrote:
>
>
> On 1/14/20 11:28 AM, Yang Shi wrote:
>>
>>
>> On 12/4/19 4:15 PM, Hugh Dickins wrote:
>>> On Wed, 4 Dec 2019, Yang Shi wrote:
>>>
>>>> Currently when truncating shmem file, if the range is partial of THP
>>>> (start or end is in the middle of THP), the pages actually will 
>>>> just get
>>>> cleared rather than being freed unless the range cover the whole THP.
>>>> Even though all the subpages are truncated (randomly or sequentially),
>>>> the THP may still be kept in page cache.  This might be fine for some
>>>> usecases which prefer preserving THP.
>>>>
>>>> But, when doing balloon inflation in QEMU, QEMU actually does hole 
>>>> punch
>>>> or MADV_DONTNEED in base page size granulairty if hugetlbfs is not 
>>>> used.
>>>> So, when using shmem THP as memory backend QEMU inflation actually 
>>>> doesn't
>>>> work as expected since it doesn't free memory.  But, the inflation
>>>> usecase really needs get the memory freed.  Anonymous THP will not get
>>>> freed right away too but it will be freed eventually when all 
>>>> subpages are
>>>> unmapped, but shmem THP would still stay in page cache.
>>>>
>>>> Split THP right away when doing partial hole punch, and if split fails
>>>> just clear the page so that read to the hole punched area would return
>>>> zero.
>>>>
>>>> Cc: Hugh Dickins <hughd@google.com>
>>>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>>>> ---
>>>> v2: * Adopted the comment from Kirill.
>>>>      * Dropped fallocate mode flag, THP split is the default behavior.
>>>>      * Blended Huge's implementation with my v1 patch. TBH I'm not 
>>>> very keen to
>>>>        Hugh's find_get_entries() hack (basically neutral), but 
>>>> without that hack
>>> Thanks for giving it a try.  I'm not neutral about my 
>>> find_get_entries()
>>> hack: it surely had to go (without it, I'd have just pushed my own 
>>> patch).
>>> I've not noticed anything wrong with your patch, and it's in the right
>>> direction, but I'm still not thrilled with it.  I also remember that I
>>> got the looping wrong in my first internal attempt (fixed in what I 
>>> sent),
>>> and need to be very sure of the try-again-versus-move-on-to-next 
>>> conditions
>>> before agreeing to anything.  No rush, I'll come back to this in 
>>> days or
>>> month ahead: I'll try to find a less gotoey blend of yours and mine.
>>
>> Hi Hugh,
>>
>> Any update on this one?
>>
>> Thanks,
>> Yang
>
> Hi Hugh,
>
> Ping. Any comment on this? I really hope it can make v5.7.
>
> Thanks,
> Yang
>
>>
>>>
>>> Hugh
>>>
>>>>        we have to rely on pagevec_release() to release extra pins 
>>>> and play with
>>>>        goto. This version does in this way. The patch is bigger 
>>>> than Hugh's due
>>>>        to extra comments to make the flow clear.
>>>>
>>>>   mm/shmem.c | 120 
>>>> ++++++++++++++++++++++++++++++++++++++++++-------------------
>>>>   1 file changed, 83 insertions(+), 37 deletions(-)
>>>>
>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>> index 220be9f..1ae0c7f 100644
>>>> --- a/mm/shmem.c
>>>> +++ b/mm/shmem.c
>>>> @@ -806,12 +806,15 @@ static void shmem_undo_range(struct inode 
>>>> *inode, loff_t lstart, loff_t lend,
>>>>       long nr_swaps_freed = 0;
>>>>       pgoff_t index;
>>>>       int i;
>>>> +    bool split = false;
>>>> +    struct page *page = NULL;
>>>>         if (lend == -1)
>>>>           end = -1;    /* unsigned, so actually very big */
>>>>         pagevec_init(&pvec);
>>>>       index = start;
>>>> +retry:
>>>>       while (index < end) {
>>>>           pvec.nr = find_get_entries(mapping, index,
>>>>               min(end - index, (pgoff_t)PAGEVEC_SIZE),
>>>> @@ -819,7 +822,8 @@ static void shmem_undo_range(struct inode 
>>>> *inode, loff_t lstart, loff_t lend,
>>>>           if (!pvec.nr)
>>>>               break;
>>>>           for (i = 0; i < pagevec_count(&pvec); i++) {
>>>> -            struct page *page = pvec.pages[i];
>>>> +            split = false;
>>>> +            page = pvec.pages[i];
>>>>                 index = indices[i];
>>>>               if (index >= end)
>>>> @@ -838,23 +842,24 @@ static void shmem_undo_range(struct inode 
>>>> *inode, loff_t lstart, loff_t lend,
>>>>               if (!trylock_page(page))
>>>>                   continue;
>>>>   -            if (PageTransTail(page)) {
>>>> -                /* Middle of THP: zero out the page */
>>>> -                clear_highpage(page);
>>>> -                unlock_page(page);
>>>> -                continue;
>>>> -            } else if (PageTransHuge(page)) {
>>>> -                if (index == round_down(end, HPAGE_PMD_NR)) {
>>>> +            if (PageTransCompound(page) && !unfalloc) {
>>>> +                if (PageHead(page) &&
>>>> +                    index != round_down(end, HPAGE_PMD_NR)) {
>>>>                       /*
>>>> -                     * Range ends in the middle of THP:
>>>> -                     * zero out the page
>>>> +                     * Fall through when punching whole
>>>> +                     * THP.
>>>>                        */
>>>> -                    clear_highpage(page);
>>>> -                    unlock_page(page);
>>>> -                    continue;
>>>> +                    index += HPAGE_PMD_NR - 1;
>>>> +                    i += HPAGE_PMD_NR - 1;
>>>> +                } else {
>>>> +                    /*
>>>> +                     * Split THP for any partial hole
>>>> +                     * punch.
>>>> +                     */
>>>> +                    get_page(page);
>>>> +                    split = true;
>>>> +                    goto split;
>>>>                   }
>>>> -                index += HPAGE_PMD_NR - 1;
>>>> -                i += HPAGE_PMD_NR - 1;
>>>>               }
>>>>                 if (!unfalloc || !PageUptodate(page)) {
>>>> @@ -866,9 +871,29 @@ static void shmem_undo_range(struct inode 
>>>> *inode, loff_t lstart, loff_t lend,
>>>>               }
>>>>               unlock_page(page);
>>>>           }
>>>> +split:
>>>>           pagevec_remove_exceptionals(&pvec);
>>>>           pagevec_release(&pvec);
>>>>           cond_resched();
>>>> +
>>>> +        if (split) {
>>>> +            /*
>>>> +             * The pagevec_release() released all extra pins
>>>> +             * from pagevec lookup.  And we hold an extra pin
>>>> +             * and still have the page locked under us.
>>>> +             */
>>>> +            if (!split_huge_page(page)) {
>>>> +                unlock_page(page);
>>>> +                put_page(page);
>>>> +                /* Re-lookup page cache from current index */
>>>> +                goto retry;
>>>> +            }
>>>> +
>>>> +            /* Fail to split THP, move to next index */
>>>> +            unlock_page(page);
>>>> +            put_page(page);
>>>> +        }
>>>> +
>>>>           index++;
>>>>       }
>>>>   @@ -901,6 +926,7 @@ static void shmem_undo_range(struct inode 
>>>> *inode, loff_t lstart, loff_t lend,
>>>>           return;
>>>>         index = start;
>>>> +again:
>>>>       while (index < end) {
>>>>           cond_resched();
>>>>   @@ -916,7 +942,8 @@ static void shmem_undo_range(struct inode 
>>>> *inode, loff_t lstart, loff_t lend,
>>>>               continue;
>>>>           }
>>>>           for (i = 0; i < pagevec_count(&pvec); i++) {
>>>> -            struct page *page = pvec.pages[i];
>>>> +            split = false;
>>>> +            page = pvec.pages[i];
>>>>                 index = indices[i];
>>>>               if (index >= end)
>>>> @@ -936,30 +963,24 @@ static void shmem_undo_range(struct inode 
>>>> *inode, loff_t lstart, loff_t lend,
>>>>                 lock_page(page);
>>>>   -            if (PageTransTail(page)) {
>>>> -                /* Middle of THP: zero out the page */
>>>> -                clear_highpage(page);
>>>> -                unlock_page(page);
>>>> -                /*
>>>> -                 * Partial thp truncate due 'start' in middle
>>>> -                 * of THP: don't need to look on these pages
>>>> -                 * again on !pvec.nr restart.
>>>> -                 */
>>>> -                if (index != round_down(end, HPAGE_PMD_NR))
>>>> -                    start++;
>>>> -                continue;
>>>> -            } else if (PageTransHuge(page)) {
>>>> -                if (index == round_down(end, HPAGE_PMD_NR)) {
>>>> +            if (PageTransCompound(page) && !unfalloc) {
>>>> +                if (PageHead(page) &&
>>>> +                    index != round_down(end, HPAGE_PMD_NR)) {
>>>>                       /*
>>>> -                     * Range ends in the middle of THP:
>>>> -                     * zero out the page
>>>> +                     * Fall through when punching whole
>>>> +                     * THP.
>>>>                        */
>>>> -                    clear_highpage(page);
>>>> -                    unlock_page(page);
>>>> -                    continue;
>>>> +                    index += HPAGE_PMD_NR - 1;
>>>> +                    i += HPAGE_PMD_NR - 1;
>>>> +                } else {
>>>> +                    /*
>>>> +                     * Split THP for any partial hole
>>>> +                     * punch.
>>>> +                     */
>>>> +                    get_page(page);
>>>> +                    split = true;
>>>> +                    goto rescan_split;
>>>>                   }
>>>> -                index += HPAGE_PMD_NR - 1;
>>>> -                i += HPAGE_PMD_NR - 1;
>>>>               }
>>>>                 if (!unfalloc || !PageUptodate(page)) {
>>>> @@ -976,8 +997,33 @@ static void shmem_undo_range(struct inode 
>>>> *inode, loff_t lstart, loff_t lend,
>>>>               }
>>>>               unlock_page(page);
>>>>           }
>>>> +rescan_split:
>>>>           pagevec_remove_exceptionals(&pvec);
>>>>           pagevec_release(&pvec);
>>>> +
>>>> +        if (split) {
>>>> +            /*
>>>> +             * The pagevec_release() released all extra pins
>>>> +             * from pagevec lookup.  And we hold an extra pin
>>>> +             * and still have the page locked under us.
>>>> +             */
>>>> +            if (!split_huge_page(page)) {
>>>> +                unlock_page(page);
>>>> +                put_page(page);
>>>> +                /* Re-lookup page cache from current index */
>>>> +                goto again;
>>>> +            }
>>>> +
>>>> +            /*
>>>> +             * Split fail, clear the page then move to next
>>>> +             * index.
>>>> +             */
>>>> +            clear_highpage(page);
>>>> +
>>>> +            unlock_page(page);
>>>> +            put_page(page);
>>>> +        }
>>>> +
>>>>           index++;
>>>>       }
>>>>   --
>>>> 1.8.3.1
>>>>
>>>>
>>
>

