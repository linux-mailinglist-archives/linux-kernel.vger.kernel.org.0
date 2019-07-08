Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E77761A96
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 08:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfGHGWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 02:22:14 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:34286 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbfGHGWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 02:22:13 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id E1517169850ABFE0DA36;
        Mon,  8 Jul 2019 14:22:11 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id x686KmqA015529;
        Mon, 8 Jul 2019 14:20:48 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019070814205273-2164428 ;
          Mon, 8 Jul 2019 14:20:52 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Brandt <chris.brandt@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] irqchip: renesas-rza1: fix an use-after-free in rza1_irqc_probe()
Date:   Mon, 8 Jul 2019 14:19:04 +0800
Message-Id: <1562566745-7447-3-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562566745-7447-1-git-send-email-wen.yang99@zte.com.cn>
References: <1562566745-7447-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-08 14:20:52,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-08 14:20:50,
        Serialize complete at 2019-07-08 14:20:50
X-MAIL: mse-fl1.zte.com.cn x686KmqA015529
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gic_node is still being used in the rza1_irqc_parse_map() call
after the of_node_put() call, which may result in use-after-free.

Fixes: a644ccb819bc ("irqchip: Add Renesas RZ/A1 Interrupt Controller driver")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Chris Brandt <chris.brandt@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: linux-kernel@vger.kernel.org
---
 drivers/irqchip/irq-renesas-rza1.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas-rza1.c
index b1f19b21..b0d46ac 100644
--- a/drivers/irqchip/irq-renesas-rza1.c
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -208,20 +208,19 @@ static int rza1_irqc_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	gic_node = of_irq_find_parent(np);
-	if (gic_node) {
+	if (gic_node)
 		parent = irq_find_host(gic_node);
-		of_node_put(gic_node);
-	}
 
 	if (!parent) {
 		dev_err(dev, "cannot find parent domain\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_put_node;
 	}
 
 	ret = rza1_irqc_parse_map(priv, gic_node);
 	if (ret) {
 		dev_err(dev, "cannot parse %s: %d\n", "interrupt-map", ret);
-		return ret;
+		goto out_put_node;
 	}
 
 	priv->chip.name = "rza1-irqc",
@@ -237,10 +236,12 @@ static int rza1_irqc_probe(struct platform_device *pdev)
 						    priv);
 	if (!priv->irq_domain) {
 		dev_err(dev, "cannot initialize irq domain\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
 	}
 
-	return 0;
+out_put_node:
+	of_node_put(gic_node);
+	return ret;
 }
 
 static int rza1_irqc_remove(struct platform_device *pdev)
-- 
2.9.5

