Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3726B2AD0E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 04:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfE0CsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 May 2019 22:48:00 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:44515 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725923AbfE0Cr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 22:47:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TSlJH2R_1558925274;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TSlJH2R_1558925274)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 May 2019 10:47:55 +0800
Subject: Re: [RESEND v5 PATCH 2/2] mm: vmscan: correct some vmscan counters
 for THP swapout
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     hannes@cmpxchg.org, mhocko@suse.com, mgorman@techsingularity.net,
        kirill.shutemov@linux.intel.com, josef@toxicpanda.com,
        hughd@google.com, shakeelb@google.com, hdanton@sina.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1558922275-31782-1-git-send-email-yang.shi@linux.alibaba.com>
 <1558922275-31782-2-git-send-email-yang.shi@linux.alibaba.com>
 <87muj88x3p.fsf@yhuang-dev.intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <a32dbca4-6239-828b-9f81-f24d582ddd75@linux.alibaba.com>
Date:   Mon, 27 May 2019 10:47:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87muj88x3p.fsf@yhuang-dev.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/27/19 10:11 AM, Huang, Ying wrote:
> Yang Shi <yang.shi@linux.alibaba.com> writes:
>
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
>> nr_dirty, nr_unqueued_dirty, nr_congested and nr_writeback are used by
>> file cache, so they are not impacted by THP swap.
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
>> v5: Fixed sc->nr_scanned double accounting per Huang Ying
>>      Added some comments to address the concern about premature OOM per Hillf Danton
>> v4: Fixed the comments from Johannes and Huang Ying
>> v3: Removed Shakeel's Reviewed-by since the patch has been changed significantly
>>      Switched back to use compound_order per Matthew
>>      Fixed more counters per Johannes
>> v2: Added Shakeel's Reviewed-by
>>      Use hpage_nr_pages instead of compound_order per Huang Ying and William Kucharski
>>
>>   mm/vmscan.c | 42 +++++++++++++++++++++++++++++++-----------
>>   1 file changed, 31 insertions(+), 11 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index b65bc50..f4f4d57 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1118,6 +1118,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>   		int may_enter_fs;
>>   		enum page_references references = PAGEREF_RECLAIM_CLEAN;
>>   		bool dirty, writeback;
>> +		unsigned int nr_pages;
>>   
>>   		cond_resched();
>>   
>> @@ -1129,6 +1130,13 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>   
>>   		VM_BUG_ON_PAGE(PageActive(page), page);
>>   
>> +		nr_pages = 1 << compound_order(page);
>> +
>> +		/*
>> +		 * Accounted one page for THP for now.  If THP gets swapped
>> +		 * out in a whole, will account all tail pages later to
>> +		 * avoid accounting tail pages twice.
>> +		 */
>>   		sc->nr_scanned++;
>>   
>>   		if (unlikely(!page_evictable(page)))
>> @@ -1250,7 +1258,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>   		case PAGEREF_ACTIVATE:
>>   			goto activate_locked;
>>   		case PAGEREF_KEEP:
>> -			stat->nr_ref_keep++;
>> +			stat->nr_ref_keep += nr_pages;
>>   			goto keep_locked;
>>   		case PAGEREF_RECLAIM:
>>   		case PAGEREF_RECLAIM_CLEAN:
> If the "Accessed bit" of a THP is set in the page table that maps it, it
> will go PAGEREF_ACTIVATE path here.  And the sc->nr_scanned should
> increase 512 instead of 1.  Otherwise sc->nr_activate may be larger than
> sc->nr_scanned.

Yes, it looks so. It seems the easiest way is to add "nr_pages - 1" in 
activate_locked label if the page is still a THP.

If we add all tail pages at the very beginning, then we have to minus 
tail pages when THP gets split, there are a few places do this.

>
> Best Regards,
> Huang, Ying

