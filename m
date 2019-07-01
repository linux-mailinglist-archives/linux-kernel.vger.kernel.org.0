Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E55925C24
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 05:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfEVDZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 23:25:18 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:52664 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727733AbfEVDZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 23:25:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TSM7IGo_1558495511;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TSM7IGo_1558495511)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 May 2019 11:25:12 +0800
Subject: Re: [v3 PATCH 2/2] mm: vmscan: correct some vmscan counters for THP
 swapout
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     ying.huang@intel.com, mhocko@suse.com, mgorman@techsingularity.net,
        kirill.shutemov@linux.intel.com, josef@toxicpanda.com,
        hughd@google.com, shakeelb@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1558431642-52120-1-git-send-email-yang.shi@linux.alibaba.com>
 <1558431642-52120-2-git-send-email-yang.shi@linux.alibaba.com>
 <20190521160038.GB3687@cmpxchg.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <b3970971-1f2c-3c9b-d0e3-008f57c45b74@linux.alibaba.com>
Date:   Wed, 22 May 2019 11:25:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190521160038.GB3687@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/19 12:00 AM, Johannes Weiner wrote:
> On Tue, May 21, 2019 at 05:40:42PM +0800, Yang Shi wrote:
>> Since commit bd4c82c22c36 ("mm, THP, swap: delay splitting THP after
>> swapped out"), THP can be swapped out in a whole.  But, nr_reclaimed
>> and some other vm counters still get inc'ed by one even though a whole
>> THP (512 pages) gets swapped out.
>>
>> This doesn't make too much sense to memory reclaim.  For example, direct
>> reclaim may just need reclaim SWAP_CLUSTER_MAX pages, reclaiming one THP
>> could fulfill it.  But, if nr_reclaimed is not increased correctly,
>> direct reclaim may just waste time to reclaim more pages,
>> SWAP_CLUSTER_MAX * 512 pages in worst case.
>>
>> And, it may cause pgsteal_{kswapd|direct} is greater than
>> pgscan_{kswapd|direct}, like the below:
>>
>> pgsteal_kswapd 122933
>> pgsteal_direct 26600225
>> pgscan_kswapd 174153
>> pgscan_direct 14678312
>>
>> nr_reclaimed and nr_scanned must be fixed in parallel otherwise it would
>> break some page reclaim logic, e.g.
>>
>> vmpressure: this looks at the scanned/reclaimed ratio so it won't
>> change semantics as long as scanned & reclaimed are fixed in parallel.
>>
>> compaction/reclaim: compaction wants a certain number of physical pages
>> freed up before going back to compacting.
>>
>> kswapd priority raising: kswapd raises priority if we scan fewer pages
>> than the reclaim target (which itself is obviously expressed in order-0
>> pages). As a result, kswapd can falsely raise its aggressiveness even
>> when it's making great progress.
>>
>> Other than nr_scanned and nr_reclaimed, some other counters, e.g.
>> pgactivate, nr_skipped, nr_ref_keep and nr_unmap_fail need to be fixed
>> too since they are user visible via cgroup, /proc/vmstat or trace
>> points, otherwise they would be underreported.
>>
>> When isolating pages from LRUs, nr_taken has been accounted in base
>> page, but nr_scanned and nr_skipped are still accounted in THP.  It
>> doesn't make too much sense too since this may cause trace point
>> underreport the numbers as well.
>>
>> So accounting those counters in base page instead of accounting THP as
>> one page.
>>
>> This change may result in lower steal/scan ratio in some cases since
>> THP may get split during page reclaim, then a part of tail pages get
>> reclaimed instead of the whole 512 pages, but nr_scanned is accounted
>> by 512, particularly for direct reclaim.  But, this should be not a
>> significant issue.
>>
>> Cc: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Shakeel Butt <shakeelb@google.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>> v3: Removed Shakeel's Reviewed-by since the patch has been changed significantly
>>      Switched back to use compound_order per Matthew
>>      Fixed more counters per Johannes
>> v2: Added Shakeel's Reviewed-by
>>      Use hpage_nr_pages instead of compound_order per Huang Ying and William Kucharski
>>
>>   mm/vmscan.c | 40 ++++++++++++++++++++++++++++------------
>>   1 file changed, 28 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index b65bc50..1044834 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1250,7 +1250,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>   		case PAGEREF_ACTIVATE:
>>   			goto activate_locked;
>>   		case PAGEREF_KEEP:
>> -			stat->nr_ref_keep++;
>> +			stat->nr_ref_keep += (1 << compound_order(page));
>>   			goto keep_locked;
>>   		case PAGEREF_RECLAIM:
>>   		case PAGEREF_RECLAIM_CLEAN:
>> @@ -1294,6 +1294,17 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>   						goto activate_locked;
>>   				}
>>   
>> +				/*
>> +				 * Account all tail pages when THP is added
>> +				 * into swap cache successfully.
>> +				 * The head page has been accounted at the
>> +				 * first place.
>> +				 */
>> +				if (PageTransHuge(page))
>> +					sc->nr_scanned +=
>> +						((1 << compound_order(page)) -
>> +							1);
>> +
>>   				may_enter_fs = 1;
> Even if we don't split and reclaim the page, we should always account
> the number of base pages in nr_scanned. Otherwise it's not clear what
> nr_scanned means.

Sure.

>
>>   				/* Adding to swap updated mapping */
>> @@ -1315,7 +1326,8 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>   			if (unlikely(PageTransHuge(page)))
>>   				flags |= TTU_SPLIT_HUGE_PMD;
>>   			if (!try_to_unmap(page, flags)) {
>> -				stat->nr_unmap_fail++;
>> +				stat->nr_unmap_fail +=
>> +					(1 << compound_order(page));
>>   				goto activate_locked;
>>   			}
>>   		}
>> @@ -1442,7 +1454,11 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>   
>>   		unlock_page(page);
>>   free_it:
>> -		nr_reclaimed++;
>> +		/*
>> +		 * THP may get swapped out in a whole, need account
>> +		 * all base pages.
>> +		 */
>> +		nr_reclaimed += (1 << compound_order(page));
> This expression is quite repetitive. Why not do
>
> 		int nr_pages;
>
> 		page = lru_to_page(page_list);
> 		nr_pages = 1 << compound_order(page);
> 		list_del(&page->lru);
>
> 		if (!trylock_page(page))
> 			...
>
> at the head of the loop and add nr_pages to all these counters
> instead?

Because it is unknown whether the THP will be swapped out as a whole or 
will be split at this point. nr_scanned is fine, but nr_reclaimed is not.

>
>> @@ -1642,14 +1659,12 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>>   	unsigned long nr_zone_taken[MAX_NR_ZONES] = { 0 };
>>   	unsigned long nr_skipped[MAX_NR_ZONES] = { 0, };
>>   	unsigned long skipped = 0;
>> -	unsigned long scan, total_scan, nr_pages;
>> +	unsigned long scan, nr_pages;
>>   	LIST_HEAD(pages_skipped);
>>   	isolate_mode_t mode = (sc->may_unmap ? 0 : ISOLATE_UNMAPPED);
>>   
>>   	scan = 0;
>> -	for (total_scan = 0;
>> -	     scan < nr_to_scan && nr_taken < nr_to_scan && !list_empty(src);
>> -	     total_scan++) {
>> +	while (scan < nr_to_scan && nr_taken < nr_to_scan && !list_empty(src)) {
>>   		struct page *page;
> Once you fixed the units, scan < nr_to_scan && nr_taken >= nr_to_scan
> is an impossible condition. You should be able to write:
>
> 	while (scan < nr_to_scan && !list_empty(src))

Yes.

>
> Also, you need to keep total_scan. The trace point wants to know how
> many pages were actually looked at, including the ones from ineligible
> zones that were skipped over.

Aha, yes. The total_scan includes both scanned and skipped. Will fix in v4.

>
>>   
>>   		page = lru_to_page(src);
>> @@ -1659,7 +1674,8 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>>   
>>   		if (page_zonenum(page) > sc->reclaim_idx) {
>>   			list_move(&page->lru, &pages_skipped);
>> -			nr_skipped[page_zonenum(page)]++;
>> +			nr_skipped[page_zonenum(page)] +=
>> +				(1 << compound_order(page));
>>   			continue;
>>   		}
>>   
>> @@ -1669,7 +1685,7 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>>   		 * ineligible pages.  This causes the VM to not reclaim any
>>   		 * pages, triggering a premature OOM.
>>   		 */
>> -		scan++;
>> +		scan += (1 << compound_order(page));
>>   		switch (__isolate_lru_page(page, mode)) {
>>   		case 0:
>>   			nr_pages = hpage_nr_pages(page);
> Same here, you can calculate nr_pages at the top of the loop and use
> it throughout.

Yes. Will fix in v4.

>
>> @@ -1707,9 +1723,9 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>>   			skipped += nr_skipped[zid];
>>   		}
>>   	}
>> -	*nr_scanned = total_scan;
>> +	*nr_scanned = scan;
>>   	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, nr_to_scan,
>> -				    total_scan, skipped, nr_taken, mode, lru);
>> +				    scan, skipped, nr_taken, mode, lru);
>>   	update_lru_sizes(lruvec, lru, nr_zone_taken);
>>   	return nr_taken;
>>   }
>> -- 
>> 1.8.3.1
>>

