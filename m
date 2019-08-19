Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 247B0948FD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 17:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfHSPsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 11:48:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47615 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfHSPpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:43 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqn-0006vJ-9x; Mon, 19 Aug 2019 17:45:41 +0200
Message-Id: <20190819143802.717400558@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:31:55 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 14/44] posix-cpu-timers: Rename thread_group_cputimer() and
 make it static
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thread_group_cputimer() is a complete misnomer. The function does two things:

 - For arming process wide timers it makes sure that the atomic time
   storage is up to date. If no cpu timer is armed yet, then the atomic
   time storage is not updated by the scheduler for performance reasons.

   In that case a full summing up of all threads needs to be done and the
   update needs to be enabled.

- Samples the current time into the caller supplied storage.

Rename it to thread_group_start_cputime(), make it static and fixup the
callsite.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched/cputime.h  |    1 -
 kernel/time/posix-cpu-timers.c |   17 +++++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -61,7 +61,6 @@ extern void cputime_adjust(struct task_c
  * Thread group CPU time accounting.
  */
 void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times);
-void thread_group_cputimer(struct task_struct *tsk, struct task_cputime *times);
 void thread_group_sample_cputime(struct task_struct *tsk, struct task_cputime *times);
 
 /*
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -253,7 +253,20 @@ void thread_group_sample_cputime(struct
 	sample_cputime_atomic(times, &cputimer->cputime_atomic);
 }
 
-void thread_group_cputimer(struct task_struct *tsk, struct task_cputime *times)
+/**
+ * thread_group_start_cputime - Start cputime and return a sample
+ * @tsk:	Task for which cputime needs to be started
+ * @iimes:	Storage for time samples
+ *
+ * The thread group cputime accouting is avoided when there are no posix
+ * CPU timers armed. Before starting a timer it's required to check whether
+ * the time accounting is active. If not, a full update of the atomic
+ * accounting store needs to be done and the accounting enabled.
+ *
+ * Updates @times with an uptodate sample of the thread group cputimes.
+ */
+static void
+thread_group_start_cputime(struct task_struct *tsk, struct task_cputime *times)
 {
 	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
 	struct task_cputime sum;
@@ -536,7 +549,7 @@ static int cpu_timer_sample_group(const
 {
 	struct task_cputime cputime;
 
-	thread_group_cputimer(p, &cputime);
+	thread_group_start_cputime(p, &cputime);
 	switch (CPUCLOCK_WHICH(which_clock)) {
 	default:
 		return -EINVAL;


