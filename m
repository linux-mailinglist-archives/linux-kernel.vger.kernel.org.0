Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1F16F34B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 00:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbgBYX17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 18:27:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55985 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730426AbgBYX0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:50 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jao-0004yz-1u; Wed, 26 Feb 2020 00:26:23 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 25076101226;
        Wed, 26 Feb 2020 00:25:47 +0100 (CET)
Message-Id: <20200225224145.444611199@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:33:34 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 13/16] x86/entry: Move irqflags and context tracking to C for simple idtentries
References: <20200225223321.231477305@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that everything is converted to the new IDTENTRY mechansim, move the
irq tracing and the invocation of enter_to_user_mode() to C code, i.e. into
the idtentry_enter() inline which is invoked through the IDTENTRY magic.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S       |    1 -
 arch/x86/entry/entry_64.S       |    9 ---------
 arch/x86/include/asm/idtentry.h |   19 ++++++++++++++++++-
 3 files changed, 18 insertions(+), 11 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1452,7 +1452,6 @@ SYM_CODE_START_LOCAL_NOALIGN(common_exce
 	movl	PT_ORIG_EAX(%esp), %edx		# get the error code
 	movl	$-1, PT_ORIG_EAX(%esp)		# no syscall to restart
 
-	TRACE_IRQS_OFF
 	movl	%esp, %eax			# pt_regs pointer
 	CALL_NOSPEC %edi
 	jmp	ret_from_exception
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -511,15 +511,6 @@ SYM_CODE_END(spurious_entries_start)
 		GET_CR2_INTO(%r12);
 	.endif
 
-	TRACE_IRQS_OFF
-
-#ifdef CONFIG_CONTEXT_TRACKING
-	testb	$3, CS(%rsp)
-	jz	.Lfrom_kernel_no_ctxt_tracking_\@
-	CALL_enter_from_user_mode
-.Lfrom_kernel_no_ctxt_tracking_\@:
-#endif
-
 	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
 
 	.if \has_error_code == 1
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -7,14 +7,31 @@
 
 #ifndef __ASSEMBLY__
 
+#ifdef CONFIG_CONTEXT_TRACKING
+static __always_inline void enter_from_user_context(void)
+{
+	CT_WARN_ON(ct_state() != CONTEXT_USER);
+	user_exit_irqoff();
+}
+#else
+static __always_inline void enter_from_user_context(void) { }
+#endif
+
 /**
  * idtentry_enter - Handle state tracking on idtentry
  * @regs:	Pointer to pt_regs of interrupted context
  *
- * Place holder for now.
+ * Invokes:
+ *  - The hardirq tracer to keep the state consistent as low level ASM
+ *    entry disabled interrupts.
+ *
+ *  - Context tracking if the exception hit user mode
  */
 static __always_inline void idtentry_enter(struct pt_regs *regs)
 {
+	trace_hardirqs_off();
+	if (user_mode(regs))
+		enter_from_user_context();
 }
 
 /**

