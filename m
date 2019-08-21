Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6338B9848E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 21:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbfHUTck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 15:32:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57209 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730017AbfHUTax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:30:53 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WJm-0004Br-Mf; Wed, 21 Aug 2019 21:30:50 +0200
Message-Id: <20190821192920.430475832@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:09:00 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 13/38] posix-cpu-timers: Simplify sample functions
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers hand in a valdiated clock id. Remove the return value which was
unchecked in most places anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -180,14 +180,12 @@ posix_cpu_clock_set(const clockid_t cloc
 }
 
 /*
- * Sample a per-thread clock for the given task.
+ * Sample a per-thread clock for the given task. clkid is validated.
  */
-static int cpu_clock_sample(const clockid_t which_clock,
-			    struct task_struct *p, u64 *sample)
+static void cpu_clock_sample(const clockid_t clkid, struct task_struct *p,
+			     u64 *sample)
 {
-	switch (CPUCLOCK_WHICH(which_clock)) {
-	default:
-		return -EINVAL;
+	switch (clkid) {
 	case CPUCLOCK_PROF:
 		*sample = prof_ticks(p);
 		break;
@@ -197,8 +195,9 @@ static int cpu_clock_sample(const clocki
 	case CPUCLOCK_SCHED:
 		*sample = task_sched_runtime(p);
 		break;
+	default:
+		WARN_ON_ONCE(1);
 	}
-	return 0;
 }
 
 /*
@@ -297,11 +296,11 @@ thread_group_start_cputime(struct task_s
  * Sample a process (thread group) clock for the given task clkid. If the
  * group's cputime accounting is already enabled, read the atomic
  * store. Otherwise a full update is required.  Task's sighand lock must be
- * held to protect the task traversal on a full update.
+ * held to protect the task traversal on a full update. clkid is already
+ * validated.
  */
-static int cpu_clock_sample_group(const clockid_t which_clock,
-				  struct task_struct *p,
-				  u64 *sample, bool start)
+static void cpu_clock_sample_group(const clockid_t clkid, struct task_struct *p,
+				   u64 *sample, bool start)
 {
 	struct thread_group_cputimer *cputimer = &p->signal->cputimer;
 	struct task_cputime cputime;
@@ -315,9 +314,7 @@ static int cpu_clock_sample_group(const
 		sample_cputime_atomic(&cputime, &cputimer->cputime_atomic);
 	}
 
-	switch (CPUCLOCK_WHICH(which_clock)) {
-	default:
-		return -EINVAL;
+	switch (clkid) {
 	case CPUCLOCK_PROF:
 		*sample = cputime.utime + cputime.stime;
 		break;
@@ -327,8 +324,9 @@ static int cpu_clock_sample_group(const
 	case CPUCLOCK_SCHED:
 		*sample = cputime.sum_exec_runtime;
 		break;
+	default:
+		WARN_ON_ONCE(1);
 	}
-	return 0;
 }
 
 static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)


