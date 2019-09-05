Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892F5AA2C6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 14:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389282AbfIEMMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 08:12:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42722 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389227AbfIEMMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:12:06 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i5qcP-0007tl-5q; Thu, 05 Sep 2019 14:12:05 +0200
Message-Id: <20190905120540.162032542@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 14:03:45 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 6/6] posix-cpu-timers: Make PID=0 and PID=self handling
 consistent
References: <20190905120339.561100423@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the PID encoded into the clock id is 0 then the target is either the
calling thread itself or the process to which it belongs.

If the current thread encodes its own PID on a process wide clock then
there is no reason not to treat it in the same way as the PID=0 case.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -90,7 +90,14 @@ static struct task_struct *lookup_task(c
 
 	} else {
 		/*
-		 * For processes require that p is group leader.
+		 * Timer is going to be attached to a process. If p is
+		 * current then treat it like the PID=0 case above.
+		 */
+		if (p == current)
+			return current->group_leader;
+
+		/*
+		 * For foreign processes require that p is group leader.
 		 */
 		if (!has_group_leader_pid(p))
 			return NULL;


