Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B95A36C3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfH3M1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 08:27:30 -0400
Received: from foss.arm.com ([217.140.110.172]:59434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfH3M1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:27:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3637D337;
        Fri, 30 Aug 2019 05:27:29 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C18B3F246;
        Fri, 30 Aug 2019 05:27:28 -0700 (PDT)
Subject: Re: [PATCH] iommu/iova: avoid false sharing on fq_timer_on
To:     Joerg Roedel <jroedel@suse.de>, Eric Dumazet <edumazet@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jinyu Qi <jinyuqi@huawei.com>, Will Deacon <will@kernel.org>
References: <20190828131338.89832-1-edumazet@google.com>
 <20190830104925.GI17192@suse.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3ffd6989-229b-9c67-d9fb-7a8e413c1336@arm.com>
Date:   Fri, 30 Aug 2019 13:27:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190830104925.GI17192@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2019 11:49, Joerg Roedel wrote:
> Looks good to me, but adding Robin for his opinion.

Sounds reasonable to me too - that should also be true for the majority 
of Arm systems that we know of. Will suggested that atomic_try_cmpxchg() 
might be relevant, but AFAICS that's backwards compared to what we want 
to do here, which I guess is more of an "atomic_unlikely_cmpxchg".

Acked-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.

> On Wed, Aug 28, 2019 at 06:13:38AM -0700, Eric Dumazet wrote:
>> In commit 14bd9a607f90 ("iommu/iova: Separate atomic variables
>> to improve performance") Jinyu Qi identified that the atomic_cmpxchg()
>> in queue_iova() was causing a performance loss and moved critical fields
>> so that the false sharing would not impact them.
>>
>> However, avoiding the false sharing in the first place seems easy.
>> We should attempt the atomic_cmpxchg() no more than 100 times
>> per second. Adding an atomic_read() will keep the cache
>> line mostly shared.
>>
>> This false sharing came with commit 9a005a800ae8
>> ("iommu/iova: Add flush timer").
>>
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> Cc: Jinyu Qi <jinyuqi@huawei.com>
>> Cc: Joerg Roedel <jroedel@suse.de>
>> ---
>>   drivers/iommu/iova.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 3e1a8a6755723a927a7942a7429ab7e6c19a0027..41c605b0058f9615c2dbdd83f1de2404a9b1d255 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -577,7 +577,9 @@ void queue_iova(struct iova_domain *iovad,
>>   
>>   	spin_unlock_irqrestore(&fq->lock, flags);
>>   
>> -	if (atomic_cmpxchg(&iovad->fq_timer_on, 0, 1) == 0)
>> +	/* Avoid false sharing as much as possible. */
>> +	if (!atomic_read(&iovad->fq_timer_on) &&
>> +	    !atomic_cmpxchg(&iovad->fq_timer_on, 0, 1))
>>   		mod_timer(&iovad->fq_timer,
>>   			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
>>   }
>> -- 
>> 2.23.0.187.g17f5b7556c-goog
