Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D59AC585F1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 17:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfF0Pfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 11:35:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:48634 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfF0Pfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:35:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50103ABC4;
        Thu, 27 Jun 2019 15:35:40 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] mm: fix regression with deferred struct page
 init
To:     xen-devel@lists.xenproject.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, pasha.tatashin@soleen.com,
        rppt@linux.ibm.com
References: <20190620160821.4210-1-jgross@suse.com>
 <79797c17-58d6-b09c-3aad-73e375a7f208@suse.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <a9b02905-8b4f-48ac-8638-8ff99bd3b0e6@suse.com>
Date:   Thu, 27 Jun 2019 17:35:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <79797c17-58d6-b09c-3aad-73e375a7f208@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.19 10:25, Juergen Gross wrote:
> Gentle ping.
> 
> I'd really like to have that in 5.2 in order to avoid the regression
> introduced with 5.2-rc1.

Adding some maintainers directly...


Juergen

> 
> 
> Juergen
> 
> On 20.06.19 18:08, Juergen Gross wrote:
>> Commit 0e56acae4b4dd4a9 ("mm: initialize MAX_ORDER_NR_PAGES at a time
>> instead of doing larger sections") is causing a regression on some
>> systems when the kernel is booted as Xen dom0.
>>
>> The system will just hang in early boot.
>>
>> Reason is an endless loop in get_page_from_freelist() in case the first
>> zone looked at has no free memory. deferred_grow_zone() is always
>> returning true due to the following code snipplet:
>>
>>    /* If the zone is empty somebody else may have cleared out the zone */
>>    if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
>>                                             first_deferred_pfn)) {
>>            pgdat->first_deferred_pfn = ULONG_MAX;
>>            pgdat_resize_unlock(pgdat, &flags);
>>            return true;
>>    }
>>
>> This in turn results in the loop as get_page_from_freelist() is
>> assuming forward progress can be made by doing some more struct page
>> initialization.
>>
>> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> Fixes: 0e56acae4b4dd4a9 ("mm: initialize MAX_ORDER_NR_PAGES at a time 
>> instead of doing larger sections")
>> Suggested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>   mm/page_alloc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index d66bc8abe0af..8e3bc949ebcc 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1826,7 +1826,8 @@ deferred_grow_zone(struct zone *zone, unsigned 
>> int order)
>>                            first_deferred_pfn)) {
>>           pgdat->first_deferred_pfn = ULONG_MAX;
>>           pgdat_resize_unlock(pgdat, &flags);
>> -        return true;
>> +        /* Retry only once. */
>> +        return first_deferred_pfn != ULONG_MAX;
>>       }
>>       /*
>>
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel

