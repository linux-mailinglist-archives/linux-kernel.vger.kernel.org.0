Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 464F816F36A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 00:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbgBYX0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 18:26:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55652 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729868AbgBYX0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:08 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jaH-0004hC-5U; Wed, 26 Feb 2020 00:25:50 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 30658104090;
        Wed, 26 Feb 2020 00:25:38 +0100 (CET)
Message-Id: <20200225222648.970676604@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:16:14 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 08/24] x86/entry: Convert Divide Error to IDTENTRY
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

Convert #DE to IDTENTRY:
  - Implement the C entry point with DEFINE_IDTENTRY
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S       |    7 -------
 arch/x86/entry/entry_64.S       |    1 -
 arch/x86/include/asm/idtentry.h |    3 +++
 arch/x86/include/asm/traps.h    |    3 ---
 arch/x86/kernel/idt.c           |    2 +-
 arch/x86/kernel/traps.c         |    7 ++++++-
 arch/x86/xen/enlighten_pv.c     |    7 ++++++-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 8 files changed, 17 insertions(+), 15 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1386,13 +1386,6 @@ SYM_CODE_START(alignment_check)
 	jmp	common_exception
 SYM_CODE_END(alignment_check)
 
-SYM_CODE_START(divide_error)
-	ASM_CLAC
-	pushl	$0				# no error code
-	pushl	$do_divide_error
-	jmp	common_exception
-SYM_CODE_END(divide_error)
-
 #ifdef CONFIG_X86_MCE
 SYM_CODE_START(machine_check)
 	ASM_CLAC
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1061,7 +1061,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  * Exception entry points.
  */
 
-idtentry	X86_TRAP_DE		divide_error		do_divide_error			has_error_code=0
 idtentry	X86_TRAP_OF		overflow		do_overflow			has_error_code=0
 idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
 idtentry	X86_TRAP_BR		bounds			do_bounds			has_error_code=0
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -76,4 +76,7 @@ static __always_inline void __##func(str
 
 #endif /* __ASSEMBLY__ */
 
+/* Simple exception entries: */
+DECLARE_IDTENTRY(X86_TRAP_DE,		exc_divide_error);
+
 #endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -11,7 +11,6 @@
 
 #define dotraplinkage __visible
 
-asmlinkage void divide_error(void);
 asmlinkage void debug(void);
 asmlinkage void nmi(void);
 asmlinkage void int3(void);
@@ -38,7 +37,6 @@ asmlinkage void machine_check(void);
 asmlinkage void simd_coprocessor_error(void);
 
 #if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
-asmlinkage void xen_divide_error(void);
 asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
 asmlinkage void xen_int3(void);
@@ -62,7 +60,6 @@ asmlinkage void xen_machine_check(void);
 asmlinkage void xen_simd_coprocessor_error(void);
 #endif
 
-dotraplinkage void do_divide_error(struct pt_regs *regs, long error_code);
 dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
 dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
 dotraplinkage void do_int3(struct pt_regs *regs, long error_code);
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -70,7 +70,7 @@ static const __initconst struct idt_data
  * set up TSS.
  */
 static const __initconst struct idt_data def_idts[] = {
-	INTG(X86_TRAP_DE,		divide_error),
+	INTG(X86_TRAP_DE,		asm_exc_divide_error),
 	INTG(X86_TRAP_NMI,		nmi),
 	INTG(X86_TRAP_BR,		bounds),
 	INTG(X86_TRAP_UD,		invalid_op),
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -279,6 +279,12 @@ static inline void __user *error_get_tra
 	return (void __user *)uprobe_get_trap_addr(regs);
 }
 
+DEFINE_IDTENTRY(exc_divide_error)
+{
+	do_error_trap(regs, 0, "divide_error", X86_TRAP_DE, SIGFPE,
+		      FPE_INTDIV, error_get_trap_addr(regs));
+}
+
 #define IP ((void __user *)uprobe_get_trap_addr(regs))
 #define DO_ERROR(trapnr, signr, sicode, addr, str, name)		   \
 dotraplinkage void do_##name(struct pt_regs *regs, long error_code)	   \
@@ -286,7 +292,6 @@ dotraplinkage void do_##name(struct pt_r
 	do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
 }
 
-DO_ERROR(X86_TRAP_DE,     SIGFPE,  FPE_INTDIV,   IP, "divide error",        divide_error)
 DO_ERROR(X86_TRAP_OF,     SIGSEGV,          0, NULL, "overflow",            overflow)
 DO_ERROR(X86_TRAP_UD,     SIGILL,  ILL_ILLOPN,   IP, "invalid opcode",      invalid_op)
 DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "coprocessor segment overrun", coprocessor_segment_overrun)
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -602,6 +602,11 @@ struct trap_array_entry {
 	bool ist_okay;
 };
 
+#define TRAP_ENTRY(func, ist_ok) {			\
+	.orig		= asm_##func,			\
+	.xen		= xen_asm_##func,		\
+	.ist_okay	= ist_ok }
+
 static struct trap_array_entry trap_array[] = {
 	{ debug,                       xen_xendebug,                    true },
 	{ double_fault,                xen_double_fault,                true },
@@ -615,7 +620,7 @@ static struct trap_array_entry trap_arra
 	{ entry_INT80_compat,          xen_entry_INT80_compat,          false },
 #endif
 	{ page_fault,                  xen_page_fault,                  false },
-	{ divide_error,                xen_divide_error,                false },
+	TRAP_ENTRY(exc_divide_error,			false ),
 	{ bounds,                      xen_bounds,                      false },
 	{ invalid_op,                  xen_invalid_op,                  false },
 	{ device_not_available,        xen_device_not_available,        false },
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -28,7 +28,7 @@ SYM_CODE_END(xen_\name)
 _ASM_NOKPROBE(xen_\name)
 .endm
 
-xen_pv_trap divide_error
+xen_pv_trap asm_exc_divide_error
 xen_pv_trap debug
 xen_pv_trap xendebug
 xen_pv_trap int3

