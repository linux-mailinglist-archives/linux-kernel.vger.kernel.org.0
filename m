Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC6D3F2250
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 00:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732844AbfKFXIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 18:08:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45549 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfKFXIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 18:08:18 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSUPN-0004jc-Kj; Thu, 07 Nov 2019 00:08:14 +0100
Message-Id: <20191106224556.539409004@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 06 Nov 2019 22:55:41 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <darren@dvhart.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [patch 07/12] futex: Mark the begin of futex exit explicitly
References: <20191106215534.241796846@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on PF_EXITING use an explicit state for the futex exit
and set it in the futex exit function. This moves the smp barrier and the
lock/unlock serialization into the futex code.

As with the DEAD state this is restricted to the exit path as exec
continues to use the same task struct.

This allows to simplify that logic in a next step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/futex.h |   31 +++----------------------------
 kernel/exit.c         |   13 +------------
 kernel/futex.c        |   37 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 40 insertions(+), 41 deletions(-)

--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -50,6 +50,7 @@ union futex_key {
 #ifdef CONFIG_FUTEX
 enum {
 	FUTEX_STATE_OK,
+	FUTEX_STATE_EXITING,
 	FUTEX_STATE_DEAD,
 };
 
@@ -64,33 +65,7 @@ static inline void futex_init_task(struc
 	tsk->futex_state = FUTEX_STATE_OK;
 }
 
-/**
- * futex_exit_done - Sets the tasks futex state to FUTEX_STATE_DEAD
- * @tsk:	task to set the state on
- *
- * Set the futex exit state of the task lockless. The futex waiter code
- * observes that state when a task is exiting and loops until the task has
- * actually finished the futex cleanup. The worst case for this is that the
- * waiter runs through the wait loop until the state becomes visible.
- *
- * This has two callers:
- *
- * - futex_mm_release() after the futex exit cleanup has been done
- *
- * - do_exit() from the recursive fault handling path.
- *
- * In case of a recursive fault this is best effort. Either the futex exit
- * code has run already or not. If the OWNER_DIED bit has been set on the
- * futex then the waiter can take it over. If not, the problem is pushed
- * back to user space. If the futex exit code did not run yet, then an
- * already queued waiter might block forever, but there is nothing which
- * can be done about that.
- */
-static inline void futex_exit_done(struct task_struct *tsk)
-{
-	tsk->futex_state = FUTEX_STATE_DEAD;
-}
-
+void futex_exit_recursive(struct task_struct *tsk);
 void futex_exit_release(struct task_struct *tsk);
 void futex_exec_release(struct task_struct *tsk);
 
@@ -98,7 +73,7 @@ long do_futex(u32 __user *uaddr, int op,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
 #else
 static inline void futex_init_task(struct task_struct *tsk) { }
-static inline void futex_exit_done(struct task_struct *tsk) { }
+static inline void futex_exit_recursive(struct task_struct *tsk) { }
 static inline void futex_exit_release(struct task_struct *tsk) { }
 static inline void futex_exec_release(struct task_struct *tsk) { }
 static inline long do_futex(u32 __user *uaddr, int op, u32 val,
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -746,23 +746,12 @@ void __noreturn do_exit(long code)
 	 */
 	if (unlikely(tsk->flags & PF_EXITING)) {
 		pr_alert("Fixing recursive fault but reboot is needed!\n");
-		futex_exit_done(tsk);
+		futex_exit_recursive(tsk);
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule();
 	}
 
 	exit_signals(tsk);  /* sets PF_EXITING */
-	/*
-	 * Ensure that all new tsk->pi_lock acquisitions must observe
-	 * PF_EXITING. Serializes against futex.c:attach_to_pi_owner().
-	 */
-	smp_mb();
-	/*
-	 * Ensure that we must observe the pi_state in exit_mm() ->
-	 * mm_release() -> exit_pi_state_list().
-	 */
-	raw_spin_lock_irq(&tsk->pi_lock);
-	raw_spin_unlock_irq(&tsk->pi_lock);
 
 	if (unlikely(in_atomic())) {
 		pr_info("note: %s[%d] exited with preempt_count %d\n",
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3679,10 +3679,45 @@ void futex_exec_release(struct task_stru
 		exit_pi_state_list(tsk);
 }
 
+/**
+ * futex_exit_recursive - Set the tasks futex state to FUTEX_STATE_DEAD
+ * @tsk:	task to set the state on
+ *
+ * Set the futex exit state of the task lockless. The futex waiter code
+ * observes that state when a task is exiting and loops until the task has
+ * actually finished the futex cleanup. The worst case for this is that the
+ * waiter runs through the wait loop until the state becomes visible.
+ *
+ * This is called from the recursive fault handling path in do_exit().
+ *
+ * This is best effort. Either the futex exit code has run already or
+ * not. If the OWNER_DIED bit has been set on the futex then the waiter can
+ * take it over. If not, the problem is pushed back to user space. If the
+ * futex exit code did not run yet, then an already queued waiter might
+ * block forever, but there is nothing which can be done about that.
+ */
+void futex_exit_recursive(struct task_struct *tsk)
+{
+	tsk->futex_state = FUTEX_STATE_DEAD;
+}
+
 void futex_exit_release(struct task_struct *tsk)
 {
+	tsk->futex_state = FUTEX_STATE_EXITING;
+	/*
+	 * Ensure that all new tsk->pi_lock acquisitions must observe
+	 * FUTEX_STATE_EXITING. Serializes against attach_to_pi_owner().
+	 */
+	smp_mb();
+	/*
+	 * Ensure that we must observe the pi_state in exit_pi_state_list().
+	 */
+	raw_spin_lock_irq(&tsk->pi_lock);
+	raw_spin_unlock_irq(&tsk->pi_lock);
+
 	futex_exec_release(tsk);
-	futex_exit_done(tsk);
+
+	tsk->futex_state = FUTEX_STATE_DEAD;
 }
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,


