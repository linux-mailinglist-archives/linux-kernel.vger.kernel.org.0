Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 041B46B87A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 10:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfGQIoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 04:44:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52527 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfGQIoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:44:02 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hnfXc-0000rM-8D; Wed, 17 Jul 2019 10:44:00 +0200
Date:   Wed, 17 Jul 2019 10:43:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LAK <linux-arm-kernel@lists.infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] arm64: Avoid pointless schedule_preempt_irq() invocations
Message-ID: <alpine.DEB.2.21.1907171036490.1767@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When preempt_count is zero on return from interrupt then
schedule_preempt_irq() is invoked even if TIF_NEED_RESCHED is not set.

That does not make sense because schedule_preempt_irq() has to go through a
full __schedule() for nothing in that case.

Check TIF_NEED_RESCHED and invoke schedule_preempt_irq() only if set.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
Found while staring at some RT wrecakge in that area.
---
 arch/arm64/kernel/entry.S |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -680,6 +680,10 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKIN
 	orr	x24, x24, x0
 alternative_else_nop_endif
 	cbnz	x24, 1f				// preempt count != 0 || NMI return path
+
+	ldr	x0, [tsk, #TSK_TI_FLAGS]        // get flags
+	tbz	x0, #TIF_NEED_RESCHED, 1f      	// needs rescheduling?
+
 	bl	preempt_schedule_irq		// irq en/disable is done inside
 1:
 #endif
