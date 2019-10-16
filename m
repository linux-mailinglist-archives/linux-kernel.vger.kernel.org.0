Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09379D8C14
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 11:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbfJPJCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 05:02:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4183 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727399AbfJPJCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:02:18 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6F3BB9BEE08DB5363A04;
        Wed, 16 Oct 2019 17:02:16 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 17:02:07 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <digholebhagyashri@gmail.com>,
        <etsai042@gmail.com>, <hariprasad.kelam@gmail.com>,
        <insafonov@gmail.com>, <yuehaibing@huawei.com>,
        <himadri18.07@gmail.com>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] staging: netlogic: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 16 Oct 2019 17:01:36 +0800
Message-ID: <20191016090136.20620-1-yuehaibing@huawei.com>
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
 drivers/staging/netlogic/xlr_net.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/netlogic/xlr_net.c b/drivers/staging/netlogic/xlr_net.c
index 05079f7..204fcdf 100644
--- a/drivers/staging/netlogic/xlr_net.c
+++ b/drivers/staging/netlogic/xlr_net.c
@@ -976,8 +976,7 @@ static int xlr_net_probe(struct platform_device *pdev)
 		priv->ndev = ndev;
 		priv->port_id = (pdev->id * 4) + port;
 		priv->nd = (struct xlr_net_data *)pdev->dev.platform_data;
-		res = platform_get_resource(pdev, IORESOURCE_MEM, port);
-		priv->base_addr = devm_ioremap_resource(&pdev->dev, res);
+		priv->base_addr = devm_platform_ioremap_resource(pdev, port);
 		if (IS_ERR(priv->base_addr)) {
 			err = PTR_ERR(priv->base_addr);
 			goto err_gmac;
-- 
2.7.4


