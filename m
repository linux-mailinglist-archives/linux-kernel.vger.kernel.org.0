Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDBC77B70
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 21:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388172AbfG0TSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 15:18:01 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43940 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfG0TSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 15:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1564255075; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TeqaMLJ9L2BHCxtg1qBbox/UTQnlkaNPBdfq7hutPgA=;
        b=D2ZpB/ed9JboSeaNs5NNk1x9UnqCgvmNUToiOG4OJ8EqJsfn2etO3sCDDZ8PhUIYwrvX2T
        dGOFZvqqmN4ObXj44DyPohokgly7/dExDr5jW52NVVz8RSSA39XXrmfUgMcfiilgo5fjvN
        SJYmaid8b9hqbHCWBrRvGB/HFmobjXA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/4] irqchip: ingenic: Error out if IRQ domain creation failed
Date:   Sat, 27 Jul 2019 15:17:39 -0400
Message-Id: <20190727191741.30317-2-paul@crapouillou.net>
In-Reply-To: <20190727191741.30317-1-paul@crapouillou.net>
References: <20190727191741.30317-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we cannot create the IRQ domain, the driver should fail to probe
instead of succeeding with just a warning message.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/irqchip/irq-ingenic.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index 06fa810e89bb..d97a3a500249 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -87,6 +87,14 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		goto out_unmap_irq;
 	}
 
+	domain = irq_domain_add_legacy(node, num_chips * 32,
+				       JZ4740_IRQ_BASE, 0,
+				       &irq_domain_simple_ops, NULL);
+	if (!domain) {
+		err = -ENOMEM;
+		goto out_unmap_base;
+	}
+
 	for (i = 0; i < num_chips; i++) {
 		/* Mask all irqs */
 		writel(0xffffffff, intc->base + (i * CHIP_SIZE) +
@@ -112,14 +120,11 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 				       IRQ_NOPROBE | IRQ_LEVEL);
 	}
 
-	domain = irq_domain_add_legacy(node, num_chips * 32, JZ4740_IRQ_BASE, 0,
-				       &irq_domain_simple_ops, NULL);
-	if (!domain)
-		pr_warn("unable to register IRQ domain\n");
-
 	setup_irq(parent_irq, &intc_cascade_action);
 	return 0;
 
+out_unmap_base:
+	iounmap(intc->base);
 out_unmap_irq:
 	irq_dispose_mapping(parent_irq);
 out_free:
-- 
2.21.0.593.g511ec345e18

