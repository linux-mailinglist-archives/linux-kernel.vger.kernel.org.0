Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D98B019CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 13:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfEJLck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 07:32:40 -0400
Received: from foss.arm.com ([217.140.101.70]:44522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfEJLci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:32:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9865B169E;
        Fri, 10 May 2019 04:32:38 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA9D23F6C4;
        Fri, 10 May 2019 04:32:36 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2 3/7] sched: fair.h: add a new cfs_rq_tg_path()
Date:   Fri, 10 May 2019 12:30:09 +0100
Message-Id: <20190510113013.1193-4-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510113013.1193-1-qais.yousef@arm.com>
References: <20190510113013.1193-1-qais.yousef@arm.com>
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
index 2e5aefaf56de..109dd068be78 100644
--- a/kernel/sched/fair.h
+++ b/kernel/sched/fair.h
@@ -33,6 +33,18 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
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
@@ -175,6 +187,12 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
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

