Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2F277619
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 04:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfG0C4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 22:56:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbfG0C4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 22:56:13 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 64AC312BCB15B6E8DB67;
        Sat, 27 Jul 2019 10:56:10 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sat, 27 Jul 2019
 10:55:59 +0800
Subject: Re: [PATCH] KVM: arm64: Update kvm_arm_exception_class and
 esr_class_str for new EC
To:     James Morse <james.morse@arm.com>, <marc.zyngier@arm.com>
CC:     <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <julien.thierry@arm.com>,
        <suzuki.poulose@arm.com>, <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>, <amit.kachhap@arm.com>,
        <Dave.Martin@arm.com>, <wanghaibin.wang@huawei.com>
References: <1562992854-972-1-git-send-email-yuzenghui@huawei.com>
 <e009aceb-9d23-1a58-8186-4883ab98bd45@arm.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <3e3029b5-74b2-693f-b4ab-5876baee3414@huawei.com>
Date:   Sat, 27 Jul 2019 10:54:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <e009aceb-9d23-1a58-8186-4883ab98bd45@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed Marc had applied this patch in his kvmarm tree, with the
updated commit message.  Thanks Marc :)

On 2019/7/25 20:48, James Morse wrote:
> Hi,
> 
> On 13/07/2019 05:40, Zenghui Yu wrote:
>> We've added two ESR exception classes for new ARM hardware extensions:
>> ESR_ELx_EC_PAC and ESR_ELx_EC_SVE.
>>
>> This patch updates "kvm_arm_exception_class" for these two EC, which the
> 
>> new EC will be parsed in kvm_exit trace events (for guest's usage of
> 
> new EC will be visible to user-space via kvm_exit() trace events... ?
> 
> 
>> Pointer Authentication and Scalable Vector Extension).  The same updates
>> to "esr_class_str" for ESR_ELx_EC_PAC, by which we can get more accurate
>> debug info.
> 
> Its accurate either way round. This stops the trace-point print from printing the EC in
> hex, instead giving it a name, like we do for all the others.

So this should be "readable".

>>   Trivial changes, update them in one go.
> 
> (I don't think this bit needs to go in the git-log!)
> 
> 
>> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
>> index a8b205e..ddf9d76 100644
>> --- a/arch/arm64/include/asm/kvm_arm.h
>> +++ b/arch/arm64/include/asm/kvm_arm.h
>> @@ -316,9 +316,10 @@
>>   
>>   #define kvm_arm_exception_class \
>>   	ECN(UNKNOWN), ECN(WFx), ECN(CP15_32), ECN(CP15_64), ECN(CP14_MR), \
>> -	ECN(CP14_LS), ECN(FP_ASIMD), ECN(CP10_ID), ECN(CP14_64), ECN(SVC64), \
>> -	ECN(HVC64), ECN(SMC64), ECN(SYS64), ECN(IMP_DEF), ECN(IABT_LOW), \
>> -	ECN(IABT_CUR), ECN(PC_ALIGN), ECN(DABT_LOW), ECN(DABT_CUR), \
>> +	ECN(CP14_LS), ECN(FP_ASIMD), ECN(CP10_ID), ECN(PAC), ECN(CP14_64), \
>> +	ECN(SVC64), ECN(HVC64), ECN(SMC64), ECN(SYS64), ECN(SVE), \
>> +	ECN(IMP_DEF), ECN(IABT_LOW), ECN(IABT_CUR), \
>> +	ECN(PC_ALIGN), ECN(DABT_LOW), ECN(DABT_CUR), \
>>   	ECN(SP_ALIGN), ECN(FP_EXC32), ECN(FP_EXC64), ECN(SERROR), \
>>   	ECN(BREAKPT_LOW), ECN(BREAKPT_CUR), ECN(SOFTSTP_LOW), \
>>   	ECN(SOFTSTP_CUR), ECN(WATCHPT_LOW), ECN(WATCHPT_CUR), \
> 
> Do we need to add:
> ESR_ELx_EC_ILL
> ESR_ELx_EC_HVC32
> ESR_ELx_EC_SMC32

I think they're needed.  But these three EC are not included into
kvm_arm_exception_class at the time it was introduced, I don't know
the reason.

> (I don't see how any of the _CUR entries could ever happen as these EC originally come
> from ESR_EL2, but they're harmless)

(I agree with you.)

>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index 8c03456..969e156 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -734,6 +734,7 @@ asmlinkage void __exception do_sysinstr(unsigned int esr, struct pt_regs *regs)
>>   	[ESR_ELx_EC_CP14_LS]		= "CP14 LDC/STC",
>>   	[ESR_ELx_EC_FP_ASIMD]		= "ASIMD",
>>   	[ESR_ELx_EC_CP10_ID]		= "CP10 MRC/VMRS",
>> +	[ESR_ELx_EC_PAC]		= "PAC",
>>   	[ESR_ELx_EC_CP14_64]		= "CP14 MCRR/MRRC",
>>   	[ESR_ELx_EC_ILL]		= "PSTATE.IL",
>>   	[ESR_ELx_EC_SVC32]		= "SVC (AArch32)",
> 
> 
> Reviewed-by: James Morse <james.morse@arm.com>

Thanks for your reviewing!


Zenghui


