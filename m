Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 657DC16F362
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 00:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbgBYX3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 18:29:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55706 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgBYX0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:14 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jaP-0004kr-Jz; Wed, 26 Feb 2020 00:25:58 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 7E47C10409E;
        Wed, 26 Feb 2020 00:25:39 +0100 (CET)
Message-Id: <20200225222649.550254944@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:16:20 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 14/24] x86/entry: Convert Coprocessor segment overrun exception to IDTENTRY
References: <20200225221606.511535280@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert #OLD_MF to IDTENTRY:
  - Implement the C entry point with DEFINE_IDTENTRY
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototyoes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S       |    7 -------
 arch/x86/entry/entry_64.S       |    1 -
 arch/x86/include/asm/idtentry.h |    1 +
 arch/x86/include/asm/traps.h    |    3 ---
 arch/x86/kernel/idt.c           |    2 +-
 arch/x86/kernel/traps.c         |    7 ++++++-
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 8 files changed, 10 insertions(+), 15 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1327,13 +1327,6 @@ SYM_CODE_START(native_iret)
 SYM_CODE_END(native_iret)
 #endif
 
-SYM_CODE_START(coprocessor_segment_overrun)
-	ASM_CLAC
-	pushl	$0
-	pushl	$do_coprocessor_segment_overrun
-	jmp	common_exception
-SYM_CODE_END(coprocessor_segment_overrun)
-
 SYM_CODE_START(invalid_TSS)
 	ASM_CLAC
 	pushl	$do_invalid_TSS
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1061,7 +1061,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  * Exception entry points.
  */
 
-idtentry	X86_TRAP_OLD_MF		coprocessor_segment_overrun	do_coprocessor_segment_overrun	has_error_code=0
 idtentry	X86_TRAP_TS		invalid_TSS		do_invalid_TSS			has_error_code=1
 idtentry	X86_TRAP_NP		segment_not_present	do_segment_not_present		has_error_code=1
 idtentry	X86_TRAP_SS		stack_segment		do_stack_segment		has_error_code=1
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -83,5 +83,6 @@ DECLARE_IDTENTRY(X86_TRAP_OF,		exc_overf
 DECLARE_IDTENTRY(X86_TRAP_BR,		exc_bounds);
 DECLARE_IDTENTRY(X86_TRAP_UD,		exc_invalid_op);
 DECLARE_IDTENTRY(X86_TRAP_NM,		exc_device_not_available);
+DECLARE_IDTENTRY(X86_TRAP_OLD_MF,	exc_coproc_segment_overrun);
 
 #endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -16,7 +16,6 @@ asmlinkage void nmi(void);
 #ifdef CONFIG_X86_64
 asmlinkage void double_fault(void);
 #endif
-asmlinkage void coprocessor_segment_overrun(void);
 asmlinkage void invalid_TSS(void);
 asmlinkage void segment_not_present(void);
 asmlinkage void stack_segment(void);
@@ -35,7 +34,6 @@ asmlinkage void simd_coprocessor_error(v
 asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
 asmlinkage void xen_double_fault(void);
-asmlinkage void xen_coprocessor_segment_overrun(void);
 asmlinkage void xen_invalid_TSS(void);
 asmlinkage void xen_segment_not_present(void);
 asmlinkage void xen_stack_segment(void);
@@ -55,7 +53,6 @@ dotraplinkage void do_nmi(struct pt_regs
 #if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 #endif
-dotraplinkage void do_coprocessor_segment_overrun(struct pt_regs *regs, long error_code);
 dotraplinkage void do_invalid_TSS(struct pt_regs *regs, long error_code);
 dotraplinkage void do_segment_not_present(struct pt_regs *regs, long error_code);
 dotraplinkage void do_stack_segment(struct pt_regs *regs, long error_code);
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -75,7 +75,7 @@ static const __initconst struct idt_data
 	INTG(X86_TRAP_BR,		asm_exc_bounds),
 	INTG(X86_TRAP_UD,		asm_exc_invalid_op),
 	INTG(X86_TRAP_NM,		asm_exc_device_not_available),
-	INTG(X86_TRAP_OLD_MF,		coprocessor_segment_overrun),
+	INTG(X86_TRAP_OLD_MF,		asm_exc_coproc_segment_overrun),
 	INTG(X86_TRAP_TS,		invalid_TSS),
 	INTG(X86_TRAP_NP,		segment_not_present),
 	INTG(X86_TRAP_SS,		stack_segment),
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -296,6 +296,12 @@ DEFINE_IDTENTRY(exc_invalid_op)
 		      ILL_ILLOPN, error_get_trap_addr(regs));
 }
 
+DEFINE_IDTENTRY(exc_coproc_segment_overrun)
+{
+	do_error_trap(regs, 0, "coprocessor segment overrun",
+		      X86_TRAP_OLD_MF, SIGFPE, 0, NULL);
+}
+
 #define IP ((void __user *)uprobe_get_trap_addr(regs))
 #define DO_ERROR(trapnr, signr, sicode, addr, str, name)		   \
 dotraplinkage void do_##name(struct pt_regs *regs, long error_code)	   \
@@ -303,7 +309,6 @@ dotraplinkage void do_##name(struct pt_r
 	do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
 }
 
-DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "coprocessor segment overrun", coprocessor_segment_overrun)
 DO_ERROR(X86_TRAP_TS,     SIGSEGV,          0, NULL, "invalid TSS",         invalid_TSS)
 DO_ERROR(X86_TRAP_NP,     SIGBUS,           0, NULL, "segment not present", segment_not_present)
 DO_ERROR(X86_TRAP_SS,     SIGBUS,           0, NULL, "stack segment",       stack_segment)
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -624,7 +624,7 @@ static struct trap_array_entry trap_arra
 	TRAP_ENTRY(exc_bounds,				false ),
 	TRAP_ENTRY(exc_invalid_op,			false ),
 	TRAP_ENTRY(exc_device_not_available,		false ),
-	{ coprocessor_segment_overrun, xen_coprocessor_segment_overrun, false },
+	TRAP_ENTRY(exc_coproc_segment_overrun,		false ),
 	{ invalid_TSS,                 xen_invalid_TSS,                 false },
 	{ segment_not_present,         xen_segment_not_present,         false },
 	{ stack_segment,               xen_stack_segment,               false },
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -38,7 +38,7 @@ xen_pv_trap asm_exc_bounds
 xen_pv_trap asm_exc_invalid_op
 xen_pv_trap asm_exc_device_not_available
 xen_pv_trap double_fault
-xen_pv_trap coprocessor_segment_overrun
+xen_pv_trap asm_exc_coproc_segment_overrun
 xen_pv_trap invalid_TSS
 xen_pv_trap segment_not_present
 xen_pv_trap stack_segment

