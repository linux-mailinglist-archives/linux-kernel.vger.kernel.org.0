Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1043E98496
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 21:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbfHUTdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 15:33:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57137 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbfHUTao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:30:44 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WJe-00049N-SG; Wed, 21 Aug 2019 21:30:42 +0200
Message-Id: <20190821192919.505833418@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:08:50 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 03/38] posix-cpu-timers: Use common permission check in
 posix_cpu_timer_create()
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another copy of the same thing gone...

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -316,44 +316,15 @@ static int posix_cpu_clock_get(const clo
  */
 static int posix_cpu_timer_create(struct k_itimer *new_timer)
 {
-	int ret = 0;
-	const pid_t pid = CPUCLOCK_PID(new_timer->it_clock);
-	struct task_struct *p;
+	struct task_struct *p = get_task_for_clock(new_timer->it_clock);
 
-	if (CPUCLOCK_WHICH(new_timer->it_clock) >= CPUCLOCK_MAX)
+	if (!p)
 		return -EINVAL;
 
 	new_timer->kclock = &clock_posix_cpu;
-
 	INIT_LIST_HEAD(&new_timer->it.cpu.entry);
-
-	rcu_read_lock();
-	if (CPUCLOCK_PERTHREAD(new_timer->it_clock)) {
-		if (pid == 0) {
-			p = current;
-		} else {
-			p = find_task_by_vpid(pid);
-			if (p && !same_thread_group(p, current))
-				p = NULL;
-		}
-	} else {
-		if (pid == 0) {
-			p = current->group_leader;
-		} else {
-			p = find_task_by_vpid(pid);
-			if (p && !has_group_leader_pid(p))
-				p = NULL;
-		}
-	}
 	new_timer->it.cpu.task = p;
-	if (p) {
-		get_task_struct(p);
-	} else {
-		ret = -EINVAL;
-	}
-	rcu_read_unlock();
-
-	return ret;
+	return 0;
 }
 
 /*


