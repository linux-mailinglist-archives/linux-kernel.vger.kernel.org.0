Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C168C9F12B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 19:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbfH0RGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 13:06:47 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:59141 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726871AbfH0RGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:06:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Tacuohx_1566925590;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tacuohx_1566925590)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 28 Aug 2019 01:06:33 +0800
Subject: Re: [v2 PATCH -mm] mm: account deferred split THPs into MemAvailable
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, rientjes@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190822080434.GF12785@dhcp22.suse.cz>
 <ee048bbf-3563-d695-ea58-5f1504aee35c@suse.cz>
 <20190822152934.w6ztolutdix6kbvc@box> <20190826074035.GD7538@dhcp22.suse.cz>
 <20190826131538.64twqx3yexmhp6nf@box> <20190827060139.GM7538@dhcp22.suse.cz>
 <20190827110210.lpe36umisqvvesoa@box>
 <aaaf9742-56f7-44b7-c3db-ad078b7b2220@suse.cz>
 <20190827120923.GB7538@dhcp22.suse.cz> <20190827121739.bzbxjloq7bhmroeq@box>
 <20190827125911.boya23eowxhqmopa@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <d76ec546-7ae8-23a3-4631-5c531c1b1f40@linux.alibaba.com>
Date:   Tue, 27 Aug 2019 10:06:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190827125911.boya23eowxhqmopa@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/27/19 5:59 AM, Kirill A. Shutemov wrote:
> On Tue, Aug 27, 2019 at 03:17:39PM +0300, Kirill A. Shutemov wrote:
>> On Tue, Aug 27, 2019 at 02:09:23PM +0200, Michal Hocko wrote:
>>> On Tue 27-08-19 14:01:56, Vlastimil Babka wrote:
>>>> On 8/27/19 1:02 PM, Kirill A. Shutemov wrote:
>>>>> On Tue, Aug 27, 2019 at 08:01:39AM +0200, Michal Hocko wrote:
>>>>>> On Mon 26-08-19 16:15:38, Kirill A. Shutemov wrote:
>>>>>>> Unmapped completely pages will be freed with current code. Deferred split
>>>>>>> only applies to partly mapped THPs: at least on 4k of the THP is still
>>>>>>> mapped somewhere.
>>>>>> Hmm, I am probably misreading the code but at least current Linus' tree
>>>>>> reads page_remove_rmap -> [page_remove_anon_compound_rmap ->\ deferred_split_huge_page even
>>>>>> for fully mapped THP.
>>>>> Well, you read correctly, but it was not intended. I screwed it up at some
>>>>> point.
>>>>>
>>>>> See the patch below. It should make it work as intened.
>>>>>
>>>>> It's not bug as such, but inefficientcy. We add page to the queue where
>>>>> it's not needed.
>>>> But that adding to queue doesn't affect whether the page will be freed
>>>> immediately if there are no more partial mappings, right? I don't see
>>>> deferred_split_huge_page() pinning the page.
>>>> So your patch wouldn't make THPs freed immediately in cases where they
>>>> haven't been freed before immediately, it just fixes a minor
>>>> inefficiency with queue manipulation?
>>> Ohh, right. I can see that in free_transhuge_page now. So fully mapped
>>> THPs really do not matter and what I have considered an odd case is
>>> really happening more often.
>>>
>>> That being said this will not help at all for what Yang Shi is seeing
>>> and we need a more proactive deferred splitting as I've mentioned
>>> earlier.
>> It was not intended to fix the issue. It's fix for current logic. I'm
>> playing with the work approach now.
> Below is what I've come up with. It appears to be functional.
>
> Any comments?

Thanks, Kirill and Michal. Doing split more proactive is definitely a 
choice to eliminate huge accumulated deferred split THPs, I did think 
about this approach before I came up with memcg aware approach. But, I 
thought this approach has some problems:

First of all, we can't prove if this is a universal win for the most 
workloads or not. For some workloads (as I mentioned about our usecase), 
we do see a lot THPs accumulated for a while, but they are very 
short-lived for other workloads, i.e. kernel build.

Secondly, it may be not fair for some workloads which don't generate too 
many deferred split THPs or those THPs are short-lived. Actually, the 
cpu time is abused by the excessive deferred split THPs generators, 
isn't it?

With memcg awareness, the deferred split THPs actually are isolated and 
capped by memcg. The long-lived deferred split THPs can't be accumulated 
too many due to the limit of memcg. And, cpu time spent in splitting 
them would just account to the memcgs who generate that many deferred 
split THPs, who generate them who pay for it. This sounds more fair and 
we could achieve much better isolation.

And, I think the discussion is diverted and mislead by the number of 
excessive deferred split THPs. To be clear, I didn't mean the excessive 
deferred split THPs are problem for us (I agree it may waste memory to 
have that many deferred split THPs not usable), the problem is the oom 
since they couldn't be split by memcg limit reclaim since the shrinker 
was not memcg aware.

>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index d77d717c620c..c576e9d772b7 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -758,6 +758,8 @@ typedef struct pglist_data {
>   	spinlock_t split_queue_lock;
>   	struct list_head split_queue;
>   	unsigned long split_queue_len;
> +	unsigned int deferred_split_calls;
> +	struct work_struct deferred_split_work;
>   #endif
>   
>   	/* Fields commonly accessed by the page reclaim scanner */
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index de1f15969e27..12d109bbe8ac 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2820,22 +2820,6 @@ void free_transhuge_page(struct page *page)
>   	free_compound_page(page);
>   }
>   
> -void deferred_split_huge_page(struct page *page)
> -{
> -	struct pglist_data *pgdata = NODE_DATA(page_to_nid(page));
> -	unsigned long flags;
> -
> -	VM_BUG_ON_PAGE(!PageTransHuge(page), page);
> -
> -	spin_lock_irqsave(&pgdata->split_queue_lock, flags);
> -	if (list_empty(page_deferred_list(page))) {
> -		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> -		list_add_tail(page_deferred_list(page), &pgdata->split_queue);
> -		pgdata->split_queue_len++;
> -	}
> -	spin_unlock_irqrestore(&pgdata->split_queue_lock, flags);
> -}
> -
>   static unsigned long deferred_split_count(struct shrinker *shrink,
>   		struct shrink_control *sc)
>   {
> @@ -2901,6 +2885,44 @@ static struct shrinker deferred_split_shrinker = {
>   	.flags = SHRINKER_NUMA_AWARE,
>   };
>   
> +void flush_deferred_split_queue(struct work_struct *work)
> +{
> +	struct pglist_data *pgdata;
> +	struct shrink_control sc;
> +
> +	pgdata = container_of(work, struct pglist_data, deferred_split_work);
> +	sc.nid = pgdata->node_id;
> +	sc.nr_to_scan = 0; /* Unlimited */
> +
> +	deferred_split_scan(NULL, &sc);
> +}
> +
> +#define NR_CALLS_TO_SPLIT 32
> +#define NR_PAGES_ON_QUEUE_TO_SPLIT 16
> +
> +void deferred_split_huge_page(struct page *page)
> +{
> +	struct pglist_data *pgdata = NODE_DATA(page_to_nid(page));
> +	unsigned long flags;
> +
> +	VM_BUG_ON_PAGE(!PageTransHuge(page), page);
> +
> +	spin_lock_irqsave(&pgdata->split_queue_lock, flags);
> +	if (list_empty(page_deferred_list(page))) {
> +		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> +		list_add_tail(page_deferred_list(page), &pgdata->split_queue);
> +		pgdata->split_queue_len++;
> +		pgdata->deferred_split_calls++;
> +	}
> +
> +	if (pgdata->deferred_split_calls > NR_CALLS_TO_SPLIT &&
> +			pgdata->split_queue_len > NR_PAGES_ON_QUEUE_TO_SPLIT) {
> +		pgdata->deferred_split_calls = 0;
> +		schedule_work(&pgdata->deferred_split_work);
> +	}
> +	spin_unlock_irqrestore(&pgdata->split_queue_lock, flags);
> +}
> +
>   #ifdef CONFIG_DEBUG_FS
>   static int split_huge_pages_set(void *data, u64 val)
>   {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9c9194959271..86af66d463e9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6636,11 +6636,14 @@ static unsigned long __init calc_memmap_size(unsigned long spanned_pages,
>   }
>   
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +void flush_deferred_split_queue(struct work_struct *work);
>   static void pgdat_init_split_queue(struct pglist_data *pgdat)
>   {
>   	spin_lock_init(&pgdat->split_queue_lock);
>   	INIT_LIST_HEAD(&pgdat->split_queue);
>   	pgdat->split_queue_len = 0;
> +	pgdat->deferred_split_calls = 0;
> +	INIT_WORK(&pgdat->deferred_split_work, flush_deferred_split_queue);
>   }
>   #else
>   static void pgdat_init_split_queue(struct pglist_data *pgdat) {}

