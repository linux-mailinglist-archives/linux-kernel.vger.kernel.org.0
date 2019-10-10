Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94614D2231
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 09:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbfJJH6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 03:58:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17291 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733062AbfJJH6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:58:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CEE63069609;
        Thu, 10 Oct 2019 07:58:43 +0000 (UTC)
Received: from [10.36.117.125] (ovpn-117-125.ams2.redhat.com [10.36.117.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95BB51001DDE;
        Thu, 10 Oct 2019 07:58:41 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] mm/memory-failure.c: Don't access uninitialized
 memmaps in memory_failure()
From:   David Hildenbrand <david@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191009142435.3975-1-david@redhat.com>
 <20191009142435.3975-3-david@redhat.com>
 <20191009144323.GH6681@dhcp22.suse.cz>
 <5a626821-77e9-e26b-c2ee-219670283bf0@redhat.com>
 <20191010073526.GC18412@dhcp22.suse.cz>
 <18383432-c74a-9ce5-a3c6-1e57d54cb629@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <52e81b85-c460-5b99-a297-e065caab3a16@redhat.com>
Date:   Thu, 10 Oct 2019 09:58:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <18383432-c74a-9ce5-a3c6-1e57d54cb629@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 10 Oct 2019 07:58:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.10.19 09:52, David Hildenbrand wrote:
> On 10.10.19 09:35, Michal Hocko wrote:
>> On Thu 10-10-19 09:27:32, David Hildenbrand wrote:
>>> On 09.10.19 16:43, Michal Hocko wrote:
>>>> On Wed 09-10-19 16:24:35, David Hildenbrand wrote:
>>>>> We should check for pfn_to_online_page() to not access uninitialized
>>>>> memmaps. Reshuffle the code so we don't have to duplicate the error
>>>>> message.
>>>>>
>>>>> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>> Cc: Michal Hocko <mhocko@kernel.org>
>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>> ---
>>>>>  mm/memory-failure.c | 14 ++++++++------
>>>>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>>> index 7ef849da8278..e866e6e5660b 100644
>>>>> --- a/mm/memory-failure.c
>>>>> +++ b/mm/memory-failure.c
>>>>> @@ -1253,17 +1253,19 @@ int memory_failure(unsigned long pfn, int flags)
>>>>>  	if (!sysctl_memory_failure_recovery)
>>>>>  		panic("Memory failure on page %lx", pfn);
>>>>>  
>>>>> -	if (!pfn_valid(pfn)) {
>>>>> +	p = pfn_to_online_page(pfn);
>>>>> +	if (!p) {
>>>>> +		if (pfn_valid(pfn)) {
>>>>> +			pgmap = get_dev_pagemap(pfn, NULL);
>>>>> +			if (pgmap)
>>>>> +				return memory_failure_dev_pagemap(pfn, flags,
>>>>> +								  pgmap);
>>>>> +		}
>>>>>  		pr_err("Memory failure: %#lx: memory outside kernel control\n",
>>>>>  			pfn);
>>>>>  		return -ENXIO;
>>>>
>>>> Don't we need that earlier at hwpoison_inject level?
>>>>
>>>
>>> Theoretically yes, this is another instance. But pfn_to_online_page(pfn)
>>> alone would not be sufficient as discussed. We would, again, have to
>>> special-case ZONE_DEVICE via things like get_dev_pagemap() ...
>>>
>>> But mm/hwpoison-inject.c:hwpoison_inject() is a pure debug feature either way:
>>>
>>> 	/*
>>> 	 * Note that the below poison/unpoison interfaces do not involve
>>> 	 * hardware status change, hence do not require hardware support.
>>> 	 * They are mainly for testing hwpoison in software level.
>>> 	 */
>>>
>>> So it's not that bad compared to memory_failure() called from real HW or
>>> drivers/base/memory.c:soft_offline_page_store()/hard_offline_page_store()
>>
>> Yes, this is just a toy. And yes we need to handle zone device pages
>> here because a) people likely want to test MCE behavior even on these
>> pages and b) HW can really trigger MCEs there as well. I was just
>> pointing that the patch is likely incomplete.
>>
> 
> I rather think this deserves a separate patch as it is a separate
> interface :)
> 
> I do wonder why hwpoison_inject() has to perform so much extra work
> compared to other memory_failure() users. This smells like legacy
> leftovers to me, but I might be wrong. The interface is fairly old,
> though. Does anybody know why we need this magic? I can spot quite some
> duplicate checks/things getting performed.
> 
> Naiive me would just make the interface perform the same as
> hard_offline_page_store(). But most probably I am not getting the real
> purpose of both different interfaces.
> 
> HWPOISON_INJECT is only selected for DEBUG_KERNEL, so I would have
> guessed that fixing this is not urgent.
> 
> BTW: mm/memory-failure.c:soft_offline_page() also looks wrong and needs
> fixing to make sure we access initialized memmaps.
> 

To be more precise, soft_offline_page_store() needs a
pfn_to_online_page() check. Will send a patch.

-- 

Thanks,

David / dhildenb
