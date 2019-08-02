Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD817FD4B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 17:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392845AbfHBPQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 11:16:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389133AbfHBPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:15:41 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72F7cOw004338;
        Fri, 2 Aug 2019 11:15:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u4nqd5f9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 11:15:02 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x72F8tXC009329;
        Fri, 2 Aug 2019 11:15:02 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u4nqd5f96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 11:15:02 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x72FB4jh027233;
        Fri, 2 Aug 2019 15:15:01 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma05wdc.us.ibm.com with ESMTP id 2u0e85wtug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 15:15:01 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x72FF0Nc54198706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Aug 2019 15:15:00 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5413B205F;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66FECB2064;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Aug 2019 15:15:00 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E532016C9A37; Fri,  2 Aug 2019 08:15:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC tip/core/rcu 02/14] rcu/nocb: Add bypass callback queueing
Date:   Fri,  2 Aug 2019 08:14:49 -0700
Message-Id: <20190802151501.13069-2-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190802151435.GA1081@linux.ibm.com>
References: <20190802151435.GA1081@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of the rcu_data structure's segmented ->cblist for no-CBs CPUs
takes advantage of unrelated grace periods, thus reducing the memory
footprint in the face of floods of call_rcu() invocations.  However,
the ->cblist field is a more-complex rcu_segcblist structure which must
be protected via locking.  Even though there are only three entities
which can acquire this lock (the CPU invoking call_rcu(), the no-CBs
grace-period kthread, and the no-CBs callbacks kthread), the contention
on this lock is excessive under heavy stress.

This commit therefore greatly reduces contention by provisioning
an rcu_cblist structure field named ->nocb_bypass within the
rcu_data structure.  Each no-CBs CPU is permitted only a limited
number of enqueues onto the ->cblist per jiffy, controlled by a new
nocb_nobypass_lim_per_jiffy kernel boot parameter that defaults to
about 16 enqueues per millisecond (16 * 1000 / HZ).  When that limit is
exceeded, the CPU instead enqueues onto the new ->nocb_bypass.

The ->nocb_bypass is flushed into the ->cblist every jiffy or when
the number of callbacks on ->nocb_bypass exceeds qhimark, whichever
happens first.  During call_rcu() floods, this flushing is carried out
by the CPU during the course of its call_rcu() invocations.  However,
a CPU could simply stop invoking call_rcu() at any time.  The no-CBs
grace-period kthread therefore carries out less-aggressive flushing
(every few jiffies or when the number of callbacks on ->nocb_bypass
exceeds (2 * qhimark), whichever comes first).  This means that the
no-CBs grace-period kthread cannot be permitted to do unbounded waits
while there are callbacks on ->nocb_bypass.  A ->nocb_bypass_timer is
used to provide the needed wakeups.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/rcu_segcblist.c |  30 ++++
 kernel/rcu/rcu_segcblist.h |   5 +
 kernel/rcu/tree.c          |  16 +-
 kernel/rcu/tree.h          |  28 +--
 kernel/rcu/tree_plugin.h   | 356 ++++++++++++++++++++++++++++++++++---
 5 files changed, 394 insertions(+), 41 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index ff431cc83037..495c58ce1640 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -36,6 +36,36 @@ void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp)
 	WRITE_ONCE(rclp->len, rclp->len + 1);
 }
 
