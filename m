Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F29D013B3F0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 22:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgANVDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 16:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbgANVDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:03:42 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17E0424696;
        Tue, 14 Jan 2020 21:03:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1irTLf-000DAU-0z; Tue, 14 Jan 2020 16:03:39 -0500
Message-Id: <20200114210338.905148486@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 16:03:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 22/26] tracing/boot: Add instance node support
References: <20200114210316.450821675@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add instance node support to boot-time tracing. User can set
some options and event nodes under instance node.

 - ftrace.instance.INSTANCE[...]
   Add new INSTANCE instance. Some options and event nodes
   are acceptable for instance node.

Link: http://lkml.kernel.org/r/157867242413.17873.9814204526141500278.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 43 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 3054921b0877..f5db30d25b0b 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -20,7 +20,7 @@ extern ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 					  unsigned long size, int cpu_id);
 
 static void __init
-trace_boot_set_ftrace_options(struct trace_array *tr, struct xbc_node *node)
+trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
 {
 	struct xbc_node *anode;
 	const char *p;
@@ -242,6 +242,40 @@ trace_boot_enable_tracer(struct trace_array *tr, struct xbc_node *node)
 	}
 }
 
+static void __init
+trace_boot_init_one_instance(struct trace_array *tr, struct xbc_node *node)
+{
+	trace_boot_set_instance_options(tr, node);
+	trace_boot_init_events(tr, node);
+	trace_boot_enable_events(tr, node);
+	trace_boot_enable_tracer(tr, node);
+}
+
+static void __init
+trace_boot_init_instances(struct xbc_node *node)
+{
+	struct xbc_node *inode;
+	struct trace_array *tr;
+	const char *p;
+
+	node = xbc_node_find_child(node, "instance");
+	if (!node)
+		return;
+
+	xbc_node_for_each_child(node, inode) {
+		p = xbc_node_get_data(inode);
+		if (!p || *p == '\0')
+			continue;
+
+		tr = trace_array_get_by_name(p);
+		if (IS_ERR(tr)) {
+			pr_err("Failed to get trace instance %s\n", p);
+			continue;
+		}
+		trace_boot_init_one_instance(tr, inode);
+	}
+}
+
 static int __init trace_boot_init(void)
 {
 	struct xbc_node *trace_node;
@@ -255,10 +289,9 @@ static int __init trace_boot_init(void)
 	if (!tr)
 		return 0;
 
-	trace_boot_set_ftrace_options(tr, trace_node);
-	trace_boot_init_events(tr, trace_node);
-	trace_boot_enable_events(tr, trace_node);
-	trace_boot_enable_tracer(tr, trace_node);
+	/* Global trace array is also one instance */
+	trace_boot_init_one_instance(tr, trace_node);
+	trace_boot_init_instances(trace_node);
 
 	return 0;
 }
-- 
2.24.1


