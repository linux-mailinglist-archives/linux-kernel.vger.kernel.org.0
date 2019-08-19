Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE46948F2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 17:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfHSPpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 11:45:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47585 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbfHSPpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:40 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjql-0006uS-GM; Mon, 19 Aug 2019 17:45:39 +0200
Message-Id: <20190819143802.331782851@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:31:51 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 10/44] posix-cpu-timers: Use common permission check in
 posix_cpu_timer_create()
References: <20190819143141.221906747@linutronix.de>
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


