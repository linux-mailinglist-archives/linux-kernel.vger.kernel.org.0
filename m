Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 324D52FE80
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 16:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfE3Owm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 10:52:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbfE3Owj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:52:39 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEpsoq163907
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:52:38 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2stgm129km-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:52:37 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:52:37 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 15:52:30 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEqTG734472134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:52:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1418B2072;
        Thu, 30 May 2019 14:52:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 611A6B2065;
        Thu, 30 May 2019 14:52:29 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:52:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 298B816C373B; Thu, 30 May 2019 07:52:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 01/12] rcu: Enable elimination of Tree-RCU softirq processing
Date:   Thu, 30 May 2019 07:52:18 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530145204.GA28526@linux.ibm.com>
References: <20190530145204.GA28526@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053014-0060-0000-0000-00000349F5EF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210783; UDB=6.00636156; IPR=6.00991817;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 14:52:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053014-0061-0000-0000-0000498DF434
Message-Id: <20190530145229.29565-1-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=38 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Some workloads need to change kthread priority for RCU core processing
without affecting other softirq work.  This commit therefore introduces
the rcutree.use_softirq kernel boot parameter, which moves the RCU core
work from softirq to a per-CPU SCHED_OTHER kthread named rcuc.  Use of
SCHED_OTHER approach avoids the scalability problems that appeared
with the earlier attempt to move RCU core processing to from softirq
to kthreads.  That said, kernels built with RCU_BOOST=y will run the
rcuc kthreads at the RCU-boosting priority.

Note that rcutree.use_softirq=0 must be specified to move RCU core
processing to the rcuc kthreads: rcutree.use_softirq=1 is the default.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[ paulmck: Adjust for invoke_rcu_callbacks() only ever being invoked
  from RCU core processing, in contrast to softirq->rcuc transition
  in old mainline RCU priority boosting. ]