+/*
+ * Flush the second rcu_cblist structure onto the first one, obliterating
+ * any contents of the first.  If rhp is non-NULL, enqueue it as the sole
+ * element of the second rcu_cblist structure, but ensuring that the second
+ * rcu_cblist structure, if initially non-empty, always appears non-empty
+ * throughout the process.  If rdp is NULL, the second rcu_cblist structure
+ * is instead initialized to empty.
+ */
+void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
+			      struct rcu_cblist *srclp,
+			      struct rcu_head *rhp)
+{
+	drclp->head = srclp->head;
+	if (drclp->head)
+		drclp->tail = srclp->tail;
+	else
+		drclp->tail = &drclp->head;
+	drclp->len = srclp->len;
+	drclp->len_lazy = srclp->len_lazy;
+	if (!rhp) {
+		rcu_cblist_init(srclp);
+	} else {
+		rhp->next = NULL;
+		srclp->head = rhp;
+		srclp->tail = &rhp->next;
+		WRITE_ONCE(srclp->len, 1);
+		srclp->len_lazy = 0;
+	}
+}
+
 /*
  * Dequeue the oldest rcu_head structure from the specified callback
  * list.  This function assumes that the callback is non-lazy, but
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 1ff996647d3c..815c2fdd3fcc 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -25,6 +25,10 @@ static inline void rcu_cblist_dequeued_lazy(struct rcu_cblist *rclp)
 }
 
 void rcu_cblist_init(struct rcu_cblist *rclp);
+void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp);
+void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
+			      struct rcu_cblist *srclp,
+			      struct rcu_head *rhp);
 struct rcu_head *rcu_cblist_dequeue(struct rcu_cblist *rclp);
 
 /*
@@ -92,6 +96,7 @@ static inline bool rcu_segcblist_restempty(struct rcu_segcblist *rsclp, int seg)
 	return !READ_ONCE(*READ_ONCE(rsclp->tails[seg]));
 }
 
+void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
 void rcu_segcblist_init(struct rcu_segcblist *rsclp);
 void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ec320658aeef..457623100d12 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1251,6 +1251,7 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	unsigned long gp_seq_req;
 	bool ret = false;
 
+	rcu_lockdep_assert_cblist_protected(rdp);
 	raw_lockdep_assert_held_rcu_node(rnp);
 
 	/* If no pending (not yet ready to invoke) callbacks, nothing to do. */
@@ -1292,7 +1293,7 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
 	unsigned long c;
 	bool needwake;
 
-	lockdep_assert_irqs_disabled();
+	rcu_lockdep_assert_cblist_protected(rdp);
 	c = rcu_seq_snap(&rcu_state.gp_seq);
 	if (!rdp->gpwrap && ULONG_CMP_GE(rdp->gp_seq_needed, c)) {
 		/* Old request still live, so mark recent callbacks. */
@@ -1318,6 +1319,7 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
  */
 static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 {
+	rcu_lockdep_assert_cblist_protected(rdp);
 	raw_lockdep_assert_held_rcu_node(rnp);
 
 	/* If no pending (not yet ready to invoke) callbacks, nothing to do. */
@@ -1341,6 +1343,7 @@ static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 static void __maybe_unused rcu_advance_cbs_nowake(struct rcu_node *rnp,
 						  struct rcu_data *rdp)
 {
+	rcu_lockdep_assert_cblist_protected(rdp);
 	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) ||
 	    !raw_spin_trylock_rcu_node(rnp))
 		return;
@@ -2187,7 +2190,9 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	 * The following usually indicates a double call_rcu().  To track
 	 * this down, try building with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y.
 	 */
-	WARN_ON_ONCE(rcu_segcblist_empty(&rdp->cblist) != (count == 0));
+	WARN_ON_ONCE(count == 0 && !rcu_segcblist_empty(&rdp->cblist));
+	WARN_ON_ONCE(!IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
+		     count != 0 && rcu_segcblist_empty(&rdp->cblist));
 
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
@@ -2564,8 +2569,9 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func, bool lazy)
 		if (rcu_segcblist_empty(&rdp->cblist))
 			rcu_segcblist_init(&rdp->cblist);
 	}
