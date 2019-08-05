Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C13D819DA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 14:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfHEMoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 08:44:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728809AbfHEMnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:43:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25D5E3082115;
        Mon,  5 Aug 2019 12:43:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BC8352EE;
        Mon,  5 Aug 2019 12:43:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5DDA39DBD; Mon,  5 Aug 2019 14:43:12 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     intel-gfx@lists.freedesktop.org, thomas@shipmail.org,
        tzimmermann@suse.de, ckoenig.leichtzumerken@gmail.com,
        bskeggs@redhat.com, daniel@ffwll.ch,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 06/18] drm/nouveau: use embedded gem object
Date:   Mon,  5 Aug 2019 14:42:58 +0200
Message-Id: <20190805124310.3275-7-kraxel@redhat.com>
In-Reply-To: <20190805124310.3275-1-kraxel@redhat.com>
References: <20190805124310.3275-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 05 Aug 2019 12:43:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop drm_gem_object from nouveau_bo, use the
ttm_buffer_object.base instead.

Build tested only.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.h      |  5 -----
 drivers/gpu/drm/nouveau/nouveau_gem.h     |  2 +-
 drivers/gpu/drm/nouveau/nouveau_abi16.c   |  4 ++--
 drivers/gpu/drm/nouveau/nouveau_bo.c      |  6 +++---
 drivers/gpu/drm/nouveau/nouveau_display.c |  8 ++++----
 drivers/gpu/drm/nouveau/nouveau_gem.c     | 15 ++++++++-------
 drivers/gpu/drm/nouveau/nouveau_prime.c   |  4 ++--
 7 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.h b/drivers/gpu/drm/nouveau/nouveau_bo.h
index 383ac36d5869..d675efe8e7f9 100644
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
index d67e2f9ec59c..40ba0f1ba5aa 100644
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
index 0c585dc5f5c3..e2bae1424502 100644
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
@@ -339,7 +339,7 @@ nouveau_abi16_ioctl_channel_alloc(ABI16_IOCTL_ARGS)
 			goto done;
 	}
 
-	ret = drm_gem_handle_create(file_priv, &chan->ntfy->gem,
+	ret = drm_gem_handle_create(file_priv, &chan->ntfy->bo.base,
 				    &init->notifier_handle);
 	if (ret)
 		goto done;
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 6f1217b3e6b9..abbbabd12241 100644
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
@@ -299,7 +299,7 @@ nouveau_bo_new(struct nouveau_cli *cli, u64 size, int align,
 			  type, &nvbo->placement,
 			  align >> PAGE_SHIFT, false, acc_size, sg,
 			  robj, nouveau_bo_del_ttm);
-	nvbo->gem.resv = nvbo->bo.resv;
+	nvbo->bo.base.resv = nvbo->bo.resv;
 
 	if (ret) {
 		/* ttm will call nouveau_bo_del_ttm if it fails.. */
@@ -1402,7 +1402,7 @@ nouveau_bo_verify_access(struct ttm_buffer_object *bo, struct file *filp)
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
index 8478c3c9ffcd..e86ad7ae622b 100644
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

