Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E01B7EC10
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 07:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732847AbfHBFWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 01:22:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732704AbfHBFWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 01:22:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4703E30860B6;
        Fri,  2 Aug 2019 05:22:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AE3D19C68;
        Fri,  2 Aug 2019 05:22:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BAFCA9D77; Fri,  2 Aug 2019 07:22:48 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     ckoenig.leichtzumerken@gmail.com, thomas@shipmail.org,
        tzimmermann@suse.de, daniel@ffwll.ch, bskeggs@redhat.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 04/17] drm/radeon: use embedded gem object
Date:   Fri,  2 Aug 2019 07:22:34 +0200
Message-Id: <20190802052247.18427-5-kraxel@redhat.com>
In-Reply-To: <20190802052247.18427-1-kraxel@redhat.com>
References: <20190802052247.18427-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 02 Aug 2019 05:22:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop drm_gem_object from radeon_bo, use the
ttm_buffer_object.base instead.

Build tested only.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/radeon/radeon.h         |  3 +--
 drivers/gpu/drm/radeon/radeon_cs.c      |  2 +-
 drivers/gpu/drm/radeon/radeon_display.c |  4 ++--
 drivers/gpu/drm/radeon/radeon_gem.c     |  2 +-
 drivers/gpu/drm/radeon/radeon_object.c  | 16 ++++++++--------
 drivers/gpu/drm/radeon/radeon_prime.c   |  2 +-
 drivers/gpu/drm/radeon/radeon_ttm.c     |  2 +-
 7 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 32808e50be12..3f7701321d21 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -505,7 +505,6 @@ struct radeon_bo {
 	struct list_head		va;
 	/* Constant after initialization */
 	struct radeon_device		*rdev;
-	struct drm_gem_object		gem_base;
 
 	struct ttm_bo_kmap_obj		dma_buf_vmap;
 	pid_t				pid;
@@ -513,7 +512,7 @@ struct radeon_bo {
 	struct radeon_mn		*mn;
 	struct list_head		mn_list;
 };
-#define gem_to_radeon_bo(gobj) container_of((gobj), struct radeon_bo, gem_base)
+#define gem_to_radeon_bo(gobj) container_of((gobj), struct radeon_bo, tbo.base)
 
 int radeon_gem_debugfs_init(struct radeon_device *rdev);
 
diff --git a/drivers/gpu/drm/radeon/radeon_cs.c b/drivers/gpu/drm/radeon/radeon_cs.c
index cef0e697a2ea..d206654b31ad 100644
--- a/drivers/gpu/drm/radeon/radeon_cs.c
+++ b/drivers/gpu/drm/radeon/radeon_cs.c
@@ -443,7 +443,7 @@ static void radeon_cs_parser_fini(struct radeon_cs_parser *parser, int error, bo
 			if (bo == NULL)
 				continue;
 
-			drm_gem_object_put_unlocked(&bo->gem_base);
+			drm_gem_object_put_unlocked(&bo->tbo.base);
 		}
 	}
 	kfree(parser->track);
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index bd52f15e6330..ea6b752dd3a4 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -275,7 +275,7 @@ static void radeon_unpin_work_func(struct work_struct *__work)
 	} else
 		DRM_ERROR("failed to reserve buffer after flip\n");
 
-	drm_gem_object_put_unlocked(&work->old_rbo->gem_base);
+	drm_gem_object_put_unlocked(&work->old_rbo->tbo.base);
 	kfree(work);
 }
 
@@ -607,7 +607,7 @@ static int radeon_crtc_page_flip_target(struct drm_crtc *crtc,
 	radeon_bo_unreserve(new_rbo);
 
 cleanup:
-	drm_gem_object_put_unlocked(&work->old_rbo->gem_base);
+	drm_gem_object_put_unlocked(&work->old_rbo->tbo.base);
 	dma_fence_put(work->fence);
 	kfree(work);
 	return r;
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index d8bc5d2dfd61..7238007f5aa4 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -83,7 +83,7 @@ int radeon_gem_object_create(struct radeon_device *rdev, unsigned long size,
 		}
 		return r;
 	}
-	*obj = &robj->gem_base;
+	*obj = &robj->tbo.base;
 	robj->pid = task_pid_nr(current);
 
 	mutex_lock(&rdev->gem.mutex);
diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index 7a2bad843f8a..66a21332ed4f 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -85,9 +85,9 @@ static void radeon_ttm_bo_destroy(struct ttm_buffer_object *tbo)
 	mutex_unlock(&bo->rdev->gem.mutex);
 	radeon_bo_clear_surface_reg(bo);
 	WARN_ON_ONCE(!list_empty(&bo->va));
-	if (bo->gem_base.import_attach)
-		drm_prime_gem_destroy(&bo->gem_base, bo->tbo.sg);
-	drm_gem_object_release(&bo->gem_base);
+	if (bo->tbo.base.import_attach)
+		drm_prime_gem_destroy(&bo->tbo.base, bo->tbo.sg);
+	drm_gem_object_release(&bo->tbo.base);
 	kfree(bo);
 }
 
@@ -209,7 +209,7 @@ int radeon_bo_create(struct radeon_device *rdev,
 	bo = kzalloc(sizeof(struct radeon_bo), GFP_KERNEL);
 	if (bo == NULL)
 		return -ENOMEM;
-	drm_gem_private_object_init(rdev->ddev, &bo->gem_base, size);
+	drm_gem_private_object_init(rdev->ddev, &bo->tbo.base, size);
 	bo->rdev = rdev;
 	bo->surface_reg = -1;
 	INIT_LIST_HEAD(&bo->list);
@@ -262,7 +262,7 @@ int radeon_bo_create(struct radeon_device *rdev,
 	r = ttm_bo_init(&rdev->mman.bdev, &bo->tbo, size, type,
 			&bo->placement, page_align, !kernel, acc_size,
 			sg, resv, &radeon_ttm_bo_destroy);
-	bo->gem_base.resv = bo->tbo.resv;
+	bo->tbo.base.resv = bo->tbo.resv;
 	up_read(&rdev->pm.mclk_lock);
 	if (unlikely(r != 0)) {
 		return r;
@@ -443,13 +443,13 @@ void radeon_bo_force_delete(struct radeon_device *rdev)
 	dev_err(rdev->dev, "Userspace still has active objects !\n");
 	list_for_each_entry_safe(bo, n, &rdev->gem.objects, list) {
 		dev_err(rdev->dev, "%p %p %lu %lu force free\n",
-			&bo->gem_base, bo, (unsigned long)bo->gem_base.size,
-			*((unsigned long *)&bo->gem_base.refcount));
+			&bo->tbo.base, bo, (unsigned long)bo->tbo.base.size,
+			*((unsigned long *)&bo->tbo.base.refcount));
 		mutex_lock(&bo->rdev->gem.mutex);
 		list_del_init(&bo->list);
 		mutex_unlock(&bo->rdev->gem.mutex);
 		/* this should unref the ttm bo */
-		drm_gem_object_put_unlocked(&bo->gem_base);
+		drm_gem_object_put_unlocked(&bo->tbo.base);
 	}
 }
 
diff --git a/drivers/gpu/drm/radeon/radeon_prime.c b/drivers/gpu/drm/radeon/radeon_prime.c
index 8ce3e8045d42..95f640f71d5a 100644
--- a/drivers/gpu/drm/radeon/radeon_prime.c
+++ b/drivers/gpu/drm/radeon/radeon_prime.c
@@ -80,7 +80,7 @@ struct drm_gem_object *radeon_gem_prime_import_sg_table(struct drm_device *dev,
 	mutex_unlock(&rdev->gem.mutex);
 
 	bo->prime_shared_count = 1;
-	return &bo->gem_base;
+	return &bo->tbo.base;
 }
 
 int radeon_gem_prime_pin(struct drm_gem_object *obj)
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index fb3696bc616d..f43ff0e0641d 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -184,7 +184,7 @@ static int radeon_verify_access(struct ttm_buffer_object *bo, struct file *filp)
 
 	if (radeon_ttm_tt_has_userptr(bo->ttm))
 		return -EPERM;
-	return drm_vma_node_verify_access(&rbo->gem_base.vma_node,
+	return drm_vma_node_verify_access(&rbo->tbo.base.vma_node,
 					  filp->private_data);
 }
 
-- 
2.18.1

