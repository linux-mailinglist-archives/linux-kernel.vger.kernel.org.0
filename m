Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD7353452D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 13:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfFDLPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 07:15:34 -0400
Received: from foss.arm.com ([217.140.101.70]:40576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727513AbfFDLPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:15:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C6A11688;
        Tue,  4 Jun 2019 04:15:16 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EF653F690;
        Tue,  4 Jun 2019 04:15:14 -0700 (PDT)
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
Subject: [PATCH v3 4/6] sched: Add new tracepoint to track pelt at se level
Date:   Tue,  4 Jun 2019 12:14:57 +0100
Message-Id: <20190604111459.2862-5-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604111459.2862-1-qais.yousef@arm.com>
References: <20190604111459.2862-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new tracepoint allows tracking PELT signals at sched_entity level.
Which is supported in CFS tasks and taskgroups only.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 include/trace/events/sched.h | 4 ++++
 kernel/sched/fair.c          | 1 +
 kernel/sched/pelt.c          | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 520b89d384ec..c7dd9bc7f001 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -617,6 +617,10 @@ DECLARE_TRACE(pelt_irq_tp,
 	TP_PROTO(struct rq *rq),
 	TP_ARGS(rq));
 
+DECLARE_TRACE(pelt_se_tp,
+	TP_PROTO(struct sched_entity *se),
+	TP_ARGS(se));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dee1338ec4a9..8e0015ebf109 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3354,6 +3354,7 @@ static inline int propagate_entity_load_avg(struct sched_entity *se)
 	update_tg_cfs_runnable(cfs_rq, se, gcfs_rq);
 
 	trace_pelt_cfs_tp(cfs_rq);
+	trace_pelt_se_tp(se);
 
 	return 1;
 }
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index c9d4945861a4..7f1a1f641866 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -267,6 +267,7 @@ int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 {
 	if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
 		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
+		trace_pelt_se_tp(se);
 		return 1;
 	}
 
@@ -280,6 +281,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
 
 		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
 		cfs_se_util_change(&se->avg);
+		trace_pelt_se_tp(se);
 		return 1;
 	}
 
-- 
2.17.1

