Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE82175B91
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 14:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgCBN1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 08:27:46 -0500
Received: from foss.arm.com ([217.140.110.172]:60880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbgCBN1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:27:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E6E8106F;
        Mon,  2 Mar 2020 05:27:42 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 056013F534;
        Mon,  2 Mar 2020 05:27:40 -0800 (PST)
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
Subject: [PATCH v3 4/6] sched/rt: Allow pulling unfitting task
Date:   Mon,  2 Mar 2020 13:27:19 +0000
Message-Id: <20200302132721.8353-5-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302132721.8353-1-qais.yousef@arm.com>
References: <20200302132721.8353-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When implemented RT Capacity Awareness; the logic was done such that if
a task was running on a fitting CPU, then it was sticky and we would try
our best to keep it there.

But as Steve suggested, to adhere to the strict priority rules of RT
class; allow pulling an RT task to unfitting CPU to ensure it gets a
chance to run ASAP.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Fixes: 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
LINK: https://lore.kernel.org/lkml/20200203111451.0d1da58f@oasis.local.home/
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/rt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3071c8612c03..e79a23ad4a93 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1656,8 +1656,7 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
 {
 	if (!task_running(rq, p) &&
-	    cpumask_test_cpu(cpu, p->cpus_ptr) &&
-	    rt_task_fits_capacity(p, cpu))
+	    cpumask_test_cpu(cpu, p->cpus_ptr))
 		return 1;
 
 	return 0;
-- 
2.17.1

