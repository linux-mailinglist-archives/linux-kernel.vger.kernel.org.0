Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A76948C3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 17:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfHSPpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 11:45:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47566 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfHSPpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:40 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqj-0006tZ-IM; Mon, 19 Aug 2019 17:45:37 +0200
Message-Id: <20190819143801.846497772@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:31:46 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 05/44] posix-cpu-timers: Sanitize bogus WARNONS
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning when p == NULL and then proceeding and dereferencing p does not
make any sense as the kernel will crash with a NULL pointer dereference
right away.

Bailing out when p == NULL and returning an error code does not cure the
underlying problem which caused p to be NULL. Though it might allow to
do proper debugging.

Same applies to the clock id check in set_process_cpu_timer().

Clean them up and make them return without trying to do further damage.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -375,7 +375,8 @@ static int posix_cpu_timer_del(struct k_
 	struct sighand_struct *sighand;
 	struct task_struct *p = timer->it.cpu.task;
 
-	WARN_ON_ONCE(p == NULL);
+	if (WARN_ON_ONCE(!p))
+		return -EINVAL;
 
 	/*
 	 * Protect against sighand release/switch in exit/exec and process/
@@ -581,7 +582,8 @@ static int posix_cpu_timer_set(struct k_
 	u64 old_expires, new_expires, old_incr, val;
 	int ret;
 
-	WARN_ON_ONCE(p == NULL);
+	if (WARN_ON_ONCE(!p))
+		return -EINVAL;
 
 	/*
 	 * Use the to_ktime conversion because that clamps the maximum
@@ -716,10 +718,11 @@ static int posix_cpu_timer_set(struct k_
 
 static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp)
 {
-	u64 now;
 	struct task_struct *p = timer->it.cpu.task;
+	u64 now;
 
-	WARN_ON_ONCE(p == NULL);
+	if (WARN_ON_ONCE(!p))
+		return;
 
 	/*
 	 * Easy part: convert the reload time.
@@ -1001,12 +1004,13 @@ static void check_process_timers(struct
  */
 static void posix_cpu_timer_rearm(struct k_itimer *timer)
 {
+	struct task_struct *p = timer->it.cpu.task;
 	struct sighand_struct *sighand;
 	unsigned long flags;
-	struct task_struct *p = timer->it.cpu.task;
 	u64 now;
 
-	WARN_ON_ONCE(p == NULL);
+	if (WARN_ON_ONCE(!p))
+		return;
 
 	/*
 	 * Fetch the current sample and update the timer's expiry time.
@@ -1203,7 +1207,9 @@ void set_process_cpu_timer(struct task_s
 	u64 now;
 	int ret;
 
-	WARN_ON_ONCE(clock_idx == CPUCLOCK_SCHED);
+	if (WARN_ON_ONCE(clock_idx >= CPUCLOCK_SCHED))
+		return;
+
 	ret = cpu_timer_sample_group(clock_idx, tsk, &now);
 
 	if (oldval && ret != -EINVAL) {


