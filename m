Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A64E521E37
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 21:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfEQTa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 15:30:27 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43660 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfEQTa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:30:26 -0400
Received: by mail-oi1-f195.google.com with SMTP id t187so5963921oie.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 12:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=from:to:subject:date:message-id;
        bh=o07nY9dfWP+zC9Cz3rhRMrIZdh7F1mKdDkQ8lc4TN8I=;
        b=STEI1EVVgCpmWP3zyeQjp30mJxvyPu6D0nynYhx12ILOsuoy4/UyeT+NrSqBfS7Y8l
         ZjL4CIvepqPvxw8IomlAvb+j6TpU8c6+a+63xo5EBQOvmHdBHcZXeA8+ugGj8sXRttZr
         hOIPeYCHhy2bFLFG71jB9yjOu8yDX0WMNSiFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=o07nY9dfWP+zC9Cz3rhRMrIZdh7F1mKdDkQ8lc4TN8I=;
        b=I3Ie6EUUeVHvMQRB6Q/QnbEaH6jkDSzLOXJ/kYSQZBslejx8FogJIx0op3wPBmT2HB
         oVRTeEqm2Z8DntjLubjyRJ0Kjmb0sobY0AfQy+Dzax3t0Csy95jRUonnvzC0iqLH09hw
         Egb+gAtmh95sQ0MwsU8ObNOEyDJQZrNlEG/kjbbJfG7T+oFbsHg5YsrehnRG6BQsX879
         OSQV1tfsVwCaTLjFzvH8w4Vls0FPOa3k9lo7ctlc1eJAZ0i+2GWA9XN0+m+EL1sqnCBf
         mgrpUgYJl9nrn45NEhmBXAmHEizPrnbom0NeSXHUeAs9UdPpwmZ/4yhUI63naChxu4AV
         ItKQ==
X-Gm-Message-State: APjAAAUKmtx4c7OzJuOgnDYJGqx3IDnijBdzZPtSY+CsxbEak/+fkKc0
        agQQCfQVkc5iZvkuc2Un02e6+w==
X-Google-Smtp-Source: APXvYqzwLpoKpZFGSKRs6z1SRvaIDZmMelQWjMoc2DQW15oxhc5Pl/yL2YE9/pRh5UeLdUn16pRArw==
X-Received: by 2002:aca:4202:: with SMTP id p2mr2003848oia.169.1558121425246;
        Fri, 17 May 2019 12:30:25 -0700 (PDT)
Received: from cando.ausoff.indeed.net ([97.105.47.162])
        by smtp.gmail.com with ESMTPSA id m8sm3122143otl.40.2019.05.17.12.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 12:30:24 -0700 (PDT)
From:   Dave Chiluk <chiluk+linux@indeed.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu slices
Date:   Fri, 17 May 2019 14:30:24 -0500
Message-Id: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been observed, that highly-threaded, non-cpu-bound applications
running under cpu.cfs_quota_us constraints can hit a high percentage of
periods throttled while simultaneously not consuming the allocated
amount of quota.  This use case is typical of user-interactive non-cpu
bound applications, such as those running in kubernetes or mesos when
run on multiple cpu cores.

This has been root caused to threads being allocated per cpu bandwidth
slices, and then not fully using that slice within the period. At which
point the slice and quota expires.  This expiration of unused slice
results in applications not being able to utilize the quota for which
they are allocated.

