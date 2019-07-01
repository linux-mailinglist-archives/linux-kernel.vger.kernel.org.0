Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 803874303D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 21:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388532AbfFLTct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 15:32:49 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50414 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728328AbfFLTcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:32:48 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hb8z1-0001BN-Sn; Wed, 12 Jun 2019 15:32:31 -0400
From:   Rik van Riel <riel@surriel.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        dietmar.eggeman@arm.com, mgorman@techsingularity.com,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 2/8] sched: change /proc/sched_debug fields
Date:   Wed, 12 Jun 2019 15:32:21 -0400
Message-Id: <20190612193227.993-3-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190612193227.993-1-riel@surriel.com>
References: <20190612193227.993-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some fields from /proc/sched_debug that are removed from
sched_entity in a subsequent patch, and add h_load, which comes in
very handy to debug CPU controller weight distribution.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/sched/debug.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 678bfb9bd87f..aab4640d66c5 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -419,11 +419,9 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	}
 
 	P(se->load.weight);
-	P(se->runnable_weight);
 #ifdef CONFIG_SMP
 	P(se->avg.load_avg);
 	P(se->avg.util_avg);
-	P(se->avg.runnable_load_avg);
 #endif
 
 #undef PN_SCHEDSTAT
@@ -541,7 +539,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
 #ifdef CONFIG_SMP
-	SEQ_printf(m, "  .%-30s: %ld\n", "runnable_weight", cfs_rq->runnable_weight);
 	SEQ_printf(m, "  .%-30s: %lu\n", "load_avg",
 			cfs_rq->avg.load_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "runnable_load_avg",
@@ -550,17 +547,15 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->avg.util_avg);
 	SEQ_printf(m, "  .%-30s: %u\n", "util_est_enqueued",
 			cfs_rq->avg.util_est.enqueued);
-	SEQ_printf(m, "  .%-30s: %ld\n", "removed.load_avg",
-			cfs_rq->removed.load_avg);
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed.util_avg",
 			cfs_rq->removed.util_avg);
-	SEQ_printf(m, "  .%-30s: %ld\n", "removed.runnable_sum",
-			cfs_rq->removed.runnable_sum);
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	SEQ_printf(m, "  .%-30s: %lu\n", "tg_load_avg_contrib",
 			cfs_rq->tg_load_avg_contrib);
 	SEQ_printf(m, "  .%-30s: %ld\n", "tg_load_avg",
 			atomic_long_read(&cfs_rq->tg->load_avg));
+	SEQ_printf(m, "  .%-30s: %lu\n", "h_load",
+			cfs_rq->h_load);
 #endif
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -964,10 +959,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		   "nr_involuntary_switches", (long long)p->nivcsw);
 
 	P(se.load.weight);
-	P(se.runnable_weight);
 #ifdef CONFIG_SMP
 	P(se.avg.load_sum);
-	P(se.avg.runnable_load_sum);
 	P(se.avg.util_sum);
 	P(se.avg.load_avg);
 	P(se.avg.runnable_load_avg);
-- 
2.20.1

