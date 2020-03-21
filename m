Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 426ED18DF6E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 11:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgCUK2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 06:28:13 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56683 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgCUK2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 06:28:13 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48kxgF72twz9v2D7;
        Sat, 21 Mar 2020 11:28:09 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=tUHJdpw7; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KSOyuxWAekaG; Sat, 21 Mar 2020 11:28:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48kxgF5gGLz9v2D1;
        Sat, 21 Mar 2020 11:28:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584786489; bh=/IOWVhiwPMCQRgzudKKMRxz9b+oGxzhOIS1ciBnze10=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tUHJdpw7KMK/9HR8wuUSQZcnGU8xLse/+rfWQcCt7vpyVUqxLj2CGKahX15nix2Fu
         Wbetx+yW8kfHEc8qe4fOZm5rS/Mjkdfwf4d5Ju6qjWTJriSpcZDZl791KdwGttaxBO
         SlkJhPmFiV7k3vuNlWGKcKS1K4+hzLIpui7Hdz0Y=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E86CA8B774;
        Sat, 21 Mar 2020 11:28:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mwGAEoGi0FQi; Sat, 21 Mar 2020 11:28:10 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3368E8B752;
        Sat, 21 Mar 2020 11:28:10 +0100 (CET)
Subject: Re: [PATCH v5 10/13] powerpc/ptrace: split out ADV_DEBUG_REGS related
 functions.
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1582848567.git.christophe.leroy@c-s.fr>
 <e2bd7d275bd5933d848aad4fee3ca652a14d039b.1582848567.git.christophe.leroy@c-s.fr>
 <87imizdbaz.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <25a7f050-f241-6035-e778-16b1ca9928f3@c-s.fr>
Date:   Sat, 21 Mar 2020 10:27:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87imizdbaz.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/20/2020 02:12 AM, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Move ADV_DEBUG_REGS functions out of ptrace.c, into
>> ptrace-adv.c and ptrace-noadv.c
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>> v4: Leave hw_breakpoint.h for ptrace.c
>> ---
>>   arch/powerpc/kernel/ptrace/Makefile       |   4 +
>>   arch/powerpc/kernel/ptrace/ptrace-adv.c   | 468 ++++++++++++++++
>>   arch/powerpc/kernel/ptrace/ptrace-decl.h  |   5 +
>>   arch/powerpc/kernel/ptrace/ptrace-noadv.c | 236 ++++++++
>>   arch/powerpc/kernel/ptrace/ptrace.c       | 650 ----------------------
>>   5 files changed, 713 insertions(+), 650 deletions(-)
>>   create mode 100644 arch/powerpc/kernel/ptrace/ptrace-adv.c
>>   create mode 100644 arch/powerpc/kernel/ptrace/ptrace-noadv.c
> 
> This is somehow breaking the ptrace-hwbreak selftest on Power8:
> 
>    test: ptrace-hwbreak
>    tags: git_version:v5.6-rc6-892-g7a285a6067d6
>    PTRACE_SET_DEBUGREG, WO, len: 1: Ok
>    PTRACE_SET_DEBUGREG, WO, len: 2: Ok
>    PTRACE_SET_DEBUGREG, WO, len: 4: Ok
>    PTRACE_SET_DEBUGREG, WO, len: 8: Ok
>    PTRACE_SET_DEBUGREG, RO, len: 1: Ok
>    PTRACE_SET_DEBUGREG, RO, len: 2: Ok
>    PTRACE_SET_DEBUGREG, RO, len: 4: Ok
>    PTRACE_SET_DEBUGREG, RO, len: 8: Ok
>    PTRACE_SET_DEBUGREG, RW, len: 1: Ok
>    PTRACE_SET_DEBUGREG, RW, len: 2: Ok
>    PTRACE_SET_DEBUGREG, RW, len: 4: Ok
>    PTRACE_SET_DEBUGREG, RW, len: 8: Ok
>    PPC_PTRACE_SETHWDEBUG, MODE_EXACT, WO, len: 1: Ok
>    PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RO, len: 1: Ok
>    PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RW, len: 1: Ok
>    PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, WO, len: 6: Ok
>    PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, RO, len: 6: Ok
>    PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, RW, len: 6: Ok
>    PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW UNALIGNED, WO, len: 6: Ok
>    PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW UNALIGNED, RO, len: 6: Fail
>    failure: ptrace-hwbreak
> 
> I haven't had time to work out why yet.
> 

A (big) part of commit c3f68b0478e7 ("powerpc/watchpoint: Fix ptrace 
code that muck around with address/len") was lost during rebase.

I'll send a fix, up to you to squash it in or commit it as is.

Christophe
