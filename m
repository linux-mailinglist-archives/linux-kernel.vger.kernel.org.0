Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9775C141DC1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 13:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgASMUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jan 2020 07:20:41 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726744AbgASMUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 07:20:41 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8EE9479CA32EEF2EE3A0;
        Sun, 19 Jan 2020 20:20:39 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Sun, 19 Jan 2020
 20:20:31 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <b.zolnierkie@samsung.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] video: remove set but not used variable 'ulScaleRight'
Date:   Sun, 19 Jan 2020 20:19:45 +0800
Message-ID: <20200119121945.12517-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/video/fbdev/kyro/STG4000OverlayDevice.c: In function
‘SetOverlayViewPort’:
drivers/video/fbdev/kyro/STG4000OverlayDevice.c:334:19: warning:
variable ‘ulScaleRight’ set but not used [-Wunused-but-set-variable]

It is never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/video/fbdev/kyro/STG4000OverlayDevice.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
index 0aeeaa10708b..9fde0e3b69ec 100644
--- a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
+++ b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
@@ -331,7 +331,7 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
 	u32 ulScale;
 	u32 ulLeft, ulRight;
 	u32 ulSrcLeft, ulSrcRight;
-	u32 ulScaleLeft, ulScaleRight;
+	u32 ulScaleLeft;
 	u32 ulhDecim;
 	u32 ulsVal;
 	u32 ulVertDecFactor;
@@ -470,7 +470,6 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
 		 * round down the pixel pos to the nearest 8 pixels.
 		 */
 		ulScaleLeft = ulSrcLeft;
-		ulScaleRight = ulSrcRight;
 
 		/* shift fxscale until it is in the range of the scaler */
 		ulhDecim = 0;
-- 
2.17.2

