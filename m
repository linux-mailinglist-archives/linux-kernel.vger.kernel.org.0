Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216211472CA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 21:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgAWUll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 15:41:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729232AbgAWUjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 15:39:44 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C33E24673;
        Thu, 23 Jan 2020 20:39:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iujGR-000mWv-9l; Thu, 23 Jan 2020 15:39:43 -0500
Message-Id: <20200123203943.183615371@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 23 Jan 2020 15:39:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Julien Grall <julien.grall@arm.com>
Subject: [PATCH RT 06/30] KVM: arm/arm64: Let the timer expire in hardirq context on RT
References: <20200123203930.646725253@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19.94-rt39-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 719cc080c914045a6e35787bf4dc3ba91cfd3efb ]

The timers are canceled from an preempt-notifier which is invoked with
disabled preemption which is not allowed on PREEMPT_RT.
The timer callback is short so in could be invoked in hard-IRQ context
on -RT.

Let the timer expire on hard-IRQ context even on -RT.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Tested-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 virt/kvm/arm/arch_timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 17cecc96f735..217d39f40393 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -67,7 +67,7 @@ static inline bool userspace_irqchip(struct kvm *kvm)
 static void soft_timer_start(struct hrtimer *hrt, u64 ns)
 {
 	hrtimer_start(hrt, ktime_add_ns(ktime_get(), ns),
-		      HRTIMER_MODE_ABS);
+		      HRTIMER_MODE_ABS_HARD);
 }
 
 static void soft_timer_cancel(struct hrtimer *hrt, struct work_struct *work)
@@ -638,10 +638,10 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
 	vcpu_ptimer(vcpu)->cntvoff = 0;
 
 	INIT_WORK(&timer->expired, kvm_timer_inject_irq_work);
-	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 	timer->bg_timer.function = kvm_bg_timer_expire;
 
-	hrtimer_init(&timer->phys_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init(&timer->phys_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 	timer->phys_timer.function = kvm_phys_timer_expire;
 
 	vtimer->irq.irq = default_vtimer_irq.irq;
-- 
2.24.1


