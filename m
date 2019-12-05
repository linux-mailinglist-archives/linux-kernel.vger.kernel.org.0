Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7785114555
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 18:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfLERFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 12:05:22 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:56397 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729793AbfLERFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:05:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tk3Ek6d_1575565511;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tk3Ek6d_1575565511)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Dec 2019 01:05:15 +0800
Subject: Re: [PATCH] mm: vmscan: protect shrinker idr replace with
 CONFIG_MEMCG
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     hannes@cmpxchg.org, shakeelb@google.com, guro@fb.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1575486978-45249-1-git-send-email-yang.shi@linux.alibaba.com>
 <e320f8af-c164-ce5e-8964-8785b0bf5f2e@virtuozzo.com>
 <20191205094341.GC28317@dhcp22.suse.cz>
 <894b9951-449d-6d7e-84aa-a1c510417710@virtuozzo.com>
 <80918583-da44-71f0-8c94-224a3268577c@virtuozzo.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <fd5f02e0-5d81-7d14-b821-aa39ea05d385@linux.alibaba.com>
Date:   Thu, 5 Dec 2019 09:05:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <80918583-da44-71f0-8c94-224a3268577c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/19 2:11 AM, Kirill Tkhai wrote:
> On 05.12.2019 13:00, Kirill Tkhai wrote:
>> On 05.12.2019 12:43, Michal Hocko wrote:
>>> On Thu 05-12-19 11:23:28, Kirill Tkhai wrote:
>>>> On 04.12.2019 22:16, Yang Shi wrote:
>>>>> Since commit 0a432dcbeb32edcd211a5d8f7847d0da7642a8b4 ("mm: shrinker:
>>>>> make shrinker not depend on memcg kmem"), shrinkers' idr is protected by
>>>>> CONFIG_MEMCG instead of CONFIG_MEMCG_KMEM, so it makes no sense to
>>>>> protect shrinker idr replace with CONFIG_MEMCG_KMEM.
>>>>>
>>>>> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
>>>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>>>> Cc: Michal Hocko <mhocko@suse.com>
>>>>> Cc: Shakeel Butt <shakeelb@google.com>
>>>>> Cc: Roman Gushchin <guro@fb.com>
>>>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>>>> It looks like that in CONFIG_SLOB case we do not even call some shrinkers
>>>> for subordinate mem cgroups (i.e., we don't call deferred_split_shrinker),
>>>> since they never become completely registered.
>>>>
>>>> Fixes: 0a432dcbeb32edcd211a5d8f7847d0da7642a8b4 ("mm: shrinker: make shrinker not depend on memcg kmem")
>>> I am confused. Why the Fixes tag? Nothing should be really broken with
>>> KMEM config guard right?
>> idr_replace() is disabled in CONFIG_MEMCG && CONFIG_SLOB case, and this is
>> wrong.
>>
>> 0a432dcbeb32edcd211a5d8f7847d0da7642a8b4 goes in the series, which enables
>> shrinker_idr infrastructure for huge_memory.c's deferred_split_shrinker
>> in CONFIG_MEMCG case. Previously, all SHRINKER_MEMCG_AWARE shrinkers were
>> based on LRUs, and they remain to base of CONFIG_MEMCG_KMEM.
>> But deferred_split_shrinker is an exception.
>>
>> In CONFIG_MEMCG && CONFIG_SLOB case, shrinker_idr contains only shrinker,
>> and it is deferred_split_shrinker. But it is never actually called, since
>> idr_replace() is never compiled. deferred_split_shrinker all the time is
>> staying in half-registered state, and it's never called for subordinate
>> mem cgroups.
>>
>> So, this is a BUG, and this should go to stable.
> The visible effect is that deferred_split_shrinker is never called
> from shrink_slab() for subordinate mem cgroups. It's called only
> for root_mem_cgroup.

Thanks for noticing the SLOB case, I didn't realize it and thought it 
was just a cleanup too.

Will update the information and cc to stable list for v2.

>
>>> This is a mere clean up AFAICS.
>>>
>>>> Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>>>>
>>>>> ---
>>>>>   mm/vmscan.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>> index ee4eecc..e7f10c4 100644
>>>>> --- a/mm/vmscan.c
>>>>> +++ b/mm/vmscan.c
>>>>> @@ -422,7 +422,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
>>>>>   {
>>>>>   	down_write(&shrinker_rwsem);
>>>>>   	list_add_tail(&shrinker->list, &shrinker_list);
>>>>> -#ifdef CONFIG_MEMCG_KMEM
>>>>> +#ifdef CONFIG_MEMCG
>>>>>   	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>>>>>   		idr_replace(&shrinker_idr, shrinker, shrinker->id);
>>>>>   #endif
>>>>>

