Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 159BB9846F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 21:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfHUTbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 15:31:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57288 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbfHUTbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:31:03 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WJx-0004Eh-PH; Wed, 21 Aug 2019 21:31:01 +0200
Message-Id: <20190821192921.590362974@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:09:12 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 25/38] posix-cpu-timers: Provide array based sample
 functions
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using task_cputime and doing the addition of utime and stime at
all call sites, it's way simpler to have a sample array which allows
indexed based checks against the expiry cache array.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -202,6 +202,32 @@ static u64 cpu_clock_sample(const clocki
 	return 0;
 }
 
+static inline void store_samples(u64 *samples, u64 stime, u64 utime, u64 rtime)
+{
+	samples[CPUCLOCK_PROF] = stime + utime;
+	samples[CPUCLOCK_VIRT] = utime;
+	samples[CPUCLOCK_SCHED] = rtime;
+}
+
+static void task_sample_cputime(struct task_struct *p, u64 *samples)
+{
+	u64 stime, utime;
+
+	task_cputime(p, &utime, &stime);
+	store_samples(samples, stime, utime, p->se.sum_exec_runtime);
+}
+
+static void proc_sample_cputime_atomic(struct task_cputime_atomic *at,
+				       u64 *samples)
+{
+	u64 stime, utime, rtime;
+
+	utime = atomic64_read(&at->utime);
+	stime = atomic64_read(&at->stime);
+	rtime = atomic64_read(&at->sum_exec_runtime);
+	store_samples(samples, stime, utime, rtime);
+}
+
 /*
  * Set cputime to sum_cputime if sum_cputime > cputime. Use cmpxchg
  * to avoid race conditions with concurrent updates to cputime.


