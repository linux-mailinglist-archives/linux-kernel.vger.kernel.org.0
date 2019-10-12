Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD755D4DB9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 08:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfJLGwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 02:52:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfJLGwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 02:52:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46026315C00D;
        Sat, 12 Oct 2019 06:52:22 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AB9D60600;
        Sat, 12 Oct 2019 06:52:21 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Scott Wood <swood@redhat.com>
Subject: [PATCH RT v2 2/3] sched: Lazy migrate_disable processing
Date:   Sat, 12 Oct 2019 01:52:13 -0500
Message-Id: <20191012065214.28109-3-swood@redhat.com>
In-Reply-To: <20191012065214.28109-1-swood@redhat.com>
References: <20191012065214.28109-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Sat, 12 Oct 2019 06:52:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid overhead on the majority of migrate disable/enable sequences by
only manipulating scheduler data (and grabbing the relevant locks) when
the task actually schedules while migrate-disabled.  A kernel build
showed around a 10% reduction in system time (with CONFIG_NR_CPUS=512).

Instead of cpuhp_pin_lock, CPU hotplug is handled by keeping a per-CPU
count of the number of pinned tasks (including tasks which have not
scheduled in the migrate-disabled section); takedown_cpu() will
wait until that reaches zero (confirmed by take_cpu_down() in stop
machine context to deal with races) before migrating tasks off of the
cpu.

To simplify synchronization, updating cpus_mask is no longer deferred
until migrate_enable().  This lets us not have to worry about
migrate_enable() missing the update if it's on the fast path (didn't
schedule during the migrate disabled section).  It also makes the code
a bit simpler and reduces deviation from mainline.

While the main motivation for this is the performance benefit, lazy
migrate disable also eliminates the restriction on calling
migrate_disable() while atomic but leaving the atomic region prior to
calling migrate_enable() -- though this won't help with local_bh_disable()
(and thus rcutorture) unless something similar is done with the recently
added local_lock.

Signed-off-by: Scott Wood <swood@redhat.com>
---
The speedup is smaller than before, due to commit 659252061477862f
("lib/smp_processor_id: Don't use cpumask_equal()") achieving
an overlapping speedup.
---
 include/linux/cpu.h    |   4 --
 include/linux/sched.h  |  11 +--
 init/init_task.c       |   4 ++
 kernel/cpu.c           | 103 +++++++++++-----------------
 kernel/sched/core.c    | 180 ++++++++++++++++++++-----------------------------
 kernel/sched/sched.h   |   4 ++
 lib/smp_processor_id.c |   3 +
 7 files changed, 128 insertions(+), 181 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index f4a772c12d14..2df500fdcbc4 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -113,8 +113,6 @@ static inline void cpu_maps_update_done(void)
 extern void cpu_hotplug_enable(void);
 void clear_tasks_mm_cpumask(int cpu);
 int cpu_down(unsigned int cpu);
-extern void pin_current_cpu(void);
-extern void unpin_current_cpu(void);
 
 #else /* CONFIG_HOTPLUG_CPU */
 
@@ -126,8 +124,6 @@ static inline void cpus_read_unlock(void) { }
 static inline void lockdep_assert_cpus_held(void) { }
 static inline void cpu_hotplug_disable(void) { }
 static inline void cpu_hotplug_enable(void) { }
-static inline void pin_current_cpu(void) { }
-static inline void unpin_current_cpu(void) { }
 
 #endif	/* !CONFIG_HOTPLUG_CPU */
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7e892e727f12..c6872b38bf77 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -229,6 +229,8 @@
 extern long io_schedule_timeout(long timeout);
 extern void io_schedule(void);
 
