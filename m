Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 311A9784FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 08:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfG2GgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 02:36:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3191 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbfG2GgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:36:14 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A20888BD6424470D0156;
        Mon, 29 Jul 2019 14:36:02 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 29 Jul 2019
 14:35:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <eric@anholt.net>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] drm/bridge: lvds-encoder: Fix build error
Date:   Mon, 29 Jul 2019 14:35:39 +0800
Message-ID: <20190729063539.19328-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DRM_LVDS_ENCODER=y but CONFIG_DRM_KMS_HELPER=m,
build fails:

drivers/gpu/drm/bridge/lvds-encoder.o: In function `lvds_encoder_probe':
lvds-encoder.c:(.text+0x155): undefined reference to `devm_drm_panel_bridge_add'

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: dbb58bfd9ae6 drm/bridge: ("Fix lvds-encoder since the panel_bridge rework.")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/bridge/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index a6eec90..2926750 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -8,7 +8,7 @@ config DRM_BRIDGE
 config DRM_PANEL_BRIDGE
 	def_bool y
 	depends on DRM_BRIDGE
-	depends on DRM_KMS_HELPER
+	select DRM_KMS_HELPER
 	select DRM_PANEL
 	help
 	  DRM bridge wrapper of DRM panels
-- 
2.7.4


