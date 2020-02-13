Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F54B15B79C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 04:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgBMDOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 22:14:35 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:43817 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729378AbgBMDOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 22:14:34 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TprWUQG_1581563668;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TprWUQG_1581563668)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Feb 2020 11:14:30 +0800
Subject: Re: [PATCH 1/2] mm: vmpressure: don't need call kfree if kstrndup
 fails
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1581398649-125989-1-git-send-email-yang.shi@linux.alibaba.com>
 <b47f8f37-fbde-5487-5025-fcb0df7a7e30@redhat.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <48d53caf-4b89-69c3-cf9b-47b8627db0bd@linux.alibaba.com>
Date:   Wed, 12 Feb 2020 19:14:27 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b47f8f37-fbde-5487-5025-fcb0df7a7e30@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/20 3:21 AM, David Hildenbrand wrote:
> On 11.02.20 06:24, Yang Shi wrote:
>> When kstrndup fails (returns NULL) there is no memory is allocated by
>> kmalloc, so no need to call kfree().
> "When kstrndup fails, no memory was allocated and we can exit directly."

Thanks for correcting the commit log.

Andrew, do you prefer I send an updated version or you would just update 
the patch in -mm tree?

>
> Reviewed-by: David Hildenbrand <david@redhat.com>
>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>>   mm/vmpressure.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/vmpressure.c b/mm/vmpressure.c
>> index 4bac22f..0590f00 100644
>> --- a/mm/vmpressure.c
>> +++ b/mm/vmpressure.c
>> @@ -371,10 +371,8 @@ int vmpressure_register_event(struct mem_cgroup *memcg,
>>   	int ret = 0;
>>   
>>   	spec_orig = spec = kstrndup(args, MAX_VMPRESSURE_ARGS_LEN, GFP_KERNEL);
>> -	if (!spec) {
>> -		ret = -ENOMEM;
>> -		goto out;
>> -	}
>> +	if (!spec)
>> +		return -ENOMEM;
>>   
>>   	/* Find required level */
>>   	token = strsep(&spec, ",");
>>
>

