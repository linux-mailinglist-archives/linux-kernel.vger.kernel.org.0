Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D7D18EE88
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 04:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgCWDcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 23:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbgCWDcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 23:32:25 -0400
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58EF820777;
        Mon, 23 Mar 2020 03:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584934344;
        bh=mKhFScqksiFKsGX5adSdphlfjuvv2FRVmg9JYk1ha3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=szcB9L4R+X8ff+n3HayaS4HZkFOeX2xt5uiRy3mAwxNTUZ1xkAgQKj/uzqifUEvvz
         0QtrFW/uZC/SF8KQ5+O38UX4qHjMHEvUs5f5Z256TTIqDoBFFWGLI96xAnTy4ZEgo6
         UkZFz6UB3yx5+uooSF8IpjSDSdl9HL+kQtsLmrsQ=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 3/3] lockdep: Briefly comment current->hardirq_threadable usecases
Date:   Mon, 23 Mar 2020 04:32:07 +0100
Message-Id: <20200323033207.32370-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200323033207.32370-1-frederic@kernel.org>
References: <20200323033207.32370-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have yet to find a proper comment for rcu_iw_handler() though.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/posix-cpu-timers.c | 1 +
 kernel/time/tick-sched.c       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index d29a06d60206..85902d756e21 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1126,6 +1126,7 @@ void run_posix_cpu_timers(void)
 	if (!fastpath_timer_check(tsk))
 		return;
 
+	/* Should be offloaded to task_work at some future */
 	trace_hardirq_threadable();
 	if (!lock_task_sighand(tsk, &flags)) {
 		trace_hardirq_unthreadable();
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 3e2dc9b8858c..d469972673e4 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -245,6 +245,10 @@ static void nohz_full_kick_func(struct irq_work *work)
 
 static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
 	.func = nohz_full_kick_func,
+	/*
+	 * Must stay in hardirq. Threading would mess up with tick
+	 * dependencies.
+	 */
 	.flags = ATOMIC_INIT(IRQ_WORK_HARD_IRQ),
 };
 
-- 
2.25.0

