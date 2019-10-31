Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 831A5EAF31
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 12:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfJaLyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 07:54:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726462AbfJaLyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:54:18 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AFEB454D48C72B19E600;
        Thu, 31 Oct 2019 19:54:14 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 31 Oct 2019
 19:54:10 +0800
Message-ID: <5DBACB61.90809@huawei.com>
Date:   Thu, 31 Oct 2019 19:54:09 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Borislav Petkov <bp@alien8.de>
CC:     <peterz@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/ioremap: Use WARN_ONCE instead of printk() + WARN_ON_ONCE()
References: <1572425838-39158-1-git-send-email-zhongjiang@huawei.com> <20191031110304.GE21133@nazgul.tnic>
In-Reply-To: <20191031110304.GE21133@nazgul.tnic>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/31 19:03, Borislav Petkov wrote:
> On Wed, Oct 30, 2019 at 04:57:18PM +0800, zhong jiang wrote:
>> WARN_ONCE is more clear and simpler. Just replace it.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  arch/x86/mm/ioremap.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>> index a39dcdb..3b74599 100644
>> --- a/arch/x86/mm/ioremap.c
>> +++ b/arch/x86/mm/ioremap.c
>> @@ -172,9 +172,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>>  		return NULL;
>>  
>>  	if (!phys_addr_valid(phys_addr)) {
>> -		printk(KERN_WARNING "ioremap: invalid physical address %llx\n",
>> -		       (unsigned long long)phys_addr);
>> -		WARN_ON_ONCE(1);
>> +		WARN_ONCE(1, "ioremap: invalid physical address %llx\n",
>> +			  (unsigned long long)phys_addr);
> Does
> 	WARN_ONCE(!phys_addr_valid(phys_addr),
> 		  "ioremap: invalid physical address %llx\n",
> 		  (unsigned long long)phys_addr);
>
> work too?
>
Look at this again, It should not works. Because that will change the logical.
if phys_addr_valid is false, we should drop out in time.

WARN_ONCE should be just visible for user not should to handle with address.

Thanks,
zhong jiang