+int cpu_nr_pinned(int cpu);
+
 /**
  * struct prev_cputime - snapshot of system and user cputime
  * @utime: time spent in user mode
@@ -661,16 +663,13 @@ struct task_struct {
 	cpumask_t			cpus_mask;
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 	int				migrate_disable;
-	int				migrate_disable_update;
-	int				pinned_on_cpu;
+	bool				migrate_disable_scheduled;
 # ifdef CONFIG_SCHED_DEBUG
-	int				migrate_disable_atomic;
+	int				pinned_on_cpu;
 # endif
-
 #elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
 # ifdef CONFIG_SCHED_DEBUG
 	int				migrate_disable;
-	int				migrate_disable_atomic;
 # endif
 #endif
 #ifdef CONFIG_PREEMPT_RT_FULL
@@ -2074,4 +2073,6 @@ static inline void rseq_syscall(struct pt_regs *regs)
 
 #endif
 
+extern struct task_struct *takedown_cpu_task;
+
 #endif
diff --git a/init/init_task.c b/init/init_task.c
index e402413dc47d..c0c7618fd2fb 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -81,6 +81,10 @@ struct task_struct init_task
 	.cpus_ptr	= &init_task.cpus_mask,
 	.cpus_mask	= CPU_MASK_ALL,
 	.nr_cpus_allowed= NR_CPUS,
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE) && \
+    defined(CONFIG_SCHED_DEBUG)
+	.pinned_on_cpu	= -1,
+#endif
 	.mm		= NULL,
 	.active_mm	= &init_mm,
 	.restart_block	= {
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 25afa2bb1a2c..e1bf3c698a32 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -76,11 +76,6 @@ static DEFINE_PER_CPU(struct cpuhp_cpu_state, cpuhp_state) = {
 	.fail = CPUHP_INVALID,
 };
 
-#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PREEMPT_RT_FULL)
-static DEFINE_PER_CPU(struct rt_rw_lock, cpuhp_pin_lock) = \
-	__RWLOCK_RT_INITIALIZER(cpuhp_pin_lock);
-#endif
-
 #if defined(CONFIG_LOCKDEP) && defined(CONFIG_SMP)
 static struct lockdep_map cpuhp_state_up_map =
 	STATIC_LOCKDEP_MAP_INIT("cpuhp_state-up", &cpuhp_state_up_map);
@@ -287,57 +282,6 @@ void cpu_maps_update_done(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-/**
- * pin_current_cpu - Prevent the current cpu from being unplugged
- */
-void pin_current_cpu(void)
-{
-#ifdef CONFIG_PREEMPT_RT_FULL
-	struct rt_rw_lock *cpuhp_pin;
-	unsigned int cpu;
-	int ret;
-
-again:
-	cpuhp_pin = this_cpu_ptr(&cpuhp_pin_lock);
-	ret = __read_rt_trylock(cpuhp_pin);
-	if (ret) {
-		current->pinned_on_cpu = smp_processor_id();
-		return;
-	}
-	cpu = smp_processor_id();
-	preempt_lazy_enable();
-	preempt_enable();
-
-	sleeping_lock_inc();
-	__read_rt_lock(cpuhp_pin);
-	sleeping_lock_dec();
-
-	preempt_disable();
-	preempt_lazy_disable();
-	if (cpu != smp_processor_id()) {
-		__read_rt_unlock(cpuhp_pin);
-		goto again;
-	}
-	current->pinned_on_cpu = cpu;
-#endif
-}
-
-/**
- * unpin_current_cpu - Allow unplug of current cpu
- */
-void unpin_current_cpu(void)
-{
-#ifdef CONFIG_PREEMPT_RT_FULL
-	struct rt_rw_lock *cpuhp_pin = this_cpu_ptr(&cpuhp_pin_lock);
-
-	if (WARN_ON(current->pinned_on_cpu != smp_processor_id()))
-		cpuhp_pin = per_cpu_ptr(&cpuhp_pin_lock, current->pinned_on_cpu);
-
-	current->pinned_on_cpu = -1;
-	__read_rt_unlock(cpuhp_pin);
-#endif
-}
-
 DEFINE_STATIC_PERCPU_RWSEM(cpu_hotplug_lock);
 
 void cpus_read_lock(void)
@@ -895,6 +839,15 @@ static int take_cpu_down(void *_param)
 	int err, cpu = smp_processor_id();
 	int ret;
 
+#ifdef CONFIG_PREEMPT_RT_BASE
+	/*
+	 * If any tasks disabled migration before we got here,
+	 * go back and sleep again.
+	 */
+	if (cpu_nr_pinned(cpu))
+		return -EAGAIN;
+#endif
+
 	/* Ensure this CPU doesn't handle any more interrupts. */
 	err = __cpu_disable();
 	if (err < 0)
