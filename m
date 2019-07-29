Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B398A78800
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 11:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfG2JHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 05:07:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36054 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbfG2JHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:07:05 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 39A4953CA7CE7A5079F3;
        Mon, 29 Jul 2019 17:07:03 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 29 Jul 2019
 17:06:55 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] drm/bridge: tc358764: Fix build error
Date:   Mon, 29 Jul 2019 17:05:20 +0800
Message-ID: <20190729090520.25968-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DRM_TOSHIBA_TC358764=y but CONFIG_DRM_KMS_HELPER=m,
building fails:

drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x228): undefined reference to `drm_atomic_helper_connector_reset'
drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x240): undefined reference to `drm_helper_probe_single_connector_modes'
drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x268): undefined reference to `drm_atomic_helper_connector_duplicate_state'
drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x270): undefined reference to `drm_atomic_helper_connector_destroy_state'

Like TC358767, select DRM_KMS_HELPER to fix this, and
change to select DRM_PANEL to avoid recursive dependency.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: f38b7cca6d0e ("drm/bridge: tc358764: Add DSI to LVDS bridge driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/bridge/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index a6eec90..323f72d 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -116,9 +116,10 @@ config DRM_THINE_THC63LVD1024
 
 config DRM_TOSHIBA_TC358764
 	tristate "TC358764 DSI/LVDS bridge"
-	depends on DRM && DRM_PANEL
 	depends on OF
 	select DRM_MIPI_DSI
+	select DRM_KMS_HELPER
+	select DRM_PANEL
 	help
 	  Toshiba TC358764 DSI/LVDS bridge driver.
 
-- 
2.7.4


