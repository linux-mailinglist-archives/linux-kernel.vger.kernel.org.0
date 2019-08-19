Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D433F948C8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 17:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfHSPqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 11:46:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47687 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfHSPpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:47 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqr-0006xO-C2; Mon, 19 Aug 2019 17:45:45 +0200
Message-Id: <20190819143803.571077991@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:04 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 23/44] posix-cpu-timers: Move prof/virt_ticks into caller
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions have only one caller left. No point in having them.

Move the almost duplicated code into the caller and simplify it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -130,23 +130,6 @@ static inline int task_cputime_zero(cons
 	return 0;
 }
 
-static inline u64 prof_ticks(struct task_struct *p)
-{
-	u64 utime, stime;
-
-	task_cputime(p, &utime, &stime);
-
-	return utime + stime;
-}
-static inline u64 virt_ticks(struct task_struct *p)
-{
-	u64 utime, stime;
-
-	task_cputime(p, &utime, &stime);
-
-	return utime;
-}
-
 static int
 posix_cpu_clock_getres(const clockid_t which_clock, struct timespec64 *tp)
 {
@@ -184,13 +167,18 @@ posix_cpu_clock_set(const clockid_t cloc
  */
 static u64 cpu_clock_sample(const clockid_t clkid, struct task_struct *p)
 {
+	u64 utime, stime;
+
+	if (clkid == CPUCLOCK_SCHED)
+		return task_sched_runtime(p);
+
+	task_cputime(p, &utime, &stime);
+
 	switch (clkid) {
 	case CPUCLOCK_PROF:
-		return prof_ticks(p);
+		return utime + stime;
 	case CPUCLOCK_VIRT:
-		return virt_ticks(p);
-	case CPUCLOCK_SCHED:
-		return task_sched_runtime(p);
+		return utime;
 	default:
 		WARN_ON_ONCE(1);
 	}


