Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F15B596D4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 11:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfF1JDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 05:03:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfF1JDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:03:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBC27308FED2;
        Fri, 28 Jun 2019 09:03:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 180995C644;
        Fri, 28 Jun 2019 09:03:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 6417C9D74; Fri, 28 Jun 2019 11:03:08 +0200 (CEST)
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
Subject: [PATCH v3 12/18] drm/radeon: switch driver from bo->resv to bo->base.resv
Date:   Fri, 28 Jun 2019 11:02:57 +0200
Message-Id: <20190628090303.29467-13-kraxel@redhat.com>
In-Reply-To: <20190628090303.29467-1-kraxel@redhat.com>
References: <20190628090303.29467-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 28 Jun 2019 09:03:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/radeon/radeon_benchmark.c | 4 ++--
 drivers/gpu/drm/radeon/radeon_cs.c        | 2 +-
 drivers/gpu/drm/radeon/radeon_display.c   | 2 +-
 drivers/gpu/drm/radeon/radeon_gem.c       | 6 +++---
 drivers/gpu/drm/radeon/radeon_mn.c        | 2 +-
 drivers/gpu/drm/radeon/radeon_object.c    | 9 ++++-----
 drivers/gpu/drm/radeon/radeon_test.c      | 8 ++++----
 drivers/gpu/drm/radeon/radeon_ttm.c       | 2 +-
 drivers/gpu/drm/radeon/radeon_uvd.c       | 2 +-
 drivers/gpu/drm/radeon/radeon_vm.c        | 6 +++---
 10 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_benchmark.c b/drivers/gpu/drm/radeon/radeon_benchmark.c
