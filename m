Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C034E20952
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 16:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfEPOPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 10:15:03 -0400
Received: from foss.arm.com ([217.140.101.70]:47168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfEPOPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:15:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B02A319F6;
        Thu, 16 May 2019 07:15:01 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBD393F71E;
        Thu, 16 May 2019 07:14:58 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drm/gem: Rename drm_gem_dumb_map_offset() to drm_gem_map_offset()
Date:   Thu, 16 May 2019 15:14:45 +0100
Message-Id: <20190516141447.46839-2-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516141447.46839-1-steven.price@arm.com>
References: <20190516141447.46839-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_gem_dumb_map_offset() is a useful helper for non-dumb clients, so
rename it to remove the _dumb.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/drm_dumb_buffers.c      | 4 ++--
 drivers/gpu/drm/drm_gem.c               | 6 +++---
 drivers/gpu/drm/exynos/exynos_drm_gem.c | 3 +--
 include/drm/drm_gem.h                   | 4 ++--
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_dumb_buffers.c
index 81dfdd33753a..956665464296 100644
--- a/drivers/gpu/drm/drm_dumb_buffers.c
+++ b/drivers/gpu/drm/drm_dumb_buffers.c
@@ -46,7 +46,7 @@
  * To support dumb objects drivers must implement the &drm_driver.dumb_create
  * operation. &drm_driver.dumb_destroy defaults to drm_gem_dumb_destroy() if
  * not set and &drm_driver.dumb_map_offset defaults to
- * drm_gem_dumb_map_offset(). See the callbacks for further details.
+ * drm_gem_map_offset(). See the callbacks for further details.
  *
  * Note that dumb objects may not be used for gpu acceleration, as has been
  * attempted on some ARM embedded platforms. Such drivers really must have
@@ -125,7 +125,7 @@ int drm_mode_mmap_dumb_ioctl(struct drm_device *dev,
 						    args->handle,
 						    &args->offset);
 	else
-		return drm_gem_dumb_map_offset(file_priv, dev, args->handle,
+		return drm_gem_map_offset(file_priv, dev, args->handle,
 					       &args->offset);
 }
 
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 50de138c89e0..99bb7f79a70b 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -294,7 +294,7 @@ drm_gem_handle_delete(struct drm_file *filp, u32 handle)
 EXPORT_SYMBOL(drm_gem_handle_delete);
 
 /**
- * drm_gem_dumb_map_offset - return the fake mmap offset for a gem object
+ * drm_gem_map_offset - return the fake mmap offset for a gem object
  * @file: drm file-private structure containing the gem object
  * @dev: corresponding drm_device
  * @handle: gem object handle
@@ -306,7 +306,7 @@ EXPORT_SYMBOL(drm_gem_handle_delete);
  * Returns:
  * 0 on success or a negative error code on failure.
  */
-int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
+int drm_gem_map_offset(struct drm_file *file, struct drm_device *dev,
 			    u32 handle, u64 *offset)
 {
 	struct drm_gem_object *obj;
@@ -332,7 +332,7 @@ int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(drm_gem_dumb_map_offset);
+EXPORT_SYMBOL_GPL(drm_gem_map_offset);
 
 /**
  * drm_gem_dumb_destroy - dumb fb callback helper for gem based drivers
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index a55f5ac41bf3..5e3aa9e4a096 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -276,8 +276,7 @@ int exynos_drm_gem_map_ioctl(struct drm_device *dev, void *data,
 {
 	struct drm_exynos_gem_map *args = data;
 
-	return drm_gem_dumb_map_offset(file_priv, dev, args->handle,
-				       &args->offset);
+	return drm_gem_map_offset(file_priv, dev, args->handle, &args->offset);
 }
 
 struct exynos_drm_gem *exynos_drm_gem_get(struct drm_file *filp,
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 5047c7ee25f5..91b07c2325e9 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -395,8 +395,8 @@ int drm_gem_fence_array_add(struct xarray *fence_array,
 int drm_gem_fence_array_add_implicit(struct xarray *fence_array,
 				     struct drm_gem_object *obj,
 				     bool write);
-int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
-			    u32 handle, u64 *offset);
+int drm_gem_map_offset(struct drm_file *file, struct drm_device *dev,
+		       u32 handle, u64 *offset);
 int drm_gem_dumb_destroy(struct drm_file *file,
 			 struct drm_device *dev,
 			 uint32_t handle);
-- 
2.20.1

