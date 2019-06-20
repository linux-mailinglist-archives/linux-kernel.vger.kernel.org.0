Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A144D1F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 17:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbfFTPUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 11:20:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:39046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726654AbfFTPUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:20:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1D804AE46;
        Thu, 20 Jun 2019 15:20:10 +0000 (UTC)
Subject: Re: [PATCH RFC] mm: fix regression with deferred struct page init
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        xen-devel@lists.xenproject.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190620094015.21206-1-jgross@suse.com>
 <d11cf6a9ac9f2f21b6102464bf80925ada02bc78.camel@linux.intel.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <0fae5789-3859-d49f-6c4c-2bde09dc3307@suse.com>
Date:   Thu, 20 Jun 2019 17:20:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d11cf6a9ac9f2f21b6102464bf80925ada02bc78.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.19 17:17, Alexander Duyck wrote:
> On Thu, 2019-06-20 at 11:40 +0200, Juergen Gross wrote:
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
>>    /* If the zone is empty somebody else may have cleared out the zone */
>>    if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
>>                                             first_deferred_pfn)) {
>>            pgdat->first_deferred_pfn = ULONG_MAX;
>>            pgdat_resize_unlock(pgdat, &flags);
>>            return true;
>>    }
>>
>> This in turn results in the loop as get_page_from_freelist() is
>> assuming forward progress can be made by doing some more struct page
>> initialization.
>>
>> Fixes: 0e56acae4b4dd4a9 ("mm: initialize MAX_ORDER_NR_PAGES at a time instead of doing larger sections")
>> ---
>> This patch makes my system boot again as Xen dom0, but I'm not really
>> sure it is the correct way to do it, hence the RFC.
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>   mm/page_alloc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index d66bc8abe0af..6ee754b5cd92 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1826,7 +1826,7 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
>>   						 first_deferred_pfn)) {
>>   		pgdat->first_deferred_pfn = ULONG_MAX;
>>   		pgdat_resize_unlock(pgdat, &flags);
>> -		return true;
>> +		return false;
>>   	}
>>   
>>   	/*
> 
> The one change I might make to this would be to do:
> 	return first_deferred_pfn != ULONG_MAX;
> 
> That way in the event the previous caller did free up the last of the
> pages and empty the zone just before we got here then we will try one more
> time. Otherwise if it was already done before we got here we exit.

Thanks for the constructive feedback!

Will send a non-RFC variant soon.


Juergen

