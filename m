Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 548962766D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 09:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfEWHAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 03:00:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64092 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfEWHAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:00:51 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 458gPr10Z2z9v1Px;
        Thu, 23 May 2019 09:00:48 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=jnQhvOhi; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZgPyeXb_h0lj; Thu, 23 May 2019 09:00:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 458gPq70rCz9v1Py;
        Thu, 23 May 2019 09:00:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1558594848; bh=SUPlvML+tdx1yeEzk+b+73oi/1jwsm7iSUeW9uFAnME=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jnQhvOhiUB08k1W4VZVgqaHp3zR+5g6/5YQZAcS/+o5M5np7VNTGhKaEgJhnT0KG3
         rgJiaSIg8mjdh2nGQk+3oA78ZDMIxX1gXI2JOpMtME95WJPpLcbpdfyuT8V9f9fwv1
         vHcou2OEK1MwvAWTVx5gALiOEoShSsdaaw5Uf3+w=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E99318B75A;
        Thu, 23 May 2019 09:00:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id eVuKMmI_EIz3; Thu, 23 May 2019 09:00:48 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 824F78B77D;
        Thu, 23 May 2019 09:00:48 +0200 (CEST)
Subject: Re: [PATCH v3 14/16] powerpc/32: implement fast entry for syscalls on
 BOOKE
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1556627571.git.christophe.leroy@c-s.fr>
 <3e254178a157e7eaeef48f983880f71f97d1f296.1556627571.git.christophe.leroy@c-s.fr>
 <20190523061427.GA19655@blackberry>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <98bf5745-88ae-7f17-fcb9-7d06ba5b9e49@c-s.fr>
Date:   Thu, 23 May 2019 09:00:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523061427.GA19655@blackberry>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 23/05/2019 à 08:14, Paul Mackerras a écrit :
> On Tue, Apr 30, 2019 at 12:39:03PM +0000, Christophe Leroy wrote:
>> This patch implements a fast entry for syscalls.
>>
>> Syscalls don't have to preserve non volatile registers except LR.
>>
>> This patch then implement a fast entry for syscalls, where
>> volatile registers get clobbered.
>>
>> As this entry is dedicated to syscall it always sets MSR_EE
>> and warns in case MSR_EE was previously off
>>
>> It also assumes that the call is always from user, system calls are
>> unexpected from kernel.
> 
> This is now upstream as commit 1a4b739bbb4f.  On the e500mc test
> config that I use, I'm getting this build failure:

Is that a standard defconfig ? If not, can you provide your .config ?

> 
> arch/powerpc/kernel/head_fsl_booke.o: In function `SystemCall':
> arch/powerpc/kernel/head_fsl_booke.S:416: undefined reference to `kvmppc_handler_BOOKE_INTERRUPT_SYSCALL_SPRN_SRR1'
> Makefile:1052: recipe for target 'vmlinux' failed
> 
>> +.macro SYSCALL_ENTRY trapno intno
>> +	mfspr	r10, SPRN_SPRG_THREAD
>> +#ifdef CONFIG_KVM_BOOKE_HV
>> +BEGIN_FTR_SECTION
>> +	mtspr	SPRN_SPRG_WSCRATCH0, r10
>> +	stw	r11, THREAD_NORMSAVE(0)(r10)
>> +	stw	r13, THREAD_NORMSAVE(2)(r10)
>> +	mfcr	r13			/* save CR in r13 for now	   */
>> +	mfspr	r11, SPRN_SRR1
>> +	mtocrf	0x80, r11	/* check MSR[GS] without clobbering reg */
>> +	bf	3, 1975f
>> +	b	kvmppc_handler_BOOKE_INTERRUPT_\intno\()_SPRN_SRR1
> 
> It seems to me that the "_SPRN_SRR1" on the end of this line
> isn't meant to be there...  However, it still fails to link with that
> removed.

This SYSCALL_ENTRY macro is a slimmed version of NORMAL_EXCEPTION_PROLOG()

In NORMAL_EXCEPTION_PROLOG(), we have:
	DO_KVM	BOOKE_INTERRUPT_##intno SPRN_SRR1;	

The _SPRN_SRR1 comes from there


Then in /arch/powerpc/include/asm/kvm_booke_hv_asm.h:

.macro DO_KVM intno srr1
#ifdef CONFIG_KVM_BOOKE_HV
BEGIN_FTR_SECTION
	mtocrf	0x80, r11	/* check MSR[GS] without clobbering reg */
	bf	3, 1975f
	b	kvmppc_handler_\intno\()_\srr1
1975:
END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
#endif
.endm


Christophe
