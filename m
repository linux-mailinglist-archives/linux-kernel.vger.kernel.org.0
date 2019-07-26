Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E5D75D50
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 05:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfGZDU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 23:20:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:36103 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfGZDU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 23:20:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 20:20:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,309,1559545200"; 
   d="scan'208";a="369406245"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jul 2019 20:20:56 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: kernel BUG at mm/swap_state.c:170!
References: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
        <CAC=cRTMz5S636Wfqdn3UGbzwzJ+v_M46_juSfoouRLS1H62orQ@mail.gmail.com>
        <CABXGCsOo-4CJicvTQm4jF4iDSqM8ic+0+HEEqP+632KfCntU+w@mail.gmail.com>
        <878ssqbj56.fsf@yhuang-dev.intel.com>
        <CABXGCsOhimxC17j=jApoty-o1roRhKYoe+oiqDZ3c1s2r3QxFw@mail.gmail.com>
        <87zhl59w2t.fsf@yhuang-dev.intel.com>
        <20190725114408.GV363@bombadil.infradead.org>
Date:   Fri, 26 Jul 2019 11:20:55 +0800
In-Reply-To: <20190725114408.GV363@bombadil.infradead.org> (Matthew Wilcox's
        message of "Thu, 25 Jul 2019 04:44:08 -0700")
Message-ID: <87a7d17a7c.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Tue, Jul 23, 2019 at 01:08:42PM +0800, Huang, Ying wrote:
>> @@ -2489,6 +2491,14 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>  	/* complete memcg works before add pages to LRU */
>>  	mem_cgroup_split_huge_fixup(head);
>>  
>> +	if (PageAnon(head) && PageSwapCache(head)) {
>> +		swp_entry_t entry = { .val = page_private(head) };
>> +
>> +		offset = swp_offset(entry);
>> +		swap_cache = swap_address_space(entry);
>> +		xa_lock(&swap_cache->i_pages);
>> +	}
>> +
>>  	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
>>  		__split_huge_page_tail(head, i, lruvec, list);
>>  		/* Some pages can be beyond i_size: drop them from page cache */
>> @@ -2501,6 +2511,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>  		} else if (!PageAnon(page)) {
>>  			__xa_store(&head->mapping->i_pages, head[i].index,
>>  					head + i, 0);
>> +		} else if (swap_cache) {
>> +			__xa_store(&swap_cache->i_pages, offset + i,
>> +				   head + i, 0);
>
> I tried something along these lines (though I think I messed up the offset
> calculation which is why it wasn't working for me).  My other concern
> was with the case where SWAPFILE_CLUSTER was less than HPAGE_PMD_NR.
> Don't we need to drop the lock and look up a new swap_cache if offset >=
> SWAPFILE_CLUSTER?

In swapfile.c, there is

#ifdef CONFIG_THP_SWAP
#define SWAPFILE_CLUSTER	HPAGE_PMD_NR
...
#else
#define SWAPFILE_CLUSTER	256
...
#endif

So, if a THP is in swap cache, then SWAPFILE_CLUSTER equals
HPAGE_PMD_NR.


And there is one swap address space for each 64M swap space.  So one THP
will be in one swap address space.

In swap.h, there is

/* One swap address space for each 64M swap space */
#define SWAP_ADDRESS_SPACE_SHIFT	14
#define SWAP_ADDRESS_SPACE_PAGES	(1 << SWAP_ADDRESS_SPACE_SHIFT)

Best Regards,
Huang, Ying
