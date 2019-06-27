Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81B1757CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 09:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfF0HIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 03:08:30 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:48569 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725787AbfF0HIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:08:30 -0400
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 27 Jun 2019 16:08:27 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.222.33)
        by 156.147.1.126 with ESMTP; 27 Jun 2019 16:08:27 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: [PATCH v2] rcu: Change return type of rcu_spawn_one_boost_kthread()
Date:   Thu, 27 Jun 2019 16:07:46 +0900
Message-Id: <1561619266-8850-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tested if the WARN_ON_ONCE() is fired with my box and it was ok.

Thanks,
Byungchul

Changes from v1
-. WARN_ON_ONCE() on failing to create rcu_boost_kthread.
-. Changed title and commit message a bit.

---8<---
From 7100fcf82202f063f70f45def208ea5198412f5a Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul.park@lge.com>
Date: Thu, 27 Jun 2019 15:58:10 +0900
Subject: [PATCH v2] rcu: Change return type of rcu_spawn_one_boost_kthread()

The return value of rcu_spawn_one_boost_kthread() is not used any
longer. Change return type of that function from int to void.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/tree_plugin.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1102765..3c8444e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1131,7 +1131,7 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
  * already exist.  We only create this kthread for preemptible RCU.
  * Returns zero if all is well, a negated errno otherwise.
  */
-static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
+static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 {
 	int rnp_index = rnp - rcu_get_root();
 	unsigned long flags;
@@ -1139,25 +1139,24 @@ static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	struct task_struct *t;
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
-		return 0;
+		return;
 
 	if (!rcu_scheduler_fully_active || rcu_rnp_online_cpus(rnp) == 0)
-		return 0;
+		return;
 
 	rcu_state.boost = 1;
 	if (rnp->boost_kthread_task != NULL)
-		return 0;
+		return;
 	t = kthread_create(rcu_boost_kthread, (void *)rnp,
 			   "rcub/%d", rnp_index);
-	if (IS_ERR(t))
-		return PTR_ERR(t);
+	if (WARN_ON_ONCE(IS_ERR(t)))
+		return;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rnp->boost_kthread_task = t;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	sp.sched_priority = kthread_prio;
 	sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
-	return 0;
 }
 
 static void rcu_cpu_kthread_setup(unsigned int cpu)
@@ -1265,7 +1264,7 @@ static void __init rcu_spawn_boost_kthreads(void)
 	if (WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec), "%s: Could not start rcub kthread, OOM is now expected behavior\n", __func__))
 		return;
 	rcu_for_each_leaf_node(rnp)
-		(void)rcu_spawn_one_boost_kthread(rnp);
+		rcu_spawn_one_boost_kthread(rnp);
 }
 
 static void rcu_prepare_kthreads(int cpu)
@@ -1275,7 +1274,7 @@ static void rcu_prepare_kthreads(int cpu)
 
 	/* Fire up the incoming CPU's kthread and leaf rcu_node kthread. */
 	if (rcu_scheduler_fully_active)
-		(void)rcu_spawn_one_boost_kthread(rnp);
+		rcu_spawn_one_boost_kthread(rnp);
 }
 
 #else /* #ifdef CONFIG_RCU_BOOST */
-- 
1.9.1

