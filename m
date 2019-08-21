Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 130C998487
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 21:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbfHUTat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 15:30:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57145 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729835AbfHUTaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:30:46 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WJf-00049a-Tx; Wed, 21 Aug 2019 21:30:44 +0200
Message-Id: <20190821192919.599658199@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:08:51 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 04/38] posix-cpu-timers: Provide quick sample function for
 itimer
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_itimer() needs a sample of the current thread group cputime. It invokes
thread_group_cputimer() - which is a misnomer. That function also starts
eventually the group cputime accouting which is bogus because the
accounting is already active when a timer is armed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched/cputime.h  |    2 +-
 kernel/time/posix-cpu-timers.c |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -62,7 +62,7 @@ extern void cputime_adjust(struct task_c
  */
 void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times);
 void thread_group_cputimer(struct task_struct *tsk, struct task_cputime *times);
-
+void thread_group_sample_cputime(struct task_struct *tsk, struct task_cputime *times);
 
 /*
  * The following are functions that support scheduler-internal time accounting.
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -232,6 +232,27 @@ static inline void sample_cputime_atomic
 	times->sum_exec_runtime = atomic64_read(&atomic_times->sum_exec_runtime);
 }
 
+/**
+ * thread_group_sample_cputime - Sample cputime for a given task
+ * @tsk:	Task for which cputime needs to be started
+ * @iimes:	Storage for time samples
+ *
+ * Called from sys_getitimer() to calculate the expiry time of an active
+ * timer. That means group cputime accounting is already active. Called
+ * with task sighand lock held.
+ *
+ * Updates @times with an uptodate sample of the thread group cputimes.
+ */
+void thread_group_sample_cputime(struct task_struct *tsk,
+				struct task_cputime *times)
+{
+	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
+
+	WARN_ON_ONCE(!cputimer->running);
+
+	sample_cputime_atomic(times, &cputimer->cputime_atomic);
+}
+
 void thread_group_cputimer(struct task_struct *tsk, struct task_cputime *times)
 {
 	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;


