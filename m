Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9890CFFBDC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 23:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfKQWNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 17:13:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfKQWNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 17:13:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FAED20729;
        Sun, 17 Nov 2019 22:13:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iWSn8-0002pu-Ac; Sun, 17 Nov 2019 17:13:10 -0500
Message-Id: <20191117221310.213859430@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 17 Nov 2019 17:12:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [for-next][PATCH 1/7] ftrace: Add modify_ftrace_direct()
References: <20191117221256.228674565@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a new function modify_ftrace_direct() that will allow a user to update
an existing direct caller to a new trampoline, without missing hits due to
unregistering one and then adding another.

Link: https://lore.kernel.org/r/20191109022907.6zzo6orhxpt5n2sv@ast-mbp.dhcp.thefacebook.com

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  6 ++++
 kernel/trace/ftrace.c  | 78 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 55647e185141..73eb2e93593f 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -250,6 +250,7 @@ static inline void ftrace_free_mem(struct module *mod, void *start, void *end) {
 extern int ftrace_direct_func_count;
 int register_ftrace_direct(unsigned long ip, unsigned long addr);
 int unregister_ftrace_direct(unsigned long ip, unsigned long addr);
+int modify_ftrace_direct(unsigned long ip, unsigned long old_addr, unsigned long new_addr);
 struct ftrace_direct_func *ftrace_find_direct_func(unsigned long addr);
 #else
 # define ftrace_direct_func_count 0
@@ -261,6 +262,11 @@ static inline int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 {
 	return -ENODEV;
 }
+static inline int modify_ftrace_direct(unsigned long ip,
+				       unsigned long old_addr, unsigned long new_addr)
+{
+	return -ENODEV;
+}
 static inline struct ftrace_direct_func *ftrace_find_direct_func(unsigned long addr)
 {
 	return NULL;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 82ef8d60a42b..834f3556ea1e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5160,6 +5160,84 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_direct);
+
+static struct ftrace_ops stub_ops = {
+	.func		= ftrace_stub,
+};
+
+/**
+ * modify_ftrace_direct - Modify an existing direct call to call something else
+ * @ip: The instruction pointer to modify
+ * @old_addr: The address that the current @ip calls directly
+ * @new_addr: The address that the @ip should call
+ *
+ * This modifies a ftrace direct caller at an instruction pointer without
+ * having to disable it first. The direct call will switch over to the
+ * @new_addr without missing anything.
+ *
+ * Returns: zero on success. Non zero on error, which includes:
+ *  -ENODEV : the @ip given has no direct caller attached
+ *  -EINVAL : the @old_addr does not match the current direct caller
+ */
+int modify_ftrace_direct(unsigned long ip,
+			 unsigned long old_addr, unsigned long new_addr)
+{
+	struct ftrace_func_entry *entry;
+	struct dyn_ftrace *rec;
+	int ret = -ENODEV;
+
+	mutex_lock(&direct_mutex);
+	entry = __ftrace_lookup_ip(direct_functions, ip);
+	if (!entry) {
+		/* OK if it is off by a little */
+		rec = lookup_rec(ip, ip);
+		if (!rec || rec->ip == ip)
+			goto out_unlock;
+
+		entry = __ftrace_lookup_ip(direct_functions, rec->ip);
+		if (!entry)
+			goto out_unlock;
+
+		ip = rec->ip;
+		WARN_ON(!(rec->flags & FTRACE_FL_DIRECT));
+	}
+
+	ret = -EINVAL;
+	if (entry->direct != old_addr)
+		goto out_unlock;
+
+	/*
+	 * By setting a stub function at the same address, we force
+	 * the code to call the iterator and the direct_ops helper.
+	 * This means that @ip does not call the direct call, and
+	 * we can simply modify it.
+	 */
+	ret = ftrace_set_filter_ip(&stub_ops, ip, 0, 0);
+	if (ret)
+		goto out_unlock;
+
+	ret = register_ftrace_function(&stub_ops);
+	if (ret) {
+		ftrace_set_filter_ip(&stub_ops, ip, 1, 0);
+		goto out_unlock;
+	}
+
+	entry->direct = new_addr;
+
+	/*
+	 * By removing the stub, we put back the direct call, calling
+	 * the @new_addr.
+	 */
+	unregister_ftrace_function(&stub_ops);
+	ftrace_set_filter_ip(&stub_ops, ip, 1, 0);
+
+	ret = 0;
+
+ out_unlock:
+	mutex_unlock(&direct_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(modify_ftrace_direct);
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
-- 
2.24.0


