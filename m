Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7DCE3651
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 17:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503012AbfJXPRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 11:17:43 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:60340 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389313AbfJXPRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:17:43 -0400
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id HTHh2100K5USYZQ01THhsz; Thu, 24 Oct 2019 17:17:41 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNert-0006yo-A6; Thu, 24 Oct 2019 17:17:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNert-0007d9-89; Thu, 24 Oct 2019 17:17:41 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Jiri Kosina <trivial@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] drm: Spelling s/connet/connect/
Date:   Thu, 24 Oct 2019 17:17:37 +0200
Message-Id: <20191024151737.29287-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspellings of "connector" and "connection"

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/gma500/mdfld_dsi_output.c | 2 +-
 include/uapi/drm/exynos_drm.h             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mdfld_dsi_output.c b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
index 03023fa0fb6f9d3c..f350ac1ead18213e 100644
--- a/drivers/gpu/drm/gma500/mdfld_dsi_output.c
+++ b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
@@ -498,7 +498,7 @@ void mdfld_dsi_output_init(struct drm_device *dev,
 		return;
 	}
 
-	/*create a new connetor*/
+	/*create a new connector*/
 	dsi_connector = kzalloc(sizeof(struct mdfld_dsi_connector), GFP_KERNEL);
 	if (!dsi_connector) {
 		DRM_ERROR("No memory");
diff --git a/include/uapi/drm/exynos_drm.h b/include/uapi/drm/exynos_drm.h
index 3e59b8382dd8cead..45c6582b3df31dbf 100644
--- a/include/uapi/drm/exynos_drm.h
+++ b/include/uapi/drm/exynos_drm.h
@@ -68,7 +68,7 @@ struct drm_exynos_gem_info {
 /**
  * A structure for user connection request of virtual display.
  *
- * @connection: indicate whether doing connetion or not by user.
+ * @connection: indicate whether doing connection or not by user.
  * @extensions: if this value is 1 then the vidi driver would need additional
  *	128bytes edid data.
  * @edid: the edid data pointer from user side.
-- 
2.17.1