-	rcu_nocb_lock(rdp);
-	was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
+		return; // Enqueued onto ->nocb_bypass, so just leave.
+	/* If we get here, rcu_nocb_try_bypass() acquired ->nocb_lock. */
 	rcu_segcblist_enqueue(&rdp->cblist, head, lazy);
 	if (__is_kfree_rcu_offset((unsigned long)func))
 		trace_rcu_kfree_callback(rcu_state.name, head,
@@ -2839,6 +2845,7 @@ static void rcu_barrier_func(void *unused)
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
 	rcu_nocb_lock(rdp);
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head, 0)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
 	} else {
@@ -3192,6 +3199,7 @@ void rcutree_migrate_callbacks(int cpu)
 	my_rdp = this_cpu_ptr(&rcu_data);
 	my_rnp = my_rdp->mynode;
 	rcu_nocb_lock(my_rdp); /* irqs already disabled. */
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies));
 	raw_spin_lock_rcu_node(my_rnp); /* irqs already disabled. */
 	/* Leverage recent GPs and set GP for new callbacks. */
 	needwake = rcu_advance_cbs(my_rnp, rdp) ||
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 2c3e9068671c..e4df86db8137 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -200,18 +200,26 @@ struct rcu_data {
 	atomic_t nocb_lock_contended;	/* Contention experienced. */
 	int nocb_defer_wakeup;		/* Defer wakeup of nocb_kthread. */
 	struct timer_list nocb_timer;	/* Enforce finite deferral. */
+	unsigned long nocb_gp_adv_time;	/* Last call_rcu() CB adv (jiffies). */
+
+	/* The following fields are used by call_rcu, hence own cacheline. */
+	raw_spinlock_t nocb_bypass_lock ____cacheline_internodealigned_in_smp;
+	struct rcu_cblist nocb_bypass;	/* Lock-contention-bypass CB list. */
+	unsigned long nocb_bypass_first; /* Time (jiffies) of first enqueue. */
+	unsigned long nocb_nobypass_last; /* Last ->cblist enqueue (jiffies). */
+	int nocb_nobypass_count;	/* # ->cblist enqueues at ^^^ time. */
 
 	/* The following fields are used by GP kthread, hence own cacheline. */
 	raw_spinlock_t nocb_gp_lock ____cacheline_internodealigned_in_smp;
-	bool nocb_gp_sleep;
-					/* Is the nocb GP thread asleep? */
+	struct timer_list nocb_bypass_timer; /* Force nocb_bypass flush. */
+	bool nocb_gp_sleep;		/* Is the nocb GP thread asleep? */
 	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
 	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
 	struct task_struct *nocb_cb_kthread;
 	struct rcu_data *nocb_next_cb_rdp;
 					/* Next rcu_data in wakeup chain. */
 
-	/* The following fields are used by CB kthread, hence new cachline. */
+	/* The following fields are used by CB kthread, hence new cacheline. */
 	struct rcu_data *nocb_gp_rdp ____cacheline_internodealigned_in_smp;
 					/* GP rdp takes GP-end wakeups. */
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
@@ -419,6 +427,10 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
+static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
+				  unsigned long j);
+static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
+				bool *was_alldone, unsigned long flags);
 static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
 				 unsigned long flags);
 static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp);
@@ -430,19 +442,15 @@ static void rcu_nocb_lock(struct rcu_data *rdp);
 static void rcu_nocb_unlock(struct rcu_data *rdp);
 static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 				       unsigned long flags);
+static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp);
 #ifdef CONFIG_RCU_NOCB_CPU
 static void __init rcu_organize_nocb_kthreads(void);
 #define rcu_nocb_lock_irqsave(rdp, flags)				\
 do {									\
-	if (!rcu_segcblist_is_offloaded(&(rdp)->cblist)) {		\
+	if (!rcu_segcblist_is_offloaded(&(rdp)->cblist))		\
 		local_irq_save(flags);					\
-	} else if (!raw_spin_trylock_irqsave(&(rdp)->nocb_lock, (flags))) {\
-		atomic_inc(&(rdp)->nocb_lock_contended);		\
-		smp_mb__after_atomic(); /* atomic_inc() before lock. */	\
+	else								\
 		raw_spin_lock_irqsave(&(rdp)->nocb_lock, (flags));	\
-		smp_mb__before_atomic(); /* atomic_dec() after lock. */	\
-		atomic_dec(&(rdp)->nocb_lock_contended);		\
-	}								\
 } while (0)
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 #define rcu_nocb_lock_irqsave(rdp, flags) local_irq_save(flags)
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index e164d2c5fa93..bb906295538d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1495,19 +1495,26 @@ static int __init parse_rcu_nocb_poll(char *arg)
 early_param("rcu_nocb_poll", parse_rcu_nocb_poll);
 
 /*
- * Acquire the specified rcu_data structure's ->nocb_lock, but only
- * if it corresponds to a no-CBs CPU.  If the lock isn't immediately
- * available, increment ->nocb_lock_contended to flag the contention.
+ * Don't bother bypassing ->cblist if the call_rcu() rate is low.
+ * After all, the main point of bypassing is to avoid lock contention
+ * on ->nocb_lock, which only can happen at high call_rcu() rates.
  */
