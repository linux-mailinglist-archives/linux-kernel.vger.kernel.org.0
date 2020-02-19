Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E2C164622
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 14:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgBSN4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 08:56:22 -0500
Received: from outbound-smtp52.blacknight.com ([46.22.136.236]:47013 "EHLO
        outbound-smtp52.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727402AbgBSN4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 08:56:21 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp52.blacknight.com (Postfix) with ESMTPS id D9A3DFB0FE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 13:56:17 +0000 (GMT)
Received: (qmail 12065 invoked from network); 19 Feb 2020 13:56:17 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 19 Feb 2020 13:56:17 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 08/13] sched/pelt: Add a new runnable average signal
Date:   Wed, 19 Feb 2020 13:54:37 +0000
Message-Id: <20200219135442.18107-9-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200219135442.18107-1-mgorman@techsingularity.net>
References: <20200219135442.18107-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>

Now that runnable_load_avg has been removed, we can replace it by a new
signal that will highlight the runnable pressure on a cfs_rq. This signal
track the waiting time of tasks on rq and can help to better define the
state of rqs.

At now, only util_avg is used to define the state of a rq:
  A rq with more that around 80% of utilization and more than 1 tasks is
  considered as overloaded.

But the util_avg signal of a rq can become temporaly low after that a task
migrated onto another rq which can bias the classification of the rq.

When tasks compete for the same rq, their runnable average signal will be
higher than util_avg as it will include the waiting time and we can use
this signal to better classify cfs_rqs.

The new runnable_avg will track the runnable time of a task which simply
adds the waiting time to the running time. The runnable _avg of cfs_rq
will be the /Sum of se's runnable_avg and the runnable_avg of group entity
will follow the one of the rq similarly to util_avg.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/sched.h | 28 +++++++++++-------
 kernel/sched/debug.c  |  9 ++++--
 kernel/sched/fair.c   | 79 +++++++++++++++++++++++++++++++++++++++++++++------
 kernel/sched/pelt.c   | 51 ++++++++++++++++++++++-----------
 kernel/sched/sched.h  | 22 +++++++++++++-
 5 files changed, 151 insertions(+), 38 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 037eaffabc24..67fa2c824b7e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -356,28 +356,30 @@ struct util_est {
 } __attribute__((__aligned__(sizeof(u64))));
 
 /*
- * The load_avg/util_avg accumulates an infinite geometric series
+ * The load/runnable/util_avg accumulates an infinite geometric series
  * (see __update_load_avg_cfs_rq() in kernel/sched/pelt.c).
  *
  * [load_avg definition]
  *
  *   load_avg = runnable% * scale_load_down(load)
  *
- * where runnable% is the time ratio that a sched_entity is runnable.
- * For cfs_rq, it is the aggregated load_avg of all runnable and
- * blocked sched_entities.
+ * [runnable_avg definition]
  *
- * [util_avg definition]
+ *   runnable_avg = runnable% * SCHED_CAPACITY_SCALE
+ *
+* [util_avg definition]
  *
  *   util_avg = running% * SCHED_CAPACITY_SCALE
  *
- * where running% is the time ratio that a sched_entity is running on
- * a CPU. For cfs_rq, it is the aggregated util_avg of all runnable
- * and blocked sched_entities.
+ * where runnable% is the time ratio that a sched_entity is runnable and
+ * running% the time ratio that a sched_entity is running.
+ *
+ * For cfs_rq, they are the aggregated values of all runnable and blocked
+ * sched_entities.
  *
- * load_avg and util_avg don't direcly factor frequency scaling and CPU
- * capacity scaling. The scaling is done through the rq_clock_pelt that
- * is used for computing those signals (see update_rq_clock_pelt())
+ * The load/runnable/util_avg doesn't direcly factor frequency scaling and CPU
+ * capacity scaling. The scaling is done through the rq_clock_pelt that is used
+ * for computing those signals (see update_rq_clock_pelt())
  *
  * N.B., the above ratios (runnable% and running%) themselves are in the
  * range of [0, 1]. To do fixed point arithmetics, we therefore scale them
@@ -401,9 +403,11 @@ struct util_est {
 struct sched_avg {
 	u64				last_update_time;
 	u64				load_sum;
+	u64				runnable_sum;
 	u32				util_sum;
 	u32				period_contrib;
 	unsigned long			load_avg;
+	unsigned long			runnable_avg;
 	unsigned long			util_avg;
 	struct util_est			util_est;
 } ____cacheline_aligned;
@@ -467,6 +471,8 @@ struct sched_entity {
 	struct cfs_rq			*cfs_rq;
 	/* rq "owned" by this entity/group: */
 	struct cfs_rq			*my_q;
