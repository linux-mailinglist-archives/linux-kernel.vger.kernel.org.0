Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB9F3E60C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 17:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfD2PUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 11:20:20 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:34046 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbfD2PUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:20:10 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id 6FL72000j3XaVaC01FL7Vv; Mon, 29 Apr 2019 17:20:08 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hL84d-0002Xr-O7; Mon, 29 Apr 2019 17:20:07 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hL84d-0005tH-Mw; Mon, 29 Apr 2019 17:20:07 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/5] irqchip/renesas-irqc: Remove devm_kzalloc()/ioremap_nocache() error printing
Date:   Mon, 29 Apr 2019 17:20:03 +0200
Message-Id: <20190429152006.22593-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190429152006.22593-1-geert+renesas@glider.be>
References: <20190429152006.22593-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to print a message if devm_kzalloc() or
ioremap_nocache() fails, as the memory allocation core already takes
care of that.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/irq-renesas-irqc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 438a063c76156d98..0955ffe12b32eb36 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -133,7 +133,6 @@ static int irqc_probe(struct platform_device *pdev)
 
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (!p) {
-		dev_err(&pdev->dev, "failed to allocate driver data\n");
 		ret = -ENOMEM;
 		goto err0;
 	}
@@ -173,7 +172,6 @@ static int irqc_probe(struct platform_device *pdev)
 	/* ioremap IOMEM and setup read/write callbacks */
 	p->iomem = ioremap_nocache(io->start, resource_size(io));
 	if (!p->iomem) {
-		dev_err(&pdev->dev, "failed to remap IOMEM\n");
 		ret = -ENXIO;
 		goto err2;
 	}
-- 
2.17.1