-static void rcu_nocb_lock(struct rcu_data *rdp)
+int nocb_nobypass_lim_per_jiffy = 16 * 1000 / HZ;
+module_param(nocb_nobypass_lim_per_jiffy, int, 0);
+
+/*
+ * Acquire the specified rcu_data structure's ->nocb_bypass_lock.  If the
+ * lock isn't immediately available, increment ->nocb_lock_contended to
+ * flag the contention.
+ */
+static void rcu_nocb_bypass_lock(struct rcu_data *rdp)
 {
 	lockdep_assert_irqs_disabled();
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist) ||
-	    raw_spin_trylock(&rdp->nocb_lock))
+	if (raw_spin_trylock(&rdp->nocb_bypass_lock))
 		return;
 	atomic_inc(&rdp->nocb_lock_contended);
 	smp_mb__after_atomic(); /* atomic_inc() before lock. */
-	raw_spin_lock(&rdp->nocb_lock);
+	raw_spin_lock(&rdp->nocb_bypass_lock);
 	smp_mb__before_atomic(); /* atomic_dec() after lock. */
 	atomic_dec(&rdp->nocb_lock_contended);
 }
@@ -1528,6 +1535,37 @@ static void rcu_nocb_wait_contended(struct rcu_data *rdp)
 		cpu_relax();
 }
 
+/*
+ * Conditionally acquire the specified rcu_data structure's
+ * ->nocb_bypass_lock.
+ */
+static bool rcu_nocb_bypass_trylock(struct rcu_data *rdp)
+{
+	lockdep_assert_irqs_disabled();
+	return raw_spin_trylock(&rdp->nocb_bypass_lock);
+}
+
+/*
+ * Release the specified rcu_data structure's ->nocb_bypass_lock.
+ */
+static void rcu_nocb_bypass_unlock(struct rcu_data *rdp)
+{
+	lockdep_assert_irqs_disabled();
+	raw_spin_unlock(&rdp->nocb_bypass_lock);
+}
+
+/*
+ * Acquire the specified rcu_data structure's ->nocb_lock, but only
+ * if it corresponds to a no-CBs CPU.
+ */
+static void rcu_nocb_lock(struct rcu_data *rdp)
+{
+	lockdep_assert_irqs_disabled();
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist))
+		return;
+	raw_spin_lock(&rdp->nocb_lock);
+}
+
 /*
  * Release the specified rcu_data structure's ->nocb_lock, but only
  * if it corresponds to a no-CBs CPU.
@@ -1555,6 +1593,15 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 	}
 }
 
+/* Lockdep check that ->cblist may be safely accessed. */
+static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
+{
+	lockdep_assert_irqs_disabled();
+	if (rcu_segcblist_is_offloaded(&rdp->cblist) &&
+	    cpu_online(rdp->cpu))
+		lockdep_assert_held(&rdp->nocb_lock);
+}
+
 /*
  * Wake up any no-CBs CPUs' kthreads that were waiting on the just-ended
  * grace period.
@@ -1591,24 +1638,27 @@ static void wake_nocb_gp(struct rcu_data *rdp, bool force,
 			   unsigned long flags)
 	__releases(rdp->nocb_lock)
 {
+	bool needwake = false;
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	lockdep_assert_held(&rdp->nocb_lock);
 	if (!READ_ONCE(rdp_gp->nocb_gp_kthread)) {
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
+				    TPS("AlreadyAwake"));
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		return;
 	}
-	if (READ_ONCE(rdp_gp->nocb_gp_sleep) || force) {
-		del_timer(&rdp->nocb_timer);
-		rcu_nocb_unlock_irqrestore(rdp, flags);
-		smp_mb(); /* enqueue before ->nocb_gp_sleep. */
-		raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
+	del_timer(&rdp->nocb_timer);
+	rcu_nocb_unlock_irqrestore(rdp, flags);
+	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
+	if (force || READ_ONCE(rdp_gp->nocb_gp_sleep)) {
 		WRITE_ONCE(rdp_gp->nocb_gp_sleep, false);
-		raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
-		wake_up_process(rdp_gp->nocb_gp_kthread);
-	} else {
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		needwake = true;
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DoWake"));
 	}