+	/* cached value of my_q->h_nr_running */
+	unsigned long			runnable_weight;
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index cfecaad387c0..8331bc04aea2 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -405,6 +405,7 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 #ifdef CONFIG_SMP
 	P(se->avg.load_avg);
 	P(se->avg.util_avg);
+	P(se->avg.runnable_avg);
 #endif
 
 #undef PN_SCHEDSTAT
@@ -524,6 +525,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 #ifdef CONFIG_SMP
 	SEQ_printf(m, "  .%-30s: %lu\n", "load_avg",
 			cfs_rq->avg.load_avg);
+	SEQ_printf(m, "  .%-30s: %lu\n", "runnable_avg",
+			cfs_rq->avg.runnable_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
 			cfs_rq->avg.util_avg);
 	SEQ_printf(m, "  .%-30s: %u\n", "util_est_enqueued",
@@ -532,8 +535,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->removed.load_avg);
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed.util_avg",
 			cfs_rq->removed.util_avg);
-	SEQ_printf(m, "  .%-30s: %ld\n", "removed.runnable_sum",
-			cfs_rq->removed.runnable_sum);
+	SEQ_printf(m, "  .%-30s: %ld\n", "removed.runnable_avg",
+			cfs_rq->removed.runnable_avg);
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	SEQ_printf(m, "  .%-30s: %lu\n", "tg_load_avg_contrib",
 			cfs_rq->tg_load_avg_contrib);
@@ -944,8 +947,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.load.weight);
 #ifdef CONFIG_SMP
 	P(se.avg.load_sum);
+	P(se.avg.runnable_sum);
 	P(se.avg.util_sum);
 	P(se.avg.load_avg);
+	P(se.avg.runnable_avg);
 	P(se.avg.util_avg);
 	P(se.avg.last_update_time);
 	P(se.avg.util_est.ewma);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 48578442fec9..1feac09f9b22 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -740,8 +740,10 @@ void init_entity_runnable_average(struct sched_entity *se)
 	 * Group entities are initialized with zero load to reflect the fact that
 	 * nothing has been attached to the task group yet.
 	 */
-	if (entity_is_task(se))
+	if (entity_is_task(se)) {
+		sa->runnable_avg = SCHED_CAPACITY_SCALE;
 		sa->load_avg = scale_load_down(se->load.weight);
+	}
 
 	/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
 }
@@ -3210,9 +3212,9 @@ void set_task_rq_fair(struct sched_entity *se,
  * _IFF_ we look at the pure running and runnable sums. Because they
  * represent the very same entity, just at different points in the hierarchy.
  *
- * Per the above update_tg_cfs_util() is trivial  * and simply copies the
- * running sum over (but still wrong, because the group entity and group rq do
- * not have their PELT windows aligned).
+ * Per the above update_tg_cfs_util() and update_tg_cfs_runnable() are trivial
+ * and simply copies the running/runnable sum over (but still wrong, because
+ * the group entity and group rq do not have their PELT windows aligned).
  *
  * However, update_tg_cfs_load() is more complex. So we have:
  *
@@ -3294,6 +3296,32 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * LOAD_AVG_MAX;
 }
 
+static inline void
+update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
+{
+	long delta = gcfs_rq->avg.runnable_avg - se->avg.runnable_avg;
+
+	/* Nothing to update */
+	if (!delta)
+		return;
+
+	/*
+	 * The relation between sum and avg is:
+	 *
+	 *   LOAD_AVG_MAX - 1024 + sa->period_contrib
+	 *
+	 * however, the PELT windows are not aligned between grq and gse.
+	 */
+
+	/* Set new sched_entity's runnable */
+	se->avg.runnable_avg = gcfs_rq->avg.runnable_avg;
+	se->avg.runnable_sum = se->avg.runnable_avg * LOAD_AVG_MAX;
+
+	/* Update parent cfs_rq runnable */
+	add_positive(&cfs_rq->avg.runnable_avg, delta);
+	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * LOAD_AVG_MAX;
+}
+
 static inline void
 update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
