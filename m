Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF024C893
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 09:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbfFTHoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 03:44:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfFTHof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 03:44:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91E88C18B2DC;
        Thu, 20 Jun 2019 07:44:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-212.ams2.redhat.com [10.36.116.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2285A5D719;
        Thu, 20 Jun 2019 07:44:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 767E017510; Thu, 20 Jun 2019 09:44:24 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/6] drm/vram: use embedded gem object
Date:   Thu, 20 Jun 2019 09:44:20 +0200
Message-Id: <20190620074424.1677-3-kraxel@redhat.com>
In-Reply-To: <20190620074424.1677-1-kraxel@redhat.com>
References: <20190620074424.1677-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 20 Jun 2019 07:44:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop drm_gem_object from drm_gem_vram_object, use the
ttm_buffer_object.base instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_vram_helper.h     |  3 +--
 drivers/gpu/drm/drm_gem_vram_helper.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 9581ea0a4f7e..7b9f50ba3fce 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -36,7 +36,6 @@ struct vm_area_struct;
  * video memory becomes scarce.
  */
 struct drm_gem_vram_object {
-	struct drm_gem_object gem;
 	struct ttm_buffer_object bo;
 	struct ttm_bo_kmap_obj kmap;
 
@@ -68,7 +67,7 @@ static inline struct drm_gem_vram_object *drm_gem_vram_of_bo(
 static inline struct drm_gem_vram_object *drm_gem_vram_of_gem(
 	struct drm_gem_object *gem)
 {
-	return container_of(gem, struct drm_gem_vram_object, gem);
+	return container_of(gem, struct drm_gem_vram_object, bo.base);
 }
 
 struct drm_gem_vram_object *drm_gem_vram_create(struct drm_device *dev,
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 4de782ca26b2..61d9520cc15f 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -24,7 +24,7 @@ static void drm_gem_vram_cleanup(struct drm_gem_vram_object *gbo)
 	 * TTM buffer object in 'bo' has already been cleaned
 	 * up; only release the GEM object.
 	 */
-	drm_gem_object_release(&gbo->gem);
+	drm_gem_object_release(&gbo->bo.base);
 }
 
 static void drm_gem_vram_destroy(struct drm_gem_vram_object *gbo)
@@ -80,7 +80,7 @@ static int drm_gem_vram_init(struct drm_device *dev,
 	int ret;
 	size_t acc_size;
 
-	ret = drm_gem_object_init(dev, &gbo->gem, size);
+	ret = drm_gem_object_init(dev, &gbo->bo.base, size);
 	if (ret)
 		return ret;
 
@@ -98,7 +98,7 @@ static int drm_gem_vram_init(struct drm_device *dev,
 	return 0;
 
 err_drm_gem_object_release:
-	drm_gem_object_release(&gbo->gem);
+	drm_gem_object_release(&gbo->bo.base);
 	return ret;
 }
 
@@ -378,11 +378,11 @@ int drm_gem_vram_fill_create_dumb(struct drm_file *file,
 	if (IS_ERR(gbo))
 		return PTR_ERR(gbo);
 
-	ret = drm_gem_handle_create(file, &gbo->gem, &handle);
+	ret = drm_gem_handle_create(file, &gbo->bo.base, &handle);
 	if (ret)
 		goto err_drm_gem_object_put_unlocked;
 
-	drm_gem_object_put_unlocked(&gbo->gem);
+	drm_gem_object_put_unlocked(&gbo->bo.base);
 
 	args->pitch = pitch;
 	args->size = size;
@@ -391,7 +391,7 @@ int drm_gem_vram_fill_create_dumb(struct drm_file *file,
 	return 0;
 
 err_drm_gem_object_put_unlocked:
-	drm_gem_object_put_unlocked(&gbo->gem);
+	drm_gem_object_put_unlocked(&gbo->bo.base);
 	return ret;
 }
 EXPORT_SYMBOL(drm_gem_vram_fill_create_dumb);
@@ -441,7 +441,7 @@ int drm_gem_vram_bo_driver_verify_access(struct ttm_buffer_object *bo,
 {
 	struct drm_gem_vram_object *gbo = drm_gem_vram_of_bo(bo);
 
-	return drm_vma_node_verify_access(&gbo->gem.vma_node,
+	return drm_vma_node_verify_access(&gbo->bo.base.vma_node,
 					  filp->private_data);
 }
 EXPORT_SYMBOL(drm_gem_vram_bo_driver_verify_access);
@@ -635,7 +635,7 @@ int drm_gem_vram_driver_gem_prime_mmap(struct drm_gem_object *gem,
 {
 	struct drm_gem_vram_object *gbo = drm_gem_vram_of_gem(gem);
 
-	gbo->gem.vma_node.vm_node.start = gbo->bo.vma_node.vm_node.start;
+	gbo->bo.base.vma_node.vm_node.start = gbo->bo.vma_node.vm_node.start;
 	return drm_gem_prime_mmap(gem, vma);
 }
 EXPORT_SYMBOL(drm_gem_vram_driver_gem_prime_mmap);
-- 
2.18.1

