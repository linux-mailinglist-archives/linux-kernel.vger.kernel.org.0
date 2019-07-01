Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3811E20380
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 12:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfEPKc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 06:32:28 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:55857 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPKc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:32:28 -0400
Received: from localhost (unknown [80.215.244.179])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 78FE3240007;
        Thu, 16 May 2019 10:32:20 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Emil Velikov <emil.velikov@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v3 6/7] drm: Replace instances of drm_format_info by drm_get_format_info
Date:   Thu, 16 May 2019 12:31:51 +0200
Message-Id: <5859d68664b8f0804a56e7386937f6db986b9e0f.1558002671.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <27b0041c7977402df4a087c78d2849ffe51c9f1c.1558002671.git-series.maxime.ripard@bootlin.com>
References: <27b0041c7977402df4a087c78d2849ffe51c9f1c.1558002671.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_get_format_info directly calls into drm_format_info, but takes directly
a struct drm_mode_fb_cmd2 pointer, instead of the fourcc directly. It's
shorter to not dereference it, and we can customise the behaviour at the
driver level if we want to, so let's switch to it where it makes sense.

Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c | 4 ++--
 drivers/gpu/drm/gma500/framebuffer.c   | 2 +-
 drivers/gpu/drm/omapdrm/omap_fb.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index 06e73a343724..6edae6458be8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -121,8 +121,7 @@ static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
 					 struct drm_mode_fb_cmd2 *mode_cmd,
 					 struct drm_gem_object **gobj_p)
 {
-	const struct drm_format_info *info = drm_get_format_info(dev,
-								 mode_cmd);
+	const struct drm_format_info *info;
 	struct amdgpu_device *adev = rfbdev->adev;
 	struct drm_gem_object *gobj = NULL;
 	struct amdgpu_bo *abo = NULL;
@@ -133,6 +132,7 @@ static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
 	int height = mode_cmd->height;
 	u32 cpp;
 
+	info = drm_get_format_info(adev->ddev, mode_cmd);
 	cpp = drm_format_info_plane_cpp(info, 0);
 
 	/* need to align pitch with crtc limits */
diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index a9d3a4a30ab8..1794ab90b2cc 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -232,7 +232,7 @@ static int psb_framebuffer_init(struct drm_device *dev,
 	 * Reject unknown formats, YUV formats, and formats with more than
 	 * 4 bytes per pixel.
 	 */
-	info = drm_format_info(mode_cmd->pixel_format);
+	info = drm_get_format_info(dev, mode_cmd);
 	if (!info || !info->depth || info->cpp[0] > 4)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index cfb641363a32..6557b2d6e16e 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -339,7 +339,7 @@ struct drm_framebuffer *omap_framebuffer_init(struct drm_device *dev,
 			dev, mode_cmd, mode_cmd->width, mode_cmd->height,
 			(char *)&mode_cmd->pixel_format);
 
-	format = drm_format_info(mode_cmd->pixel_format);
+	format = drm_get_format_info(dev, mode_cmd);
 
 	for (i = 0; i < ARRAY_SIZE(formats); i++) {
 		if (formats[i] == mode_cmd->pixel_format)
-- 
git-series 0.9.1