+	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
+	if (needwake)
+		wake_up_process(rdp_gp->nocb_gp_kthread);
 }
 
 /*
@@ -1625,6 +1675,188 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, reason);
 }
 
+/*
+ * Flush the ->nocb_bypass queue into ->cblist, enqueuing rhp if non-NULL.
+ * However, if there is a callback to be enqueued and if ->nocb_bypass
+ * proves to be initially empty, just return false because the no-CB GP
+ * kthread may need to be awakened in this case.
+ *
+ * Note that this function always returns true if rhp is NULL.
+ */
+static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
+				     unsigned long j)
+{
+	struct rcu_cblist rcl;
+
+	WARN_ON_ONCE(!rcu_segcblist_is_offloaded(&rdp->cblist));
+	rcu_lockdep_assert_cblist_protected(rdp);
+	lockdep_assert_held(&rdp->nocb_bypass_lock);
+	if (rhp && !rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
+		raw_spin_unlock(&rdp->nocb_bypass_lock);
+		return false;
+	}
+	/* Note: ->cblist.len already accounts for ->nocb_bypass contents. */
+	if (rhp)
+		rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
+	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
+	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
+	WRITE_ONCE(rdp->nocb_bypass_first, j);
+	rcu_nocb_bypass_unlock(rdp);
+	return true;
+}
+
+/*
+ * Flush the ->nocb_bypass queue into ->cblist, enqueuing rhp if non-NULL.
+ * However, if there is a callback to be enqueued and if ->nocb_bypass
+ * proves to be initially empty, just return false because the no-CB GP
+ * kthread may need to be awakened in this case.
+ *
+ * Note that this function always returns true if rhp is NULL.
+ */
+static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
+				  unsigned long j)
+{
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist))
+		return true;
+	rcu_lockdep_assert_cblist_protected(rdp);
+	rcu_nocb_bypass_lock(rdp);
+	return rcu_nocb_do_flush_bypass(rdp, rhp, j);
+}
+
+/*
+ * If the ->nocb_bypass_lock is immediately available, flush the
+ * ->nocb_bypass queue into ->cblist.
+ */
+static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
+{
+	rcu_lockdep_assert_cblist_protected(rdp);
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist) ||
+	    !rcu_nocb_bypass_trylock(rdp))
+		return;
+	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j));
+}
+
+/*
+ * See whether it is appropriate to use the ->nocb_bypass list in order
+ * to control contention on ->nocb_lock.  A limited number of direct
+ * enqueues are permitted into ->cblist per jiffy.  If ->nocb_bypass
+ * is non-empty, further callbacks must be placed into ->nocb_bypass,
+ * otherwise rcu_barrier() breaks.  Use rcu_nocb_flush_bypass() to switch
+ * back to direct use of ->cblist.  However, ->nocb_bypass should not be
+ * used if ->cblist is empty, because otherwise callbacks can be stranded
+ * on ->nocb_bypass because we cannot count on the current CPU ever again
+ * invoking call_rcu().  The general rule is that if ->nocb_bypass is
+ * non-empty, the corresponding no-CBs grace-period kthread must not be
+ * in an indefinite sleep state.
+ *
+ * Finally, it is not permitted to use the bypass during early boot,
+ * as doing so would confuse the auto-initialization code.  Besides
+ * which, there is no point in worrying about lock contention while
+ * there is only one CPU in operation.
+ */
+static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
+				bool *was_alldone, unsigned long flags)
+{
+	unsigned long c;
+	unsigned long cur_gp_seq;
+	unsigned long j = jiffies;
+	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
+
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist)) {
+		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+		return false; /* Not offloaded, no bypassing. */
+	}
+	lockdep_assert_irqs_disabled();
+
+	// Don't use ->nocb_bypass during early boot.
+	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING) {
+		rcu_nocb_lock(rdp);
+		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
+		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+		return false;
+	}
+
+	// If we have advanced to a new jiffy, reset counts to allow
+	// moving back from ->nocb_bypass to ->cblist.
+	if (j == rdp->nocb_nobypass_last) {
+		c = rdp->nocb_nobypass_count + 1;
+	} else {
+		WRITE_ONCE(rdp->nocb_nobypass_last, j);
+		c = rdp->nocb_nobypass_count - nocb_nobypass_lim_per_jiffy;
+		if (c > nocb_nobypass_lim_per_jiffy)
+			c = nocb_nobypass_lim_per_jiffy;
+		else if (c < 0)
+			c = 0;
+	}
+	WRITE_ONCE(rdp->nocb_nobypass_count, c);
+
+	// If there hasn't yet been all that many ->cblist enqueues
+	// this jiffy, tell the caller to enqueue onto ->cblist.  But flush
+	// ->nocb_bypass first.
+	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy) {
+		rcu_nocb_lock(rdp);
+		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+		if (*was_alldone)
+			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
+					    TPS("FirstQ"));
+		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
+		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
+		return false; // Caller must enqueue the callback.
+	}
+
+	// If ->nocb_bypass has been used too long or is too full,
+	// flush ->nocb_bypass to ->cblist.
+	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) ||
+	    ncbs >= qhimark) {
+		rcu_nocb_lock(rdp);
+		if (!rcu_nocb_flush_bypass(rdp, rhp, j)) {
+			*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+			if (*was_alldone)
+				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
+						    TPS("FirstQ"));
+			WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
+			return false; // Caller must enqueue the callback.
+		}
+		if (j != rdp->nocb_gp_adv_time &&
+		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
+		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq)) {
+			rcu_advance_cbs_nowake(rdp->mynode, rdp);
+			rdp->nocb_gp_adv_time = j;
+		}
+		rcu_nocb_unlock_irqrestore(rdp, flags);
+		return true; // Callback already enqueued.
+	}
+
+	// We need to use the bypass.
+	rcu_nocb_wait_contended(rdp);
+	rcu_nocb_bypass_lock(rdp);
+	ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
+	rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
+	rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
+	if (!ncbs) {
+		WRITE_ONCE(rdp->nocb_bypass_first, j);
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FirstBQ"));
+	}
+	rcu_nocb_bypass_unlock(rdp);
+	smp_mb(); /* Order enqueue before wake. */
+	if (ncbs) {
+		local_irq_restore(flags);
+	} else {
+		// No-CBs GP kthread might be indefinitely asleep, if so, wake.
+		rcu_nocb_lock(rdp); // Rare during call_rcu() flood.
+		if (!rcu_segcblist_pend_cbs(&rdp->cblist)) {
+			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
+					    TPS("FirstBQwake"));
+			__call_rcu_nocb_wake(rdp, true, flags);
+		} else {
+			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
+					    TPS("FirstBQnoWake"));
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+		}
+	}
+	return true; // Callback already enqueued.
+}
+
 /*
  * Awaken the no-CBs grace-period kthead if needed, either due to it
  * legitimately being asleep or due to overload conditions.
@@ -1683,23 +1915,33 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 	}
-	if (!irqs_disabled_flags(flags)) {
-		lockdep_assert_irqs_enabled();
-		rcu_nocb_wait_contended(rdp);
-	}
 	return;
 }
 
+/* Wake up the no-CBs GP kthread to flush ->nocb_bypass. */
+static void do_nocb_bypass_wakeup_timer(struct timer_list *t)
+{
+	unsigned long flags;
+	struct rcu_data *rdp = from_timer(rdp, t, nocb_bypass_timer);
+
+	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Timer"));
+	rcu_nocb_lock_irqsave(rdp, flags);
+	__call_rcu_nocb_wake(rdp, true, flags);
+}
+
 /*
  * No-CBs GP kthreads come here to wait for additional callbacks to show up
  * or for grace periods to end.
  */
 static void nocb_gp_wait(struct rcu_data *my_rdp)
 {
+	bool bypass = false;
+	long bypass_ncbs;
 	int __maybe_unused cpu = my_rdp->cpu;
 	unsigned long cur_gp_seq;
 	unsigned long flags;
 	bool gotcbs;
+	unsigned long j = jiffies;
 	bool needwait_gp = false; // This prevents actual uninitialized use.
 	bool needwake;
 	bool needwake_gp;
@@ -1713,21 +1955,50 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	 * and the global grace-period kthread are awakened if needed.
 	 */
 	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
-		if (rcu_segcblist_empty(&rdp->cblist))
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
+		rcu_nocb_lock_irqsave(rdp, flags);
+		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
+		if (bypass_ncbs &&
+		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
+		     bypass_ncbs > 2 * qhimark)) {
+			// Bypass full or old, so flush it.
+			(void)rcu_nocb_try_flush_bypass(rdp, j);
+			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
+		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
+			rcu_nocb_unlock_irqrestore(rdp, flags);
 			continue; /* No callbacks here, try next. */
+		}
+		if (bypass_ncbs) {
+			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
+					    TPS("Bypass"));
+			bypass = true;
+		}
 		rnp = rdp->mynode;
