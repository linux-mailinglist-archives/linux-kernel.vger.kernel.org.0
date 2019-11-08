Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0D58F5A1C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 22:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbfKHVf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 16:35:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732901AbfKHVew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:34:52 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31FC0222CD;
        Fri,  8 Nov 2019 21:34:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iTBu6-0007wb-4q; Fri, 08 Nov 2019 16:34:50 -0500
Message-Id: <20191108213450.032003836@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 08 Nov 2019 16:28:37 -0500
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
Subject: [PATCH 03/10] ftrace: Add register_ftrace_direct()
References: <20191108212834.594904349@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add the start of the functionality to allow other trampolines to use the
ftrace mcount/fentry/nop location. This adds two new functions:

 register_ftrace_direct() and unregister_ftrace_direct()

Both take two parameters: the first is the instruction address of where the
mcount/fentry/nop exists, and the second is the trampoline to have that
location called.

This will handle cases where ftrace is already used on that same location,
and will make it still work, where the registered direct called trampoline
will get called after all the registered ftrace callers are handled.

Currently, it will not allow for IP_MODIFY functions to be called at the
same locations, which include some kprobes and live kernel patching.

At this point, no architecture supports this. This is only the start of
implementing the framework.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  36 +++++-
 kernel/trace/Kconfig   |   8 ++
 kernel/trace/ftrace.c  | 272 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 309 insertions(+), 7 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8385cafe4f9f..efe3e521aff4 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -144,6 +144,8 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops);
  * TRACE_ARRAY - The ops->private points to a trace_array descriptor.
  * PERMANENT - Set when the ops is permanent and should not be affected by
  *             ftrace_enabled.
+ * DIRECT - Used by the direct ftrace_ops helper for direct functions
+ *            (internal ftrace only, should not be used by others)
  */
 enum {
 	FTRACE_OPS_FL_ENABLED			= 1 << 0,
@@ -163,6 +165,7 @@ enum {
 	FTRACE_OPS_FL_RCU			= 1 << 14,
 	FTRACE_OPS_FL_TRACE_ARRAY		= 1 << 15,
 	FTRACE_OPS_FL_PERMANENT                 = 1 << 16,
+	FTRACE_OPS_FL_DIRECT			= 1 << 17,
 };
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -242,6 +245,32 @@ static inline void ftrace_free_init_mem(void) { }
 static inline void ftrace_free_mem(struct module *mod, void *start, void *end) { }
 #endif /* CONFIG_FUNCTION_TRACER */
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+int register_ftrace_direct(unsigned long ip, unsigned long addr);
+int unregister_ftrace_direct(unsigned long ip, unsigned long addr);
+#else
+static inline int register_ftrace_direct(unsigned long ip, unsigned long addr)
+{
+	return -ENODEV;
+}
+static inline int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+
+#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+/*
+ * This must be implemented by the architecture.
+ * It is the way the ftrace direct_ops helper, when called
+ * via ftrace (because there's other callbacks besides the
+ * direct call), can inform the architecture's trampoline that this
+ * routine has a direct caller, and what the caller is.
+ */
+static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs,
+						 unsigned long addr) { }
+#endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+
 #ifdef CONFIG_STACK_TRACER
 
 extern int stack_tracer_enabled;
@@ -333,6 +362,7 @@ bool is_ftrace_trampoline(unsigned long addr);
  *  REGS_EN - the function is set up to save regs.
  *  IPMODIFY - the record allows for the IP address to be changed.
  *  DISABLED - the record is not ready to be touched yet
+ *  DIRECT   - there is a direct function to call
  *
  * When a new ftrace_ops is registered and wants a function to save
  * pt_regs, the rec->flag REGS is set. When the function has been
@@ -348,10 +378,12 @@ enum {
 	FTRACE_FL_TRAMP_EN	= (1UL << 27),
 	FTRACE_FL_IPMODIFY	= (1UL << 26),
 	FTRACE_FL_DISABLED	= (1UL << 25),
+	FTRACE_FL_DIRECT	= (1UL << 24),
+	FTRACE_FL_DIRECT_EN	= (1UL << 23),
 };
 
-#define FTRACE_REF_MAX_SHIFT	25
-#define FTRACE_FL_BITS		7
+#define FTRACE_REF_MAX_SHIFT	23
+#define FTRACE_FL_BITS		9
 #define FTRACE_FL_MASKED_BITS	((1UL << FTRACE_FL_BITS) - 1)
 #define FTRACE_FL_MASK		(FTRACE_FL_MASKED_BITS << FTRACE_REF_MAX_SHIFT)
 #define FTRACE_REF_MAX		((1UL << FTRACE_REF_MAX_SHIFT) - 1)
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e08527f50d2a..624a05e99b0b 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -33,6 +33,9 @@ config HAVE_DYNAMIC_FTRACE
 config HAVE_DYNAMIC_FTRACE_WITH_REGS
 	bool
 
