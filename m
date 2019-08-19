Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 608AF948E3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 17:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfHSPrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 11:47:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47767 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbfHSPpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:52 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqv-00070E-QG; Mon, 19 Aug 2019 17:45:49 +0200
Message-Id: <20190819143804.653518555@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:15 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 34/44] posix-cpu-timers: Remove cputime_expires
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last users of the magic struct cputime based expiry cache are
gone. Remove the leftovers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h   |    9 ++-------
 kernel/time/posix-cpu-timers.c |   10 ----------
 2 files changed, 2 insertions(+), 17 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -65,19 +65,14 @@ static inline int clockid_to_fd(const cl
 #ifdef CONFIG_POSIX_TIMERS
 /**
  * posix_cputimers - Container for posix CPU timer related data
- * @cputime_expires:	Earliest-expiration cache task_cputime based
  * @expiries:		Earliest-expiration cache array based
  * @cpu_timers:		List heads to queue posix CPU timers
  *
  * Used in task_struct and signal_struct
  */
 struct posix_cputimers {
-	/* Temporary union until all users are cleaned up */
-	union {
-		struct task_cputime	cputime_expires;
-		u64			expiries[CPUCLOCK_MAX];
-	};
-	struct list_head		cpu_timers[CPUCLOCK_MAX];
+	u64			expiries[CPUCLOCK_MAX];
+	struct list_head	cpu_timers[CPUCLOCK_MAX];
 };
 
 static inline void posix_cputimers_init(struct posix_cputimers *pct)
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -18,16 +18,6 @@
 
 #include "posix-timers.h"
 
-static inline void temporary_check(void)
-{
-	BUILD_BUG_ON(offsetof(struct task_cputime, stime) !=
-		     CPUCLOCK_PROF * sizeof(u64));
-	BUILD_BUG_ON(offsetof(struct task_cputime, utime) !=
-		     CPUCLOCK_VIRT * sizeof(u64));
-	BUILD_BUG_ON(offsetof(struct task_cputime, sum_exec_runtime) !=
-		     CPUCLOCK_SCHED * sizeof(u64));
-}
-
 static void posix_cpu_timer_rearm(struct k_itimer *timer);
 
 /*


