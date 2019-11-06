Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E34F2251
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 00:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbfKFXIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 18:08:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45558 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfKFXIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 18:08:21 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSUPQ-0004ju-PF; Thu, 07 Nov 2019 00:08:17 +0100
Message-Id: <20191106224556.645603214@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 06 Nov 2019 22:55:42 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <darren@dvhart.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [patch 08/12] futex: Sanitize exit state handling
References: <20191106215534.241796846@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having a smp_mb() and an empty lock/unlock of task::pi_lock move
the state setting into to the lock section.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3703,16 +3703,19 @@ void futex_exit_done(struct task_struct
 
 void futex_exit_release(struct task_struct *tsk)
 {
-	tsk->futex_state = FUTEX_STATE_EXITING;
-	/*
-	 * Ensure that all new tsk->pi_lock acquisitions must observe
-	 * FUTEX_STATE_EXITING. Serializes against attach_to_pi_owner().
-	 */
-	smp_mb();
 	/*
-	 * Ensure that we must observe the pi_state in exit_pi_state_list().
+	 * Switch the state to FUTEX_STATE_EXITING under tsk->pi_lock.
+	 *
+	 * This ensures that all subsequent checks of tsk->futex_state in
+	 * attach_to_pi_owner() must observe FUTEX_STATE_EXITING with
+	 * tsk->pi_lock held.
+	 *
+	 * It guarantees also that a pi_state which was queued right before
+	 * the state change under tsk->pi_lock by a concurrent waiter must
+	 * be observed in exit_pi_state_list().
 	 */
 	raw_spin_lock_irq(&tsk->pi_lock);
+	tsk->futex_state = FUTEX_STATE_EXITING;
 	raw_spin_unlock_irq(&tsk->pi_lock);
 
 	futex_exec_release(tsk);


