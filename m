Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2340165F3B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 14:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgBTNx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 08:53:56 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:49034 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728071AbgBTNx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:53:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TqSK9Y._1582206806;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TqSK9Y._1582206806)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 20 Feb 2020 21:53:48 +0800
Subject: Re: [PATCH] mm/slub: Detach node lock from counting free objects
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200201031502.92218-1-wenyang@linux.alibaba.com>
 <20200212145247.bf89431272038de53dd9d975@linux-foundation.org>
 <b42f7daa-4aea-1cf8-5bbb-2cd5d48b4e9a@linux.alibaba.com>
 <20200218205312.GA3156@carbon>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <cb36f3e5-c01c-a99d-9230-af52f806e227@linux.alibaba.com>
Date:   Thu, 20 Feb 2020 21:53:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200218205312.GA3156@carbon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/2/19 4:53 上午, Roman Gushchin wrote:
> On Sun, Feb 16, 2020 at 12:15:54PM +0800, Wen Yang wrote:
>>
>>
>> On 2020/2/13 6:52 上午, Andrew Morton wrote:
>>> On Sat,  1 Feb 2020 11:15:02 +0800 Wen Yang <wenyang@linux.alibaba.com> wrote:
>>>
>>>> The lock, protecting the node partial list, is taken when couting the free
>>>> objects resident in that list. It introduces locking contention when the
>>>> page(s) is moved between CPU and node partial lists in allocation path
>>>> on another CPU. So reading "/proc/slabinfo" can possibily block the slab
>>>> allocation on another CPU for a while, 200ms in extreme cases. If the
>>>> slab object is to carry network packet, targeting the far-end disk array,
>>>> it causes block IO jitter issue.
>>>>
>>>> This fixes the block IO jitter issue by caching the total inuse objects in
>>>> the node in advance. The value is retrieved without taking the node partial
>>>> list lock on reading "/proc/slabinfo".
>>>>
>>>> ...
>>>>
>>>> @@ -1768,7 +1774,9 @@ static void free_slab(struct kmem_cache *s, struct page *page)
>>>>    static void discard_slab(struct kmem_cache *s, struct page *page)
>>>>    {
>>>> -	dec_slabs_node(s, page_to_nid(page), page->objects);
>>>> +	int inuse = page->objects;
>>>> +
>>>> +	dec_slabs_node(s, page_to_nid(page), page->objects, inuse);
>>>
>>> Is this right?  dec_slabs_node(..., page->objects, page->objects)?
>>>
>>> If no, we could simply pass the page* to inc_slabs_node/dec_slabs_node
>>> and save a function argument.
>>>
>>> If yes then why?
>>>
>>
>> Thanks for your comments.
>> We are happy to improve this patch based on your suggestions.
>>
>>
>> When the user reads /proc/slabinfo, in order to obtain the active_objs
>> information, the kernel traverses all slabs and executes the following code
>> snippet:
>> static unsigned long count_partial(struct kmem_cache_node *n,
>>                                          int (*get_count)(struct page *))
>> {
>>          unsigned long flags;
>>          unsigned long x = 0;
>>          struct page *page;
>>
>>          spin_lock_irqsave(&n->list_lock, flags);
>>          list_for_each_entry(page, &n->partial, slab_list)
>>                  x += get_count(page);
>>          spin_unlock_irqrestore(&n->list_lock, flags);
>>          return x;
>> }
>>
>> It may cause performance issues.
>>
>> Christoph suggested "you could cache the value in the userspace application?
>> Why is this value read continually?", But reading the /proc/slabinfo is
>> initiated by the user program. As a cloud provider, we cannot control user
>> behavior. If a user program inadvertently executes cat /proc/slabinfo, it
>> may affect other user programs.
>>
>> As Christoph said: "The count is not needed for any operations. Just for the
>> slabinfo output. The value has no operational value for the allocator
>> itself. So why use extra logic to track it in potentially performance
>> critical paths?"
>>
>> In this way, could we show the approximate value of active_objs in the
>> /proc/slabinfo?
>>
>> Based on the following information:
>> In the discard_slab() function, page->inuse is equal to page->total_objects;
>> In the allocate_slab() function, page->inuse is also equal to
>> page->total_objects (with one exception: for kmem_cache_node, page-> inuse
>> equals 1);
>> page->inuse will only change continuously when the obj is constantly
>> allocated or released. (This should be the performance critical path
>> emphasized by Christoph)
>>
>> When users query the global slabinfo information, we may use total_objects
>> to approximate active_objs.
> 
> Well, from one point of view, it makes no sense, because the ratio between
> these two numbers is very meaningful: it's the slab utilization rate.
> 
> On the other side, with enabled per-cpu partial lists active_objs has
> nothing to do with the reality anyway, so I agree with you, calling
> count_partial() is almost useless.
> 
> That said, I wonder if the right thing to do is something like the patch below?
> 
> Thanks!
> 
> Roman
> 
> --
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 1d644143f93e..ba0505e75ecc 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2411,14 +2411,16 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
>   static unsigned long count_partial(struct kmem_cache_node *n,
>                                          int (*get_count)(struct page *))
>   {
> -       unsigned long flags;
>          unsigned long x = 0;
> +#ifdef CONFIG_SLUB_CPU_PARTIAL
> +       unsigned long flags;
>          struct page *page;
>   
>          spin_lock_irqsave(&n->list_lock, flags);
>          list_for_each_entry(page, &n->partial, slab_list)
>                  x += get_count(page);
>          spin_unlock_irqrestore(&n->list_lock, flags);
> +#endif
>          return x;
>   }
>   #endif /* CONFIG_SLUB_DEBUG || CONFIG_SYSFS */
> 

Hi Roman,

Thanks for your comments.

In the server scenario, SLUB_CPU_PARTIAL is turned on by default, and 
can improve the performance of the cloud server, as follows:

   default y
   depends on SLUB && SMP
   bool "SLUB per cpu partial cache"
   help
     Per cpu partial caches accelerate objects allocation and freeing
     that is local to a processor at the price of more indeterminism
     in the latency of the free. On overflow these caches will be cleared
     which requires the taking of locks that may cause latency spikes.
     Typically one would choose no for a realtime system.


Best wishes,
Wen



