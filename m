Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50A558FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 03:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfF1Biq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 21:38:46 -0400
Received: from ozlabs.org ([203.11.71.1]:57045 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfF1Bip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:38:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45ZfYZ4B3pz9s3Z;
        Fri, 28 Jun 2019 11:38:42 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] recordmcount: Fix spurious mcount entries on powerpc
In-Reply-To: <20190627102358.GA5974@sathnaga86>
References: <20190626183801.31247-1-naveen.n.rao@linux.vnet.ibm.com> <20190627102358.GA5974@sathnaga86>
Date:   Fri, 28 Jun 2019 11:38:42 +1000
Message-ID: <87woh6sd3x.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Satheesh Rajendran <sathnaga@linux.vnet.ibm.com> writes:
> On Thu, Jun 27, 2019 at 12:08:01AM +0530, Naveen N. Rao wrote:
>> The recent change enabling HAVE_C_RECORDMCOUNT on powerpc started
>> showing the following issue:
>> 
>>   # modprobe kprobe_example
>>    ftrace-powerpc: Not expected bl: opcode is 3c4c0001
>>    WARNING: CPU: 0 PID: 227 at kernel/trace/ftrace.c:2001 ftrace_bug+0x90/0x318
>>    Modules linked in:
>>    CPU: 0 PID: 227 Comm: modprobe Not tainted 5.2.0-rc6-00678-g1c329100b942 #2
>>    NIP:  c000000000264318 LR: c00000000025d694 CTR: c000000000f5cd30
>>    REGS: c000000001f2b7b0 TRAP: 0700   Not tainted  (5.2.0-rc6-00678-g1c329100b942)
>>    MSR:  900000010282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 28228222  XER: 00000000
>>    CFAR: c0000000002642fc IRQMASK: 0
>>    <snip>
>>    NIP [c000000000264318] ftrace_bug+0x90/0x318
>>    LR [c00000000025d694] ftrace_process_locs+0x4f4/0x5e0
>>    Call Trace:
>>    [c000000001f2ba40] [0000000000000004] 0x4 (unreliable)
>>    [c000000001f2bad0] [c00000000025d694] ftrace_process_locs+0x4f4/0x5e0
>>    [c000000001f2bb90] [c00000000020ff10] load_module+0x25b0/0x30c0
>>    [c000000001f2bd00] [c000000000210cb0] sys_finit_module+0xc0/0x130
>>    [c000000001f2be20] [c00000000000bda4] system_call+0x5c/0x70
>>    Instruction dump:
>>    419e0018 2f83ffff 419e00bc 2f83ffea 409e00cc 4800001c 0fe00000 3c62ff96
>>    39000001 39400000 386386d0 480000c4 <0fe00000> 3ce20003 39000001 3c62ff96
>>    ---[ end trace 4c438d5cebf78381 ]---
>>    ftrace failed to modify
>>    [<c0080000012a0008>] 0xc0080000012a0008
>>     actual:   01:00:4c:3c
>>    Initializing ftrace call sites
>>    ftrace record flags: 2000000
>>     (0)
>>     expected tramp: c00000000006af4c
>> 
>> Looking at the relocation records in __mcount_loc showed a few spurious
>> entries:
>>   RELOCATION RECORDS FOR [__mcount_loc]:
>>   OFFSET           TYPE              VALUE
>>   0000000000000000 R_PPC64_ADDR64    .text.unlikely+0x0000000000000008
>>   0000000000000008 R_PPC64_ADDR64    .text.unlikely+0x0000000000000014
>>   0000000000000010 R_PPC64_ADDR64    .text.unlikely+0x0000000000000060
>>   0000000000000018 R_PPC64_ADDR64    .text.unlikely+0x00000000000000b4
>>   0000000000000020 R_PPC64_ADDR64    .init.text+0x0000000000000008
>>   0000000000000028 R_PPC64_ADDR64    .init.text+0x0000000000000014
>> 
>> The first entry in each section is incorrect. Looking at the relocation
>> records, the spurious entries correspond to the R_PPC64_ENTRY records:
>>   RELOCATION RECORDS FOR [.text.unlikely]:
>>   OFFSET           TYPE              VALUE
>>   0000000000000000 R_PPC64_REL64     .TOC.-0x0000000000000008
>>   0000000000000008 R_PPC64_ENTRY     *ABS*
>>   0000000000000014 R_PPC64_REL24     _mcount
>>   <snip>
>> 
>> The problem is that we are not validating the return value from
>> get_mcountsym() in sift_rel_mcount(). With this entry, mcountsym is 0,
>> but Elf_r_sym(relp) also ends up being 0. Fix this by ensuring mcountsym
>> is valid before processing the entry.
>> 
>> Fixes: c7d64b560ce80 ("powerpc/ftrace: Enable C Version of recordmcount")
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>  scripts/recordmcount.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
> Hi,
>
> linuxppc/merge branch latest commit 850f6274c5b5 was failing to boot IBM
> Power8 Box, and the failure got resolved with this patch.
> https://github.com/linuxppc/issues/issues/254
>
> # git log -2 --oneline
> 0e0f55b31ea8 (HEAD -> issue_254) recordmcount: Fix spurious mcount entries on powerpc
> 850f6274c5b5 (origin/merge, merge) Automatic merge of branches 'master', 'next' and 'fixes' into merge
> # uname -r
> 5.2.0-rc6-00123-g0e0f55b31ea8
>  
> Tested-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Thanks. I've pulled the broken commit out of merge for now.

The fix and the original commit will show up in merge later today
probably.

cheers
