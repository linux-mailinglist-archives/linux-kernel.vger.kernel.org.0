Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2C085A60C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 22:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfF1Utg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 16:49:36 -0400
Received: from shelob.surriel.com ([96.67.55.147]:38548 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfF1Utg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 16:49:36 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hgxo6-0007TL-Nu; Fri, 28 Jun 2019 16:49:18 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 08/10] sched,fair: refactor enqueue/dequeue_entity
Date:   Fri, 28 Jun 2019 16:49:11 -0400
Message-Id: <20190628204913.10287-9-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628204913.10287-1-riel@surriel.com>
References: <20190628204913.10287-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor enqueue_entity, dequeue_entity, and update_load_avg, in order
to split out the things we still want to happen at every level in the
cgroup hierarchy with a flat runqueue from the things we only need to
happen once.

No functional changes.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/sched/fair.c | 64 +++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8da2823401ca..a751e7a9b228 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3480,7 +3480,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 #define DO_ATTACH	0x4
 
 /* Update task and its cfs_rq load average */
-static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+static inline bool update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	u64 now = cfs_rq_clock_pelt(cfs_rq);
 	int decayed;
@@ -3509,6 +3509,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	} else if (decayed && (flags & UPDATE_TG))
 		update_tg_load_avg(cfs_rq, 0);
+
+	return decayed;
 }
 
 #ifndef CONFIG_64BIT
@@ -3725,9 +3727,10 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 #define SKIP_AGE_LOAD	0x0
 #define DO_ATTACH	0x0
 
-static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
+static inline bool update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
 {
 	cfs_rq_util_change(cfs_rq, 0);
+	return false;
 }
 
 static inline void remove_entity_load_avg(struct sched_entity *se) {}
@@ -3850,6 +3853,24 @@ static inline void check_schedstat_required(void)
  * CPU and an up-to-date min_vruntime on the destination CPU.
  */
 
+static bool
+enqueue_entity_groups(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+{
+	/*
+	 * When enqueuing a sched_entity, we must:
+	 *   - Update loads to have both entity and cfs_rq synced with now.
+	 *   - Add its load to cfs_rq->runnable_avg
+	 *   - For group_entity, update its weight to reflect the new share of
+	 *     its group cfs_rq
+	 *   - Add its new weight to cfs_rq->load.weight
+	 */
+	if (!update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH))
+		return false;
+
+	update_cfs_group(se);
+	return true;
+}
+
 static void
 enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
@@ -3874,16 +3895,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	if (renorm && !curr)
 		se->vruntime += cfs_rq->min_vruntime;
 
-	/*
-	 * When enqueuing a sched_entity, we must:
-	 *   - Update loads to have both entity and cfs_rq synced with now.
-	 *   - Add its load to cfs_rq->runnable_avg
-	 *   - For group_entity, update its weight to reflect the new share of
-	 *     its group cfs_rq
-	 *   - Add its new weight to cfs_rq->load.weight
-	 */
-	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
-	update_cfs_group(se);
 	enqueue_runnable_load_avg(cfs_rq, se);
 	account_entity_enqueue(cfs_rq, se);
 
@@ -3950,14 +3961,9 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 
-static void
-dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+static bool
+dequeue_entity_groups(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
-	/*
-	 * Update run-time statistics of the 'current'.
-	 */
-	update_curr(cfs_rq);
-
 	/*
 	 * When dequeuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
@@ -3966,7 +3972,21 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
 	 */
-	update_load_avg(cfs_rq, se, UPDATE_TG);
+	if (!update_load_avg(cfs_rq, se, UPDATE_TG))
+		return false;
+	update_cfs_group(se);
+
+	return true;
+}
+
+static void
+dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+{
+	/*
+	 * Update run-time statistics of the 'current'.
+	 */
+	update_curr(cfs_rq);
+
 	dequeue_runnable_load_avg(cfs_rq, se);
 
 	update_stats_dequeue(cfs_rq, se, flags);
@@ -3990,8 +4010,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/* return excess runtime on last dequeue */
 	return_cfs_rq_runtime(cfs_rq);
 
-	update_cfs_group(se);
-
 	/*
 	 * Now advance min_vruntime if @se was the entity holding it back,
 	 * except when: DEQUEUE_SAVE && !DEQUEUE_MOVE, in this case we'll be
@@ -5156,6 +5174,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (se->on_rq)
 			break;
 		cfs_rq = cfs_rq_of(se);
+		enqueue_entity_groups(cfs_rq, se, flags);
 		enqueue_entity(cfs_rq, se, flags);
 
 		/*
@@ -5238,6 +5257,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
+		dequeue_entity_groups(cfs_rq, se, flags);
 		dequeue_entity(cfs_rq, se, flags);
 
 		/*
-- 
2.20.1

