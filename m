Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 697E58EEB1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 16:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732731AbfHOOwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 10:52:03 -0400
Received: from foss.arm.com ([217.140.110.172]:45190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfHOOwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:52:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15FF2344;
        Thu, 15 Aug 2019 07:52:01 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 138523F706;
        Thu, 15 Aug 2019 07:51:59 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        tglx@linutronix.de, qais.yousef@arm.com
Subject: [PATCH v2 4/4] sched/fair: Prevent active LB from preempting higher sched classes
Date:   Thu, 15 Aug 2019 15:51:07 +0100
Message-Id: <20190815145107.5318-5-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815145107.5318-1-valentin.schneider@arm.com>
References: <20190815145107.5318-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CFS load balancer can cause the cpu_stopper to run a function to
try and steal a remote rq's running task. However, it so happens
that while only CFS tasks will ever be migrated by that function, we
can end up preempting higher sched class tasks, since it is executed
by the cpu_stopper.

This can potentially occur whenever a rq's running task is > CFS but
the rq has runnable CFS tasks.

Check the sched class of the remote rq's running task after we've
grabbed its lock. If it's CFS, carry on, otherwise run
detach_one_task() locally since we don't need the cpu_stopper (that
!CFS task is doing the exact same thing).

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8f5f6cad5008..bf4f7f43252f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8759,6 +8759,7 @@ static inline enum alb_status active_load_balance(struct lb_env *env)
 	enum alb_status status = cancelled;
 	struct sched_domain *sd = env->sd;
 	struct rq *busiest = env->src_rq;
+	struct task_struct *p = NULL;
 	unsigned long flags;
 
 	schedstat_inc(sd->lb_failed[env->idle]);
@@ -8780,6 +8781,16 @@ static inline enum alb_status active_load_balance(struct lb_env *env)
 	if (busiest->cfs.h_nr_running < 1)
 		goto unlock;
 
+	/*
+	 * If busiest->curr isn't CFS, then there's no point in running the
+	 * cpu_stopper. We can try to nab one CFS task though, since they're
+	 * all ready to be plucked.
+	 */
+	if (busiest->curr->sched_class != &fair_sched_class) {
+		p = detach_one_task(env);
+		goto unlock;
+	}
+
 	/*
 	 * Don't kick the active_load_balance_cpu_stop, if the curr task on
 	 * busiest CPU can't be moved to dst_cpu:
@@ -8803,7 +8814,9 @@ static inline enum alb_status active_load_balance(struct lb_env *env)
 unlock:
 	raw_spin_unlock_irqrestore(&busiest->lock, flags);
 
-	if (status == started)
+	if (p)
+		attach_one_task(env->dst_rq, p);
+	else if (status == started)
 		stop_one_cpu_nowait(cpu_of(busiest),
 				    active_load_balance_cpu_stop, busiest,
 				    &busiest->active_balance_work);
-- 
2.22.0

