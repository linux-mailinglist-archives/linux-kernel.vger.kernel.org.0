Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D93105297
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 14:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKUNEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 08:04:00 -0500
Received: from relay.sw.ru ([185.231.240.75]:52106 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUND7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:03:59 -0500
Received: from dhcp-172-16-25-5.sw.ru ([172.16.25.5])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iXm7i-0002DQ-S4; Thu, 21 Nov 2019 16:03:50 +0300
Subject: Re: [PATCH v4 1/2] kasan: detect negative size in memory operation
 function
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
References: <20191112065302.7015-1-walter-zh.wu@mediatek.com>
 <040479c3-6f96-91c6-1b1a-9f3e947dac06@virtuozzo.com>
 <1574341376.8338.4.camel@mtksdccf07>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <217bd537-e6b7-3acc-b6bb-ac9c5d94da89@virtuozzo.com>
Date:   Thu, 21 Nov 2019 16:03:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1574341376.8338.4.camel@mtksdccf07>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/19 4:02 PM, Walter Wu wrote:
> On Thu, 2019-11-21 at 15:26 +0300, Andrey Ryabinin wrote:
>>
>> On 11/12/19 9:53 AM, Walter Wu wrote:
>>
>>> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
>>> index 6814d6d6a023..4bfce0af881f 100644
>>> --- a/mm/kasan/common.c
>>> +++ b/mm/kasan/common.c
>>> @@ -102,7 +102,8 @@ EXPORT_SYMBOL(__kasan_check_write);
>>>  #undef memset
>>>  void *memset(void *addr, int c, size_t len)
>>>  {
>>> -	check_memory_region((unsigned long)addr, len, true, _RET_IP_);
>>> +	if (!check_memory_region((unsigned long)addr, len, true, _RET_IP_))
>>> +		return NULL;
>>>  
>>>  	return __memset(addr, c, len);
>>>  }
>>> @@ -110,8 +111,9 @@ void *memset(void *addr, int c, size_t len)
>>>  #undef memmove
>>>  void *memmove(void *dest, const void *src, size_t len)
>>>  {
>>> -	check_memory_region((unsigned long)src, len, false, _RET_IP_);
>>> -	check_memory_region((unsigned long)dest, len, true, _RET_IP_);
>>> +	if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
>>> +	    !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
>>> +		return NULL;
>>>  
>>>  	return __memmove(dest, src, len);
>>>  }
>>> @@ -119,8 +121,9 @@ void *memmove(void *dest, const void *src, size_t len)
>>>  #undef memcpy
>>>  void *memcpy(void *dest, const void *src, size_t len)
>>>  {
>>> -	check_memory_region((unsigned long)src, len, false, _RET_IP_);
>>> -	check_memory_region((unsigned long)dest, len, true, _RET_IP_);
>>> +	if (!check_memory_region((unsigned long)src, len, false, _RET_IP_) ||
>>> +	    !check_memory_region((unsigned long)dest, len, true, _RET_IP_))
>>> +		return NULL;
>>>  
>>
>> I realized that we are going a wrong direction here. Entirely skipping mem*() operation on any
>> poisoned shadow value might only make things worse. Some bugs just don't have any serious consequences,
>> but skipping the mem*() ops entirely might introduce such consequences, which wouldn't happen otherwise.
>>
>> So let's keep this code as this, no need to check the result of check_memory_region().
>>
>>
> Ok, we just need to determine whether size is negative number. If yes
> then KASAN produce report and continue to execute mem*(). right?
> 

Yes.
