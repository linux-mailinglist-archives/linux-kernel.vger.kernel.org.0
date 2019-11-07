Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09394F2DFA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 13:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388379AbfKGMMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 07:12:43 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:56642 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbfKGMMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:12:43 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 0EFDF2E1605;
        Thu,  7 Nov 2019 15:12:38 +0300 (MSK)
Received: from iva8-b53eb3f76dc7.qloud-c.yandex.net (iva8-b53eb3f76dc7.qloud-c.yandex.net [2a02:6b8:c0c:2ca1:0:640:b53e:b3f7])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id 24DXkBuaDA-CbA8QAEg;
        Thu, 07 Nov 2019 15:12:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1573128758; bh=b0LL+tCcdVJcSuSAO3vDpWYdAlf+rk5azG2l9+3kHCU=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=UzzJSwhFxRu4eVVTGVnR3tyvs8lQigVETmDOxtEd41xzfcbYhZIf1edZ0HQjpW8lr
         TckNFdI3ItHIHTuSubQ5wRGhK45uPXZgoyb4QwC+Fvly86asl3agmNPGQPYQSA+MkU
         B3w9YJXEmLThChXjCo1phInzUWxF+MJwAHvdd45c=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8554:53c0:3d75:2e8a])
        by iva8-b53eb3f76dc7.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id TLsQCzIzFd-CbW4G9Wv;
        Thu, 07 Nov 2019 15:12:37 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH RFC] sched/fair: add burst to cgroup cpu bandwidth controller
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org
Cc:     Dave Chiluk <chiluk+linux@indeed.com>
Date:   Thu, 07 Nov 2019 15:12:37 +0300
Message-ID: <157312875706.707.12248531434112979828.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CFS bandwidth controller assigns cpu.cfs_quota_us runtime into
global pool every cpu.cfs_period_us. All unused runtime is expired.

