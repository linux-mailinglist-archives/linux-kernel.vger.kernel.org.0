Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B60418175B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 13:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgCKMCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 08:02:53 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:51006 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729211AbgCKMCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:02:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TsIQDda_1583928008;
Received: from ali-6c96cfdd1403.local(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0TsIQDda_1583928008)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 Mar 2020 20:00:09 +0800
Subject: Re: [PATCH v2 1/1] mm: fix interrupt disabled long time inside
 deferred_init_memmap()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
References: <20200303161551.132263-1-shile.zhang@linux.alibaba.com>
 <20200303161551.132263-2-shile.zhang@linux.alibaba.com>
 <fc22967d-0803-2e6f-26af-148a24f8f958@virtuozzo.com>
 <386d7d5f-a57d-f5b1-acee-131ce23d35ec@linux.alibaba.com>
 <2d4defb7-8816-3447-3d65-f5d80067a9fd@virtuozzo.com>
 <1856c956-858f-82d4-f3b3-05b2d0e5641c@linux.alibaba.com>
 <094fcf02-37bd-c9b9-7156-77b9b34955e0@virtuozzo.com>
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
Message-ID: <59c7f8c7-d2ef-8b59-637e-88a353d4daf0@linux.alibaba.com>
Date:   Wed, 11 Mar 2020 20:00:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <094fcf02-37bd-c9b9-7156-77b9b34955e0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/3/11 19:42, Kirill Tkhai wrote:
> On 11.03.2020 04:44, Shile Zhang wrote:
>> Hi Kirill,
>>
>> Sorry for late to reply!
>> I'm not fully understood the whole thing about deferred page init, so I
>> just force on the jiffies update issue itself.
>>
>> Maybe I'm in wrong path, it seems make no sense that deferred page init in 1 CPU system,
>> it cannot be initialize memory parallel.
> Yes, it can't be initialized in parallel. But scheduler interprets deferred thread as a separate
> task, so CPU time will be shared between that thread and the rest of tasks. This still should
> make boot faster.

Thanks for your quickly reply!

Sorry, I don't think the CPU time can be shared to the rest of tasks 
since the CPU be blocked until
the deferred pages are all initialized, as following code:
8<------
#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT

         /* There will be num_node_state(N_MEMORY) threads */
         atomic_set(&pgdat_init_n_undone, num_node_state(N_MEMORY));
         for_each_node_state(nid, N_MEMORY) {
                 kthread_run(deferred_init_memmap, NODE_DATA(nid), 
"pgdatinit%d", nid);
         }

         /* Block until all are initialised */
         wait_for_completion(&pgdat_init_all_done_comp);
8<-------

Maybe I misunderstood this point.

@Pavel,
Could you please give any advice on this point? Thanks!

