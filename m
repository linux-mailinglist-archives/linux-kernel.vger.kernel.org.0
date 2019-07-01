Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD0405A611
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 22:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfF1Ut7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 16:49:59 -0400
Received: from shelob.surriel.com ([96.67.55.147]:38464 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfF1Utg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 16:49:36 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hgxo6-0007TL-Le; Fri, 28 Jun 2019 16:49:18 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 06/10] sched,cfs: use explicit cfs_rq of parent se helper
Date:   Fri, 28 Jun 2019 16:49:09 -0400
Message-Id: <20190628204913.10287-7-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628204913.10287-1-riel@surriel.com>
References: <20190628204913.10287-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an explicit "cfs_rq of parent sched_entity" helper in a few
strategic places, where cfs_rq_of(se) may no longer point at the
right runqueue once we flatten the hierarchical cgroup runqueues.

No functional change.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/sched/fair.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e41feacc45d9..d48bff5118fc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -276,6 +276,15 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 	return grp->my_q;
 }
 
+/* runqueue owned by the parent entity; the root cfs_rq for a top level se */
+static inline struct cfs_rq *group_cfs_rq_of_parent(struct sched_entity *se)
+{
+	if (se->parent)
+		return group_cfs_rq(se->parent);
+
+	return cfs_rq_of(se);
+}
+
 static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
@@ -3297,7 +3306,7 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 
 	gcfs_rq->propagate = 0;
 
-	cfs_rq = cfs_rq_of(se);
+	cfs_rq = group_cfs_rq_of_parent(se);
 
 	add_tg_cfs_propagate(cfs_rq, gcfs_rq->prop_runnable_sum);
 
@@ -7778,7 +7787,7 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 
 	WRITE_ONCE(cfs_rq->h_load_next, NULL);
 	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
+		cfs_rq = group_cfs_rq_of_parent(se);
 		WRITE_ONCE(cfs_rq->h_load_next, se);
 		if (cfs_rq->last_h_load_update == now)
 			break;
@@ -7801,7 +7810,7 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 
 static unsigned long task_se_h_load(struct sched_entity *se)
 {
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+	struct cfs_rq *cfs_rq = group_cfs_rq_of_parent(se);
 
 	update_cfs_rq_h_load(cfs_rq);
 	return div64_ul(se->avg.load_avg * cfs_rq->h_load,
@@ -10148,7 +10157,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	struct sched_entity *se = &curr->se;
 
 	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
+		cfs_rq = group_cfs_rq_of_parent(se);
 		entity_tick(cfs_rq, se, queued);
 	}
 
-- 
2.20.1

