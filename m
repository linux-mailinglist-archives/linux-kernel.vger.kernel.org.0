Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7CE19610E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 23:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgC0W0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 18:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbgC0WZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:25:08 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57C33217D8;
        Fri, 27 Mar 2020 22:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585347907;
        bh=nTy6FurwjMOt+wtEU20iWyrcDsMmmfs5wl7gzXUqPPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1s6LEN+O1BnIE0kUU7dLVNoXAMENP8KdBVM8jQKLfSk3LkgQz3HPIiSqh+nhUQoJN
         Q1Bt0xG/OQsnfZSddbP6OjYySTXkS8D/KSDjXg7jeUix2sMAtutMXIJXDIB/bAVX7F
         YXRaNbg+hj1cp8V8FYaHfQxHOHRAUq2FOp1l58ok=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 tip/core/rcu 27/34] rcu-tasks: Allow rcu_read_unlock_trace() under scheduler locks
Date:   Fri, 27 Mar 2020 15:24:49 -0700
Message-Id: <20200327222456.12470-27-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200327222346.GA12082@paulmck-ThinkPad-P72>
References: <20200327222346.GA12082@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_read_unlock_trace() can invoke rcu_read_unlock_trace_special(),
which in turn can call wake_up().  Therefore, if any scheduler lock is
held across a call to rcu_read_unlock_trace(), self-deadlock can occur.
This commit therefore uses the irq_work facility to defer the wake_up()
to a clean environment where no scheduler locks will be held.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
[ paulmck: Update #includes for m68k per kbuild test robot. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h  | 12 +++++++++++-
 kernel/rcu/update.c |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index a7ecde9..2663167e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -729,6 +729,16 @@ void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
 DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
 		 "RCU Tasks Trace");
 
+/*
+ * This irq_work handler allows rcu_read_unlock_trace() to be invoked
+ * while the scheduler locks are held.
+ */
+static void rcu_read_unlock_iw(struct irq_work *iwp)
+{
+	wake_up(&trc_wait);
+}
+static DEFINE_IRQ_WORK(rcu_tasks_trace_iw, rcu_read_unlock_iw);
+
 /* If we are the last reader, wake up the grace-period kthread. */
 void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
 {
@@ -742,7 +752,7 @@ void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
 		WRITE_ONCE(t->trc_reader_special.b.need_qs, false);
 	WRITE_ONCE(t->trc_reader_nesting, nesting);
 	if (nq && atomic_dec_and_test(&trc_n_readers_need_end))
-		wake_up(&trc_wait);
+		irq_work_queue(&rcu_tasks_trace_iw);
 }
 EXPORT_SYMBOL_GPL(rcu_read_unlock_trace_special);
 
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 0fb2a9e..40e3512 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -41,6 +41,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/kprobes.h>
 #include <linux/slab.h>
+#include <linux/irq_work.h>
 
 #define CREATE_TRACE_POINTS
 
-- 
2.9.5

