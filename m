Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F9C78582
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 08:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfG2GyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 02:54:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57892 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbfG2GyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:54:04 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 57F4BE75CF37FCE21D54;
        Mon, 29 Jul 2019 14:54:01 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 29 Jul 2019
 14:53:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <eric@anholt.net>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] drm/bridge: lvds-encoder: Fix build error while CONFIG_DRM_KMS_HELPER=m
Date:   Mon, 29 Jul 2019 14:53:44 +0800
Message-ID: <20190729065344.9680-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If DRM_LVDS_ENCODER=y but CONFIG_DRM_KMS_HELPER=m,
build fails:

drivers/gpu/drm/bridge/lvds-encoder.o: In function `lvds_encoder_probe':
lvds-encoder.c:(.text+0x155): undefined reference to `devm_drm_panel_bridge_add'
drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x228): undefined reference to `drm_atomic_helper_connector_reset'
drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x240): undefined reference to `drm_helper_probe_single_connector_modes'
drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x268): undefined reference to `drm_atomic_helper_connector_duplicate_state'
drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x270): undefined reference to `drm_atomic_helper_connector_destroy_state'

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: dbb58bfd9ae6 drm/bridge: ("Fix lvds-encoder since the panel_bridge rework.")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index a6eec90..77e4b95 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -48,6 +48,7 @@ config DRM_DUMB_VGA_DAC
 config DRM_LVDS_ENCODER
 	tristate "Transparent parallel to LVDS encoder support"
 	depends on OF
+	select DRM_KMS_HELPER
 	select DRM_PANEL_BRIDGE
 	help
 	  Support for transparent parallel to LVDS encoders that don't require
-- 
2.7.4


