Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B5C12F33C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 04:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgACDJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 22:09:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgACDJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:09:57 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CAA621D7D;
        Fri,  3 Jan 2020 03:09:56 +0000 (UTC)
Date:   Thu, 2 Jan 2020 22:09:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Have stack tracer compile when MCOUNT_INSN_SIZE is
 not defined
Message-ID: <20200102220955.05975d6e@rorschach.local.home>
In-Reply-To: <20200102220754.5dc61fcc@rorschach.local.home>
References: <202001020219.zvE3vsty%lkp@intel.com>
        <20200102220754.5dc61fcc@rorschach.local.home>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

On some archs with some configurations, MCOUNT_INSN_SIZE is not defined, and
this makes the stack tracer fail to compile. Just define it to zero in this
case.

Link: https://lore.kernel.org/r/202001020219.zvE3vsty%lkp@intel.com

Cc: stable@vger.kernel.org
Fixes: 4df297129f622 ("tracing: Remove most or all of stack tracer stack size from stack_max_size")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_stack.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 4df9a209f7ca..c557f42a9397 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -283,6 +283,11 @@ static void check_stack(unsigned long ip, unsigned long *stack)
 	local_irq_restore(flags);
 }
 
+/* Some archs may not define MCOUNT_INSN_SIZE */
+#ifndef MCOUNT_INSN_SIZE
+# define MCOUNT_INSN_SIZE 0
+#endif
+
 static void
 stack_trace_call(unsigned long ip, unsigned long parent_ip,
 		 struct ftrace_ops *op, struct pt_regs *pt_regs)
-- 
2.20.1

