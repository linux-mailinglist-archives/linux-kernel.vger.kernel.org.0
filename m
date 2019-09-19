Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82145B8022
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 19:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404345AbfISRil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 13:38:41 -0400
Received: from mail.efficios.com ([167.114.142.138]:33754 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403969AbfISRig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:38:36 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B93693318B9;
        Thu, 19 Sep 2019 13:38:33 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id KpKrxsqOK4xY; Thu, 19 Sep 2019 13:38:33 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id AA3DB331882;
        Thu, 19 Sep 2019 13:38:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AA3DB331882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568914711;
        bh=7q2hJvzueHt5iEQJ53TkJTxYjvaerIBjSKsuoaAxyOw=;
        h=From:To:Date:Message-Id;
        b=ro+qmubG7E7JtVJ0JqPNwSy6tCJw/mZPV5i0532Y+xMZF5vKjxrHQHJXMeviBbj96
         ZiKBuWc4Al/CS2e02RdJGw3uvx0dE4mKy2MjwMX4qfM5vh2LXH72pDZjcKOJPLIvGN
         9i/SPS5ZcRrOdAB74NNW1cl9b2mqtxsVQGZa2/A7Jk2OBlAOoQMUfma1P11P3esk/4
         jq8cEw9FBxjZMK7qw/obBzLY1n448WWiuugfTQOSozYhNOQxfRKENEP/c3FkyoepoS
         z4ffbdEeplyaJitXs0x53Z2mdfGorxIYRQCSZ51x9Ur04N5wZCO/dO3mN9n7lvxjC/
         6SuxWqntqa7jA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id CYyuOq9xlBrH; Thu, 19 Sep 2019 13:38:31 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 3EE5533186A;
        Thu, 19 Sep 2019 13:38:31 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 5.4 4/7] Fix: sched/membarrier: p->mm->membarrier_state racy load (v4)
Date:   Thu, 19 Sep 2019 13:37:02 -0400
Message-Id: <20190919173705.2181-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919173705.2181-1-mathieu.desnoyers@efficios.com>
References: <20190919173705.2181-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The membarrier_state field is located within the mm_struct, which
is not guaranteed to exist when used from runqueue-lock-free iteration
on runqueues by the membarrier system call.

Copy the membarrier_state from the mm_struct into the scheduler runqueue
when the scheduler switches between mm.

When registering membarrier for mm, after setting the registration bit
in the mm membarrier state, issue a synchronize_rcu() to ensure the
scheduler observes the change. In order to take care of the case
where a runqueue keeps executing the target mm without swapping to
other mm, iterate over each runqueue and issue an IPI to copy the
membarrier_state from the mm_struct into each runqueue which have the
same mm which state has just been modified.

Move the mm membarrier_state field closer to pgd in mm_struct to use
a cache line already touched by the scheduler switch_mm.

The membarrier_execve() (now membarrier_exec_mmap) hook now needs to
clear the runqueue's membarrier state in addition to clear the mm
membarrier state, so move its implementation into the scheduler
membarrier code so it can access the runqueue structure.

Add memory barrier in membarrier_exec_mmap() prior to clearing
the membarrier state, ensuring memory accesses executed prior to exec
are not reordered with the stores clearing the membarrier state.

As suggested by Linus, move all membarrier.c RCU read-side locks outside
of the for each cpu loops.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Kirill Tkhai <tkhai@yandex.ru>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
Changes since v1:
- Take care of Peter Zijlstra's feedback, moving callsites closer
  to switch_mm() (scheduler) and activate_mm() (execve).
- Add memory barrier in membarrier_exec_mmap() prior to clearing
  the membarrier state.

Changes since v2:
- Move the call to membarrier_exec_mmap() before setting tsk->mm
  to its new value, so the memory barrier is done before this
  store.

Changes since v3:
- Use GFP_KERNEL for registration cpumask allocation.
- Use this_cpu_write() to update the runqueue's membarrier_state.
- Return -ENOMEM to userspace if cpumask allocation fails. Remove
  fallback code.
---
 fs/exec.c                 |   2 +-
 include/linux/mm_types.h  |  14 ++-
 include/linux/sched/mm.h  |   8 +-
 kernel/sched/core.c       |   4 +-
 kernel/sched/membarrier.c | 176 ++++++++++++++++++++++++++++----------
 kernel/sched/sched.h      |  34 ++++++++
 6 files changed, 184 insertions(+), 54 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index f7f6a140856a..555e93c7dec8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1033,6 +1033,7 @@ static int exec_mmap(struct mm_struct *mm)
 	}
 	task_lock(tsk);
 	active_mm = tsk->active_mm;
