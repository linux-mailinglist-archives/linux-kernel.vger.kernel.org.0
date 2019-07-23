Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD5D719D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 15:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbfGWN7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 09:59:14 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:33522 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725907AbfGWN7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:59:14 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id B35F72E148D;
        Tue, 23 Jul 2019 16:59:08 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id frB3hPlU0a-x8B0wU3s;
        Tue, 23 Jul 2019 16:59:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1563890348; bh=nBIIHjCFTEo7qsFwDoL4x/nujKFzXvipAp3pDUSMVXc=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=wvk5M5JeNxNSno7f42PKUw0g7uQGaGVewJo6mraA6Wcr5QDyBxzh7bZT0UhLd40Xb
         B8A5hz1MlbU1kxlYZYb8ccEUnm3eYcyY6I5l2HRQV3j+D1apMVOkUHQ0fVbelEiizd
         TxmizULvBuSb1ld34atuZsE6/crymbEXG7z7nvsY=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:38b3:1cdf:ad1a:1fe1])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id aeAd1EbwGg-x8AmOEwo;
        Tue, 23 Jul 2019 16:59:08 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH RFC] mm/page_idle: simple idle page tracking for virtual
 memory
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <156388286599.2859.5353604441686895041.stgit@buzz>
 <20190723134647.GA104199@google.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <53719394-2679-81ae-686e-c138522c0dfc@yandex-team.ru>
Date:   Tue, 23 Jul 2019 16:59:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190723134647.GA104199@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.07.2019 16:46, Joel Fernandes wrote:
> On Tue, Jul 23, 2019 at 02:54:26PM +0300, Konstantin Khlebnikov wrote:
>> The page_idle tracking feature currently requires looking up the pagemap
>> for a process followed by interacting with /sys/kernel/mm/page_idle.
>> This is quite cumbersome and can be error-prone too. If between
>> accessing the per-PID pagemap and the global page_idle bitmap, if
>> something changes with the page then the information is not accurate.
>> More over looking up PFN from pagemap in Android devices is not
>> supported by unprivileged process and requires SYS_ADMIN and gives 0 for
>> the PFN.
>>
>> This patch adds simplified interface which works only with mapped pages:
>> Run: "echo 6 > /proc/pid/clear_refs" to mark all mapped pages as idle.
>> Pages that still idle are marked with bit 57 in /proc/pid/pagemap.
>> Total size of idle pages is shown in /proc/pid/smaps (_rollup).
>>
>> Piece of comment is stolen from Joel Fernandes <joel@joelfernandes.org>
> 
> This will not work well for the problem at hand, the heap profiler
> (heapprofd) only wants to clear the idle flag for the heap memory area which
> is what it is profiling. There is no reason to do it for all mapped pages.
> Using the /proc/pid/page_idle in my patch, it can be done selectively for
> particular memory areas.
> 
> I had previously thought of having an interface that accepts an address
> range to set the idle flag, however that is also more complexity.

Profiler could look into particular area in /proc/pid/smaps
or count idle pages via /proc/pid/pagemap.

Selective /proc/pid/clear_refs is not so hard to add.
Somthing like echo "6 561214d03000-561214d29000" > /proc/pid/clear_refs
might be useful for all other operations.

> 
> thanks,
> 
>   - Joel
> 
> 
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Link: https://lore.kernel.org/lkml/20190722213205.140845-1-joel@joelfernandes.org/
>> ---
>>   Documentation/admin-guide/mm/pagemap.rst |    3 ++-
>>   Documentation/filesystems/proc.txt       |    3 +++
>>   fs/proc/task_mmu.c                       |   33 ++++++++++++++++++++++++++++--
>>   3 files changed, 36 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
>> index 340a5aee9b80..d7ee60287584 100644
>> --- a/Documentation/admin-guide/mm/pagemap.rst
>> +++ b/Documentation/admin-guide/mm/pagemap.rst
>> @@ -21,7 +21,8 @@ There are four components to pagemap:
>>       * Bit  55    pte is soft-dirty (see
>>         :ref:`Documentation/admin-guide/mm/soft-dirty.rst <soft_dirty>`)
>>       * Bit  56    page exclusively mapped (since 4.2)
>> -    * Bits 57-60 zero
>> +    * Bit  57    page is idle
>> +    * Bits 58-60 zero
>>       * Bit  61    page is file-page or shared-anon (since 3.5)
>>       * Bit  62    page swapped
>>       * Bit  63    page present
>> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
>> index 99ca040e3f90..d222be8b4eb9 100644
>> --- a/Documentation/filesystems/proc.txt
>> +++ b/Documentation/filesystems/proc.txt
>> @@ -574,6 +574,9 @@ To reset the peak resident set size ("high water mark") to the process's
>>   current value:
>>       > echo 5 > /proc/PID/clear_refs
>>   
>> +To mark all mapped pages as idle:
>> +    > echo 6 > /proc/PID/clear_refs
>> +
>>   Any other value written to /proc/PID/clear_refs will have no effect.
>>   
>>   The /proc/pid/pagemap gives the PFN, which can be used to find the pageflags
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 731642e0f5a0..6da952574a1f 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -413,6 +413,7 @@ struct mem_size_stats {
>>   	unsigned long private_clean;
>>   	unsigned long private_dirty;
>>   	unsigned long referenced;
>> +	unsigned long idle;
>>   	unsigned long anonymous;
>>   	unsigned long lazyfree;
>>   	unsigned long anonymous_thp;
>> @@ -479,6 +480,10 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>>   	if (young || page_is_young(page) || PageReferenced(page))
>>   		mss->referenced += size;
>>   
>> +	/* Not accessed and still idle. */
>> +	if (!young && page_is_idle(page))
>> +		mss->idle += size;
>> +
>>   	/*
>>   	 * Then accumulate quantities that may depend on sharing, or that may
>>   	 * differ page-by-page.
>> @@ -799,6 +804,9 @@ static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
>>   	SEQ_PUT_DEC(" kB\nPrivate_Clean:  ", mss->private_clean);
>>   	SEQ_PUT_DEC(" kB\nPrivate_Dirty:  ", mss->private_dirty);
>>   	SEQ_PUT_DEC(" kB\nReferenced:     ", mss->referenced);
>> +#ifdef CONFIG_IDLE_PAGE_TRACKING
>> +	SEQ_PUT_DEC(" kB\nIdle:           ", mss->idle);
>> +#endif
>>   	SEQ_PUT_DEC(" kB\nAnonymous:      ", mss->anonymous);
>>   	SEQ_PUT_DEC(" kB\nLazyFree:       ", mss->lazyfree);
>>   	SEQ_PUT_DEC(" kB\nAnonHugePages:  ", mss->anonymous_thp);
>> @@ -969,6 +977,7 @@ enum clear_refs_types {
>>   	CLEAR_REFS_MAPPED,
>>   	CLEAR_REFS_SOFT_DIRTY,
>>   	CLEAR_REFS_MM_HIWATER_RSS,
>> +	CLEAR_REFS_SOFT_ACCESS,
>>   	CLEAR_REFS_LAST,
>>   };
>>   
>> @@ -1045,6 +1054,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
>>   	pte_t *pte, ptent;
>>   	spinlock_t *ptl;
>>   	struct page *page;
>> +	int young;
>>   
>>   	ptl = pmd_trans_huge_lock(pmd, vma);
>>   	if (ptl) {
>> @@ -1058,8 +1068,16 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
>>   
>>   		page = pmd_page(*pmd);
>>   
>> +		young = pmdp_test_and_clear_young(vma, addr, pmd);
>> +
>> +		if (cp->type == CLEAR_REFS_SOFT_ACCESS) {
>> +			if (young)
>> +				set_page_young(page);
>> +			set_page_idle(page);
>> +			goto out;
>> +		}
>> +
>>   		/* Clear accessed and referenced bits. */
>> -		pmdp_test_and_clear_young(vma, addr, pmd);
>>   		test_and_clear_page_young(page);
>>   		ClearPageReferenced(page);
>>   out:
>> @@ -1086,8 +1104,16 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
>>   		if (!page)
>>   			continue;
>>   
>> +		young = ptep_test_and_clear_young(vma, addr, pte);
>> +
>> +		if (cp->type == CLEAR_REFS_SOFT_ACCESS) {
>> +			if (young)
>> +				set_page_young(page);
>> +			set_page_idle(page);
>> +			continue;
>> +		}
>> +
>>   		/* Clear accessed and referenced bits. */
>> -		ptep_test_and_clear_young(vma, addr, pte);
>>   		test_and_clear_page_young(page);
>>   		ClearPageReferenced(page);
>>   	}
>> @@ -1253,6 +1279,7 @@ struct pagemapread {
>>   #define PM_PFRAME_MASK		GENMASK_ULL(PM_PFRAME_BITS - 1, 0)
>>   #define PM_SOFT_DIRTY		BIT_ULL(55)
>>   #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
>> +#define PM_IDLE			BIT_ULL(57)
>>   #define PM_FILE			BIT_ULL(61)
>>   #define PM_SWAP			BIT_ULL(62)
>>   #define PM_PRESENT		BIT_ULL(63)
>> @@ -1326,6 +1353,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>>   		page = vm_normal_page(vma, addr, pte);
>>   		if (pte_soft_dirty(pte))
>>   			flags |= PM_SOFT_DIRTY;
>> +		if (!pte_young(pte) && page && page_is_idle(page))
>> +			flags |= PM_IDLE;
>>   	} else if (is_swap_pte(pte)) {
>>   		swp_entry_t entry;
>>   		if (pte_swp_soft_dirty(pte))
>>
