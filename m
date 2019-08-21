Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAD198474
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 21:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfHUTbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 15:31:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57327 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbfHUTbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:31:08 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WK1-0004Fv-Sw; Wed, 21 Aug 2019 21:31:06 +0200
Message-Id: <20190821192922.078293002@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:09:17 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 30/38] posix-cpu-timers: Respect INFINITY for hard RTTIME
 limit
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTIME limit expiry code does not check the hard RTTIME limit for
INFINITY, i.e. being disabled.  Add it.

While this could be considered an ABI breakage if something would depend on
this behaviour. Though it's highly unlikely to have an effect because
RLIM_INFINITY is at minimum INT_MAX and the RTTIME limit is in seconds, so
the timer would fire after ~68 years.

Adding this obvious correct limit check also allows further consolidation
of that code and is a prerequisite for cleaning up the 0 based checks and
the rlimit setter code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Documented the theoretical ABI breakage in the changelong
---
 kernel/time/posix-cpu-timers.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -921,7 +921,7 @@ static void check_process_timers(struct
 		unsigned long hard = task_rlimit_max(tsk, RLIMIT_CPU);
 		unsigned long psecs = div_u64(ptime, NSEC_PER_SEC);
 
-		if (psecs >= hard) {
+		if (hard != RLIM_INFINITY && psecs >= hard) {
 			/*
 			 * At the hard limit, we just die.
 			 * No need to calculate anything else now.


