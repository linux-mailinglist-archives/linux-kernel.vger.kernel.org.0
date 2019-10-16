Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F01B3D8C19
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 11:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390743AbfJPJDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 05:03:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727399AbfJPJDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:03:35 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2E9197370965DC43FFBB;
        Wed, 16 Oct 2019 17:03:33 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 17:03:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <daniela.mormocea@gmail.com>,
        <gustavo@embeddedor.com>, <linux.bhar@gmail.com>,
        <philipp.panzer@fau.de>, <nishka.dasgupta@yahoo.com>,
        <harold.andre@gmx.fr>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: ralink-gdma: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 16 Oct 2019 17:03:05 +0800
Message-ID: <20191016090305.23392-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/ralink-gdma/ralink-gdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index 900424d..eabf109 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -796,7 +796,6 @@ static int gdma_dma_probe(struct platform_device *pdev)
 	struct gdma_dma_dev *dma_dev;
 	struct dma_device *dd;
 	unsigned int i;
-	struct resource *res;
 	int ret;
 	int irq;
 	void __iomem *base;
@@ -818,8 +817,7 @@ static int gdma_dma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	dma_dev->data = data;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 	dma_dev->base = base;
-- 
2.7.4


