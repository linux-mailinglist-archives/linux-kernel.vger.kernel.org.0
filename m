Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAB1E135F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 09:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389988AbfJWHqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 03:46:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732328AbfJWHqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:46:36 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 339628C4DF37949A8DBF;
        Wed, 23 Oct 2019 15:46:34 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 15:46:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kishon@ti.com>, <yuehaibing@huawei.com>, <rogerq@ti.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] phy: ti: dm816x: remove set but not used variable 'phy_data'
Date:   Wed, 23 Oct 2019 15:45:23 +0800
Message-ID: <20191023074523.31888-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/phy/ti/phy-dm816x-usb.c:192:29: warning:
 variable phy_data set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/phy/ti/phy-dm816x-usb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/phy/ti/phy-dm816x-usb.c b/drivers/phy/ti/phy-dm816x-usb.c
index cbcce7c..26f1947 100644
--- a/drivers/phy/ti/phy-dm816x-usb.c
+++ b/drivers/phy/ti/phy-dm816x-usb.c
@@ -189,7 +189,6 @@ static int dm816x_usb_phy_probe(struct platform_device *pdev)
 	struct phy_provider *phy_provider;
 	struct usb_otg *otg;
 	const struct of_device_id *of_id;
-	const struct usb_phy_data *phy_data;
 	int error;
 
 	of_id = of_match_device(of_match_ptr(dm816x_usb_phy_id_table),
@@ -220,8 +219,6 @@ static int dm816x_usb_phy_probe(struct platform_device *pdev)
 	if (phy->usbphy_ctrl == 0x2c)
 		phy->instance = 1;
 
-	phy_data = of_id->data;
-
 	otg = devm_kzalloc(&pdev->dev, sizeof(*otg), GFP_KERNEL);
 	if (!otg)
 		return -ENOMEM;
-- 
2.7.4


