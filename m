Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17198100471
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 12:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKRLky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 06:40:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:51238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfKRLkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:40:52 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE10120730;
        Mon, 18 Nov 2019 11:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574077250;
        bh=AIZlOjSJOADzJPesS+L1Au5nHr+gi0p1wKOb1txnlZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X8HChwxUY/EOPGribs2tTGogemWhARzGzFAxKKjG9d0gPT4UJcShhSj/AXpSRI9YJ
         R9zBcfK3mfYn9hQw9mHPKrpJQ2fXOk8UwjnA7ECV5GnABd6MIEzcmmMWzL19TiBSVX
         kGprUqxiZCSF8nRFGSpCV6GqZHLUfKOUBaOokmb8=
Date:   Mon, 18 Nov 2019 20:40:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     x86@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 2/2] x86/insn: Add some Intel instructions to the opcode
 map
Message-Id: <20191118204045.35ef5aaa02650c47fbb51950@kernel.org>
In-Reply-To: <20191115135447.6519-3-adrian.hunter@intel.com>
References: <20191115135447.6519-1-adrian.hunter@intel.com>
        <20191115135447.6519-3-adrian.hunter@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Fri, 15 Nov 2019 15:54:47 +0200
Adrian Hunter <adrian.hunter@intel.com> wrote:

