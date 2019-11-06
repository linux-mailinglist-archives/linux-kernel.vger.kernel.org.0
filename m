Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6976DF224C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 00:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732575AbfKFXIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 18:08:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45505 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbfKFXII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 18:08:08 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSUPF-0004ix-MZ; Thu, 07 Nov 2019 00:08:05 +0100
Message-Id: <20191106224556.149449274@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 06 Nov 2019 22:55:37 +0100
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
Subject: [patch 03/12] futex: Replace PF_EXITPIDONE with a state
References: <20191106215534.241796846@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The futex exit handling relies on PF_ flags. That's suboptimal as it
requires a smp_mb() and an ugly lock/unlock of the exiting tasks pi_lock in
the middle of do_exit() to enforce the observability of PF_EXITING in the
futex code.

Add a futex_state member to task_struct and convert the PF_EXITPIDONE logic
over to the new state. The PF_EXITING dependency will be cleaned up in a
later step.

This prepares for handling various futex exit issues later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/futex.h |   33 +++++++++++++++++++++++++++++++++
 include/linux/sched.h |    2 +-
 kernel/exit.c         |   18 ++----------------
 kernel/futex.c        |   25 +++++++++++++------------
 4 files changed, 49 insertions(+), 29 deletions(-)

--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -48,6 +48,10 @@ union futex_key {
 #define FUTEX_KEY_INIT (union futex_key) { .both = { .ptr = NULL } }
 
 #ifdef CONFIG_FUTEX
+enum {
+	FUTEX_STATE_OK,
+	FUTEX_STATE_DEAD,
+};
 
 static inline void futex_init_task(struct task_struct *tsk)
 {
@@ -57,6 +61,34 @@ static inline void futex_init_task(struc
 #endif
 	INIT_LIST_HEAD(&tsk->pi_state_list);
 	tsk->pi_state_cache = NULL;
+	tsk->futex_state = FUTEX_STATE_OK;
+}
+
+/**
+ * futex_exit_done - Sets the tasks futex state to FUTEX_STATE_DEAD
+ * @tsk:	task to set the state on
+ *
+ * Set the futex exit state of the task lockless. The futex waiter code
+ * observes that state when a task is exiting and loops until the task has
+ * actually finished the futex cleanup. The worst case for this is that the
+ * waiter runs through the wait loop until the state becomes visible.
+ *
+ * This has two callers:
+ *
+ * - futex_mm_release() after the futex exit cleanup has been done
+ *
+ * - do_exit() from the recursive fault handling path.
+ *
+ * In case of a recursive fault this is best effort. Either the futex exit
+ * code has run already or not. If the OWNER_DIED bit has been set on the
+ * futex then the waiter can take it over. If not, the problem is pushed
+ * back to user space. If the futex exit code did not run yet, then an
+ * already queued waiter might block forever, but there is nothing which
+ * can be done about that.
+ */
+static inline void futex_exit_done(struct task_struct *tsk)
+{
+	tsk->futex_state = FUTEX_STATE_DEAD;
 }
 
 void futex_mm_release(struct task_struct *tsk);
@@ -66,6 +98,7 @@ long do_futex(u32 __user *uaddr, int op,
 #else
 static inline void futex_init_task(struct task_struct *tsk) { }
 static inline void futex_mm_release(struct task_struct *tsk) { }
+static inline void futex_exit_done(struct task_struct *tsk) { }
 static inline long do_futex(u32 __user *uaddr, int op, u32 val,
 			    ktime_t *timeout, u32 __user *uaddr2,
 			    u32 val2, u32 val3)
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1054,6 +1054,7 @@ struct task_struct {
 #endif
 	struct list_head		pi_state_list;
 	struct futex_pi_state		*pi_state_cache;
+	unsigned int			futex_state;
 #endif
 #ifdef CONFIG_PERF_EVENTS
 	struct perf_event_context	*perf_event_ctxp[perf_nr_task_contexts];
@@ -1442,7 +1443,6 @@ extern struct pid *cad_pid;
  */
 #define PF_IDLE			0x00000002	/* I am an IDLE thread */
 #define PF_EXITING		0x00000004	/* Getting shut down */
-#define PF_EXITPIDONE		0x00000008	/* PI exit done on shut down */
 #define PF_VCPU			0x00000010	/* I'm a virtual CPU */
 #define PF_WQ_WORKER		0x00000020	/* I'm a workqueue worker */
 #define PF_FORKNOEXEC		0x00000040	/* Forked but didn't exec */
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -746,16 +746,7 @@ void __noreturn do_exit(long code)
 	 */
 	if (unlikely(tsk->flags & PF_EXITING)) {
 		pr_alert("Fixing recursive fault but reboot is needed!\n");
-		/*
-		 * We can do this unlocked here. The futex code uses
-		 * this flag just to verify whether the pi state
-		 * cleanup has been done or not. In the worst case it
-		 * loops once more. We pretend that the cleanup was
-		 * done as there is no way to return. Either the
-		 * OWNER_DIED bit is set by now or we push the blocked
-		 * task into the wait for ever nirwana as well.
-		 */
-		tsk->flags |= PF_EXITPIDONE;
+		futex_exit_done(tsk);
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule();
 	}
@@ -846,12 +837,7 @@ void __noreturn do_exit(long code)
 	 * Make sure we are holding no locks:
 	 */
 	debug_check_no_locks_held();
-	/*
-	 * We can do this unlocked here. The futex code uses this flag
-	 * just to verify whether the pi state cleanup has been done
-	 * or not. In the worst case it loops once more.
-	 */
-	tsk->flags |= PF_EXITPIDONE;
+	futex_exit_done(tsk);
 
 	if (tsk->io_context)
 		exit_io_context(tsk);
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1182,9 +1182,10 @@ static int handle_exit_race(u32 __user *
 	u32 uval2;
 
 	/*
-	 * If PF_EXITPIDONE is not yet set, then try again.
+	 * If the futex exit state is not yet FUTEX_STATE_DEAD, wait
+	 * for it to finish.
 	 */
-	if (tsk && !(tsk->flags & PF_EXITPIDONE))
+	if (tsk && tsk->futex_state != FUTEX_STATE_DEAD)
 		return -EAGAIN;
 
 	/*
@@ -1203,8 +1204,9 @@ static int handle_exit_race(u32 __user *
 	 *    *uaddr = 0xC0000000;	     tsk = get_task(PID);
 	 *   }				     if (!tsk->flags & PF_EXITING) {
 	 *  ...				       attach();
-	 *  tsk->flags |= PF_EXITPIDONE;     } else {
-	 *				       if (!(tsk->flags & PF_EXITPIDONE))
+	 *  tsk->futex_state =               } else {
+	 *	FUTEX_STATE_DEAD;              if (tsk->futex_state !=
+	 *					  FUTEX_STATE_DEAD)
 	 *				         return -EAGAIN;
 	 *				       return -ESRCH; <--- FAIL
 	 *				     }
@@ -1260,17 +1262,16 @@ static int attach_to_pi_owner(u32 __user
 	}
 
 	/*
-	 * We need to look at the task state flags to figure out,
-	 * whether the task is exiting. To protect against the do_exit
-	 * change of the task flags, we do this protected by
-	 * p->pi_lock:
+	 * We need to look at the task state to figure out, whether the
+	 * task is exiting. To protect against the change of the task state
+	 * in futex_exit_release(), we do this protected by p->pi_lock:
 	 */
 	raw_spin_lock_irq(&p->pi_lock);
-	if (unlikely(p->flags & PF_EXITING)) {
+	if (unlikely(p->futex_state != FUTEX_STATE_OK)) {
 		/*
-		 * The task is on the way out. When PF_EXITPIDONE is
-		 * set, we know that the task has finished the
-		 * cleanup:
+		 * The task is on the way out. When the futex state is
+		 * FUTEX_STATE_DEAD, we know that the task has finished
+		 * the cleanup:
 		 */
 		int ret = handle_exit_race(uaddr, uval, p);
 