>> It might be better to disable deferred page init in 'deferred_init' in case of 1 CPU
>> (or only one memory node).
>>
>> In other word, seems the better way to solve this issue is do not bind 'pgdatinit' thread
>> on boot CPU.
>>
>> I also refactor the patch based on your comment, please help to check, thanks!
>>
>>
>> On 2020/3/4 18:47, Kirill Tkhai wrote:
>>> On 04.03.2020 05:34, Shile Zhang wrote:
>>>> Hi Kirill,
>>>>
>>>> Thanks for your quickly reply!
>>>>
>>>> On 2020/3/4 00:52, Kirill Tkhai wrote:
>>>>> On 03.03.2020 19:15, Shile Zhang wrote:
>>>>>> When 'CONFIG_DEFERRED_STRUCT_PAGE_INIT' is set, 'pgdatinit' kthread will
>>>>>> initialise the deferred pages with local interrupts disabled. It is
>>>>>> introduced by commit 3a2d7fa8a3d5 ("mm: disable interrupts while
>>>>>> initializing deferred pages").
>>>>>>
>>>>>> The local interrupt will be disabled long time inside
>>>>>> deferred_init_memmap(), depends on memory size.
>>>>>> On machine with NCPUS <= 2, the 'pgdatinit' kthread could be pined on
>>>>>> boot CPU, then the tick timer will stuck long time, which caused the
>>>>>> system wall time inaccuracy.
>>>>>>
>>>>>> For example, the dmesg shown that:
>>>>>>
>>>>>>      [    0.197975] node 0 initialised, 32170688 pages in 1ms
>>>>>>
>>>>>> Obviously, 1ms is unreasonable.
>>>>>> Now, fix it by restore in the pending interrupts inside the while loop.
>>>>>> The reasonable demsg shown likes:
>>>>>>
>>>>>> [    1.069306] node 0 initialised, 32203456 pages in 894ms
>>>>> The way I understand the original problem, that Pavel fixed:
>>>>>
>>>>> we need disable irqs in deferred_init_memmap() since this function may be called
>>>>> in parallel with deferred_grow_zone() called from interrupt handler. So, Pavel
>>>>> added lock to fix the race.
>>>>>
>>>>> In case of we temporary unlock the lock, interrupt still be possible,
>>>>> so my previous proposition returns the problem back.
>>>>>
>>>>> Now thought again, I think we have to just add:
>>>>>
>>>>>       pgdat_resize_unlock();
>>>>>       pgdat_resize_lock();
>>>>>
>>>>> instead of releasing interrupts, since in case of we just release them with lock held,
>>>>> a call of interrupt->deferred_grow_zone() bring us to a deadlock.
>>>>>
>>>>> So, unlock the lock is must.
>>>> Yes, you're right! I missed this point.
>>>> Thanks for your comment!
>>>>
>>>>>> Signed-off-by: Shile Zhang<shile.zhang@linux.alibaba.com>
>>>>>> ---
>>>>>>     mm/page_alloc.c | 6 +++++-
>>>>>>     1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>> index 3c4eb750a199..d3f337f2e089 100644
>>>>>> --- a/mm/page_alloc.c
>>>>>> +++ b/mm/page_alloc.c
>>>>>> @@ -1809,8 +1809,12 @@ static int __init deferred_init_memmap(void *data)
>>>>>>          * that we can avoid introducing any issues with the buddy
>>>>>>          * allocator.
>>>>>>          */
>>>>>> -    while (spfn < epfn)
>>>>>> +    while (spfn < epfn) {
>>>>>>             nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
>>>>>> +        /* let in any pending interrupts */
>>>>>> +        local_irq_restore(flags);
>>>>>> +        local_irq_save(flags);
>>>>>> +    }
>>>>>>     zone_empty:
>>>>>>         pgdat_resize_unlock(pgdat, &flags);
>>>>> I think we need here something like below (untested):
>>>>>
>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>> index 79e950d76ffc..323afa9a4db5 100644
>>>>> --- a/mm/page_alloc.c
>>>>> +++ b/mm/page_alloc.c
>>>>> @@ -1828,7 +1828,7 @@ static int __init deferred_init_memmap(void *data)
>>>>>     {
>>>>>         pg_data_t *pgdat = data;
>>>>>         const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
>>>>> -    unsigned long spfn = 0, epfn = 0, nr_pages = 0;
>>>>> +    unsigned long spfn = 0, epfn = 0, nr_pages = 0, prev_nr_pages = 0;
>>>>>         unsigned long first_init_pfn, flags;
>>>>>         unsigned long start = jiffies;
>>>>>         struct zone *zone;
>>>>> @@ -1869,8 +1869,18 @@ static int __init deferred_init_memmap(void *data)
>>>>>          * that we can avoid introducing any issues with the buddy
>>>>>          * allocator.
>>>>>          */
>>>>> -    while (spfn < epfn)
>>>>> +    while (spfn < epfn) {
>>>>>             nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
>>>>> +        /*
>>>>> +         * Release interrupts every 1Gb to give a possibility
>>>>> +         * a timer to advance jiffies.
>>>>> +         */
>>>>> +        if (nr_pages - prev_nr_pages > (1UL << (30 - PAGE_SHIFT))) {
>>>>> +            prev_nr_pages = nr_pages;
>>>>> +            pgdat_resize_unlock(pgdat, &flags);
>>>>> +            pgdat_resize_lock(pgdat, &flags);
>>>>> +        }
>>>>> +    }
>>>>>     zone_empty:
>>>>>         pgdat_resize_unlock(pgdat, &flags);
>>>>>    (I believe the comment may be improved more).
>>>> Yeah, your patch is better!
>>>> I test your code and it works!
>>>> But it seems that 1G is still hold the interrupts too long, about 40ms in my env
>>>> with Intel(R) Xeon(R) 2.5GHz). I tried other size, it is OK to use 1024 pages (4MB),
>>>> which suggested by Andrew's before.
>>>>
>>>> Could you please help to review it again?
>>>>
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index 3c4eb750a199..5def66d3ffcd 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -1768,7 +1768,7 @@ static int __init deferred_init_memmap(void *data)
>>>>    {
>>>>           pg_data_t *pgdat = data;
>>>>           const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
>>>> -       unsigned long spfn = 0, epfn = 0, nr_pages = 0;
>>>> +       unsigned long spfn = 0, epfn = 0, nr_pages = 0, prev_nr_pages = 0;
>>>>           unsigned long first_init_pfn, flags;
>>>>           unsigned long start = jiffies;
>>>>           struct zone *zone;
>>>> @@ -1809,8 +1809,17 @@ static int __init deferred_init_memmap(void *data)
>>>>            * that we can avoid introducing any issues with the buddy
>>>>            * allocator.
>>>>            */
>>>> -       while (spfn < epfn)
>>>> +       while (spfn < epfn) {
>>>>                   nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
>>>> +               /*
>>>> +                * Restore pending interrupts every 1024 pages to give
>>>> +                * the chance tick timer to advance jiffies.
>>>> +                */
>>>> +               if (nr_pages - prev_nr_pages > 1024) {
>>>> +                       pgdat_resize_unlock(&flags);
>>>> +                       pgdat_resize_lock(&flags);
>>> Here is problem: prev_nr_pages must be updated.
>>>
>>> Anyway, releasing every 4M looks wrong for me, since you removes the fix that Pavel introduced.
>>> He protected against big allocations made from interrupt content. But in case of we unlock
>>> the lock after 4Mb, only 4Mb will be available for allocations from interrupts. pgdat->first_deferred_pfn
>>> is updated at the start of function, so interrupt allocations won't be able to initialize
>>> mode for themselve.
>> Yes, you're right. I missed this point since I'm not fully understood the code before.
>> Thanks for your advice!
>>> In case of you want unlock interrupts very often, you should make some creativity with first_deferred_pfn.
>>> We should update it sequentially. Something like below (untested):
>> I got your point now, thanks!
>>> ---
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 79e950d76ffc..be09d158baeb 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -1828,7 +1828,7 @@ static int __init deferred_init_memmap(void *data)
>>>    {
>>>        pg_data_t *pgdat = data;
>>>        const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
>>> -    unsigned long spfn = 0, epfn = 0, nr_pages = 0;
>>> +    unsigned long spfn = 0, epfn = 0, nr_pages;
>>>        unsigned long first_init_pfn, flags;
>>>        unsigned long start = jiffies;
>>>        struct zone *zone;
>>> @@ -1838,7 +1838,7 @@ static int __init deferred_init_memmap(void *data)
>>>        /* Bind memory initialisation thread to a local node if possible */
>>>        if (!cpumask_empty(cpumask))
>>>            set_cpus_allowed_ptr(current, cpumask);
>>> -
>>> +again:
>>>        pgdat_resize_lock(pgdat, &flags);
>>>        first_init_pfn = pgdat->first_deferred_pfn;
>>>        if (first_init_pfn == ULONG_MAX) {
>>> @@ -1850,7 +1850,6 @@ static int __init deferred_init_memmap(void *data)
>>>        /* Sanity check boundaries */
>>>        BUG_ON(pgdat->first_deferred_pfn < pgdat->node_start_pfn);
>>>        BUG_ON(pgdat->first_deferred_pfn > pgdat_end_pfn(pgdat));
>>> -    pgdat->first_deferred_pfn = ULONG_MAX;
>>>          /* Only the highest zone is deferred so find it */
>>>        for (zid = 0; zid < MAX_NR_ZONES; zid++) {
>>> @@ -1864,14 +1863,30 @@ static int __init deferred_init_memmap(void *data)
>>>                             first_init_pfn))
>>>            goto zone_empty;
>>>    +    nr_pages = 0;
>> 'nr_pages' used to mark the total init pages before, so it cannot be zerolized each round.
>> seems we need one more to count the pages init each round.
>>
>>> +
>>>        /*
>>>         * Initialize and free pages in MAX_ORDER sized increments so
>>>         * that we can avoid introducing any issues with the buddy
>>>         * allocator.
>>> +     * Final iteration marker is: spfn=ULONG_MAX and epfn=0.
>>>         */
>>> -    while (spfn < epfn)
>>> +    while (spfn < epfn) {
>>>            nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
>>> +        if (!epfn)
>>> +            break;
>> Seems 'epfn' never goes to 0 since it is "end page frame number", right?
>> So this is needless.
>>> +        pgdat->first_deferred_pfn = epfn;
>> I think first_deferred_pfn update wrong value here, it seems should be the spfn, the start pfn right?
>>> +        /*
>>> +         * Restore pending interrupts every 128Mb to give
>>> +         * the chance tick timer to advance jiffies.
>>> +         */
>>> +        if (nr_pages > (1UL << 27 - PAGE_SHIFT)) {
>>> +            pgdat_resize_unlock(pgdat, &flags);
>>> +            goto again;
>>> +        }
>>> +    }
>>>    zone_empty:
>>> +    pgdat->first_deferred_pfn = ULONG_MAX;
>>>        pgdat_resize_unlock(pgdat, &flags);
>>>          /* Sanity check that the next zone really is unpopulated */
>>>
>>>
>> I update the patch based on your comment, it passed the test.
>> Could you please help to review it again? Thanks!
> The patch is OK for me. It may be sent into ml with an appropriate description.
>
> Feel free to not forget to add my:
>
> Co-developed-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Yeah, sure!
Many thanks for your kindly help on this issue!
I'll send out v3 later for further review.
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 3c4eb750a199..841c902d4509 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1763,12 +1763,17 @@ deferred_init_maxorder(u64 *i, struct zone *zone, unsigned long *start_pfn,
>>          return nr_pages;
>>   }
>>
>> +/*
>> + * Release the tick timer interrupts for every TICK_PAGE_COUNT pages.
>> + */
>> +#define TICK_PAGE_COUNT        (32 * 1024)
>> +
>>   /* Initialise remaining memory on a node */
>>   static int __init deferred_init_memmap(void *data)
>>   {
>>          pg_data_t *pgdat = data;
>>          const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
>> -       unsigned long spfn = 0, epfn = 0, nr_pages = 0;
>> +       unsigned long spfn = 0, epfn = 0, nr_pages = 0, prev_nr_pages = 0;
>>          unsigned long first_init_pfn, flags;
>>          unsigned long start = jiffies;
>>          struct zone *zone;
>> @@ -1779,6 +1784,7 @@ static int __init deferred_init_memmap(void *data)
>>          if (!cpumask_empty(cpumask))
>>                  set_cpus_allowed_ptr(current, cpumask);
>>
>> +again:
>>          pgdat_resize_lock(pgdat, &flags);
>>          first_init_pfn = pgdat->first_deferred_pfn;
>>          if (first_init_pfn == ULONG_MAX) {
>> @@ -1790,7 +1796,6 @@ static int __init deferred_init_memmap(void *data)
>>          /* Sanity check boundaries */
>>          BUG_ON(pgdat->first_deferred_pfn < pgdat->node_start_pfn);
>>          BUG_ON(pgdat->first_deferred_pfn > pgdat_end_pfn(pgdat));
>> -       pgdat->first_deferred_pfn = ULONG_MAX;
>>
>>          /* Only the highest zone is deferred so find it */
>>          for (zid = 0; zid < MAX_NR_ZONES; zid++) {
>> @@ -1809,9 +1814,23 @@ static int __init deferred_init_memmap(void *data)
>>           * that we can avoid introducing any issues with the buddy
>>           * allocator.
>>           */
>> -       while (spfn < epfn)
>> +       while (spfn < epfn) {
>>                  nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
>> +               /*
>> +                * Release the interrupts for every TICK_PAGE_COUNT pages
>> +                * (128MB) to give the chance that tick timer to advance
>> +                * the jiffies.
>> +                */
>> +               if ((nr_pages - prev_nr_pages) > TICK_PAGE_COUNT) {
>> +                       prev_nr_pages = nr_pages;
>> +                       pgdat->first_deferred_pfn = spfn;
>> +                       pgdat_resize_unlock(pgdat, &flags);
>> +                       goto again;
>> +               }
>> +       }
>> +
>>   zone_empty:
>> +       pgdat->first_deferred_pfn = ULONG_MAX;
>>          pgdat_resize_unlock(pgdat, &flags);
>>
>>          /* Sanity check that the next zone really is unpopulated */
>>

