Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC9E1878EF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 06:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgCQFDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 01:03:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60674 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgCQFDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 01:03:31 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 70FE8200CB7;
        Tue, 17 Mar 2020 06:03:29 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 35466200CBB;
        Tue, 17 Mar 2020 06:03:24 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9ACE9402C4;
        Tue, 17 Mar 2020 13:03:17 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] irqchip: irq-imx-gpcv2: Remove unnecessary blank lines
Date:   Tue, 17 Mar 2020 12:56:41 +0800
Message-Id: <1584421001-2647-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank lines for cleanup.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/irqchip/irq-imx-gpcv2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 4f74c15..4f11b9b 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -17,7 +17,6 @@
 #define GPC_IMR1_CORE2		0x1c0
 #define GPC_IMR1_CORE3		0x1d0
 
-
 struct gpcv2_irqchip_data {
 	struct raw_spinlock	rlock;
 	void __iomem		*gpc_base;
@@ -287,6 +286,5 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 	of_node_clear_flag(node, OF_POPULATED);
 	return 0;
 }
-
 IRQCHIP_DECLARE(imx_gpcv2_imx7d, "fsl,imx7d-gpc", imx_gpcv2_irqchip_init);
 IRQCHIP_DECLARE(imx_gpcv2_imx8mq, "fsl,imx8mq-gpc", imx_gpcv2_irqchip_init);
-- 
2.7.4