Since commit de53fd7aedb1 ("sched/fair: Fix low cpu usage with high
throttling by removing expiration of cpu-local slices") slice assigned
to cpu does not expire. This allows to serve tiny bursts (upto 1ms),
but this runtime pool is cpu-bound and not transferred between cpus.

Setup for interactive workload with irregular cpu consumption have to set
quota according to relatively short spikes of cpu usage. This eliminates
possibility of control for average cpu usage. Increasing period and quota
proportionally for getting bigger runtime chunks is not an option because
if even bigger spike deplete global pool then execution will stuck until
end of period and next refill.

This patch adds limited accumulation of unused runtime from past periods.
Accumulated runtime does not expire. It stays in global pool and could
be used by any cpu. Average cpu usage stays limited with quota / period,
but spiky workload could use more cpu power for a short period of time.

Size of pool for burst runtime is set in attribute cpu.cfs_burst_us.
Default is 0, which reflects current behavior.

Statistics for used bust runtime is shown in cpu.stat as "burst_time".

Example setup:
cpu.cfs_period_us = 100ms
cpu.cfs_quota_us = 200ms
cpu.cfs_burst_us = 300ms

Average cpu usage stays limited with 2 cpus (quota / period), but cgroup
could accumulate runtime (burst) and for 100ms could utilize up to 5 cpus
(quota / period + burst / 100ms), or 3 cpus for 300ms, an so on.

Implementation is simple. All logic is in __refill_cfs_bandwidth_runtime().
The rest changes are interface for cgroup and cgroup2.

For cgroup2 burst is set as third number in attribute cpu.max:
cpu.max = $QUOTA $PERIOD $BURST

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 Documentation/admin-guide/cgroup-v2.rst |   15 +++--
 Documentation/scheduler/sched-bwc.rst   |    8 ++-
 kernel/sched/core.c                     |   88 +++++++++++++++++++++++++------
 kernel/sched/fair.c                     |   34 ++++++++++--
 kernel/sched/sched.h                    |    4 +
 5 files changed, 119 insertions(+), 30 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 5361ebec3361..8c3cc3d882ba 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -981,11 +981,12 @@ All time durations are in microseconds.
 	- user_usec
 	- system_usec
 
-	and the following three when the controller is enabled:
+	and the following four when the controller is enabled:
 
 	- nr_periods
 	- nr_throttled
 	- throttled_usec
+	- burst_usec
 
   cpu.weight
 	A read-write single value file which exists on non-root
@@ -1006,16 +1007,18 @@ All time durations are in microseconds.
 	the closest approximation of the current weight.
 
   cpu.max
-	A read-write two value file which exists on non-root cgroups.
-	The default is "max 100000".
+	A read-write 1..3 values file which exists on non-root cgroups.
+	The default is "max 100000 0".
 
 	The maximum bandwidth limit.  It's in the following format::
 
-	  $MAX $PERIOD
+	  $MAX $PERIOD $BURST
 
 	which indicates that the group may consume upto $MAX in each
-	$PERIOD duration.  "max" for $MAX indicates no limit.  If only
-	one number is written, $MAX is updated.
+	$PERIOD duration and accumulates upto $BURST time for bursts.
+
+	"max" for $MAX indicates no limit.
+	If only one number is written, $MAX is updated.
 
   cpu.pressure
 	A read-only nested-key file which exists on non-root cgroups.
diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
index 9801d6b284b1..5f1cac7b2d44 100644
--- a/Documentation/scheduler/sched-bwc.rst
+++ b/Documentation/scheduler/sched-bwc.rst
@@ -27,12 +27,14 @@ Quota and period are managed within the cpu subsystem via cgroupfs.
 
 cpu.cfs_quota_us: the total available run-time within a period (in microseconds)
 cpu.cfs_period_us: the length of a period (in microseconds)
+cpu.cfs_burst_us: the maxumum size of burst run-time pool (in microseconds)
 cpu.stat: exports throttling statistics [explained further below]
 
 The default values are::
 
 	cpu.cfs_period_us=100ms
-	cpu.cfs_quota=-1
+	cpu.cfs_quota_us=-1
+	cpu.cfs_burst_us=0
 
 A value of -1 for cpu.cfs_quota_us indicates that the group does not have any
 bandwidth restriction in place, such a group is described as an unconstrained
@@ -51,6 +53,9 @@ and return the group to an unconstrained state once more.
 Any updates to a group's bandwidth specification will result in it becoming
 unthrottled if it is in a constrained state.
 
+Writing positive value into cpu.cfs_burst_us allows to allcumulate unused
+run-time (upto this value) and use it later in addition to assigned quota.
+
 System wide settings
 --------------------
 For efficiency run-time is transferred between the global pool and CPU local
@@ -75,6 +80,7 @@ cpu.stat:
 - nr_throttled: Number of times the group has been throttled/limited.
 - throttled_time: The total time duration (in nanoseconds) for which entities
   of the group have been throttled.
+- burst_time: The total running time consumed from burst pool.
 
 This interface is read-only.
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dd05a378631a..010b79c45200 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7354,7 +7354,8 @@ static const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
 
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
-static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
+static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
+				u64 burst)
 {
 	int i, ret = 0, runtime_enabled, runtime_was_enabled;
 	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
@@ -7399,12 +7400,13 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
 	raw_spin_lock_irq(&cfs_b->lock);
 	cfs_b->period = ns_to_ktime(period);
 	cfs_b->quota = quota;
-
-	__refill_cfs_bandwidth_runtime(cfs_b);
+	cfs_b->burst = burst;
 
 	/* Restart the period timer (if active) to handle new period expiry: */
-	if (runtime_enabled)
+	if (runtime_enabled) {
+		__refill_cfs_bandwidth_runtime(cfs_b);
 		start_cfs_bandwidth(cfs_b);
+	}
 
 	raw_spin_unlock_irq(&cfs_b->lock);
 
@@ -7432,9 +7434,10 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
 
 static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 {
-	u64 quota, period;
+	u64 quota, period, burst;
 
 	period = ktime_to_ns(tg->cfs_bandwidth.period);
+	burst = tg->cfs_bandwidth.burst;
 	if (cfs_quota_us < 0)
 		quota = RUNTIME_INF;
 	else if ((u64)cfs_quota_us <= U64_MAX / NSEC_PER_USEC)
@@ -7442,7 +7445,7 @@ static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 	else
 		return -EINVAL;
 
-	return tg_set_cfs_bandwidth(tg, period, quota);
+	return tg_set_cfs_bandwidth(tg, period, quota, burst);
 }
 
 static long tg_get_cfs_quota(struct task_group *tg)
@@ -7460,15 +7463,16 @@ static long tg_get_cfs_quota(struct task_group *tg)
 
 static int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
 {
-	u64 quota, period;
+	u64 quota, period, burst;
 
 	if ((u64)cfs_period_us > U64_MAX / NSEC_PER_USEC)
 		return -EINVAL;
 
 	period = (u64)cfs_period_us * NSEC_PER_USEC;
 	quota = tg->cfs_bandwidth.quota;
+	burst = tg->cfs_bandwidth.burst;
 
-	return tg_set_cfs_bandwidth(tg, period, quota);
+	return tg_set_cfs_bandwidth(tg, period, quota, burst);
 }
 
 static long tg_get_cfs_period(struct task_group *tg)
@@ -7481,6 +7485,28 @@ static long tg_get_cfs_period(struct task_group *tg)
 	return cfs_period_us;
 }
 
