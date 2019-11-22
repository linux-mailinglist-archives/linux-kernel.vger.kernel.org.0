Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0E4107677
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 18:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKVRco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 12:32:44 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:60942 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVRco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1574443958; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=BsOlL8/XnAfBK2QWU/Rb8R+YHIlHTHWMA7vYLcPK6P4=;
        b=xUysZIDD4Y+vkE/VuxZOdjQSSU8ChF6w8FCgueySeFOa2xV+1ja90PRNNCo8J7j4r3+lKQ
        mg/Npq4h8MEhpKGeRygQOrgrroWkrOajSwf5w4GkVTWA47zpf+vZ+hGq/db1LrLp5OvChx
        /tzKtQCj9eAnOBY8b391vLQcoiF02VE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] irqchip: ingenic: Get rid of the legacy IRQ domain
Date:   Fri, 22 Nov 2019 18:32:33 +0100
Message-Id: <20191122173233.105225-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of the legacy IRQ domain and hardcoded IRQ base, since all the
Ingenic drivers and platform code have been updated to use devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/irqchip/irq-ingenic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index 01d18b39069e..c5589ee0dfb3 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -17,7 +17,6 @@
 #include <linux/delay.h>
 
 #include <asm/io.h>
-#include <asm/mach-jz4740/irq.h>
 
 struct ingenic_intc_data {
 	void __iomem *base;
@@ -50,7 +49,7 @@ static irqreturn_t intc_cascade(int irq, void *data)
 		while (pending) {
 			int bit = __fls(pending);
 
-			irq = irq_find_mapping(domain, bit + (i * 32));
+			irq = irq_linear_revmap(domain, bit + (i * 32));
 			generic_handle_irq(irq);
 			pending &= ~BIT(bit);
 		}
@@ -97,8 +96,7 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		goto out_unmap_irq;
 	}
 
-	domain = irq_domain_add_legacy(node, num_chips * 32,
-				       JZ4740_IRQ_BASE, 0,
+	domain = irq_domain_add_linear(node, num_chips * 32,
 				       &irq_generic_chip_ops, NULL);
 	if (!domain) {
 		err = -ENOMEM;
-- 
2.24.0

