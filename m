Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0835A612
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 22:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfF1UuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 16:50:05 -0400
Received: from shelob.surriel.com ([96.67.55.147]:38438 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfF1Utg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 16:49:36 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hgxo6-0007TL-Mt; Fri, 28 Jun 2019 16:49:18 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 07/10] sched,cfs: fix zero length timeslice calculation
Date:   Fri, 28 Jun 2019 16:49:10 -0400
Message-Id: <20190628204913.10287-8-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628204913.10287-1-riel@surriel.com>
References: <20190628204913.10287-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way the time slice length is currently calculated, not only do high
priority tasks get longer time slices than low priority tasks, but due
to fixed point math, low priority tasks could end up with a zero length
time slice. This can lead to cache thrashing and other inefficiencies.

Simplify the logic a little bit, and cap the minimum time slice length
to sysctl_sched_min_granularity.

Tasks that end up getting a time slice length too long for their relative
priority will simply end up having their vruntime advanced much faster than
other tasks, resulting in them receiving time slices less frequently.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/sched/fair.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d48bff5118fc..8da2823401ca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -671,22 +671,6 @@ static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
 	return delta;
 }
 
-/*
- * The idea is to set a period in which each task runs once.
- *
- * When there are too many tasks (sched_nr_latency) we have to stretch
- * this period because otherwise the slices get too small.
- *
- * p = (nr <= nl) ? l : l*nr/nl
- */
-static u64 __sched_period(unsigned long nr_running)
-{
-	if (unlikely(nr_running > sched_nr_latency))
-		return nr_running * sysctl_sched_min_granularity;
-	else
-		return sysctl_sched_latency;
-}
-
 /*
  * We calculate the wall-time slice from the period by taking a part
  * proportional to the weight.
@@ -695,7 +679,7 @@ static u64 __sched_period(unsigned long nr_running)
  */
 static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	u64 slice = __sched_period(cfs_rq->nr_running + !se->on_rq);
+	u64 slice = sysctl_sched_latency;
 
 	for_each_sched_entity(se) {
 		struct load_weight *load;
@@ -712,6 +696,13 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		}
 		slice = __calc_delta(slice, se->load.weight, load);
 	}
+
+	/*
+	 * To avoid cache thrashing, run at least sysctl_sched_min_granularity.
+	 * The vruntime of a low priority task advances faster; those tasks
+	 * will simply get time slices less frequently.
+	 */
+	slice = max_t(u64, slice, sysctl_sched_min_granularity);
 	return slice;
 }
 
-- 
2.20.1

