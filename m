Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 144C5771FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 21:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388671AbfGZTTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 15:19:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50224 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388597AbfGZTTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:19:03 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr5k4-0001CO-Mu; Fri, 26 Jul 2019 21:19:00 +0200
Message-Id: <20190726185753.832418500@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 20:31:00 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [patch 12/12] timers: Prepare support for PREEMPT_RT
References: <20190726183048.982726647@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

When PREEMPT_RT is enabled, the soft interrupt thread can be preempted.  If
the soft interrupt thread is preempted in the middle of a timer callback,
then calling del_timer_sync() can lead to two issues:

  - If the caller is on a remote CPU then it has to spin wait for the timer
    handler to complete. This can result in unbound priority inversion.

  - If the caller originates from the task which preempted the timer
    handler on the same CPU, then spin waiting for the timer handler to
    complete is never going to end.

To avoid these issues, add a new lock to the timer base which is held
around the execution of the timer callbacks. If del_timer_sync() detects
that the timer callback is currently running, it blocks on the expiry
lock. When the callback is finished, the expiry lock is dropped by the
softirq thread which wakes up the waiter and the system makes progress.

This addresses both the priority inversion and the life lock issues.

This mechanism is not used for timers which are marked IRQSAFE as for those
preemption is disabled accross the callback and therefore this situation
cannot happen. The callbacks for such timers need to be individually
audited for RT compliance.

The same issue can happen in virtual machines when the vCPU which runs a
timer callback is scheduled out. If a second vCPU of the same guest calls
del_timer_sync() it will spin wait for the other vCPU to be scheduled back
in. The expiry lock mechanism would avoid that. It'd be trivial to enable
this when paravirt spinlocks are enabled in a guest, but it's not clear
whether this is an actual problem in the wild, so for now it's an RT only
mechanism.

As the softirq thread can be preempted with PREEMPT_RT=y, the SMP variant
of del_timer_sync() needs to be used on UP as well.

[ tglx: Refactored it for mainline ]

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
---
 include/linux/timer.h |    2 
 kernel/time/timer.c   |  103 ++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 96 insertions(+), 9 deletions(-)

