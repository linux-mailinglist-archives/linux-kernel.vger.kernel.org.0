Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8B0117EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 05:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfLJEB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 23:01:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:41390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfLJEB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:01:57 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38CE3205C9;
        Tue, 10 Dec 2019 04:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950516;
        bh=RX8i7uMUEjXP+6qIejQGL9lkVE4XXjHZhPVNvQaD7QI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wz66kMYkjt5tOqSJPV/XybuYU1xScJVV5uQOMeydooZV9TYj372CazKe1cXPDWWQT
         qF0YzbAEiwXR1bR8/ATmgRsxYaMxO8qcQIbw8kODEaHFN5DH6Ex40th1hpKoNOHnW5
         DajXfqVoWoAs8cyv2+tbDgkjOozRHzBsdtmApRq8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/10] rcu: Use *_ONCE() to protect lockless ->expmask accesses
Date:   Mon,  9 Dec 2019 20:01:45 -0800
Message-Id: <20191210040154.2498-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040122.GA2419@paulmck-ThinkPad-P72>
References: <20191210040122.GA2419@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_node structure's ->expmask field is accessed locklessly when
starting a new expedited grace period and when reporting an expedited
RCU CPU stall warning.  This commit therefore handles the former by
taking a snapshot of ->expmask while the lock is held and the latter
by applying READ_ONCE() to lockless reads and WRITE_ONCE() to the
corresponding updates.

Link: https://lore.kernel.org/lkml/CANpmjNNmSOagbTpffHr4=Yedckx9Rm2NuGqC9UqE+AOz5f1-ZQ@mail.gmail.com
Reported-by: syzbot+134336b86f728d6e55a0@syzkaller.appspotmail.com
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Marco Elver <elver@google.com>
---
 kernel/rcu/tree_exp.h | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index d632cd0..69c5aa6 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -134,7 +134,7 @@ static void __maybe_unused sync_exp_reset_tree(void)
 	rcu_for_each_node_breadth_first(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		WARN_ON_ONCE(rnp->expmask);
-		rnp->expmask = rnp->expmaskinit;
+		WRITE_ONCE(rnp->expmask, rnp->expmaskinit);
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 }
@@ -211,7 +211,7 @@ static void __rcu_report_exp_rnp(struct rcu_node *rnp,
 		rnp = rnp->parent;
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled */
 		WARN_ON_ONCE(!(rnp->expmask & mask));
-		rnp->expmask &= ~mask;
+		WRITE_ONCE(rnp->expmask, rnp->expmask & ~mask);
 	}
 }
 
@@ -241,7 +241,7 @@ static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
-	rnp->expmask &= ~mask;
+	WRITE_ONCE(rnp->expmask, rnp->expmask & ~mask);
 	__rcu_report_exp_rnp(rnp, wake, flags); /* Releases rnp->lock. */
 }
 
@@ -372,12 +372,10 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 	/* IPI the remaining CPUs for expedited quiescent state. */
-	for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
+	for_each_leaf_node_cpu_mask(rnp, cpu, mask_ofl_ipi) {
 		unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
 		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 
-		if (!(mask_ofl_ipi & mask))
-			continue;
 retry_ipi:
 		if (rcu_dynticks_in_eqs_since(rdp, rdp->exp_dynticks_snap)) {
 			mask_ofl_test |= mask;
@@ -491,7 +489,7 @@ static void synchronize_sched_expedited_wait(void)
 				struct rcu_data *rdp;
 
 				mask = leaf_node_cpu_bit(rnp, cpu);
-				if (!(rnp->expmask & mask))
+				if (!(READ_ONCE(rnp->expmask) & mask))
 					continue;
 				ndetected++;
 				rdp = per_cpu_ptr(&rcu_data, cpu);
@@ -503,7 +501,8 @@ static void synchronize_sched_expedited_wait(void)
 		}
 		pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
 			jiffies - jiffies_start, rcu_state.expedited_sequence,
-			rnp_root->expmask, ".T"[!!rnp_root->exp_tasks]);
+			READ_ONCE(rnp_root->expmask),
+			".T"[!!rnp_root->exp_tasks]);
 		if (ndetected) {
 			pr_err("blocking rcu_node structures:");
 			rcu_for_each_node_breadth_first(rnp) {
@@ -513,7 +512,7 @@ static void synchronize_sched_expedited_wait(void)
 					continue;
 				pr_cont(" l=%u:%d-%d:%#lx/%c",
 					rnp->level, rnp->grplo, rnp->grphi,
-					rnp->expmask,
+					READ_ONCE(rnp->expmask),
 					".T"[!!rnp->exp_tasks]);
 			}
 			pr_cont("\n");
@@ -521,7 +520,7 @@ static void synchronize_sched_expedited_wait(void)
 		rcu_for_each_leaf_node(rnp) {
 			for_each_leaf_node_possible_cpu(rnp, cpu) {
 				mask = leaf_node_cpu_bit(rnp, cpu);
-				if (!(rnp->expmask & mask))
+				if (!(READ_ONCE(rnp->expmask) & mask))
 					continue;
 				dump_cpu_task(cpu);
 			}
-- 
2.9.5