> Add to the opcode map the following instructions:
>         cldemote
>         tpause
>         umonitor
>         umwait
>         movdiri
>         movdir64b
>         enqcmd
>         enqcmds
>         encls
>         enclu
>         enclv
>         pconfig
>         wbnoinvd
> 
> For information about the instructions, refer Intel SDM May 2019
> (325462-070US) and Intel Architecture Instruction Set Extensions
> May 2019 (319433-037).
> 
> The instruction decoding can be tested using the perf tools'
> "x86 instruction decoder - new instructions" test as folllows:
> 
>   $ perf test -v "new " 2>&1 | grep -i cldemote
>   Decoded ok: 0f 1c 00                    cldemote (%eax)
>   Decoded ok: 0f 1c 05 78 56 34 12        cldemote 0x12345678
>   Decoded ok: 0f 1c 84 c8 78 56 34 12     cldemote 0x12345678(%eax,%ecx,8)
>   Decoded ok: 0f 1c 00                    cldemote (%rax)
>   Decoded ok: 41 0f 1c 00                 cldemote (%r8)
>   Decoded ok: 0f 1c 04 25 78 56 34 12     cldemote 0x12345678
>   Decoded ok: 0f 1c 84 c8 78 56 34 12     cldemote 0x12345678(%rax,%rcx,8)
>   Decoded ok: 41 0f 1c 84 c8 78 56 34 12  cldemote 0x12345678(%r8,%rcx,8)
>   $ perf test -v "new " 2>&1 | grep -i tpause
>   Decoded ok: 66 0f ae f3                 tpause %ebx
>   Decoded ok: 66 0f ae f3                 tpause %ebx
>   Decoded ok: 66 41 0f ae f0              tpause %r8d
>   $ perf test -v "new " 2>&1 | grep -i umonitor
>   Decoded ok: 67 f3 0f ae f0              umonitor %ax
>   Decoded ok: f3 0f ae f0                 umonitor %eax
>   Decoded ok: 67 f3 0f ae f0              umonitor %eax
>   Decoded ok: f3 0f ae f0                 umonitor %rax
>   Decoded ok: 67 f3 41 0f ae f0           umonitor %r8d
>   $ perf test -v "new " 2>&1 | grep -i umwait
>   Decoded ok: f2 0f ae f0                 umwait %eax
>   Decoded ok: f2 0f ae f0                 umwait %eax
>   Decoded ok: f2 41 0f ae f0              umwait %r8d
>   $ perf test -v "new " 2>&1 | grep -i movdiri
>   Decoded ok: 0f 38 f9 03                 movdiri %eax,(%ebx)
>   Decoded ok: 0f 38 f9 88 78 56 34 12     movdiri %ecx,0x12345678(%eax)
>   Decoded ok: 48 0f 38 f9 03              movdiri %rax,(%rbx)
>   Decoded ok: 48 0f 38 f9 88 78 56 34 12  movdiri %rcx,0x12345678(%rax)
>   $ perf test -v "new " 2>&1 | grep -i movdir64b
>   Decoded ok: 66 0f 38 f8 18              movdir64b (%eax),%ebx
>   Decoded ok: 66 0f 38 f8 88 78 56 34 12  movdir64b 0x12345678(%eax),%ecx
>   Decoded ok: 67 66 0f 38 f8 1c           movdir64b (%si),%bx
>   Decoded ok: 67 66 0f 38 f8 8c 34 12     movdir64b 0x1234(%si),%cx
>   Decoded ok: 66 0f 38 f8 18              movdir64b (%rax),%rbx
>   Decoded ok: 66 0f 38 f8 88 78 56 34 12  movdir64b 0x12345678(%rax),%rcx
>   Decoded ok: 67 66 0f 38 f8 18           movdir64b (%eax),%ebx
>   Decoded ok: 67 66 0f 38 f8 88 78 56 34 12       movdir64b 0x12345678(%eax),%ecx
>   $ perf test -v "new " 2>&1 | grep -i enqcmd
>   Decoded ok: f2 0f 38 f8 18              enqcmd (%eax),%ebx
>   Decoded ok: f2 0f 38 f8 88 78 56 34 12  enqcmd 0x12345678(%eax),%ecx
>   Decoded ok: 67 f2 0f 38 f8 1c           enqcmd (%si),%bx
>   Decoded ok: 67 f2 0f 38 f8 8c 34 12     enqcmd 0x1234(%si),%cx
>   Decoded ok: f3 0f 38 f8 18              enqcmds (%eax),%ebx
>   Decoded ok: f3 0f 38 f8 88 78 56 34 12  enqcmds 0x12345678(%eax),%ecx
>   Decoded ok: 67 f3 0f 38 f8 1c           enqcmds (%si),%bx
>   Decoded ok: 67 f3 0f 38 f8 8c 34 12     enqcmds 0x1234(%si),%cx
>   Decoded ok: f2 0f 38 f8 18              enqcmd (%rax),%rbx
>   Decoded ok: f2 0f 38 f8 88 78 56 34 12  enqcmd 0x12345678(%rax),%rcx
>   Decoded ok: 67 f2 0f 38 f8 18           enqcmd (%eax),%ebx
>   Decoded ok: 67 f2 0f 38 f8 88 78 56 34 12       enqcmd 0x12345678(%eax),%ecx
>   Decoded ok: f3 0f 38 f8 18              enqcmds (%rax),%rbx
>   Decoded ok: f3 0f 38 f8 88 78 56 34 12  enqcmds 0x12345678(%rax),%rcx
>   Decoded ok: 67 f3 0f 38 f8 18           enqcmds (%eax),%ebx
>   Decoded ok: 67 f3 0f 38 f8 88 78 56 34 12       enqcmds 0x12345678(%eax),%ecx
>   $ perf test -v "new " 2>&1 | grep -i enqcmds
>   Decoded ok: f3 0f 38 f8 18              enqcmds (%eax),%ebx
>   Decoded ok: f3 0f 38 f8 88 78 56 34 12  enqcmds 0x12345678(%eax),%ecx
>   Decoded ok: 67 f3 0f 38 f8 1c           enqcmds (%si),%bx
>   Decoded ok: 67 f3 0f 38 f8 8c 34 12     enqcmds 0x1234(%si),%cx
>   Decoded ok: f3 0f 38 f8 18              enqcmds (%rax),%rbx
>   Decoded ok: f3 0f 38 f8 88 78 56 34 12  enqcmds 0x12345678(%rax),%rcx
>   Decoded ok: 67 f3 0f 38 f8 18           enqcmds (%eax),%ebx
>   Decoded ok: 67 f3 0f 38 f8 88 78 56 34 12       enqcmds 0x12345678(%eax),%ecx
>   $ perf test -v "new " 2>&1 | grep -i encls
>   Decoded ok: 0f 01 cf                    encls
>   Decoded ok: 0f 01 cf                    encls
>   $ perf test -v "new " 2>&1 | grep -i enclu
>   Decoded ok: 0f 01 d7                    enclu
>   Decoded ok: 0f 01 d7                    enclu
>   $ perf test -v "new " 2>&1 | grep -i enclv
>   Decoded ok: 0f 01 c0                    enclv
>   Decoded ok: 0f 01 c0                    enclv
>   $ perf test -v "new " 2>&1 | grep -i pconfig
>   Decoded ok: 0f 01 c5                    pconfig
>   Decoded ok: 0f 01 c5                    pconfig
>   $ perf test -v "new " 2>&1 | grep -i wbnoinvd
>   Decoded ok: f3 0f 09                    wbnoinvd
>   Decoded ok: f3 0f 09                    wbnoinvd
> 