[ paulmck: Avoid wakeups when scheduler might have invoked rcu_read_unlock()
  while holding rq or pi locks, also possibly fixing a pre-existing latent
  bug involving raise_softirq()-induced wakeups. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 .../admin-guide/kernel-parameters.txt         |   6 +
 kernel/rcu/tree.c                             | 138 ++++++++++++++++--
 kernel/rcu/tree.h                             |   2 +-
 kernel/rcu/tree_plugin.h                      | 134 ++---------------
 4 files changed, 146 insertions(+), 134 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 138f6664b2e2..b96fd15c7316 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3752,6 +3752,12 @@
 			the propagation of recent CPU-hotplug changes up
 			the rcu_node combining tree.
 
+	rcutree.use_softirq=	[KNL]
+			If set to zero, move all RCU_SOFTIRQ processing to
+			per-CPU rcuc kthreads.  Defaults to a non-zero
+			value, meaning that RCU_SOFTIRQ is used by default.
+			Specify rcutree.use_softirq=0 to use rcuc kthreads.
+
 	rcutree.rcu_fanout_exact= [KNL]
 			Disable autobalancing of the rcu_node combining
 			tree.  This is used by rcutorture, and might
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 980ca3ca643f..8e290163505a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -51,6 +51,12 @@
 #include <linux/tick.h>
 #include <linux/sysrq.h>
 #include <linux/kprobes.h>
+#include <linux/gfp.h>
+#include <linux/oom.h>
+#include <linux/smpboot.h>
+#include <linux/jiffies.h>
+#include <linux/sched/isolation.h>
+#include "../time/tick-internal.h"
 
 #include "tree.h"
 #include "rcu.h"
@@ -92,6 +98,9 @@ struct rcu_state rcu_state = {
 /* Dump rcu_node combining tree at boot to verify correct setup. */
 static bool dump_tree;
 module_param(dump_tree, bool, 0444);
+/* By default, use RCU_SOFTIRQ instead of rcuc kthreads. */
+static bool use_softirq = 1;
+module_param(use_softirq, bool, 0444);
 /* Control rcu_node-tree auto-balancing at boot time. */
 static bool rcu_fanout_exact;
 module_param(rcu_fanout_exact, bool, 0444);
@@ -2253,7 +2262,7 @@ void rcu_force_quiescent_state(void)
 EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
 
 /* Perform RCU core processing work for the current CPU.  */
-static __latent_entropy void rcu_core(struct softirq_action *unused)
+static __latent_entropy void rcu_core(void)
 {
 	unsigned long flags;
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
@@ -2295,29 +2304,131 @@ static __latent_entropy void rcu_core(struct softirq_action *unused)
 	trace_rcu_utilization(TPS("End RCU core"));
 }
 
+static void rcu_core_si(struct softirq_action *h)
+{
+	rcu_core();
+}
+
+static void rcu_wake_cond(struct task_struct *t, int status)
+{
+	/*
+	 * If the thread is yielding, only wake it when this
+	 * is invoked from idle
+	 */
+	if (t && (status != RCU_KTHREAD_YIELDING || is_idle_task(current)))
+		wake_up_process(t);
+}
+
+static void invoke_rcu_core_kthread(void)
+{
+	struct task_struct *t;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__this_cpu_write(rcu_data.rcu_cpu_has_work, 1);
+	t = __this_cpu_read(rcu_data.rcu_cpu_kthread_task);
+	if (t != NULL && t != current)
+		rcu_wake_cond(t, __this_cpu_read(rcu_data.rcu_cpu_kthread_status));
+	local_irq_restore(flags);
+}
+
 /*
- * Schedule RCU callback invocation.  If the running implementation of RCU
- * does not support RCU priority boosting, just do a direct call, otherwise
- * wake up the per-CPU kernel kthread.  Note that because we are running
- * on the current CPU with softirqs disabled, the rcu_cpu_kthread_task
- * cannot disappear out from under us.
+ * Do RCU callback invocation.  Not that if we are running !use_softirq,
+ * we are already in the rcuc kthread.  If callbacks are offloaded, then
+ * ->cblist is always empty, so we don't get here.  Therefore, we only
+ * ever need to check for the scheduler being operational (some callbacks
+ * do wakeups, so we do need the scheduler).
  */
 static void invoke_rcu_callbacks(struct rcu_data *rdp)
 {
 	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
 		return;
-	if (likely(!rcu_state.boost)) {
-		rcu_do_batch(rdp);
-		return;
-	}
-	invoke_rcu_callbacks_kthread();
+	rcu_do_batch(rdp);
 }
 
+/*
+ * Wake up this CPU's rcuc kthread to do RCU core processing.
+ */
 static void invoke_rcu_core(void)
 {
-	if (cpu_online(smp_processor_id()))
+	if (!cpu_online(smp_processor_id()))
+		return;
+	if (use_softirq)
 		raise_softirq(RCU_SOFTIRQ);
+	else
+		invoke_rcu_core_kthread();
+}
+
+static void rcu_cpu_kthread_park(unsigned int cpu)
+{
+	per_cpu(rcu_data.rcu_cpu_kthread_status, cpu) = RCU_KTHREAD_OFFCPU;
+}
+
+static int rcu_cpu_kthread_should_run(unsigned int cpu)
+{
+	return __this_cpu_read(rcu_data.rcu_cpu_has_work);
+}
+
+/*
+ * Per-CPU kernel thread that invokes RCU callbacks.  This replaces
+ * the RCU softirq used in configurations of RCU that do not support RCU
+ * priority boosting.
+ */
+static void rcu_cpu_kthread(unsigned int cpu)
+{
+	unsigned int *statusp = this_cpu_ptr(&rcu_data.rcu_cpu_kthread_status);
+	char work, *workp = this_cpu_ptr(&rcu_data.rcu_cpu_has_work);
+	int spincnt;
+
+	for (spincnt = 0; spincnt < 10; spincnt++) {
+		trace_rcu_utilization(TPS("Start CPU kthread@rcu_wait"));
+		local_bh_disable();
+		*statusp = RCU_KTHREAD_RUNNING;
+		local_irq_disable();
+		work = *workp;
+		*workp = 0;
+		local_irq_enable();
+		if (work)
+			rcu_core();
+		local_bh_enable();
+		if (*workp == 0) {
+			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
+			*statusp = RCU_KTHREAD_WAITING;
+			return;
+		}
+	}
+	*statusp = RCU_KTHREAD_YIELDING;
+	trace_rcu_utilization(TPS("Start CPU kthread@rcu_yield"));
+	schedule_timeout_interruptible(2);
+	trace_rcu_utilization(TPS("End CPU kthread@rcu_yield"));
+	*statusp = RCU_KTHREAD_WAITING;
+}
+
+static struct smp_hotplug_thread rcu_cpu_thread_spec = {
+	.store			= &rcu_data.rcu_cpu_kthread_task,
+	.thread_should_run	= rcu_cpu_kthread_should_run,
+	.thread_fn		= rcu_cpu_kthread,
+	.thread_comm		= "rcuc/%u",
+	.setup			= rcu_cpu_kthread_setup,
+	.park			= rcu_cpu_kthread_park,
+};
+
+/*
+ * Spawn per-CPU RCU core processing kthreads.
+ */
+static int __init rcu_spawn_core_kthreads(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		per_cpu(rcu_data.rcu_cpu_has_work, cpu) = 0;
+	if (!IS_ENABLED(CONFIG_RCU_BOOST) && use_softirq)
+		return 0;
+	WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec),
+		  "%s: Could not start rcuc kthread, OOM is now expected behavior\n", __func__);
+	return 0;
 }
