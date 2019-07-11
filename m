Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B1965625
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 13:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfGKLwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 07:52:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfGKLwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 07:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GAWMid08qmglw4UjNwmXK3AmZT7rymJlUMwMLPUqkt0=; b=RtucCuBbe0e3AemSAB+T9RmAUo
        2SGZzWT1lCpdDSWBPyVgkgnWEBxwL91Y8gs5kukXWFkcMfl6xV1fwuDwWC6z+0Zj7U2cBi1tqJtb3
        pOlj77iUtY7txUw9kJbgN/T2ORrFoK80NoR7vJ3QfcAHEkgXF+QRAh5D5jJjV/C8LkRETUt0izk6U
        vWpvQjgN4uKxG2p8YEvWPmbBO2GAwFTONAAkVOHMVwNcsHs7nRBtuWeF1NKIDS3S4LgOhCzmAMAEj
        IVY/073DoC4WrJ/OLFnX066v1hbFcJUrTIIIQmo95Dx3yfrpFLXhqdv8gDdyNbwwpzucg4JawHes8
        w5ijtCVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlXc5-00070H-0E; Thu, 11 Jul 2019 11:51:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 04EF320B53B65; Thu, 11 Jul 2019 13:51:45 +0200 (CEST)
Message-Id: <20190711114336.174080643@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 11 Jul 2019 13:41:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        rostedt@goodmis.org, luto@kernel.org, torvalds@linux-foundation.org
Cc:     hpa@zytor.com, dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com, peterz@infradead.org
Subject: [PATCH v3 6/6] x86/entry/64: Remove TRACE_IRQS_*_DEBUG
References: <20190711114054.406765395@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since INT3/#BP no longer runs on an IST, this workaround is no longer
required.

Tested by running lockdep+ftrace as described in the initial commit:

  5963e317b1e9 ("ftrace/x86: Do not change stacks in DEBUG when calling lockdep")

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S |   46 ++--------------------------------------------
 1 file changed, 2 insertions(+), 44 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -67,44 +67,6 @@ END(native_usergs_sysret64)
 .endm
 
 /*
- * When dynamic function tracer is enabled it will add a breakpoint
- * to all locations that it is about to modify, sync CPUs, update
- * all the code, sync CPUs, then remove the breakpoints. In this time
- * if lockdep is enabled, it might jump back into the debug handler
- * outside the updating of the IST protection. (TRACE_IRQS_ON/OFF).
- *
- * We need to change the IDT table before calling TRACE_IRQS_ON/OFF to
- * make sure the stack pointer does not get reset back to the top
- * of the debug stack, and instead just reuses the current stack.
- */
-#if defined(CONFIG_DYNAMIC_FTRACE) && defined(CONFIG_TRACE_IRQFLAGS)
-
-.macro TRACE_IRQS_OFF_DEBUG
-	call	debug_stack_set_zero
-	TRACE_IRQS_OFF
-	call	debug_stack_reset
-.endm
-
-.macro TRACE_IRQS_ON_DEBUG
-	call	debug_stack_set_zero
-	TRACE_IRQS_ON
-	call	debug_stack_reset
-.endm
-
-.macro TRACE_IRQS_IRETQ_DEBUG
-	btl	$9, EFLAGS(%rsp)		/* interrupts off? */
-	jnc	1f
-	TRACE_IRQS_ON_DEBUG
-1:
-.endm
-
-#else
-# define TRACE_IRQS_OFF_DEBUG			TRACE_IRQS_OFF
-# define TRACE_IRQS_ON_DEBUG			TRACE_IRQS_ON
-# define TRACE_IRQS_IRETQ_DEBUG			TRACE_IRQS_IRETQ
-#endif
-
-/*
  * 64-bit SYSCALL instruction entry. Up to 6 arguments in registers.
  *
  * This is the only entry point used for 64-bit system calls.  The
@@ -878,11 +840,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
 	GET_CR2_INTO(%rdx);			/* can clobber %rax */
 	.endif
 
-	.if \shift_ist != -1
-	TRACE_IRQS_OFF_DEBUG			/* reload IDT in case of recursion */
-	.else
 	TRACE_IRQS_OFF
-	.endif
 
 	.if \paranoid == 0
 	testb	$3, CS(%rsp)
@@ -1248,7 +1206,7 @@ END(paranoid_entry)
 ENTRY(paranoid_exit)
 	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF_DEBUG
+	TRACE_IRQS_OFF
 	testl	%ebx, %ebx			/* swapgs needed? */
 	jnz	.Lparanoid_exit_no_swapgs
 	TRACE_IRQS_IRETQ
@@ -1257,7 +1215,7 @@ ENTRY(paranoid_exit)
 	SWAPGS_UNSAFE_STACK
 	jmp	.Lparanoid_exit_restore
 .Lparanoid_exit_no_swapgs:
-	TRACE_IRQS_IRETQ_DEBUG
+	TRACE_IRQS_IRETQ
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 .Lparanoid_exit_restore:


