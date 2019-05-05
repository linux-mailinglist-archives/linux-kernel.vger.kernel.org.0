Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36EC813F49
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2019 13:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfEEL6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 May 2019 07:58:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56850 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbfEEL63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 07:58:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 046DC168F;
        Sun,  5 May 2019 04:58:29 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E4943F5C1;
        Sun,  5 May 2019 04:58:27 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH 3/7] sched: fair.h: add a new cfs_rq_tg_path()
Date:   Sun,  5 May 2019 12:57:28 +0100
Message-Id: <20190505115732.9844-4-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190505115732.9844-1-qais.yousef@arm.com>
References: <20190505115732.9844-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new function will be used in later patches when introducing the new
PELT tracepoints.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/fair.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/sched/fair.h b/kernel/sched/fair.h
index 04c5c8c0e477..aa57e3cb2eaa 100644
--- a/kernel/sched/fair.h
+++ b/kernel/sched/fair.h
@@ -31,6 +31,18 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 	return grp->my_q;
 }
 
+static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
+{
+	int l = path ? len : 0;
+
+	if (cfs_rq && task_group_is_autogroup(cfs_rq->tg))
+		autogroup_path(cfs_rq->tg, path, l);
+	else if (cfs_rq && cfs_rq->tg->css.cgroup)
+		cgroup_path(cfs_rq->tg->css.cgroup, path, l);
+	else if (path)
+		strcpy(path, "(null)");
+}
+
 static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
@@ -173,6 +185,12 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 	return NULL;
 }
 
+static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
+{
+	if (path)
+		strcpy(path, "(null)");
+}
+
 static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	return true;
-- 
2.17.1

