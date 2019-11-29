Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41FA910D6BF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 15:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfK2ON1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 09:13:27 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:1502 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfK2ON1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 09:13:27 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47Pc1H5RW3z9vBmM;
        Fri, 29 Nov 2019 15:13:23 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=trnSGb+S; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id TdWezx36oXmJ; Fri, 29 Nov 2019 15:13:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47Pc1H4LKsz9vBmK;
        Fri, 29 Nov 2019 15:13:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1575036803; bh=wKDL0HqjaEMsTPg5depm0Atm4aPOV97ucMBSnnNc5Vc=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=trnSGb+S5bC20Icn9ePmvud+bTfYeXEvsmtjf/wPLHkzVh/eBkLxhbbmAjMkCBLHH
         /ql/4m27t4p9o0PtQNnLYBjyvBJ5HbPJjX4nXL3wChS3osnJ1qj22GUvmCfdC+YTIR
         OLIRSmJVnuWtZ1wDOofETX9ctzRTQi/xKR5bJv+8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E61048B8DA;
        Fri, 29 Nov 2019 15:13:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xQuiQxPF79F6; Fri, 29 Nov 2019 15:13:24 +0100 (CET)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B13D68B8D2;
        Fri, 29 Nov 2019 15:13:24 +0100 (CET)
Subject: Re: [PATCH] powerpc/kasan: KASAN is not supported on RELOCATABLE &&
 FSL_BOOKE
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Lexi Shao <shaolexi@huawei.com>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au
Cc:     linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        linuxppc-dev@lists.ozlabs.org, liucheng32@huawei.com,
        yi.zhang@huawei.com
References: <20191129070455.62084-1-shaolexi@huawei.com>
 <fc48b5bc-45c1-e4e0-7b56-a23cc045ee0e@c-s.fr>
Message-ID: <e1b2b106-aa8b-2f3d-2109-985a5c672f85@c-s.fr>
Date:   Fri, 29 Nov 2019 15:13:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <fc48b5bc-45c1-e4e0-7b56-a23cc045ee0e@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 29/11/2019 à 08:46, Christophe Leroy a écrit :
> 
> 
> Le 29/11/2019 à 08:04, Lexi Shao a écrit :
>> CONFIG_RELOCATABLE and CONFIG_KASAN cannot be enabled at the same time
>> on ppce500 fsl_booke. All functions called before kasan_early_init()
>> should be disabled with kasan check. When CONFIG_RELOCATABLE is enabled
>> on ppce500 fsl_booke, relocate_init() is called before kasan_early_init()
>> which triggers kasan check and results in boot failure.
>> Call trace and functions which triggers kasan check(*):
>>    - _start
>>     - set_ivor
>>      - relocate_init(*)
>>       - early_get_first_memblock_info(*)
>>        - of_scan_flat_dt(*)
>>     ...
>>      - kasan_early_init
>>
>> Potential solutions could be 1. implement relocate_init and all its 
>> children
>> function in a seperate file or 2. introduce a global vairable in 
>> KASAN, only
>> enable KASAN check when init is done.
> 
> Solution 1 seems uneasy. of_scan_flat_dt() and children are general 
> functions that can't be set aside.
> Solution 2 would destroy performance, and would anyway not work with 
> inline instrumentation.
> 
> Have you tried moving the call to kasan_early_init() before the call of 
> relocate_init() ?

I just tried it with QEMU, it works. I'll send a patch out soon.

Christophe


> On other PPC32, kasan_early_init() is the first thing done after 
> activating the MMU. But AFAIU, MMU is always active on BOOKE though.
> 
> Christophe
> 
>>
>> Disable KASAN when RELOCATABLE is selected on fsl_booke for now until
>> it is supported.
>>
>> Signed-off-by: Lexi Shao <shaolexi@huawei.com>
>> ---
>>   arch/powerpc/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 3e56c9c2f16e..14f3da63c088 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -171,7 +171,7 @@ config PPC
>>       select HAVE_ARCH_AUDITSYSCALL
>>       select HAVE_ARCH_HUGE_VMAP        if PPC_BOOK3S_64 && PPC_RADIX_MMU
>>       select HAVE_ARCH_JUMP_LABEL
>> -    select HAVE_ARCH_KASAN            if PPC32
>> +    select HAVE_ARCH_KASAN            if PPC32 && !(RELOCATABLE && 
>> FSL_BOOKE)
>>       select HAVE_ARCH_KGDB
>>       select HAVE_ARCH_MMAP_RND_BITS
>>       select HAVE_ARCH_MMAP_RND_COMPAT_BITS    if COMPAT
>>
