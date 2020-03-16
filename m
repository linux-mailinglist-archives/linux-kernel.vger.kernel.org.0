Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFA4318718E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 18:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbgCPRtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 13:49:35 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:45363 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732228AbgCPRtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 13:49:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TsoNvPO_1584380967;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TsoNvPO_1584380967)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Mar 2020 01:49:29 +0800
Subject: Re: [PATCH 2/2] mm: swap: use smp_mb__after_atomic() to order LRU bit
 set
To:     Vlastimil Babka <vbabka@suse.cz>, shakeelb@google.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1584124476-76534-1-git-send-email-yang.shi@linux.alibaba.com>
 <1584124476-76534-2-git-send-email-yang.shi@linux.alibaba.com>
 <3c13c484-8fbf-3c3a-fbe1-a40434869e55@suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <52877743-bb43-f928-2995-92607272dbb8@linux.alibaba.com>
Date:   Mon, 16 Mar 2020 10:49:26 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3c13c484-8fbf-3c3a-fbe1-a40434869e55@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/20 10:40 AM, Vlastimil Babka wrote:
> On 3/13/20 7:34 PM, Yang Shi wrote:
>> Memory barrier is needed after setting LRU bit, but smp_mb() is too
>> strong.  Some architectures, i.e. x86, imply memory barrier with atomic
>> operations, so replacing it with smp_mb__after_atomic() sounds better,
>> which is nop on strong ordered machines, and full memory barriers on
>> others.  With this change the vm-calability cases would perform better
>> on x86, I saw total 6% improvement with this patch and previous inline
>> fix.
>>
>> The test data (lru-file-readtwice throughput) against v5.6-rc4:
>> 	mainline	w/ inline fix	w/ both (adding this)
>> 	150MB		154MB		159MB
>>
>> Fixes: 9c4e6b1a7027 ("mm, mlock, vmscan: no more skipping pagevecs")
>> Cc: Shakeel Butt <shakeelb@google.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> According to my understanding of Documentation/memory_barriers.txt this would be
> correct (but it might not say much :)

This is my understanding too.

>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> But i have some suggestions...
>
>> ---
>>   mm/swap.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/swap.c b/mm/swap.c
>> index cf39d24..118bac4 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -945,20 +945,20 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
>>   	 * #0: __pagevec_lru_add_fn		#1: clear_page_mlock
>>   	 *
>>   	 * SetPageLRU()				TestClearPageMlocked()
>> -	 * smp_mb() // explicit ordering	// above provides strict
>> +	 * MB() 	// explicit ordering	// above provides strict
> Why MB()? That would be the first appareance of 'MB()' in the whole tree. I
> think it's fine keeping smp_mb()...

I would like to use a more general name, maybe just use "memory barrier"?

>
>>   	 *					// ordering
>>   	 * PageMlocked()			PageLRU()
>>   	 *
>>   	 *
>>   	 * if '#1' does not observe setting of PG_lru by '#0' and fails
>>   	 * isolation, the explicit barrier will make sure that page_evictable
>> -	 * check will put the page in correct LRU. Without smp_mb(), SetPageLRU
>> +	 * check will put the page in correct LRU. Without MB(), SetPageLRU
> ... same here ...
>
>>   	 * can be reordered after PageMlocked check and can make '#1' to fail
>>   	 * the isolation of the page whose Mlocked bit is cleared (#0 is also
>>   	 * looking at the same page) and the evictable page will be stranded
>>   	 * in an unevictable LRU.
> Only here I would note that SetPageLRU() is an atomic bitop so we can use the
> __after_atomic() variant. And I would move the actual SetPageLRU() call from
> above the comment here right before the barrier.

Sure. Thanks.

>
>>   	 */
>> -	smp_mb();
>> +	smp_mb__after_atomic();
> Thanks.
>
>>   
>>   	if (page_evictable(page)) {
>>   		lru = page_lru(page);
>>

