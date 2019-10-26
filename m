Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1BFE5F31
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 21:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfJZTYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 15:24:46 -0400
Received: from mxwww.masterlogin.de ([95.129.51.220]:41658 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfJZTYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 15:24:46 -0400
Received: from mxout1.routing.net (unknown [192.168.10.81])
        by new.mxwww.masterlogin.de (Postfix) with ESMTPS id 3E75396F0D;
        Sat, 26 Oct 2019 19:24:42 +0000 (UTC)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout1.routing.net (Postfix) with ESMTP id 93B2243CF3;
        Sat, 26 Oct 2019 19:24:42 +0000 (UTC)
Received: from localhost.localdomain (fttx-pool-80.208.211.177.bambit.de [80.208.211.177])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 925A81005F5;
        Sat, 26 Oct 2019 19:24:41 +0000 (UTC)
From:   Frank Wunderlich <frank-w@public-files.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: 
Date:   Sat, 26 Oct 2019 21:23:59 +0200
Message-Id: <20191026192359.27687-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Sat, 26 Oct 2019 20:53:28 +0200
Subject: [PATCH] serial: 8250-mtk: Ask for IRQ-count before request one

at least on bananapi-r2 we have only 1 IRQ and need to
check for IRQ-count to fix following Errors during probe:

[    4.935780] mt6577-uart 11004000.serial: IRQ index 1 not found
[    4.962589] 11002000.serial: ttyS1 at MMIO 0x11002000 (irq = 202, base_baud = 1625000) is a ST16650V2
[    4.972127] mt6577-uart 11002000.serial: IRQ index 1 not found
[    4.998927] 11003000.serial: ttyS2 at MMIO 0x11003000 (irq = 203, base_baud = 1625000) is a ST16650V2
[    5.008474] mt6577-uart 11003000.serial: IRQ index 1 not found

based on Patch from Anson Huang
https://patchwork.ozlabs.org/patch/1164500/

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/tty/serial/8250/8250_mtk.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index b411ba4eb5e9..bf250187928a 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -485,6 +485,7 @@ static int mtk8250_probe(struct platform_device *pdev)
 	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	struct mtk8250_data *data;
+	int irq_count;
 	int err;
 
 	if (!regs || !irq) {
@@ -544,7 +545,15 @@ static int mtk8250_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	data->rx_wakeup_irq = platform_get_irq(pdev, 1);
+	irq_count = platform_irq_count(pdev);
+	if (irq_count < 0)
+		return irq_count;
+
+	if (irq_count > 1) {
+		data->rx_wakeup_irq = platform_get_irq(pdev, 1);
+		if (data->rx_wakeup_irq < 0)
+			data->rx_wakeup_irq = 0;
+	}
 
 	return 0;
 }
-- 
2.17.1

