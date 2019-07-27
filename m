Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8F877B6F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 21:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388068AbfG0TRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 15:17:54 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43894 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfG0TRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 15:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1564255072; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=K8lbvtW0OZ0d0LuxNkQz4JumZZZ/lfQdM+i8FRtHIK4=;
        b=q9ca4+YtpHjxY3ato2Zz1wcttBjUS9OOfqtT0H5IQFeKgGe3o82ILmz2dAnR4wKuMejbrY
        2A45CsJZvDxZp6mY+HRdagjapKJ/VHeHKUMJX+Xb3zGLQnTQll/s/KbPBuDPDFNlsfVjvQ
        yl4yzHUcu5Z5djD8P/OIy5MCmkuBKLE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/4] irqchip: ingenic: Drop redundant irq_suspend / irq_resume functions
Date:   Sat, 27 Jul 2019 15:17:38 -0400
Message-Id: <20190727191741.30317-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same behaviour can be obtained by using the IRQCHIP_MASK_ON_SUSPEND
flag on the IRQ chip.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/irqchip/irq-ingenic.c   | 24 +-----------------------
 include/linux/irqchip/ingenic.h | 14 --------------
 2 files changed, 1 insertion(+), 37 deletions(-)
 delete mode 100644 include/linux/irqchip/ingenic.h

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index f126255b3260..06fa810e89bb 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -10,7 +10,6 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/irqchip.h>
-#include <linux/irqchip/ingenic.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/timex.h>
@@ -50,26 +49,6 @@ static irqreturn_t intc_cascade(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void intc_irq_set_mask(struct irq_chip_generic *gc, uint32_t mask)
-{
-	struct irq_chip_regs *regs = &gc->chip_types->regs;
-
-	writel(mask, gc->reg_base + regs->enable);
-	writel(~mask, gc->reg_base + regs->disable);
-}
-
-void ingenic_intc_irq_suspend(struct irq_data *data)
-{
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	intc_irq_set_mask(gc, gc->wake_active);
-}
-
-void ingenic_intc_irq_resume(struct irq_data *data)
-{
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	intc_irq_set_mask(gc, gc->mask_cache);
-}
-
 static struct irqaction intc_cascade_action = {
 	.handler = intc_cascade,
 	.name = "SoC intc cascade interrupt",
@@ -127,8 +106,7 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		ct->chip.irq_mask = irq_gc_mask_disable_reg;
 		ct->chip.irq_mask_ack = irq_gc_mask_disable_reg;
 		ct->chip.irq_set_wake = irq_gc_set_wake;
-		ct->chip.irq_suspend = ingenic_intc_irq_suspend;
-		ct->chip.irq_resume = ingenic_intc_irq_resume;
+		ct->chip.flags = IRQCHIP_MASK_ON_SUSPEND;
 
 		irq_setup_generic_chip(gc, IRQ_MSK(32), 0, 0,
 				       IRQ_NOPROBE | IRQ_LEVEL);
diff --git a/include/linux/irqchip/ingenic.h b/include/linux/irqchip/ingenic.h
deleted file mode 100644
index 146558853ad4..000000000000
--- a/include/linux/irqchip/ingenic.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- */
-
-#ifndef __LINUX_IRQCHIP_INGENIC_H__
-#define __LINUX_IRQCHIP_INGENIC_H__
-
-#include <linux/irq.h>
-
-extern void ingenic_intc_irq_suspend(struct irq_data *data);
-extern void ingenic_intc_irq_resume(struct irq_data *data);
-
-#endif
-- 
2.21.0.593.g511ec345e18

