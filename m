Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F95C12F33B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 04:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgACDJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 22:09:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:54592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbgACDJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:09:12 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A1F321D7D;
        Fri,  3 Jan 2020 03:09:11 +0000 (UTC)
Date:   Thu, 2 Jan 2020 22:09:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Define MCOUNT_INSN_SIZE when not defined without
 direct calls
Message-ID: <20200102220909.3847bf2d@rorschach.local.home>
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

In order to handle direct calls along side of function graph tracer, a check
is made to see if the address being traced by the function graph tracer is a
direct call or not. To get the address used by direct callers, the return
address is subtracted by MCOUNT_INSN_SIZE.

For some archs with certain configurations, MCOUNT_INSN_SIZE is undefined
here. But these should not be using direct calls anyway. Just define
MCOUNT_INSN_SIZE to zero in this case.

Link: https://lore.kernel.org/r/202001020219.zvE3vsty%lkp@intel.com

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: ff205766dbbee ("ftrace: Fix function_graph tracer interaction with BPF trampoline")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index a2659735db73..1af321dec0f1 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -96,6 +96,20 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	return 0;
 }
 
+/*
+ * Not all archs define MCOUNT_INSN_SIZE which is used to look for direct
+ * functions. But those archs currently don't support direct functions
+ * anyway, and ftrace_find_rec_direct() is just a stub for them.
+ * Define MCOUNT_INSN_SIZE to keep those archs compiling.
+ */
+#ifndef MCOUNT_INSN_SIZE
+/* Make sure this only works without direct calls */
+# ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+#  error MCOUNT_INSN_SIZE not defined with direct calls enabled
+# endif
+# define MCOUNT_INSN_SIZE 0
+#endif
+
 int function_graph_enter(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
-- 
2.20.1

