Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 166FCD9327
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 15:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405639AbfJPN6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 09:58:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4220 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404326AbfJPN6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:58:03 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DDC6FBB39C77AC8A3C0D;
        Wed, 16 Oct 2019 21:58:00 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 21:57:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kishon@ti.com>, <kstewart@linuxfoundation.org>,
        <yuehaibing@huawei.com>, <swinslow@gmail.com>,
        <gregkh@linuxfoundation.org>, <opensource@jilayne.com>,
        <tglx@linutronix.de>, <info@metux.net>, <allison@lohutok.net>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] phy: hisilicon: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 16 Oct 2019 21:57:35 +0800
Message-ID: <20191016135735.12576-1-yuehaibing@huawei.com>
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
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 4 +---
 drivers/phy/hisilicon/phy-histb-combphy.c  | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index 9b16f13..34a6a9a 100644
--- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
+++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
@@ -114,7 +114,6 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 	struct hisi_inno_phy_priv *priv;
 	struct phy_provider *provider;
 	struct device_node *child;
-	struct resource *res;
 	int i = 0;
 	int ret;
 
@@ -122,8 +121,7 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->mmio = devm_ioremap_resource(dev, res);
+	priv->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->mmio)) {
 		ret = PTR_ERR(priv->mmio);
 		return ret;
diff --git a/drivers/phy/hisilicon/phy-histb-combphy.c b/drivers/phy/hisilicon/phy-histb-combphy.c
index 62d10ef..f1cb3e4 100644
--- a/drivers/phy/hisilicon/phy-histb-combphy.c
+++ b/drivers/phy/hisilicon/phy-histb-combphy.c
@@ -195,7 +195,6 @@ static int histb_combphy_probe(struct platform_device *pdev)
 	struct histb_combphy_priv *priv;
 	struct device_node *np = dev->of_node;
 	struct histb_combphy_mode *mode;
-	struct resource *res;
 	u32 vals[3];
 	int ret;
 
@@ -203,8 +202,7 @@ static int histb_combphy_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->mmio = devm_ioremap_resource(dev, res);
+	priv->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->mmio)) {
 		ret = PTR_ERR(priv->mmio);
 		return ret;
-- 
2.7.4


