Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69467F5A1D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 22:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbfKHVf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 16:35:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732903AbfKHVew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:34:52 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DAAD222CE;
        Fri,  8 Nov 2019 21:34:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iTBu6-0007x5-9l; Fri, 08 Nov 2019 16:34:50 -0500
Message-Id: <20191108213450.181040649@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 08 Nov 2019 16:28:38 -0500
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
Subject: [PATCH 04/10] ftrace: Add ftrace_find_direct_func()
References: <20191108212834.594904349@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As function_graph tracer modifies the return address to insert a trampoline
to trace the return of a function, it must be aware of a direct caller, as
when it gets called, the function's return address may not be at on the
stack where it expects. It may have to see if that return address points to
the a direct caller and adjust if it is.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  6 ++++
 kernel/trace/ftrace.c  | 79 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index efe3e521aff4..8b37b8105398 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -51,6 +51,7 @@ static inline void early_trace_init(void) { }
 
 struct module;
 struct ftrace_hash;
+struct ftrace_direct_func;
 
 #if defined(CONFIG_FUNCTION_TRACER) && defined(CONFIG_MODULES) && \
 	defined(CONFIG_DYNAMIC_FTRACE)
@@ -248,6 +249,7 @@ static inline void ftrace_free_mem(struct module *mod, void *start, void *end) {
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 int register_ftrace_direct(unsigned long ip, unsigned long addr);
 int unregister_ftrace_direct(unsigned long ip, unsigned long addr);
+struct ftrace_direct_func *ftrace_find_direct_func(unsigned long addr);
 #else
 static inline int register_ftrace_direct(unsigned long ip, unsigned long addr)
 {
@@ -257,6 +259,10 @@ static inline int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 {
 	return -ENODEV;
 }
+static inline struct ftrace_direct_func *ftrace_find_direct_func(unsigned long addr)
+{
+	return NULL;
+}
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a06671f3a281..f57ab704dc2d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4941,6 +4941,46 @@ ftrace_set_addr(struct ftrace_ops *ops, unsigned long ip, int remove,
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+
+struct ftrace_direct_func {
+	struct list_head	next;
+	unsigned long		addr;
+	int			count;
+};
+
+static LIST_HEAD(ftrace_direct_funcs);
+
+/**
+ * ftrace_find_direct_func - test an address if it is a registered direct caller
+ * @addr: The address of a registered direct caller
+ *
+ * This searches to see if a ftrace direct caller has been registered
+ * at a specific address, and if so, it returns a descriptor for it.
+ *
+ * This can be used by architecture code to see if an address is
+ * a direct caller (trampoline) attached to a fentry/mcount location.
+ * This is useful for the function_graph tracer, as it may need to
+ * do adjustments if it traced a location that also has a direct
+ * trampoline attached to it.
+ */
+struct ftrace_direct_func *ftrace_find_direct_func(unsigned long addr)
+{
+	struct ftrace_direct_func *entry;
+	bool found = false;
+
+	/* May be called by fgraph trampoline (protected by rcu tasks) */
+	list_for_each_entry_rcu(entry, &ftrace_direct_funcs, next) {
+		if (entry->addr == addr) {
+			found = true;
+			break;
+		}
+	}
+	if (found)
+		return entry;
+
+	return NULL;
+}
+
 /**
  * register_ftrace_direct - Call a custom trampoline directly
  * @ip: The address of the nop at the beginning of a function
@@ -4960,6 +5000,7 @@ ftrace_set_addr(struct ftrace_ops *ops, unsigned long ip, int remove,
  */
 int register_ftrace_direct(unsigned long ip, unsigned long addr)
 {
+	struct ftrace_direct_func *direct;
 	struct ftrace_func_entry *entry;
 	struct ftrace_hash *free_hash = NULL;
 	struct dyn_ftrace *rec;
@@ -5008,6 +5049,18 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 	if (!entry)
 		goto out_unlock;
 
+	direct = ftrace_find_direct_func(addr);
+	if (!direct) {
+		direct = kmalloc(sizeof(*direct), GFP_KERNEL);
+		if (!direct) {
+			kfree(entry);
+			goto out_unlock;
+		}
+		direct->addr = addr;
+		direct->count = 0;
+		list_add_rcu(&direct->next, &ftrace_direct_funcs);
+	}
+
 	entry->ip = ip;
 	entry->direct = addr;
 	__add_hash_entry(direct_functions, entry);
@@ -5022,8 +5075,20 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 			ftrace_set_filter_ip(&direct_ops, ip, 1, 0);
 	}
 
-	if (ret)
+	if (ret) {
 		kfree(entry);
+		if (!direct->count) {
+			list_del_rcu(&direct->next);
+			synchronize_rcu_tasks();
+			kfree(direct);
+			if (free_hash)
+				free_ftrace_hash(free_hash);
+			free_hash = NULL;
+		}
+	} else {
+		if (!direct->count)
+			direct->count++;
+	}
  out_unlock:
 	mutex_unlock(&direct_mutex);
 
@@ -5039,6 +5104,7 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct);
 int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 {
 	struct ftrace_func_entry *entry;
+	struct ftrace_direct_func *direct;
 	struct dyn_ftrace *rec;
 	int ret = -ENODEV;
 
@@ -5069,6 +5135,17 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 
 	remove_hash_entry(direct_functions, entry);
 
+	direct = ftrace_find_direct_func(addr);
+	if (!WARN_ON(!direct)) {
+		/* This is the good path (see the ! before WARN) */
+		direct->count--;
+		WARN_ON(direct->count < 0);
+		if (!direct->count) {
+			list_del_rcu(&direct->next);
+			synchronize_rcu_tasks();
+			kfree(direct);
+		}
+	}
  out_unlock:
 	mutex_unlock(&direct_mutex);
 
-- 
2.23.0


