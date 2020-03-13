Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0E0A18386A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 19:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgCLSRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 14:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgCLSRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:17:05 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CCA020739;
        Thu, 12 Mar 2020 18:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584037024;
        bh=fjI+R94EzQwA0tEzSeSTDZ6iCR8SFLgPUT9TV/qWp/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OPl4FBaD4RxZgn6w4mnc5Ojw6IN77nJImoLIGzaEMcDvhk+DMAQlbUJEJRaG3GjIq
         bEfKXcAeYDev7NmleS8DmFy1q8C88NV3N0aimUij1wtfW3yS+Qbefgx1hvwfh989ld
         HG78uAvFJsOhPTwWqfqN+q5SvSrKWiYTaBmdDWa0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC tip/core/rcu 02/16] rcu: Add per-task state to RCU CPU stall warnings
Date:   Thu, 12 Mar 2020 11:16:48 -0700
Message-Id: <20200312181702.8443-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200312181618.GA21271@paulmck-ThinkPad-P72>
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, an RCU-preempt CPU stall warning simply lists the PIDs of
those tasks holding up the current grace period.  This can be helpful,
but more can be even more helpful.

To this end, this commit adds the nesting level, whether the task
things it was preempted in its current RCU read-side critical section,
whether RCU core has asked this task for a quiescent state, whether the
expedited-grace-period hint is set, and whether the task believes that
it is on the blocked-tasks list (it must be, or it would not be printed,
but if things are broken, best not to take too much for granted).

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 502b4dd..6de5a5b 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -192,14 +192,39 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
+// Communicate task state back to the RCU CPU stall warning request.
+struct rcu_stall_chk_rdr {
+	struct task_struct *t;
+	int nesting;
+	union rcu_special rs;
+	bool on_blkd_list;
+};
+
+/*
+ * Report out the state of a not-running task that is stalling the
+ * current RCU grace period.
+ */
+static void check_slow_task(void *arg)
+{
+	struct rcu_node *rnp;
+	struct rcu_stall_chk_rdr *rscrp = arg;
+	struct task_struct *t = rscrp->t;
+
+	rscrp->nesting = t->rcu_read_lock_nesting;
+	rscrp->rs = t->rcu_read_unlock_special;
+	rnp = t->rcu_blocked_node;
+	rscrp->on_blkd_list = !list_empty(&t->rcu_node_entry);
+}
+
 /*
  * Scan the current list of tasks blocked within RCU read-side critical
  * sections, printing out the tid of each.
  */
 static int rcu_print_task_stall(struct rcu_node *rnp)
 {
-	struct task_struct *t;
 	int ndetected = 0;
+	struct rcu_stall_chk_rdr rscr;
+	struct task_struct *t;
 
 	if (!rcu_preempt_blocked_readers_cgp(rnp))
 		return 0;
@@ -208,7 +233,16 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 	t = list_entry(rnp->gp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
-		pr_cont(" P%d", t->pid);
+		rscr.t = t;
+		if (!try_invoke_on_nonrunning_task(t, check_slow_task, &rscr))
+			pr_cont(" P%d", t->pid);
+		else
+			pr_cont(" P%d/%d:%c%c%c%c",
+				t->pid, rscr.nesting,
+				".b"[rscr.rs.b.blocked],
+				".q"[rscr.rs.b.need_qs],
+				".e"[rscr.rs.b.exp_hint],
+				".l"[rscr.on_blkd_list]);
 		ndetected++;
 	}
 	pr_cont("\n");
-- 
2.9.5

