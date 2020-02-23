Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08977169978
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 19:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgBWSk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 13:40:26 -0500
Received: from foss.arm.com ([217.140.110.172]:50564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbgBWSkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 13:40:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9CB912FC;
        Sun, 23 Feb 2020 10:40:18 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFB983F703;
        Sun, 23 Feb 2020 10:40:16 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2 6/6] sched/rt: Remove unnecessary assignment in inc/dec_rt_migration
Date:   Sun, 23 Feb 2020 18:40:01 +0000
Message-Id: <20200223184001.14248-7-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200223184001.14248-1-qais.yousef@arm.com>
References: <20200223184001.14248-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The statement

	rt_rq = &rq_of_rt_rq(rt_rq)->rt

Was just dereferencing rt_rq to get a pointer to itself. Which is a NOP.
Remove it.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/rt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index b35e49cdafcc..520e84993fe7 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -343,7 +343,6 @@ static void inc_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 		return;
 
 	p = rt_task_of(rt_se);
-	rt_rq = &rq_of_rt_rq(rt_rq)->rt;
 
 	rt_rq->rt_nr_total++;
 	if (p->nr_cpus_allowed > 1) {
@@ -368,7 +367,6 @@ static void dec_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 		return;
 
 	p = rt_task_of(rt_se);
-	rt_rq = &rq_of_rt_rq(rt_rq)->rt;
 
 	rt_rq->rt_nr_total--;
 	if (p->nr_cpus_allowed > 1) {
-- 
2.17.1

