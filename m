Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A8617EE91
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 03:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgCJC2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 22:28:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:56464 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgCJC2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 22:28:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 19:28:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="388766932"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga004.jf.intel.com with ESMTP; 09 Mar 2020 19:28:15 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -V3] mm: Add PageLayzyFree() helper functions for MADV_FREE
References: <20200309021744.1309482-1-ying.huang@intel.com>
        <68360241-eb18-b3d8-bf6f-4dbbed258ee6@redhat.com>
        <20200309121300.GL8447@dhcp22.suse.cz>
Date:   Tue, 10 Mar 2020 10:28:14 +0800
In-Reply-To: <20200309121300.GL8447@dhcp22.suse.cz> (Michal Hocko's message of
        "Mon, 9 Mar 2020 13:13:00 +0100")
Message-ID: <87mu8px7sx.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Mon 09-03-20 09:55:38, David Hildenbrand wrote:
>> On 09.03.20 03:17, Huang, Ying wrote:
> [...]
>> > @@ -1235,7 +1234,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>> >  		 * Try to allocate it some swap space here.
>> >  		 * Lazyfree page could be freed directly
>> >  		 */
>> > -		if (PageAnon(page) && PageSwapBacked(page)) {
>> > +		if (PageAnon(page) && !__PageLazyFree(page)) {
>> >  			if (!PageSwapCache(page)) {
>> >  				if (!(sc->gfp_mask & __GFP_IO))
>> >  					goto keep_locked;
>> > @@ -1411,7 +1410,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>> >  			}
>> >  		}
>> >  
>> > -		if (PageAnon(page) && !PageSwapBacked(page)) {
>> > +		if (PageLazyFree(page)) {
>> >  			/* follow __remove_mapping for reference */
>> >  			if (!page_ref_freeze(page, 1))
>> >  				goto keep_locked;
>> > 
>> 
>> I still prefer something like
>> 
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index fd6d4670ccc3..7538501230bd 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -63,6 +63,10 @@
>>   * page_waitqueue(page) is a wait queue of all tasks waiting for the page
>>   * to become unlocked.
>>   *
>> + * PG_swapbacked used with anonymous pages (PageAnon()) indicates that a
>> + * page is backed by swap. Anonymous pages without PG_swapbacked are
>> + * pages that can be lazily freed (e.g., MADV_FREE) on demand.
>> + *
>>   * PG_uptodate tells whether the page's contents is valid.  When a read
>>   * completes, the page becomes uptodate, unless a disk I/O error happened.
>>   *
>> 
>> and really don't like the use of !__PageLazyFree() instead of PageSwapBacked().
>
> I have to say that I do not have a strong opinion about helper
> functions. In general I tend to be against adding them unless there is a
> very good reason for them. This particular patch is in a gray zone a bit.
>
> There are few places which are easier to follow but others sound like,
> we have a hammer let's use it. E.g. shrink_page_list path above.

I can remove all these places.  Only keep the helpful places.

> There is a clear comment explaining PageAnon && PageSwapBacked check
> being LazyFree related but do I have to know that this is LazyFree
> path? I believe that seeing PageSwapBacked has a more meaning to me
> because it tells me that anonymous pages without a backing store
> doesn't really need swap entry.  This happens to be Lazy free related
> today but with a heavy overloading of our flags this might differ in
> the future. You have effectively made a more generic description more
> specific without a very good reason.

Yes.  The following piece isn't lazy free specific.  We can keep use PageSwapBacked().

 @@ -1235,7 +1234,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
  		 * Try to allocate it some swap space here.
  		 * Lazyfree page could be freed directly
  		 */
 -		if (PageAnon(page) && PageSwapBacked(page)) {
 +		if (PageAnon(page) && !__PageLazyFree(page)) {
  			if (!PageSwapCache(page)) {
  				if (!(sc->gfp_mask & __GFP_IO))
  					goto keep_locked;

And the following piece is lazy free specific.  I think it helps.

 @@ -1411,7 +1410,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
  			}
  		}
  
 -		if (PageAnon(page) && !PageSwapBacked(page)) {
 +		if (PageLazyFree(page)) {
  			/* follow __remove_mapping for reference */
  			if (!page_ref_freeze(page, 1))
  				goto keep_locked;
 
> On the other hand having PG_swapbacked description in page-flags.h above
> gives a very useful information which was previously hidden at the
> definition so this is a clear improvement.

Yes.  I think it's good to add document for PG_swapbacked definition.

> That being said I think that the patch is not helpful enough. I would
> much rather see a simply documentation update.
