Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0A97B57E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 00:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfG3WML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 18:12:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60527 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfG3WML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:12:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UMC0b63398141
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 15:12:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UMC0b63398141
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564524720;
        bh=wOVYqXVJoU91lcEwPzjNYPM3EOq9c9CN7k6lqmQwMV4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gH7bettan5F7+cmCdich/dGoXITeX3berQiEFMj0dSI5tnwL0Cx/lW+6cSePiQ2zX
         jSEyIak6uGfHH8JKBymt7ClakP659GAhPn4k/LiO2HWbjJtyYqtQBuUiygxuxgyZdt
         8Pn+Jr7Xu4rN5l7Z7DPBt8hLEAoR/ePiSlJPaSjoIC6pTqr9iWElIwoairr8ekGQau
         I4s0feQk5fULAgWLxqjTSiJYX8nm6iLkxH5BqQBy55Hg8YtxEew0vQ7OUnGMLn9tED
         RcypU3+weXhih3c8l6w57kw1AWeGIQNI6no48kVmzwG+UOGoED47A5USrobCIUnfU3
         /7phJvAEN8g6w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UMBwd93398138;
        Tue, 30 Jul 2019 15:11:58 -0700
Date:   Tue, 30 Jul 2019 15:11:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-b78b1e6b5b77b265a94e3027e6f0dcaad33faf9f@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
          hpa@zytor.com, tglx@linutronix.de, peterz@infradead.org,
          mingo@kernel.org
In-Reply-To: <20190726185753.077004842@linutronix.de>
References: <20190726185753.077004842@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] sched: Mark hrtimers to expire in hard interrupt
 context
Git-Commit-ID: b78b1e6b5b77b265a94e3027e6f0dcaad33faf9f
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

Commit-ID:  b78b1e6b5b77b265a94e3027e6f0dcaad33faf9f
Gitweb:     https://git.kernel.org/tip/b78b1e6b5b77b265a94e3027e6f0dcaad33faf9f
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 20:30:52 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jul 2019 23:57:54 +0200

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