@@ -3374,6 +3402,7 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 	add_tg_cfs_propagate(cfs_rq, gcfs_rq->prop_runnable_sum);
 
 	update_tg_cfs_util(cfs_rq, se, gcfs_rq);
+	update_tg_cfs_runnable(cfs_rq, se, gcfs_rq);
 	update_tg_cfs_load(cfs_rq, se, gcfs_rq);
 
 	trace_pelt_cfs_tp(cfs_rq);
@@ -3444,7 +3473,7 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
 static inline int
 update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 {
-	unsigned long removed_load = 0, removed_util = 0, removed_runnable_sum = 0;
+	unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
 	struct sched_avg *sa = &cfs_rq->avg;
 	int decayed = 0;
 
@@ -3455,7 +3484,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		raw_spin_lock(&cfs_rq->removed.lock);
 		swap(cfs_rq->removed.util_avg, removed_util);
 		swap(cfs_rq->removed.load_avg, removed_load);
-		swap(cfs_rq->removed.runnable_sum, removed_runnable_sum);
+		swap(cfs_rq->removed.runnable_avg, removed_runnable);
 		cfs_rq->removed.nr = 0;
 		raw_spin_unlock(&cfs_rq->removed.lock);
 
@@ -3467,7 +3496,16 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		sub_positive(&sa->util_avg, r);
 		sub_positive(&sa->util_sum, r * divider);
 
-		add_tg_cfs_propagate(cfs_rq, -(long)removed_runnable_sum);
+		r = removed_runnable;
+		sub_positive(&sa->runnable_avg, r);
+		sub_positive(&sa->runnable_sum, r * divider);
+
+		/*
+		 * removed_runnable is the unweighted version of removed_load so we
+		 * can use it to estimate removed_load_sum.
+		 */
+		add_tg_cfs_propagate(cfs_rq,
+			-(long)(removed_runnable * divider) >> SCHED_CAPACITY_SHIFT);
 
 		decayed = 1;
 	}
@@ -3513,6 +3551,8 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	 */
 	se->avg.util_sum = se->avg.util_avg * divider;
 
+	se->avg.runnable_sum = se->avg.runnable_avg * divider;
+
 	se->avg.load_sum = divider;
 	if (se_weight(se)) {
 		se->avg.load_sum =
@@ -3522,6 +3562,8 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	enqueue_load_avg(cfs_rq, se);
 	cfs_rq->avg.util_avg += se->avg.util_avg;
 	cfs_rq->avg.util_sum += se->avg.util_sum;
+	cfs_rq->avg.runnable_avg += se->avg.runnable_avg;
+	cfs_rq->avg.runnable_sum += se->avg.runnable_sum;
 
 	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
 
@@ -3543,6 +3585,8 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	dequeue_load_avg(cfs_rq, se);
 	sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
 	sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
+	sub_positive(&cfs_rq->avg.runnable_avg, se->avg.runnable_avg);
+	sub_positive(&cfs_rq->avg.runnable_sum, se->avg.runnable_sum);
 
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
@@ -3649,10 +3693,15 @@ static void remove_entity_load_avg(struct sched_entity *se)
 	++cfs_rq->removed.nr;
 	cfs_rq->removed.util_avg	+= se->avg.util_avg;
 	cfs_rq->removed.load_avg	+= se->avg.load_avg;
-	cfs_rq->removed.runnable_sum	+= se->avg.load_sum; /* == runnable_sum */
+	cfs_rq->removed.runnable_avg	+= se->avg.runnable_avg;
 	raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
 }
 
+static inline unsigned long cfs_rq_runnable_avg(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->avg.runnable_avg;
+}
+
 static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 {
 	return cfs_rq->avg.load_avg;
@@ -3979,11 +4028,13 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/*
 	 * When enqueuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
+	 *   - Add its load to cfs_rq->runnable_avg
 	 *   - For group_entity, update its weight to reflect the new share of
 	 *     its group cfs_rq
 	 *   - Add its new weight to cfs_rq->load.weight
 	 */
 	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
+	se_update_runnable(se);
 	update_cfs_group(se);
 	account_entity_enqueue(cfs_rq, se);
 
@@ -4061,11 +4112,13 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/*
 	 * When dequeuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
+	 *   - Subtract its load from the cfs_rq->runnable_avg.
 	 *   - Subtract its previous weight from cfs_rq->load.weight.
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
 	 */
 	update_load_avg(cfs_rq, se, UPDATE_TG);
+	se_update_runnable(se);
 
 	update_stats_dequeue(cfs_rq, se, flags);
 
@@ -5236,6 +5289,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			goto enqueue_throttle;
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
+		se_update_runnable(se);
 		update_cfs_group(se);
 
 		cfs_rq->h_nr_running++;
@@ -5333,6 +5387,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			goto dequeue_throttle;
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
+		se_update_runnable(se);
 		update_cfs_group(se);
 
 		cfs_rq->h_nr_running--;
@@ -5405,6 +5460,11 @@ static unsigned long cpu_load_without(struct rq *rq, struct task_struct *p)
 	return load;
 }
 
