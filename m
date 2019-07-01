Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7F804E77B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 13:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfFUL6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 07:58:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbfFUL6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:58:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22E4E3082E03;
        Fri, 21 Jun 2019 11:58:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-212.ams2.redhat.com [10.36.116.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3642460852;
        Fri, 21 Jun 2019 11:58:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3FEC417538; Fri, 21 Jun 2019 13:57:57 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     ckoenig.leichtzumerken@gmail.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 06/18] drm/nouveau: use embedded gem object
Date:   Fri, 21 Jun 2019 13:57:43 +0200
Message-Id: <20190621115755.8481-7-kraxel@redhat.com>
In-Reply-To: <20190621115755.8481-1-kraxel@redhat.com>
References: <20190621115755.8481-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 21 Jun 2019 11:58:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop drm_gem_object from nouveau_bo, use the
ttm_buffer_object.base instead.

Build tested only.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.h      |  5 -----
 drivers/gpu/drm/nouveau/nouveau_gem.h     |  2 +-
 drivers/gpu/drm/nouveau/nouveau_abi16.c   |  4 ++--
 drivers/gpu/drm/nouveau/nouveau_bo.c      |  4 ++--
 drivers/gpu/drm/nouveau/nouveau_display.c |  8 ++++----
 drivers/gpu/drm/nouveau/nouveau_gem.c     | 15 ++++++++-------
 drivers/gpu/drm/nouveau/nouveau_prime.c   |  4 ++--
 7 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.h b/drivers/gpu/drm/nouveau/nouveau_bo.h
