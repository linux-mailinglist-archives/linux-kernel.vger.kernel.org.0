Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D61A4948C6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 17:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfHSPpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 11:45:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47652 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbfHSPpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:45 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqp-0006wB-0B; Mon, 19 Aug 2019 17:45:43 +0200
Message-Id: <20190819143803.099927430@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:31:59 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 18/44] posix-cpu-timers: Use clock ID in
 posix_cpu_timer_rearm()
References: <20190819143141.221906747@linutronix.de>
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


