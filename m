Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030B62ABDB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2019 21:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfEZTTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 May 2019 15:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfEZTSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:18:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E13A92173C;
        Sun, 26 May 2019 19:18:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUyfR-0004ev-0M; Sun, 26 May 2019 15:18:49 -0400
Message-Id: <20190526191848.897981603@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 May 2019 15:18:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cheng Jian <cj.chengjian@huawei.com>
Subject: [for-next][PATCH 16/16] ftrace: Enable trampoline when rec count returns back to one
References: <20190526191828.466305460@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cheng Jian <cj.chengjian@huawei.com>

Custom trampolines can only be enabled if there is only a single ops
attached to it. If there's only a single callback registered to a function,
and the ops has a trampoline registered for it, then we can call the
trampoline directly. This is very useful for improving the performance of
ftrace and livepatch.

If more than one callback is registered to a function, the general
trampoline is used, and the custom trampoline is not restored back to the
direct call even if all the other callbacks were unregistered and we are
back to one callback for the function.

To fix this, set FTRACE_FL_TRAMP flag if rec count is decremented
to one, and the ops that left has a trampoline.

Testing After this patch :

insmod livepatch_unshare_files.ko
cat /sys/kernel/debug/tracing/enabled_functions

	unshare_files (1) R I	tramp: 0xffffffffc0000000(klp_ftrace_handler+0x0/0xa0) ->ftrace_ops_assist_func+0x0/0xf0

echo unshare_files > /sys/kernel/debug/tracing/set_ftrace_filter
echo function > /sys/kernel/debug/tracing/current_tracer
cat /sys/kernel/debug/tracing/enabled_functions

	unshare_files (2) R I ->ftrace_ops_list_func+0x0/0x150

echo nop > /sys/kernel/debug/tracing/current_tracer
cat /sys/kernel/debug/tracing/enabled_functions

	unshare_files (1) R I	tramp: 0xffffffffc0000000(klp_ftrace_handler+0x0/0xa0) ->ftrace_ops_assist_func+0x0/0xf0

Link: http://lkml.kernel.org/r/1556969979-111047-1-git-send-email-cj.chengjian@huawei.com

Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4f2c26bebe2a..5c3eadb143ed 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1622,6 +1622,11 @@ static bool test_rec_ops_needs_regs(struct dyn_ftrace *rec)
 	return  keep_regs;
 }
 
+static struct ftrace_ops *
+ftrace_find_tramp_ops_any(struct dyn_ftrace *rec);
+static struct ftrace_ops *
+ftrace_find_tramp_ops_next(struct dyn_ftrace *rec, struct ftrace_ops *ops);
+
 static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 				     int filter_hash,
 				     bool inc)
@@ -1750,15 +1755,17 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 			}
 
 			/*
-			 * If the rec had TRAMP enabled, then it needs to
-			 * be cleared. As TRAMP can only be enabled iff
-			 * there is only a single ops attached to it.
-			 * In otherwords, always disable it on decrementing.
-			 * In the future, we may set it if rec count is
-			 * decremented to one, and the ops that is left
-			 * has a trampoline.
+			 * The TRAMP needs to be set only if rec count
+			 * is decremented to one, and the ops that is
+			 * left has a trampoline. As TRAMP can only be
+			 * enabled if there is only a single ops attached
+			 * to it.
 			 */
-			rec->flags &= ~FTRACE_FL_TRAMP;
+			if (ftrace_rec_count(rec) == 1 &&
+			    ftrace_find_tramp_ops_any(rec))
+				rec->flags |= FTRACE_FL_TRAMP;
+			else
+				rec->flags &= ~FTRACE_FL_TRAMP;
 
 			/*
 			 * flags will be cleared in ftrace_check_record()
@@ -1951,11 +1958,6 @@ static void print_ip_ins(const char *fmt, const unsigned char *p)
 		printk(KERN_CONT "%s%02x", i ? ":" : "", p[i]);
 }
 
-static struct ftrace_ops *
-ftrace_find_tramp_ops_any(struct dyn_ftrace *rec);
-static struct ftrace_ops *
-ftrace_find_tramp_ops_next(struct dyn_ftrace *rec, struct ftrace_ops *ops);
-
 enum ftrace_bug_type ftrace_bug_type;
 const void *ftrace_expected;
 
-- 
2.20.1


