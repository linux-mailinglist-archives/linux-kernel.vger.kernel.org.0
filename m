Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 370144E784
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 13:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfFUL6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 07:58:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfFUL6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:58:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 030ACC1EB1E7;
        Fri, 21 Jun 2019 11:58:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-212.ams2.redhat.com [10.36.116.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 322FE5D772;
        Fri, 21 Jun 2019 11:58:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BE8109DB5; Fri, 21 Jun 2019 13:57:59 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     ckoenig.leichtzumerken@gmail.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 14/18] drm/amdgpu: switch driver from bo->resv to bo->base.resv
Date:   Fri, 21 Jun 2019 13:57:51 +0200
Message-Id: <20190621115755.8481-15-kraxel@redhat.com>
In-Reply-To: <20190621115755.8481-1-kraxel@redhat.com>
References: <20190621115755.8481-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 21 Jun 2019 11:58:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  6 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  6 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  6 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 20 ++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  6 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 30 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 13 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index df26bf34b675..6dce43bd60f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -218,7 +218,7 @@ void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo)
 static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
 					struct amdgpu_amdkfd_fence *ef)
 {
-	struct reservation_object *resv = bo->tbo.resv;
+	struct reservation_object *resv = bo->tbo.base.resv;
 	struct reservation_object_list *old, *new;
 	unsigned int i, j, k;
 
@@ -812,7 +812,7 @@ static int process_sync_pds_resv(struct amdkfd_process_info *process_info,
 		struct amdgpu_bo *pd = peer_vm->root.base.bo;
 
 		ret = amdgpu_sync_resv(NULL,
-					sync, pd->tbo.resv,
+					sync, pd->tbo.base.resv,
 					AMDGPU_FENCE_OWNER_UNDEFINED, false);
 		if (ret)
 			return ret;
@@ -887,7 +887,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 				  AMDGPU_FENCE_OWNER_KFD, false);
 	if (ret)
 		goto wait_pd_fail;
-	ret = reservation_object_reserve_shared(vm->root.base.bo->tbo.resv, 1);
+	ret = reservation_object_reserve_shared(vm->root.base.bo->tbo.base.resv, 1);
 	if (ret)
 		goto reserve_shared_fail;
 	amdgpu_bo_fence(vm->root.base.bo,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index dc63707e426f..118ec7514277 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -402,7 +402,7 @@ static int amdgpu_cs_bo_validate(struct amdgpu_cs_parser *p,
 	struct ttm_operation_ctx ctx = {
 		.interruptible = true,
 		.no_wait_gpu = false,
-		.resv = bo->tbo.resv,
+		.resv = bo->tbo.base.resv,
 		.flags = 0
 	};
 	uint32_t domain;
@@ -734,7 +734,7 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 
 	list_for_each_entry(e, &p->validated, tv.head) {
 		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
-		struct reservation_object *resv = bo->tbo.resv;
+		struct reservation_object *resv = bo->tbo.base.resv;
 
 		r = amdgpu_sync_resv(p->adev, &p->job->sync, resv, p->filp,
 				     amdgpu_bo_explicit_sync(bo));
@@ -1732,7 +1732,7 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
 	*map = mapping;
 
 	/* Double check that the BO is reserved by this CS */
-	if (READ_ONCE((*bo)->tbo.resv->lock.ctx) != &parser->ticket)
+	if (READ_ONCE((*bo)->tbo.base.resv->lock.ctx) != &parser->ticket)
 		return -EINVAL;
 
 	if (!((*bo)->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 535650967b1a..b5d020e15c35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -204,7 +204,7 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crtc *crtc,
 		goto unpin;
 	}
 
-	r = reservation_object_get_fences_rcu(new_abo->tbo.resv, &work->excl,
+	r = reservation_object_get_fences_rcu(new_abo->tbo.base.resv, &work->excl,
 					      &work->shared_count,
 					      &work->shared);
 	if (unlikely(r != 0)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index c56819bcad8e..cd4fe9dd8863 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -216,7 +216,7 @@ static int amdgpu_dma_buf_map_attach(struct dma_buf *dma_buf,
 		 * fences on the reservation object into a single exclusive
 		 * fence.
 		 */
-		r = __reservation_object_make_exclusive(bo->tbo.resv);
+		r = __reservation_object_make_exclusive(bo->tbo.base.resv);
 		if (r)
 			goto error_unreserve;
 	}
@@ -278,7 +278,7 @@ struct reservation_object *amdgpu_gem_prime_res_obj(struct drm_gem_object *obj)
 {
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 
-	return bo->tbo.resv;
+	return bo->tbo.base.resv;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 6d991e8df357..d26bca1efb9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -134,7 +134,7 @@ int amdgpu_gem_object_open(struct drm_gem_object *obj,
 		return -EPERM;
 
 	if (abo->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID &&
-	    abo->tbo.resv != vm->root.base.bo->tbo.resv)
+	    abo->tbo.base.resv != vm->root.base.bo->tbo.base.resv)
 		return -EPERM;
 
 	r = amdgpu_bo_reserve(abo, false);
@@ -252,7 +252,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		if (r)
 			return r;
 
-		resv = vm->root.base.bo->tbo.resv;
+		resv = vm->root.base.bo->tbo.base.resv;
 	}
 
 	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
@@ -434,7 +434,7 @@ int amdgpu_gem_wait_idle_ioctl(struct drm_device *dev, void *data,
 		return -ENOENT;
 	}
 	robj = gem_to_amdgpu_bo(gobj);
-	ret = reservation_object_wait_timeout_rcu(robj->tbo.resv, true, true,
+	ret = reservation_object_wait_timeout_rcu(robj->tbo.base.resv, true, true,
 						  timeout);
 
 	/* ret == 0 means not signaled,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a70e5a32749a..5142aa6377a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1084,7 +1084,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	amdgpu_vm_fini(adev, &fpriv->vm);
 
 	if (pasid)
-		amdgpu_pasid_free_delayed(pd->tbo.resv, pasid);
+		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
 	amdgpu_bo_unref(&pd);
 
 	idr_for_each_entry(&fpriv->bo_list_handles, list, handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index 4ff4cf5988ea..9c72531c842c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -216,7 +216,7 @@ static void amdgpu_mn_invalidate_node(struct amdgpu_mn_node *node,
 		if (!amdgpu_ttm_tt_affect_userptr(bo->tbo.ttm, start, end))
 			continue;
 
-		r = reservation_object_wait_timeout_rcu(bo->tbo.resv,
+		r = reservation_object_wait_timeout_rcu(bo->tbo.base.resv,
 			true, false, MAX_SCHEDULE_TIMEOUT);
 		if (r <= 0)
 			DRM_ERROR("(%ld) failed to wait for user bo\n", r);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 00b283f914a6..ec0f6420718f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -517,7 +517,7 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 	    bo->tbo.mem.placement & TTM_PL_FLAG_VRAM) {
 		struct dma_fence *fence;
 
-		r = amdgpu_fill_buffer(bo, 0, bo->tbo.resv, &fence);
+		r = amdgpu_fill_buffer(bo, 0, bo->tbo.base.resv, &fence);
 		if (unlikely(r))
 			goto fail_unreserve;
 
@@ -540,7 +540,7 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 
 fail_unreserve:
 	if (!bp->resv)
-		ww_mutex_unlock(&bo->tbo.resv->lock);
+		ww_mutex_unlock(&bo->tbo.base.resv->lock);
 	amdgpu_bo_unref(&bo);
 	return r;
 }
@@ -561,7 +561,7 @@ static int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
 	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
 		AMDGPU_GEM_CREATE_SHADOW;
 	bp.type = ttm_bo_type_kernel;
-	bp.resv = bo->tbo.resv;
+	bp.resv = bo->tbo.base.resv;
 
 	r = amdgpu_bo_do_create(adev, &bp, &bo->shadow);
 	if (!r) {
@@ -602,13 +602,13 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 
 	if ((flags & AMDGPU_GEM_CREATE_SHADOW) && !(adev->flags & AMD_IS_APU)) {
 		if (!bp->resv)
-			WARN_ON(reservation_object_lock((*bo_ptr)->tbo.resv,
+			WARN_ON(reservation_object_lock((*bo_ptr)->tbo.base.resv,
 							NULL));
 
 		r = amdgpu_bo_create_shadow(adev, bp->size, *bo_ptr);
 
 		if (!bp->resv)
-			reservation_object_unlock((*bo_ptr)->tbo.resv);
+			reservation_object_unlock((*bo_ptr)->tbo.base.resv);
 
 		if (r)
 			amdgpu_bo_unref(bo_ptr);
@@ -705,7 +705,7 @@ int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr)
 		return 0;
 	}
 
-	r = reservation_object_wait_timeout_rcu(bo->tbo.resv, false, false,
+	r = reservation_object_wait_timeout_rcu(bo->tbo.base.resv, false, false,
 						MAX_SCHEDULE_TIMEOUT);
 	if (r < 0)
 		return r;
@@ -1082,7 +1082,7 @@ int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags)
  */
 void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
 {
-	lockdep_assert_held(&bo->tbo.resv->lock.base);
+	lockdep_assert_held(&bo->tbo.base.resv->lock.base);
 
 	if (tiling_flags)
 		*tiling_flags = bo->tiling_flags;
@@ -1278,7 +1278,7 @@ int amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo)
 void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
 		     bool shared)
 {
-	struct reservation_object *resv = bo->tbo.resv;
+	struct reservation_object *resv = bo->tbo.base.resv;
 
 	if (shared)
 		reservation_object_add_shared_fence(resv, fence);
@@ -1303,7 +1303,7 @@ int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr)
 	int r;
 
 	amdgpu_sync_create(&sync);
-	amdgpu_sync_resv(adev, &sync, bo->tbo.resv, owner, false);
+	amdgpu_sync_resv(adev, &sync, bo->tbo.base.resv, owner, false);
 	r = amdgpu_sync_wait(&sync, intr);
 	amdgpu_sync_free(&sync);
 
@@ -1323,7 +1323,7 @@ int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr)
 u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
 {
 	WARN_ON_ONCE(bo->tbo.mem.mem_type == TTM_PL_SYSTEM);
-	WARN_ON_ONCE(!ww_mutex_is_locked(&bo->tbo.resv->lock) &&
+	WARN_ON_ONCE(!ww_mutex_is_locked(&bo->tbo.base.resv->lock) &&
 		     !bo->pin_count && bo->tbo.type != ttm_bo_type_kernel);
 	WARN_ON_ONCE(bo->tbo.mem.start == AMDGPU_BO_INVALID_OFFSET);
 	WARN_ON_ONCE(bo->tbo.mem.mem_type == TTM_PL_VRAM &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b8ae9a838b6c..b903a382b6b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -438,7 +438,7 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
 
 	r = amdgpu_ttm_copy_mem_to_mem(adev, &src, &dst,
 				       new_mem->num_pages << PAGE_SHIFT,
-				       bo->resv, &fence);
+				       bo->base.resv, &fence);
 	if (r)
 		goto error;
 
@@ -1450,14 +1450,14 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 	 * cleanly handle page faults.
 	 */
 	if (bo->type == ttm_bo_type_kernel &&
-	    !reservation_object_test_signaled_rcu(bo->resv, true))
+	    !reservation_object_test_signaled_rcu(bo->base.resv, true))
 		return false;
 
 	/* If bo is a KFD BO, check if the bo belongs to the current process.
 	 * If true, then return false as any KFD process needs all its BOs to
 	 * be resident to run successfully
 	 */
-	flist = reservation_object_get_list(bo->resv);
+	flist = reservation_object_get_list(bo->base.resv);
 	if (flist) {
 		for (i = 0; i < flist->shared_count; ++i) {
 			f = rcu_dereference_protected(flist->shared[i],
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 5b2fea3b4a2c..f858607b17a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1073,7 +1073,7 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	ib->length_dw = 16;
 
 	if (direct) {
-		r = reservation_object_wait_timeout_rcu(bo->tbo.resv,
+		r = reservation_object_wait_timeout_rcu(bo->tbo.base.resv,
 							true, false,
 							msecs_to_jiffies(10));
 		if (r == 0)
@@ -1085,7 +1085,7 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 		if (r)
 			goto err_free;
 	} else {
-		r = amdgpu_sync_resv(adev, &job->sync, bo->tbo.resv,
+		r = amdgpu_sync_resv(adev, &job->sync, bo->tbo.base.resv,
 				     AMDGPU_FENCE_OWNER_UNDEFINED, false);
 		if (r)
 			goto err_free;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index e44f9dd202e8..4c86b9cd1530 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -302,7 +302,7 @@ static void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
 
-	if (bo->tbo.resv != vm->root.base.bo->tbo.resv)
+	if (bo->tbo.base.resv != vm->root.base.bo->tbo.base.resv)
 		return;
 
 	vm->bulk_moveable = false;
@@ -583,7 +583,7 @@ void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo)
 	for (bo_base = abo->vm_bo; bo_base; bo_base = bo_base->next) {
 		struct amdgpu_vm *vm = bo_base->vm;
 
-		if (abo->tbo.resv == vm->root.base.bo->tbo.resv)
+		if (abo->tbo.base.resv == vm->root.base.bo->tbo.base.resv)
 			vm->bulk_moveable = false;
 	}
 
@@ -834,7 +834,7 @@ static void amdgpu_vm_bo_param(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		bp->flags |= AMDGPU_GEM_CREATE_SHADOW;
 	bp->type = ttm_bo_type_kernel;
 	if (vm->root.base.bo)
-		bp->resv = vm->root.base.bo->tbo.resv;
+		bp->resv = vm->root.base.bo->tbo.base.resv;
 }
 
 /**
@@ -1692,7 +1692,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			ttm = container_of(bo->tbo.ttm, struct ttm_dma_tt, ttm);
 			pages_addr = ttm->dma_address;
 		}
-		exclusive = reservation_object_get_excl(bo->tbo.resv);
+		exclusive = reservation_object_get_excl(bo->tbo.base.resv);
 	}
 
 	if (bo) {
@@ -1702,7 +1702,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 		flags = 0x0;
 	}
 
-	if (clear || (bo && bo->tbo.resv == vm->root.base.bo->tbo.resv))
+	if (clear || (bo && bo->tbo.base.resv == vm->root.base.bo->tbo.base.resv))
 		last_update = &vm->last_update;
 	else
 		last_update = &bo_va->last_pt_update;
@@ -1733,7 +1733,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 	 * the evicted list so that it gets validated again on the
 	 * next command submission.
 	 */
-	if (bo && bo->tbo.resv == vm->root.base.bo->tbo.resv) {
+	if (bo && bo->tbo.base.resv == vm->root.base.bo->tbo.base.resv) {
 		uint32_t mem_type = bo->tbo.mem.mem_type;
 
 		if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(mem_type)))
@@ -1869,7 +1869,7 @@ static void amdgpu_vm_free_mapping(struct amdgpu_device *adev,
  */
 static void amdgpu_vm_prt_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	struct reservation_object *resv = vm->root.base.bo->tbo.resv;
+	struct reservation_object *resv = vm->root.base.bo->tbo.base.resv;
 	struct dma_fence *excl, **shared;
 	unsigned i, shared_count;
 	int r;
@@ -1983,7 +1983,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 	while (!list_empty(&vm->invalidated)) {
 		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
 					 base.vm_status);
-		resv = bo_va->base.bo->tbo.resv;
+		resv = bo_va->base.bo->tbo.base.resv;
 		spin_unlock(&vm->invalidated_lock);
 
 		/* Try to reserve the BO to avoid clearing its ptes */
@@ -2074,7 +2074,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
 	if (mapping->flags & AMDGPU_PTE_PRT)
 		amdgpu_vm_prt_get(adev);
 
-	if (bo && bo->tbo.resv == vm->root.base.bo->tbo.resv &&
+	if (bo && bo->tbo.base.resv == vm->root.base.bo->tbo.base.resv &&
 	    !bo_va->base.moved) {
 		list_move(&bo_va->base.vm_status, &vm->moved);
 	}
@@ -2406,7 +2406,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *ticket)
 			struct amdgpu_bo *bo;
 
 			bo = mapping->bo_va->base.bo;
-			if (READ_ONCE(bo->tbo.resv->lock.ctx) != ticket)
+			if (READ_ONCE(bo->tbo.base.resv->lock.ctx) != ticket)
 				continue;
 		}
 
@@ -2433,7 +2433,7 @@ void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
 	struct amdgpu_vm_bo_base **base;
 
 	if (bo) {
-		if (bo->tbo.resv == vm->root.base.bo->tbo.resv)
+		if (bo->tbo.base.resv == vm->root.base.bo->tbo.base.resv)
 			vm->bulk_moveable = false;
 
 		for (base = &bo_va->base.bo->vm_bo; *base;
@@ -2497,7 +2497,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
 		struct amdgpu_vm *vm = bo_base->vm;
 
-		if (evicted && bo->tbo.resv == vm->root.base.bo->tbo.resv) {
+		if (evicted && bo->tbo.base.resv == vm->root.base.bo->tbo.base.resv) {
 			amdgpu_vm_bo_evicted(bo_base);
 			continue;
 		}
@@ -2508,7 +2508,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 
 		if (bo->tbo.type == ttm_bo_type_kernel)
 			amdgpu_vm_bo_relocated(bo_base);
-		else if (bo->tbo.resv == vm->root.base.bo->tbo.resv)
+		else if (bo->tbo.base.resv == vm->root.base.bo->tbo.base.resv)
 			amdgpu_vm_bo_moved(bo_base);
 		else
 			amdgpu_vm_bo_invalidated(bo_base);
@@ -2638,7 +2638,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
  */
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
 {
-	return reservation_object_wait_timeout_rcu(vm->root.base.bo->tbo.resv,
+	return reservation_object_wait_timeout_rcu(vm->root.base.bo->tbo.base.resv,
 						   true, true, timeout);
 }
 
@@ -2713,7 +2713,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free_root;
 
-	r = reservation_object_reserve_shared(root->tbo.resv, 1);
+	r = reservation_object_reserve_shared(root->tbo.base.resv, 1);
 	if (r)
 		goto error_unreserve;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index ddd181f5ed37..61fc584cbb1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -72,7 +72,7 @@ static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
 	if (r)
 		return r;
 
-	r = amdgpu_sync_resv(p->adev, &p->job->sync, root->tbo.resv,
+	r = amdgpu_sync_resv(p->adev, &p->job->sync, root->tbo.base.resv,
 			     owner, false);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1129dd963796..254d8b13b423 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5510,7 +5510,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		 * deadlock during GPU reset when this fence will not signal
 		 * but we hold reservation lock for the BO.
 		 */
-		r = reservation_object_wait_timeout_rcu(abo->tbo.resv, true,
+		r = reservation_object_wait_timeout_rcu(abo->tbo.base.resv, true,
 							false,
 							msecs_to_jiffies(5000));
 		if (unlikely(r <= 0))
-- 
2.18.1

