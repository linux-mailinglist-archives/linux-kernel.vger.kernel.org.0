Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C08A57DF1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 10:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfF0IMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 04:12:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfF0IMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 04:12:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6BEDF8552A;
        Thu, 27 Jun 2019 08:12:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61D9C5D707;
        Thu, 27 Jun 2019 08:12:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8AFDE16E08; Thu, 27 Jun 2019 10:12:06 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/bochs: fix framebuffer setup.
Date:   Thu, 27 Jun 2019 10:12:06 +0200
Message-Id: <20190627081206.23135-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 27 Jun 2019 08:12:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver doesn't consider framebuffer pitch and offset, leading to a
wrong display in case offset != 0 or pitch != width * bpp.  Fix it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h     |  2 +-
 drivers/gpu/drm/bochs/bochs_hw.c  | 14 ++++++++++----
 drivers/gpu/drm/bochs/bochs_kms.c |  3 ++-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index cc35d492142c..2a65434500ee 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -86,7 +86,7 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 void bochs_hw_setformat(struct bochs_device *bochs,
 			const struct drm_format_info *format);
 void bochs_hw_setbase(struct bochs_device *bochs,
-		      int x, int y, u64 addr);
+		      int x, int y, int stride, u64 addr);
 int bochs_hw_load_edid(struct bochs_device *bochs);
 
 /* bochs_mm.c */
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index 791ab2f79947..ebfea8744fe6 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -255,16 +255,22 @@ void bochs_hw_setformat(struct bochs_device *bochs,
 }
 
 void bochs_hw_setbase(struct bochs_device *bochs,
-		      int x, int y, u64 addr)
+		      int x, int y, int stride, u64 addr)
 {
-	unsigned long offset = (unsigned long)addr +
+	unsigned long offset;
+	unsigned int vx, vy, vwidth;
+
+	bochs->stride = stride;
+	offset = (unsigned long)addr +
 		y * bochs->stride +
 		x * (bochs->bpp / 8);
-	int vy = offset / bochs->stride;
-	int vx = (offset % bochs->stride) * 8 / bochs->bpp;
+	vy = offset / bochs->stride;
+	vx = (offset % bochs->stride) * 8 / bochs->bpp;
+	vwidth = stride * 8 / bochs->bpp;
 
 	DRM_DEBUG_DRIVER("x %d, y %d, addr %llx -> offset %lx, vx %d, vy %d\n",
 			 x, y, addr, offset, vx, vy);
+	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_WIDTH, vwidth);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET, vx);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET, vy);
 }
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 5904eddc83a5..bc19dbd531ef 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -36,7 +36,8 @@ static void bochs_plane_update(struct bochs_device *bochs,
 	bochs_hw_setbase(bochs,
 			 state->crtc_x,
 			 state->crtc_y,
-			 gbo->bo.offset);
+			 state->fb->pitches[0],
+			 state->fb->offsets[0] + gbo->bo.offset);
 	bochs_hw_setformat(bochs, state->fb->format);
 }
 
-- 
2.18.1

