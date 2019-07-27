Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B28377B71
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 21:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbfG0TSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 15:18:08 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43958 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfG0TSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 15:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1564255079; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aN0LkOEHW98v+tptgk3RNYOKGQkp5CctwsH80KkRwcg=;
        b=fcgXJXi8hnnP5oSfBBDooTYIob+QBOq3x6N8XnTCx5SKBpWMhQpl1pSG8G2HY6TkSeU1rq
        zUcqJXb22s8WZt6+4xTUnnuyd/GVJa/1+eDmX15DhWzgwXZLnYBpPmaC3uBfDrPntw0Mef
        sx0ZRMZj1lUjUV1SEu7F9BbLiELNb2I=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/4] irqchip: ingenic: Get virq number from IRQ domain
Date:   Sat, 27 Jul 2019 15:17:40 -0400
Message-Id: <20190727191741.30317-3-paul@crapouillou.net>
In-Reply-To: <20190727191741.30317-1-paul@crapouillou.net>
References: <20190727191741.30317-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the virq number from the IRQ domain instead of calculating it from
the hardcoded irq base.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/irqchip/irq-ingenic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index d97a3a500249..82a079fa3a3d 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -21,6 +21,7 @@
 
 struct ingenic_intc_data {
 	void __iomem *base;
+	struct irq_domain *domain;
 	unsigned num_chips;
 };
 
@@ -34,6 +35,7 @@ struct ingenic_intc_data {
 static irqreturn_t intc_cascade(int irq, void *data)
 {
 	struct ingenic_intc_data *intc = irq_get_handler_data(irq);
+	struct irq_domain *domain = intc->domain;
 	uint32_t irq_reg;
 	unsigned i;
 
@@ -43,7 +45,8 @@ static irqreturn_t intc_cascade(int irq, void *data)
 		if (!irq_reg)
 			continue;
 
-		generic_handle_irq(__fls(irq_reg) + (i * 32) + JZ4740_IRQ_BASE);
+		irq = irq_find_mapping(domain, __fls(irq_reg) + (i * 32));
+		generic_handle_irq(irq);
 	}
 
 	return IRQ_HANDLED;
@@ -95,6 +98,8 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		goto out_unmap_base;
 	}
 
+	intc->domain = domain;
+
 	for (i = 0; i < num_chips; i++) {
 		/* Mask all irqs */
 		writel(0xffffffff, intc->base + (i * CHIP_SIZE) +
-- 
2.21.0.593.g511ec345e18

