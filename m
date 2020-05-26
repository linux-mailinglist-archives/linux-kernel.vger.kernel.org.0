Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFDC199909
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 16:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbgCaO4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 10:56:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46306 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbgCaO4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M3iZZ9XdnTzC9WaVpzkUyV5Li5vQ/KX3VC2mSf/zdQE=; b=jmmwHcaYqgkxezlT63UqFj8jQN
        Jq5a66LpEzj55rRgY8448z4pMuI260o+A+kSF96xVJCsqePAY0p+8qqA9P03KHmcCzCTuQCRi1a9B
        eh+qXVPULKX2Kw4sgj3yhsc5M0OPrycrBafN27k+c86R/pbQ+D8yTtXZH9LxT5OdYtATIWD83F1mR
        XdaNCR4jIsl0+RaqEctpsVDZnXwmZcIi2+pr2fYjHUz9iLUmeV7q3rlo0QKT7Ny3BHOKojAzWpXLJ
        rJRy/U05ZtvxnIyaw5BR5YzSTlKG3vi9WYEXOywOetThW5Hhxv31SH9zwC2mD3C7Q+oiTlmDsNl1D
        KJSkKs3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJIIR-0004dd-9g; Tue, 31 Mar 2020 14:55:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4E9C304DB2;
        Tue, 31 Mar 2020 16:55:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C570A29D71B7A; Tue, 31 Mar 2020 16:55:15 +0200 (CEST)
Date:   Tue, 31 Mar 2020 16:55:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 6/9] lockdep: Introduce wait-type checks
Message-ID: <20200331145515.GR20730@hirez.programming.kicks-ass.net>
References: <20200313174701.148376-1-bigeasy@linutronix.de>
 <20200313174701.148376-7-bigeasy@linutronix.de>
 <CAMuHMdU6s1F=DnaguZXrV4sWzEO-EqTaGQ=N7zyhgGq1M+Q1Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU6s1F=DnaguZXrV4sWzEO-EqTaGQ=N7zyhgGq1M+Q1Ug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 03:25:21PM +0200, Geert Uytterhoeven wrote:
> On arm64 (e.g. R-Car H3 ES2.0):
> 
> +=============================
> +[ BUG: Invalid wait context ]
> +5.6.0-salvator-x-09423-gb29514ba13a9c459-dirty #679 Not tainted
> +-----------------------------
> +swapper/5/0 is trying to lock:
> +ffffff86ff76f398 (&pool->lock){..-.}-{3:3}, at: __queue_work+0x134/0x430
> +other info that might help us debug this:
> +1 lock held by swapper/5/0:
> + #0: ffffffc01103a4a0 (rcu_read_lock){....}-{1:3}, at:
> rcu_lock_acquire.constprop.59+0x0/0x38
> +stack backtrace:
> +CPU: 5 PID: 0 Comm: swapper/5 Not tainted
> 5.6.0-salvator-x-09423-gb29514ba13a9c459-dirty #679
> +Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
> +Call trace:
> + dump_backtrace+0x0/0x180
> + show_stack+0x14/0x1c
> + dump_stack+0xdc/0x12c
> + __lock_acquire+0x37c/0xf9c
> + lock_acquire+0x258/0x288
> + _raw_spin_lock+0x34/0x48
> + __queue_work+0x134/0x430
> + queue_work_on+0x48/0x8c
> + timers_update_nohz+0x24/0x2c
> + tick_nohz_activate.isra.15.part.16+0x5c/0x80
> + tick_setup_sched_timer+0xe0/0xf0
> + hrtimer_run_queues+0x88/0xf8

So this is complaining that it cannot take pool->lock, which is
WAIT_CONFIG while holding RCU, which presents a WAIT_CONFIG context.

This seems to implicate something is amiss, because that should be
allowed. The thing it doesn't print is the context, which in the above
case is a (hrtimer) interrupt.

I suspect this really is a hardirq context and the next patch won't cure
things. It looks nohz (full?) related.

Frederic, can you untangle this?

---

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1511690e4de7..ac10db66cc63 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3952,10 +3952,36 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	return ret;
 }
 
+static inline short task_wait_context(struct task_struct *curr)
+{
+	/*
+	 * Set appropriate wait type for the context; for IRQs we have to take
+	 * into account force_irqthread as that is implied by PREEMPT_RT.
+	 */
+	if (curr->hardirq_context) {
+		/*
+		 * Check if force_irqthreads will run us threaded.
+		 */
+		if (curr->hardirq_threaded || curr->irq_config)
+			return LD_WAIT_CONFIG;
+
+		return LD_WAIT_SPIN;
+	} else if (curr->softirq_context) {
+		/*
+		 * Softirqs are always threaded.
+		 */
+		return LD_WAIT_CONFIG;
+	}
+
+	return LD_WAIT_MAX;
+}
+
 static int
 print_lock_invalid_wait_context(struct task_struct *curr,
 				struct held_lock *hlock)
 {
+	short curr_inner;
+
 	if (!debug_locks_off())
 		return 0;
 	if (debug_locks_silent)
@@ -3971,6 +3997,10 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 	print_lock(hlock);
 
 	pr_warn("other info that might help us debug this:\n");
+
+	curr_inner = task_wait_context(curr);
+	pr_warn("context-{%d:%d}\n", curr_inner, curr_inner);
+
 	lockdep_print_held_locks(curr);
 
 	pr_warn("stack backtrace:\n");
@@ -4017,26 +4047,7 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 	}
 	depth++;
 
-	/*
-	 * Set appropriate wait type for the context; for IRQs we have to take
-	 * into account force_irqthread as that is implied by PREEMPT_RT.
-	 */
-	if (curr->hardirq_context) {
-		/*
-		 * Check if force_irqthreads will run us threaded.
-		 */
-		if (curr->hardirq_threaded || curr->irq_config)
-			curr_inner = LD_WAIT_CONFIG;
-		else
-			curr_inner = LD_WAIT_SPIN;
-	} else if (curr->softirq_context) {
-		/*
-		 * Softirqs are always threaded.
-		 */
-		curr_inner = LD_WAIT_CONFIG;
-	} else {
-		curr_inner = LD_WAIT_MAX;
-	}
+	curr_inner = task_wait_context(curr);
 
 	for (; depth < curr->lockdep_depth; depth++) {
 		struct held_lock *prev = curr->held_locks + depth;
