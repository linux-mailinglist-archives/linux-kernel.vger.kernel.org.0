Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC6109848B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 21:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbfHUTa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 15:30:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57195 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbfHUTav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:30:51 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WJk-0004BM-Ts; Wed, 21 Aug 2019 21:30:49 +0200
Message-Id: <20190821192920.245357769@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:08:58 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 11/38] posix-cpu-timers: Use clock ID in
 posix_cpu_timer_rearm()
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract the clock ID (PROF/VIRT/SCHED) from the clock selector and use it
as argument to the sample functions. That allows to simplify them once all
callers are fixed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -987,6 +987,7 @@ static void check_process_timers(struct
  */
 static void posix_cpu_timer_rearm(struct k_itimer *timer)
 {
+	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	struct task_struct *p = timer->it.cpu.task;
 	struct sighand_struct *sighand;
 	unsigned long flags;
@@ -999,7 +1000,7 @@ static void posix_cpu_timer_rearm(struct
 	 * Fetch the current sample and update the timer's expiry time.
 	 */
 	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
-		cpu_clock_sample(timer->it_clock, p, &now);
+		cpu_clock_sample(clkid, p, &now);
 		bump_cpu_timer(timer, now);
 		if (unlikely(p->exit_state))
 			return;
@@ -1025,7 +1026,7 @@ static void posix_cpu_timer_rearm(struct
 			/* If the process is dying, no need to rearm */
 			goto unlock;
 		}
-		cpu_clock_sample_group(timer->it_clock, p, &now, true);
+		cpu_clock_sample_group(clkid, p, &now, true);
 		bump_cpu_timer(timer, now);
 		/* Leave the sighand locked for the call below.  */
 	}


