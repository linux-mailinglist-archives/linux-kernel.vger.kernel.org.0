Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E63D36B35
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 06:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfFFExs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 00:53:48 -0400
Received: from foss.arm.com ([217.140.101.70]:40720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbfFFExs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 00:53:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BA9280D;
        Wed,  5 Jun 2019 21:53:47 -0700 (PDT)
Received: from [10.162.43.122] (p8cg001049571a15.blr.arm.com [10.162.43.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37FC13F690;
        Wed,  5 Jun 2019 21:53:44 -0700 (PDT)
Subject: Re: [PATCH V2 4/4] arm64/mm: Drop local variable vm_fault_t from
 __do_page_fault()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1559544085-7502-1-git-send-email-anshuman.khandual@arm.com>
 <1559544085-7502-5-git-send-email-anshuman.khandual@arm.com>
 <20190604145612.GM6610@arrakis.emea.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1d89177a-e7af-ac4e-1a04-e8b750c2c768@arm.com>
Date:   Thu, 6 Jun 2019 10:24:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190604145612.GM6610@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/04/2019 08:26 PM, Catalin Marinas wrote:
> On Mon, Jun 03, 2019 at 12:11:25PM +0530, Anshuman Khandual wrote:
>> __do_page_fault() is over complicated with multiple goto statements. This
>> cleans up the code flow and while there drops local variable vm_fault_t.
> 
> I'd change the subject as well here to something like refactor or
> simplify __do_page_fault().

Sure.

> 
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 4bb65f3..41fa905 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -397,37 +397,29 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
>>  static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
>>  			   unsigned int mm_flags, unsigned long vm_flags)
>>  {
>> -	struct vm_area_struct *vma;
>> -	vm_fault_t fault;
>> +	struct vm_area_struct *vma = find_vma(mm, addr);
>>  
>> -	vma = find_vma(mm, addr);
>> -	fault = VM_FAULT_BADMAP;
>>  	if (unlikely(!vma))
>> -		goto out;
>> -	if (unlikely(vma->vm_start > addr))
>> -		goto check_stack;
>> +		return VM_FAULT_BADMAP;
>>  
>>  	/*
>>  	 * Ok, we have a good vm_area for this memory access, so we can handle
>>  	 * it.
>>  	 */
>> -good_area:
>> +	if (unlikely(vma->vm_start > addr)) {
>> +		if (!(vma->vm_flags & VM_GROWSDOWN))
>> +			return VM_FAULT_BADMAP;
>> +		if (expand_stack(vma, addr))
>> +			return VM_FAULT_BADMAP;
>> +	}
> 
> You could have a single return here:
> 
> 	if (unlikely(vma->vm_start > addr) &&
> 	    (!(vma->vm_flags & VM_GROWSDOWN) || expand_stack(vma, addr)))
> 		return VM_FAULT_BADMAP;
> 
> Not sure it's any clearer though.
> 

TBH the proposed one seems clearer as it separates effect (vma->vm_start > addr)
from required permission check (vma->vm_flags & VM_GROWSDOWN) and required action
(expand_stack(vma, addr)). But I am happy to change as you have mentioned if that
is preferred.
