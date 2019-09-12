Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD1FB0BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 11:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbfILJoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 05:44:37 -0400
Received: from 4.mo1.mail-out.ovh.net ([46.105.76.26]:60434 "EHLO
        4.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730835AbfILJoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:44:37 -0400
Received: from player718.ha.ovh.net (unknown [10.108.42.83])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id 65D9018F432
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 11:44:32 +0200 (CEST)
Received: from qperret.net (115.ip-51-255-42.eu [51.255.42.115])
        (Authenticated sender: qperret@qperret.net)
        by player718.ha.ovh.net (Postfix) with ESMTPSA id 961E59A7B108;
        Thu, 12 Sep 2019 09:44:19 +0000 (UTC)
From:   Quentin Perret <qperret@qperret.net>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, juri.lelli@redhat.com, rjw@rjwysocki.net,
        morten.rasmussen@arm.com, valentin.schneider@arm.com,
        qais.yousef@arm.com, tkjos@google.com,
        linux-kernel@vger.kernel.org, qperret@qperret.net
Subject: [PATCH] sched/fair: Speed-up energy-aware wake-ups
Date:   Thu, 12 Sep 2019 11:44:04 +0200
Message-Id: <20190912094404.13802-1-qperret@qperret.net>
X-Mailer: git-send-email 2.17.1
X-Ovh-Tracer-Id: 1405123085517740942
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtdehgddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Perret <quentin.perret@arm.com>

EAS computes the energy impact of migrating a waking task when deciding
on which CPU it should run. However, the current approach is known to
have a high algorithmic complexity, which can result in prohibitively
high wake-up latencies on systems with complex energy models, such as
systems with per-CPU DVFS. On such systems, the algorithm complexity is
in O(n^2) (ignoring the cost of searching for performance states in the
EM) with 'n' the number of CPUs.

To address this, re-factor the EAS wake-up path to compute the energy
'delta' (with and without the task) on a per-performance domain basis,
rather than system-wide, which brings the complexity down to O(n).

No functional changes intended.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---

Test results
~~~~~~~~~~~~

* Setup: Tested on a Google Pixel 3, with a Snapdragon 845 (4+4 CPUs,
  A55/A75). Base kernel is 5.3-rc5 + Pixel3 specific patches. Android
  userspace, no graphics.

* Test case:  Run a periodic rt-app task, with 16ms period, ramping down
  from 70% to 10%, in 5% steps of 500 ms each (json avail. at [1]).
  Frequencies of all CPUs are pinned to max (using scaling_min_freq
  CPUFreq sysfs entries) to reduce variability. The time to run
  select_task_rq_fair() is measured using the function profiler
  (/sys/kernel/debug/tracing/trace_stat/function*). See the test script
  for more details [2].

Test 1:
I hacked the DT to 'fake' per-CPU DVFS. That is, we end up with one
CPUFreq policy per CPU (8 policies in total). Since all frequencies are
pinned to max for the test, this should have no impact on the actual
frequency selection, but it does in the EAS calculation.

      +---------------------------+----------------------------------+
      | Without patch             | With patch                       |
+-----+-----+----------+----------+-----+-----------------+----------+
| CPU | Hit | Avg (us) | s^2 (us) | Hit | Avg (us)        | s^2 (us) |
|-----+-----+----------+----------+-----+-----------------+----------+
|  0  | 274 | 38.303   | 1750.239 | 401 | 14.126 (-63.1%) | 146.625  |
|  1  | 197 | 49.529   | 1695.852 | 314 | 16.135 (-67.4%) | 167.525  |
|  2  | 142 | 34.296   | 1758.665 | 302 | 14.133 (-58.8%) | 130.071  |
|  3  | 172 | 31.734   | 1490.975 | 641 | 14.637 (-53.9%) | 139.189  |
|  4  | 316 | 7.834    | 178.217  | 425 | 5.413  (-30.9%) | 20.803   |
|  5  | 447 | 8.424    | 144.638  | 556 | 5.929  (-29.6%) | 27.301   |
|  6  | 581 | 14.886   | 346.793  | 456 | 5.711  (-61.6%) | 23.124   |
|  7  | 456 | 10.005   | 211.187  | 997 | 4.708  (-52.9%) | 21.144   |
+-----+-----+----------+----------+-----+-----------------+----------+
             * Hit, Avg and s^2 are as reported by the function profiler

Test 2:
I also ran the same test with a normal DT, with 2 CPUFreq policies, to
see if this causes regressions in the most common case.

      +---------------------------+----------------------------------+
      | Without patch             | With patch                       |
+-----+-----+----------+----------+-----+-----------------+----------+
| CPU | Hit | Avg (us) | s^2 (us) | Hit | Avg (us)        | s^2 (us) |
|-----+-----+----------+----------+-----+-----------------+----------+
|  0  | 345 | 22.184   | 215.321  | 580 | 18.635 (-16.0%) | 146.892  |
|  1  | 358 | 18.597   | 200.596  | 438 | 12.934 (-30.5%) | 104.604  |
|  2  | 359 | 25.566   | 200.217  | 397 | 10.826 (-57.7%) | 74.021   |
|  3  | 362 | 16.881   | 200.291  | 718 | 11.455 (-32.1%) | 102.280  |
|  4  | 457 | 3.822    | 9.895    | 757 | 4.616  (+20.8%) | 13.369   |
|  5  | 344 | 4.301    | 7.121    | 594 | 5.320  (+23.7%) | 18.798   |
|  6  | 472 | 4.326    | 7.849    | 464 | 5.648  (+30.6%) | 22.022   |
|  7  | 331 | 4.630    | 13.937   | 408 | 5.299  (+14.4%) | 18.273   |
+-----+-----+----------+----------+-----+-----------------+----------+
             * Hit, Avg and s^2 are as reported by the function profiler

In addition to these two tests, I also ran 50 iterations of the Lisa
EAS functional test suite [3] with this patch applied on Arm Juno r0,
Arm Juno r2, Arm TC2 and Hikey960, and could not see any regressions
(all EAS functional tests are passing).

[1] https://paste.debian.net/1100055/
[2] https://paste.debian.net/1100057/
[3] https://github.com/ARM-software/lisa/blob/master/lisa/tests/scheduler/eas_behaviour.py
---
 kernel/sched/fair.c | 110 ++++++++++++++++++++------------------------
 1 file changed, 50 insertions(+), 60 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc9cfeaac8bd..8a521087e11d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6277,69 +6277,55 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 }
 
 /*
- * compute_energy(): Estimates the energy that would be consumed if @p was
+ * compute_energy(): Estimates the energy that @pd would consume if @p was
  * migrated to @dst_cpu. compute_energy() predicts what will be the utilization
- * landscape of the * CPUs after the task migration, and uses the Energy Model
+ * landscape of @pd's CPUs after the task migration, and uses the Energy Model
  * to compute what would be the energy if we decided to actually migrate that
  * task.
  */
 static long
 compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 {
-	unsigned int max_util, util_cfs, cpu_util, cpu_cap;
-	unsigned long sum_util, energy = 0;
-	struct task_struct *tsk;
+	struct cpumask *pd_mask = perf_domain_span(pd);
+	unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
+	unsigned long max_util = 0, sum_util = 0;
 	int cpu;
 
-	for (; pd; pd = pd->next) {
-		struct cpumask *pd_mask = perf_domain_span(pd);
+	/*
+	 * The capacity state of CPUs of the current rd can be driven by CPUs
+	 * of another rd if they belong to the same pd. So, account for the
+	 * utilization of these CPUs too by masking pd with cpu_online_mask
+	 * instead of the rd span.
+	 *
+	 * If an entire pd is outside of the current rd, it will not appear in
+	 * its pd list and will not be accounted by compute_energy().
+	 */
+	for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
+		unsigned long cpu_util, util_cfs = cpu_util_next(cpu, p, dst_cpu);
+		struct task_struct *tsk = cpu == dst_cpu ? p : NULL;
 
 		/*
-		 * The energy model mandates all the CPUs of a performance
-		 * domain have the same capacity.
+		 * Busy time computation: utilization clamping is not
+		 * required since the ratio (sum_util / cpu_capacity)
+		 * is already enough to scale the EM reported power
+		 * consumption at the (eventually clamped) cpu_capacity.
 		 */
-		cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
-		max_util = sum_util = 0;
+		sum_util += schedutil_cpu_util(cpu, util_cfs, cpu_cap,
+					       ENERGY_UTIL, NULL);
 
 		/*
-		 * The capacity state of CPUs of the current rd can be driven by
-		 * CPUs of another rd if they belong to the same performance
-		 * domain. So, account for the utilization of these CPUs too
-		 * by masking pd with cpu_online_mask instead of the rd span.
-		 *
-		 * If an entire performance domain is outside of the current rd,
-		 * it will not appear in its pd list and will not be accounted
-		 * by compute_energy().
+		 * Performance domain frequency: utilization clamping
+		 * must be considered since it affects the selection
+		 * of the performance domain frequency.
+		 * NOTE: in case RT tasks are running, by default the
+		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
-		for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
-			util_cfs = cpu_util_next(cpu, p, dst_cpu);
-
-			/*
-			 * Busy time computation: utilization clamping is not
-			 * required since the ratio (sum_util / cpu_capacity)
-			 * is already enough to scale the EM reported power
-			 * consumption at the (eventually clamped) cpu_capacity.
-			 */
-			sum_util += schedutil_cpu_util(cpu, util_cfs, cpu_cap,
-						       ENERGY_UTIL, NULL);
-
-			/*
-			 * Performance domain frequency: utilization clamping
-			 * must be considered since it affects the selection
-			 * of the performance domain frequency.
-			 * NOTE: in case RT tasks are running, by default the
-			 * FREQUENCY_UTIL's utilization can be max OPP.
-			 */
-			tsk = cpu == dst_cpu ? p : NULL;
-			cpu_util = schedutil_cpu_util(cpu, util_cfs, cpu_cap,
-						      FREQUENCY_UTIL, tsk);
-			max_util = max(max_util, cpu_util);
-		}
-
-		energy += em_pd_energy(pd->em_pd, max_util, sum_util);
+		cpu_util = schedutil_cpu_util(cpu, util_cfs, cpu_cap,
+					      FREQUENCY_UTIL, tsk);
+		max_util = max(max_util, cpu_util);
 	}
 
