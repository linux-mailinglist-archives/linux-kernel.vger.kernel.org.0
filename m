Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6959C2B6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 11:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfHYJpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 05:45:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37976 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfHYJpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 05:45:14 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i1p5F-0004tF-5J; Sun, 25 Aug 2019 11:45:13 +0200
Date:   Sun, 25 Aug 2019 09:43:00 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for 5.3-rc5
References: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
Message-ID: <156672618029.19810.6692216639070045415.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

up to:  b0fdc01354f4: sched/core: Schedule new worker even if PI-blocked

Handle the worker management in situations where a task is scheduled out on
a PI lock contention correctly and schedule a new worker if possible.

Thanks,

	tglx

------------------>
Sebastian Andrzej Siewior (1):
      sched/core: Schedule new worker even if PI-blocked


 kernel/sched/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b037f195473..010d578118d6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3904,7 +3904,7 @@ void __noreturn do_task_dead(void)
 
 static inline void sched_submit_work(struct task_struct *tsk)
 {
-	if (!tsk->state || tsk_is_pi_blocked(tsk))
+	if (!tsk->state)
 		return;
 
 	/*
@@ -3920,6 +3920,9 @@ static inline void sched_submit_work(struct task_struct *tsk)
 		preempt_enable_no_resched();
 	}
 
+	if (tsk_is_pi_blocked(tsk))
+		return;
+
 	/*
 	 * If we are going to sleep and we have plugged IO queued,
 	 * make sure to submit it to avoid deadlocks.


