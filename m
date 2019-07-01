Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5574D290A3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 08:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbfEXGAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 02:00:08 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41636 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725886AbfEXGAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:00:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TSXfk8M_1558677600;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TSXfk8M_1558677600)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 May 2019 14:00:01 +0800
Subject: Re: [v4 PATCH 2/2] mm: vmscan: correct some vmscan counters for
To:     Hillf Danton <hdanton@sina.com>
Cc:     ying.huang@intel.com, hannes@cmpxchg.org, mhocko@suse.com,
        mgorman@techsingularity.net, kirill.shutemov@linux.intel.com,
        josef@toxicpanda.com, hughd@google.com, shakeelb@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190524055125.3036-1-hdanton@sina.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <fbc9a823-7e6a-f923-92e1-c7e93a256aff@linux.alibaba.com>
Date:   Fri, 24 May 2019 14:00:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190524055125.3036-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/19 1:51 PM, Hillf Danton wrote:
> On Fri, 24 May 2019 09:27:02 +0800 Yang Shi wrote:
>> On 5/23/19 11:51 PM, Hillf Danton wrote:
>>> On Thu, 23 May 2019 10:27:38 +0800 Yang Shi wrote:
>>>> @ -1642,14 +1650,14 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>>>>    	unsigned long nr_zone_taken[MAX_NR_ZONES] = { 0 };
>>>>    	unsigned long nr_skipped[MAX_NR_ZONES] = { 0, };
>>>>    	unsigned long skipped = 0;
>>>> -	unsigned long scan, total_scan, nr_pages;
>>>> +	unsigned long scan, total_scan;
>>>> +	unsigned long nr_pages;
>>> Change for no earn:)
>> Aha, yes.
>>
>>>>    	LIST_HEAD(pages_skipped);
>>>>    	isolate_mode_t mode = (sc->may_unmap ? 0 : ISOLATE_UNMAPPED);
>>>> +	total_scan = 0;
>>>>    	scan = 0;
>>>> -	for (total_scan = 0;
>>>> -	     scan < nr_to_scan && nr_taken < nr_to_scan && !list_empty(src);
>>>> -	     total_scan++) {
>>>> +	while (scan < nr_to_scan && !list_empty(src)) {
>>>>    		struct page *page;
>>> AFAICS scan currently prevents us from looping for ever, while nr_taken bails
>>> us out once we get what's expected, so I doubt it makes much sense to cut
>>> nr_taken off.
>> It is because "scan < nr_to_scan && nr_taken >= nr_to_scan" is
>> impossible now with the units fixed.
>>
> With the units fixed, nr_taken is no longer checked.

It is because scan would be always >= nr_taken.

>
>>>>    		page = lru_to_page(src);
>>>> @@ -1657,9 +1665,12 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>>>>    		VM_BUG_ON_PAGE(!PageLRU(page), page);
>>>> +		nr_pages = 1 << compound_order(page);
>>>> +		total_scan += nr_pages;
>>>> +
>>>>    		if (page_zonenum(page) > sc->reclaim_idx) {
>>>>    			list_move(&page->lru, &pages_skipped);
>>>> -			nr_skipped[page_zonenum(page)]++;
>>>> +			nr_skipped[page_zonenum(page)] += nr_pages;
>>>>    			continue;
>>>>    		}
>>>> @@ -1669,10 +1680,9 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>>>>    		 * ineligible pages.  This causes the VM to not reclaim any
>>>>    		 * pages, triggering a premature OOM.
>>>>    		 */
>>>> -		scan++;
>>>> +		scan += nr_pages;
>>> The comment looks to defy the change if we fail to add a huge page to
>>> the dst list; otherwise nr_taken knows how to do the right thing. What
>>> I prefer is to let scan to do one thing a time.
>> I don't get your point. Do you mean the comment "Do not count skipped
>> pages because that makes the function return with no isolated pages if
>> the LRU mostly contains ineligible pages."? I'm supposed the comment is
>> used to explain why not count skipped page.
>>
> Well consider the case where there is a huge page in the second place
> reversely on the src list along with other 20 regular pages, and we are
> not able to add the huge page to the dst list. Currently we can go on and
> try to scan other pages, provided nr_to_scan is 32; with the units fixed,
> however, scan goes over nr_to_scan, leaving us no chance to scan any page
> that may be not busy. I wonder that triggers a premature OOM, because I
> think scan means the number of list nodes we try to isolate, and
> nr_taken the number of regular pages successfully isolated.

Yes, good point. I think I just need roll back to what v3 did here to 
get scan accounted for each case separately to avoid the possible 
over-account.

>>>>    		switch (__isolate_lru_page(page, mode)) {
>>>>    		case 0:
>>>> -			nr_pages = hpage_nr_pages(page);
>>>>    			nr_taken += nr_pages;
>>>>    			nr_zone_taken[page_zonenum(page)] += nr_pages;
>>>>    			list_move(&page->lru, dst);
>>>> --
>>>> 1.8.3.1
> Best Regards
> Hillf