index 7ce5064a59f6..1ea50ce16312 100644
--- a/drivers/gpu/drm/radeon/radeon_benchmark.c
+++ b/drivers/gpu/drm/radeon/radeon_benchmark.c
@@ -122,7 +122,7 @@ static void radeon_benchmark_move(struct radeon_device *rdev, unsigned size,
 	if (rdev->asic->copy.dma) {
 		time = radeon_benchmark_do_move(rdev, size, saddr, daddr,
 						RADEON_BENCHMARK_COPY_DMA, n,
-						dobj->tbo.resv);
+						dobj->tbo.base.resv);
 		if (time < 0)
 			goto out_cleanup;
 		if (time > 0)
@@ -133,7 +133,7 @@ static void radeon_benchmark_move(struct radeon_device *rdev, unsigned size,
 	if (rdev->asic->copy.blit) {
 		time = radeon_benchmark_do_move(rdev, size, saddr, daddr,
 						RADEON_BENCHMARK_COPY_BLIT, n,
-						dobj->tbo.resv);
+						dobj->tbo.base.resv);
 		if (time < 0)
 			goto out_cleanup;
 		if (time > 0)
diff --git a/drivers/gpu/drm/radeon/radeon_cs.c b/drivers/gpu/drm/radeon/radeon_cs.c
index d206654b31ad..7e5254a34e84 100644
--- a/drivers/gpu/drm/radeon/radeon_cs.c
+++ b/drivers/gpu/drm/radeon/radeon_cs.c
@@ -257,7 +257,7 @@ static int radeon_cs_sync_rings(struct radeon_cs_parser *p)
 	list_for_each_entry(reloc, &p->validated, tv.head) {
 		struct reservation_object *resv;
 
-		resv = reloc->robj->tbo.resv;
+		resv = reloc->robj->tbo.base.resv;
 		r = radeon_sync_resv(p->rdev, &p->ib.sync, resv,
 				     reloc->tv.num_shared);
 		if (r)
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index ea6b752dd3a4..7bf73230ac0b 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -533,7 +533,7 @@ static int radeon_crtc_page_flip_target(struct drm_crtc *crtc,
 		DRM_ERROR("failed to pin new rbo buffer before flip\n");
 		goto cleanup;
 	}
-	work->fence = dma_fence_get(reservation_object_get_excl(new_rbo->tbo.resv));
+	work->fence = dma_fence_get(reservation_object_get_excl(new_rbo->tbo.base.resv));
 	radeon_bo_get_tiling_flags(new_rbo, &tiling_flags, NULL);
 	radeon_bo_unreserve(new_rbo);
 
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 7238007f5aa4..03873f21a734 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -114,7 +114,7 @@ static int radeon_gem_set_domain(struct drm_gem_object *gobj,
 	}
 	if (domain == RADEON_GEM_DOMAIN_CPU) {
 		/* Asking for cpu access wait for object idle */
-		r = reservation_object_wait_timeout_rcu(robj->tbo.resv, true, true, 30 * HZ);
+		r = reservation_object_wait_timeout_rcu(robj->tbo.base.resv, true, true, 30 * HZ);
 		if (!r)
 			r = -EBUSY;
 
@@ -449,7 +449,7 @@ int radeon_gem_busy_ioctl(struct drm_device *dev, void *data,
 	}
 	robj = gem_to_radeon_bo(gobj);
 
-	r = reservation_object_test_signaled_rcu(robj->tbo.resv, true);
+	r = reservation_object_test_signaled_rcu(robj->tbo.base.resv, true);
 	if (r == 0)
 		r = -EBUSY;
 	else
@@ -478,7 +478,7 @@ int radeon_gem_wait_idle_ioctl(struct drm_device *dev, void *data,
 	}
 	robj = gem_to_radeon_bo(gobj);
 
-	ret = reservation_object_wait_timeout_rcu(robj->tbo.resv, true, true, 30 * HZ);
+	ret = reservation_object_wait_timeout_rcu(robj->tbo.base.resv, true, true, 30 * HZ);
 	if (ret == 0)
 		r = -EBUSY;
 	else if (ret < 0)
diff --git a/drivers/gpu/drm/radeon/radeon_mn.c b/drivers/gpu/drm/radeon/radeon_mn.c
index 8c3871ed23a9..0d64ace0e6c1 100644
--- a/drivers/gpu/drm/radeon/radeon_mn.c
+++ b/drivers/gpu/drm/radeon/radeon_mn.c
@@ -163,7 +163,7 @@ static int radeon_mn_invalidate_range_start(struct mmu_notifier *mn,
 				continue;
 			}
 
-			r = reservation_object_wait_timeout_rcu(bo->tbo.resv,
+			r = reservation_object_wait_timeout_rcu(bo->tbo.base.resv,
 				true, false, MAX_SCHEDULE_TIMEOUT);
 			if (r <= 0)
 				DRM_ERROR("(%ld) failed to wait for user bo\n", r);
diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index 66a21332ed4f..4e8d1d82dc0e 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -262,7 +262,6 @@ int radeon_bo_create(struct radeon_device *rdev,
 	r = ttm_bo_init(&rdev->mman.bdev, &bo->tbo, size, type,
 			&bo->placement, page_align, !kernel, acc_size,
 			sg, resv, &radeon_ttm_bo_destroy);
-	bo->tbo.base.resv = bo->tbo.resv;
 	up_read(&rdev->pm.mclk_lock);
 	if (unlikely(r != 0)) {
 		return r;
@@ -611,7 +610,7 @@ int radeon_bo_get_surface_reg(struct radeon_bo *bo)
 	int steal;
 	int i;
 
-	lockdep_assert_held(&bo->tbo.resv->lock.base);
+	lockdep_assert_held(&bo->tbo.base.resv->lock.base);
 
 	if (!bo->tiling_flags)
 		return 0;
@@ -737,7 +736,7 @@ void radeon_bo_get_tiling_flags(struct radeon_bo *bo,
 				uint32_t *tiling_flags,
 				uint32_t *pitch)
 {
-	lockdep_assert_held(&bo->tbo.resv->lock.base);
+	lockdep_assert_held(&bo->tbo.base.resv->lock.base);
 
 	if (tiling_flags)
 		*tiling_flags = bo->tiling_flags;
@@ -749,7 +748,7 @@ int radeon_bo_check_tiling(struct radeon_bo *bo, bool has_moved,
 				bool force_drop)
 {
 	if (!force_drop)
-		lockdep_assert_held(&bo->tbo.resv->lock.base);
+		lockdep_assert_held(&bo->tbo.base.resv->lock.base);
 
 	if (!(bo->tiling_flags & RADEON_TILING_SURFACE))
 		return 0;
@@ -871,7 +870,7 @@ int radeon_bo_wait(struct radeon_bo *bo, u32 *mem_type, bool no_wait)
 void radeon_bo_fence(struct radeon_bo *bo, struct radeon_fence *fence,
 		     bool shared)
 {
-	struct reservation_object *resv = bo->tbo.resv;
+	struct reservation_object *resv = bo->tbo.base.resv;
 
 	if (shared)
 		reservation_object_add_shared_fence(resv, &fence->base);
diff --git a/drivers/gpu/drm/radeon/radeon_test.c b/drivers/gpu/drm/radeon/radeon_test.c
index 0f6ba81a1669..a5e1d2139e80 100644
--- a/drivers/gpu/drm/radeon/radeon_test.c
+++ b/drivers/gpu/drm/radeon/radeon_test.c
@@ -120,11 +120,11 @@ static void radeon_do_test_moves(struct radeon_device *rdev, int flag)
 		if (ring == R600_RING_TYPE_DMA_INDEX)
 			fence = radeon_copy_dma(rdev, gtt_addr, vram_addr,
 						size / RADEON_GPU_PAGE_SIZE,
-						vram_obj->tbo.resv);
+						vram_obj->tbo.base.resv);
 		else
 			fence = radeon_copy_blit(rdev, gtt_addr, vram_addr,
 						 size / RADEON_GPU_PAGE_SIZE,
-						 vram_obj->tbo.resv);
+						 vram_obj->tbo.base.resv);
 		if (IS_ERR(fence)) {
 			DRM_ERROR("Failed GTT->VRAM copy %d\n", i);
 			r = PTR_ERR(fence);
@@ -171,11 +171,11 @@ static void radeon_do_test_moves(struct radeon_device *rdev, int flag)
 		if (ring == R600_RING_TYPE_DMA_INDEX)
 			fence = radeon_copy_dma(rdev, vram_addr, gtt_addr,
 						size / RADEON_GPU_PAGE_SIZE,
-						vram_obj->tbo.resv);
+						vram_obj->tbo.base.resv);
 		else
 			fence = radeon_copy_blit(rdev, vram_addr, gtt_addr,
 						 size / RADEON_GPU_PAGE_SIZE,
-						 vram_obj->tbo.resv);
+						 vram_obj->tbo.base.resv);
 		if (IS_ERR(fence)) {
 			DRM_ERROR("Failed VRAM->GTT copy %d\n", i);
 			r = PTR_ERR(fence);
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index f474beeda5eb..b5e02bb3c019 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -244,7 +244,7 @@ static int radeon_move_blit(struct ttm_buffer_object *bo,
 	BUILD_BUG_ON((PAGE_SIZE % RADEON_GPU_PAGE_SIZE) != 0);
 
 	num_pages = new_mem->num_pages * (PAGE_SIZE / RADEON_GPU_PAGE_SIZE);
-	fence = radeon_copy(rdev, old_start, new_start, num_pages, bo->resv);
+	fence = radeon_copy(rdev, old_start, new_start, num_pages, bo->base.resv);
 	if (IS_ERR(fence))
 		return PTR_ERR(fence);
 
diff --git a/drivers/gpu/drm/radeon/radeon_uvd.c b/drivers/gpu/drm/radeon/radeon_uvd.c
index ff4f794d1c86..311e69c2ed7f 100644
--- a/drivers/gpu/drm/radeon/radeon_uvd.c
+++ b/drivers/gpu/drm/radeon/radeon_uvd.c
@@ -477,7 +477,7 @@ static int radeon_uvd_cs_msg(struct radeon_cs_parser *p, struct radeon_bo *bo,
 		return -EINVAL;
 	}
 
-	f = reservation_object_get_excl(bo->tbo.resv);
+	f = reservation_object_get_excl(bo->tbo.base.resv);
 	if (f) {
 		r = radeon_fence_wait((struct radeon_fence *)f, false);
 		if (r) {
diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
index 8512b02e9583..e48a05533126 100644
--- a/drivers/gpu/drm/radeon/radeon_vm.c
+++ b/drivers/gpu/drm/radeon/radeon_vm.c
@@ -702,7 +702,7 @@ int radeon_vm_update_page_directory(struct radeon_device *rdev,
 	if (ib.length_dw != 0) {
 		radeon_asic_vm_pad_ib(rdev, &ib);
 
-		radeon_sync_resv(rdev, &ib.sync, pd->tbo.resv, true);
+		radeon_sync_resv(rdev, &ib.sync, pd->tbo.base.resv, true);
 		WARN_ON(ib.length_dw > ndw);
 		r = radeon_ib_schedule(rdev, &ib, NULL, false);
 		if (r) {
@@ -830,8 +830,8 @@ static int radeon_vm_update_ptes(struct radeon_device *rdev,
 		uint64_t pte;
 		int r;
 
-		radeon_sync_resv(rdev, &ib->sync, pt->tbo.resv, true);
-		r = reservation_object_reserve_shared(pt->tbo.resv, 1);
+		radeon_sync_resv(rdev, &ib->sync, pt->tbo.base.resv, true);
+		r = reservation_object_reserve_shared(pt->tbo.base.resv, 1);
 		if (r)
 			return r;
 
-- 
2.18.1

