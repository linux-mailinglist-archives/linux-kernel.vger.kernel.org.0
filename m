Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 463CDD88B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 08:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbfJPGmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 02:42:23 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:57741 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbfJPGmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 02:42:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 7FDE33F9BD;
        Wed, 16 Oct 2019 08:42:15 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=pPPZbgm6;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S_wGHDoaqxPm; Wed, 16 Oct 2019 08:42:14 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id F27B33F9AA;
        Wed, 16 Oct 2019 08:42:12 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 2B0F236016A;
        Wed, 16 Oct 2019 08:42:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1571208132; bh=mWx5XiZ18RyCNn31L5t+RJV/zV42tlypsAdDAf2qsTY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pPPZbgm6n3Xs7qxcyyTkGfHL9NTkrulg+YkkNIGgcLhHXkWoAmcqKvUNk6wQ4pR9v
         o1C/C2B2NoGNs9hMB11UgywSYcpY0sswuSj9vx2doiPx8g0/8eV6umhLQWgBLh+SXF
         FVyCpoJ/S0MMm3R371V9Bj4n10SM7r58S4kum3l8=
Subject: Re: [PATCH v5 4/8] mm: Add write-protect and clean utilities for
 address space ranges
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org, kirill@shutemov.name,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20191010124314.40067-1-thomas_os@shipmail.org>
 <20191010124314.40067-5-thomas_os@shipmail.org>
 <20191010130542.GP2328@hirez.programming.kicks-ass.net>
 <45cf5965-bd63-3574-d8c2-abbd6c4960d5@shipmail.org>
 <20191010141708.GV2311@hirez.programming.kicks-ass.net>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <7594be1d-01d5-62b7-8947-022f9ebeb845@shipmail.org>
Date:   Wed, 16 Oct 2019 08:42:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191010141708.GV2311@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/19 4:17 PM, Peter Zijlstra wrote:
> On Thu, Oct 10, 2019 at 03:24:47PM +0200, Thomas Hellström (VMware) wrote:
>> On 10/10/19 3:05 PM, Peter Zijlstra wrote:
>>> On Thu, Oct 10, 2019 at 02:43:10PM +0200, Thomas Hellström (VMware) wrote:
>>>> +/**
>>>> + * wp_shared_mapping_range - Write-protect all ptes in an address space range
>>>> + * @mapping: The address_space we want to write protect
>>>> + * @first_index: The first page offset in the range
>>>> + * @nr: Number of incremental page offsets to cover
>>>> + *
>>>> + * Note: This function currently skips transhuge page-table entries, since
>>>> + * it's intended for dirty-tracking on the PTE level. It will warn on
>>>> + * encountering transhuge write-enabled entries, though, and can easily be
>>>> + * extended to handle them as well.
>>>> + *
>>>> + * Return: The number of ptes actually write-protected. Note that
>>>> + * already write-protected ptes are not counted.
>>>> + */
>>>> +unsigned long wp_shared_mapping_range(struct address_space *mapping,
>>>> +				      pgoff_t first_index, pgoff_t nr)
>>>> +{
>>>> +	struct wp_walk wpwalk = { .total = 0 };
>>>> +
>>>> +	i_mmap_lock_read(mapping);
>>>> +	WARN_ON(walk_page_mapping(mapping, first_index, nr, &wp_walk_ops,
>>>> +				  &wpwalk));
>>>> +	i_mmap_unlock_read(mapping);
>>>> +
>>>> +	return wpwalk.total;
>>>> +}
>>> That's a read lock, this means there's concurrency to self. What happens
>>> if someone does two concurrent wp_shared_mapping_range() on the same
>>> mapping?
>>>
>>> The thing is, because of pte_wrprotect() the iteration that starts last
>>> will see a smaller pte_write range, if it completes first and does
>>> flush_tlb_range(), it will only flush a partial range.
>>>
>>> This is exactly what {inc,dec}_tlb_flush_pending() is for, but you're
>>> not using mm_tlb_flush_nested() to detect the situation and do a bigger
>>> flush.
>>>
>>> Or if you're not needing that, then I'm missing why.
>> Good catch. Thanks,
>>
>> Yes the read lock is not intended to protect against concurrent users but to
>> protect the vmas from disappearing under us. Since it fundamentally makes no
>> sense having two concurrent threads picking up dirty ptes on the same
>> address_space range we have an external range-based lock to protect against
>> that.
> Nothing mandates/verifies the function you expose is used exclusively.
> Therefore you cannot make assumptions on that range lock your user has.
>
>> However, that external lock doesn't protect other code  from concurrently
>> modifying ptes and having the mm's  tlb_flush_pending increased, so I guess
>> we unconditionally need to test for that and do a full range flush if
>> necessary?
> Yes, something like:
>
> 	if (mm_tlb_flush_nested(mm))
> 		flush_tlb_range(walk->vma, walk->vma->vm_start, walk->vma->vm_end);
> 	else  if (wpwalk->tlbflush_end > wpwalk->tlbflush_start)
> 		flush_tlb_range(walk->vma, wpwalk->tlbflush_start, wpwalk->tlbflush_end);
>
Hi, Peter,

I've updated the patch to incorporate something similar to the above. 
Since you've looked at the patch, any chance of an R-B?

Thanks,

Thomas


