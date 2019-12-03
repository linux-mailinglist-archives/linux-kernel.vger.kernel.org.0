Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A691103AF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 18:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfLCRhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 12:37:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55180 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLCRhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 12:37:47 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1icC7M-000569-03; Tue, 03 Dec 2019 18:37:44 +0100
Date:   Tue, 3 Dec 2019 18:37:43 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RT] powerpc: Fixup compile and lazy-preempt
Message-ID: <20191203173743.5mjvmhqfccdhwaon@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the softirq rework 32bit POWER does not compile because
get_current() is not provided - just the `current' macro.
Use the `current' instead.

Since the v5.2-RT series, the lazy-preempt code is broken. It loads the
lazy-counter and flags from the R9 but R2 should be used.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/kernel/entry_32.S | 4 ++--
 include/linux/preempt.h        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index d37b373104502..004944258387b 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -893,10 +893,10 @@ user_exc_return:		/* r10 contains MSR_KERNEL here */
 	bne	restore_kuap
 	andi.	r8,r8,_TIF_NEED_RESCHED
 	bne+	1f
-	lwz	r0,TI_PREEMPT_LAZY(r9)
+	lwz	r0,TI_PREEMPT_LAZY(r2)
 	cmpwi	0,r0,0          /* if non-zero, just restore regs and return */
 	bne	restore_kuap
-	lwz	r0,TI_FLAGS(r9)
+	lwz	r0,TI_FLAGS(r2)
 	andi.	r0,r0,_TIF_NEED_RESCHED_LAZY
 	beq+	restore_kuap
 1:
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index d559e3a0379c2..7653dd58b4b21 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -100,9 +100,9 @@
 				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
 #ifdef CONFIG_PREEMPT_RT_FULL
 
-#define softirq_count()		((long)get_current()->softirq_count)
+#define softirq_count()		(current->softirq_count)
 #define in_softirq()		(softirq_count())
-#define in_serving_softirq()	(get_current()->softirq_count & SOFTIRQ_OFFSET)
+#define in_serving_softirq()	(current->softirq_count & SOFTIRQ_OFFSET)
 
 #else
 
-- 
2.24.0

