Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E24516F355
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 00:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbgBYX23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 18:28:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55888 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbgBYX0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:36 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jaU-0004na-Ue; Wed, 26 Feb 2020 00:26:03 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 9471F1040A1;
        Wed, 26 Feb 2020 00:25:40 +0100 (CET)
Message-Id: <20200225222650.050626171@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:16:25 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 19/24] x86/entry: Convert General protection exception to IDTENTRY
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

Convert #GP to IDTENTRY_ERRORCODE:
  - Implement the C entry point with DEFINE_IDTENTRY
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototyoes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S       |    8 +-------
 arch/x86/entry/entry_64.S       |    3 +--
 arch/x86/include/asm/idtentry.h |    1 +
 arch/x86/include/asm/traps.h    |    3 ---
 arch/x86/kernel/idt.c           |    2 +-
 arch/x86/kernel/traps.c         |    7 +++----
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 8 files changed, 9 insertions(+), 19 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -732,7 +732,7 @@
 .macro idtentry_push_func vector cfunc
 	.if \vector == X86_TRAP_XF
 		/* AMD 486 bug: invd from userspace calls exception 19 instead of #GP */
-		ALTERNATIVE "pushl	$do_general_protection",	\
+		ALTERNATIVE "pushl	$exc_general_protection",	\
 			    "pushl	$do_simd_coprocessor_error",	\
 			    X86_FEATURE_XMM
 	.else
@@ -1652,12 +1652,6 @@ SYM_CODE_START(nmi)
 #endif
 SYM_CODE_END(nmi)
 
-SYM_CODE_START(general_protection)
-	ASM_CLAC
-	pushl	$do_general_protection
-	jmp	common_exception
-SYM_CODE_END(general_protection)
-
 #ifdef CONFIG_KVM_GUEST
 SYM_CODE_START(async_page_fault)
 	ASM_CLAC
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1061,7 +1061,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  * Exception entry points.
  */
 
-idtentry	X86_TRAP_GP		general_protection	do_general_protection		has_error_code=1
 idtentry	X86_TRAP_SPURIOUS	spurious_interrupt_bug	do_spurious_interrupt_bug	has_error_code=0
 idtentry	X86_TRAP_MF		coprocessor_error	do_coprocessor_error		has_error_code=0
 idtentry	X86_TRAP_AC		alignment_check		do_alignment_check		has_error_code=1
@@ -1201,7 +1200,7 @@ SYM_CODE_START(xen_failsafe_callback)
 	addq	$0x30, %rsp
 	pushq	$0				/* RIP */
 	UNWIND_HINT_IRET_REGS offset=8
-	jmp	general_protection
+	jmp	asm_exc_general_protection
 1:	/* Segment mismatch => Category 1 (Bad segment). Retry the IRET. */
 	movq	(%rsp), %rcx
 	movq	8(%rsp), %r11
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -132,5 +132,6 @@ DECLARE_IDTENTRY(X86_TRAP_OLD_MF,	exc_co
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_TS,	exc_invalid_tss);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_NP,	exc_segment_not_present);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_SS,	exc_stack_segment);
+DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_GP,	exc_general_protection);
 
 #endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -16,7 +16,6 @@ asmlinkage void nmi(void);
 #ifdef CONFIG_X86_64
 asmlinkage void double_fault(void);
 #endif
-asmlinkage void general_protection(void);
 asmlinkage void page_fault(void);
 asmlinkage void async_page_fault(void);
 asmlinkage void spurious_interrupt_bug(void);
@@ -31,7 +30,6 @@ asmlinkage void simd_coprocessor_error(v
 asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
 asmlinkage void xen_double_fault(void);
-asmlinkage void xen_general_protection(void);
 asmlinkage void xen_page_fault(void);
 asmlinkage void xen_spurious_interrupt_bug(void);
 asmlinkage void xen_coprocessor_error(void);
@@ -47,7 +45,6 @@ dotraplinkage void do_nmi(struct pt_regs
 #if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 #endif
-dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code);
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code);
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -79,7 +79,7 @@ static const __initconst struct idt_data
 	INTG(X86_TRAP_TS,		asm_exc_invalid_tss),
 	INTG(X86_TRAP_NP,		asm_exc_segment_not_present),
 	INTG(X86_TRAP_SS,		asm_exc_stack_segment),
-	INTG(X86_TRAP_GP,		general_protection),
+	INTG(X86_TRAP_GP,		asm_exc_general_protection),
 	INTG(X86_TRAP_SPURIOUS,		spurious_interrupt_bug),
 	INTG(X86_TRAP_MF,		coprocessor_error),
 	INTG(X86_TRAP_AC,		alignment_check),
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -214,7 +214,7 @@ do_trap_no_signal(struct task_struct *ts
 	 * process no chance to handle the signal and notice the
 	 * kernel fault information, so that won't result in polluting
 	 * the information about previously queued, but not yet
-	 * delivered, faults.  See also do_general_protection below.
+	 * delivered, faults.  See also exc_general_protection below.
 	 */
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_nr = trapnr;
@@ -410,7 +410,7 @@ dotraplinkage void do_double_fault(struc
 		 * which is what the stub expects, given that the faulting
 		 * RIP will be the IRET instruction.
 		 */
-		regs->ip = (unsigned long)general_protection;
+		regs->ip = (unsigned long)asm_exc_general_protection;
 		regs->sp = (unsigned long)&gpregs->orig_ax;
 
 		return;
@@ -529,7 +529,7 @@ static enum kernel_gp_hint get_kernel_gp
 
 #define GPFSTR "general protection fault"
 
-dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
+DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
 	enum kernel_gp_hint hint = GP_NO_HINT;
@@ -603,7 +603,6 @@ dotraplinkage void do_general_protection
 	die_addr(desc, regs, error_code, gp_addr);
 
 }
-NOKPROBE_SYMBOL(do_general_protection);
 
 DEFINE_IDTENTRY(exc_int3)
 {
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -628,7 +628,7 @@ static struct trap_array_entry trap_arra
 	TRAP_ENTRY(exc_invalid_tss,			false ),
 	TRAP_ENTRY(exc_segment_not_present,		false ),
 	TRAP_ENTRY(exc_stack_segment,			false ),
-	{ general_protection,          xen_general_protection,          false },
+	TRAP_ENTRY(exc_general_protection,		false ),
 	{ spurious_interrupt_bug,      xen_spurious_interrupt_bug,      false },
 	{ coprocessor_error,           xen_coprocessor_error,           false },
 	{ alignment_check,             xen_alignment_check,             false },
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -42,7 +42,7 @@ xen_pv_trap asm_exc_coproc_segment_overr
 xen_pv_trap asm_exc_invalid_tss
 xen_pv_trap asm_exc_segment_not_present
 xen_pv_trap asm_exc_stack_segment
-xen_pv_trap general_protection
+xen_pv_trap asm_exc_general_protection
 xen_pv_trap page_fault
 xen_pv_trap spurious_interrupt_bug
 xen_pv_trap coprocessor_error

