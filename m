Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E174BC79
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 17:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfFSPIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 11:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfFSPIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:08:04 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2060F21881;
        Wed, 19 Jun 2019 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560956883;
        bh=4sX2gGRZSHcM+JIOEuXYuzhAkLyOF4FzxxOwkq7aiS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0l+B7pxlMQFS2frYfDt9Y0Ui2ol+ATkTrXF8+wXmp5j95smOcYU5mxE9ShxaBVVuo
         dExU8n0DlhT/C39blrI1RpA0Vg+dlwO8vIvAEuDc9bxJ5re2crOSMmKjVcqyjlmhmc
         N3MoiupCMRLKe49L5c6jPuQT6Dady74pf99aAWjQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2 05/12] tracing/uprobe: Add multi-probe per uprobe event support
Date:   Thu, 20 Jun 2019 00:07:58 +0900
Message-Id: <156095687876.28024.13840331032234992863.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156095682948.28024.14190188071338900568.stgit@devnote2>
References: <156095682948.28024.14190188071338900568.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow user to define several probes on one uprobe event.
Note that this only support appending method. So deleting
event will delete all probes on the event.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace.c        |    2 +
 kernel/trace/trace_uprobe.c |   60 ++++++++++++++++++++++++++++++-------------
 2 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8f5455046504..73fbe3b0dd08 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4821,7 +4821,7 @@ static const char readme_msg[] =
 	"\t\t\t  Write into this file to define/undefine new trace events.\n"
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
-	"  uprobe_events\t\t- Add/remove/show the userspace dynamic events\n"
+	"  uprobe_events\t\t- Create/append/remove/show the userspace dynamic events\n"
 	"\t\t\t  Write into this file to define/undefine new trace events.\n"
 #endif
 #if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS)
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 437dddeca8bf..c568f7b16f5c 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -364,15 +364,32 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
 {
 	int ret;
 
+	if (trace_probe_has_sibling(&tu->tp))
+		goto unreg;
+
 	ret = unregister_uprobe_event(tu);
 	if (ret)
 		return ret;
 
+unreg:
 	dyn_event_remove(&tu->devent);
+	trace_probe_unlink(&tu->tp);
 	free_trace_uprobe(tu);
 	return 0;
 }
 
+static int append_trace_uprobe(struct trace_uprobe *tu, struct trace_uprobe *to)
+{
+	int ret;
+
+	/* Append to existing event */
+	ret = trace_probe_append(&tu->tp, &to->tp);
+	if (!ret)
+		dyn_event_add(&tu->devent);
+
+	return ret;
+}
+
 /*
  * Uprobe with multiple reference counter is not allowed. i.e.
  * If inode and offset matches, reference counter offset *must*
@@ -382,25 +399,21 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
  * as the new one does not conflict with any other existing
  * ones.
  */
-static struct trace_uprobe *find_old_trace_uprobe(struct trace_uprobe *new)
+static int validate_ref_ctr_offset(struct trace_uprobe *new)
 {
 	struct dyn_event *pos;
-	struct trace_uprobe *tmp, *old = NULL;
+	struct trace_uprobe *tmp;
 	struct inode *new_inode = d_real_inode(new->path.dentry);
 
-	old = find_probe_event(trace_probe_name(&new->tp),
-				trace_probe_group_name(&new->tp));
-
 	for_each_trace_uprobe(tmp, pos) {
-		if ((old ? old != tmp : true) &&
-		    new_inode == d_real_inode(tmp->path.dentry) &&
+		if (new_inode == d_real_inode(tmp->path.dentry) &&
 		    new->offset == tmp->offset &&
 		    new->ref_ctr_offset != tmp->ref_ctr_offset) {
 			pr_warn("Reference counter offset mismatch.");
-			return ERR_PTR(-EINVAL);
+			return -EINVAL;
 		}
 	}
-	return old;
+	return 0;
 }
 
 /* Register a trace_uprobe and probe_event */
@@ -411,18 +424,29 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 
 	mutex_lock(&event_mutex);
 
-	/* register as an event */
-	old_tu = find_old_trace_uprobe(tu);
-	if (IS_ERR(old_tu)) {
-		ret = PTR_ERR(old_tu);
+	ret = validate_ref_ctr_offset(tu);
+	if (ret)
 		goto end;
-	}
 
+	/* register as an event */
+	old_tu = find_probe_event(trace_probe_name(&tu->tp),
+				  trace_probe_group_name(&tu->tp));
 	if (old_tu) {
-		/* delete old event */
-		ret = unregister_trace_uprobe(old_tu);
-		if (ret)
-			goto end;
+		if (is_ret_probe(tu) != is_ret_probe(old_tu)) {
+			trace_probe_log_set_index(0);
+			trace_probe_log_err(0, DIFF_PROBE_TYPE);
+			ret = -EEXIST;
+		} else {
+			ret = trace_probe_compare_arg_type(&tu->tp, &old_tu->tp);
+			if (ret) {
+				/* Note that argument starts index = 2 */
+				trace_probe_log_set_index(ret + 1);
+				trace_probe_log_err(0, DIFF_ARG_TYPE);
+				ret = -EEXIST;
+			} else
+				ret = append_trace_uprobe(tu, old_tu);
+		}
+		goto end;
 	}
 
 	ret = register_uprobe_event(tu);

