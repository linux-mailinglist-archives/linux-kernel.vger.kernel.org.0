Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 644C119A7B8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 10:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbgDAIsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 04:48:54 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:8371 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgDAIsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:48:53 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65e8455597e4-40731; Wed, 01 Apr 2020 16:48:26 +0800 (CST)
X-RM-TRANSID: 2ee65e8455597e4-40731
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65e8455580bf-9490d;
        Wed, 01 Apr 2020 16:48:25 +0800 (CST)
X-RM-TRANSID: 2ee65e8455580bf-9490d
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ata:ahci_xgene:use devm_platform_ioremap_resource() to simplify code
Date:   Wed,  1 Apr 2020 16:49:52 +0800
Message-Id: <20200401084952.5828-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this function, devm_platform_ioremap_resource() should be suitable
to simplify code.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/ata/ahci_xgene.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 16246c843..061209275 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -739,7 +739,6 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
 	struct xgene_ahci_context *ctx;
-	struct resource *res;
 	const struct of_device_id *of_devid;
 	enum xgene_ahci_version version = XGENE_AHCI_V1;
 	const struct ata_port_info *ppi[] = { &xgene_ahci_v1_port_info,
@@ -759,32 +758,24 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 	ctx->dev = dev;
 
 	/* Retrieve the IP core resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	ctx->csr_core = devm_ioremap_resource(dev, res);
+	ctx->csr_core = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(ctx->csr_core))
 		return PTR_ERR(ctx->csr_core);
 
 	/* Retrieve the IP diagnostic resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	ctx->csr_diag = devm_ioremap_resource(dev, res);
+	ctx->csr_diag = devm_platform_ioremap_resource(pdev, 2);
 	if (IS_ERR(ctx->csr_diag))
 		return PTR_ERR(ctx->csr_diag);
 
 	/* Retrieve the IP AXI resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
-	ctx->csr_axi = devm_ioremap_resource(dev, res);
+	ctx->csr_axi = devm_platform_ioremap_resource(pdev, 3);
 	if (IS_ERR(ctx->csr_axi))
 		return PTR_ERR(ctx->csr_axi);
 
 	/* Retrieve the optional IP mux resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 4);
-	if (res) {
-		void __iomem *csr = devm_ioremap_resource(dev, res);
-		if (IS_ERR(csr))
-			return PTR_ERR(csr);
-
-		ctx->csr_mux = csr;
-	}
+	ctx->csr_mux = devm_platform_ioremap_resource(pdev, 4);
+	if (IS_ERR(ctx->csr_mux))
+		return PTR_ERR(ctx->csr_mux);
 
 	of_devid = of_match_device(xgene_ahci_of_match, dev);
 	if (of_devid) {
-- 
2.20.1.windows.1



