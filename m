Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30C757DF7E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 17:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbfHAPxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 11:53:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38517 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732090AbfHAPxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:53:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71Friq3005185
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 08:53:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71Friq3005185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564674825;
        bh=8sIe0Pe1k8DGjdPypIw4hFFyohZ4oz0X6NY6IeHKxLA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=IiiY0D1DLIHZkGaxtWGxu9EzkhlwLQ7pM6RJ6njMxra1D+nEAqI0Gl9VbVXGUBdsA
         dl7US4bpK8JPuysqEK/A2Jb60U7Cr4B9AG7lZkG90B0RfkL4cKAW0Yegnsd/uDrsm7
         o+Qa1n0i/EDc5AQSSn0JKvt0yqka9+tPGeFT/6+yJsSp8bZmsX1f//isOmG03QlZEU
         vsr4v+XIXCK6LOOyREqrdKny+pNjQ7VlIAWfd5l/yeZFtmgPqIU7dJocuXxYKUzxfy
         KN9HyZJlbQEzMcHNDFDonAN2CJ1cftz7dHw2bBYlHlBRkv4CBd0nDJupWh+xTAcxSd
         /aTAXEhBFdzeg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71FriFL005182;
        Thu, 1 Aug 2019 08:53:44 -0700
Date:   Thu, 1 Aug 2019 08:53:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-8b74569a24cb61ed5406668a4e7b3cbdccba25f7@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: peterz@infradead.org, mingo@kernel.org, bigeasy@linutronix.de,
          hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20190726185753.077004842@linutronix.de>
References: <20190726185753.077004842@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] sched: Mark hrtimers to expire in hard interrupt
 context
Git-Commit-ID: 8b74569a24cb61ed5406668a4e7b3cbdccba25f7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8b74569a24cb61ed5406668a4e7b3cbdccba25f7
Gitweb:     https://git.kernel.org/tip/8b74569a24cb61ed5406668a4e7b3cbdccba25f7
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 20:30:52 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 17:43:17 +0200

sched: Mark hrtimers to expire in hard interrupt context

The scheduler related hrtimers need to expire in hard interrupt context
even on PREEMPT_RT enabled kernels. Mark then as such.

No functional change.

[ tglx: Split out from larger combo patch. Add changelog. ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726185753.077004842@linutronix.de


---
 kernel/sched/core.c     | 6 +++---
 kernel/sched/deadline.c | 4 ++--
 kernel/sched/rt.c       | 7 ++++---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b037f195473..389e0993fbb4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -255,7 +255,7 @@ static void __hrtick_restart(struct rq *rq)
 {
 	struct hrtimer *timer = &rq->hrtick_timer;
 
-	hrtimer_start_expires(timer, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_start_expires(timer, HRTIMER_MODE_ABS_PINNED_HARD);
 }
 
 /*
@@ -314,7 +314,7 @@ void hrtick_start(struct rq *rq, u64 delay)
 	 */
 	delay = max_t(u64, delay, 10000LL);
 	hrtimer_start(&rq->hrtick_timer, ns_to_ktime(delay),
-		      HRTIMER_MODE_REL_PINNED);
+		      HRTIMER_MODE_REL_PINNED_HARD);
 }
 #endif /* CONFIG_SMP */
 
@@ -328,7 +328,7 @@ static void hrtick_rq_init(struct rq *rq)
 	rq->hrtick_csd.info = rq;
 #endif
 
-	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	rq->hrtick_timer.function = hrtick;
 }
 #else	/* CONFIG_SCHED_HRTICK */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ef5b9f6b1d42..0359612d5443 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -923,7 +923,7 @@ static int start_dl_timer(struct task_struct *p)
 	 */
 	if (!hrtimer_is_queued(timer)) {
 		get_task_struct(p);
-		hrtimer_start(timer, act, HRTIMER_MODE_ABS);
+		hrtimer_start(timer, act, HRTIMER_MODE_ABS_HARD);
 	}
 
 	return 1;
@@ -1053,7 +1053,7 @@ void init_dl_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->dl_timer;
 
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	timer->function = dl_task_timer;
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a532558a5176..da3e85e61013 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -45,8 +45,8 @@ void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime)
 
 	raw_spin_lock_init(&rt_b->rt_runtime_lock);
 
-	hrtimer_init(&rt_b->rt_period_timer,
-			CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&rt_b->rt_period_timer, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_REL_HARD);
 	rt_b->rt_period_timer.function = sched_rt_period_timer;
 }
 
@@ -67,7 +67,8 @@ static void start_rt_bandwidth(struct rt_bandwidth *rt_b)
 		 * to update the period.
 		 */
 		hrtimer_forward_now(&rt_b->rt_period_timer, ns_to_ktime(0));
-		hrtimer_start_expires(&rt_b->rt_period_timer, HRTIMER_MODE_ABS_PINNED);
+		hrtimer_start_expires(&rt_b->rt_period_timer,
+				      HRTIMER_MODE_ABS_PINNED_HARD);
 	}
 	raw_spin_unlock(&rt_b->rt_runtime_lock);
 }
