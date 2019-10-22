Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABEEDE0034
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 11:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbfJVJBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 05:01:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:20290 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388200AbfJVJBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:01:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46y6vG0r0jz9v0Rt;
        Tue, 22 Oct 2019 11:01:46 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=aFiBDzx8; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id R_xcJFO0NgjM; Tue, 22 Oct 2019 11:01:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46y6vF6hhSz9v0Rs;
        Tue, 22 Oct 2019 11:01:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1571734905; bh=nHY+vb8GjkX/ryDDQxMD9wvS8Jypk/lWmaBjduwAW2g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aFiBDzx8TYEsUwlqX8Mz/Bi9WApZqoufpPa5cIYrO9nsqAgJ/tKjk+Ew2Ju35NaM3
         Rt1OQt0zuWRCn7LaqdRdYm2MGd3m6uvdy/QkGWHSYghSVBcjdNGUapbQv8SQ8y8/K4
         Zf1wVTqAC+1Vio2vT/Xd24fgvR99CeXYE3lbbfhY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DE5A48B91D;
        Tue, 22 Oct 2019 11:01:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jl5Y6p6W0Ic7; Tue, 22 Oct 2019 11:01:46 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2F4CD8B919;
        Tue, 22 Oct 2019 11:01:46 +0200 (CEST)
Subject: Re: [RFC PATCH] powerpc/32: Switch VDSO to C implementation.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        vincenzo.frascino@arm.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <8ce3582f7f7da9ff0286ced857e5aa2e5ae6746e.1571662378.git.christophe.leroy@c-s.fr>
 <alpine.DEB.2.21.1910212312520.2078@nanos.tec.linutronix.de>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <f4486e86-3c0c-0eec-1639-0e5956cdb8f1@c-s.fr>
Date:   Tue, 22 Oct 2019 11:01:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910212312520.2078@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/10/2019 à 23:29, Thomas Gleixner a écrit :
> On Mon, 21 Oct 2019, Christophe Leroy wrote:
> 
>> This is a tentative to switch powerpc/32 vdso to generic C implementation.
>> It will likely not work on 64 bits or even build properly at the moment.
>>
>> powerpc is a bit special for VDSO as well as system calls in the
>> way that it requires setting CR SO bit which cannot be done in C.
>> Therefore, entry/exit and fallback needs to be performed in ASM.
>>
>> To allow that, C fallbacks just return -1 and the ASM entry point
>> performs the system call when the C function returns -1.
>>
>> The performance is rather disappoiting. That's most likely all
>> calculation in the C implementation are based on 64 bits math and
>> converted to 32 bits at the very end. I guess C implementation should
>> use 32 bits math like the assembly VDSO does as of today.
> 
>> gettimeofday:    vdso: 750 nsec/call
>>
>> gettimeofday:    vdso: 1533 nsec/call

Small improvement (3%) with the proposed change:

gettimeofday:    vdso: 1485 nsec/call

Though still some way to go.

Christophe

> 
> The only real 64bit math which can matter is the 64bit * 32bit multiply,
> i.e.
> 
> static __always_inline
> u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
> {
>          return ((cycles - last) & mask) * mult;
> }
> 
> Everything else is trivial add/sub/shift, which should be roughly the same
> in ASM.
> 
> Can you try to replace that with:
> 
> static __always_inline
> u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
> {
>          u64 ret, delta = ((cycles - last) & mask);
>          u32 dh, dl;
> 
>          dl = delta;
>          dh = delta >> 32;
> 
>          res = mul_u32_u32(al, mul);
>          if (ah)
>                  res += mul_u32_u32(ah, mul) << 32;
> 
>          return res;
> }
> 
> That's pretty much what __do_get_tspec does in ASM.
> 
> Thanks,
> 
> 	tglx
> 
