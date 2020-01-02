Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E80C712E4CF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 11:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgABKIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 05:08:15 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:55724 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728011AbgABKIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:08:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TmbxjSH_1577959688;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TmbxjSH_1577959688)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jan 2020 18:08:09 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] sched/cputime: move rq parameter in irqtime_account_process_tick
Date:   Thu,  2 Jan 2020 18:07:52 +0800
Message-Id: <1577959674-255537-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every time we call irqtime_account_process_tick() is in a interrupt,
Every caller will get and assign a parameter rq = this_rq(), This is
unnecessary and increase the code size a little bit. Move the rq getting
action to irqtime_account_process_tick internally is better.

             base               with this patch
cputime.o    578792 bytes        577888 bytes

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Wanpeng Li <wanpeng.li@hotmail.com>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/cputime.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index d43318a489f2..cff3e656566d 100644
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
@@ -473,13 +471,12 @@ void thread_group_cputime_adjusted(struct task_struct *p, u64 *ut, u64 *st)
 void account_process_tick(struct task_struct *p, int user_tick)
 {
 	u64 cputime, steal;
-	struct rq *rq = this_rq();
 
 	if (vtime_accounting_enabled_this_cpu())
 		return;
 
 	if (sched_clock_irqtime) {
-		irqtime_account_process_tick(p, user_tick, rq, 1);
+		irqtime_account_process_tick(p, user_tick, 1);
 		return;
 	}
 
@@ -493,7 +490,7 @@ void account_process_tick(struct task_struct *p, int user_tick)
 
 	if (user_tick)
 		account_user_time(p, cputime);
-	else if ((p != rq->idle) || (irq_count() != HARDIRQ_OFFSET))
+	else if ((p != this_rq()->idle) || (irq_count() != HARDIRQ_OFFSET))
 		account_system_time(p, HARDIRQ_OFFSET, cputime);
 	else
 		account_idle_time(cputime);
-- 
1.8.3.1

