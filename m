Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D35A3557A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 21:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733093AbfFYTQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 15:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732040AbfFYTPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:15:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D0EF21655;
        Tue, 25 Jun 2019 19:15:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hfquw-0002MA-B9; Tue, 25 Jun 2019 15:15:46 -0400
Message-Id: <20190625191546.218076076@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 25 Jun 2019 15:15:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 09/12] tracing/probe: Add trace flag access APIs for trace_probe
References: <20190625191510.599310671@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add trace_probe_test/set/clear_flag() functions for accessing
trace_probe.flag field.
This flags field should not be accessed directly.

Link: http://lkml.kernel.org/r/155931585683.28323.314290023236905988.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 20 ++++++++++----------
 kernel/trace/trace_probe.c  |  4 ++--
 kernel/trace/trace_probe.h  | 22 ++++++++++++++++++++--
 kernel/trace/trace_uprobe.c | 18 +++++++++---------
 4 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 87a52094378c..c3ab84cb25c8 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -298,7 +298,7 @@ enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 		if (ret)
 			return ret;
 	} else
-		tk->tp.flags |= TP_FLAG_PROFILE;
+		trace_probe_set_flag(&tk->tp, TP_FLAG_PROFILE);
 
 	if (enabled)
 		return 0;
@@ -308,7 +308,7 @@ enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 		if (file)
 			trace_probe_remove_file(&tk->tp, file);
 		else
-			tk->tp.flags &= ~TP_FLAG_PROFILE;
+			trace_probe_clear_flag(&tk->tp, TP_FLAG_PROFILE);
 	}
 
 	return ret;
@@ -329,9 +329,9 @@ disable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
 			return -ENOENT;
 		if (!trace_probe_has_single_file(tp))
 			goto out;
-		tp->flags &= ~TP_FLAG_TRACE;
+		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
 	} else
-		tp->flags &= ~TP_FLAG_PROFILE;
+		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
 
 	if (!trace_probe_is_enabled(tp) && trace_probe_is_registered(tp)) {
 		if (trace_kprobe_is_return(tk))
@@ -408,7 +408,7 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 		ret = register_kprobe(&tk->rp.kp);
 
 	if (ret == 0)
-		tk->tp.flags |= TP_FLAG_REGISTERED;
+		trace_probe_set_flag(&tk->tp, TP_FLAG_REGISTERED);
 	return ret;
 }
 
@@ -420,7 +420,7 @@ static void __unregister_trace_kprobe(struct trace_kprobe *tk)
 			unregister_kretprobe(&tk->rp);
 		else
 			unregister_kprobe(&tk->rp.kp);
-		tk->tp.flags &= ~TP_FLAG_REGISTERED;
+		trace_probe_clear_flag(&tk->tp, TP_FLAG_REGISTERED);
 		/* Cleanup kprobe for reuse */
 		if (tk->rp.kp.symbol_name)
 			tk->rp.kp.addr = NULL;
@@ -1313,10 +1313,10 @@ static int kprobe_dispatcher(struct kprobe *kp, struct pt_regs *regs)
 
 	raw_cpu_inc(*tk->nhit);
 
-	if (tk->tp.flags & TP_FLAG_TRACE)
+	if (trace_probe_test_flag(&tk->tp, TP_FLAG_TRACE))
 		kprobe_trace_func(tk, regs);
 #ifdef CONFIG_PERF_EVENTS
-	if (tk->tp.flags & TP_FLAG_PROFILE)
+	if (trace_probe_test_flag(&tk->tp, TP_FLAG_PROFILE))
 		ret = kprobe_perf_func(tk, regs);
 #endif
 	return ret;
@@ -1330,10 +1330,10 @@ kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
 
 	raw_cpu_inc(*tk->nhit);
 
-	if (tk->tp.flags & TP_FLAG_TRACE)
+	if (trace_probe_test_flag(&tk->tp, TP_FLAG_TRACE))
 		kretprobe_trace_func(tk, ri, regs);
 #ifdef CONFIG_PERF_EVENTS
-	if (tk->tp.flags & TP_FLAG_PROFILE)
+	if (trace_probe_test_flag(&tk->tp, TP_FLAG_PROFILE))
 		kretprobe_perf_func(tk, ri, regs);
 #endif
 	return 0;	/* We don't tweek kernel, so just return 0 */
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index abb05608a09d..323a11ad1dad 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -948,7 +948,7 @@ int trace_probe_add_file(struct trace_probe *tp, struct trace_event_file *file)
 	link->file = file;
 	INIT_LIST_HEAD(&link->list);
 	list_add_tail_rcu(&link->list, &tp->files);