+	membarrier_exec_mmap(mm);
 	tsk->mm = mm;
 	tsk->active_mm = mm;
 	activate_mm(active_mm, mm);
@@ -1825,7 +1826,6 @@ static int __do_execve_file(int fd, struct filename *filename,
 	/* execve succeeded */
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
-	membarrier_execve(current);
 	rseq_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6a7a1083b6fb..ec9bd3a6c827 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -383,6 +383,16 @@ struct mm_struct {
 		unsigned long highest_vm_end;	/* highest vma end address */
 		pgd_t * pgd;
 
+#ifdef CONFIG_MEMBARRIER
+		/**
+		 * @membarrier_state: Flags controlling membarrier behavior.
+		 *
+		 * This field is close to @pgd to hopefully fit in the same
+		 * cache-line, which needs to be touched by switch_mm().
+		 */
+		atomic_t membarrier_state;
+#endif
+
 		/**
 		 * @mm_users: The number of users including userspace.
 		 *
@@ -452,9 +462,7 @@ struct mm_struct {
 		unsigned long flags; /* Must use atomic bitops to access */
 
 		struct core_state *core_state; /* coredumping support */
-#ifdef CONFIG_MEMBARRIER
-		atomic_t membarrier_state;
-#endif
+
 #ifdef CONFIG_AIO
 		spinlock_t			ioctx_lock;
 		struct kioctx_table __rcu	*ioctx_table;
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 8557ec664213..e6770012db18 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -370,10 +370,8 @@ static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
 	sync_core_before_usermode();
 }
 
-static inline void membarrier_execve(struct task_struct *t)
-{
-	atomic_set(&t->mm->membarrier_state, 0);
-}
+extern void membarrier_exec_mmap(struct mm_struct *mm);
+
 #else
 #ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
 static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
@@ -382,7 +380,7 @@ static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
 {
 }
 #endif
-static inline void membarrier_execve(struct task_struct *t)
+static inline void membarrier_exec_mmap(struct mm_struct *mm)
 {
 }
 static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index df9f1fe5689b..e25d0b97a242 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3238,8 +3238,10 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		next->active_mm = oldmm;
 		mmgrab(oldmm);
 		enter_lazy_tlb(oldmm, next);
-	} else
+	} else {
+		membarrier_switch_mm(rq, oldmm, mm);
 		switch_mm_irqs_off(oldmm, mm, next);
+	}
 
 	if (!prev->mm) {
 		prev->active_mm = NULL;
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 7e0a0d6535f3..fce06a2e1d89 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -30,6 +30,39 @@ static void ipi_mb(void *info)
 	smp_mb();	/* IPIs should be serializing but paranoid. */
 }
 
+static void ipi_sync_rq_state(void *info)
+{
+	struct mm_struct *mm = (struct mm_struct *) info;
+
+	if (current->mm != mm)
+		return;
+	this_cpu_write(runqueues.membarrier_state,
+		       atomic_read(&mm->membarrier_state));
+	/*
+	 * Issue a memory barrier after setting
+	 * MEMBARRIER_STATE_GLOBAL_EXPEDITED in the current runqueue to
+	 * guarantee that no memory access following registration is reordered
+	 * before registration.
+	 */
+	smp_mb();
+}
+
+void membarrier_exec_mmap(struct mm_struct *mm)
+{
+	/*
+	 * Issue a memory barrier before clearing membarrier_state to
+	 * guarantee that no memory access prior to exec is reordered after
+	 * clearing this state.
+	 */
+	smp_mb();
+	atomic_set(&mm->membarrier_state, 0);
+	/*
+	 * Keep the runqueue membarrier_state in sync with this mm
+	 * membarrier_state.
+	 */
+	this_cpu_write(runqueues.membarrier_state, 0);
+}
+
 static int membarrier_global_expedited(void)
 {
 	int cpu;
@@ -56,6 +89,7 @@ static int membarrier_global_expedited(void)
 	}
 
 	cpus_read_lock();
