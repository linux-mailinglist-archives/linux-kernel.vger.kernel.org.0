Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C47832C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 15:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbfHFNfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 09:35:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfHFNfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:35:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 442B630C0624;
        Tue,  6 Aug 2019 13:35:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D10CA60933;
        Tue,  6 Aug 2019 13:34:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BB86617446; Tue,  6 Aug 2019 15:34:54 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] drm: add gem ttm helpers
Date:   Tue,  6 Aug 2019 15:34:52 +0200
Message-Id: <20190806133454.8254-2-kraxel@redhat.com>
In-Reply-To: <20190806133454.8254-1-kraxel@redhat.com>
References: <20190806133454.8254-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 06 Aug 2019 13:35:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now with ttm_buffer_object being a subclass of drm_gem_object we can
easily lookup ttm_buffer_object for a given drm_gem_object, which in
turm allows to create common helper functions.  This patch starts off
with dump mmap helpers.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_ttm_helper.h     | 27 +++++++++++++++
 drivers/gpu/drm/drm_gem_ttm_helper.c | 52 ++++++++++++++++++++++++++++
 drivers/gpu/drm/Kconfig              |  7 ++++
 drivers/gpu/drm/Makefile             |  3 ++
 4 files changed, 89 insertions(+)
 create mode 100644 include/drm/drm_gem_ttm_helper.h
 create mode 100644 drivers/gpu/drm/drm_gem_ttm_helper.c

diff --git a/include/drm/drm_gem_ttm_helper.h b/include/drm/drm_gem_ttm_helper.h
new file mode 100644
index 000000000000..2c6874190b17
--- /dev/null
+++ b/include/drm/drm_gem_ttm_helper.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef DRM_GEM_TTM_HELPER_H
+#define DRM_GEM_TTM_HELPER_H
+
+#include <drm/drm_gem.h>
+#include <drm/ttm/ttm_bo_api.h>
+#include <linux/kernel.h> /* for container_of() */
+
+/**
+ * Returns the container of type &struct ttm_buffer_object
+ * for field base.
+ * @gem:	the GEM object
+ * Returns:	The containing GEM VRAM object
+ */
+static inline struct ttm_buffer_object *drm_gem_ttm_of_gem(
+	struct drm_gem_object *gem)
+{
+	return container_of(gem, struct ttm_buffer_object, base);
+}
+
+u64 drm_gem_ttm_mmap_offset(struct ttm_buffer_object *bo);
+int drm_gem_ttm_driver_dumb_mmap_offset(struct drm_file *file,
+					struct drm_device *dev,
+					uint32_t handle, uint64_t *offset);
+
+#endif
diff --git a/drivers/gpu/drm/drm_gem_ttm_helper.c b/drivers/gpu/drm/drm_gem_ttm_helper.c
new file mode 100644
index 000000000000..b069bd0c4c94
--- /dev/null
+++ b/drivers/gpu/drm/drm_gem_ttm_helper.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <drm/drm_gem_ttm_helper.h>
+
+/**
+ * drm_gem_ttm_mmap_offset() - Returns a GEM ttm object's mmap offset
+ * @gbo:	the GEM ttm object
+ *
+ * See drm_vma_node_offset_addr() for more information.
+ *
+ * Returns:
+ * The buffer object's offset for userspace mappings on success, or
+ * 0 if no offset is allocated.
+ */
+u64 drm_gem_ttm_mmap_offset(struct ttm_buffer_object *bo)
+{
+	return drm_vma_node_offset_addr(&bo->base.vma_node);
+}
+EXPORT_SYMBOL(drm_gem_ttm_mmap_offset);
+
+/**
+ * drm_gem_ttm_driver_dumb_mmap_offset() - \
+	Implements &struct drm_driver.dumb_mmap_offset
+ * @file:	DRM file pointer.
+ * @dev:	DRM device.
+ * @handle:	GEM handle
+ * @offset:	Returns the mapping's memory offset on success
+ *
+ * Returns:
+ * 0 on success, or
+ * a negative errno code otherwise.
+ */
+int drm_gem_ttm_driver_dumb_mmap_offset(struct drm_file *file,
+					 struct drm_device *dev,
+					 uint32_t handle, uint64_t *offset)
+{
+	struct drm_gem_object *gem;
+	struct ttm_buffer_object *bo;
+
+	gem = drm_gem_object_lookup(file, handle);
+	if (!gem)
+		return -ENOENT;
+
+	bo = drm_gem_ttm_of_gem(gem);
+	*offset = drm_gem_ttm_mmap_offset(bo);
+
+	drm_gem_object_put_unlocked(gem);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_gem_ttm_driver_dumb_mmap_offset);
+
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index e6f40fb54c9a..f7b25519f95c 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -172,6 +172,13 @@ config DRM_VRAM_HELPER
 	help
 	  Helpers for VRAM memory management
 
+config DRM_TTM_HELPER
+	tristate
+	depends on DRM
+	select DRM_TTM
+	help
+	  Helpers for ttm-based gem objects
+
 config DRM_GEM_CMA_HELPER
 	bool
 	depends on DRM
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 10f8329a8b71..545c61d6528b 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -37,6 +37,9 @@ drm_vram_helper-y := drm_gem_vram_helper.o \
 		     drm_vram_mm_helper.o
 obj-$(CONFIG_DRM_VRAM_HELPER) += drm_vram_helper.o
 
+drm_ttm_helper-y := drm_gem_ttm_helper.o
+obj-$(CONFIG_DRM_TTM_HELPER) += drm_ttm_helper.o
+
 drm_kms_helper-y := drm_crtc_helper.o drm_dp_helper.o drm_dsc.o drm_probe_helper.o \
 		drm_plane_helper.o drm_dp_mst_topology.o drm_atomic_helper.o \
 		drm_kms_helper_common.o drm_dp_dual_mode_helper.o \
-- 
2.18.1

