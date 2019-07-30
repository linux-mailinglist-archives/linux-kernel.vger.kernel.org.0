Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C61137B5D1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 00:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbfG3WlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 18:41:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58722 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388225AbfG3WlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:41:07 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsanb-0002Oa-3x; Wed, 31 Jul 2019 00:40:52 +0200
Message-Id: <20190730223828.874901027@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 31 Jul 2019 00:33:53 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>
Subject: [patch 5/7] posix-timers: Rework cancel retry loops
References: <20190730223348.409366334@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparatory step for adding the PREEMPT RT specific synchronization
mechanism to wait for a running timer callback, rework the timer cancel
retry loops so they call a common function. This allows trivial
substitution in one place.

Originally-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -805,6 +805,17 @@ static int common_hrtimer_try_to_cancel(
 	return hrtimer_try_to_cancel(&timr->it.real.timer);
 }
 
+static struct k_itimer *timer_wait_running(struct k_itimer *timer,
+					   unsigned long *flags)
+{
+	timer_t timer_id = READ_ONCE(timer->it_id);
+
+	unlock_timer(timer, *flags);
+	cpu_relax();
+	/* Relock the timer. It might be not longer hashed. */
+	return lock_timer(timer_id, flags);
+}
+
 /* Set a POSIX.1b interval timer. */
 int common_timer_set(struct k_itimer *timr, int flags,
 		     struct itimerspec64 *new_setting,
@@ -859,8 +870,9 @@ static int do_timer_settime(timer_t time
 
 	if (old_spec64)
 		memset(old_spec64, 0, sizeof(*old_spec64));
-retry:
+
 	timr = lock_timer(timer_id, &flags);
+retry:
 	if (!timr)
 		return -EINVAL;
 
@@ -870,11 +882,14 @@ static int do_timer_settime(timer_t time
 	else
 		error = kc->timer_set(timr, tmr_flags, new_spec64, old_spec64);
 
-	unlock_timer(timr, flags);
 	if (error == TIMER_RETRY) {
-		old_spec64 = NULL;	// We already got the old time...
+		// We already got the old time...
+		old_spec64 = NULL;
+		/* Unlocks and relocks the timer if it still exists */
+		timr = timer_wait_running(timr, &flags);
 		goto retry;
 	}
+	unlock_timer(timr, flags);
 
 	return error;
 }
@@ -951,13 +966,15 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 	struct k_itimer *timer;
 	unsigned long flags;
 
-retry_delete:
 	timer = lock_timer(timer_id, &flags);
+
+retry_delete:
 	if (!timer)
 		return -EINVAL;
 
-	if (timer_delete_hook(timer) == TIMER_RETRY) {
-		unlock_timer(timer, flags);
+	if (unlikely(timer_delete_hook(timer) == TIMER_RETRY)) {
+		/* Unlocks and relocks the timer if it still exists */
+		timer = timer_wait_running(timer, &flags);
 		goto retry_delete;
 	}
 


