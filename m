Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 565C96ADA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 19:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388267AbfGPR3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 13:29:18 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:47586 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728124AbfGPR3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:29:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TX4BEhE_1563298132;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TX4BEhE_1563298132)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Jul 2019 01:28:55 +0800
Subject: Re: [v2 PATCH 2/2] mm: mempolicy: handle vma with unmovable pages
 mapped correctly in mbind
To:     Vlastimil Babka <vbabka@suse.cz>, mhocko@kernel.org,
        mgorman@techsingularity.net, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1561162809-59140-1-git-send-email-yang.shi@linux.alibaba.com>
 <1561162809-59140-3-git-send-email-yang.shi@linux.alibaba.com>
 <0cbc99f6-76a9-7357-efa7-a2d551b3cd12@suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <9defdc16-c825-05b7-b394-abdf39000220@linux.alibaba.com>
Date:   Tue, 16 Jul 2019 10:28:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0cbc99f6-76a9-7357-efa7-a2d551b3cd12@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/19 5:07 AM, Vlastimil Babka wrote:
> On 6/22/19 2:20 AM, Yang Shi wrote:
>> @@ -969,10 +975,21 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
>>   /*
>>    * page migration, thp tail pages can be passed.
>>    */
>> -static void migrate_page_add(struct page *page, struct list_head *pagelist,
>> +static int migrate_page_add(struct page *page, struct list_head *pagelist,
>>   				unsigned long flags)
>>   {
>>   	struct page *head = compound_head(page);
>> +
>> +	/*
>> +	 * Non-movable page may reach here.  And, there may be
>> +	 * temporaty off LRU pages or non-LRU movable pages.
>> +	 * Treat them as unmovable pages since they can't be
>> +	 * isolated, so they can't be moved at the moment.  It
>> +	 * should return -EIO for this case too.
>> +	 */
>> +	if (!PageLRU(head) && (flags & MPOL_MF_STRICT))
>> +		return -EIO;
>> +
> Hm but !PageLRU() is not the only way why queueing for migration can
> fail, as can be seen from the rest of the function. Shouldn't all cases
> be reported?

Do you mean the shared pages and isolation failed pages? I'm not sure 
whether we should consider these cases break the semantics or not, so I 
leave them as they are. But, strictly speaking they should be reported 
too, at least for the isolation failed page.

Thanks,
Yang

>
>>   	/*
>>   	 * Avoid migrating a page that is shared with others.
>>   	 */
>> @@ -984,6 +1001,8 @@ static void migrate_page_add(struct page *page, struct list_head *pagelist,
>>   				hpage_nr_pages(head));
>>   		}
>>   	}
>> +
>> +	return 0;
>>   }
>>   
>>   /* page allocation callback for NUMA node migration */
>> @@ -1186,9 +1205,10 @@ static struct page *new_page(struct page *page, unsigned long start)
>>   }
>>   #else
>>   
>> -static void migrate_page_add(struct page *page, struct list_head *pagelist,
>> +static int migrate_page_add(struct page *page, struct list_head *pagelist,
>>   				unsigned long flags)
>>   {
>> +	return -EIO;
>>   }
>>   
>>   int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
>>

