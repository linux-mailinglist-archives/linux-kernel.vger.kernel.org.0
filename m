Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A89BAA787
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 17:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390689AbfIEPoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 11:44:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390545AbfIEPno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EF722196E;
        Thu,  5 Sep 2019 15:43:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tvD-0007cp-IQ; Thu, 05 Sep 2019 11:43:43 -0400
Message-Id: <20190905154343.460399508@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:43:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiping Ma <jiping.ma2@windriver.com>,
        Will Deacon <will@kernel.org>
Subject: [for-next][PATCH 22/25] tracing/arm64: Have max stack tracer handle the case of return
 address after data
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Most archs (well at least x86) store the function call return address on the
stack before storing the local variables for the function. The max stack
tracer depends on this in its algorithm to display the stack size of each
function it finds in the back trace.

Some archs (arm64), may store the return address (from its link register)
just before calling a nested function. There's no reason to save the link
register on leaf functions, as it wont be updated. This breaks the algorithm
of the max stack tracer.

Add a new define ARCH_FTRACE_SHIFT_STACK_TRACER that an architecture may set
if it stores the return address (link register) after it stores the
function's local variables, and have the stack trace shift the values of the
mapped stack size to the appropriate functions.

Link: 20190802094103.163576-1-jiping.ma2@windriver.com

Reported-by: Jiping Ma <jiping.ma2@windriver.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/arm64/include/asm/ftrace.h | 13 +++++++++++++
 kernel/trace/trace_stack.c      | 14 ++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 5ab5200b2bdc..d48667b04c41 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -14,6 +14,19 @@
 #define MCOUNT_ADDR		((unsigned long)_mcount)
 #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
 
+/*
+ * Currently, gcc tends to save the link register after the local variables
+ * on the stack. This causes the max stack tracer to report the function
+ * frame sizes for the wrong functions. By defining
+ * ARCH_FTRACE_SHIFT_STACK_TRACER, it will tell the stack tracer to expect
+ * to find the return address on the stack after the local variables have
+ * been set up.
+ *
+ * Note, this may change in the future, and we will need to deal with that
+ * if it were to happen.
+ */
+#define ARCH_FTRACE_SHIFT_STACK_TRACER 1
+
 #ifndef __ASSEMBLY__
 #include <linux/compat.h>
 
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 5d16f73898db..642a850af81a 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -158,6 +158,20 @@ static void check_stack(unsigned long ip, unsigned long *stack)
 			i++;
 	}
 
+#ifdef ARCH_FTRACE_SHIFT_STACK_TRACER
+	/*
+	 * Some archs will store the link register before calling
+	 * nested functions. This means the saved return address
+	 * comes after the local storage, and we need to shift
+	 * for that.
+	 */
+	if (x > 1) {
+		memmove(&stack_trace_index[0], &stack_trace_index[1],
+			sizeof(stack_trace_index[0]) * (x - 1));
+		x--;
+	}
+#endif
+
 	stack_trace_nr_entries = x;
 
 	if (task_stack_end_corrupted(current)) {
-- 
2.20.1


