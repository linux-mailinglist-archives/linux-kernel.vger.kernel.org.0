Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5823C19BAD8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 06:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgDBEC7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Apr 2020 00:02:59 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:40552 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726136AbgDBEC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 00:02:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TuNonMf_1585800168;
Received: from 127.0.0.1(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0TuNonMf_1585800168)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Apr 2020 12:02:53 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER to
 handle THP spilt issue
From:   teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <5e0e0659-5f70-2162-96be-5fcd0d3f46ad@redhat.com>
Date:   Thu, 2 Apr 2020 12:02:47 +0800
Cc:     Nadav Amit <namit@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "pagupta@redhat.com" <pagupta@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "mojha@codeaurora.org" <mojha@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Hui Zhu <teawater@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <07AF0005-2711-4137-A96D-DA264A05C302@linux.alibaba.com>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
 <20200326054554-mutt-send-email-mst@kernel.org>
 <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
 <20200331093300-mutt-send-email-mst@kernel.org>
 <b69796e0-fa41-a219-c3e5-a11e9f5f18bf@redhat.com>
 <20200331100359-mutt-send-email-mst@kernel.org>
 <85f699d4-459a-a319-0a8f-96c87d345c49@redhat.com>
 <BABD09DC-217E-4F00-9C05-74ABB4B1E13D@vmware.com>
 <5e0e0659-5f70-2162-96be-5fcd0d3f46ad@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2020年4月1日 17:48，David Hildenbrand <david@redhat.com> 写道：
> 
> On 31.03.20 18:37, Nadav Amit wrote:
>>> On Mar 31, 2020, at 7:09 AM, David Hildenbrand <david@redhat.com> wrote:
>>> 
>>> On 31.03.20 16:07, Michael S. Tsirkin wrote:
>>>> On Tue, Mar 31, 2020 at 04:03:18PM +0200, David Hildenbrand wrote:
>>>>> On 31.03.20 15:37, Michael S. Tsirkin wrote:
>>>>>> On Tue, Mar 31, 2020 at 03:32:05PM +0200, David Hildenbrand wrote:
>>>>>>> On 31.03.20 15:24, Michael S. Tsirkin wrote:
>>>>>>>> On Tue, Mar 31, 2020 at 12:35:24PM +0200, David Hildenbrand wrote:
>>>>>>>>> On 26.03.20 10:49, Michael S. Tsirkin wrote:
>>>>>>>>>> On Thu, Mar 26, 2020 at 08:54:04AM +0100, David Hildenbrand wrote:
>>>>>>>>>>>> Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat.com>:
>>>>>>>>>>>> 
>>>>>>>>>>>> ﻿On Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hildenbrand wrote:
>>>>>>>>>>>>>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
>>>>>>>>>>>>>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote:
>>>>>>>>>>>>>>> 2. You are essentially stealing THPs in the guest. So the fastest
>>>>>>>>>>>>>>> mapping (THP in guest and host) is gone. The guest won't be able to make
>>>>>>>>>>>>>>> use of THP where it previously was able to. I can imagine this implies a
>>>>>>>>>>>>>>> performance degradation for some workloads. This needs a proper
>>>>>>>>>>>>>>> performance evaluation.
>>>>>>>>>>>>>> 
>>>>>>>>>>>>>> I think the problem is more with the alloc_pages API.
>>>>>>>>>>>>>> That gives you exactly the given order, and if there's
>>>>>>>>>>>>>> a larger chunk available, it will split it up.
>>>>>>>>>>>>>> 
>>>>>>>>>>>>>> But for balloon - I suspect lots of other users,
>>>>>>>>>>>>>> we do not want to stress the system but if a large
>>>>>>>>>>>>>> chunk is available anyway, then we could handle
>>>>>>>>>>>>>> that more optimally by getting it all in one go.
>>>>>>>>>>>>>> 
>>>>>>>>>>>>>> 
>>>>>>>>>>>>>> So if we want to address this, IMHO this calls for a new API.
>>>>>>>>>>>>>> Along the lines of
>>>>>>>>>>>>>> 
>>>>>>>>>>>>>>  struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
>>>>>>>>>>>>>>                  unsigned int max_order, unsigned int *order)
>>>>>>>>>>>>>> 
>>>>>>>>>>>>>> the idea would then be to return at a number of pages in the given
>>>>>>>>>>>>>> range.
>>>>>>>>>>>>>> 
>>>>>>>>>>>>>> What do you think? Want to try implementing that?
>>>>>>>>>>>>> 
>>>>>>>>>>>>> You can just start with the highest order and decrement the order until
>>>>>>>>>>>>> your allocation succeeds using alloc_pages(), which would be enough for
>>>>>>>>>>>>> a first version. At least I don't see the immediate need for a new
>>>>>>>>>>>>> kernel API.
>>>>>>>>>>>> 
>>>>>>>>>>>> OK I remember now.  The problem is with reclaim. Unless reclaim is
>>>>>>>>>>>> completely disabled, any of these calls can sleep. After it wakes up,
>>>>>>>>>>>> we would like to get the larger order that has become available
>>>>>>>>>>>> meanwhile.
>>>>>>>>>>> 
>>>>>>>>>>> Yes, but that‘s a pure optimization IMHO.
>>>>>>>>>>> So I think we should do a trivial implementation first and then see what we gain from a new allocator API. Then we might also be able to justify it using real numbers.
>>>>>>>>>> 
>>>>>>>>>> Well how do you propose implement the necessary semantics?
>>>>>>>>>> I think we are both agreed that alloc_page_range is more or
>>>>>>>>>> less what's necessary anyway - so how would you approximate it
>>>>>>>>>> on top of existing APIs?
>>>>>>>>> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
>>>>>> 
>>>>>> .....
>>>>>> 
>>>>>> 
>>>>>>>>> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
>>>>>>>>> index 26de020aae7b..067810b32813 100644
>>>>>>>>> --- a/mm/balloon_compaction.c
>>>>>>>>> +++ b/mm/balloon_compaction.c
>>>>>>>>> @@ -112,23 +112,35 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
>>>>>>>>> EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
>>>>>>>>> 
>>>>>>>>> /*
>>>>>>>>> - * balloon_page_alloc - allocates a new page for insertion into the balloon
>>>>>>>>> - *			page list.
>>>>>>>>> + * balloon_pages_alloc - allocates a new page (of at most the given order)
>>>>>>>>> + * 			 for insertion into the balloon page list.
>>>>>>>>> *
>>>>>>>>> * Driver must call this function to properly allocate a new balloon page.
>>>>>>>>> * Driver must call balloon_page_enqueue before definitively removing the page
>>>>>>>>> * from the guest system.
>>>>>>>>> *
>>>>>>>>> + * Will fall back to smaller orders if allocation fails. The order of the
>>>>>>>>> + * allocated page is stored in page->private.
>>>>>>>>> + *
>>>>>>>>> * Return: struct page for the allocated page or NULL on allocation failure.
>>>>>>>>> */
>>>>>>>>> -struct page *balloon_page_alloc(void)
>>>>>>>>> +struct page *balloon_pages_alloc(int order)
>>>>>>>>> {
>>>>>>>>> -	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
>>>>>>>>> -				       __GFP_NOMEMALLOC | __GFP_NORETRY |
>>>>>>>>> -				       __GFP_NOWARN);
>>>>>>>>> -	return page;
>>>>>>>>> +	struct page *page;
>>>>>>>>> +
>>>>>>>>> +	while (order >= 0) {
>>>>>>>>> +		page = alloc_pages(balloon_mapping_gfp_mask() |
>>>>>>>>> +				   __GFP_NOMEMALLOC | __GFP_NORETRY |
>>>>>>>>> +				   __GFP_NOWARN, order);
>>>>>>>>> +		if (page) {
>>>>>>>>> +			set_page_private(page, order);
>>>>>>>>> +			return page;
>>>>>>>>> +		}
>>>>>>>>> +		order--;
>>>>>>>>> +	}
>>>>>>>>> +	return NULL;
>>>>>>>>> }
>>>>>>>>> -EXPORT_SYMBOL_GPL(balloon_page_alloc);
>>>>>>>>> +EXPORT_SYMBOL_GPL(balloon_pages_alloc);
>>>>>>>>> 
>>>>>>>>> /*
>>>>>>>>> * balloon_page_enqueue - inserts a new page into the balloon page list.
>>>>>>>> 
>>>>>>>> 
>>>>>>>> I think this will try to invoke direct reclaim from the first iteration
>>>>>>>> to free up the max order.
>>>>>>> 
>>>>>>> %__GFP_NORETRY: The VM implementation will try only very lightweight
>>>>>>> memory direct reclaim to get some memory under memory pressure (thus it
>>>>>>> can sleep). It will avoid disruptive actions like OOM killer.
>>>>>>> 
>>>>>>> Certainly good enough for a first version I would say, no?
>>>>>> 
>>>>>> Frankly how well that behaves would depend a lot on the workload.
>>>>>> Can regress just as well.
>>>>>> 
>>>>>> For the 1st version I'd prefer something that is the least disruptive,
>>>>>> and that IMHO means we only trigger reclaim at all in the same configuration
>>>>>> as now - when we can't satisfy the lowest order allocation.
>>>>> 
>>>>> Agreed.
>>>>> 
>>>>>> Anything else would be a huge amount of testing with all kind of
>>>>>> workloads.
>>>>> 
>>>>> So doing a "& ~__GFP_RECLAIM" in case order > 0? (as done in
>>>>> GFP_TRANSHUGE_LIGHT)
>>>> 
>>>> That will improve the situation when reclaim is not needed, but leave
>>>> the problem in place for when it's needed: if reclaim does trigger, we
>>>> can get a huge free page and immediately break it up.
>>>> 
>>>> So it's ok as a first step but it will make the second step harder as
>>>> we'll need to test with reclaim :).
>>> 
>>> I expect the whole "steal huge pages from your guest" to be problematic,
>>> as I already mentioned to Alex. This needs a performance evaluation.
>>> 
>>> This all smells like a lot of workload dependent fine-tuning. :)
>> 
>> AFAIK the hardware overheads of keeping huge-pages in the guest and backing
>> them with 4KB pages are non-negligible. Did you take those into account?
> 
> Of course, the fastest mapping will be huge pages in host and guest.
> Having huge pages in your guest but not in your host cannot really be
> solved using ballooning AFAIKs. Hopefully THP in the host will be doing
> its job properly :)
> 
> ... however, so far, we haven't done any performance comparisons at all.
> The only numbers from Hui Zhu that I can spot are number of THP in the
> host, which is not really expressing actual guest performance IMHO. That
> definitely has to be done to evaluate the different optimizations we
> might want to try out.
> 

I did some tests with vm-scalability on Monday comparing their performance in VM:
//4 processes random r/w
usemem -R -a -Z  -n 4 1g

write:
hugepage: 146367 KB/s
thp:	  133550 KB/s
normal:   124248 KB/s

read:
hugepage: 103969 KB/s
thp:	  100622 KB/s
normal:   88755 KB/s

Best,
Hui


> -- 
> Thanks,
> 
> David / dhildenb

