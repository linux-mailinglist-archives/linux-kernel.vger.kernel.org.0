Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA6319610B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 23:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgC0WZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 18:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbgC0WZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:25:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B29EC21927;
        Fri, 27 Mar 2020 22:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585347908;
        bh=1nn9QtPMvUtw5J8lfCbvfOGClwyMMAJVbt0kG1bLOmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wKT67xEcMLAjt1OB+qdmOR3qmOqGzLDsrZ6q8oZPo3npTzGCPnzGwodq8I158OAgi
         DYeLpTrJXnYwchLpxy1vuVfPE2Z6XQq78pfsaQXHUvqMyYsLK2oazPSSwrcwcoTMPe
         SAW+tuhDJHYtL408ZyHtWBtJXxgTUwZXFCFljuK0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 tip/core/rcu 31/34] rcu-tasks: Add rcu_dynticks_zero_in_eqs() effectiveness statistics
Date:   Fri, 27 Mar 2020 15:24:53 -0700
Message-Id: <20200327222456.12470-31-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200327222346.GA12082@paulmck-ThinkPad-P72>
References: <20200327222346.GA12082@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds counts of the number of calls and number of successful
calls to rcu_dynticks_zero_in_eqs(), which are printed at the end
of rcutorture runs and at stall time.  This allows evaluation of the
effectiveness of rcu_dynticks_zero_in_eqs().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 27d2458..c1a0706 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -725,6 +725,11 @@ DECLARE_WAIT_QUEUE_HEAD(trc_wait);	// List of holdout tasks.
 // Record outstanding IPIs to each CPU.  No point in sending two...
 static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
 
+// The number of detections of task quiescent state relying on
+// heavyweight readers executing explicit memory barriers.
+unsigned long n_heavy_reader_attempts;
+unsigned long n_heavy_reader_updates;
+
 void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
 DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
 		 "RCU Tasks Trace");
@@ -830,9 +835,11 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 		// If heavyweight readers are enabled on the remote task,
 		// we can inspect its state despite its currently running.
 		// However, we cannot safely change its state.
+		n_heavy_reader_attempts++;
 		if (!ofl && // Check for "running" idle tasks on offline CPUs.
 		    !rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
 			return false; // No quiescent state, do it the hard way.
+		n_heavy_reader_updates++;
 		in_qs = true;
 	} else {
 		in_qs = likely(!t->trc_reader_nesting);
@@ -1143,9 +1150,11 @@ core_initcall(rcu_spawn_tasks_trace_kthread);
 
 static void show_rcu_tasks_trace_gp_kthread(void)
 {
-	char buf[32];
+	char buf[64];
 
-	sprintf(buf, "N%d", atomic_read(&trc_n_readers_need_end));
+	sprintf(buf, "N%d h:%lu/%lu", atomic_read(&trc_n_readers_need_end),
+		data_race(n_heavy_reader_updates),
+		data_race(n_heavy_reader_attempts));
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_trace, buf);
 }
 
-- 
2.9.5

