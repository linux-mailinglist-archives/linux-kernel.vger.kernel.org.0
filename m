Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C699AC048
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 21:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406338AbfIFTOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 15:14:32 -0400
Received: from shelob.surriel.com ([96.67.55.147]:38236 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406263AbfIFTOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:14:09 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i6Jey-0003p8-IR; Fri, 06 Sep 2019 15:12:40 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 09/15] sched,fair: add helper functions for flattened runqueue
Date:   Fri,  6 Sep 2019 15:12:31 -0400
Message-Id: <20190906191237.27006-10-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906191237.27006-1-riel@surriel.com>
References: <20190906191237.27006-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper functions to make the flattened runqueue patch a little smaller.

The task_se_h_weight function is similar to task_se_h_load, but scales the
task weight by the group weight, without taking the task's duty cycle into
account.

The task_se_in_cgroup helper is functionally identical to parent_entity,
but directly calling a function with that name obscures what the other
code is trying to use it for, and would make the code harder to understand.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/sched/fair.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3e294e9c9994..08f7f627bdde 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -243,6 +243,7 @@ static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct load_weight
 
 const struct sched_class fair_sched_class;
 static unsigned long task_se_h_load(struct sched_entity *se);
+static unsigned long task_se_h_weight(struct sched_entity *se);
 
 /**************************************************************
  * CFS operations on generic schedulable entities:
@@ -431,6 +432,12 @@ static inline struct sched_entity *parent_entity(struct sched_entity *se)
 	return se->parent;
 }
 
+/* Is this (task) sched_entity in a non-root cgroup? */
+static inline bool task_se_in_cgroup(struct sched_entity *se)
+{
+	return parent_entity(se);
+}
+
 static void
 find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 {
@@ -513,6 +520,11 @@ static inline struct sched_entity *parent_entity(struct sched_entity *se)
 	return NULL;
 }
 
+static inline bool task_se_in_cgroup(struct sched_entity *se)
+{
+	return false;
+}
+
 static inline void
 find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 {
@@ -7853,6 +7865,20 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 	}
 }
 
+static unsigned long task_se_h_weight(struct sched_entity *se)
+{
+	struct cfs_rq *cfs_rq;
+
+	if (!task_se_in_cgroup(se))
+		return se->load.weight;
+
+	cfs_rq = group_cfs_rq_of_parent(se);
+	update_cfs_rq_h_load(cfs_rq);
+
+	/* Reduce the load.weight by the h_load of the group the task is in. */
+	return (cfs_rq->h_load * se->load.weight) >> SCHED_FIXEDPOINT_SHIFT;
+}
+
 static unsigned long task_se_h_load(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = group_cfs_rq_of_parent(se);
@@ -7889,6 +7915,11 @@ static unsigned long task_se_h_load(struct sched_entity *se)
 {
 	return se->avg.load_avg;
 }
+
+static unsigned long task_se_h_weight(struct sched_entity *se)
+{
+	return se->load.weight;
+}
 #endif
 
 /********** Helpers for find_busiest_group ************************/
-- 
2.20.1

