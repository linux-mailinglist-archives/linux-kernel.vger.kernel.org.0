Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF3C98477
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 21:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfHUTbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 15:31:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57356 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfHUTbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:31:11 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WK6-0004Gy-4x; Wed, 21 Aug 2019 21:31:10 +0200
Message-Id: <20190821192922.548747613@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:09:22 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 35/38] posix-cpu-timers: Remove pointless comparisons
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The soft RLIMIT expiry code checks whether the soft limit is greater than
the hard limit. That's pointless because if the soft RLIMIT is greater than
the hard RLIMIT then that code cannot be reached as the hard RLIMIT check
is before that and already killed the process.

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Fixup vs. the previous patch changes
---
 kernel/time/posix-cpu-timers.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -814,15 +814,14 @@ static void check_thread_timers(struct t
 			__group_send_sig_info(SIGKILL, SEND_SIG_PRIV, tsk);
 			return;
 		}
+
 		if (rtim >= soft) {
 			/*
 			 * At the soft limit, send a SIGXCPU every second.
 			 */
-			if (soft < hard) {
-				soft += USEC_PER_SEC;
-				tsk->signal->rlim[RLIMIT_RTTIME].rlim_cur =
-					soft;
-			}
+			soft += USEC_PER_SEC;
+			tsk->signal->rlim[RLIMIT_RTTIME].rlim_cur = soft;
+
 			if (print_fatal_signals) {
 				pr_info("RT Watchdog Timeout (soft): %s[%d]\n",
 					tsk->comm, task_pid_nr(tsk));
@@ -938,10 +937,9 @@ static void check_process_timers(struct
 					tsk->comm, task_pid_nr(tsk));
 			}
 			__group_send_sig_info(SIGXCPU, SEND_SIG_PRIV, tsk);
-			if (soft < hard) {
-				sig->rlim[RLIMIT_CPU].rlim_cur = soft + 1;
-				softns += NSEC_PER_SEC;
-			}
+
+			sig->rlim[RLIMIT_CPU].rlim_cur = soft + 1;
+			softns += NSEC_PER_SEC;
 		}
 
 		/* Update the expiry cache */


