Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42EA1178ED1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 11:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbgCDKsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 05:48:06 -0500
Received: from relay.sw.ru ([185.231.240.75]:53360 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgCDKsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:48:06 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j9RZ9-0005TX-Tr; Wed, 04 Mar 2020 13:47:52 +0300
Subject: Re: [PATCH v2 1/1] mm: fix interrupt disabled long time inside
 deferred_init_memmap()
To:     Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
References: <20200303161551.132263-1-shile.zhang@linux.alibaba.com>
 <20200303161551.132263-2-shile.zhang@linux.alibaba.com>
 <fc22967d-0803-2e6f-26af-148a24f8f958@virtuozzo.com>
 <386d7d5f-a57d-f5b1-acee-131ce23d35ec@linux.alibaba.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <2d4defb7-8816-3447-3d65-f5d80067a9fd@virtuozzo.com>
Date:   Wed, 4 Mar 2020 13:47:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <386d7d5f-a57d-f5b1-acee-131ce23d35ec@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.2020 05:34, Shile Zhang wrote:
> Hi Kirill,
> 
> Thanks for your quickly reply!
> 
> On 2020/3/4 00:52, Kirill Tkhai wrote:
>> On 03.03.2020 19:15, Shile Zhang wrote:
>>> When 'CONFIG_DEFERRED_STRUCT_PAGE_INIT' is set, 'pgdatinit' kthread will
>>> initialise the deferred pages with local interrupts disabled. It is
>>> introduced by commit 3a2d7fa8a3d5 ("mm: disable interrupts while
>>> initializing deferred pages").
>>>
>>> The local interrupt will be disabled long time inside
>>> deferred_init_memmap(), depends on memory size.
>>> On machine with NCPUS <= 2, the 'pgdatinit' kthread could be pined on
>>> boot CPU, then the tick timer will stuck long time, which caused the
>>> system wall time inaccuracy.
>>>
>>> For example, the dmesg shown that:
>>>
>>>    [    0.197975] node 0 initialised, 32170688 pages in 1ms
>>>
>>> Obviously, 1ms is unreasonable.
>>> Now, fix it by restore in the pending interrupts inside the while loop.
>>> The reasonable demsg shown likes:
>>>
>>> [    1.069306] node 0 initialised, 32203456 pages in 894ms
>> The way I understand the original problem, that Pavel fixed:
>>
>> we need disable irqs in deferred_init_memmap() since this function may be called
>> in parallel with deferred_grow_zone() called from interrupt handler. So, Pavel
>> added lock to fix the race.
>>
>> In case of we temporary unlock the lock, interrupt still be possible,
>> so my previous proposition returns the problem back.
>>
>> Now thought again, I think we have to just add:
>>
>>     pgdat_resize_unlock();
>>     pgdat_resize_lock();
>>
>> instead of releasing interrupts, since in case of we just release them with lock held,
>> a call of interrupt->deferred_grow_zone() bring us to a deadlock.
>>
>> So, unlock the lock is must.
> 
> Yes, you're right! I missed this point.
> Thanks for your comment!
> 
>>
>>> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
>>> ---
>>>   mm/page_alloc.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 3c4eb750a199..d3f337f2e089 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -1809,8 +1809,12 @@ static int __init deferred_init_memmap(void *data)
>>>        * that we can avoid introducing any issues with the buddy
>>>        * allocator.
>>>        */
>>> -    while (spfn < epfn)
>>> +    while (spfn < epfn) {
>>>           nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
>>> +        /* let in any pending interrupts */
>>> +        local_irq_restore(flags);
>>> +        local_irq_save(flags);
>>> +    }
>>>   zone_empty:
>>>       pgdat_resize_unlock(pgdat, &flags);
>> I think we need here something like below (untested):
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 79e950d76ffc..323afa9a4db5 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1828,7 +1828,7 @@ static int __init deferred_init_memmap(void *data)
>>   {
>>       pg_data_t *pgdat = data;
>>       const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
>> -    unsigned long spfn = 0, epfn = 0, nr_pages = 0;
>> +    unsigned long spfn = 0, epfn = 0, nr_pages = 0, prev_nr_pages = 0;
>>       unsigned long first_init_pfn, flags;
>>       unsigned long start = jiffies;
>>       struct zone *zone;
>> @@ -1869,8 +1869,18 @@ static int __init deferred_init_memmap(void *data)
>>        * that we can avoid introducing any issues with the buddy
>>        * allocator.
>>        */
>> -    while (spfn < epfn)
>> +    while (spfn < epfn) {
>>           nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
>> +        /*
>> +         * Release interrupts every 1Gb to give a possibility
>> +         * a timer to advance jiffies.
>> +         */
>> +        if (nr_pages - prev_nr_pages > (1UL << (30 - PAGE_SHIFT))) {
>> +            prev_nr_pages = nr_pages;
>> +            pgdat_resize_unlock(pgdat, &flags);
>> +            pgdat_resize_lock(pgdat, &flags);
>> +        }
>> +    }
>>   zone_empty:
>>       pgdat_resize_unlock(pgdat, &flags);
>>  
>> (I believe the comment may be improved more).
> 
> Yeah, your patch is better!
> I test your code and it works!
> But it seems that 1G is still hold the interrupts too long, about 40ms in my env
> with Intel(R) Xeon(R) 2.5GHz). I tried other size, it is OK to use 1024 pages (4MB),
> which suggested by Andrew's before.
> 
> Could you please help to review it again?
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..5def66d3ffcd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1768,7 +1768,7 @@ static int __init deferred_init_memmap(void *data)
>  {
>         pg_data_t *pgdat = data;
>         const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
> -       unsigned long spfn = 0, epfn = 0, nr_pages = 0;
> +       unsigned long spfn = 0, epfn = 0, nr_pages = 0, prev_nr_pages = 0;
>         unsigned long first_init_pfn, flags;
>         unsigned long start = jiffies;
>         struct zone *zone;
> @@ -1809,8 +1809,17 @@ static int __init deferred_init_memmap(void *data)
>          * that we can avoid introducing any issues with the buddy
>          * allocator.
>          */
> -       while (spfn < epfn)
> +       while (spfn < epfn) {
>                 nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> +               /*
> +                * Restore pending interrupts every 1024 pages to give
> +                * the chance tick timer to advance jiffies.
> +                */
> +               if (nr_pages - prev_nr_pages > 1024) {
> +                       pgdat_resize_unlock(&flags);
> +                       pgdat_resize_lock(&flags);

Here is problem: prev_nr_pages must be updated.

Anyway, releasing every 4M looks wrong for me, since you removes the fix that Pavel introduced.
He protected against big allocations made from interrupt content. But in case of we unlock
the lock after 4Mb, only 4Mb will be available for allocations from interrupts. pgdat->first_deferred_pfn
is updated at the start of function, so interrupt allocations won't be able to initialize
mode for themselve.

In case of you want unlock interrupts very often, you should make some creativity with first_deferred_pfn.
We should update it sequentially. Something like below (untested):

---
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 79e950d76ffc..be09d158baeb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1828,7 +1828,7 @@ static int __init deferred_init_memmap(void *data)
 {
 	pg_data_t *pgdat = data;
 	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
-	unsigned long spfn = 0, epfn = 0, nr_pages = 0;
+	unsigned long spfn = 0, epfn = 0, nr_pages;
 	unsigned long first_init_pfn, flags;
 	unsigned long start = jiffies;
 	struct zone *zone;
@@ -1838,7 +1838,7 @@ static int __init deferred_init_memmap(void *data)
 	/* Bind memory initialisation thread to a local node if possible */
 	if (!cpumask_empty(cpumask))
 		set_cpus_allowed_ptr(current, cpumask);
-
+again:
 	pgdat_resize_lock(pgdat, &flags);
 	first_init_pfn = pgdat->first_deferred_pfn;
 	if (first_init_pfn == ULONG_MAX) {
@@ -1850,7 +1850,6 @@ static int __init deferred_init_memmap(void *data)
 	/* Sanity check boundaries */
 	BUG_ON(pgdat->first_deferred_pfn < pgdat->node_start_pfn);
 	BUG_ON(pgdat->first_deferred_pfn > pgdat_end_pfn(pgdat));
-	pgdat->first_deferred_pfn = ULONG_MAX;
 
 	/* Only the highest zone is deferred so find it */
 	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
@@ -1864,14 +1863,30 @@ static int __init deferred_init_memmap(void *data)
 						 first_init_pfn))
 		goto zone_empty;
 
+	nr_pages = 0;
+
 	/*
 	 * Initialize and free pages in MAX_ORDER sized increments so
 	 * that we can avoid introducing any issues with the buddy
 	 * allocator.
+	 * Final iteration marker is: spfn=ULONG_MAX and epfn=0.
 	 */
-	while (spfn < epfn)
+	while (spfn < epfn) {
 		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
+		if (!epfn)
+			break;
+		pgdat->first_deferred_pfn = epfn;
+		/*
+		 * Restore pending interrupts every 128Mb to give
+		 * the chance tick timer to advance jiffies.
+		 */
+		if (nr_pages > (1UL << 27 - PAGE_SHIFT)) {
+			pgdat_resize_unlock(pgdat, &flags);
+			goto again;
+		}
+	}
 zone_empty:
+	pgdat->first_deferred_pfn = ULONG_MAX;
 	pgdat_resize_unlock(pgdat, &flags);
 
 	/* Sanity check that the next zone really is unpopulated */



