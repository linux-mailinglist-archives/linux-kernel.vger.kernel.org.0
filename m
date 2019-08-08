Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F43885EB0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 11:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbfHHJhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 05:37:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732432AbfHHJhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:37:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 441EEC04D293;
        Thu,  8 Aug 2019 09:37:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F24595C220;
        Thu,  8 Aug 2019 09:37:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 431829D13; Thu,  8 Aug 2019 11:37:03 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/8] drm/vram: switch vram helpers to the new gem_ttm_bo_device_init()
Date:   Thu,  8 Aug 2019 11:36:58 +0200
Message-Id: <20190808093702.29512-5-kraxel@redhat.com>
In-Reply-To: <20190808093702.29512-1-kraxel@redhat.com>
References: <20190808093702.29512-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 08 Aug 2019 09:37:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_vram_helper.h             |  6 +--
 drivers/gpu/drm/drm_gem_vram_helper.c         | 48 -------------------
 drivers/gpu/drm/drm_vram_mm_helper.c          |  6 +--
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  1 -
 drivers/gpu/drm/Kconfig                       |  1 +
 5 files changed, 5 insertions(+), 57 deletions(-)

diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index ac217d768456..701d2c46a4f4 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -4,6 +4,7 @@
 #define DRM_GEM_VRAM_HELPER_H
 
 #include <drm/drm_gem.h>
+#include <drm/drm_gem_ttm_helper.h>
 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_placement.h>
 #include <linux/kernel.h> /* for container_of() */
@@ -76,7 +77,6 @@ struct drm_gem_vram_object *drm_gem_vram_create(struct drm_device *dev,
 						unsigned long pg_align,
 						bool interruptible);
 void drm_gem_vram_put(struct drm_gem_vram_object *gbo);
-u64 drm_gem_vram_mmap_offset(struct drm_gem_vram_object *gbo);
 s64 drm_gem_vram_offset(struct drm_gem_vram_object *gbo);
 int drm_gem_vram_pin(struct drm_gem_vram_object *gbo, unsigned long pl_flag);
 int drm_gem_vram_unpin(struct drm_gem_vram_object *gbo);
@@ -110,9 +110,6 @@ extern const struct drm_vram_mm_funcs drm_gem_vram_mm_funcs;
 int drm_gem_vram_driver_dumb_create(struct drm_file *file,
 				    struct drm_device *dev,
 				    struct drm_mode_create_dumb *args);
-int drm_gem_vram_driver_dumb_mmap_offset(struct drm_file *file,
-					 struct drm_device *dev,
-					 uint32_t handle, uint64_t *offset);
 
 /**
  * define DRM_GEM_VRAM_DRIVER - default callback functions for \
@@ -123,7 +120,6 @@ int drm_gem_vram_driver_dumb_mmap_offset(struct drm_file *file,
  */
 #define DRM_GEM_VRAM_DRIVER \
 	.dumb_create		  = drm_gem_vram_driver_dumb_create, \
-	.dumb_map_offset	  = drm_gem_vram_driver_dumb_mmap_offset, \
 	.gem_prime_mmap		  = drm_gem_prime_mmap
 
 #endif
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index fd751078bae1..b78865055990 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -156,22 +156,6 @@ void drm_gem_vram_put(struct drm_gem_vram_object *gbo)
 }
 EXPORT_SYMBOL(drm_gem_vram_put);
 
-/**
- * drm_gem_vram_mmap_offset() - Returns a GEM VRAM object's mmap offset
- * @gbo:	the GEM VRAM object
- *
- * See drm_vma_node_offset_addr() for more information.
- *
- * Returns:
- * The buffer object's offset for userspace mappings on success, or
- * 0 if no offset is allocated.
- */
-u64 drm_gem_vram_mmap_offset(struct drm_gem_vram_object *gbo)
-{
-	return drm_vma_node_offset_addr(&gbo->bo.base.vma_node);
-}
-EXPORT_SYMBOL(drm_gem_vram_mmap_offset);
-
 /**
  * drm_gem_vram_offset() - \
 	Returns a GEM VRAM object's offset in video memory
@@ -511,38 +495,6 @@ int drm_gem_vram_driver_dumb_create(struct drm_file *file,
 }
 EXPORT_SYMBOL(drm_gem_vram_driver_dumb_create);
 
-/**
- * drm_gem_vram_driver_dumb_mmap_offset() - \
-	Implements &struct drm_driver.dumb_mmap_offset
- * @file:	DRM file pointer.
- * @dev:	DRM device.
- * @handle:	GEM handle
- * @offset:	Returns the mapping's memory offset on success
- *
- * Returns:
- * 0 on success, or
- * a negative errno code otherwise.
- */
-int drm_gem_vram_driver_dumb_mmap_offset(struct drm_file *file,
-					 struct drm_device *dev,
-					 uint32_t handle, uint64_t *offset)
-{
-	struct drm_gem_object *gem;
-	struct drm_gem_vram_object *gbo;
-
-	gem = drm_gem_object_lookup(file, handle);
-	if (!gem)
-		return -ENOENT;
-
-	gbo = drm_gem_vram_of_gem(gem);
-	*offset = drm_gem_vram_mmap_offset(gbo);
-
-	drm_gem_object_put_unlocked(gem);
-
-	return 0;
-}
-EXPORT_SYMBOL(drm_gem_vram_driver_dumb_mmap_offset);
-
 /*
  * PRIME helpers
  */
diff --git a/drivers/gpu/drm/drm_vram_mm_helper.c b/drivers/gpu/drm/drm_vram_mm_helper.c
index c911781d6728..a693f9ce356c 100644
--- a/drivers/gpu/drm/drm_vram_mm_helper.c
+++ b/drivers/gpu/drm/drm_vram_mm_helper.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include <drm/drm_gem_ttm_helper.h>
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
 #include <drm/drm_vram_mm_helper.h>
@@ -170,9 +171,8 @@ int drm_vram_mm_init(struct drm_vram_mm *vmm, struct drm_device *dev,
 	vmm->vram_size = vram_size;
 	vmm->funcs = funcs;
 
-	ret = ttm_bo_device_init(&vmm->bdev, &bo_driver,
-				 dev->anon_inode->i_mapping,
-				 true);
+	ret = drm_gem_ttm_bo_device_init(dev, &vmm->bdev, &bo_driver,
+					 true);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 2ae538835781..6386c67e086b 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -59,7 +59,6 @@ static struct drm_driver hibmc_driver = {
 	.major			= 1,
 	.minor			= 0,
 	.dumb_create            = hibmc_dumb_create,
-	.dumb_map_offset        = drm_gem_vram_driver_dumb_mmap_offset,
 	.gem_prime_mmap		= drm_gem_prime_mmap,
 	.irq_handler		= hibmc_drm_interrupt,
 };
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index f7b25519f95c..1be8ad30d8fe 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -169,6 +169,7 @@ config DRM_VRAM_HELPER
 	tristate
 	depends on DRM
 	select DRM_TTM
+	select DRM_TTM_HELPER
 	help
 	  Helpers for VRAM memory management
 
-- 
2.18.1