+early_initcall(rcu_spawn_core_kthreads);
 
 /*
  * Handle any core-RCU processing required by a call_rcu() invocation.
@@ -3355,7 +3466,8 @@ void __init rcu_init(void)
 	rcu_init_one();
 	if (dump_tree)
 		rcu_dump_rcu_node_tree();
-	open_softirq(RCU_SOFTIRQ, rcu_core);
+	if (use_softirq)
+		open_softirq(RCU_SOFTIRQ, rcu_core_si);
 
 	/*
 	 * We don't need protection against CPU-hotplug here because
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e253d11af3c4..a1a72a1ecb02 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -407,8 +407,8 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func);
 static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
-static void invoke_rcu_callbacks_kthread(void);
 static bool rcu_is_callbacks_kthread(void);
+static void rcu_cpu_kthread_setup(unsigned int cpu);
 static void __init rcu_spawn_boost_kthreads(void);
 static void rcu_prepare_kthreads(int cpu);
 static void rcu_cleanup_after_idle(void);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1102765f91fd..21611862e083 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -11,29 +11,7 @@
  *	   Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
-#include <linux/delay.h>
-#include <linux/gfp.h>
-#include <linux/oom.h>
-#include <linux/sched/debug.h>
-#include <linux/smpboot.h>
-#include <linux/sched/isolation.h>
-#include <uapi/linux/sched/types.h>
-#include "../time/tick-internal.h"
-
-#ifdef CONFIG_RCU_BOOST
 #include "../locking/rtmutex_common.h"
-#else /* #ifdef CONFIG_RCU_BOOST */
-
-/*
- * Some architectures do not define rt_mutexes, but if !CONFIG_RCU_BOOST,
- * all uses are in dead code.  Provide a definition to keep the compiler
- * happy, but add WARN_ON_ONCE() to complain if used in the wrong place.
- * This probably needs to be excluded from -rt builds.
- */
-#define rt_mutex_owner(a) ({ WARN_ON_ONCE(1); NULL; })
-#define rt_mutex_futex_unlock(x) WARN_ON_ONCE(1)
-
-#endif /* #else #ifdef CONFIG_RCU_BOOST */
 
 #ifdef CONFIG_RCU_NOCB_CPU
 static cpumask_var_t rcu_nocb_mask; /* CPUs to have callbacks offloaded. */
@@ -94,6 +72,8 @@ static void __init rcu_bootup_announce_oddness(void)
 		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_init_delay);
 	if (gp_cleanup_delay)
 		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_cleanup_delay);
+	if (!use_softirq)
+		pr_info("\tRCU_SOFTIRQ processing moved to rcuc kthreads.\n");
 	if (IS_ENABLED(CONFIG_RCU_EQS_DEBUG))
 		pr_info("\tRCU debug extended QS entry/exit.\n");
 	rcupdate_announce_bootup_oddness();
