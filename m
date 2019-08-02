Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEC1B7FB8B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 15:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394858AbfHBNuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 09:50:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4159 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727520AbfHBNuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:50:24 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BFE258AA898B4ECE3C76;
        Fri,  2 Aug 2019 21:50:22 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Fri, 2 Aug 2019
 21:50:15 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <zbr@ioremap.net>, <andreas@kemnade.info>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] w1: omap-hdq: use devm_platform_ioremap_resource() to simplify code
Date:   Fri, 2 Aug 2019 21:50:10 +0800
Message-ID: <20190802135010.24052-1-yuehaibing@huawei.com>
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
 drivers/w1/masters/omap_hdq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index 3099052..4164045 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -660,7 +660,6 @@ static int omap_hdq_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct hdq_data *hdq_data;
-	struct resource *res;
 	int ret, irq;
 	u8 rev;
 	const char *mode;
@@ -674,8 +673,7 @@ static int omap_hdq_probe(struct platform_device *pdev)
 	hdq_data->dev = dev;
 	platform_set_drvdata(pdev, hdq_data);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hdq_data->hdq_base = devm_ioremap_resource(dev, res);
+	hdq_data->hdq_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hdq_data->hdq_base))
 		return PTR_ERR(hdq_data->hdq_base);
 
-- 
2.7.4


