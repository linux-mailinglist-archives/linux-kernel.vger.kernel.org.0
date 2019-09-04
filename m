Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D80CAA7FB0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 11:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbfIDJr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 05:47:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33974 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbfIDJr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:47:57 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 875A06E3090634102B61;
        Wed,  4 Sep 2019 17:47:56 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 17:47:49 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <yuehaibing@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] usb: gadget: r8a66597-udc: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 4 Sep 2019 17:47:38 +0800
Message-ID: <20190904094738.7860-1-yuehaibing@huawei.com>
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

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/gadget/udc/r8a66597-udc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index 11e25a3..582a161 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1838,7 +1838,7 @@ static int r8a66597_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	char clk_name[8];
-	struct resource *res, *ires;
+	struct resource *ires;
 	int irq;
 	void __iomem *reg = NULL;
 	struct r8a66597 *r8a66597 = NULL;
@@ -1846,8 +1846,7 @@ static int r8a66597_probe(struct platform_device *pdev)
 	int i;
 	unsigned long irq_trigger;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reg = devm_ioremap_resource(&pdev->dev, res);
+	reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
-- 
2.7.4


