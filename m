Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7AE7D8BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 10:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391829AbfJPI7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 04:59:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46424 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388817AbfJPI7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:59:39 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0D8C0BE2ADF6A9344CCD;
        Wed, 16 Oct 2019 16:59:38 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 16:59:30 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <matthias.bgg@gmail.com>,
        <bhanusreemahesh@gmail.com>, <jbi.octave@gmail.com>,
        <swboyd@chromium.org>, <yuehaibing@huawi.com>,
        <sergio.paracuellos@gmail.com>, <puranjay12@gmail.com>,
        <arma2ff0@gmail.com>, <kimbrownkd@gmail.com>
CC:     <devel@driverdev.osuosl.org>,
        <linux-arm-kernel@lists.ifradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: mt7621-dma: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 16 Oct 2019 16:58:33 +0800
Message-ID: <20191016085833.26376-1-yuehaibing@huawei.com>
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
 drivers/staging/mt7621-dma/mtk-hsdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
index d964642..4d541c4 100644
--- a/drivers/staging/mt7621-dma/mtk-hsdma.c
+++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
@@ -650,7 +650,6 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 	struct mtk_hsdma_chan *chan;
 	struct mtk_hsdam_engine *hsdma;
 	struct dma_device *dd;
-	struct resource *res;
 	int ret;
 	int irq;
 	void __iomem *base;
@@ -667,8 +666,7 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 	if (!hsdma)
 		return -EINVAL;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 	hsdma->base = base + HSDMA_BASE_OFFSET;
-- 
2.7.4


