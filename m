Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF591117EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 05:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfLJECF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 23:02:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbfLJECC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:02:02 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A88DB214D8;
        Tue, 10 Dec 2019 04:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950521;
        bh=m2GXoSyuxJbV9GL011u2OK+TshJgf3LR/XQ5uYfnR1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kc/tq1xbJEGaYDK4dsApB34Mss7gP2wVa0IoPZ37YBEHSnL9q75BVdCJdPXH26UTK
         IqSVkU2/iuxDqAfIzmav4rv7ynSsFEvpRnKL/LEXCxI1k6endaK9M0jqVxEq463UXY
         VZa1cXLgRDW7QTsPS0X1b5kEBc5SPZ/wbT33gUx8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/10] rcu: Update tree_exp.h function-header comments
Date:   Mon,  9 Dec 2019 20:01:52 -0800
Message-Id: <20191210040154.2498-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040122.GA2419@paulmck-ThinkPad-P72>
References: <20191210040122.GA2419@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The function-header comments in kernel/rcu/tree_exp.h have gotten a bit
out of date, so this commit updates a number of them.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 3923c07..1eafbcd 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -21,7 +21,7 @@ static void rcu_exp_gp_seq_start(void)
 }
 
 /*
- * Return then value that expedited-grace-period counter will have
+ * Return the value that the expedited-grace-period counter will have
  * at the end of the current grace period.
  */
 static __maybe_unused unsigned long rcu_exp_gp_seq_endval(void)
@@ -39,7 +39,9 @@ static void rcu_exp_gp_seq_end(void)
 }
 
 /*
- * Take a snapshot of the expedited-grace-period counter.
+ * Take a snapshot of the expedited-grace-period counter, which is the
+ * earliest value that will indicate that a full grace period has
+ * elapsed since the current time.
  */
 static unsigned long rcu_exp_gp_seq_snap(void)
 {
@@ -143,22 +145,18 @@ static void __maybe_unused sync_exp_reset_tree(void)
  * Return non-zero if there is no RCU expedited grace period in progress
  * for the specified rcu_node structure, in other words, if all CPUs and
  * tasks covered by the specified rcu_node structure have done their bit
- * for the current expedited grace period.  Works only for preemptible
- * RCU -- other RCU implementation use other means.
- *
- * Caller must hold the specificed rcu_node structure's ->lock
+ * for the current expedited grace period.
  */
 static bool sync_rcu_exp_done(struct rcu_node *rnp)
 {
 	raw_lockdep_assert_held_rcu_node(rnp);
-
 	return rnp->exp_tasks == NULL &&
 	       READ_ONCE(rnp->expmask) == 0;
 }
 
 /*
- * Like sync_rcu_exp_done(), but this function assumes the caller doesn't
- * hold the rcu_node's ->lock, and will acquire and release the lock itself
+ * Like sync_rcu_exp_done(), but where the caller does not hold the
+ * rcu_node's ->lock.
  */
 static bool sync_rcu_exp_done_unlocked(struct rcu_node *rnp)
 {
@@ -180,8 +178,6 @@ static bool sync_rcu_exp_done_unlocked(struct rcu_node *rnp)
  * which the task was queued or to one of that rcu_node structure's ancestors,
  * recursively up the tree.  (Calm down, calm down, we do the recursion
  * iteratively!)
- *
- * Caller must hold the specified rcu_node structure's ->lock.
  */
 static void __rcu_report_exp_rnp(struct rcu_node *rnp,
 				 bool wake, unsigned long flags)
@@ -189,6 +185,7 @@ static void __rcu_report_exp_rnp(struct rcu_node *rnp,
 {
 	unsigned long mask;
 
+	raw_lockdep_assert_held_rcu_node(rnp);
 	for (;;) {
 		if (!sync_rcu_exp_done(rnp)) {
 			if (!rnp->expmask)
@@ -452,6 +449,10 @@ static void sync_rcu_exp_select_cpus(void)
 			flush_work(&rnp->rew.rew_work);
 }
 
+/*
+ * Wait for the expedited grace period to elapse, issuing any needed
+ * RCU CPU stall warnings along the way.
+ */
 static void synchronize_sched_expedited_wait(void)
 {
 	int cpu;
@@ -781,7 +782,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
  * implementations, it is still unfriendly to real-time workloads, so is
  * thus not recommended for any sort of common-case code.  In fact, if
  * you are using synchronize_rcu_expedited() in a loop, please restructure
- * your code to batch your updates, and then Use a single synchronize_rcu()
+ * your code to batch your updates, and then use a single synchronize_rcu()
  * instead.
  *
  * This has the same semantics as (but is more brutal than) synchronize_rcu().
-- 
2.9.5

