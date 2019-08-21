Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713349848C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 21:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfHUTca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 15:32:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57224 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfHUTay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:30:54 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WJo-0004CJ-GL; Wed, 21 Aug 2019 21:30:52 +0200
Message-Id: <20190821192920.639878168@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:09:02 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 15/38] posix-cpu-timers: Sample task times once in expiry
 check
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sampling the task times twice does not make sense. Do it once.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -785,9 +785,9 @@ static inline void check_dl_overrun(stru
 static void check_thread_timers(struct task_struct *tsk,
 				struct list_head *firing)
 {
-	struct list_head *timers = tsk->cpu_timers;
 	struct task_cputime *tsk_expires = &tsk->cputime_expires;
-	u64 expires;
+	struct list_head *timers = tsk->cpu_timers;
+	u64 expires, stime, utime;
 	unsigned long soft;
 
 	if (dl_task(tsk))
@@ -800,10 +800,12 @@ static void check_thread_timers(struct t
 	if (task_cputime_zero(&tsk->cputime_expires))
 		return;
 
-	expires = check_timers_list(timers, firing, prof_ticks(tsk));
+	task_cputime(tsk, &utime, &stime);
+
+	expires = check_timers_list(timers, firing, utime + stime);
 	tsk_expires->prof_exp = expires;
 
-	expires = check_timers_list(++timers, firing, virt_ticks(tsk));
+	expires = check_timers_list(++timers, firing, utime);
 	tsk_expires->virt_exp = expires;
 
 	tsk_expires->sched_exp = check_timers_list(++timers, firing,