--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -183,7 +183,7 @@ extern void add_timer(struct timer_list
 
 extern int try_to_del_timer_sync(struct timer_list *timer);
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
   extern int del_timer_sync(struct timer_list *timer);
 #else
 # define del_timer_sync(t)		del_timer(t)
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -196,6 +196,10 @@ EXPORT_SYMBOL(jiffies_64);
 struct timer_base {
 	raw_spinlock_t		lock;
 	struct timer_list	*running_timer;
+#ifdef CONFIG_PREEMPT_RT
+	spinlock_t		expiry_lock;
+	atomic_t		timer_waiters;
+#endif
 	unsigned long		clk;
 	unsigned long		next_expiry;
 	unsigned int		cpu;
@@ -1227,7 +1231,78 @@ int try_to_del_timer_sync(struct timer_l
 }
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_PREEMPT_RT
+static __init void timer_base_init_expiry_lock(struct timer_base *base)
+{
+	spin_lock_init(&base->expiry_lock);
+}
+
+static inline void timer_base_lock_expiry(struct timer_base *base)
+{
+	spin_lock(&base->expiry_lock);
+}
+
+static inline void timer_base_unlock_expiry(struct timer_base *base)
+{
+	spin_unlock(&base->expiry_lock);
+}
+
+/*
+ * The counterpart to del_timer_wait_running().
+ *
+ * If there is a waiter for base->expiry_lock, then it was waiting for the
+ * timer callback to finish. Drop expiry_lock and reaquire it. That allows
+ * the waiter to acquire the lock and make progress.
+ */
+static void timer_sync_wait_running(struct timer_base *base)
+{
+	if (atomic_read(&base->timer_waiters)) {
+		spin_unlock(&base->expiry_lock);
+		spin_lock(&base->expiry_lock);
+	}
+}
+
+/*
+ * This function is called on PREEMPT_RT kernels when the fast path
+ * deletion of a timer failed because the timer callback function was
+ * running.
+ *
+ * This prevents priority inversion, if the softirq thread on a remote CPU
+ * got preempted, and it prevents a life lock when the task which tries to
+ * delete a timer preempted the softirq thread running the timer callback
+ * function.
+ */
+static void del_timer_wait_running(struct timer_list *timer)
+{
+	u32 tf;
+
+	tf = READ_ONCE(timer->flags);
+	if (!(tf & TIMER_MIGRATING)) {
+		struct timer_base *base = get_timer_base(tf);
+
+		/*
+		 * Mark the base as contended and grab the expiry lock,
+		 * which is held by the softirq across the timer
+		 * callback. Drop the lock immediately so the softirq can
+		 * expire the next timer. In theory the timer could already
+		 * be running again, but that's more than unlikely and just
+		 * causes another wait loop.
+		 */
+		atomic_inc(&base->timer_waiters);
+		spin_lock_bh(&base->expiry_lock);
+		atomic_dec(&base->timer_waiters);
+		spin_unlock_bh(&base->expiry_lock);
+	}
+}
+#else
+static inline void timer_base_init_expiry_lock(struct timer_base *base) { }
+static inline void timer_base_lock_expiry(struct timer_base *base) { }
+static inline void timer_base_unlock_expiry(struct timer_base *base) { }
+static inline void timer_sync_wait_running(struct timer_base *base) { }
+static inline void del_timer_wait_running(struct timer_list *timer) { }
+#endif
+
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 /**
  * del_timer_sync - deactivate a timer and wait for the handler to finish.
  * @timer: the timer to be deactivated
@@ -1266,6 +1341,8 @@ EXPORT_SYMBOL(try_to_del_timer_sync);
  */
 int del_timer_sync(struct timer_list *timer)
 {
+	int ret;
+
 #ifdef CONFIG_LOCKDEP
 	unsigned long flags;
 
@@ -1283,12 +1360,17 @@ int del_timer_sync(struct timer_list *ti
 	 * could lead to deadlock.
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
-	for (;;) {
-		int ret = try_to_del_timer_sync(timer);
-		if (ret >= 0)
-			return ret;
-		cpu_relax();
-	}
+
+	do {
+		ret = try_to_del_timer_sync(timer);
+
+		if (unlikely(ret < 0)) {
+			del_timer_wait_running(timer);
+			cpu_relax();
+		}
+	} while (ret < 0);
+
+	return ret;
 }
 EXPORT_SYMBOL(del_timer_sync);
 #endif
@@ -1360,10 +1442,13 @@ static void expire_timers(struct timer_b
 		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
+			base->running_timer = NULL;
 			raw_spin_lock(&base->lock);
 		} else {
 			raw_spin_unlock_irq(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
+			base->running_timer = NULL;
+			timer_sync_wait_running(base);
 			raw_spin_lock_irq(&base->lock);
 		}
 	}
@@ -1658,6 +1743,7 @@ static inline void __run_timers(struct t
 	if (!time_after_eq(jiffies, base->clk))
 		return;
 
+	timer_base_lock_expiry(base);
 	raw_spin_lock_irq(&base->lock);
 
 	/*
@@ -1684,8 +1770,8 @@ static inline void __run_timers(struct t
 		while (levels--)
 			expire_timers(base, heads + levels);
 	}
-	base->running_timer = NULL;
 	raw_spin_unlock_irq(&base->lock);
+	timer_base_unlock_expiry(base);
 }
 
 /*
@@ -1930,6 +2016,7 @@ static void __init init_timer_cpu(int cp
 		base->cpu = cpu;
 		raw_spin_lock_init(&base->lock);
 		base->clk = jiffies;
+		timer_base_init_expiry_lock(base);
 	}
 }
 


