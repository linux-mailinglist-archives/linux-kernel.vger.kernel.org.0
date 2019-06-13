Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D8543790
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732798AbfFMPAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:00:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35413 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732598AbfFMOul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:50:41 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hbR3m-0002Ty-4J; Thu, 13 Jun 2019 16:50:38 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/6] workqueue: Don't assume that the callback has interrupts disabled
Date:   Thu, 13 Jun 2019 16:50:24 +0200
Message-Id: <20190613145027.27753-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613145027.27753-1-bigeasy@linutronix.de>
References: <20190613145027.27753-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the TIMER_IRQSAFE flag, the timer callback is invoked with
disabled interrupts. On -RT the callback is invoked in softirq context
with enabled interrupts. Since the interrupts are threaded, there are
are no in_irq() users. The local_bh_disable() around the threaded
handler ensures that there is either a timer or a threaded handler
active on the CPU.

Disable interrupts before __queue_work() is invoked from the timer
callback.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 601d61150b65d..a3c2959e5c4f0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1611,9 +1611,11 @@ EXPORT_SYMBOL_GPL(queue_work_node);
 void delayed_work_timer_fn(struct timer_list *t)
 {
 	struct delayed_work *dwork = from_timer(dwork, t, timer);
+	unsigned long flags;
 
-	/* should have been called from irqsafe timer with irq already off */
+	local_irq_save(flags);
 	__queue_work(dwork->cpu, dwork->wq, &dwork->work);
+	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(delayed_work_timer_fn);
 
-- 
2.20.1

