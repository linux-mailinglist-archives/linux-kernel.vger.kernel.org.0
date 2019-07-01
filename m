Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3435858658
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 17:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfF0Pxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 11:53:34 -0400
Received: from foss.arm.com ([217.140.110.172]:57532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfF0Pxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:53:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4331E142F;
        Thu, 27 Jun 2019 08:53:29 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B09C3F246;
        Thu, 27 Jun 2019 08:53:26 -0700 (PDT)
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
Subject: [PATCH v4 1/2] drm/gem: Rename drm_gem_dumb_map_offset() to drm_gem_map_offset()
Date:   Thu, 27 Jun 2019 16:53:17 +0100
Message-Id: <20190627155318.38053-2-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627155318.38053-1-steven.price@arm.com>
References: <20190627155318.38053-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_gem_dumb_map_offset() is a useful helper for non-dumb clients, so
rename it to remove the _dumb and add a comment that it can be used by
shmem clients.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/drm_dumb_buffers.c      | 4 ++--
 drivers/gpu/drm/drm_gem.c               | 9 ++++++---
 drivers/gpu/drm/exynos/exynos_drm_gem.c | 3 +--
 include/drm/drm_gem.h                   | 4 ++--
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_dumb_buffers.c
index d18a740fe0f1..b55cfc9e8772 100644
--- a/drivers/gpu/drm/drm_dumb_buffers.c
+++ b/drivers/gpu/drm/drm_dumb_buffers.c
@@ -48,7 +48,7 @@
  * To support dumb objects drivers must implement the &drm_driver.dumb_create
  * operation. &drm_driver.dumb_destroy defaults to drm_gem_dumb_destroy() if
  * not set and &drm_driver.dumb_map_offset defaults to
- * drm_gem_dumb_map_offset(). See the callbacks for further details.
+ * drm_gem_map_offset(). See the callbacks for further details.
  *
  * Note that dumb objects may not be used for gpu acceleration, as has been
  * attempted on some ARM embedded platforms. Such drivers really must have
@@ -127,7 +127,7 @@ int drm_mode_mmap_dumb_ioctl(struct drm_device *dev,
 						    args->handle,
 						    &args->offset);
 	else
-		return drm_gem_dumb_map_offset(file_priv, dev, args->handle,
+		return drm_gem_map_offset(file_priv, dev, args->handle,
 					       &args->offset);
 }
 
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index a8c4468f03d9..62842b7701bb 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -298,7 +298,7 @@ drm_gem_handle_delete(struct drm_file *filp, u32 handle)
 EXPORT_SYMBOL(drm_gem_handle_delete);
 
 /**
- * drm_gem_dumb_map_offset - return the fake mmap offset for a gem object
+ * drm_gem_map_offset - return the fake mmap offset for a gem object
  * @file: drm file-private structure containing the gem object
  * @dev: corresponding drm_device
  * @handle: gem object handle
@@ -307,10 +307,13 @@ EXPORT_SYMBOL(drm_gem_handle_delete);
  * This implements the &drm_driver.dumb_map_offset kms driver callback for
  * drivers which use gem to manage their backing storage.
  *
+ * It can also be used by drivers using the shmem backend as they have the
+ * same restriction that imported objects cannot be mapped.
+ *
  * Returns:
  * 0 on success or a negative error code on failure.
  */
-int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
+int drm_gem_map_offset(struct drm_file *file, struct drm_device *dev,
 			    u32 handle, u64 *offset)
 {
 	struct drm_gem_object *obj;
@@ -336,7 +339,7 @@ int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(drm_gem_dumb_map_offset);
+EXPORT_SYMBOL_GPL(drm_gem_map_offset);
 
 /**
  * drm_gem_dumb_destroy - dumb fb callback helper for gem based drivers
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index d8f1fe9b68d8..3b8cffc7a8e0 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -272,8 +272,7 @@ int exynos_drm_gem_map_ioctl(struct drm_device *dev, void *data,
 {
 	struct drm_exynos_gem_map *args = data;
 
-	return drm_gem_dumb_map_offset(file_priv, dev, args->handle,
-				       &args->offset);
+	return drm_gem_map_offset(file_priv, dev, args->handle, &args->offset);
 }
 
 struct exynos_drm_gem *exynos_drm_gem_get(struct drm_file *filp,
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index a9121fe66ea2..65b884930583 100644
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

