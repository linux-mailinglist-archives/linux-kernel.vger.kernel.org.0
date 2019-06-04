Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 583313452A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 13:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfFDLPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 07:15:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40592 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfFDLPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:15:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 788B8169E;
        Tue,  4 Jun 2019 04:15:18 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAAB93F690;
        Tue,  4 Jun 2019 04:15:16 -0700 (PDT)
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
Subject: [PATCH v3 5/6] sched: Add sched_overutilized tracepoint
Date:   Tue,  4 Jun 2019 12:14:58 +0100
Message-Id: <20190604111459.2862-6-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604111459.2862-1-qais.yousef@arm.com>
References: <20190604111459.2862-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new tracepoint allows us to track the changes in overutilized
status.

Overutilized status is associated with EAS. It indicates that the system
is in high performance state. EAS is disabled when the system is in this
state since there's not much energy savings while high performance tasks
are pushing the system to the limit and it's better to default to the
spreading behavior of the scheduler.

This tracepoint helps understanding and debugging the conditions under
which this happens.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 include/trace/events/sched.h |  4 ++++
 kernel/sched/fair.c          | 11 +++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index c7dd9bc7f001..edd96e04049f 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -621,6 +621,10 @@ DECLARE_TRACE(pelt_se_tp,
 	TP_PROTO(struct sched_entity *se),
 	TP_ARGS(se));
 
+DECLARE_TRACE(sched_overutilized_tp,
+	TP_PROTO(int overutilized, struct root_domain *rd),
+	TP_ARGS(overutilized, rd));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8e0015ebf109..e2418741608e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5179,8 +5179,10 @@ static inline bool cpu_overutilized(int cpu)
 
 static inline void update_overutilized_status(struct rq *rq)
 {
-	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
+	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
 		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
+		trace_sched_overutilized_tp(1, rq->rd);
+	}
 }
 #else
 static inline void update_overutilized_status(struct rq *rq) { }
@@ -8542,8 +8544,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
 		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
+
+		trace_sched_overutilized_tp(!!(sg_status & SG_OVERUTILIZED), rd);
 	} else if (sg_status & SG_OVERUTILIZED) {
-		WRITE_ONCE(env->dst_rq->rd->overutilized, SG_OVERUTILIZED);
+		struct root_domain *rd = env->dst_rq->rd;
+
+		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
+		trace_sched_overutilized_tp(1, rd);
 	}
 }
 
-- 
2.17.1

