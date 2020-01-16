Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C9C13DD26
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 15:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgAPOOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 09:14:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726084AbgAPOOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:14:49 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9C402C06E83C7C35574F;
        Thu, 16 Jan 2020 22:14:46 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 16 Jan 2020
 22:14:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <yuehaibing@huawei.com>, <nkristam@nvidia.com>,
        <felipe.balbi@linux.intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] usb: gadget: xudc: Remove redundant platform_get_irq error message
Date:   Thu, 16 Jan 2020 22:14:33 +0800
Message-ID: <20200116141433.57056-1-yuehaibing@huawei.com>
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
 drivers/usb/gadget/udc/tegra-xudc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 634c2c1..fc1eafc 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3492,11 +3492,8 @@ static int tegra_xudc_probe(struct platform_device *pdev)
 	}
 
 	xudc->irq = platform_get_irq(pdev, 0);
-	if (xudc->irq < 0) {
-		dev_err(xudc->dev, "failed to get IRQ: %d\n",
-				xudc->irq);
+	if (xudc->irq < 0)
 		return xudc->irq;
-	}
 
 	err = devm_request_irq(&pdev->dev, xudc->irq, tegra_xudc_irq, 0,
 			       dev_name(&pdev->dev), xudc);
-- 
2.7.4


