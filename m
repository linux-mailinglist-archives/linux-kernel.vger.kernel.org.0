Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89FD7D784F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 16:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732604AbfJOOWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 10:22:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732050AbfJOOWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:22:07 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5F6D42936B4E6926B116;
        Tue, 15 Oct 2019 22:22:04 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 15 Oct 2019
 22:21:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <orsonzhai@gmail.com>, <baolin.wang@linaro.org>,
        <zhang.lyra@gmail.com>, <yuehaibing@huawei.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] clk: sprd: use devm_platform_ioremap_resource() to simplify code
Date:   Tue, 15 Oct 2019 22:21:44 +0800
Message-ID: <20191015142144.23544-1-yuehaibing@huawei.com>
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
 drivers/clk/sprd/common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
index 9d56eac..3718696 100644
--- a/drivers/clk/sprd/common.c
+++ b/drivers/clk/sprd/common.c
@@ -42,7 +42,6 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
 	void __iomem *base;
 	struct device_node *node = pdev->dev.of_node;
 	struct regmap *regmap;
-	struct resource *res;
 
 	if (of_find_property(node, "sprd,syscon", NULL)) {
 		regmap = syscon_regmap_lookup_by_phandle(node, "sprd,syscon");
@@ -51,8 +50,7 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
 			return PTR_ERR(regmap);
 		}
 	} else {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		base = devm_ioremap_resource(&pdev->dev, res);
+		base = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(base))
 			return PTR_ERR(base);
 
-- 
2.7.4


