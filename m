Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D75576D926
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 04:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfGSCmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 22:42:53 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:34092 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726015AbfGSCmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 22:42:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TXF5rRz_1563504168;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TXF5rRz_1563504168)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Jul 2019 10:42:49 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] cputime: remove rq parameter for irqtime_account_process_tick func
Date:   Fri, 19 Jul 2019 10:42:41 +0800
Message-Id: <20190719024242.249429-1-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the per cpu rq in function directly is enough, don't need get and
pass it from outside as a parameter. That's make function neat.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Wanpeng Li <wanpeng.li@hotmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/cputime.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 2305ce89a26c..3aaf761ede81 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -355,7 +355,7 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
  * softirq as those do not count in task exec_runtime any more.
  */
 static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
-					 struct rq *rq, int ticks)
+					 int ticks)
 {
 	u64 other, cputime = TICK_NSEC * ticks;
 
@@ -381,7 +381,7 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 		account_system_index_time(p, cputime, CPUTIME_SOFTIRQ);
 	} else if (user_tick) {
 		account_user_time(p, cputime);
-	} else if (p == rq->idle) {
+	} else if (p == this_rq()->idle) {
 		account_idle_time(cputime);
 	} else if (p->flags & PF_VCPU) { /* System time or guest time */
 		account_guest_time(p, cputime);
@@ -392,14 +392,12 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 
 static void irqtime_account_idle_ticks(int ticks)
 {
-	struct rq *rq = this_rq();
-
-	irqtime_account_process_tick(current, 0, rq, ticks);
+	irqtime_account_process_tick(current, 0, ticks);
 }
 #else /* CONFIG_IRQ_TIME_ACCOUNTING */
 static inline void irqtime_account_idle_ticks(int ticks) { }
 static inline void irqtime_account_process_tick(struct task_struct *p, int user_tick,
-						struct rq *rq, int nr_ticks) { }
+						int nr_ticks) { }
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
 
 /*
@@ -475,13 +473,12 @@ void thread_group_cputime_adjusted(struct task_struct *p, u64 *ut, u64 *st)
 void account_process_tick(struct task_struct *p, int user_tick)
 {
 	u64 cputime, steal;
-	struct rq *rq = this_rq();
 
 	if (vtime_accounting_cpu_enabled())
 		return;
 
 	if (sched_clock_irqtime) {
-		irqtime_account_process_tick(p, user_tick, rq, 1);
+		irqtime_account_process_tick(p, user_tick, 1);
 		return;
 	}
 
@@ -495,7 +492,7 @@ void account_process_tick(struct task_struct *p, int user_tick)
 
 	if (user_tick)
 		account_user_time(p, cputime);
-	else if ((p != rq->idle) || (irq_count() != HARDIRQ_OFFSET))
+	else if ((p != this_rq()->idle) || (irq_count() != HARDIRQ_OFFSET))
 		account_system_time(p, HARDIRQ_OFFSET, cputime);
 	else
 		account_idle_time(cputime);
-- 
2.19.1.856.g8858448bb

