Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 346F49C2B5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 11:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfHYJpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 05:45:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37970 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfHYJpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 05:45:14 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i1p5E-0004t5-FZ; Sun, 25 Aug 2019 11:45:12 +0200
Date:   Sun, 25 Aug 2019 09:43:00 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for 5.3-rc5
Message-ID: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

up to:  d0ff14fdc987: genirq: Properly pair kobject_del() with kobject_add()

A single fix for a imbalanced kobject operation in the irq decriptor code
which was unearthed by the new warnings in the kobject code.

Thanks,

	tglx

------------------>
Michael Kelley (1):
      genirq: Properly pair kobject_del() with kobject_add()


 kernel/irq/irqdesc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 9484e88dabc2..9be995fc3c5a 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -295,6 +295,18 @@ static void irq_sysfs_add(int irq, struct irq_desc *desc)
 	}
 }
 
+static void irq_sysfs_del(struct irq_desc *desc)
+{
+	/*
+	 * If irq_sysfs_init() has not yet been invoked (early boot), then
+	 * irq_kobj_base is NULL and the descriptor was never added.
+	 * kobject_del() complains about a object with no parent, so make
+	 * it conditional.
+	 */
+	if (irq_kobj_base)
+		kobject_del(&desc->kobj);
+}
+
 static int __init irq_sysfs_init(void)
 {
 	struct irq_desc *desc;
@@ -325,6 +337,7 @@ static struct kobj_type irq_kobj_type = {
 };
 
 static void irq_sysfs_add(int irq, struct irq_desc *desc) {}
+static void irq_sysfs_del(struct irq_desc *desc) {}
 
 #endif /* CONFIG_SYSFS */
 
@@ -438,7 +451,7 @@ static void free_desc(unsigned int irq)
 	 * The sysfs entry must be serialized against a concurrent
 	 * irq_sysfs_init() as well.
 	 */
-	kobject_del(&desc->kobj);
+	irq_sysfs_del(desc);
 	delete_irq_desc(irq);
 
 	/*


