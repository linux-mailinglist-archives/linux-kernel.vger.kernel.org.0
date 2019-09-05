Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F3BAA2C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 14:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389245AbfIEMMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 08:12:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42708 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388911AbfIEMME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:12:04 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i5qcN-0007tP-Mf; Thu, 05 Sep 2019 14:12:03 +0200
Message-Id: <20190905120539.888798188@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 14:03:42 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 3/6] posix-cpu-timers: Restrict timer_create() permissions
References: <20190905120339.561100423@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now there is no restriction at all to attach a Posix CPU timer to any
process in the system. Per thread CPU timers are limited to be created by
threads in the same thread group.

Timers can be used to observe activity of tasks and also impose overhead on
the process to which they are attached because that process needs to do the
fine grained CPU time accounting.

Limit the ability to attach timers to a process by checking whether the
task which is creating the timer has permissions to attach ptrace on the
target process.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -6,6 +6,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/cputime.h>
 #include <linux/posix-timers.h>
+#include <linux/ptrace.h>
 #include <linux/errno.h>
 #include <linux/math64.h>
 #include <linux/uaccess.h>
@@ -78,7 +79,22 @@ static struct task_struct *lookup_task(c
 	/*
 	 * For processes require that p is group leader.
 	 */
-	return has_group_leader_pid(p) ? p : NULL;
+	if (!has_group_leader_pid(p))
+		return NULL;
+
+	/*
+	 * Avoid the ptrace overhead when this is current's process
+	 */
+	if (same_thread_group(p, current))
+		return p;
+
+	/*
+	 * Creating timers on processes which cannot be ptraced is not
+	 * permitted:
+	 */
+	if (!ptrace_may_access(p, PTRACE_MODE_ATTACH_REALCREDS))
+		return NULL;
+	return p;
 }
 
 static struct task_struct *__get_task_for_clock(const clockid_t clock,


