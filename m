Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC4B3BB74B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 16:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbfIWO44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 10:56:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58823 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfIWO4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:56:48 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iCPlf-0007as-Fz; Mon, 23 Sep 2019 16:56:47 +0200
Message-Id: <20190923145528.963075294@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 23 Sep 2019 16:54:41 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michael Kerrisk <mtk.manpages@googlemail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch V2 6/6] posix-cpu-timers: Return -EPERM if ptrace permission
 check fails
References: <20190923145435.507024424@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returning -EINVAL when a permission check fails is not really intuitive and
can cause hard to diagnose problems.

The POSIX specification for clock_gettime() and timer_create() requires to
obtain the clock id first by invoking clock_getcpuclockid().

clock_getcpuclockid() can return -EPERM if the caller does not have
permissions. That does not make sense in two aspects:

 - Nothing prevents the caller to make up a clockid and feed it into the
   syscalls

 - clock_getcpuclockid() is a helper function in glibc which just mangles
   the PID/TID bits to the proper place and glibc cannot do any permission
   checks at all for this function.

In order to prevent abuse the kernel has to do the permission checking in
timer_create() and clock_gettime(). Those functions have only -EINVAL as
documented return values, but returning -EINVAL for a valid clockid when
the permission check fails is not understandable for programmers.

So ignore the POSIX specification and return -EPERM when the ptrace
permission check fails.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch.

TODO: Update timer_create.2 and clock_gettime.2 manpages
---
 kernel/time/posix-cpu-timers.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -107,7 +107,7 @@ static struct task_struct *lookup_task(c
 	}
 
 	/* Decide based on the ptrace permissions. */
-	return ptrace_may_access(p, mode) ? p : ERR_PTR(-EINVAL);
+	return ptrace_may_access(p, mode) ? p : ERR_PTR(-EPERM);
 }
 
 static struct task_struct *__get_task_for_clock(const clockid_t clock,