-	return energy;
+	return em_pd_energy(pd->em_pd, max_util, sum_util);
 }
 
 /*
@@ -6381,21 +6367,19 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
  * other use-cases too. So, until someone finds a better way to solve this,
  * let's keep things simple by re-using the existing slow path.
  */
-
 static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
-	unsigned long prev_energy = ULONG_MAX, best_energy = ULONG_MAX;
+	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
 	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
+	unsigned long cpu_cap, util, base_energy = 0;
 	int cpu, best_energy_cpu = prev_cpu;
-	struct perf_domain *head, *pd;
-	unsigned long cpu_cap, util;
 	struct sched_domain *sd;
+	struct perf_domain *pd;
 
 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
 	if (!pd || READ_ONCE(rd->overutilized))
 		goto fail;
-	head = pd;
 
 	/*
 	 * Energy-aware wake-up happens on the lowest sched_domain starting
@@ -6412,9 +6396,14 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		goto unlock;
 
 	for (; pd; pd = pd->next) {
-		unsigned long cur_energy, spare_cap, max_spare_cap = 0;
+		unsigned long cur_delta, spare_cap, max_spare_cap = 0;
+		unsigned long base_energy_pd;
 		int max_spare_cap_cpu = -1;
 
+		/* Compute the 'base' energy of the pd, without @p */
+		base_energy_pd = compute_energy(p, -1, pd);
+		base_energy += base_energy_pd;
+
 		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
