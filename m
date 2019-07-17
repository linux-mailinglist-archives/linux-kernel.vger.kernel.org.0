Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09A2A6B8C4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 11:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfGQJCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 05:02:24 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49520 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQJCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 05:02:24 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D3741A0174;
        Wed, 17 Jul 2019 11:02:22 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 79D371A00FF;
        Wed, 17 Jul 2019 11:02:15 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F0931402D5;
        Wed, 17 Jul 2019 17:02:06 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linus.walleij@linaro.org, stefan.wahren@i2se.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] mmc: mxs: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 17 Jul 2019 16:52:59 +0800
Message-Id: <20190717085259.31235-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/mmc/host/mxs-mmc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index b334e81..78e7e35 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -571,7 +571,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct mxs_mmc_host *host;
 	struct mmc_host *mmc;
-	struct resource *iores;
 	int ret = 0, irq_err;
 	struct regulator *reg_vmmc;
 	struct mxs_ssp *ssp;
@@ -587,8 +586,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	host = mmc_priv(mmc);
 	ssp = &host->ssp;
 	ssp->dev = &pdev->dev;
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ssp->base = devm_ioremap_resource(&pdev->dev, iores);
+	ssp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ssp->base)) {
 		ret = PTR_ERR(ssp->base);
 		goto out_mmc_free;
-- 
2.7.4

