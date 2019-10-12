Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6998FD4DF5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 09:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfJLHbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 03:31:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:26829 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfJLHbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 03:31:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46qxMx55lqz9v1Dp;
        Sat, 12 Oct 2019 09:31:41 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=OpoUpGRI; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id O_PEinIXgLoa; Sat, 12 Oct 2019 09:31:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46qxMx42Dtz9v1Dl;
        Sat, 12 Oct 2019 09:31:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1570865501; bh=VsMk4k5KWSekIMCZq0ixP3GE+1fnGp+O8WXTjCgDDoQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OpoUpGRIwAKeP5d6Infu9JC4zPojTWf1n4o7MdGtarj4xsz/Z391llxNFGiw4soMe
         2tMxpZ5Z/HZ/fYAzYU6nCS1DjPfS+j786EBliHIfoc1jj4tBBX4W/IIadvCa3xzpX6
         9P7aFQo5U/RjK2Tn80IRNKpO2FHFTfLi5voerO8g=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8F0A08B790;
        Sat, 12 Oct 2019 09:31:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CzilGxpF1BE8; Sat, 12 Oct 2019 09:31:42 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E1CEC8B752;
        Sat, 12 Oct 2019 09:31:41 +0200 (CEST)
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
 <8d0ad57b-72ad-b77c-d558-86b46982ddeb@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b1defb08-6983-b909-9011-71753905fa02@c-s.fr>
Date:   Sat, 12 Oct 2019 09:31:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8d0ad57b-72ad-b77c-d558-86b46982ddeb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/10/2019 à 08:25, Ravi Bangoria a écrit :
> 
> 
> On 10/10/19 10:14 AM, Ravi Bangoria wrote:
>>
>>>> @Christophe, Is patch5 works for you on 8xx?
>>>>
>>>
>>> Getting the following :
>>>
>>> root@vgoip:~# ./ptrace-hwbreak
>>> test: ptrace-hwbreak
>>> tags: git_version:v5.4-rc2-710-gf0082e173fe4-dirty
>>> PTRACE_SET_DEBUGREG, WO, len: 1: Ok
>>> PTRACE_SET_DEBUGREG, WO, len: 2: Ok
>>> PTRACE_SET_DEBUGREG, WO, len: 4: Ok
>>> PTRACE_SET_DEBUGREG, WO, len: 8: Ok
>>> PTRACE_SET_DEBUGREG, RO, len: 1: Ok
>>> PTRACE_SET_DEBUGREG, RO, len: 2: Ok
>>> PTRACE_SET_DEBUGREG, RO, len: 4: Ok
>>> PTRACE_SET_DEBUGREG, RO, len: 8: Ok
>>> PTRACE_SET_DEBUGREG, RW, len: 1: Ok
>>> PTRACE_SET_DEBUGREG, RW, len: 2: Ok
>>> PTRACE_SET_DEBUGREG, RW, len: 4: Ok
>>> PTRACE_SET_DEBUGREG, RW, len: 8: Ok
>>> PPC_PTRACE_SETHWDEBUG, MODE_EXACT, WO, len: 1: Ok
>>> PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RO, len: 1: Ok
>>> PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RW, len: 1: Ok
>>> PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, WO, len: 6: Ok
>>> PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, RO, len: 6: Fail
>>> failure: ptrace-hwbreak
>>>
>>
>> Thanks Christophe. I don't have any 8xx box. I checked qemu and it seems
>> qemu emulation for 8xx is not yet supported. So I can't debug this. Can
>> you please check why it's failing?
> 
> PPC_PTRACE_SETHWDEBUG internally uses DAWR register and probably 8xx does
> not emulate DAWR logic, it only uses DABR to emulate double-word 
> watchpoint.
> In that case, all testcases that uses PPC_PTRACE_SETHWDEBUG should be
> disabled for 8xx. I'll change [PATCH 5] accordingly and resend.

I think the MODE_EXACT ones are OK with the 8xx at the time being.

> 
> Also, do you think I should fix hw_breakpoint_validate_len() from [PARCH 1]
> for 8xx? I re-checked you recent patch* to allow any address range size for
> 8xx. With that patch, hw_breakpoint_validate_len() won't get called at all
> for 8xx.

At the time being, the 8xx emulates DABR so it has the same limitations 
as BOOK3S.
My patch needs to be rebased on top of your series and I think it needs 
some modifications, as it seems it doesn't properly handle size 1 and 
size 2 breakpoints at least.
So I think that you should leave your Patch1 as is, and I'll modify the 
validate_len() logic while rebasing my patch.

Christophe