+	rcu_read_lock();
 	for_each_online_cpu(cpu) {
 		struct task_struct *p;
 
@@ -70,17 +104,25 @@ static int membarrier_global_expedited(void)
 		if (cpu == raw_smp_processor_id())
 			continue;
 
-		rcu_read_lock();
+		if (!(READ_ONCE(cpu_rq(cpu)->membarrier_state) &
+		    MEMBARRIER_STATE_GLOBAL_EXPEDITED))
+			continue;
+
+		/*
+		 * Skip the CPU if it runs a kernel thread. The scheduler
+		 * leaves the prior task mm in place as an optimization when
+		 * scheduling a kthread.
+		 */
 		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
-		if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
-				   MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {
-			if (!fallback)
-				__cpumask_set_cpu(cpu, tmpmask);
-			else
-				smp_call_function_single(cpu, ipi_mb, NULL, 1);
-		}
-		rcu_read_unlock();
+		if (p->flags & PF_KTHREAD)
+			continue;
+
+		if (!fallback)
+			__cpumask_set_cpu(cpu, tmpmask);
+		else
+			smp_call_function_single(cpu, ipi_mb, NULL, 1);
 	}
+	rcu_read_unlock();
 	if (!fallback) {
 		preempt_disable();
 		smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
@@ -136,6 +178,7 @@ static int membarrier_private_expedited(int flags)
 	}
 
 	cpus_read_lock();
+	rcu_read_lock();
 	for_each_online_cpu(cpu) {
 		struct task_struct *p;
 
@@ -149,7 +192,6 @@ static int membarrier_private_expedited(int flags)
 		 */
 		if (cpu == raw_smp_processor_id())
 			continue;
-		rcu_read_lock();
 		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
 		if (p && p->mm == current->mm) {
 			if (!fallback)
@@ -157,8 +199,8 @@ static int membarrier_private_expedited(int flags)
 			else
 				smp_call_function_single(cpu, ipi_mb, NULL, 1);
 		}
-		rcu_read_unlock();
 	}
+	rcu_read_unlock();
 	if (!fallback) {
 		preempt_disable();
 		smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
@@ -177,32 +219,78 @@ static int membarrier_private_expedited(int flags)
 	return 0;
 }
 
+static int sync_runqueues_membarrier_state(struct mm_struct *mm)
+{
+	int membarrier_state = atomic_read(&mm->membarrier_state);
+	cpumask_var_t tmpmask;
+	int cpu;
+
+	if (atomic_read(&mm->mm_users) == 1 || num_online_cpus() == 1) {
+		this_cpu_write(runqueues.membarrier_state, membarrier_state);
+
+		/*
+		 * For single mm user, we can simply issue a memory barrier
+		 * after setting MEMBARRIER_STATE_GLOBAL_EXPEDITED in the
+		 * mm and in the current runqueue to guarantee that no memory
+		 * access following registration is reordered before
+		 * registration.
+		 */
+		smp_mb();
+		return 0;
+	}
+
+	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
+		return -ENOMEM;
+
+	/*
+	 * For mm with multiple users, we need to ensure all future
+	 * scheduler executions will observe @mm's new membarrier
+	 * state.
+	 */
+	synchronize_rcu();
+
+	/*
+	 * For each cpu runqueue, if the task's mm match @mm, ensure that all
+	 * @mm's membarrier state set bits are also set in in the runqueue's
+	 * membarrier state. This ensures that a runqueue scheduling
+	 * between threads which are users of @mm has its membarrier state
+	 * updated.
+	 */
+	cpus_read_lock();
+	rcu_read_lock();
+	for_each_online_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+		struct task_struct *p;
+
+		p = task_rcu_dereference(&rq->curr);
+		if (p && p->mm == mm)
+			__cpumask_set_cpu(cpu, tmpmask);
+	}
+	rcu_read_unlock();
+
+	preempt_disable();
+	smp_call_function_many(tmpmask, ipi_sync_rq_state, mm, 1);
+	preempt_enable();
+
+	free_cpumask_var(tmpmask);
+	cpus_read_unlock();
+
+	return 0;
+}
+
 static int membarrier_register_global_expedited(void)
 {
 	struct task_struct *p = current;
 	struct mm_struct *mm = p->mm;
+	int ret;
 
 	if (atomic_read(&mm->membarrier_state) &
 	    MEMBARRIER_STATE_GLOBAL_EXPEDITED_READY)
 		return 0;
 	atomic_or(MEMBARRIER_STATE_GLOBAL_EXPEDITED, &mm->membarrier_state);
-	if (atomic_read(&mm->mm_users) == 1) {
-		/*
-		 * For single mm user, single threaded process, we can
-		 * simply issue a memory barrier after setting
-		 * MEMBARRIER_STATE_GLOBAL_EXPEDITED to guarantee that
-		 * no memory access following registration is reordered
-		 * before registration.
-		 */
-		smp_mb();
-	} else {
-		/*
-		 * For multi-mm user threads, we need to ensure all
-		 * future scheduler executions will observe the new
-		 * thread flag state for this mm.
-		 */
-		synchronize_rcu();
-	}
+	ret = sync_runqueues_membarrier_state(mm);
+	if (ret)
+		return ret;
 	atomic_or(MEMBARRIER_STATE_GLOBAL_EXPEDITED_READY,
 		  &mm->membarrier_state);
 
@@ -213,12 +301,15 @@ static int membarrier_register_private_expedited(int flags)
 {
 	struct task_struct *p = current;
 	struct mm_struct *mm = p->mm;
-	int state = MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY;
+	int ready_state = MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY,
+	    set_state = MEMBARRIER_STATE_PRIVATE_EXPEDITED,
+	    ret;
 
 	if (flags & MEMBARRIER_FLAG_SYNC_CORE) {
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE))
 			return -EINVAL;
-		state = MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY;
+		ready_state =
+			MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY;
 	}
 
 	/*
@@ -226,20 +317,15 @@ static int membarrier_register_private_expedited(int flags)
 	 * groups, which use the same mm. (CLONE_VM but not
 	 * CLONE_THREAD).
 	 */
