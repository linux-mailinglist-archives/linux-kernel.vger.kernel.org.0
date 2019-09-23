Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCEDBB748
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 16:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501998AbfIWO4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 10:56:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58815 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731431AbfIWO4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:56:49 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iCPlf-0007am-2h; Mon, 23 Sep 2019 16:56:47 +0200
Message-Id: <20190923145528.856703803@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 23 Sep 2019 16:54:40 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michael Kerrisk <mtk.manpages@googlemail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch V2 5/6] posix-cpu-timers: Return PTR_ERR() from lookup_task()
References: <20190923145435.507024424@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for changing the return code to -EPERM when the ptrace
permission check fails, use PTR_ERR() to return the error information from
lookup_task() and fixup all call sites.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 kernel/time/posix-cpu-timers.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -63,7 +63,7 @@ static struct task_struct *lookup_task(c
 
 	p = find_task_by_vpid(pid);
 	if (!p)
-		return p;
+		return ERR_PTR(-EINVAL);
 
 	if (gettime) {
 		/*
@@ -103,11 +103,11 @@ static struct task_struct *lookup_task(c
 		 * the timer is destroyed.
 		 */
 		if (!has_group_leader_pid(p))
-			return NULL;
+			return ERR_PTR(-EINVAL);
 	}
 
 	/* Decide based on the ptrace permissions. */
-	return ptrace_may_access(p, mode) ? p : NULL;
+	return ptrace_may_access(p, mode) ? p : ERR_PTR(-EINVAL);
 }
 
 static struct task_struct *__get_task_for_clock(const clockid_t clock,
@@ -118,11 +118,11 @@ static struct task_struct *__get_task_fo
 	struct task_struct *p;
 
 	if (CPUCLOCK_WHICH(clock) >= CPUCLOCK_MAX)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	rcu_read_lock();
 	p = lookup_task(pid, thread, gettime);
-	if (p && getref)
+	if (!IS_ERR(p) && getref)
 		get_task_struct(p);
 	rcu_read_unlock();
 	return p;
@@ -140,7 +140,9 @@ static inline struct task_struct *get_ta
 
 static inline int validate_clock_permissions(const clockid_t clock)
 {
-	return __get_task_for_clock(clock, false, false) ? 0 : -EINVAL;
+	struct task_struct *res =  __get_task_for_clock(clock, false, false);
+
+	return IS_ERR(res) ? PTR_ERR(res) : 0;
 }
 
 /*
@@ -391,8 +393,8 @@ static int posix_cpu_clock_get(const clo
 	u64 t;
 
 	tsk = get_task_for_clock_get(clock);
-	if (!tsk)
-		return -EINVAL;
+	if (IS_ERR(tsk))
+		return PTR_ERR(tsk);
 
 	if (CPUCLOCK_PERTHREAD(clock))
 		t = cpu_clock_sample(clkid, tsk);
@@ -413,8 +415,8 @@ static int posix_cpu_timer_create(struct
 {
 	struct task_struct *p = get_task_for_clock(new_timer->it_clock);
 
-	if (!p)
-		return -EINVAL;
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	new_timer->kclock = &clock_posix_cpu;
 	timerqueue_init(&new_timer->it.cpu.node);


