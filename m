Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F951941F3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 15:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgCZOuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 10:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgCZOuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:50:07 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F89F2076A;
        Thu, 26 Mar 2020 14:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585234206;
        bh=/9X19HahLvZm7RYaSPLYJ2T4xNgBeO4KjoDyq4rBL38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rhlCtS9a0H/EOaG+ARElQv3SpPKx7rRTkiQOjbW6YqFgC8qbo3N6ErvNNqVi8/lOG
         jW7e1JitJ3GCn7EKZdC0nZnR/38b2k6JJ3DUQrxO7cKb+ci64lS+IU5+ZBJb8B0ThK
         7PaxoIG0Me4agkzrCdfsQqpOF9qLctqV2x/gwhF0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Paul McKenney <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH -tip 3/4] kprobes: Support NOKPROBE_SYMBOL() in modules
Date:   Thu, 26 Mar 2020 23:50:00 +0900
Message-Id: <158523419989.24735.6665260504057165207.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158523416289.24735.10455512519475919061.stgit@devnote2>
References: <158523416289.24735.10455512519475919061.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support NOKPROBE_SYMBOL() in modules. NOKPROBE_SYMBOL() records
only symbol address in "_kprobe_blacklist" section in the
module.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/module.h |    2 ++
 kernel/kprobes.c       |   17 +++++++++++++++++
 kernel/module.c        |    3 +++
 3 files changed, 22 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 369c354f9207..1192097c9a69 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -492,6 +492,8 @@ struct module {
 #ifdef CONFIG_KPROBES
 	void *kprobes_text_start;
 	unsigned int kprobes_text_size;
+	unsigned long *kprobe_blacklist;
+	unsigned int num_kprobe_blacklist;
 #endif
 
 #ifdef CONFIG_LIVEPATCH
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index b7549992b9bd..9eb5acf0a9f3 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2192,6 +2192,11 @@ static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
 	}
 }
 
+static void kprobe_remove_ksym_blacklist(unsigned long entry)
+{
+	kprobe_remove_area_blacklist(entry, entry + 1);
+}
+
 int __init __weak arch_populate_kprobe_blacklist(void)
 {
 	return 0;
@@ -2231,6 +2236,12 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 static void add_module_kprobe_blacklist(struct module *mod)
 {
 	unsigned long start, end;
+	int i;
+
+	if (mod->kprobe_blacklist) {
+		for (i = 0; i < mod->num_kprobe_blacklist; i++)
+			kprobe_add_ksym_blacklist(mod->kprobe_blacklist[i]);
+	}
 
 	start = (unsigned long)mod->kprobes_text_start;
 	if (start) {
@@ -2242,6 +2253,12 @@ static void add_module_kprobe_blacklist(struct module *mod)
 static void remove_module_kprobe_blacklist(struct module *mod)
 {
 	unsigned long start, end;
+	int i;
+
+	if (mod->kprobe_blacklist) {
+		for (i = 0; i < mod->num_kprobe_blacklist; i++)
+			kprobe_remove_ksym_blacklist(mod->kprobe_blacklist[i]);
+	}
 
 	start = (unsigned long)mod->kprobes_text_start;
 	if (start) {
diff --git a/kernel/module.c b/kernel/module.c
index f7712a923d63..7be011dacd8a 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3197,6 +3197,9 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 #ifdef CONFIG_KPROBES
 	mod->kprobes_text_start = section_objs(info, ".kprobes.text", 1,
 						&mod->kprobes_text_size);
+	mod->kprobe_blacklist = section_objs(info, "_kprobe_blacklist",
+						sizeof(unsigned long),
+						&mod->num_kprobe_blacklist);
 #endif
 	mod->extable = section_objs(info, "__ex_table",
 				    sizeof(*mod->extable), &mod->num_exentries);

