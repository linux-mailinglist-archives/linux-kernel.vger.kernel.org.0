Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B50DEE281D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 04:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436999AbfJXC3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 22:29:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58598 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436951AbfJXC3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:29:49 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6F3F62F6BF412295F8CD;
        Thu, 24 Oct 2019 10:29:47 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 24 Oct 2019
 10:29:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <vigneshr@ti.com>, <masonccyang@mxic.com.tw>,
        <yuehaibing@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mtd: rawnand: mxic: Remove dev_err() on platform_get_irq() failure
Date:   Thu, 24 Oct 2019 10:29:34 +0800
Message-ID: <20191024022934.34288-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() will call dev_err() itself on failure,
so there is no need for the driver to also do this.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mtd/nand/raw/mxic_nand.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxic_nand.c b/drivers/mtd/nand/raw/mxic_nand.c
index 9d49e6c..ed7a4e0 100644
--- a/drivers/mtd/nand/raw/mxic_nand.c
+++ b/drivers/mtd/nand/raw/mxic_nand.c
@@ -524,10 +524,8 @@ static int mxic_nfc_probe(struct platform_device *pdev)
 	nand_chip->controller = &nfc->controller;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to retrieve irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	mxic_nfc_hw_init(nfc);
 
-- 
2.7.4


