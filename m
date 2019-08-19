Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FFC948FB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 17:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfHSPsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 11:48:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47657 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbfHSPpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:45 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqp-0006wW-Gb; Mon, 19 Aug 2019 17:45:43 +0200
Message-Id: <20190819143803.190250202@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:00 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 19/44] posix-cpu-timer: Remove pointless return value check
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_process_cpu_timer() checks already whether the clock id is valid. No
point in checking the return value of the sample function. That allows to
simplify the sample function later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1204,14 +1204,13 @@ void set_process_cpu_timer(struct task_s
 			   u64 *newval, u64 *oldval)
 {
 	u64 now;
-	int ret;
 
 	if (WARN_ON_ONCE(clock_idx >= CPUCLOCK_SCHED))
 		return;
 
-	ret = cpu_clock_sample_group(clock_idx, tsk, &now, true);
+	cpu_clock_sample_group(clock_idx, tsk, &now, true);
 
-	if (oldval && ret != -EINVAL) {
+	if (oldval) {
 		/*
 		 * We are setting itimer. The *oldval is absolute and we update
 		 * it to be relative, *newval argument is relative and we update


