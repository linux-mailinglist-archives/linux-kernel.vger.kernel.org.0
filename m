Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF3218A999
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 01:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgCSALL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 20:11:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgCSALG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 20:11:06 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 891C420784;
        Thu, 19 Mar 2020 00:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584576665;
        bh=9+z9/6IXhKnsDV/0ekCJis5azPLRxI2BhYEcwRPUzdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SGlfDndQby9ng9qHhonXso6dbeIJraOtkRxmiuQNZ0zh1WuRIAeOjAx4nfV4+mlb9
         Stq8bbgqwCngnTo8zF/0DwJBp/NT4/wxrYZYy2j5LW2MwNJDNUgpWIK3WI7VjXAc1g
         aPvZflUavVPRLJ5FOQzCPLNV2Yvt6zO6rY4ZV/gU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 tip/core/rcu 11/22] rcu-tasks: Use unique names for RCU-Tasks kthreads and messages
Date:   Wed, 18 Mar 2020 17:10:49 -0700
Message-Id: <20200319001100.24917-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200319001024.GA28798@paulmck-ThinkPad-P72>
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit causes the flavors of RCU Tasks to use different names
for their kthreads and in their console messages.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 7ba1730..ac0f282 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -22,6 +22,8 @@ typedef void (*rcu_tasks_gp_func_t)(struct rcu_tasks *rtp);
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
  * @call_func: This flavor's call_rcu()-equivalent function.
+ * @name: This flavor's textual name.
+ * @kname: This flavor's kthread name.
  */
 struct rcu_tasks {
 	struct rcu_head *cbs_head;
@@ -31,16 +33,20 @@ struct rcu_tasks {
 	struct task_struct *kthread_ptr;
 	rcu_tasks_gp_func_t gp_func;
 	call_rcu_func_t call_func;
+	char *name;
+	char *kname;
 };
 
-#define DEFINE_RCU_TASKS(name, gp, call)				\
-static struct rcu_tasks name =						\
+#define DEFINE_RCU_TASKS(rt_name, gp, call, n)				\
+static struct rcu_tasks rt_name =					\
 {									\
-	.cbs_tail = &name.cbs_head,					\
-	.cbs_wq = __WAIT_QUEUE_HEAD_INITIALIZER(name.cbs_wq),		\
-	.cbs_lock = __RAW_SPIN_LOCK_UNLOCKED(name.cbs_lock),		\
+	.cbs_tail = &rt_name.cbs_head,					\
+	.cbs_wq = __WAIT_QUEUE_HEAD_INITIALIZER(rt_name.cbs_wq),	\
+	.cbs_lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name.cbs_lock),		\
 	.gp_func = gp,							\
 	.call_func = call,						\
+	.name = n,							\
+	.kname = #rt_name,						\
 }
 
 /* Track exiting tasks in order to allow them to be waited for. */
@@ -145,8 +151,8 @@ static void __init rcu_spawn_tasks_kthread_generic(struct rcu_tasks *rtp)
 {
 	struct task_struct *t;
 
-	t = kthread_run(rcu_tasks_kthread, rtp, "rcu_tasks_kthread");
-	if (WARN_ONCE(IS_ERR(t), "%s: Could not start Tasks-RCU grace-period kthread, OOM is now expected behavior\n", __func__))
+	t = kthread_run(rcu_tasks_kthread, rtp, "%s_kthread", rtp->kname);
+	if (WARN_ONCE(IS_ERR(t), "%s: Could not start %s grace-period kthread, OOM is now expected behavior\n", __func__, rtp->name))
 		return;
 	smp_mb(); /* Ensure others see full kthread. */
 }
@@ -342,7 +348,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 }
 
 void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
-DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks);
+DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
 
 /**
  * call_rcu_tasks() - Queue an RCU for invocation task-based grace period
@@ -437,7 +443,8 @@ static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
 }
 
 void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
-DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude);
+DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude,
+		 "RCU Tasks Rude");
 
 /**
  * call_rcu_tasks_rude() - Queue a callback rude task-based grace period
-- 
2.9.5

