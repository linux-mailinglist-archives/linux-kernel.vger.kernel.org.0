Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B85D9895E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 04:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbfHVCS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 22:18:56 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34060 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbfHVCSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 22:18:13 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i0cfX-0001S6-50; Wed, 21 Aug 2019 22:17:43 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 04/15] sched,fair: move runnable_load_avg to cfs_rq
Date:   Wed, 21 Aug 2019 22:17:29 -0400
Message-Id: <20190822021740.15554-5-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822021740.15554-1-riel@surriel.com>
References: <20190822021740.15554-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since only the root cfs_rq runnable_load_avg field is used any more,
we can move the field from struct sched_avg, which every sched_entity
has one of, directly into the struct cfs_rq, of which we have way fewer.

No functional changes.

Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 include/linux/sched.h | 1 -
 kernel/sched/debug.c  | 3 +--
 kernel/sched/fair.c   | 8 ++++----
 kernel/sched/sched.h  | 1 +
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f5bb6948e40c..84a6cc6f5c47 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -394,7 +394,6 @@ struct sched_avg {
 	u32				util_sum;
 	u32				period_contrib;
 	unsigned long			load_avg;
-	unsigned long			runnable_load_avg;
 	unsigned long			util_avg;
 	struct util_est			util_est;
 } ____cacheline_aligned;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index cefc1b171c0b..6e7c8ff210a8 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -539,7 +539,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %lu\n", "load_avg",
 			cfs_rq->avg.load_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "runnable_load_avg",
-			cfs_rq->avg.runnable_load_avg);
+			cfs_rq->runnable_load_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
 			cfs_rq->avg.util_avg);
 	SEQ_printf(m, "  .%-30s: %u\n", "util_est_enqueued",
@@ -960,7 +960,6 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.load_sum);
 	P(se.avg.util_sum);
 	P(se.avg.load_avg);
-	P(se.avg.runnable_load_avg);
 	P(se.avg.util_avg);
 	P(se.enqueued_h_load);
 	P(se.avg.last_update_time);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 30afeda1620f..a48d0dbfc232 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2768,7 +2768,7 @@ enqueue_runnable_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		struct cfs_rq *root_cfs_rq = &cfs_rq->rq->cfs;
 		se->enqueued_h_load = task_se_h_load(se);
 
-		root_cfs_rq->avg.runnable_load_avg += se->enqueued_h_load;
+		root_cfs_rq->runnable_load_avg += se->enqueued_h_load;
 	}
 }
 
@@ -2777,7 +2777,7 @@ dequeue_runnable_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	if (entity_is_task(se)) {
 		struct cfs_rq *root_cfs_rq = &cfs_rq->rq->cfs;
-		sub_positive(&root_cfs_rq->avg.runnable_load_avg,
+		sub_positive(&root_cfs_rq->runnable_load_avg,
 					se->enqueued_h_load);
 	}
 }
@@ -2795,7 +2795,7 @@ update_runnable_load_avg(struct sched_entity *se)
 
 	new_h_load = task_se_h_load(se);
 	delta = new_h_load - se->enqueued_h_load;
-	root_cfs_rq->avg.runnable_load_avg += delta;
+	root_cfs_rq->runnable_load_avg += delta;
 	se->enqueued_h_load = new_h_load;
 }
 
@@ -3561,7 +3561,7 @@ static void remove_entity_load_avg(struct sched_entity *se)
 
 static inline unsigned long cfs_rq_runnable_load_avg(struct cfs_rq *cfs_rq)
 {
-	return cfs_rq->avg.runnable_load_avg;
+	return cfs_rq->runnable_load_avg;
 }
 
 static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5be14cee61f9..32978a8de8ce 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -516,6 +516,7 @@ struct cfs_rq {
 	 * CFS load tracking
 	 */
 	struct sched_avg	avg;
+	unsigned long		runnable_load_avg;
 #ifndef CONFIG_64BIT
 	u64			load_last_update_time_copy;
 #endif
-- 
2.20.1

