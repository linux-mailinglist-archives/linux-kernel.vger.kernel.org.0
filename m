Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E62DF5A18
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 22:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733193AbfKHVfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 16:35:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732950AbfKHVex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:34:53 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1723B22480;
        Fri,  8 Nov 2019 21:34:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iTBu7-0007zV-0d; Fri, 08 Nov 2019 16:34:51 -0500
Message-Id: <20191108213450.891579507@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 08 Nov 2019 16:28:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 09/10] ftrace/x86: Add register_ftrace_direct() for custom trampolines
References: <20191108212834.594904349@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Enable x86 to allow for register_ftrace_direct(), where a custom trampoline
may be called directly from an ftrace mcount/fentry location.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/Kconfig              |  1 +
 arch/x86/include/asm/ftrace.h | 13 +++++++++++++
 arch/x86/kernel/ftrace.c      | 12 ++++++++++++
 arch/x86/kernel/ftrace_64.S   | 33 ++++++++++++++++++++++++++-------
 include/linux/ftrace.h        |  6 ++++++
 5 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d6e1faa28c58..329d9c729ba3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -158,6 +158,7 @@ config X86
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
+	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_EISA
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index c38a66661576..c2a7458f912c 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -28,6 +28,19 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
+/*
+ * When a ftrace registered caller is tracing a function that is
+ * also set by a register_ftrace_direct() call, it needs to be
+ * differentiated in the ftrace_caller trampoline. To do this, we
+ * place the direct caller in the ORIG_AX part of pt_regs. This
+ * tells the ftrace_caller that there's a direct caller.
+ */
+static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
+{
+	/* Emulate a call */
+	regs->orig_ax = addr;
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 struct dyn_arch_ftrace {
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 024c3053dbba..fef283f6341d 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -1042,6 +1042,18 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
 
+	/*
+	 * If the return location is actually pointing directly to
+	 * the start of a direct trampoline (if we trace the trampoline
+	 * it will still be offset by MCOUNT_INSN_SIZE), then the
+	 * return address is actually off by one word, and we
+	 * need to adjust for that.
+	 */
+	if (ftrace_find_direct_func(self_addr + MCOUNT_INSN_SIZE)) {
+		self_addr = *parent;
+		parent++;
+	}
+
 	/*
 	 * Protect against fault, even if it shouldn't
 	 * happen. This tool is too much intrusive to
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 809d54397dba..5d946ab40b52 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -88,6 +88,7 @@ EXPORT_SYMBOL(__fentry__)
 	movq %rdi, RDI(%rsp)
 	movq %r8, R8(%rsp)
 	movq %r9, R9(%rsp)
+	movq $0, ORIG_RAX(%rsp)
 	/*
 	 * Save the original RBP. Even though the mcount ABI does not
 	 * require this, it helps out callers.
@@ -114,7 +115,8 @@ EXPORT_SYMBOL(__fentry__)
 	subq $MCOUNT_INSN_SIZE, %rdi
 	.endm
 
-.macro restore_mcount_regs
+.macro restore_mcount_regs save=0
+
 	movq R9(%rsp), %r9
 	movq R8(%rsp), %r8
 	movq RDI(%rsp), %rdi
@@ -123,10 +125,7 @@ EXPORT_SYMBOL(__fentry__)
 	movq RCX(%rsp), %rcx
 	movq RAX(%rsp), %rax
 
-	/* ftrace_regs_caller can modify %rbp */
-	movq RBP(%rsp), %rbp
-
-	addq $MCOUNT_REG_SIZE, %rsp
+	addq $MCOUNT_REG_SIZE-\save, %rsp
 
 	.endm
 
@@ -228,10 +227,30 @@ GLOBAL(ftrace_regs_call)
 	movq R10(%rsp), %r10
 	movq RBX(%rsp), %rbx
 
-	restore_mcount_regs
+	movq RBP(%rsp), %rbp
+
+	movq ORIG_RAX(%rsp), %rax
+	movq %rax, MCOUNT_REG_SIZE-8(%rsp)
+
+	/* If ORIG_RAX is anything but zero, make this a call to that */
+	movq ORIG_RAX(%rsp), %rax
+	cmpq	$0, %rax
+	je	1f
+
+	/* Swap the flags with orig_rax */
+	movq MCOUNT_REG_SIZE(%rsp), %rdi
+	movq %rdi, MCOUNT_REG_SIZE-8(%rsp)
+	movq %rax, MCOUNT_REG_SIZE(%rsp)
+
+	restore_mcount_regs 8
+
+	jmp	2f
+
+1:	restore_mcount_regs
+
 
 	/* Restore flags */
-	popfq
+2:	popfq
 
 	/*
 	 * As this jmp to ftrace_epilogue can be a short jump
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8b37b8105398..2bc7bd6b8387 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -272,6 +272,12 @@ static inline struct ftrace_direct_func *ftrace_find_direct_func(unsigned long a
  * via ftrace (because there's other callbacks besides the
  * direct call), can inform the architecture's trampoline that this
  * routine has a direct caller, and what the caller is.
+ *
+ * For example, in x86, it returns the direct caller
+ * callback function via the regs->orig_ax parameter.
+ * Then in the ftrace trampoline, if this is set, it makes
+ * the return from the trampoline jump to the direct caller
+ * instead of going back to the function it just traced.
  */
 static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs,
 						 unsigned long addr) { }
-- 
2.23.0


