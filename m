Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2CC6170CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 01:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgB0AGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 19:06:45 -0500
Received: from foss.arm.com ([217.140.110.172]:43922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgB0AGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 19:06:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 789341FB;
        Wed, 26 Feb 2020 16:06:44 -0800 (PST)
Received: from [192.168.0.129] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E71373F73B;
        Wed, 26 Feb 2020 16:06:42 -0800 (PST)
Subject: Re: [PATCH 1/3] mm/vma: Move VM_NO_KHUGEPAGED into generic header
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1582692658-3294-1-git-send-email-anshuman.khandual@arm.com>
 <1582692658-3294-2-git-send-email-anshuman.khandual@arm.com>
 <9899b82b-1295-97de-27da-a0a20dbe1a60@suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <6e50e08d-8892-684f-dc0a-e65cde8d632a@arm.com>
Date:   Thu, 27 Feb 2020 05:36:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9899b82b-1295-97de-27da-a0a20dbe1a60@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/26/2020 05:04 PM, Vlastimil Babka wrote:
> On 2/26/20 5:50 AM, Anshuman Khandual wrote:
>> Move VM_NO_KHUGEPAGED into generic header (include/linux/mm.h). This just
>> makes sure that no VMA flag is scattered in individual function files any
>> longer. While at this, fix an old comment which is no longer valid.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  include/linux/mm.h | 3 ++-
>>  mm/khugepaged.c    | 2 --
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 52269e56c514..6f7e400e6ea3 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -287,6 +287,8 @@ extern unsigned int kobjsize(const void *objp);
>>  #define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
>>  #define VM_MERGEABLE	0x80000000	/* KSM may merge identical pages */
>>  
>> +#define VM_NO_KHUGEPAGED (VM_SPECIAL | VM_HUGETLB)
> 
> While the preprocessor doesn't mind that VM_SPECIAL is only defined later, I
> would have moved this below VM_SPECIAL definition anyway, where it fits better,
> and add a comment like other defines there do?

Sure, will do.