-		rcu_nocb_lock_irqsave(rdp, flags);
-		WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
-		del_timer(&my_rdp->nocb_timer);
-		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
-		needwake_gp = rcu_advance_cbs(rnp, rdp);
-		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
+		if (bypass) {  // Avoid race with first bypass CB.
+			WRITE_ONCE(my_rdp->nocb_defer_wakeup,
+				   RCU_NOCB_WAKE_NOT);
+			del_timer(&my_rdp->nocb_timer);
+		}
+		// Advance callbacks if helpful and low contention.
+		needwake_gp = false;
+		if (!rcu_segcblist_restempty(&rdp->cblist,
+					     RCU_NEXT_READY_TAIL) ||
+		    (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
+		     rcu_seq_done(&rnp->gp_seq, cur_gp_seq))) {
+			raw_spin_lock_rcu_node(rnp); /* irqs disabled. */
+			needwake_gp = rcu_advance_cbs(rnp, rdp);
+			raw_spin_unlock_rcu_node(rnp); /* irqs disabled. */
+		}
 		// Need to wait on some grace period?
+		WARN_ON_ONCE(!rcu_segcblist_restempty(&rdp->cblist,
+						      RCU_NEXT_READY_TAIL));
 		if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq)) {
 			if (!needwait_gp ||
 			    ULONG_CMP_LT(cur_gp_seq, wait_gp_seq))
 				wait_gp_seq = cur_gp_seq;
 			needwait_gp = true;
+			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
+					    TPS("NeedWaitGP"));
 		}
 		if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
 			needwake = rdp->nocb_cb_sleep;
