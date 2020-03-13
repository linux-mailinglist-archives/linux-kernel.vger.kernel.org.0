Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE3618385D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 19:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCLSRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 14:17:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLSRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:17:05 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED5E0206B1;
        Thu, 12 Mar 2020 18:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584037024;
        bh=QhQn73h+DWfpDj9QJYvc3jL1eYN2/CxEtnU/MGer2UA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFnE0iVPMh+c8wM6PIfzjw8PECiatE5OaMo5ytxB1VKZPdqZzc4oUrZigcUbYK+cf
         QUyQ4eCdjW7dKq9DC4bcEWhXpIvGYixQ7/To9QfTSxrpol1HMZ3ecy+bBkBQ1ALu8H
         uSyI/V3jSVuvyPbXo7leYOlBXlj+j794SgyGHjmQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: [PATCH RFC tip/core/rcu 01/16] sched/core: Add function to sample state of non-running function
Date:   Thu, 12 Mar 2020 11:16:47 -0700
Message-Id: <20200312181702.8443-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200312181618.GA21271@paulmck-ThinkPad-P72>
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

A running task's state can be sampled in a consistent manner (for example,
for diagnostic purposes) simply by invoking smp_call_function_single()
on its CPU, which may be obtained using task_cpu(), then having the
IPI handler verify that the desired task is in fact still running.
However, if the task is not running, this sampling can in theory be
done directly.  In practice, the task might start running at any time,
including during the sampling period.  Gaining a consistent sample of
a not-running task therefore requires that something be done to prevent
that task from running.

This commit therefore adds a try_invoke_on_nonrunning_task() function
that invokes a specified function with the specified argument if the
specified task is in a non-running state, returning true if successful.
Otherwise this function simply returns false.  Given that the function
passed to try_invoke_on_nonrunning_task() will be invoked with a runqueue
lock held, that function had better be quite lightweight.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[ paulmck: Apply feedback from Peter Zijlstra and Steven Rostedt. ]
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
---
 include/linux/wait.h |  2 ++
 kernel/sched/core.c  | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 3283c8d..6c0f989 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -1148,4 +1148,6 @@ int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, i
 		(wait)->flags = 0;						\
 	} while (0)
 
+bool try_invoke_on_nonrunning_task(struct task_struct *p, void (*func)(void *arg), void *arg);
+
 #endif /* _LINUX_WAIT_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fc1dfc0..d64328c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2580,6 +2580,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 *
 	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
 	 * __schedule().  See the comment for smp_mb__after_spinlock().
+	 *
+	 * A similar smb_rmb() lives in try_invoke_on_nonrunning_task().
 	 */
 	smp_rmb();
 	if (p->on_rq && ttwu_remote(p, wake_flags))
@@ -2654,6 +2656,53 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 }
 
 /**
+ * try_invoke_on_nonrunning_task - Invoke a function for a non-running task
+ * @p: Process for which the function is to be invoked.
+ * @func: Function to invoke.
+ * @arg: Argument to function.
+ *
+ * If the specified task is not running (either sleeping or runnable but
+ * not actually running), arrange to keep it in that state while invoking
+ * @func(@arg).  Given that @func can be invoked with a runqueue lock held,
+ * it had better be quite lightweight.
+ *
+ * Returns:
+ *	@false if the task is running or blocked.
+ *	@true if the task is runnable but not running.
+ */
+bool try_invoke_on_nonrunning_task(struct task_struct *p, void (*func)(void *arg), void *arg)
+{
+	bool ret = false;
+	struct rq_flags rf;
+	struct rq *rq;
+
+	lockdep_assert_irqs_enabled();
+	raw_spin_lock_irq(&p->pi_lock);
+	if (p->on_rq) {
+		rq = __task_rq_lock(p, &rf);
+		if (task_rq(p) == rq && !task_curr(p)) {
+			func(arg);
+			ret = true;
+		}
+		rq_unlock(rq, &rf);
+	} else {
+		switch (p->state) {
+		case TASK_RUNNING:
+		case TASK_WAKING:
+			break;
+		default:
+			smp_rmb();
+			if (!p->on_rq) {
+				func(arg);
+				ret = true;
+			}
+		}
+	}
+	raw_spin_unlock_irq(&p->pi_lock);
+	return ret;
+}
+
+/**
  * wake_up_process - Wake up a specific process
  * @p: The process to be woken up.
  *
-- 
2.9.5