The expiration of per-cpu slices was recently fixed by commit
512ac999d275 ("sched/fair: Fix bandwidth timer clock drift condition").
Prior to that it appears that this has been broken since a least commit
51f2176d74ac ("sched/fair: Fix unlocked reads of some
cfs_b->quota/period") which was introduced in v3.16-rc1 in 2014.  That
commit added the following conditional which resulted in slices never
being expired.

if (cfs_rq->runtime_expires != cfs_b->runtime_expires) {
	/* extend local deadline, drift is bounded above by 2 ticks */
	cfs_rq->runtime_expires += TICK_NSEC;

Because this was broken for nearly 5 years, and has recently been fixed
and is now being noticed by many users running kubernetes
(https://github.com/kubernetes/kubernetes/issues/67577) it is my opinion
that the mechanisms around expiring runtime should be removed
altogether.

This allows only per-cpu slices to live longer than the period boundary.
This allows threads on runqueues that do not use much CPU to continue to
use their remaining slice over a longer period of time than
cpu.cfs_period_us. However, this helps prevents the above condition of
hitting throttling while also not fully utilizing your cpu quota.

This theoretically allows a machine to use slightly more than it's
allotted quota in some periods.  This overflow would be bounded by the
remaining per-cpu slice that was left un-used in the previous period.
For CPU bound tasks this will change nothing, as they should
theoretically fully utilize all of their quota and slices in each
period. For user-interactive tasks as described above this provides a
much better user/application experience as their cpu utilization will
more closely match the amount they requested when they hit throttling.

This greatly improves performance of high-thread-count, non-cpu bound
applications with low cfs_quota_us allocation on high-core-count
machines. In the case of an artificial testcase, this performance
discrepancy has been observed to be almost 30x performance improvement,
while still maintaining correct cpu quota restrictions albeit over
longer time intervals than cpu.cfs_period_us.  That testcase is available
at https://github.com/indeedeng/fibtest.

Fixes: 512ac999d275 ("sched/fair: Fix bandwidth timer clock drift condition")
Signed-off-by: Dave Chiluk <chiluk+linux@indeed.com>
---
 Documentation/scheduler/sched-bwc.txt | 29 +++++++++++---
 kernel/sched/fair.c                   | 71 +++--------------------------------
 kernel/sched/sched.h                  |  4 --
 3 files changed, 29 insertions(+), 75 deletions(-)

diff --git a/Documentation/scheduler/sched-bwc.txt b/Documentation/scheduler/sched-bwc.txt
index f6b1873..4ded8ae 100644
--- a/Documentation/scheduler/sched-bwc.txt
+++ b/Documentation/scheduler/sched-bwc.txt
@@ -8,16 +8,33 @@ CFS bandwidth control is a CONFIG_FAIR_GROUP_SCHED extension which allows the
 specification of the maximum CPU bandwidth available to a group or hierarchy.
 
 The bandwidth allowed for a group is specified using a quota and period. Within
-each given "period" (microseconds), a group is allowed to consume only up to
-"quota" microseconds of CPU time.  When the CPU bandwidth consumption of a
-group exceeds this limit (for that period), the tasks belonging to its
-hierarchy will be throttled and are not allowed to run again until the next
-period.
+each given "period" (microseconds), a task group is allocated up to "quota"
+microseconds of CPU time.  When the CPU bandwidth consumption of a group
+exceeds this limit (for that period), the tasks belonging to its hierarchy will
+be throttled and are not allowed to run again until the next period.
 
 A group's unused runtime is globally tracked, being refreshed with quota units
 above at each period boundary.  As threads consume this bandwidth it is
 transferred to cpu-local "silos" on a demand basis.  The amount transferred
-within each of these updates is tunable and described as the "slice".
+within each of these updates is tunable and described as the "slice".  Slices
+that are allocated to cpu-local silos do not expire at the end of the period,
+but unallocated quota does.  This doesn't affect cpu-bound applications as they
+by definition consume all of their bandwidth in each each period.
+
+However for highly-threaded user-interactive/non-cpu bound applications this
+non-expiration nuance allows applications to burst past their quota limits
+equal to the amount of unused slice per cpu that the task group is running on.
+This slight burst requires that quota had gone unused in previous periods.
+Additionally this burst amount is limited to the size of a slice for every cpu
+a task group is run on.  As a result, this mechanism still strictly limits the
+task group to quota average usage over a longer time windows.  This provides
+better more predictable user experience for highly threaded applications with
+small quota limits on high core count machines.  It also eliminates the
+propensity to throttle these applications while simultanously using less than
+quota amounts of cpu.  Another way to say this, is that by allowing the unused
+portion of a slice to be used in following periods we have decreased the
+possibility of wasting unused quota on cpu-local silos that don't need much cpu
+time.
 
 Management
 ----------
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f..a675c69 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4295,8 +4295,6 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 
 	now = sched_clock_cpu(smp_processor_id());
 	cfs_b->runtime = cfs_b->quota;
-	cfs_b->runtime_expires = now + ktime_to_ns(cfs_b->period);
-	cfs_b->expires_seq++;
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -4318,8 +4316,7 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 {
 	struct task_group *tg = cfs_rq->tg;
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(tg);
-	u64 amount = 0, min_amount, expires;
-	int expires_seq;
+	u64 amount = 0, min_amount;
 
 	/* note: this is a positive sum as runtime_remaining <= 0 */
 	min_amount = sched_cfs_bandwidth_slice() - cfs_rq->runtime_remaining;
@@ -4336,61 +4333,17 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 			cfs_b->idle = 0;
 		}
 	}
-	expires_seq = cfs_b->expires_seq;
-	expires = cfs_b->runtime_expires;
 	raw_spin_unlock(&cfs_b->lock);
 
 	cfs_rq->runtime_remaining += amount;
-	/*
-	 * we may have advanced our local expiration to account for allowed
-	 * spread between our sched_clock and the one on which runtime was
-	 * issued.
-	 */
-	if (cfs_rq->expires_seq != expires_seq) {
-		cfs_rq->expires_seq = expires_seq;
-		cfs_rq->runtime_expires = expires;
-	}
 
 	return cfs_rq->runtime_remaining > 0;
 }
 
-/*
- * Note: This depends on the synchronization provided by sched_clock and the
- * fact that rq->clock snapshots this value.
- */
-static void expire_cfs_rq_runtime(struct cfs_rq *cfs_rq)
-{
-	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
-
-	/* if the deadline is ahead of our clock, nothing to do */
-	if (likely((s64)(rq_clock(rq_of(cfs_rq)) - cfs_rq->runtime_expires) < 0))
-		return;
-
-	if (cfs_rq->runtime_remaining < 0)
-		return;
-
-	/*
-	 * If the local deadline has passed we have to consider the
-	 * possibility that our sched_clock is 'fast' and the global deadline
-	 * has not truly expired.
-	 *
-	 * Fortunately we can check determine whether this the case by checking
-	 * whether the global deadline(cfs_b->expires_seq) has advanced.
-	 */
-	if (cfs_rq->expires_seq == cfs_b->expires_seq) {
-		/* extend local deadline, drift is bounded above by 2 ticks */
-		cfs_rq->runtime_expires += TICK_NSEC;
-	} else {
-		/* global deadline is ahead, expiration has passed */
-		cfs_rq->runtime_remaining = 0;
-	}
-}
-
 static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 {
 	/* dock delta_exec before expiring quota (as it could span periods) */
 	cfs_rq->runtime_remaining -= delta_exec;
-	expire_cfs_rq_runtime(cfs_rq);
 
 	if (likely(cfs_rq->runtime_remaining > 0))
 		return;
@@ -4581,8 +4534,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		resched_curr(rq);
 }
 
-static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
-		u64 remaining, u64 expires)
+static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
 {
 	struct cfs_rq *cfs_rq;
 	u64 runtime;
@@ -4604,7 +4556,6 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
 		remaining -= runtime;
 
 		cfs_rq->runtime_remaining += runtime;
-		cfs_rq->runtime_expires = expires;
 
 		/* we check whether we're throttled above */
 		if (cfs_rq->runtime_remaining > 0)
@@ -4629,7 +4580,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
  */
 static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, unsigned long flags)
 {
-	u64 runtime, runtime_expires;
+	u64 runtime;
 	int throttled;
 
 	/* no need to continue the timer with no bandwidth constraint */
@@ -4657,8 +4608,6 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
 	/* account preceding periods in which throttling occurred */
 	cfs_b->nr_throttled += overrun;
 
-	runtime_expires = cfs_b->runtime_expires;
-
 	/*
 	 * This check is repeated as we are holding onto the new bandwidth while
 	 * we unthrottle. This can potentially race with an unthrottled group
@@ -4671,8 +4620,7 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
 		cfs_b->distribute_running = 1;
 		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		/* we can't nest cfs_b->lock while distributing bandwidth */
-		runtime = distribute_cfs_runtime(cfs_b, runtime,
-						 runtime_expires);
+		runtime = distribute_cfs_runtime(cfs_b, runtime);
 		raw_spin_lock_irqsave(&cfs_b->lock, flags);
 
 		cfs_b->distribute_running = 0;
@@ -4749,8 +4697,7 @@ static void __return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 		return;
 
 	raw_spin_lock(&cfs_b->lock);
-	if (cfs_b->quota != RUNTIME_INF &&
-	    cfs_rq->runtime_expires == cfs_b->runtime_expires) {
+	if (cfs_b->quota != RUNTIME_INF) {
 		cfs_b->runtime += slack_runtime;
 
 		/* we are under rq->lock, defer unthrottling using a timer */
@@ -4783,7 +4730,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 {
 	u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
 	unsigned long flags;
-	u64 expires;
 
 	/* confirm we're still not at a refresh boundary */
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
@@ -4800,7 +4746,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 	if (cfs_b->quota != RUNTIME_INF && cfs_b->runtime > slice)
 		runtime = cfs_b->runtime;
 
-	expires = cfs_b->runtime_expires;
 	if (runtime)
 		cfs_b->distribute_running = 1;
 
@@ -4809,11 +4754,9 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 	if (!runtime)
 		return;
 
-	runtime = distribute_cfs_runtime(cfs_b, runtime, expires);
+	runtime = distribute_cfs_runtime(cfs_b, runtime);
 
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
-	if (expires == cfs_b->runtime_expires)
-		lsub_positive(&cfs_b->runtime, runtime);
 	cfs_b->distribute_running = 0;
 	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 }
@@ -4969,8 +4912,6 @@ void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 
 	cfs_b->period_active = 1;
 	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
-	cfs_b->runtime_expires += (overrun + 1) * ktime_to_ns(cfs_b->period);
-	cfs_b->expires_seq++;
 	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b52ed1a..0c0ed23 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -341,8 +341,6 @@ struct cfs_bandwidth {
 	u64			quota;
 	u64			runtime;
 	s64			hierarchical_quota;
-	u64			runtime_expires;
-	int			expires_seq;
 
 	short			idle;
 	short			period_active;
@@ -562,8 +560,6 @@ struct cfs_rq {
 
 #ifdef CONFIG_CFS_BANDWIDTH
 	int			runtime_enabled;
-	int			expires_seq;
-	u64			runtime_expires;
 	s64			runtime_remaining;
 
 	u64			throttled_clock;
-- 
1.8.3.1

