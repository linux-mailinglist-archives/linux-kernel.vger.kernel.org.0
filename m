Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0948F85880
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 05:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfHHD0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 23:26:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3779 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728019AbfHHD0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 23:26:05 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7AFC54D9EDB93D01F930;
        Thu,  8 Aug 2019 11:26:01 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 8 Aug 2019
 11:25:52 +0800
Subject: Re: [PATCH v5 01/10] powerpc: unify definition of M_IF_NEEDED
To:     Michael Ellerman <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <diana.craciun@nxp.com>,
        <christophe.leroy@c-s.fr>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>
CC:     <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <yebin10@huawei.com>, <thunder.leizhen@huawei.com>,
        <jingxiangfeng@huawei.com>, <fanchengyang@huawei.com>,
        <zhaohongjiang@huawei.com>
References: <20190807065706.11411-1-yanaijie@huawei.com>
 <20190807065706.11411-2-yanaijie@huawei.com>
 <87sgqdt8yc.fsf@concordia.ellerman.id.au>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <bd2f943a-10fb-3473-5611-1a5bb3bedc5b@huawei.com>
Date:   Thu, 8 Aug 2019 11:25:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87sgqdt8yc.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/7 21:13, Michael Ellerman wrote:
> Jason Yan <yanaijie@huawei.com> writes:
>> M_IF_NEEDED is defined too many times. Move it to a common place.
> 
> The name is not great, can you call it MAS2_M_IF_NEEDED, which at least
> gives a clue what it's for?
> 

OK.

> cheers
> 
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> Cc: Diana Craciun <diana.craciun@nxp.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> Reviewed-by: Diana Craciun <diana.craciun@nxp.com>
>> Tested-by: Diana Craciun <diana.craciun@nxp.com>
>> ---
>>   arch/powerpc/include/asm/nohash/mmu-book3e.h  | 10 ++++++++++
>>   arch/powerpc/kernel/exceptions-64e.S          | 10 ----------
>>   arch/powerpc/kernel/fsl_booke_entry_mapping.S | 10 ----------
>>   arch/powerpc/kernel/misc_64.S                 |  5 -----
>>   4 files changed, 10 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/nohash/mmu-book3e.h b/arch/powerpc/include/asm/nohash/mmu-book3e.h
>> index 4c9777d256fb..0877362e48fa 100644
>> --- a/arch/powerpc/include/asm/nohash/mmu-book3e.h
>> +++ b/arch/powerpc/include/asm/nohash/mmu-book3e.h
>> @@ -221,6 +221,16 @@
>>   #define TLBILX_T_CLASS2			6
>>   #define TLBILX_T_CLASS3			7
>>   
>> +/*
>> + * The mapping only needs to be cache-coherent on SMP, except on
>> + * Freescale e500mc derivatives where it's also needed for coherent DMA.
>> + */
>> +#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
>> +#define M_IF_NEEDED	MAS2_M
>> +#else
>> +#define M_IF_NEEDED	0
>> +#endif
>> +
>>   #ifndef __ASSEMBLY__
>>   #include <asm/bug.h>
>>   
>> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
>> index 1cfb3da4a84a..fd49ec07ce4a 100644
>> --- a/arch/powerpc/kernel/exceptions-64e.S
>> +++ b/arch/powerpc/kernel/exceptions-64e.S
>> @@ -1342,16 +1342,6 @@ skpinv:	addi	r6,r6,1				/* Increment */
>>   	sync
>>   	isync
>>   
>> -/*
>> - * The mapping only needs to be cache-coherent on SMP, except on
>> - * Freescale e500mc derivatives where it's also needed for coherent DMA.
>> - */
>> -#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
>> -#define M_IF_NEEDED	MAS2_M
>> -#else
>> -#define M_IF_NEEDED	0
>> -#endif
>> -
>>   /* 6. Setup KERNELBASE mapping in TLB[0]
>>    *
>>    * r3 = MAS0 w/TLBSEL & ESEL for the entry we started in
>> diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
>> index ea065282b303..de0980945510 100644
>> --- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
>> +++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
>> @@ -153,16 +153,6 @@ skpinv:	addi	r6,r6,1				/* Increment */
>>   	tlbivax 0,r9
>>   	TLBSYNC
>>   
>> -/*
>> - * The mapping only needs to be cache-coherent on SMP, except on
>> - * Freescale e500mc derivatives where it's also needed for coherent DMA.
>> - */
>> -#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
>> -#define M_IF_NEEDED	MAS2_M
>> -#else
>> -#define M_IF_NEEDED	0
>> -#endif
>> -
>>   #if defined(ENTRY_MAPPING_BOOT_SETUP)
>>   
>>   /* 6. Setup KERNELBASE mapping in TLB1[0] */
>> diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
>> index b55a7b4cb543..26074f92d4bc 100644
>> --- a/arch/powerpc/kernel/misc_64.S
>> +++ b/arch/powerpc/kernel/misc_64.S
>> @@ -432,11 +432,6 @@ kexec_create_tlb:
>>   	rlwimi	r9,r10,16,4,15		/* Setup MAS0 = TLBSEL | ESEL(r9) */
>>   
>>   /* Set up a temp identity mapping v:0 to p:0 and return to it. */
>> -#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
>> -#define M_IF_NEEDED	MAS2_M
>> -#else
>> -#define M_IF_NEEDED	0
>> -#endif
>>   	mtspr	SPRN_MAS0,r9
>>   
>>   	lis	r9,(MAS1_VALID|MAS1_IPROT)@h
>> -- 
>> 2.17.2
> 
> .
> 

