Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D6B16F370
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 00:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgBYX0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 18:26:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55572 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbgBYXZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:25:56 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jaA-0004aR-MJ; Wed, 26 Feb 2020 00:25:42 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 04211104096;
        Wed, 26 Feb 2020 00:25:33 +0100 (CET)
Message-Id: <20200225221305.605144982@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:08:05 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 4/8] x86/entry: Move irq tracing on syscall entry to C-code
References: <20200225220801.571835584@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the C entry points are safe, move the irq flags tracing code into
the entry helper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c          |    5 +++++
 arch/x86/entry/entry_32.S        |   12 ------------
 arch/x86/entry/entry_64.S        |    2 --
 arch/x86/entry/entry_64_compat.S |   18 ------------------
 4 files changed, 5 insertions(+), 32 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -57,6 +57,11 @@ static inline void enter_from_user_mode(
  */
 static __always_inline void syscall_entry_fixups(void)
 {
+	/*
+	 * Usermode is traced as interrupts enabled, but the syscall entry
+	 * mechanisms disable interrupts. Tell the tracer.
+	 */
+	trace_hardirqs_off();
 	enter_from_user_mode();
 	local_irq_enable();
 }
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -960,12 +960,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	jnz	.Lsysenter_fix_flags
 .Lsysenter_flags_fixed:
 
-	/*
-	 * User mode is traced as though IRQs are on, and SYSENTER
-	 * turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movl	%esp, %eax
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
@@ -1075,12 +1069,6 @@ SYM_FUNC_START(entry_INT80_32)
 
 	SAVE_ALL pt_regs_ax=$-ENOSYS switch_stacks=1	/* save rest */
 
-	/*
-	 * User mode is traced as though IRQs are on, and the interrupt gate
-	 * turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movl	%esp, %eax
 	call	do_int80_syscall_32
 .Lsyscall_32_done:
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -167,8 +167,6 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_h
 
 	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
 
-	TRACE_IRQS_OFF
-
 	/* IRQs are off. */
 	movq	%rax, %rdi
 	movq	%rsp, %rsi
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -129,12 +129,6 @@ SYM_FUNC_START(entry_SYSENTER_compat)
 	jnz	.Lsysenter_fix_flags
 .Lsysenter_flags_fixed:
 
-	/*
-	 * User mode is traced as though IRQs are on, and SYSENTER
-	 * turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
@@ -247,12 +241,6 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_aft
 	pushq   $0			/* pt_regs->r15 = 0 */
 	xorl	%r15d, %r15d		/* nospec   r15 */
 
-	/*
-	 * User mode is traced as though IRQs are on, and SYSENTER
-	 * turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
@@ -403,12 +391,6 @@ SYM_CODE_START(entry_INT80_compat)
 	xorl	%r15d, %r15d		/* nospec   r15 */
 	cld
 
-	/*
-	 * User mode is traced as though IRQs are on, and the interrupt
-	 * gate turned them off.
-	 */
-	TRACE_IRQS_OFF
-
 	movq	%rsp, %rdi
 	call	do_int80_syscall_32
 .Lsyscall_32_done:

