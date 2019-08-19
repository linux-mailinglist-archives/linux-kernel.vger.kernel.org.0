Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81FB8948E1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 17:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfHSPrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 11:47:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47813 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbfHSPpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:54 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqy-00072L-V8; Mon, 19 Aug 2019 17:45:53 +0200
Message-Id: <20190819143805.221910859@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:21 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 40/44] posix-cpu-timers: Remove pointless comparisions
References: <20190819143141.221906747@linutronix.de>
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
 kernel/time/posix-cpu-timers.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -807,15 +807,14 @@ static void check_thread_timers(struct t
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
@@ -929,10 +928,9 @@ static void check_process_timers(struct
 					tsk->comm, task_pid_nr(tsk));
 			}
 			__group_send_sig_info(SIGXCPU, SEND_SIG_PRIV, tsk);
-			if (soft < hard) {
-				soft++;
-				sig->rlim[RLIMIT_CPU].rlim_cur = soft;
-			}
+
+			soft++;
+			sig->rlim[RLIMIT_CPU].rlim_cur = soft;
 		}
 
 		/* Update the expiry cache */


