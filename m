Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B507140244
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 04:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgAQDXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 22:23:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9184 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727015AbgAQDXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 22:23:00 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 37089E421B1FB973F35D;
        Fri, 17 Jan 2020 11:22:58 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 17 Jan 2020
 11:22:48 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <b.zolnierkie@samsung.com>, <yuehaibing@huawei.com>,
        <arnd@arndb.de>, <daniel.vetter@ffwll.ch>,
        <christophe.jaillet@wanadoo.fr>, <jani.nikula@intel.com>,
        <hslester96@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] video: fbdev: pxa168fb: remove unnecessary platform_get_irq
Date:   Fri, 17 Jan 2020 11:22:41 +0800
Message-ID: <20200117032241.59148-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 640ba2444fa9 ("drivers/video/pxa168fb.c: use devm_ functions")
left behind this, it can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/video/fbdev/pxa168fb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index 706c6943..aef8a30 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -779,7 +779,6 @@ static int pxa168fb_remove(struct platform_device *pdev)
 {
 	struct pxa168fb_info *fbi = platform_get_drvdata(pdev);
 	struct fb_info *info;
-	int irq;
 	unsigned int data;
 
 	if (!fbi)
@@ -799,8 +798,6 @@ static int pxa168fb_remove(struct platform_device *pdev)
 	if (info->cmap.len)
 		fb_dealloc_cmap(&info->cmap);
 
-	irq = platform_get_irq(pdev, 0);
-
 	dma_free_wc(fbi->dev, info->fix.smem_len,
 		    info->screen_base, info->fix.smem_start);
 
-- 
2.7.4


