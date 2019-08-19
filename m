Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D572494902
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfHSPs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 11:48:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47589 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbfHSPpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:42 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjql-0006uf-TG; Mon, 19 Aug 2019 17:45:39 +0200
Message-Id: <20190819143802.423098617@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:31:52 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 11/44] posix-cpu-timers: Provide quick sample function for
 itimer
References: <20190819143141.221906747@linutronix.de>
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


