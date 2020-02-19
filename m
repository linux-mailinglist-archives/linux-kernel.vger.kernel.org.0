Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE687163A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 03:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgBSCwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 21:52:15 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39466 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728027AbgBSCwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:52:15 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BE3FAAF365DBB3DB6BE6;
        Wed, 19 Feb 2020 10:52:12 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Wed, 19 Feb 2020 10:52:05 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] drm/hisilicon: Set preferred mode resolution and maximum resolution
Date:   Wed, 19 Feb 2020 10:51:47 +0800
Message-ID: <1582080707-18825-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set the preferred mode resolution to 1024 * 768 and maximum
resolution to 1920 * 1200.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Gong junjie <gongjunjie2@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index 6d98fdc..82fc7d3 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -11,8 +11,10 @@
  *	Jianhua Li <lijianhua@huawei.com>
  */
 
+#include <drm/drm_gem_vram_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_crtc_helper.h>
 #include <drm/drm_print.h>
 
 #include "hibmc_drm_drv.h"
@@ -20,7 +22,13 @@
 
 static int hibmc_connector_get_modes(struct drm_connector *connector)
 {
-	return drm_add_modes_noedid(connector, 800, 600);
+	int count;
+
+	drm_connector_update_edid_property(connector, NULL);
+	count = drm_add_modes_noedid(connector, 1920, 1200);
+	drm_set_preferred_mode(connector, 1024, 768);
+
+	return count;
 }
 
 static enum drm_mode_status hibmc_connector_mode_valid(struct drm_connector *connector,
-- 
2.7.4