-	if ((atomic_read(&mm->membarrier_state) & state) == state)
+	if ((atomic_read(&mm->membarrier_state) & ready_state) == ready_state)
 		return 0;
-	atomic_or(MEMBARRIER_STATE_PRIVATE_EXPEDITED, &mm->membarrier_state);
 	if (flags & MEMBARRIER_FLAG_SYNC_CORE)
-		atomic_or(MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE,
-			  &mm->membarrier_state);
-	if (atomic_read(&mm->mm_users) != 1) {
-		/*
-		 * Ensure all future scheduler executions will observe the
-		 * new thread flag state for this process.
-		 */
-		synchronize_rcu();
-	}
-	atomic_or(state, &mm->membarrier_state);
+		set_state |= MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE;
+	atomic_or(set_state, &mm->membarrier_state);
+	ret = sync_runqueues_membarrier_state(mm);
+	if (ret)
+		return ret;
+	atomic_or(ready_state, &mm->membarrier_state);
 
 	return 0;
 }
@@ -253,8 +339,10 @@ static int membarrier_register_private_expedited(int flags)
  * command specified does not exist, not available on the running
  * kernel, or if the command argument is invalid, this system call
  * returns -EINVAL. For a given command, with flags argument set to 0,
- * this system call is guaranteed to always return the same value until
- * reboot.
+ * if this system call returns -ENOSYS or -EINVAL, it is guaranteed to
+ * always return the same value until reboot. In addition, it can return
+ * -ENOMEM if there is not enough memory available to perform the system
+ * call.
  *
  * All memory accesses performed in program order from each targeted thread
  * is guaranteed to be ordered with respect to sys_membarrier(). If we use
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 802b1f3405f2..85cb30b1b6b7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -907,6 +907,10 @@ struct rq {
 
 	atomic_t		nr_iowait;
 
+#ifdef CONFIG_MEMBARRIER
+	int membarrier_state;
+#endif
+
 #ifdef CONFIG_SMP
 	struct root_domain		*rd;
 	struct sched_domain __rcu	*sd;
@@ -2423,3 +2427,33 @@ static inline bool sched_energy_enabled(void)
 static inline bool sched_energy_enabled(void) { return false; }
 
 #endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
+
+#ifdef CONFIG_MEMBARRIER
+/*
+ * The scheduler provides memory barriers required by membarrier between:
+ * - prior user-space memory accesses and store to rq->membarrier_state,
+ * - store to rq->membarrier_state and following user-space memory accesses.
+ * In the same way it provides those guarantees around store to rq->curr.
+ */
+static inline void membarrier_switch_mm(struct rq *rq,
+					struct mm_struct *prev_mm,
+					struct mm_struct *next_mm)
+{
+	int membarrier_state;
+
+	if (prev_mm == next_mm)
+		return;
+
+	membarrier_state = atomic_read(&next_mm->membarrier_state);
+	if (READ_ONCE(rq->membarrier_state) == membarrier_state)
+		return;
+
+	WRITE_ONCE(rq->membarrier_state, membarrier_state);
+}
+#else
+static inline void membarrier_switch_mm(struct rq *rq,
+					struct mm_struct *prev_mm,
+					struct mm_struct *next_mm)
+{
+}
+#endif
-- 
2.17.1

