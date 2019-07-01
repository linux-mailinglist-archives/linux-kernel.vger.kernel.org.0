Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F05413F4B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2019 13:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfEEL6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 May 2019 07:58:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56890 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727765AbfEEL6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 07:58:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 452481715;
        Sun,  5 May 2019 04:58:34 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BED303F5C1;
        Sun,  5 May 2019 04:58:32 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH 6/7] sched: Add sched_overutilized tracepoint
Date:   Sun,  5 May 2019 12:57:31 +0100
Message-Id: <20190505115732.9844-7-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190505115732.9844-1-qais.yousef@arm.com>
References: <20190505115732.9844-1-qais.yousef@arm.com>
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
 include/trace/events/sched.h | 4 ++++
 kernel/sched/fair.c          | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 0933c08cfc7e..d27733d9aed6 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -600,6 +600,10 @@ DECLARE_TRACE(sched_load_se,
 	TP_PROTO(int cpu, const char *path, struct sched_entity *se),
 	TP_ARGS(cpu, path, se));
 
+DECLARE_TRACE(sched_overutilized,
+	TP_PROTO(int overutilized),
+	TP_ARGS(overutilized));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3fd306079b57..75403918e158 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4965,8 +4965,10 @@ static inline bool cpu_overutilized(int cpu)
 
 static inline void update_overutilized_status(struct rq *rq)
 {
-	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
+	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
 		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
+		trace_sched_overutilized(1);
+	}
 }
 #else
 static inline void update_overutilized_status(struct rq *rq) { }
@@ -8330,8 +8332,11 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
 		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
+
+		trace_sched_overutilized(!!(sg_status & SG_OVERUTILIZED));
 	} else if (sg_status & SG_OVERUTILIZED) {
 		WRITE_ONCE(env->dst_rq->rd->overutilized, SG_OVERUTILIZED);
+		trace_sched_overutilized(1);
 	}
 }
 
-- 
2.17.1

