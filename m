Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D179FF98A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 19:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKLS34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 13:29:56 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:40889 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbfKLS34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:29:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0ThvJW5U_1573583388;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0ThvJW5U_1573583388)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Nov 2019 02:29:51 +0800
Subject: Re: [PATCH] mm: migrate: handle freed page at the first place
To:     Michal Hocko <mhocko@kernel.org>
Cc:     mgorman@techsingularity.net, vbabka@suse.cz,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1573510165-113395-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191112080401.GA2763@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <f9bca12a-58ff-1566-e9e6-a687d3ba14b9@linux.alibaba.com>
Date:   Tue, 12 Nov 2019 10:29:46 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191112080401.GA2763@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/19 12:04 AM, Michal Hocko wrote:
> On Tue 12-11-19 06:09:25, Yang Shi wrote:
>> When doing migration if the freed page is met, we just return without
>> migrating it since it is pointless to migrate a freed page.  But, the
>> current code did two things before handling freed page:
>>
>> 1. Return -ENOMEM if the page is THP and THP migration is not supported.
>> 2. Allocate target page unconditionally.
>>
>> Both makes not too much sense.  If we handle freed page at the first place
>> we don't have to worry about allocating/freeing target page and split
>> THP at all.
>>
>> For example (worst case) if we are trying to migrate a freed THP without
>> THP migration supported, the migrate_pages() would just split the THP then
>> retry to migrate base pages one by one by pointless allocating and freeing
>> pages, this is just waste of time.
>>
>> I didn't run into any actual problem with the current code (or I may
>> just not notice it yet), it was found by visual inspection.
> It would be preferable to accompany a change like this with some actual
> numbers. A race with page freeing should be a very rare situation. Maybe
> it is not under some workloads but that would better be checked and
> documented. I also do not like to do page state changes for THP
> migration without a support. I cannot really say this is 100% correct

However that THP will not be migrated actually, just will be freed by 
put_page().

> from top of my head and I do not see a sufficient justification to go
> and chase all those tiny details because that is time consuming.
>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>>   mm/migrate.c | 18 +++++++-----------
>>   1 file changed, 7 insertions(+), 11 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 4fe45d1..ef96997 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1170,13 +1170,6 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>>   	int rc = MIGRATEPAGE_SUCCESS;
>>   	struct page *newpage;
>>   
>> -	if (!thp_migration_supported() && PageTransHuge(page))
>> -		return -ENOMEM;
>> -
>> -	newpage = get_new_page(page, private);
>> -	if (!newpage)
>> -		return -ENOMEM;
>> -
>>   	if (page_count(page) == 1) {
>>   		/* page was freed from under us. So we are done. */
>>   		ClearPageActive(page);
>> @@ -1187,13 +1180,16 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>>   				__ClearPageIsolated(page);
>>   			unlock_page(page);
>>   		}
>> -		if (put_new_page)
>> -			put_new_page(newpage, private);
>> -		else
>> -			put_page(newpage);
>>   		goto out;
>>   	}
>>   
>> +	if (!thp_migration_supported() && PageTransHuge(page))
>> +		return -ENOMEM;
>> +
>> +	newpage = get_new_page(page, private);
>> +	if (!newpage)
>> +		return -ENOMEM;
>> +
>>   	rc = __unmap_and_move(page, newpage, force, mode);
>>   	if (rc == MIGRATEPAGE_SUCCESS)
>>   		set_page_owner_migrate_reason(newpage, reason);
>> -- 
>> 1.8.3.1
>>

