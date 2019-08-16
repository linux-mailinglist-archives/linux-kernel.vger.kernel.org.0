Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5E890569
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 18:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfHPQGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 12:06:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42672 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfHPQGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:06:31 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hyekG-0004Iy-7Z; Fri, 16 Aug 2019 18:06:28 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] sched/core: Schedule new worker even if PI-blocked
Date:   Fri, 16 Aug 2019 18:06:26 +0200
Message-Id: <20190816160626.12742-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a task is PI-blocked (blocking on sleeping spinlock) then we don't want =
to
schedule a new kworker if we schedule out due to lock contention because !RT
does not do that as well. A spinning spinlock disables preemption and a wor=
ker
does not schedule out on lock contention (but spin).

On RT the RW-semaphore implementation uses an rtmutex so
tsk_is_pi_blocked() will return true if a task blocks on it. In this case we
will now start a new worker which may deadlock if one worker is waiting on
progress from another worker. Since a RW-semaphore starts a new worker on !=
RT,
we should do the same on RT.

XFS is able to trigger this deadlock.

Allow to schedule new worker if the current worker is PI-blocked.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3945,7 +3945,7 @@ void __noreturn do_task_dead(void)
=20
 static inline void sched_submit_work(struct task_struct *tsk)
 {
-	if (!tsk->state || tsk_is_pi_blocked(tsk))
+	if (!tsk->state)
 		return;
=20
 	/*
@@ -3961,6 +3961,9 @@ static inline void sched_submit_work(str
 		preempt_enable_no_resched();
 	}
=20
+	if (tsk_is_pi_blocked(tsk))
+		return;
+
 	/*
 	 * If we are going to sleep and we have plugged IO queued,
 	 * make sure to submit it to avoid deadlocks.
