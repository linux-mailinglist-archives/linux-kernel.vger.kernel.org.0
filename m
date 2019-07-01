Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1163F5991D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 13:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfF1LVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 07:21:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35293 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfF1LVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 07:21:49 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgows-000222-Mn; Fri, 28 Jun 2019 13:21:46 +0200
Message-Id: <20190628111440.279463375@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 28 Jun 2019 13:11:51 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Robert Hodaszi <Robert.Hodaszi@digi.com>
Subject: [patch V2 3/6] genirq: Add optional hardware synchronization for
 shutdown
References: <20190628111148.828731433@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_irq() ensures that no hardware interrupt handler is executing on a
different CPU before actually releasing resources and deactivating the
interrupt completely in a domain hierarchy.

But that does not catch the case where the interrupt is on flight at the
hardware level but not yet serviced by the target CPU. That creates an
interesing race condition:

   CPU 0                  CPU 1               IRQ CHIP

                                              interrupt is raised
                                              sent to CPU1
			  Unable to handle
			  immediately
			  (interrupts off,
			   deep idle delay)
   mask()
   ...
   free()
     shutdown()
     synchronize_irq()
     release_resources()
                          do_IRQ()
                            -> resources are not available

That might be harmless and just trigger a spurious interrupt warning, but
some interrupt chips might get into a wedged state.

Utilize the existing irq_get_irqchip_state() callback for the
synchronization in free_irq().

synchronize_hardirq() is not using this mechanism as it might actually
deadlock unter certain conditions, e.g. when called with interrupts
disabled and the target CPU is the one on which the synchronization is
invoked. synchronize_irq() uses it because that function cannot be called
from non preemtible contexts as it might sleep.

No functional change intended and according to Marc the existing GIC
implementations where the driver supports the callback should be able
to cope with that core change. Famous last words.

Fixes: 464d12309e1b ("x86/vector: Switch IOAPIC to global reservation mode")
Reported-by: Robert Hodaszi <Robert.Hodaszi@digi.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---

V2: Use irq_get_irqchip_state() instead of adding another one...

---
 kernel/irq/internals.h |    4 ++
 kernel/irq/manage.c    |   75 ++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 60 insertions(+), 19 deletions(-)

--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -97,6 +97,10 @@ static inline void irq_mark_irq(unsigned
 extern void irq_mark_irq(unsigned int irq);
 #endif
 
+extern int __irq_get_irqchip_state(struct irq_data *data,
+				   enum irqchip_irq_state which,
+				   bool *state);
+
 extern void init_kstat_irqs(struct irq_desc *desc, int node, int nr);
 
 irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags);
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -35,8 +35,9 @@ static int __init setup_forced_irqthread
 early_param("threadirqs", setup_forced_irqthreads);
 #endif
 
-static void __synchronize_hardirq(struct irq_desc *desc)
+static void __synchronize_hardirq(struct irq_desc *desc, bool sync_chip)
 {
+	struct irq_data *irqd = irq_desc_get_irq_data(desc);
 	bool inprogress;
 
 	do {
@@ -52,6 +53,20 @@ static void __synchronize_hardirq(struct
 		/* Ok, that indicated we're done: double-check carefully. */
 		raw_spin_lock_irqsave(&desc->lock, flags);
 		inprogress = irqd_irq_inprogress(&desc->irq_data);
+
+		/*
+		 * If requested and supported, check at the chip whether it
+		 * is in flight at the hardware level, i.e. already pending
+		 * in a CPU and waiting for service and acknowledge.
+		 */
+		if (!inprogress && sync_chip) {
+			/*
+			 * Ignore the return code. inprogress is only updated
+			 * when the chip supports it.
+			 */
+			__irq_get_irqchip_state(irqd, IRQCHIP_STATE_ACTIVE,
+						&inprogress);
+		}
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 		/* Oops, that failed? */
@@ -74,13 +89,18 @@ static void __synchronize_hardirq(struct
  *	Returns: false if a threaded handler is active.
  *
  *	This function may be called - with care - from IRQ context.
+ *
+ *	It does not check whether there is an interrupt on flight at the
+ *	hardware level, but not serviced yet, as this might deadlock when
+ *	called with interrupts disabled and the target CPU of the interrupt
+ *	is the current CPU.
  */
 bool synchronize_hardirq(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
 	if (desc) {
-		__synchronize_hardirq(desc);
+		__synchronize_hardirq(desc, false);
 		return !atomic_read(&desc->threads_active);
 	}
 
@@ -98,13 +118,17 @@ EXPORT_SYMBOL(synchronize_hardirq);
  *
  *	Can only be called from preemptible code as it might sleep when
  *	an interrupt thread is associated to @irq.
+ *
+ *	It optionally makes sure (when the irq chip supports that method)
+ *	that the interrupt is not pending in any CPU and waiting for
+ *	service.
  */
 void synchronize_irq(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
 	if (desc) {
-		__synchronize_hardirq(desc);
+		__synchronize_hardirq(desc, true);
 		/*
 		 * We made sure that no hardirq handler is
 		 * running. Now verify that no threaded handlers are
@@ -1730,8 +1754,12 @@ static struct irqaction *__free_irq(stru
 
 	unregister_handler_proc(irq, action);
 
-	/* Make sure it's not being used on another CPU: */
-	synchronize_hardirq(irq);
+	/*
+	 * Make sure it's not being used on another CPU and if the chip
+	 * supports it also make sure that there is no (not yet serviced)
+	 * interrupt on flight at the hardware level.
+	 */
+	__synchronize_hardirq(desc, true);
 
 #ifdef CONFIG_DEBUG_SHIRQ
 	/*
@@ -2589,6 +2617,28 @@ void teardown_percpu_nmi(unsigned int ir
 	irq_put_desc_unlock(desc, flags);
 }
 
+int __irq_get_irqchip_state(struct irq_data *data, enum irqchip_irq_state which,
+			    bool *state)
+{
+	struct irq_chip *chip;
+	int err = -EINVAL;
+
+	do {
+		chip = irq_data_get_irq_chip(data);
+		if (chip->irq_get_irqchip_state)
+			break;
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+		data = data->parent_data;
+#else
+		data = NULL;
+#endif
+	} while (data);
+
+	if (data)
+		err = chip->irq_get_irqchip_state(data, which, state);
+	return err;
+}
+
 /**
  *	irq_get_irqchip_state - returns the irqchip state of a interrupt.
  *	@irq: Interrupt line that is forwarded to a VM
@@ -2607,7 +2657,6 @@ int irq_get_irqchip_state(unsigned int i
 {
 	struct irq_desc *desc;
 	struct irq_data *data;
-	struct irq_chip *chip;
 	unsigned long flags;
 	int err = -EINVAL;
 
@@ -2617,19 +2666,7 @@ int irq_get_irqchip_state(unsigned int i
 
 	data = irq_desc_get_irq_data(desc);
 
-	do {
-		chip = irq_data_get_irq_chip(data);
-		if (chip->irq_get_irqchip_state)
-			break;
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
-		data = data->parent_data;
-#else
-		data = NULL;
-#endif
-	} while (data);
-
-	if (data)
-		err = chip->irq_get_irqchip_state(data, which, state);
+	err = __irq_get_irqchip_state(data, which, state);
 
 	irq_put_desc_busunlock(desc, flags);
 	return err;


