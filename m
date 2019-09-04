Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14301A8180
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 13:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfIDLvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 07:51:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbfIDLvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:51:35 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 779DCDDBA4A18AEEDC9F;
        Wed,  4 Sep 2019 19:51:33 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 19:51:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <b.zolnierkie@samsung.com>, <allison@lohutok.net>,
        <mcgrof@kernel.org>, <yuehaibing@huawei.com>,
        <rfontana@redhat.com>, <tglx@linutronix.de>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] fbdev: da8xx-fb: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 4 Sep 2019 19:50:28 +0800
Message-ID: <20190904115028.25392-1-yuehaibing@huawei.com>
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
 drivers/video/fbdev/da8xx-fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index b1cf248..57518d7 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -1328,7 +1328,6 @@ static int fb_probe(struct platform_device *device)
 {
 	struct da8xx_lcdc_platform_data *fb_pdata =
 						dev_get_platdata(&device->dev);
-	struct resource *lcdc_regs;
 	struct lcd_ctrl_config *lcd_cfg;
 	struct fb_videomode *lcdc_info;
 	struct fb_info *da8xx_fb_info;
@@ -1346,8 +1345,7 @@ static int fb_probe(struct platform_device *device)
 	if (lcdc_info == NULL)
 		return -ENODEV;
 
-	lcdc_regs = platform_get_resource(device, IORESOURCE_MEM, 0);
-	da8xx_fb_reg_base = devm_ioremap_resource(&device->dev, lcdc_regs);
+	da8xx_fb_reg_base = devm_platform_ioremap_resource(device, 0);
 	if (IS_ERR(da8xx_fb_reg_base))
 		return PTR_ERR(da8xx_fb_reg_base);
 
-- 
2.7.4


