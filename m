Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13337117EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 05:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfLJE1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 23:27:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfLJE0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:26:36 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35F87222C4;
        Tue, 10 Dec 2019 04:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951995;
        bh=Kijt+ax9E/GM/w8P1YUGTcubjBJGWXIOWPwUkjE317E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/Hln0sfsFt4V7XKFv+f56Xj7pGyVVS1TxxSOd98Hf0+BWcVt0OwOoXhpCZYK4mDF
         Lk/Hg7CZGTdDCKzQ8Le35jhoY4WXz9yZdinZKRTfRCsK/h0DmhfIwSS9DmYCwl/581
         vWRKLhPSNLzWnxtYKX4tvmEjTFDXNHiGKLn94Nxs=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/11] rcu: Rename some instance of CONFIG_PREEMPTION to CONFIG_PREEMPT_RCU
Date:   Mon,  9 Dec 2019 20:26:24 -0800
Message-Id: <20191210042629.3808-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210042606.GA3624@paulmck-ThinkPad-P72>
References: <20191210042606.GA3624@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

CONFIG_PREEMPTION and CONFIG_PREEMPT_RCU are always identical,
but some code depends on CONFIG_PREEMPTION to access to
rcu_preempt functionality. This patch changes CONFIG_PREEMPTION
to CONFIG_PREEMPT_RCU in these cases.

Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c       | 4 ++--
 kernel/rcu/tree_stall.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c9dbb05..5445da2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1934,7 +1934,7 @@ rcu_report_unblock_qs_rnp(struct rcu_node *rnp, unsigned long flags)
 	struct rcu_node *rnp_p;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
-	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPTION)) ||
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT_RCU)) ||
 	    WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)) ||
 	    rnp->qsmask != 0) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
@@ -2294,7 +2294,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 		mask = 0;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->qsmask == 0) {
-			if (!IS_ENABLED(CONFIG_PREEMPTION) ||
+			if (!IS_ENABLED(CONFIG_PREEMPT_RCU) ||
 			    rcu_preempt_blocked_readers_cgp(rnp)) {
 				/*
 				 * No point in scanning bits because they
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index c0b8c45..a6652ef 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -163,7 +163,7 @@ static void rcu_iw_handler(struct irq_work *iwp)
 //
 // Printing RCU CPU stall warnings
 
-#ifdef CONFIG_PREEMPTION
+#ifdef CONFIG_PREEMPT_RCU
 
 /*
  * Dump detailed information for all tasks blocking the current RCU
@@ -215,7 +215,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 	return ndetected;
 }
 
-#else /* #ifdef CONFIG_PREEMPTION */
+#else /* #ifdef CONFIG_PREEMPT_RCU */
 
 /*
  * Because preemptible RCU does not exist, we never have to check for
@@ -233,7 +233,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 {
 	return 0;
 }
-#endif /* #else #ifdef CONFIG_PREEMPTION */
+#endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
 /*
  * Dump stacks of all tasks running on stalled CPUs.  First try using
-- 
2.9.5

