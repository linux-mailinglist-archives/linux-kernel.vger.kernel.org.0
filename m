Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04BD2B3928
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 13:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbfIPLLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 07:11:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:52394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729720AbfIPLLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 07:11:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4D300AFF3;
        Mon, 16 Sep 2019 11:11:39 +0000 (UTC)
Subject: Re: [PATCH] mm, thp: Do not queue fully unmapped pages for deferred
 split
To:     Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20190913091849.11151-1-kirill.shutemov@linux.intel.com>
 <20190916103602.GD10231@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5c946cd9-e17b-b184-37b7-250c6dfb977c@suse.cz>
Date:   Mon, 16 Sep 2019 13:11:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916103602.GD10231@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/19 12:36 PM, Michal Hocko wrote:
> On Fri 13-09-19 12:18:49, Kirill A. Shutemov wrote:
>> Adding fully unmapped pages into deferred split queue is not productive:
>> these pages are about to be freed or they are pinned and cannot be split
>> anyway.
>> 
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> ---
>>  mm/rmap.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>> 
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 003377e24232..45388f1bf317 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1271,12 +1271,20 @@ static void page_remove_anon_compound_rmap(struct page *page)
>>  	if (TestClearPageDoubleMap(page)) {
>>  		/*
>>  		 * Subpages can be mapped with PTEs too. Check how many of
>> -		 * themi are still mapped.
>> +		 * them are still mapped.
>>  		 */
>>  		for (i = 0, nr = 0; i < HPAGE_PMD_NR; i++) {
>>  			if (atomic_add_negative(-1, &page[i]._mapcount))
>>  				nr++;
>>  		}
>> +
>> +		/*
>> +		 * Queue the page for deferred split if at least one small
>> +		 * page of the compound page is unmapped, but at least one
>> +		 * small page is still mapped.
>> +		 */
>> +		if (nr && nr < HPAGE_PMD_NR)
>> +			deferred_split_huge_page(page);
> 
> You've set nr to zero in the for loop so this cannot work AFAICS.

The for loop then does nr++ for each subpage that's still mapped?


>>  	} else {
>>  		nr = HPAGE_PMD_NR;
>>  	}
>> @@ -1284,10 +1292,8 @@ static void page_remove_anon_compound_rmap(struct page *page)
>>  	if (unlikely(PageMlocked(page)))
>>  		clear_page_mlock(page);
>>  
>> -	if (nr) {
>> +	if (nr)
>>  		__mod_node_page_state(page_pgdat(page), NR_ANON_MAPPED, -nr);
>> -		deferred_split_huge_page(page);
>> -	}
>>  }
>>  
>>  /**
>> -- 
>> 2.21.0
> 

