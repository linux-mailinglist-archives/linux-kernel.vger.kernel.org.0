Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4B415A453
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 10:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgBLJL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 04:11:56 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:44332 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbgBLJLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:11:53 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id 1lBp220035USYZQ01lBphZ; Wed, 12 Feb 2020 10:11:51 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1o3g-0000Zh-Uz; Wed, 12 Feb 2020 10:11:48 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1ngP-0002Ry-BS; Wed, 12 Feb 2020 09:47:45 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] irqchip/renesas-intc-irqpin: Restore devm_ioremap() alignment
Date:   Wed, 12 Feb 2020 09:47:44 +0100
Message-Id: <20200212084744.9376-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restore alignment of the continuation of the devm_ioremap() call in
intc_irqpin_probe().

Fixes: 4bdc0d676a643140 ("remove ioremap_nocache and devm_ioremap_nocache")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/irq-renesas-intc-irqpin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 6e5e3172796bca3b..3819185bfd02c63f 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -461,7 +461,7 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 		}
 
 		i->iomem = devm_ioremap(dev, io[k]->start,
-						resource_size(io[k]));
+					resource_size(io[k]));
 		if (!i->iomem) {
 			dev_err(dev, "failed to remap IOMEM\n");
 			ret = -ENXIO;
-- 
2.17.1