Thanks for updating it!
This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/lib/x86-opcode-map.txt       | 18 ++++++++++++------
>  tools/arch/x86/lib/x86-opcode-map.txt | 18 ++++++++++++------
>  2 files changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
> index e0b85930dd77..0a0e9112f284 100644
> --- a/arch/x86/lib/x86-opcode-map.txt
> +++ b/arch/x86/lib/x86-opcode-map.txt
> @@ -333,7 +333,7 @@ AVXcode: 1
>  06: CLTS
>  07: SYSRET (o64)
>  08: INVD
> -09: WBINVD
> +09: WBINVD | WBNOINVD (F3)
>  0a:
>  0b: UD2 (1B)
>  0c:
> @@ -364,7 +364,7 @@ AVXcode: 1
>  # a ModR/M byte.
>  1a: BNDCL Gv,Ev (F3) | BNDCU Gv,Ev (F2) | BNDMOV Gv,Ev (66) | BNDLDX Gv,Ev
>  1b: BNDCN Gv,Ev (F2) | BNDMOV Ev,Gv (66) | BNDMK Gv,Ev (F3) | BNDSTX Ev,Gv
> -1c:
> +1c: Grp20 (1A),(1C)
>  1d:
>  1e:
>  1f: NOP Ev
> @@ -792,6 +792,8 @@ f3: Grp17 (1A)
>  f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v)
>  f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
>  f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
> +f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3)
> +f9: MOVDIRI My,Gy
>  EndTable
>  
>  Table: 3-byte opcode 2 (0x0f 0x3a)
> @@ -943,9 +945,9 @@ GrpTable: Grp6
>  EndTable
>  
>  GrpTable: Grp7
> -0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B)
> -1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B)
> -2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B)
> +0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B)
> +1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
> +2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
>  3: LIDT Ms
>  4: SMSW Mw/Rv
>  5: rdpkru (110),(11B) | wrpkru (111),(11B)
> @@ -1020,7 +1022,7 @@ GrpTable: Grp15
>  3: vstmxcsr Md (v1) | WRGSBASE Ry (F3),(11B)
>  4: XSAVE | ptwrite Ey (F3),(11B)
>  5: XRSTOR | lfence (11B)
> -6: XSAVEOPT | clwb (66) | mfence (11B)
> +6: XSAVEOPT | clwb (66) | mfence (11B) | TPAUSE Rd (66),(11B) | UMONITOR Rv (F3),(11B) | UMWAIT Rd (F2),(11B)
>  7: clflush | clflushopt (66) | sfence (11B)
>  EndTable
>  
> @@ -1051,6 +1053,10 @@ GrpTable: Grp19
>  6: vscatterpf1qps/d Wx (66),(ev)
>  EndTable
>  
> +GrpTable: Grp20
> +0: cldemote Mb
> +EndTable
> +
>  # AMD's Prefetch Group
>  GrpTable: GrpP
>  0: PREFETCH
> diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
> index e0b85930dd77..0a0e9112f284 100644
> --- a/tools/arch/x86/lib/x86-opcode-map.txt
> +++ b/tools/arch/x86/lib/x86-opcode-map.txt
> @@ -333,7 +333,7 @@ AVXcode: 1
>  06: CLTS
>  07: SYSRET (o64)
>  08: INVD
> -09: WBINVD
> +09: WBINVD | WBNOINVD (F3)
>  0a:
>  0b: UD2 (1B)
>  0c:
> @@ -364,7 +364,7 @@ AVXcode: 1
>  # a ModR/M byte.
>  1a: BNDCL Gv,Ev (F3) | BNDCU Gv,Ev (F2) | BNDMOV Gv,Ev (66) | BNDLDX Gv,Ev
>  1b: BNDCN Gv,Ev (F2) | BNDMOV Ev,Gv (66) | BNDMK Gv,Ev (F3) | BNDSTX Ev,Gv
> -1c:
> +1c: Grp20 (1A),(1C)
>  1d:
>  1e:
>  1f: NOP Ev
> @@ -792,6 +792,8 @@ f3: Grp17 (1A)
>  f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v)
>  f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
>  f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
> +f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3)
> +f9: MOVDIRI My,Gy
>  EndTable
>  
>  Table: 3-byte opcode 2 (0x0f 0x3a)
> @@ -943,9 +945,9 @@ GrpTable: Grp6
>  EndTable
>  
>  GrpTable: Grp7
> -0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B)
> -1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B)
> -2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B)
> +0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B)
> +1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
> +2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
>  3: LIDT Ms
>  4: SMSW Mw/Rv
>  5: rdpkru (110),(11B) | wrpkru (111),(11B)
> @@ -1020,7 +1022,7 @@ GrpTable: Grp15
>  3: vstmxcsr Md (v1) | WRGSBASE Ry (F3),(11B)
>  4: XSAVE | ptwrite Ey (F3),(11B)
>  5: XRSTOR | lfence (11B)
> -6: XSAVEOPT | clwb (66) | mfence (11B)
> +6: XSAVEOPT | clwb (66) | mfence (11B) | TPAUSE Rd (66),(11B) | UMONITOR Rv (F3),(11B) | UMWAIT Rd (F2),(11B)
>  7: clflush | clflushopt (66) | sfence (11B)
>  EndTable
>  
> @@ -1051,6 +1053,10 @@ GrpTable: Grp19
>  6: vscatterpf1qps/d Wx (66),(ev)
>  EndTable
>  
> +GrpTable: Grp20
> +0: cldemote Mb
> +EndTable
> +
>  # AMD's Prefetch Group
>  GrpTable: GrpP
>  0: PREFETCH
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
