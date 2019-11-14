Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59378FCD2F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 19:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfKNST4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 13:19:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:35794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbfKNSS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DABC320857;
        Thu, 14 Nov 2019 18:18:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhK-00016o-3u; Thu, 14 Nov 2019 13:18:26 -0500
Message-Id: <20191114181825.998435008@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:17:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [for-next][PATCH 18/33] tracing: Use CONFIG_PREEMPTION
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Add additional header output for PREEMPT_RT.
Link: http://lkml.kernel.org/r/20191015191821.11479-34-bigeasy@linutronix.de

Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace-uses.rst | 2 +-
 kernel/trace/trace.c                | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
index 740bd0224d35..2a05e770618a 100644
--- a/Documentation/trace/ftrace-uses.rst
+++ b/Documentation/trace/ftrace-uses.rst
@@ -146,7 +146,7 @@ FTRACE_OPS_FL_RECURSION_SAFE
 	itself or any nested functions that those functions call.
 
 	If this flag is set, it is possible that the callback will also
-	be called with preemption enabled (when CONFIG_PREEMPT is set),
+	be called with preemption enabled (when CONFIG_PREEMPTION is set),
 	but this is not guaranteed.
 
 FTRACE_OPS_FL_IPMODIFY
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f093a433cb42..db7d06a26861 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3726,6 +3726,8 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
 		   "desktop",
 #elif defined(CONFIG_PREEMPT)
 		   "preempt",
+#elif defined(CONFIG_PREEMPT_RT)
+		   "preempt_rt",
 #else
 		   "unknown",
 #endif
-- 
2.23.0


