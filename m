Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7EE948FF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 17:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfHSPsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 11:48:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47611 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbfHSPpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:42 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqm-0006ux-O3; Mon, 19 Aug 2019 17:45:40 +0200
Message-Id: <20190819143802.610164797@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:31:54 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 13/44] posix-cpu-timers: Sample directly in timer check
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thread group accounting is active, otherwise the expiry function would
not be running. Sample the thread group time directly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -914,16 +914,17 @@ static void check_process_timers(struct
 	if (!READ_ONCE(tsk->signal->cputimer.running))
 		return;
 
-        /*
+       /*
 	 * Signify that a thread is checking for process timers.
 	 * Write access to this field is protected by the sighand lock.
 	 */
 	sig->cputimer.checking_timer = true;
 
 	/*
-	 * Collect the current process totals.
+	 * Collect the current process totals. Group accounting is active
+	 * so the sample can be taken directly.
 	 */
-	thread_group_cputimer(tsk, &cputime);
+	sample_cputime_atomic(&cputime, &sig->cputimer.cputime_atomic);
 	utime = cputime.utime;
 	ptime = utime + cputime.stime;
 	sum_sched_runtime = cputime.sum_exec_runtime;


