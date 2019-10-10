Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 803D7D265A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 11:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbfJJJaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 05:30:30 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:35411 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfJJJaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:30:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46pm5t70dPz9tyg3;
        Thu, 10 Oct 2019 11:30:26 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Mi+LBXie; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id bGdkoNBMdE8L; Thu, 10 Oct 2019 11:30:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46pm5t5kgwz9tyfl;
        Thu, 10 Oct 2019 11:30:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1570699826; bh=AykK97M7er2vvsv5jIrpdgMqJu5mfszKCg1SulVxerg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Mi+LBXieYs1bXqMMcVBxGt0xJEsWJQxna+rH76Uo5f8WlQ8yvbgQynDlslYkEmKP9
         wDxkjFiEtlOjZhz9hE2b1rpXa76g7GNgWkt39bnymL7AWiPXOQZMJWSfZu1GfSkHTc
         BjMG7D4v7nWbpz3LA4ZXlm7AUWOSWU8hwKG6rFTA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DE7468B7B2;
        Thu, 10 Oct 2019 11:30:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vHcJKjrjLiae; Thu, 10 Oct 2019 11:30:27 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4699B8B78B;
        Thu, 10 Oct 2019 11:30:27 +0200 (CEST)
Subject: Re: [PATCH v4 0/5] Powerpc/Watchpoint: Few important fixes
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, npiggin@gmail.com,
        benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20190925040630.6948-1-ravi.bangoria@linux.ibm.com>
 <19b222ce-3013-7de5-1c04-48c6fd00fe81@linux.ibm.com>
 <0d98e256-44ee-f920-cb2f-f79545584769@c-s.fr>
 <3e31e5f7-f948-512a-054c-9ad10103ccc0@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b77485b4-39ea-aeb7-432f-44ec4963d25f@c-s.fr>
Date:   Thu, 10 Oct 2019 11:30:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3e31e5f7-f948-512a-054c-9ad10103ccc0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/10/2019 à 06:44, Ravi Bangoria a écrit :
> 
>>> @Christophe, Is patch5 works for you on 8xx?
>>>
>>
>> Getting the following :
>>
>> root@vgoip:~# ./ptrace-hwbreak
>> test: ptrace-hwbreak
>> tags: git_version:v5.4-rc2-710-gf0082e173fe4-dirty
>> PTRACE_SET_DEBUGREG, WO, len: 1: Ok
>> PTRACE_SET_DEBUGREG, WO, len: 2: Ok
>> PTRACE_SET_DEBUGREG, WO, len: 4: Ok
>> PTRACE_SET_DEBUGREG, WO, len: 8: Ok
>> PTRACE_SET_DEBUGREG, RO, len: 1: Ok
>> PTRACE_SET_DEBUGREG, RO, len: 2: Ok
>> PTRACE_SET_DEBUGREG, RO, len: 4: Ok
>> PTRACE_SET_DEBUGREG, RO, len: 8: Ok
>> PTRACE_SET_DEBUGREG, RW, len: 1: Ok
>> PTRACE_SET_DEBUGREG, RW, len: 2: Ok
>> PTRACE_SET_DEBUGREG, RW, len: 4: Ok
>> PTRACE_SET_DEBUGREG, RW, len: 8: Ok
>> PPC_PTRACE_SETHWDEBUG, MODE_EXACT, WO, len: 1: Ok
>> PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RO, len: 1: Ok
>> PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RW, len: 1: Ok
>> PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, WO, len: 6: Ok
>> PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, RO, len: 6: Fail
>> failure: ptrace-hwbreak
>>
> 
> Thanks Christophe. I don't have any 8xx box. I checked qemu and it seems
> qemu emulation for 8xx is not yet supported. So I can't debug this. Can
> you please check why it's failing?
> 

First issue: we get a mismatch between the parent and the child, because 
len 8 test generates two reads/writes while the parent installs the 
breakpoint only once.

Changing glvar from __u64 to unsigned long fixes the problem.

Then I get:

test: ptrace-hwbreak
tags: git_version:v5.4-rc2-710-gf0082e173fe4-dirty
PTRACE_SET_DEBUGREG, WO, len: 1: Ok
PTRACE_SET_DEBUGREG, WO, len: 2: Ok
PTRACE_SET_DEBUGREG, WO, len: 4: Ok
PTRACE_SET_DEBUGREG, RO, len: 1: Ok
PTRACE_SET_DEBUGREG, RO, len: 2: Ok
PTRACE_SET_DEBUGREG, RO, len: 4: Ok
PTRACE_SET_DEBUGREG, RW, len: 1: Ok
PTRACE_SET_DEBUGREG, RW, len: 2: Ok
PTRACE_SET_DEBUGREG, RW, len: 4: Ok
PPC_PTRACE_SETHWDEBUG, MODE_EXACT, WO, len: 1: Ok
PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RO, len: 1: Ok
PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RW, len: 1: Ok
PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, WO, len: 6: Fail
failure: ptrace-hwbreak

Which shows that PPC_PTRACE_SETHWDEBUG doesn't work in MODE_RANGE

Christophe
