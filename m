Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA5441751BD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 03:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCBCRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 21:17:38 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726695AbgCBCRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 21:17:38 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 489E9EE228E2F0D26E70;
        Mon,  2 Mar 2020 10:17:36 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.195) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Mar 2020
 10:17:29 +0800
Subject: Re: [PATCH v3 0/6] implement KASLR for powerpc/fsl_booke/64
To:     Scott Wood <oss@buserror.net>, Daniel Axtens <dja@axtens.net>,
        <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <diana.craciun@nxp.com>, <christophe.leroy@c-s.fr>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>, <me@tobin.cc>
CC:     <linux-kernel@vger.kernel.org>, <zhaohongjiang@huawei.com>
References: <20200206025825.22934-1-yanaijie@huawei.com>
 <87tv3drf79.fsf@dja-thinkpad.axtens.net>
 <8171d326-5138-4f5c-cff6-ad3ee606f0c2@huawei.com>
 <e8cd8f287934954cfa07dcf76ac73492e2d49a5b.camel@buserror.net>
 <dd8db870-b607-3f74-d3bc-a8d9f33f9852@huawei.com>
 <4c0e7fec63dbc7b91fa6c24692c73c256c131f51.camel@buserror.net>
 <188971ed-f1c4-39b3-c07e-89cc593d88d7@huawei.com>
 <530c49dfd97c811dc53ffc78c594d7133f7eb1e9.camel@buserror.net>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <35e6c660-3896-bdb8-45f3-c1504aa2171f@huawei.com>
Date:   Mon, 2 Mar 2020 10:17:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <530c49dfd97c811dc53ffc78c594d7133f7eb1e9.camel@buserror.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.221.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/3/1 6:54, Scott Wood 写道:
> On Sat, 2020-02-29 at 15:27 +0800, Jason Yan wrote:
>>
>> 在 2020/2/29 12:28, Scott Wood 写道:
>>> On Fri, 2020-02-28 at 14:47 +0800, Jason Yan wrote:
>>>>
>>>> 在 2020/2/28 13:53, Scott Wood 写道:
>>>>>
>>>>> I don't see any debug setting for %pK (or %p) to always print the
>>>>> actual
>>>>> address (closest is kptr_restrict=1 but that only works in certain
>>>>> contexts)... from looking at the code it seems it hashes even if kaslr
>>>>> is
>>>>> entirely disabled?  Or am I missing something?
>>>>>
>>>>
>>>> Yes, %pK (or %p) always hashes whether kaslr is disabled or not. So if
>>>> we want the real value of the address, we cannot use it. But if you only
>>>> want to distinguish if two pointers are the same, it's ok.
>>>
>>> Am I the only one that finds this a bit crazy?  If you want to lock a
>>> system
>>> down then fine, but why wage war on debugging even when there's no
>>> randomization going on?  Comparing two pointers for equality is not always
>>> adequate.
>>>
>>
>> AFAIK, %p hashing is only exist because of many legacy address printings
>> and force who really want the raw values to switch to %px or even %lx.
>> It's not the opposite of debugging. Raw address printing is not
>> forbidden, only people need to estimate the risk of adrdress leaks.
> 
> Yes, but I don't see any format specifier to switch to that will hash in a
> randomized production environment, but not in a debug or other non-randomized
> environment which seems like the ideal default for most debug output.
> 

Sorry I have no idea why there is no format specifier considered for 
switching of randomized or non-randomized environment. May they think 
that raw address should not leak in non-randomized environment too. May 
be Kees or Tobin can answer this question.

Kees? Tobin?

>>
>> Turnning to %p may not be a good idea in this situation. So
>> for the REG logs printed when dumping stack, we can disable it when
>> KASLR is open. For the REG logs in other places like show_regs(), only
>> privileged can trigger it, and they are not combind with a symbol, so
>> I think it's ok to keep them.
>>
>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
>> index fad50db9dcf2..659c51f0739a 100644
>> --- a/arch/powerpc/kernel/process.c
>> +++ b/arch/powerpc/kernel/process.c
>> @@ -2068,7 +2068,10 @@ void show_stack(struct task_struct *tsk, unsigned
>> long *stack)
>>                   newsp = stack[0];
>>                   ip = stack[STACK_FRAME_LR_SAVE];
>>                   if (!firstframe || ip != lr) {
>> -                       printk("["REG"] ["REG"] %pS", sp, ip, (void *)ip);
>> +                       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
>> +                               printk("%pS", (void *)ip);
>> +                       else
>> +                               printk("["REG"] ["REG"] %pS", sp, ip,
>> (void *)ip);
> 
> This doesn't deal with "nokaslr" on the kernel command line.  It also doesn't
> seem like something that every callsite should have to opencode, versus having
> an appropriate format specifier behaves as I described above (and I still
> don't see why that format specifier should not be "%p").
> 

Actually I still do not understand why we should print the raw value 
here. When KALLSYMS is enabled we have symbol name  and  offset like 
put_cred_rcu+0x108/0x110, and when KALLSYMS is disabled we have the raw 
address.

> -Scott
> 
> 
> 
> .
> 

