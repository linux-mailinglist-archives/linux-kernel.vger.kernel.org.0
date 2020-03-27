Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0BF1960FB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 23:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgC0WZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 18:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbgC0WZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:25:05 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C28F2145D;
        Fri, 27 Mar 2020 22:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585347904;
        bh=oTBLksX2Wb6a7l2ZYlYQ/FViwXRmkrKCqHYWWLEK68M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tO/39LlaWYO3kFl5dL7ySy7j3bbmWp3QRSiFxXXxbrJSAnKOQOyrUTJ0GhzaYZ464
         XB0G81wdu+tYzhCulhBUpZCrNFafjLDIFdwOEDkyRi6n+rjSOk+MOQWm5+RErNhAiA
         86szUiwc48QTyyZQSPwP9srEpRsMxLyy3PGZ7Jhk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 tip/core/rcu 18/34] rcu-tasks: Add RCU tasks to rcutorture writer stall output
Date:   Fri, 27 Mar 2020 15:24:40 -0700
Message-Id: <20200327222456.12470-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200327222346.GA12082@paulmck-ThinkPad-P72>
References: <20200327222346.GA12082@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds state for each RCU-tasks flavor to the rcutorture
writer stall output.  The initial state is minimal, but you have to
start somewhere.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[ paulmck: Fixes based on feedback from kbuild test robot. ]
---
 kernel/rcu/rcu.h        |  1 +
 kernel/rcu/tasks.h      | 45 +++++++++++++++++++++++++++++++++++++++++++--
 kernel/rcu/tree_stall.h |  2 +-
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 72903867..e1089fd 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -431,6 +431,7 @@ bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
 void rcu_expedite_gp(void);
 void rcu_unexpedite_gp(void);
 void rcupdate_announce_bootup_oddness(void);
+void show_rcu_tasks_gp_kthreads(void);
 void rcu_request_urgent_qs_task(struct task_struct *t);
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index b52a640..7ce9a60 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -219,6 +219,16 @@ static void __init rcu_tasks_bootup_oddness(void)
 
 #endif /* #ifndef CONFIG_TINY_RCU */
 
+/* Dump out rcutorture-relevant state common to all RCU-tasks flavors. */
+static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
+{
+	pr_info("%s %c%c %s\n",
+		rtp->kname,
+		".k"[!!data_race(rtp->kthread_ptr)],
+		".C"[!!data_race(rtp->cbs_head)],
+		s);
+}
+
 #ifdef CONFIG_TASKS_RCU
 
 ////////////////////////////////////////////////////////////////////////
@@ -482,7 +492,14 @@ static int __init rcu_spawn_tasks_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_kthread);
 
-#endif /* #ifdef CONFIG_TASKS_RCU */
+static void show_rcu_tasks_classic_gp_kthread(void)
+{
+	show_rcu_tasks_generic_gp_kthread(&rcu_tasks, "");
+}
+
+#else /* #ifdef CONFIG_TASKS_RCU */
+static void show_rcu_tasks_classic_gp_kthread(void) { }
+#endif /* #else #ifdef CONFIG_TASKS_RCU */
 
 #ifdef CONFIG_TASKS_RUDE_RCU
 
@@ -578,7 +595,14 @@ static int __init rcu_spawn_tasks_rude_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_rude_kthread);
 
-#endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
+static void show_rcu_tasks_rude_gp_kthread(void)
+{
+	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
+}
+
+#else /* #ifdef CONFIG_TASKS_RUDE_RCU */
+static void show_rcu_tasks_rude_gp_kthread(void) {}
+#endif /* #else #ifdef CONFIG_TASKS_RUDE_RCU */
 
 ////////////////////////////////////////////////////////////////////////
 //
@@ -978,10 +1002,27 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_trace_kthread);
 
+static void show_rcu_tasks_trace_gp_kthread(void)
+{
+	char buf[32];
+
+	sprintf(buf, "N%d", atomic_read(&trc_n_readers_need_end));
+	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_trace, buf);
+}
+
 #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
 void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
+static inline void show_rcu_tasks_trace_gp_kthread(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
 
+void show_rcu_tasks_gp_kthreads(void)
+{
+	show_rcu_tasks_classic_gp_kthread();
+	show_rcu_tasks_rude_gp_kthread();
+	show_rcu_tasks_trace_gp_kthread();
+}
+
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
+void show_rcu_tasks_gp_kthreads(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index e19487d..ec8e985 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -649,7 +649,7 @@ void show_rcu_gp_kthreads(void)
 		if (rcu_segcblist_is_offloaded(&rdp->cblist))
 			show_rcu_nocb_state(rdp);
 	}
-	/* sched_show_task(rcu_state.gp_kthread); */
+	show_rcu_tasks_gp_kthreads();
 }
 EXPORT_SYMBOL_GPL(show_rcu_gp_kthreads);
 
-- 
2.9.5

