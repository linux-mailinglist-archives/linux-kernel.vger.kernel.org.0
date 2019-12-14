Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAFCB11F0C0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 08:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfLNHkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 02:40:10 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbfLNHkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 02:40:10 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8EF5C3EA7E02956B2F5C;
        Sat, 14 Dec 2019 15:40:05 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Sat, 14 Dec 2019 15:40:00 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] sched/debug: fix trival print task format
Date:   Sat, 14 Dec 2019 15:37:14 +0800
Message-ID: <20191214073714.52215-1-xiexiuqi@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure leave one space between state and task name.

w/o patch:
runnable tasks:
 S           task   PID         tree-key  switches  prio     wait
-----------------------------------------------------------------
 I    kworker/0:2   656     87693.884557      8255   120
 Sirq/10-ACPI:Ged   829         0.000000         3    49
 Sirq/11-ACPI:Ged   830         0.000000         3    49
 Sirq/50-arm-smmu   945         0.000000         3    49

with patch:
runnable tasks:
 S            task   PID         tree-key  switches  prio     wait
------------------------------------------------------------------
 I     kworker/0:2   656     87693.884557      8255   120
 S irq/10-ACPI:Ged   829         0.000000         3    49
 S irq/11-ACPI:Ged   830         0.000000         3    49
 S irq/50-arm-smmu   945         0.000000         3    49

---
v2:
 - fix a typo
 - simpler to add one space before print format

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 kernel/sched/debug.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f7e4579e746c..9ee6250cef0d 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -438,7 +438,7 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 	else
 		SEQ_printf(m, " %c", task_state_to_char(p));
 
-	SEQ_printf(m, "%15s %5d %9Ld.%06ld %9Ld %5d ",
+	SEQ_printf(m, " %15s %5d %9Ld.%06ld %9Ld %5d ",
 		p->comm, task_pid_nr(p),
 		SPLIT_NS(p->se.vruntime),
 		(long long)(p->nvcsw + p->nivcsw),
@@ -465,10 +465,10 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "runnable tasks:\n");
-	SEQ_printf(m, " S           task   PID         tree-key  switches  prio"
+	SEQ_printf(m, " S            task   PID         tree-key  switches  prio"
 		   "     wait-time             sum-exec        sum-sleep\n");
 	SEQ_printf(m, "-------------------------------------------------------"
-		   "----------------------------------------------------\n");
+		   "------------------------------------------------------\n");
 
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
-- 
2.20.1