+static unsigned long cpu_runnable(struct rq *rq)
+{
+	return cfs_rq_runnable_avg(&rq->cfs);
+}
+
 static unsigned long capacity_of(int cpu)
 {
 	return cpu_rq(cpu)->cpu_capacity;
@@ -7550,6 +7610,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (cfs_rq->avg.util_sum)
 		return false;
 
+	if (cfs_rq->avg.runnable_sum)
+		return false;
+
 	return true;
 }
 
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 3eb0ed333dcb..d6ec21450ffa 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -108,7 +108,7 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
  */
 static __always_inline u32
 accumulate_sum(u64 delta, struct sched_avg *sa,
-	       unsigned long load, int running)
+	       unsigned long load, unsigned long runnable, int running)
 {
 	u32 contrib = (u32)delta; /* p == 0 -> delta < 1024 */
 	u64 periods;
@@ -121,6 +121,8 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
 	 */
 	if (periods) {
 		sa->load_sum = decay_load(sa->load_sum, periods);
+		sa->runnable_sum =
+			decay_load(sa->runnable_sum, periods);
 		sa->util_sum = decay_load((u64)(sa->util_sum), periods);
 
 		/*
@@ -146,6 +148,8 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
 
 	if (load)
 		sa->load_sum += load * contrib;
+	if (runnable)
+		sa->runnable_sum += runnable * contrib << SCHED_CAPACITY_SHIFT;
 	if (running)
 		sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;
 
@@ -182,7 +186,7 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
  */
 static __always_inline int
 ___update_load_sum(u64 now, struct sched_avg *sa,
-		  unsigned long load, int running)
+		  unsigned long load, unsigned long runnable, int running)
 {
 	u64 delta;
 
@@ -218,7 +222,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	 * Also see the comment in accumulate_sum().
 	 */
 	if (!load)
-		running = 0;
+		runnable = running = 0;
 
 	/*
 	 * Now we know we crossed measurement unit boundaries. The *_avg
@@ -227,14 +231,14 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	 * Step 1: accumulate *_sum since last_update_time. If we haven't
 	 * crossed period boundaries, finish.
 	 */
-	if (!accumulate_sum(delta, sa, load, running))
+	if (!accumulate_sum(delta, sa, load, runnable, running))
 		return 0;
 
 	return 1;
 }
 
 static __always_inline void
-___update_load_avg(struct sched_avg *sa, unsigned long load)
+___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runnable)
 {
 	u32 divider = LOAD_AVG_MAX - 1024 + sa->period_contrib;
 
@@ -242,6 +246,7 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
 	 * Step 2: update *_avg.
 	 */
 	sa->load_avg = div_u64(load * sa->load_sum, divider);
+	sa->runnable_avg =	div_u64(runnable * sa->runnable_sum, divider);
 	WRITE_ONCE(sa->util_avg, sa->util_sum / divider);
 }
 
@@ -250,9 +255,14 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
  *
  *   task:
  *     se_weight()   = se->load.weight
+ *     se_runnable() = !!on_rq
  *
  *   group: [ see update_cfs_group() ]
  *     se_weight()   = tg->weight * grq->load_avg / tg->load_avg
+ *     se_runnable() = grq->h_nr_running
+ *
+ *   runnable_sum = se_runnable() * runnable = grq->runnable_sum
+ *   runnable_avg = runnable_sum
  *
  *   load_sum := runnable
  *   load_avg = se_weight(se) * load_sum
@@ -261,14 +271,17 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
  *
  * cfq_rq:
  *