+config HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	bool
+
 config HAVE_FTRACE_MCOUNT_RECORD
 	bool
 	help
@@ -557,6 +560,11 @@ config DYNAMIC_FTRACE_WITH_REGS
 	depends on DYNAMIC_FTRACE
 	depends on HAVE_DYNAMIC_FTRACE_WITH_REGS
 
+config DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	def_bool y
+	depends on DYNAMIC_FTRACE
+	depends on HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+
 config FUNCTION_PROFILER
 	bool "Kernel function profiler"
 	depends on FUNCTION_TRACER
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b0e7f03919de..a06671f3a281 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1023,6 +1023,7 @@ static bool update_all_ops;
 struct ftrace_func_entry {
 	struct hlist_node hlist;
 	unsigned long ip;
+	unsigned long direct; /* for direct lookup only */
 };
 
 struct ftrace_func_probe {
@@ -1730,6 +1731,9 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 			if (FTRACE_WARN_ON(ftrace_rec_count(rec) == FTRACE_REF_MAX))
 				return false;
 
+			if (ops->flags & FTRACE_OPS_FL_DIRECT)
+				rec->flags |= FTRACE_FL_DIRECT;
+
 			/*
 			 * If there's only a single callback registered to a
 			 * function, and the ops has a trampoline registered
@@ -1757,6 +1761,18 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 				return false;
 			rec->flags--;
 
+			if (ops->flags & FTRACE_OPS_FL_DIRECT)
+				rec->flags &= ~FTRACE_FL_DIRECT;
+
+			/*
+			 * Only the internal direct_ops should have the
+			 * DIRECT flag set. Thus, if it is removing a
+			 * function, then that function should no longer
+			 * be direct.
+			 */
+			if (ops->flags & FTRACE_OPS_FL_DIRECT)
+				rec->flags &= ~FTRACE_FL_DIRECT;
+
 			/*
 			 * If the rec had REGS enabled and the ops that is
 			 * being removed had REGS set, then see if there is
@@ -2092,15 +2108,34 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
 	 * If enabling and the REGS flag does not match the REGS_EN, or
 	 * the TRAMP flag doesn't match the TRAMP_EN, then do not ignore
 	 * this record. Set flags to fail the compare against ENABLED.
+	 * Same for direct calls.
 	 */
 	if (flag) {
-		if (!(rec->flags & FTRACE_FL_REGS) != 
+		if (!(rec->flags & FTRACE_FL_REGS) !=
 		    !(rec->flags & FTRACE_FL_REGS_EN))
 			flag |= FTRACE_FL_REGS;
 
-		if (!(rec->flags & FTRACE_FL_TRAMP) != 
+		if (!(rec->flags & FTRACE_FL_TRAMP) !=
 		    !(rec->flags & FTRACE_FL_TRAMP_EN))
 			flag |= FTRACE_FL_TRAMP;
+
+		/*
+		 * Direct calls are special, as count matters.
+		 * We must test the record for direct, if the
+		 * DIRECT and DIRECT_EN do not match, but only
+		 * if the count is 1. That's because, if the
+		 * count is something other than one, we do not
+		 * want the direct enabled (it will be done via the
+		 * direct helper). But if DIRECT_EN is set, and
+		 * the count is not one, we need to clear it.
+		 */
+		if (ftrace_rec_count(rec) == 1) {
+			if (!(rec->flags & FTRACE_FL_DIRECT) !=
+			    !(rec->flags & FTRACE_FL_DIRECT_EN))
+				flag |= FTRACE_FL_DIRECT;
+		} else if (rec->flags & FTRACE_FL_DIRECT_EN) {
+			flag |= FTRACE_FL_DIRECT;
+		}
 	}
 
 	/* If the state of this record hasn't changed, then do nothing */
@@ -2125,6 +2160,25 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
 				else
 					rec->flags &= ~FTRACE_FL_TRAMP_EN;
 			}
+			if (flag & FTRACE_FL_DIRECT) {
+				/*
+				 * If there's only one user (direct_ops helper)
+				 * then we can call the direct function
+				 * directly (no ftrace trampoline).
+				 */
+				if (ftrace_rec_count(rec) == 1) {
+					if (rec->flags & FTRACE_FL_DIRECT)
+						rec->flags |= FTRACE_FL_DIRECT_EN;
+					else
+						rec->flags &= ~FTRACE_FL_DIRECT_EN;
+				} else {
+					/*
+					 * Can only call directly if there's
+					 * only one callback to the function.
+					 */
+					rec->flags &= ~FTRACE_FL_DIRECT_EN;
+				}
+			}
 		}
 
 		/*
@@ -2154,7 +2208,7 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
 			 * and REGS states. The _EN flags must be disabled though.
 			 */
 			rec->flags &= ~(FTRACE_FL_ENABLED | FTRACE_FL_TRAMP_EN |
-					FTRACE_FL_REGS_EN);
+					FTRACE_FL_REGS_EN | FTRACE_FL_DIRECT_EN);
 	}
 
 	ftrace_bug_type = FTRACE_BUG_NOP;