@@ -924,11 +877,10 @@ static int take_cpu_down(void *_param)
 	return 0;
 }
 
+struct task_struct *takedown_cpu_task;
+
 static int takedown_cpu(unsigned int cpu)
 {
-#ifdef CONFIG_PREEMPT_RT_FULL
-	struct rt_rw_lock *cpuhp_pin = per_cpu_ptr(&cpuhp_pin_lock, cpu);
-#endif
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 	int err;
 
@@ -941,17 +893,38 @@ static int takedown_cpu(unsigned int cpu)
 	 */
 	irq_lock_sparse();
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-	__write_rt_lock(cpuhp_pin);
+#ifdef CONFIG_PREEMPT_RT_BASE
+	WARN_ON_ONCE(takedown_cpu_task);
+	takedown_cpu_task = current;
+
+again:
+	/*
+	 * If a task pins this CPU after we pass this check, take_cpu_down
+	 * will return -EAGAIN.
+	 */
+	for (;;) {
+		int nr_pinned;
+
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		nr_pinned = cpu_nr_pinned(cpu);
+		if (nr_pinned == 0)
+			break;
+		schedule();
+	}
+	set_current_state(TASK_RUNNING);
 #endif
 
 	/*
 	 * So now all preempt/rcu users must observe !cpu_active().
 	 */
 	err = stop_machine_cpuslocked(take_cpu_down, NULL, cpumask_of(cpu));
+#ifdef CONFIG_PREEMPT_RT_BASE
+	if (err == -EAGAIN)
+		goto again;
+#endif
 	if (err) {
-#ifdef CONFIG_PREEMPT_RT_FULL
-		__write_rt_unlock(cpuhp_pin);
+#ifdef CONFIG_PREEMPT_RT_BASE
+		takedown_cpu_task = NULL;
 #endif
 		/* CPU refused to die */
 		irq_unlock_sparse();
@@ -971,8 +944,8 @@ static int takedown_cpu(unsigned int cpu)
 	wait_for_ap_thread(st, false);
 	BUG_ON(st->state != CPUHP_AP_IDLE_DEAD);
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-	__write_rt_unlock(cpuhp_pin);
+#ifdef CONFIG_PREEMPT_RT_BASE
+	takedown_cpu_task = NULL;
 #endif
 	/* Interrupts are moved away from the dying cpu, reenable alloc/free */
 	irq_unlock_sparse();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bfd160e90797..5cb2a519b8bf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1126,7 +1126,8 @@ static int migration_cpu_stop(void *data)
 void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask)
 {
 	cpumask_copy(&p->cpus_mask, new_mask);
-	p->nr_cpus_allowed = cpumask_weight(new_mask);
+	if (p->cpus_ptr == &p->cpus_mask)
+		p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
@@ -1137,8 +1138,7 @@ int __migrate_disabled(struct task_struct *p)
 EXPORT_SYMBOL_GPL(__migrate_disabled);
 #endif
 
-static void __do_set_cpus_allowed_tail(struct task_struct *p,
-				       const struct cpumask *new_mask)
+void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
 	struct rq *rq = task_rq(p);
 	bool queued, running;
@@ -1167,20 +1167,6 @@ static void __do_set_cpus_allowed_tail(struct task_struct *p,
 		set_curr_task(rq, p);
 }
 
-void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
-{
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
-	if (__migrate_disabled(p)) {
-		lockdep_assert_held(&p->pi_lock);
-
-		cpumask_copy(&p->cpus_mask, new_mask);
-		p->migrate_disable_update = 1;
-		return;
-	}
-#endif
-	__do_set_cpus_allowed_tail(p, new_mask);
-}
-
 /*
  * Change a given task's CPU affinity. Migrate the thread to a
  * proper CPU and schedule it away if the CPU it's executing on
@@ -1239,7 +1225,8 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	}
 
 	/* Can the task run on the task's current CPU? If so, we're done */
-	if (cpumask_test_cpu(task_cpu(p), new_mask) || __migrate_disabled(p))
+	if (cpumask_test_cpu(task_cpu(p), new_mask) ||
+	    p->cpus_ptr != &p->cpus_mask)
 		goto out;
 
 	dest_cpu = cpumask_any_and(cpu_valid_mask, new_mask);
@@ -3502,6 +3489,8 @@ static inline void schedule_debug(struct task_struct *prev)
 	BUG();
 }
 
+static void migrate_disabled_sched(struct task_struct *p);
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -3572,6 +3561,9 @@ static void __sched notrace __schedule(bool preempt)
 	rq_lock(rq, &rf);
 	smp_mb__after_spinlock();
 
+	if (__migrate_disabled(prev))
+		migrate_disabled_sched(prev);
+
 	/* Promote REQ to ACT */
 	rq->clock_update_flags <<= 1;
 	update_rq_clock(rq);
@@ -5822,6 +5814,8 @@ static void migrate_tasks(struct rq *dead_rq, struct rq_flags *rf)
 		BUG_ON(!next);
 		put_prev_task(rq, next);
 
+		WARN_ON_ONCE(__migrate_disabled(next));
+
 		/*
 		 * Rules for changing task_struct::cpus_mask are holding
 		 * both pi_lock and rq->lock, such that holding either
@@ -7317,14 +7311,9 @@ void dump_cpu_task(int cpu)
 static inline void
 migrate_disable_update_cpus_allowed(struct task_struct *p)
 {
-	struct rq *rq;
-	struct rq_flags rf;
-
-	rq = task_rq_lock(p, &rf);
 	p->cpus_ptr = cpumask_of(smp_processor_id());
 	update_nr_migratory(p, -1);
 	p->nr_cpus_allowed = 1;
-	task_rq_unlock(rq, p, &rf);
 }
 
 static inline void
@@ -7342,54 +7331,35 @@ void dump_cpu_task(int cpu)
 
 void migrate_disable(void)
 {
-	struct task_struct *p = current;
+	preempt_disable();
 
-	if (in_atomic() || irqs_disabled()) {
+	if (++current->migrate_disable == 1) {
+		this_rq()->nr_pinned++;
+		preempt_lazy_disable();
 #ifdef CONFIG_SCHED_DEBUG
-		p->migrate_disable_atomic++;
+		WARN_ON_ONCE(current->pinned_on_cpu >= 0);
+		current->pinned_on_cpu = smp_processor_id();
 #endif
-		return;
-	}
-#ifdef CONFIG_SCHED_DEBUG
-	if (unlikely(p->migrate_disable_atomic)) {
-		tracing_off();
-		WARN_ON_ONCE(1);
 	}
-#endif
 
-	if (p->migrate_disable) {
-		p->migrate_disable++;
-		return;
-	}
+	preempt_enable();
+}
+EXPORT_SYMBOL(migrate_disable);
 
-	preempt_disable();
-	preempt_lazy_disable();
-	pin_current_cpu();
+static void migrate_disabled_sched(struct task_struct *p)
+{
+	if (p->migrate_disable_scheduled)
+		return;
 
 	migrate_disable_update_cpus_allowed(p);
-	p->migrate_disable = 1;
-
-	preempt_enable();
+	p->migrate_disable_scheduled = 1;
 }
-EXPORT_SYMBOL(migrate_disable);
 
 void migrate_enable(void)
 {
 	struct task_struct *p = current;
-
-	if (in_atomic() || irqs_disabled()) {
-#ifdef CONFIG_SCHED_DEBUG
-		p->migrate_disable_atomic--;
-#endif
-		return;
-	}
-
-#ifdef CONFIG_SCHED_DEBUG
-	if (unlikely(p->migrate_disable_atomic)) {
-		tracing_off();
-		WARN_ON_ONCE(1);
-	}
-#endif
+	struct rq *rq = this_rq();
+	int cpu = task_cpu(p);
 
 	WARN_ON_ONCE(p->migrate_disable <= 0);
 	if (p->migrate_disable > 1) {
@@ -7399,65 +7369,67 @@ void migrate_enable(void)
 
 	preempt_disable();
 
+#ifdef CONFIG_SCHED_DEBUG
+	WARN_ON_ONCE(current->pinned_on_cpu != cpu);
+	current->pinned_on_cpu = -1;
+#endif
+
+	WARN_ON_ONCE(rq->nr_pinned < 1);
+
 	p->migrate_disable = 0;
+	rq->nr_pinned--;
+	if (rq->nr_pinned == 0 && unlikely(!cpu_active(cpu)) &&
+	    takedown_cpu_task)
+		wake_up_process(takedown_cpu_task);
+
+	if (!p->migrate_disable_scheduled)
+		goto out;
+
+	p->migrate_disable_scheduled = 0;
+
 	migrate_enable_update_cpus_allowed(p);
 
-	if (p->migrate_disable_update) {
-		struct rq *rq;
+	WARN_ON(smp_processor_id() != cpu);
+	if (!is_cpu_allowed(p, cpu)) {
+		struct migration_arg arg = { p };
 		struct rq_flags rf;
-		int cpu = task_cpu(p);
 
 		rq = task_rq_lock(p, &rf);
 		update_rq_clock(rq);
-
-		__do_set_cpus_allowed_tail(p, &p->cpus_mask);
+		arg.dest_cpu = select_fallback_rq(cpu, p);
 		task_rq_unlock(rq, p, &rf);
 
-		p->migrate_disable_update = 0;
+		preempt_lazy_enable();
+		preempt_enable();
 
-		WARN_ON(smp_processor_id() != cpu);
-		if (!cpumask_test_cpu(cpu, &p->cpus_mask)) {
-			struct migration_arg arg = { p };
-			struct rq_flags rf;
-
-			rq = task_rq_lock(p, &rf);
-			update_rq_clock(rq);
-			arg.dest_cpu = select_fallback_rq(cpu, p);
-			task_rq_unlock(rq, p, &rf);
-
-			unpin_current_cpu();
-			preempt_lazy_enable();
-			preempt_enable();
-
-			sleeping_lock_inc();
-			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
-			sleeping_lock_dec();
-			return;
-		}
+		sleeping_lock_inc();
+		stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
+		sleeping_lock_dec();
+		return;
 	}
-	unpin_current_cpu();
+
+out:
 	preempt_lazy_enable();
 	preempt_enable();
 }
 EXPORT_SYMBOL(migrate_enable);
 
-#elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
-void migrate_disable(void)
+int cpu_nr_pinned(int cpu)
 {
-#ifdef CONFIG_SCHED_DEBUG
-	struct task_struct *p = current;
+	struct rq *rq = cpu_rq(cpu);
 
-	if (in_atomic() || irqs_disabled()) {
-		p->migrate_disable_atomic++;
-		return;
-	}
+	return rq->nr_pinned;
+}
 
-	if (unlikely(p->migrate_disable_atomic)) {
-		tracing_off();
-		WARN_ON_ONCE(1);
-	}
+#elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
+static void migrate_disabled_sched(struct task_struct *p)
+{
+}
 
-	p->migrate_disable++;
+void migrate_disable(void)
+{
+#ifdef CONFIG_SCHED_DEBUG
+	current->migrate_disable++;
 #endif
 	barrier();
 }
@@ -7468,20 +7440,14 @@ void migrate_enable(void)
 #ifdef CONFIG_SCHED_DEBUG
 	struct task_struct *p = current;
 
-	if (in_atomic() || irqs_disabled()) {
-		p->migrate_disable_atomic--;
-		return;
-	}
-
-	if (unlikely(p->migrate_disable_atomic)) {
-		tracing_off();
-		WARN_ON_ONCE(1);
-	}
-
 	WARN_ON_ONCE(p->migrate_disable <= 0);
 	p->migrate_disable--;
 #endif
 	barrier();
 }
 EXPORT_SYMBOL(migrate_enable);
+#else
+static void migrate_disabled_sched(struct task_struct *p)
+{
+}
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9c1bbd67e971..2e4db417049d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -952,6 +952,10 @@ struct rq {
 	/* Must be inspected within a rcu lock section */
 	struct cpuidle_state	*idle_state;
 #endif
+
+#if defined(CONFIG_PREEMPT_RT_BASE) && defined(CONFIG_SMP)
+	int			nr_pinned;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index bd9571653288..5f2618d346c4 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -23,6 +23,9 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	 * Kernel threads bound to a single CPU can safely use
 	 * smp_processor_id():
 	 */
+	if (current->migrate_disable)
+		goto out;
+
 	if (current->nr_cpus_allowed == 1)
 		goto out;
 
-- 
1.8.3.1

