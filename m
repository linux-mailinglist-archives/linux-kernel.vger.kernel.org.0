Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED81B4A69
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 11:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfIQJYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 05:24:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbfIQJYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:24:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E56363082B3F;
        Tue, 17 Sep 2019 09:24:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FB785C21E;
        Tue, 17 Sep 2019 09:24:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B16399D31; Tue, 17 Sep 2019 11:24:05 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Eric Anholt <eric@anholt.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        QEMU'S CIRRUS DEVICE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 05/11] drm/shmem: drop DEFINE_DRM_GEM_SHMEM_FOPS
Date:   Tue, 17 Sep 2019 11:23:58 +0200
Message-Id: <20190917092404.9982-6-kraxel@redhat.com>
In-Reply-To: <20190917092404.9982-1-kraxel@redhat.com>
References: <20190917092404.9982-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 17 Sep 2019 09:24:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEFINE_DRM_GEM_SHMEM_FOPS is identical
to DEFINE_DRM_GEM_FOPS now, drop it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/drm/drm_gem_shmem_helper.h      | 26 -------------------------
 drivers/gpu/drm/cirrus/cirrus.c         |  2 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c |  2 +-
 drivers/gpu/drm/tiny/gm12u320.c         |  2 +-
 drivers/gpu/drm/v3d/v3d_drv.c           |  2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c    |  2 +-
 6 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index d89f2116c8ab..6748379a0b44 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -88,32 +88,6 @@ struct drm_gem_shmem_object {
 #define to_drm_gem_shmem_obj(obj) \
 	container_of(obj, struct drm_gem_shmem_object, base)
 
-/**
- * DEFINE_DRM_GEM_SHMEM_FOPS() - Macro to generate file operations for shmem drivers
- * @name: name for the generated structure
- *
- * This macro autogenerates a suitable &struct file_operations for shmem based
- * drivers, which can be assigned to &drm_driver.fops. Note that this structure
- * cannot be shared between drivers, because it contains a reference to the
- * current module using THIS_MODULE.
- *
- * Note that the declaration is already marked as static - if you need a
- * non-static version of this you're probably doing it wrong and will break the
- * THIS_MODULE reference by accident.
- */
-#define DEFINE_DRM_GEM_SHMEM_FOPS(name) \
-	static const struct file_operations name = {\
-		.owner		= THIS_MODULE,\
-		.open		= drm_open,\
-		.release	= drm_release,\
-		.unlocked_ioctl	= drm_ioctl,\
-		.compat_ioctl	= drm_compat_ioctl,\
-		.poll		= drm_poll,\
-		.read		= drm_read,\
-		.llseek		= noop_llseek,\
-		.mmap		= drm_gem_mmap, \
-	}
-
 struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t size);
 void drm_gem_shmem_free_object(struct drm_gem_object *obj);
 
diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
index 89d9e6fdeb8c..7d08d067e1a4 100644
--- a/drivers/gpu/drm/cirrus/cirrus.c
+++ b/drivers/gpu/drm/cirrus/cirrus.c
@@ -510,7 +510,7 @@ static void cirrus_mode_config_init(struct cirrus_device *cirrus)
 
 /* ------------------------------------------------------------------ */
 
-DEFINE_DRM_GEM_SHMEM_FOPS(cirrus_fops);
+DEFINE_DRM_GEM_FOPS(cirrus_fops);
 
 static struct drm_driver cirrus_driver = {
 	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index d74442d71048..a78ce21594d7 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -470,7 +470,7 @@ static const struct drm_ioctl_desc panfrost_drm_driver_ioctls[] = {
 	PANFROST_IOCTL(MADVISE,		madvise,	DRM_RENDER_ALLOW),
 };
 
-DEFINE_DRM_GEM_SHMEM_FOPS(panfrost_drm_driver_fops);
+DEFINE_DRM_GEM_FOPS(panfrost_drm_driver_fops);
 
 /*
  * Panfrost driver version:
diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index 03d0e2df6774..94fb1f593564 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -649,7 +649,7 @@ static void gm12u320_driver_release(struct drm_device *dev)
 	kfree(gm12u320);
 }
 
-DEFINE_DRM_GEM_SHMEM_FOPS(gm12u320_fops);
+DEFINE_DRM_GEM_FOPS(gm12u320_fops);
 
 static struct drm_driver gm12u320_drm_driver = {
 	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 3506ae2723ae..03e4fbe1b92b 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -169,7 +169,7 @@ v3d_postclose(struct drm_device *dev, struct drm_file *file)
 	kfree(v3d_priv);
 }
 
-DEFINE_DRM_GEM_SHMEM_FOPS(v3d_drm_fops);
+DEFINE_DRM_GEM_FOPS(v3d_drm_fops);
 
 /* DRM_AUTH is required on SUBMIT_CL for now, while we don't have GMP
  * protection between clients.  Note that render nodes would be be
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index a5cb58754f7d..8dee698c90ff 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -184,7 +184,7 @@ MODULE_AUTHOR("Dave Airlie <airlied@redhat.com>");
 MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
 MODULE_AUTHOR("Alon Levy");
 
-DEFINE_DRM_GEM_SHMEM_FOPS(virtio_gpu_driver_fops);
+DEFINE_DRM_GEM_FOPS(virtio_gpu_driver_fops);
 
 static struct drm_driver driver = {
 	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_RENDER | DRIVER_ATOMIC,
-- 
2.18.1

