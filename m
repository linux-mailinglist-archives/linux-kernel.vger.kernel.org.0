Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D18D239BD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 16:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389345AbfETOWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 10:22:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387918AbfETOV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:21:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D059821721;
        Mon, 20 May 2019 14:21:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hSjAq-0003Os-V8; Mon, 20 May 2019 10:21:56 -0400
Message-Id: <20190520142156.854498464@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 20 May 2019 10:20:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: [RFC][PATCH 02/14 v2] function_graph: Add an array structure that will allow multiple
 callbacks
References: <20190520142001.270067280@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add an array structure that will eventually allow the function graph tracer
to have up to 16 simultaneous callbacks attached. It's an array of 16
fgraph_ops pointers, that is assigned when one is registered. On entry of a
function the entry of the first item in the array is called, and if it
returns zero, then the callback returns non zero if it wants the return
callback to be called on exit of the function.

The array will simplify the process of having more than one callback
attached to the same function, as its index into the array can be stored on
the shadow stack. We need to only save the index, because this will allow
the fgraph_ops to be freed before the function returns (which may happen if
the function call schedule for a long time).

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 98 ++++++++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 33 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index db0c387756a3..c765906d846d 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -38,9 +38,27 @@
 static bool kill_ftrace_graph;
 int ftrace_graph_active;
 
+#define FGRAPH_ARRAY_SIZE	16
+
+static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
+
 /* Both enabled by default (can be cleared by function_graph tracer flags */
 static bool fgraph_sleep_time = true;
 
+int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
+{
+	return 0;
+}
+
+static void ftrace_graph_ret_stub(struct ftrace_graph_ret *trace)
+{
+}
+
+static struct fgraph_ops fgraph_stub = {
+	.entryfunc = ftrace_graph_entry_stub,
+	.retfunc = ftrace_graph_ret_stub,
+};
+
 /**
  * ftrace_graph_is_dead - returns true if ftrace_graph_stop() was called
  *
@@ -123,7 +141,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 		goto out;
 
 	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace))
+	if (!fgraph_array[0]->entryfunc(&trace))
 		goto out_ret;
 
 	return 0;
@@ -231,7 +249,7 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 
 	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
 	trace.rettime = trace_clock_local();
-	ftrace_graph_return(&trace);
+	fgraph_array[0]->retfunc(&trace);
 	/*
 	 * The ftrace_graph_return() may still access the current
 	 * ret_stack structure, we need to make sure the update of
@@ -349,11 +367,6 @@ void ftrace_graph_sleep_time_control(bool enable)
 	fgraph_sleep_time = enable;
 }
 
-int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
-{
-	return 0;
-}
-
 /* The callbacks that hook a function */
 trace_func_graph_ret_t ftrace_graph_return =
 			(trace_func_graph_ret_t)ftrace_stub;
@@ -586,37 +599,53 @@ static int start_graph_tracing(void)
 int register_ftrace_graph(struct fgraph_ops *gops)
 {
 	int ret = 0;
+	int i;
 
 	mutex_lock(&ftrace_lock);
 
-	/* we currently allow only one tracer registered at a time */
-	if (ftrace_graph_active) {
+	if (!fgraph_array[0]) {
+		/* The array must always have real data on it */
+		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
+			fgraph_array[i] = &fgraph_stub;
+		}
+	}
+
+	/* Look for an available spot */
+	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
+		if (fgraph_array[i] == &fgraph_stub)
+			break;
+	}
+	if (i >= FGRAPH_ARRAY_SIZE) {
 		ret = -EBUSY;
 		goto out;
 	}
 
-	register_pm_notifier(&ftrace_suspend_notifier);
+	fgraph_array[i] = gops;
 
 	ftrace_graph_active++;
-	ret = start_graph_tracing();
-	if (ret) {
-		ftrace_graph_active--;
-		goto out;
-	}
 
-	ftrace_graph_return = gops->retfunc;
+	if (ftrace_graph_active == 1) {
+		register_pm_notifier(&ftrace_suspend_notifier);
+		ret = start_graph_tracing();
+		if (ret) {
+			ftrace_graph_active--;
+			goto out;
+		}
+
+		ftrace_graph_return = gops->retfunc;
 
-	/*
-	 * Update the indirect function to the entryfunc, and the
-	 * function that gets called to the entry_test first. Then
-	 * call the update fgraph entry function to determine if
-	 * the entryfunc should be called directly or not.
-	 */
-	__ftrace_graph_entry = gops->entryfunc;
-	ftrace_graph_entry = ftrace_graph_entry_test;
-	update_function_graph_func();
+		/*
+		 * Update the indirect function to the entryfunc, and the
+		 * function that gets called to the entry_test first. Then
+		 * call the update fgraph entry function to determine if
+		 * the entryfunc should be called directly or not.
+		 */
+		__ftrace_graph_entry = gops->entryfunc;
+		ftrace_graph_entry = ftrace_graph_entry_test;
+		update_function_graph_func();
 
-	ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
+		ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
+	}
 out:
 	mutex_unlock(&ftrace_lock);
 	return ret;
@@ -624,19 +653,22 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 
 void unregister_ftrace_graph(struct fgraph_ops *gops)
 {
+	int i;
+
 	mutex_lock(&ftrace_lock);
 
 	if (unlikely(!ftrace_graph_active))
 		goto out;
 
 	ftrace_graph_active--;
-	ftrace_graph_return = (trace_func_graph_ret_t)ftrace_stub;
-	ftrace_graph_entry = ftrace_graph_entry_stub;
-	__ftrace_graph_entry = ftrace_graph_entry_stub;
-	ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
-	unregister_pm_notifier(&ftrace_suspend_notifier);
-	unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
-
+	if (!ftrace_graph_active) {
+		ftrace_graph_return = (trace_func_graph_ret_t)ftrace_stub;
+		ftrace_graph_entry = ftrace_graph_entry_stub;
+		__ftrace_graph_entry = ftrace_graph_entry_stub;
+		ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
+		unregister_pm_notifier(&ftrace_suspend_notifier);
+		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
+	}
  out:
 	mutex_unlock(&ftrace_lock);
 }
-- 
2.20.1


