Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9FDDE5E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 17:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfD2PPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 11:15:19 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:53464 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfD2PPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:15:18 -0400
Received: from ramsan ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id 6FFG200063XaVaC01FFGzZ; Mon, 29 Apr 2019 17:15:16 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hL7zw-0002Sb-1U; Mon, 29 Apr 2019 17:15:16 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hL7zv-0005m0-Vk; Mon, 29 Apr 2019 17:15:16 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] irqchip/renesas-intc-irqpin: Remove devm_kzalloc() error printing
Date:   Mon, 29 Apr 2019 17:15:14 +0200
Message-Id: <20190429151514.22150-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to print a message if devm_kzalloc() fails, as the
memory allocation core already takes care of that.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/irq-renesas-intc-irqpin.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 8c039525703f7c9a..04c05a18600cf71f 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -389,10 +389,8 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	int k;
 
 	p = devm_kzalloc(dev, sizeof(*p), GFP_KERNEL);
-	if (!p) {
-		dev_err(dev, "failed to allocate driver data\n");
+	if (!p)
 		return -ENOMEM;
-	}
 
 	/* deal with driver instance configuration */
 	of_property_read_u32(dev->of_node, "sense-bitfield-width",
-- 
2.17.1