+ *   runnable_sum = \Sum se->avg.runnable_sum
+ *   runnable_avg = \Sum se->avg.runnable_avg
+ *
  *   load_sum = \Sum se_weight(se) * se->avg.load_sum
  *   load_avg = \Sum se->avg.load_avg
  */
 
 int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 {
-	if (___update_load_sum(now, &se->avg, 0, 0)) {
-		___update_load_avg(&se->avg, se_weight(se));
+	if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
+		___update_load_avg(&se->avg, se_weight(se), 1);
 		trace_pelt_se_tp(se);
 		return 1;
 	}
@@ -278,9 +291,10 @@ int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 
 int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	if (___update_load_sum(now, &se->avg, !!se->on_rq, cfs_rq->curr == se)) {
+	if (___update_load_sum(now, &se->avg, !!se->on_rq, se_runnable(se),
+				cfs_rq->curr == se)) {
 
-		___update_load_avg(&se->avg, se_weight(se));
+		___update_load_avg(&se->avg, se_weight(se), 1);
 		cfs_se_util_change(&se->avg);
 		trace_pelt_se_tp(se);
 		return 1;
@@ -293,9 +307,10 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 {
 	if (___update_load_sum(now, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
+				cfs_rq->h_nr_running,
 				cfs_rq->curr != NULL)) {
 
-		___update_load_avg(&cfs_rq->avg, 1);
+		___update_load_avg(&cfs_rq->avg, 1, 1);
 		trace_pelt_cfs_tp(cfs_rq);
 		return 1;
 	}
@@ -310,17 +325,18 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
  *   util_sum = cpu_scale * load_sum
  *   runnable_sum = util_sum
  *
- *   load_avg is not supported and meaningless.
+ *   load_avg and runnable_load_avg are not supported and meaningless.
  *
  */
 
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 {
 	if (___update_load_sum(now, &rq->avg_rt,
+				running,
 				running,
 				running)) {
 
-		___update_load_avg(&rq->avg_rt, 1);
+		___update_load_avg(&rq->avg_rt, 1, 1);
 		trace_pelt_rt_tp(rq);
 		return 1;
 	}
@@ -335,17 +351,18 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
  *   util_sum = cpu_scale * load_sum
  *   runnable_sum = util_sum
  *
- *   load_avg is not supported and meaningless.
+ *   load_avg and runnable_load_avg are not supported and meaningless.
  *
  */
 
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 {
 	if (___update_load_sum(now, &rq->avg_dl,
+				running,
 				running,
 				running)) {
 
-		___update_load_avg(&rq->avg_dl, 1);
+		___update_load_avg(&rq->avg_dl, 1, 1);
 		trace_pelt_dl_tp(rq);
 		return 1;
 	}
@@ -361,7 +378,7 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
  *   util_sum = cpu_scale * load_sum
  *   runnable_sum = util_sum
  *
- *   load_avg is not supported and meaningless.
+ *   load_avg and runnable_load_avg are not supported and meaningless.
  *
  */
 
@@ -389,14 +406,16 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 	 * rq->clock += delta with delta >= running
 	 */
 	ret = ___update_load_sum(rq->clock - running, &rq->avg_irq,
+				0,
 				0,
 				0);
 	ret += ___update_load_sum(rq->clock, &rq->avg_irq,
+				1,
 				1,
 				1);
 
 	if (ret) {
-		___update_load_avg(&rq->avg_irq, 1);
+		___update_load_avg(&rq->avg_irq, 1, 1);
 		trace_pelt_irq_tp(rq);
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4f653ef89f1f..5f6f5de03764 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -527,7 +527,7 @@ struct cfs_rq {
 		int		nr;
 		unsigned long	load_avg;
 		unsigned long	util_avg;
-		unsigned long	runnable_sum;
+		unsigned long	runnable_avg;
 	} removed;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -688,9 +688,29 @@ struct dl_rq {
 /* An entity is a task if it doesn't "own" a runqueue */
 #define entity_is_task(se)	(!se->my_q)
 
+static inline void se_update_runnable(struct sched_entity *se)
+{
+	if (!entity_is_task(se))
+		se->runnable_weight = se->my_q->h_nr_running;
+}
+
+static inline long se_runnable(struct sched_entity *se)
+{
+	if (entity_is_task(se))
+		return !!se->on_rq;
+	else
+		return se->runnable_weight;
+}
+
 #else
 #define entity_is_task(se)	1
 
+static inline void se_update_runnable(struct sched_entity *se) {}
+
+static inline long se_runnable(struct sched_entity *se)
+{
+	return !!se->on_rq;
+}
 #endif
 
 #ifdef CONFIG_SMP
-- 
2.16.4