-	tp->flags |= TP_FLAG_TRACE;
+	trace_probe_set_flag(tp, TP_FLAG_TRACE);
 	return 0;
 }
 
@@ -979,7 +979,7 @@ int trace_probe_remove_file(struct trace_probe *tp,
 	kfree(link);
 
 	if (list_empty(&tp->files))
-		tp->flags &= ~TP_FLAG_TRACE;
+		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
 
 	return 0;
 }
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index ab02007e131d..87d48d850b63 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -238,14 +238,32 @@ struct event_file_link {
 	struct list_head		list;
 };
 
+static inline bool trace_probe_test_flag(struct trace_probe *tp,
+					 unsigned int flag)
+{
+	return !!(tp->flags & flag);
+}
+
+static inline void trace_probe_set_flag(struct trace_probe *tp,
+					unsigned int flag)
+{
+	tp->flags |= flag;
+}
+
+static inline void trace_probe_clear_flag(struct trace_probe *tp,
+					  unsigned int flag)
+{
+	tp->flags &= ~flag;
+}
+
 static inline bool trace_probe_is_enabled(struct trace_probe *tp)
 {
-	return !!(tp->flags & (TP_FLAG_TRACE | TP_FLAG_PROFILE));
+	return trace_probe_test_flag(tp, TP_FLAG_TRACE | TP_FLAG_PROFILE);
 }
 
 static inline bool trace_probe_is_registered(struct trace_probe *tp)
 {
-	return !!(tp->flags & TP_FLAG_REGISTERED);
+	return trace_probe_test_flag(tp, TP_FLAG_REGISTERED);
 }
 
 static inline int trace_probe_unregister_event_call(struct trace_probe *tp)
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index a9f8045b6695..f8e23ed47823 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -927,17 +927,17 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
 	int ret;
 
 	if (file) {
-		if (tu->tp.flags & TP_FLAG_PROFILE)
+		if (trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE))
 			return -EINTR;
 
 		ret = trace_probe_add_file(&tu->tp, file);
 		if (ret < 0)
 			return ret;
 	} else {
-		if (tu->tp.flags & TP_FLAG_TRACE)
+		if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
 			return -EINTR;
 
-		tu->tp.flags |= TP_FLAG_PROFILE;
+		trace_probe_set_flag(&tu->tp, TP_FLAG_PROFILE);
 	}
 
 	WARN_ON(!uprobe_filter_is_empty(&tu->filter));
@@ -970,7 +970,7 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
 	if (file)
 		trace_probe_remove_file(&tu->tp, file);
 	else
-		tu->tp.flags &= ~TP_FLAG_PROFILE;
+		trace_probe_clear_flag(&tu->tp, TP_FLAG_PROFILE);
 
 	return ret;
 }
@@ -988,7 +988,7 @@ probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
 		if (trace_probe_is_enabled(&tu->tp))
 			return;
 	} else
-		tu->tp.flags &= ~TP_FLAG_PROFILE;
+		trace_probe_clear_flag(&tu->tp, TP_FLAG_PROFILE);
 
 	WARN_ON(!uprobe_filter_is_empty(&tu->filter));
 
@@ -1266,11 +1266,11 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	ucb = uprobe_buffer_get();
 	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
 
-	if (tu->tp.flags & TP_FLAG_TRACE)
+	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
 		ret |= uprobe_trace_func(tu, regs, ucb, dsize);
 
 #ifdef CONFIG_PERF_EVENTS
-	if (tu->tp.flags & TP_FLAG_PROFILE)
+	if (trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE))
 		ret |= uprobe_perf_func(tu, regs, ucb, dsize);
 #endif
 	uprobe_buffer_put(ucb);
@@ -1301,11 +1301,11 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	ucb = uprobe_buffer_get();
 	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
 
-	if (tu->tp.flags & TP_FLAG_TRACE)
+	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
 		uretprobe_trace_func(tu, func, regs, ucb, dsize);
 
 #ifdef CONFIG_PERF_EVENTS
-	if (tu->tp.flags & TP_FLAG_PROFILE)
+	if (trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE))
 		uretprobe_perf_func(tu, func, regs, ucb, dsize);
 #endif
 	uprobe_buffer_put(ucb);
-- 
2.20.1