@@ -627,7 +607,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	if (preempt_bh_were_disabled || irqs_were_disabled) {
 		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
 		/* Need to defer quiescent state until everything is enabled. */
-		if (irqs_were_disabled) {
+		if (irqs_were_disabled && use_softirq) {
 			/* Enabling irqs does not reschedule, so... */
 			raise_softirq_irqoff(RCU_SOFTIRQ);
 		} else {
@@ -944,18 +924,21 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
+/*
+ * If boosting, set rcuc kthreads to realtime priority.
+ */
+static void rcu_cpu_kthread_setup(unsigned int cpu)
+{
 #ifdef CONFIG_RCU_BOOST
+	struct sched_param sp;
 
-static void rcu_wake_cond(struct task_struct *t, int status)
-{
-	/*
-	 * If the thread is yielding, only wake it when this
-	 * is invoked from idle
-	 */
-	if (status != RCU_KTHREAD_YIELDING || is_idle_task(current))
-		wake_up_process(t);
+	sp.sched_priority = kthread_prio;
+	sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);
+#endif /* #ifdef CONFIG_RCU_BOOST */
 }
 
+#ifdef CONFIG_RCU_BOOST
+
 /*
  * Carry out RCU priority boosting on the task indicated by ->exp_tasks
  * or ->boost_tasks, advancing the pointer to the next task in the
@@ -1090,23 +1073,6 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	}
 }
 
-/*
- * Wake up the per-CPU kthread to invoke RCU callbacks.
- */
-static void invoke_rcu_callbacks_kthread(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__this_cpu_write(rcu_data.rcu_cpu_has_work, 1);
-	if (__this_cpu_read(rcu_data.rcu_cpu_kthread_task) != NULL &&
-	    current != __this_cpu_read(rcu_data.rcu_cpu_kthread_task)) {
-		rcu_wake_cond(__this_cpu_read(rcu_data.rcu_cpu_kthread_task),
-			      __this_cpu_read(rcu_data.rcu_cpu_kthread_status));
-	}
-	local_irq_restore(flags);
-}
-
 /*
  * Is the current CPU running the RCU-callbacks kthread?
  * Caller must have preemption disabled.
@@ -1160,59 +1126,6 @@ static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	return 0;
 }
 
-static void rcu_cpu_kthread_setup(unsigned int cpu)
-{
-	struct sched_param sp;
-
-	sp.sched_priority = kthread_prio;
-	sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);
-}
-
-static void rcu_cpu_kthread_park(unsigned int cpu)
-{
-	per_cpu(rcu_data.rcu_cpu_kthread_status, cpu) = RCU_KTHREAD_OFFCPU;
-}
-
-static int rcu_cpu_kthread_should_run(unsigned int cpu)
-{
-	return __this_cpu_read(rcu_data.rcu_cpu_has_work);
-}
-
-/*
- * Per-CPU kernel thread that invokes RCU callbacks.  This replaces
- * the RCU softirq used in configurations of RCU that do not support RCU
- * priority boosting.
- */
-static void rcu_cpu_kthread(unsigned int cpu)
-{
-	unsigned int *statusp = this_cpu_ptr(&rcu_data.rcu_cpu_kthread_status);
-	char work, *workp = this_cpu_ptr(&rcu_data.rcu_cpu_has_work);
-	int spincnt;
-
-	for (spincnt = 0; spincnt < 10; spincnt++) {
-		trace_rcu_utilization(TPS("Start CPU kthread@rcu_wait"));
-		local_bh_disable();
-		*statusp = RCU_KTHREAD_RUNNING;
-		local_irq_disable();
-		work = *workp;
-		*workp = 0;
-		local_irq_enable();
-		if (work)
-			rcu_do_batch(this_cpu_ptr(&rcu_data));
-		local_bh_enable();
-		if (*workp == 0) {
-			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
-			*statusp = RCU_KTHREAD_WAITING;
-			return;
-		}
-	}
-	*statusp = RCU_KTHREAD_YIELDING;
-	trace_rcu_utilization(TPS("Start CPU kthread@rcu_yield"));
-	schedule_timeout_interruptible(2);
-	trace_rcu_utilization(TPS("End CPU kthread@rcu_yield"));
-	*statusp = RCU_KTHREAD_WAITING;
-}
-
 /*
  * Set the per-rcu_node kthread's affinity to cover all CPUs that are
  * served by the rcu_node in question.  The CPU hotplug lock is still
@@ -1243,27 +1156,13 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 	free_cpumask_var(cm);
 }
 
-static struct smp_hotplug_thread rcu_cpu_thread_spec = {
-	.store			= &rcu_data.rcu_cpu_kthread_task,
-	.thread_should_run	= rcu_cpu_kthread_should_run,
-	.thread_fn		= rcu_cpu_kthread,
-	.thread_comm		= "rcuc/%u",
-	.setup			= rcu_cpu_kthread_setup,
-	.park			= rcu_cpu_kthread_park,
-};
-
 /*
  * Spawn boost kthreads -- called as soon as the scheduler is running.
  */
 static void __init rcu_spawn_boost_kthreads(void)
 {
 	struct rcu_node *rnp;
-	int cpu;
 
-	for_each_possible_cpu(cpu)
-		per_cpu(rcu_data.rcu_cpu_has_work, cpu) = 0;
-	if (WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec), "%s: Could not start rcub kthread, OOM is now expected behavior\n", __func__))
-		return;
 	rcu_for_each_leaf_node(rnp)
 		(void)rcu_spawn_one_boost_kthread(rnp);
 }
@@ -1286,11 +1185,6 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
-static void invoke_rcu_callbacks_kthread(void)
-{
-	WARN_ON_ONCE(1);
-}
-
 static bool rcu_is_callbacks_kthread(void)
 {
 	return false;
-- 
2.17.1

