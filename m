Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 657F198466
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 21:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbfHUTa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 15:30:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57203 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730013AbfHUTav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:30:51 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WJl-0004Bb-Qj; Wed, 21 Aug 2019 21:30:49 +0200
Message-Id: <20190821192920.339725769@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:08:59 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 12/38] posix-cpu-timers: Remove pointless return value check
References: <20190821190847.665673890@linutronix.de>
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
@@ -1190,14 +1190,13 @@ void set_process_cpu_timer(struct task_s
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


