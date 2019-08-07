Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEBD842E0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 05:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfHGDWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 23:22:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42358 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbfHGDWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 23:22:30 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E7D4756A99E4D96D9800;
        Wed,  7 Aug 2019 11:22:24 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 7 Aug 2019
 11:22:16 +0800
Subject: Re: [PATCH v4 09/10] powerpc/fsl_booke/kaslr: support nokaslr cmdline
 parameter
To:     Christophe Leroy <christophe.leroy@c-s.fr>, <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <diana.craciun@nxp.com>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>
CC:     <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <yebin10@huawei.com>, <thunder.leizhen@huawei.com>,
        <jingxiangfeng@huawei.com>, <fanchengyang@huawei.com>,
        <zhaohongjiang@huawei.com>
References: <20190805064335.19156-1-yanaijie@huawei.com>
 <20190805064335.19156-10-yanaijie@huawei.com>
 <e7703798-c2e2-c75f-1001-46c01db88238@c-s.fr>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <3a83c812-ac14-3e89-241e-eeade105d23e@huawei.com>
Date:   Wed, 7 Aug 2019 11:22:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <e7703798-c2e2-c75f-1001-46c01db88238@c-s.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/6 15:59, Christophe Leroy wrote:
> 
> 
> Le 05/08/2019 à 08:43, Jason Yan a écrit :
>> One may want to disable kaslr when boot, so provide a cmdline parameter
>> 'nokaslr' to support this.
>>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> Cc: Diana Craciun <diana.craciun@nxp.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Reviewed-by: Diana Craciun <diana.craciun@nxp.com>
>> Tested-by: Diana Craciun <diana.craciun@nxp.com>
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Tiny comment below.
> 
>> ---
>>   arch/powerpc/kernel/kaslr_booke.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/kaslr_booke.c 
>> b/arch/powerpc/kernel/kaslr_booke.c
>> index 4b3f19a663fc..7c3cb41e7122 100644
>> --- a/arch/powerpc/kernel/kaslr_booke.c
>> +++ b/arch/powerpc/kernel/kaslr_booke.c
>> @@ -361,6 +361,18 @@ static unsigned long __init 
>> kaslr_choose_location(void *dt_ptr, phys_addr_t size
>>       return kaslr_offset;
>>   }
>> +static inline __init bool kaslr_disabled(void)
>> +{
>> +    char *str;
>> +
>> +    str = strstr(boot_command_line, "nokaslr");
>> +    if ((str == boot_command_line) ||
>> +        (str > boot_command_line && *(str - 1) == ' '))
>> +        return true;
> 
> I don't think additional () are needed for the left part 'str == 
> boot_command_line'
> 

Agree.

>> +
>> +    return false;
>> +}
>> +
>>   /*
>>    * To see if we need to relocate the kernel to a random offset
>>    * void *dt_ptr - address of the device tree
>> @@ -376,6 +388,8 @@ notrace void __init kaslr_early_init(void *dt_ptr, 
>> phys_addr_t size)
>>       kernel_sz = (unsigned long)_end - KERNELBASE;
>>       kaslr_get_cmdline(dt_ptr);
>> +    if (kaslr_disabled())
>> +        return;
>>       offset = kaslr_choose_location(dt_ptr, size, kernel_sz);
>>
> 
> .
> 