@@ -1745,6 +2016,13 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 			rcu_gp_kthread_wake();
 	}
 
+	if (bypass && !rcu_nocb_poll) {
+		// At least one child with non-empty ->nocb_bypass, so set
+		// timer in order to avoid stranding its callbacks.
+		raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
+		mod_timer(&my_rdp->nocb_bypass_timer, j + 2);
+		raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
+	}
 	if (rcu_nocb_poll) {
 		/* Polling, so trace if first poll in the series. */
 		if (gotcbs)
@@ -1755,6 +2033,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
 		swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
 				!READ_ONCE(my_rdp->nocb_gp_sleep));
+		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EndSleep"));
 	} else {
 		rnp = my_rdp->mynode;
 		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("StartWait"));
@@ -1766,6 +2045,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	}
 	if (!rcu_nocb_poll) {
 		raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
+		if (bypass)
+			del_timer(&my_rdp->nocb_bypass_timer);
 		WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
 		raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
 	}
@@ -1947,8 +2228,11 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 	init_swait_queue_head(&rdp->nocb_cb_wq);
 	init_swait_queue_head(&rdp->nocb_gp_wq);
 	raw_spin_lock_init(&rdp->nocb_lock);
+	raw_spin_lock_init(&rdp->nocb_bypass_lock);
 	raw_spin_lock_init(&rdp->nocb_gp_lock);
 	timer_setup(&rdp->nocb_timer, do_nocb_deferred_wakeup_timer, 0);
+	timer_setup(&rdp->nocb_bypass_timer, do_nocb_bypass_wakeup_timer, 0);
+	rcu_cblist_init(&rdp->nocb_bypass);
 }
 
 /*
@@ -2092,6 +2376,12 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 	local_irq_restore(flags);
 }
 
+/* Lockdep check that ->cblist may be safely accessed. */
+static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
+{
+	lockdep_assert_irqs_disabled();
+}
+
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq)
 {
 }
@@ -2105,6 +2395,18 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 }
 
+static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
+				  unsigned long j)
+{
+	return true;
+}
+
+static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
+				bool *was_alldone, unsigned long flags)
+{
+	return false;
+}
+
 static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
 				 unsigned long flags)
 {
-- 
2.17.1

