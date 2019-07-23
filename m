Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8509771194
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 08:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387987AbfGWGHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 02:07:51 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:34751 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729098AbfGWGHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:07:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TXc-Eyt_1563862068;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TXc-Eyt_1563862068)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jul 2019 14:07:48 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] cputime: fix a account error of softirq
Date:   Tue, 23 Jul 2019 14:01:40 +0800
Message-Id: <20190723060142.145747-1-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According the comments before this line:
 * ksoftirqd time do not get accounted in cpu_softirq_time.
And process in irqtime_account_irq()
I guess the original attempt is to account ksoftirqd into
system time instead of softirq time.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Wanpeng Li <wanpeng.li@hotmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/cputime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 2305ce89a26c..d78aee140957 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -378,7 +378,7 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 		 * So, we have to handle it separately here.
 		 * Also, p->stime needs to be updated for ksoftirqd.
 		 */
-		account_system_index_time(p, cputime, CPUTIME_SOFTIRQ);
+		account_system_index_time(p, cputime, CPUTIME_SYSTEM);
 	} else if (user_tick) {
 		account_user_time(p, cputime);
 	} else if (p == rq->idle) {
-- 
2.19.1.856.g8858448bb