@@ -2309,6 +2363,51 @@ ftrace_find_tramp_ops_new(struct dyn_ftrace *rec)
 	return NULL;
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+/* Protected by rcu_tasks for reading, and direct_mutex for writing */
+static struct ftrace_hash *direct_functions = EMPTY_HASH;
+static DEFINE_MUTEX(direct_mutex);
+
+/*
+ * Search the direct_functions hash to see if the given instruction pointer
+ * has a direct caller attached to it.
+ */
+static unsigned long find_rec_direct(unsigned long ip)
+{
+	struct ftrace_func_entry *entry;
+
+	entry = __ftrace_lookup_ip(direct_functions, ip);
+	if (!entry)
+		return 0;
+
+	return entry->direct;
+}
+
+static void call_direct_funcs(unsigned long ip, unsigned long pip,
+			      struct ftrace_ops *ops, struct pt_regs *regs)
+{
+	unsigned long addr;
+
+	addr = find_rec_direct(ip);
+	if (!addr)
+		return;
+
+	arch_ftrace_set_direct_caller(regs, addr);
+}
+
+struct ftrace_ops direct_ops = {
+	.func		= call_direct_funcs,
+	.flags		= FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_RECURSION_SAFE
+			  | FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS
+			  | FTRACE_OPS_FL_PERMANENT,
+};
+#else
+static inline unsigned long find_rec_direct(unsigned long ip)
+{
+	return 0;
+}
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+
 /**
  * ftrace_get_addr_new - Get the call address to set to
  * @rec:  The ftrace record descriptor
@@ -2322,6 +2421,15 @@ ftrace_find_tramp_ops_new(struct dyn_ftrace *rec)
 unsigned long ftrace_get_addr_new(struct dyn_ftrace *rec)
 {
 	struct ftrace_ops *ops;
+	unsigned long addr;
+
+	if ((rec->flags & FTRACE_FL_DIRECT) &&
+	    (ftrace_rec_count(rec) == 1)) {
+		addr = find_rec_direct(rec->ip);
+		if (addr)
+			return addr;
+		WARN_ON_ONCE(1);
+	}
 
 	/* Trampolines take precedence over regs */
 	if (rec->flags & FTRACE_FL_TRAMP) {
@@ -2354,6 +2462,15 @@ unsigned long ftrace_get_addr_new(struct dyn_ftrace *rec)
 unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec)
 {
 	struct ftrace_ops *ops;
+	unsigned long addr;
+
+	/* Direct calls take precedence over trampolines */
+	if (rec->flags & FTRACE_FL_DIRECT_EN) {
+		addr = find_rec_direct(rec->ip);
+		if (addr)
+			return addr;
+		WARN_ON_ONCE(1);
+	}
 
 	/* Trampolines take precedence over regs */
 	if (rec->flags & FTRACE_FL_TRAMP_EN) {
@@ -3465,10 +3582,11 @@ static int t_show(struct seq_file *m, void *v)
 	if (iter->flags & FTRACE_ITER_ENABLED) {
 		struct ftrace_ops *ops;
 
-		seq_printf(m, " (%ld)%s%s",
+		seq_printf(m, " (%ld)%s%s%s",
 			   ftrace_rec_count(rec),
 			   rec->flags & FTRACE_FL_REGS ? " R" : "  ",
-			   rec->flags & FTRACE_FL_IPMODIFY ? " I" : "  ");
+			   rec->flags & FTRACE_FL_IPMODIFY ? " I" : "  ",
+			   rec->flags & FTRACE_FL_DIRECT ? " D" : "  ");
 		if (rec->flags & FTRACE_FL_TRAMP_EN) {
 			ops = ftrace_find_tramp_ops_any(rec);
 			if (ops) {
@@ -3484,6 +3602,13 @@ static int t_show(struct seq_file *m, void *v)
 		} else {
 			add_trampoline_func(m, NULL, rec);
 		}
+		if (rec->flags & FTRACE_FL_DIRECT) {
+			unsigned long direct;
+
+			direct = find_rec_direct(rec->ip);
+			if (direct)
+				seq_printf(m, "\n\tdirect-->%pS", (void *)direct);
+		}
 	}	
 
 	seq_putc(m, '\n');
@@ -4815,6 +4940,143 @@ ftrace_set_addr(struct ftrace_ops *ops, unsigned long ip, int remove,
 	return ftrace_set_hash(ops, NULL, 0, ip, remove, reset, enable);
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+/**
+ * register_ftrace_direct - Call a custom trampoline directly
+ * @ip: The address of the nop at the beginning of a function
+ * @addr: The address of the trampoline to call at @ip
+ *
+ * This is used to connect a direct call from the nop location (@ip)
+ * at the start of ftrace traced functions. The location that it calls
+ * (@addr) must be able to handle a direct call, and save the parameters
+ * of the function being traced, and restore them (or inject new ones
+ * if needed), before returning.
+ *
+ * Returns:
+ *  0 on success
+ *  -EBUSY - Another direct function is already attached (there can be only one)
+ *  -ENODEV - @ip does not point to a ftrace nop location (or not supported)
+ *  -ENOMEM - There was an allocation failure.
+ */
+int register_ftrace_direct(unsigned long ip, unsigned long addr)
+{
+	struct ftrace_func_entry *entry;
+	struct ftrace_hash *free_hash = NULL;
+	struct dyn_ftrace *rec;
+	int ret = -EBUSY;
+
+	mutex_lock(&direct_mutex);
+
+	/* See if there's a direct function at @ip already */
+	if (find_rec_direct(ip))
+		goto out_unlock;
+
+	ret = -ENODEV;
+	rec = lookup_rec(ip, ip);
+	if (!rec)
+		goto out_unlock;
+
+	/*
+	 * Check if the rec says it has a direct call but we didn't
+	 * find one earlier?
+	 */
+	if (WARN_ON(rec->flags & FTRACE_FL_DIRECT))
+		goto out_unlock;
+
+	/* Make sure the ip points to the exact record */
+	ip = rec->ip;
+
+	ret = -ENOMEM;
+	if (ftrace_hash_empty(direct_functions) ||
+	    direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
+		struct ftrace_hash *new_hash;
+		int size = ftrace_hash_empty(direct_functions) ? 0 :
+			direct_functions->count + 1;
+
+		if (size < 32)
+			size = 32;
+
+		new_hash = dup_hash(direct_functions, size);
+		if (!new_hash)
+			goto out_unlock;
+
+		free_hash = direct_functions;
+		direct_functions = new_hash;
+	}
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		goto out_unlock;
+
+	entry->ip = ip;
+	entry->direct = addr;
+	__add_hash_entry(direct_functions, entry);
+
+	ret = ftrace_set_filter_ip(&direct_ops, ip, 0, 0);
+	if (ret)
+		remove_hash_entry(direct_functions, entry);
+
+	if (!ret && !(direct_ops.flags & FTRACE_OPS_FL_ENABLED)) {
+		ret = register_ftrace_function(&direct_ops);
+		if (ret)
+			ftrace_set_filter_ip(&direct_ops, ip, 1, 0);
+	}
+
+	if (ret)
+		kfree(entry);
+ out_unlock:
+	mutex_unlock(&direct_mutex);
+
+	if (free_hash) {
+		synchronize_rcu_tasks();
+		free_ftrace_hash(free_hash);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(register_ftrace_direct);
+
+int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
+{
+	struct ftrace_func_entry *entry;
+	struct dyn_ftrace *rec;
+	int ret = -ENODEV;
+
+	mutex_lock(&direct_mutex);
+
+	entry = __ftrace_lookup_ip(direct_functions, ip);
+	if (!entry) {
+		/* OK if it is off by a little */
+		rec = lookup_rec(ip, ip);
+		if (!rec || rec->ip == ip)
+			goto out_unlock;
+
+		entry = __ftrace_lookup_ip(direct_functions, rec->ip);
+		if (!entry) {
+			WARN_ON(rec->flags & FTRACE_FL_DIRECT);
+			goto out_unlock;
+		}
+
+		WARN_ON(!(rec->flags & FTRACE_FL_DIRECT));
+	}
+
+	if (direct_functions->count == 1)
+		unregister_ftrace_function(&direct_ops);
+
+	ret = ftrace_set_filter_ip(&direct_ops, ip, 1, 0);
+
+	WARN_ON(ret);
+
+	remove_hash_entry(direct_functions, entry);
+
+ out_unlock:
+	mutex_unlock(&direct_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(unregister_ftrace_direct);
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+
 /**
  * ftrace_set_filter_ip - set a function to filter on in ftrace by address
  * @ops - the ops to set the filter with
-- 
2.23.0