index 846f4bdec0de..40f01b9a07d4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.h
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.h
@@ -35,11 +35,6 @@ struct nouveau_bo {
 
 	struct nouveau_drm_tile *tile;
 
-	/* Only valid if allocated via nouveau_gem_new() and iff you hold a
-	 * gem reference to it! For debugging, use gem.filp != NULL to test
-	 * whether it is valid. */
-	struct drm_gem_object gem;
-
 	/* protect by the ttm reservation lock */
 	int pin_refcnt;
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.h b/drivers/gpu/drm/nouveau/nouveau_gem.h
index fe39998f65cc..477cd0fb050f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.h
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.h
@@ -10,7 +10,7 @@
 static inline struct nouveau_bo *
 nouveau_gem_object(struct drm_gem_object *gem)
 {
-	return gem ? container_of(gem, struct nouveau_bo, gem) : NULL;
+	return gem ? container_of(gem, struct nouveau_bo, bo.base) : NULL;
 }
 
 /* nouveau_gem.c */
diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
index c3fd5dd39ed9..94387e62b338 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -139,7 +139,7 @@ nouveau_abi16_chan_fini(struct nouveau_abi16 *abi16,
 	if (chan->ntfy) {
 		nouveau_vma_del(&chan->ntfy_vma);
 		nouveau_bo_unpin(chan->ntfy);
-		drm_gem_object_put_unlocked(&chan->ntfy->gem);
+		drm_gem_object_put_unlocked(&chan->ntfy->bo.base);
 	}
 
 	if (chan->heap.block_size)
@@ -345,7 +345,7 @@ nouveau_abi16_ioctl_channel_alloc(ABI16_IOCTL_ARGS)
 			goto done;
 	}
 
-	ret = drm_gem_handle_create(file_priv, &chan->ntfy->gem,
+	ret = drm_gem_handle_create(file_priv, &chan->ntfy->bo.base,
 				    &init->notifier_handle);
 	if (ret)
 		goto done;
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 34a998012bf6..376215b2206f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -136,7 +136,7 @@ nouveau_bo_del_ttm(struct ttm_buffer_object *bo)
 	struct drm_device *dev = drm->dev;
 	struct nouveau_bo *nvbo = nouveau_bo(bo);
 
-	if (unlikely(nvbo->gem.filp))
+	if (unlikely(nvbo->bo.base.filp))
 		DRM_ERROR("bo %p still attached to GEM object\n", bo);
 	WARN_ON(nvbo->pin_refcnt > 0);
 	nv10_bo_put_tile_region(dev, nvbo->tile, NULL);
@@ -1400,7 +1400,7 @@ nouveau_bo_verify_access(struct ttm_buffer_object *bo, struct file *filp)
 {
 	struct nouveau_bo *nvbo = nouveau_bo(bo);
 
-	return drm_vma_node_verify_access(&nvbo->gem.vma_node,
+	return drm_vma_node_verify_access(&nvbo->bo.base.vma_node,
 					  filp->private_data);
 }
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index 832da8e0020d..fc8f5bb73ca8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -201,7 +201,7 @@ nouveau_user_framebuffer_destroy(struct drm_framebuffer *drm_fb)
 	struct nouveau_framebuffer *fb = nouveau_framebuffer(drm_fb);
 
 	if (fb->nvbo)
-		drm_gem_object_put_unlocked(&fb->nvbo->gem);
+		drm_gem_object_put_unlocked(&fb->nvbo->bo.base);
 
 	drm_framebuffer_cleanup(drm_fb);
 	kfree(fb);
@@ -214,7 +214,7 @@ nouveau_user_framebuffer_create_handle(struct drm_framebuffer *drm_fb,
 {
 	struct nouveau_framebuffer *fb = nouveau_framebuffer(drm_fb);
 
-	return drm_gem_handle_create(file_priv, &fb->nvbo->gem, handle);
+	return drm_gem_handle_create(file_priv, &fb->nvbo->bo.base, handle);
 }
 
 static const struct drm_framebuffer_funcs nouveau_framebuffer_funcs = {
@@ -660,8 +660,8 @@ nouveau_display_dumb_create(struct drm_file *file_priv, struct drm_device *dev,
 	if (ret)
 		return ret;
 
-	ret = drm_gem_handle_create(file_priv, &bo->gem, &args->handle);
-	drm_gem_object_put_unlocked(&bo->gem);
+	ret = drm_gem_handle_create(file_priv, &bo->bo.base, &args->handle);
+	drm_gem_object_put_unlocked(&bo->bo.base);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index b4bda716564d..2f484ab7dbca 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -205,13 +205,13 @@ nouveau_gem_new(struct nouveau_cli *cli, u64 size, int align, uint32_t domain,
 
 	/* Initialize the embedded gem-object. We return a single gem-reference
 	 * to the caller, instead of a normal nouveau_bo ttm reference. */
-	ret = drm_gem_object_init(drm->dev, &nvbo->gem, nvbo->bo.mem.size);
+	ret = drm_gem_object_init(drm->dev, &nvbo->bo.base, nvbo->bo.mem.size);
 	if (ret) {
 		nouveau_bo_ref(NULL, pnvbo);
 		return -ENOMEM;
 	}
 
-	nvbo->bo.persistent_swap_storage = nvbo->gem.filp;
+	nvbo->bo.persistent_swap_storage = nvbo->bo.base.filp;
 	return 0;
 }
 
@@ -268,15 +268,16 @@ nouveau_gem_ioctl_new(struct drm_device *dev, void *data,
 	if (ret)
 		return ret;
 
-	ret = drm_gem_handle_create(file_priv, &nvbo->gem, &req->info.handle);
+	ret = drm_gem_handle_create(file_priv, &nvbo->bo.base,
+				    &req->info.handle);
 	if (ret == 0) {
-		ret = nouveau_gem_info(file_priv, &nvbo->gem, &req->info);
+		ret = nouveau_gem_info(file_priv, &nvbo->bo.base, &req->info);
 		if (ret)
 			drm_gem_handle_delete(file_priv, req->info.handle);
 	}
 
 	/* drop reference from allocate - handle holds it now */
-	drm_gem_object_put_unlocked(&nvbo->gem);
+	drm_gem_object_put_unlocked(&nvbo->bo.base);
 	return ret;
 }
 
@@ -355,7 +356,7 @@ validate_fini_no_ticket(struct validate_op *op, struct nouveau_channel *chan,
 		list_del(&nvbo->entry);
 		nvbo->reserved_by = NULL;
 		ttm_bo_unreserve(&nvbo->bo);
-		drm_gem_object_put_unlocked(&nvbo->gem);
+		drm_gem_object_put_unlocked(&nvbo->bo.base);
 	}
 }
 
@@ -493,7 +494,7 @@ validate_list(struct nouveau_channel *chan, struct nouveau_cli *cli,
 	list_for_each_entry(nvbo, list, entry) {
 		struct drm_nouveau_gem_pushbuf_bo *b = &pbbo[nvbo->pbbo_index];
 
-		ret = nouveau_gem_set_domain(&nvbo->gem, b->read_domains,
+		ret = nouveau_gem_set_domain(&nvbo->bo.base, b->read_domains,
 					     b->write_domains,
 					     b->valid_domains);
 		if (unlikely(ret)) {
diff --git a/drivers/gpu/drm/nouveau/nouveau_prime.c b/drivers/gpu/drm/nouveau/nouveau_prime.c
index 1fefc93af1d7..0750caf86e12 100644
--- a/drivers/gpu/drm/nouveau/nouveau_prime.c
+++ b/drivers/gpu/drm/nouveau/nouveau_prime.c
@@ -79,13 +79,13 @@ struct drm_gem_object *nouveau_gem_prime_import_sg_table(struct drm_device *dev,
 
 	/* Initialize the embedded gem-object. We return a single gem-reference
 	 * to the caller, instead of a normal nouveau_bo ttm reference. */
-	ret = drm_gem_object_init(dev, &nvbo->gem, nvbo->bo.mem.size);
+	ret = drm_gem_object_init(dev, &nvbo->bo.base, nvbo->bo.mem.size);
 	if (ret) {
 		nouveau_bo_ref(NULL, &nvbo);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	return &nvbo->gem;
+	return &nvbo->bo.base;
 }
 
 int nouveau_gem_prime_pin(struct drm_gem_object *obj)
-- 
2.18.1

