Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBFFCE4E8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 16:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfJGOQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 10:16:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44030 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfJGOQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:16:51 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iHTod-0005Li-06; Mon, 07 Oct 2019 16:16:47 +0200
Date:   Mon, 7 Oct 2019 16:16:46 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RT] locking/rtmutex: Clean ->pi_blocked_on in the error case
Message-ID: <20191007141646.2qjo3d6pnzdrlr5l@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

The function rt_mutex_wait_proxy_lock() cleans ->pi_blocked_on in case
of failure (timeout, signal). The same cleanup is required in
__rt_mutex_start_proxy_lock().
In both the cases the tasks was interrupted by a signal or timeout while
acquiring the lock and after the interruption it longer blocks on the
lock.

Fixes: 1a1fb985f2e2b ("futex: Handle early deadlock return correctly")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

This means I'm going to revert the raw_spinlock_t changes to
futex_hash_bucket, add back all futex fixes we had and put this one on
top.

 kernel/locking/rtmutex.c | 43 +++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 0649a33fb7e6c..bb5c09c49c504 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2321,6 +2321,26 @@ void rt_mutex_proxy_unlock(struct rt_mutex *lock,
 	rt_mutex_set_owner(lock, NULL);
 }
 
+static void fixup_rt_mutex_blocked(struct rt_mutex *lock)
+{
+	struct task_struct *tsk = current;
+	/*
+	 * RT has a problem here when the wait got interrupted by a timeout
+	 * or a signal. task->pi_blocked_on is still set. The task must
+	 * acquire the hash bucket lock when returning from this function.
+	 *
+	 * If the hash bucket lock is contended then the
+	 * BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on)) in
+	 * task_blocks_on_rt_mutex() will trigger. This can be avoided by
+	 * clearing task->pi_blocked_on which removes the task from the
+	 * boosting chain of the rtmutex. That's correct because the task
+	 * is not longer blocked on it.
+	 */
+	raw_spin_lock(&tsk->pi_lock);
+	tsk->pi_blocked_on = NULL;
+	raw_spin_unlock(&tsk->pi_lock);
+}
+
 /**
  * __rt_mutex_start_proxy_lock() - Start lock acquisition for another task
  * @lock:		the rt_mutex to take
@@ -2393,6 +2413,9 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 		ret = 0;
 	}
 
+	if (ret)
+		fixup_rt_mutex_blocked(lock);
+
 	debug_rt_mutex_print_deadlock(waiter);
 
 	return ret;
@@ -2473,7 +2496,6 @@ int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
 			       struct hrtimer_sleeper *to,
 			       struct rt_mutex_waiter *waiter)
 {
-	struct task_struct *tsk = current;
 	int ret;
 
 	raw_spin_lock_irq(&lock->wait_lock);
@@ -2485,23 +2507,8 @@ int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
 	 * have to fix that up.
 	 */
 	fixup_rt_mutex_waiters(lock);
-	/*
-	 * RT has a problem here when the wait got interrupted by a timeout
-	 * or a signal. task->pi_blocked_on is still set. The task must
-	 * acquire the hash bucket lock when returning from this function.
-	 *
-	 * If the hash bucket lock is contended then the
-	 * BUG_ON(rt_mutex_real_waiter(task->pi_blocked_on)) in
-	 * task_blocks_on_rt_mutex() will trigger. This can be avoided by
-	 * clearing task->pi_blocked_on which removes the task from the
-	 * boosting chain of the rtmutex. That's correct because the task
-	 * is not longer blocked on it.
-	 */
-	if (ret) {
-		raw_spin_lock(&tsk->pi_lock);
-		tsk->pi_blocked_on = NULL;
-		raw_spin_unlock(&tsk->pi_lock);
-	}
+	if (ret)
+		fixup_rt_mutex_blocked(lock);
 
 	raw_spin_unlock_irq(&lock->wait_lock);
 
-- 
2.23.0