@@ -6427,9 +6416,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 			/* Always use prev_cpu as a candidate. */
 			if (cpu == prev_cpu) {
-				prev_energy = compute_energy(p, prev_cpu, head);
-				best_energy = min(best_energy, prev_energy);
-				continue;
+				prev_delta = compute_energy(p, prev_cpu, pd);
+				prev_delta -= base_energy_pd;
+				best_delta = min(best_delta, prev_delta);
 			}
 
 			/*
@@ -6445,9 +6434,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 		/* Evaluate the energy impact of using this CPU. */
 		if (max_spare_cap_cpu >= 0) {
-			cur_energy = compute_energy(p, max_spare_cap_cpu, head);
-			if (cur_energy < best_energy) {
-				best_energy = cur_energy;
+			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
+			cur_delta -= base_energy_pd;
+			if (cur_delta < best_delta) {
+				best_delta = cur_delta;
 				best_energy_cpu = max_spare_cap_cpu;
 			}
 		}
@@ -6459,10 +6449,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	 * Pick the best CPU if prev_cpu cannot be used, or if it saves at
 	 * least 6% of the energy used by prev_cpu.
 	 */
-	if (prev_energy == ULONG_MAX)
+	if (prev_delta == ULONG_MAX)
 		return best_energy_cpu;
 
-	if ((prev_energy - best_energy) > (prev_energy >> 4))
+	if ((prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
 		return best_energy_cpu;
 
 	return prev_cpu;
-- 
2.22.1

