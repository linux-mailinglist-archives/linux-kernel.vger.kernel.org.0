Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 582038CD15
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 09:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfHNHmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 03:42:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:56406 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbfHNHmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:42:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C23E4ADE0;
        Wed, 14 Aug 2019 07:42:08 +0000 (UTC)
Subject: Re: [patch] mm, page_alloc: move_freepages should not examine struct
 page of reserved memory
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.1908122036560.10779@chino.kir.corp.google.com>
 <3aadeed1-3f38-267d-8dae-839e10a2f9d2@suse.cz>
 <alpine.DEB.2.21.1908131018450.230426@chino.kir.corp.google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <643d3680-9994-ce58-037f-b1fc123ff8bd@suse.cz>
Date:   Wed, 14 Aug 2019 09:42:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908131018450.230426@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/19 7:22 PM, David Rientjes wrote:
> On Tue, 13 Aug 2019, Vlastimil Babka wrote:
> 
>> > After commit 907ec5fca3dc ("mm: zero remaining unavailable struct pages"),
>> > struct page of reserved memory is zeroed.  This causes page->flags to be 0
>> > and fixes issues related to reading /proc/kpageflags, for example, of
>> > reserved memory.
>> > 
>> > The VM_BUG_ON() in move_freepages_block(), however, assumes that
>> > page_zone() is meaningful even for reserved memory.  That assumption is no
>> > longer true after the aforementioned commit.
>> 
>> How comes that move_freepages_block() gets called on reserved memory in
>> the first place?
>> 
> 
> It's simply math after finding a valid free page from the per-zone free 
> area to use as fallback.  We find the beginning and end of the pageblock 
> of the valid page and that can bring us into memory that was reserved per 
> the e820.  pfn_valid() is still true (it's backed by a struct page), but 
> since it's zero'd we shouldn't make any inferences here about comparing 
> its node or zone.  The current node check just happens to succeed most of 
> the time by luck because reserved memory typically appears on node 0.
> 
> The fix here is to validate that we actually have buddy pages before 
> testing if there's any type of zone or node strangeness going on.

I see, thanks.


>> > @@ -2273,6 +2258,10 @@ static int move_freepages(struct zone *zone,
>> >  			continue;
>> >  		}
>> >  
>> > +		/* Make sure we are not inadvertently changing nodes */
>> > +		VM_BUG_ON_PAGE(page_to_nid(page) != zone_to_nid(zone), page);
>> > +		VM_BUG_ON_PAGE(page_zone(page) != zone, page);
>> 
>> The later check implies the former check, so if it's to stay, the first
>> one could be removed and comment adjusted s/nodes/zones/
>> 
> 
> Does it?  The first is checking for a corrupted page_to_nid the second is 
> checking for a corrupted or unexpected page_zone.  What's being tested 
> here is the state of struct page, as it was previous to this patch, not 
> the state of struct zone.

page_zone() calls page_to_nid() internally, so if nid was wrong, the resulting
zone pointer would be also wrong. But if you want more fine grained bug output,
that's fine.
