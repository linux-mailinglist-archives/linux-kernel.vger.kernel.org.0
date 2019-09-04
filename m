Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94756A81A5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 13:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfIDL5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 07:57:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbfIDL5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:57:18 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E7F8989353DA47D25456;
        Wed,  4 Sep 2019 19:57:15 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 19:57:06 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jingoohan1@gmail.com>, <b.zolnierkie@samsung.com>
CC:     <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] fbdev: s3c-fb: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 4 Sep 2019 19:55:23 +0800
Message-ID: <20190904115523.25068-1-yuehaibing@huawei.com>
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
 drivers/video/fbdev/s3c-fb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index ba04d7a..43ac8d7 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1411,8 +1411,7 @@ static int s3c_fb_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(sfb->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sfb->regs = devm_ioremap_resource(dev, res);
+	sfb->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sfb->regs)) {
 		ret = PTR_ERR(sfb->regs);
 		goto err_lcd_clk;
-- 
2.7.4