+static long tg_get_cfs_burst(struct task_group *tg)
+{
+	u64 cfs_burst_us = tg->cfs_bandwidth.burst;
+
+	do_div(cfs_burst_us, NSEC_PER_USEC);
+	return cfs_burst_us;
+}
+
+static int tg_set_cfs_burst(struct task_group *tg, long cfs_burst_us)
+{
+	u64 quota, period, burst;
+
+	if ((u64)cfs_burst_us > U64_MAX / NSEC_PER_USEC)
+		return -EINVAL;
+
+	period = ktime_to_ns(tg->cfs_bandwidth.period);
+	quota = tg->cfs_bandwidth.quota;
+	burst = (u64)cfs_burst_us * NSEC_PER_USEC;
+
+	return tg_set_cfs_bandwidth(tg, period, quota, burst);
+}
+
 static s64 cpu_cfs_quota_read_s64(struct cgroup_subsys_state *css,
 				  struct cftype *cft)
 {
@@ -7505,6 +7531,18 @@ static int cpu_cfs_period_write_u64(struct cgroup_subsys_state *css,
 	return tg_set_cfs_period(css_tg(css), cfs_period_us);
 }
 
+static u64 cpu_cfs_burst_read_u64(struct cgroup_subsys_state *css,
+				  struct cftype *cft)
+{
+	return tg_get_cfs_burst(css_tg(css));
+}
+
+static int cpu_cfs_burst_write_u64(struct cgroup_subsys_state *css,
+				   struct cftype *cftype, u64 cfs_burst_us)
+{
+	return tg_set_cfs_burst(css_tg(css), cfs_burst_us);
+}
+
 struct cfs_schedulable_data {
 	struct task_group *tg;
 	u64 period, quota;
@@ -7596,6 +7634,7 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 	seq_printf(sf, "nr_periods %d\n", cfs_b->nr_periods);
 	seq_printf(sf, "nr_throttled %d\n", cfs_b->nr_throttled);
 	seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);
+	seq_printf(sf, "burst_time %llu\n", cfs_b->burst_time);
 
 	if (schedstat_enabled() && tg != &root_task_group) {
 		u64 ws = 0;
@@ -7657,6 +7696,11 @@ static struct cftype cpu_legacy_files[] = {
 		.read_u64 = cpu_cfs_period_read_u64,
 		.write_u64 = cpu_cfs_period_write_u64,
 	},
+	{
+		.name = "cfs_burst_us",
+		.read_u64 = cpu_cfs_burst_read_u64,
+		.write_u64 = cpu_cfs_burst_write_u64,
+	},
 	{
 		.name = "stat",
 		.seq_show = cpu_cfs_stat_show,
@@ -7699,15 +7743,20 @@ static int cpu_extra_stat_show(struct seq_file *sf,
 		struct task_group *tg = css_tg(css);
 		struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
 		u64 throttled_usec;
+		u64 burst_usec;
 
 		throttled_usec = cfs_b->throttled_time;
 		do_div(throttled_usec, NSEC_PER_USEC);
 
+		burst_usec = cfs_b->burst_time;
+		do_div(burst_usec, NSEC_PER_USEC);
+
 		seq_printf(sf, "nr_periods %d\n"
 			   "nr_throttled %d\n"
-			   "throttled_usec %llu\n",
+			   "throttled_usec %llu\n"
+			   "burst_usec %llu\n",
 			   cfs_b->nr_periods, cfs_b->nr_throttled,
-			   throttled_usec);
+			   throttled_usec, burst_usec);
 	}
 #endif
 	return 0;
@@ -7777,26 +7826,29 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 #endif
 
 static void __maybe_unused cpu_period_quota_print(struct seq_file *sf,
-						  long period, long quota)
+						  long period, long quota,
+						  long burst)
 {
 	if (quota < 0)
 		seq_puts(sf, "max");
 	else
 		seq_printf(sf, "%ld", quota);
 
-	seq_printf(sf, " %ld\n", period);
+	seq_printf(sf, " %ld %ld\n", period, burst);
 }
 
 /* caller should put the current value in *@periodp before calling */
 static int __maybe_unused cpu_period_quota_parse(char *buf,
-						 u64 *periodp, u64 *quotap)
+						 u64 *periodp, u64 *quotap,
+						 s64 *burstp)
 {
 	char tok[21];	/* U64_MAX */
 
-	if (sscanf(buf, "%20s %llu", tok, periodp) < 1)
+	if (sscanf(buf, "%20s %llu %llu", tok, periodp, burstp) < 1)
 		return -EINVAL;
 
 	*periodp *= NSEC_PER_USEC;
+	*burstp *= NSEC_PER_USEC;
 
 	if (sscanf(tok, "%llu", quotap))
 		*quotap *= NSEC_PER_USEC;
@@ -7813,7 +7865,8 @@ static int cpu_max_show(struct seq_file *sf, void *v)
 {
 	struct task_group *tg = css_tg(seq_css(sf));
 
-	cpu_period_quota_print(sf, tg_get_cfs_period(tg), tg_get_cfs_quota(tg));
+	cpu_period_quota_print(sf, tg_get_cfs_period(tg), tg_get_cfs_quota(tg),
+			       tg_get_cfs_burst(tg));
 	return 0;
 }
 
@@ -7822,12 +7875,13 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 {
 	struct task_group *tg = css_tg(of_css(of));
 	u64 period = tg_get_cfs_period(tg);
+	s64 burst = tg_get_cfs_burst(tg);
 	u64 quota;
 	int ret;
 
-	ret = cpu_period_quota_parse(buf, &period, &quota);
+	ret = cpu_period_quota_parse(buf, &period, &quota, &burst);
 	if (!ret)
-		ret = tg_set_cfs_bandwidth(tg, period, quota);
+		ret = tg_set_cfs_bandwidth(tg, period, quota, burst);
 	return ret ?: nbytes;
 }
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 682a754ea3e1..26b8dac67c79 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4353,16 +4353,26 @@ static inline u64 sched_cfs_bandwidth_slice(void)
 }
 
 /*
- * Replenish runtime according to assigned quota. We use sched_clock_cpu
- * directly instead of rq->clock to avoid adding additional synchronization
- * around rq->lock.
+ * Replenish runtime according to assigned quota.
+ * Called only if quota != RUNTIME_INF.
  *
  * requires cfs_b->lock
  */
 void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 {
-	if (cfs_b->quota != RUNTIME_INF)
-		cfs_b->runtime = cfs_b->quota;
+	u64 runtime = cfs_b->runtime;
+
+	/*
+	 * Preserve past runtime up to burst size. If remaining runtime lower
+	 * than previous burst runtime then account delta as used burst time.
+	 */
+	if (runtime > cfs_b->burst)
+		runtime = cfs_b->burst;
+	else if (runtime < cfs_b->burst_runtime)
+		cfs_b->burst_time += cfs_b->burst_runtime - runtime;
+
+	cfs_b->burst_runtime = runtime;
+	cfs_b->runtime = runtime + cfs_b->quota;
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -4968,6 +4978,9 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->runtime = 0;
 	cfs_b->quota = RUNTIME_INF;
 	cfs_b->period = ns_to_ktime(default_cfs_period());
+	cfs_b->burst = 0;
+	cfs_b->burst_runtime = 0;
+	cfs_b->burst_time = 0;
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
 	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
@@ -4986,14 +4999,23 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 {
+	u64 overrun;
+
 	lockdep_assert_held(&cfs_b->lock);
 
 	if (cfs_b->period_active)
 		return;
 
 	cfs_b->period_active = 1;
-	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
+	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
 	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
+
+	/*
+	 * Refill runtime for periods of inactivity and current.
+	 * __refill_cfs_bandwidth_runtime() will cut excess.
+	 */
+	cfs_b->runtime += cfs_b->quota * overrun;
+	__refill_cfs_bandwidth_runtime(cfs_b);
 }
 
 static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0db2c1b3361e..eaecd7298f80 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -344,10 +344,14 @@ struct cfs_bandwidth {
 	struct hrtimer		slack_timer;
 	struct list_head	throttled_cfs_rq;
 
+	u64			burst;
+	u64			burst_runtime;
+
 	/* Statistics: */
 	int			nr_periods;
 	int			nr_throttled;
 	u64			throttled_time;
+	u64			burst_time;
 #endif
 };
 

