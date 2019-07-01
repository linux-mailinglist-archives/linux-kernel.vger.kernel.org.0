Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 924AF3CBA2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 14:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbfFKMcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 08:32:07 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:50404 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387574AbfFKMcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:32:07 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jun 2019 08:32:05 EDT
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 176253FA1F;
        Tue, 11 Jun 2019 14:25:22 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=vmwopensource.org header.i=@vmwopensource.org header.b=nWtz1uMe;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -3.1
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 tagged_above=-999 required=6.31
        tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, DKIM_SIGNED=0.1,
        DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TvAoIKr99SY2; Tue, 11 Jun 2019 14:25:09 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id B77E43F670;
        Tue, 11 Jun 2019 14:25:09 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 483A9362507;
        Tue, 11 Jun 2019 14:25:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=vmwopensource.org;
        s=mail; t=1560255909;
        bh=xQxMqrK+Py+hBvKGd+V8YsDo/0sA3BbH6hMMRmIkPZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nWtz1uMehbw8RrjiwQdm02GDYWpZXgEeUAiGcGDsh2b5kwfXrfpKprca2eS/39WLh
         seIXJxvvU30eUu+rrRVnKQ5M3MLnlqg64sN5GPHq0+1Uq7dfQfznQJpErB1lXy0cCC
         eBfHlovRRVAKh6cjtkFp5aRVJYJbzFdFYTdm4sYA=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thellstrom@vmwopensource.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>
Subject: [PATCH v4 9/9] drm/vmwgfx: Add surface dirty-tracking callbacks
Date:   Tue, 11 Jun 2019 14:24:54 +0200
Message-Id: <20190611122454.3075-10-thellstrom@vmwopensource.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611122454.3075-1-thellstrom@vmwopensource.org>
References: <20190611122454.3075-1-thellstrom@vmwopensource.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Add the callbacks necessary to implement emulated coherent memory for
surfaces. Add a flag to the gb_surface_create ioctl to indicate that
surface memory should be coherent.
Also bump the drm minor version to signal the availability of coherent
surfaces.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Deepak Rawat <drawat@vmware.com>
---
 .../device_include/svga3d_surfacedefs.h       | 233 ++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h           |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c       | 395 +++++++++++++++++-
 include/uapi/drm/vmwgfx_drm.h                 |   4 +-
 4 files changed, 629 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/device_include/svga3d_surfacedefs.h b/drivers/gpu/drm/vmwgfx/device_include/svga3d_surfacedefs.h
index f2bfd3d80598..61414f105c67 100644
--- a/drivers/gpu/drm/vmwgfx/device_include/svga3d_surfacedefs.h
+++ b/drivers/gpu/drm/vmwgfx/device_include/svga3d_surfacedefs.h
@@ -1280,7 +1280,6 @@ svga3dsurface_get_pixel_offset(SVGA3dSurfaceFormat format,
 	return offset;
 }
 
-
 static inline u32
 svga3dsurface_get_image_offset(SVGA3dSurfaceFormat format,
 			       surf_size_struct baseLevelSize,
@@ -1375,4 +1374,236 @@ svga3dsurface_is_screen_target_format(SVGA3dSurfaceFormat format)
 	return svga3dsurface_is_dx_screen_target_format(format);
 }
 
+/**
+ * struct svga3dsurface_mip - Mimpmap level information
+ * @bytes: Bytes required in the backing store of this mipmap level.
+ * @img_stride: Byte stride per image.
+ * @row_stride: Byte stride per block row.
+ * @size: The size of the mipmap.
+ */
+struct svga3dsurface_mip {
+	size_t bytes;
+	size_t img_stride;
+	size_t row_stride;
+	struct drm_vmw_size size;
+
+};
+
+/**
+ * struct svga3dsurface_cache - Cached surface information
+ * @desc: Pointer to the surface descriptor
+ * @mip: Array of mipmap level information. Valid size is @num_mip_levels.
+ * @mip_chain_bytes: Bytes required in the backing store for the whole chain
+ * of mip levels.
+ * @sheet_bytes: Bytes required in the backing store for a sheet
+ * representing a single sample.
+ * @num_mip_levels: Valid size of the @mip array. Number of mipmap levels in
+ * a chain.
+ * @num_layers: Number of slices in an array texture or number of faces in
+ * a cubemap texture.
+ */
+struct svga3dsurface_cache {
+	const struct svga3d_surface_desc *desc;
+	struct svga3dsurface_mip mip[DRM_VMW_MAX_MIP_LEVELS];
+	size_t mip_chain_bytes;
+	size_t sheet_bytes;
+	u32 num_mip_levels;
+	u32 num_layers;
+};
+
+/**
+ * struct svga3dsurface_loc - Surface location
+ * @sub_resource: Surface subresource. Defined as layer * num_mip_levels +
+ * mip_level.
+ * @x: X coordinate.
+ * @y: Y coordinate.
+ * @z: Z coordinate.
+ */
+struct svga3dsurface_loc {
+	u32 sub_resource;
+	u32 x, y, z;
+};
+
+/**
+ * svga3dsurface_subres - Compute the subresource from layer and mipmap.
+ * @cache: Surface layout data.
+ * @mip_level: The mipmap level.
+ * @layer: The surface layer (face or array slice).
+ *
+ * Return: The subresource.
+ */
+static inline u32 svga3dsurface_subres(const struct svga3dsurface_cache *cache,
+				       u32 mip_level, u32 layer)
+{
+	return cache->num_mip_levels * layer + mip_level;
+}
+
+/**
+ * svga3dsurface_setup_cache - Build a surface cache entry
+ * @size: The surface base level dimensions.
+ * @format: The surface format.
+ * @num_mip_levels: Number of mipmap levels.
+ * @num_layers: Number of layers.
+ * @cache: Pointer to a struct svga3dsurface_cach object to be filled in.
+ *
+ * Return: Zero on success, -EINVAL on invalid surface layout.
+ */
+static inline int svga3dsurface_setup_cache(const struct drm_vmw_size *size,
+					    SVGA3dSurfaceFormat format,
+					    u32 num_mip_levels,
+					    u32 num_layers,
+					    u32 num_samples,
+					    struct svga3dsurface_cache *cache)
+{
+	const struct svga3d_surface_desc *desc;
+	u32 i;
+
+	memset(cache, 0, sizeof(*cache));
+	cache->desc = desc = svga3dsurface_get_desc(format);
+	cache->num_mip_levels = num_mip_levels;
+	cache->num_layers = num_layers;
+	for (i = 0; i < cache->num_mip_levels; i++) {
+		struct svga3dsurface_mip *mip = &cache->mip[i];
+
+		mip->size = svga3dsurface_get_mip_size(*size, i);
+		mip->bytes = svga3dsurface_get_image_buffer_size
+			(desc, &mip->size, 0);
+		mip->row_stride =
+			__KERNEL_DIV_ROUND_UP(mip->size.width,
+					      desc->block_size.width) *
+			desc->bytes_per_block * num_samples;
+		if (!mip->row_stride)
+			goto invalid_dim;
+
+		mip->img_stride =
+			__KERNEL_DIV_ROUND_UP(mip->size.height,
+					      desc->block_size.height) *
+			mip->row_stride;
+		if (!mip->img_stride)
+			goto invalid_dim;
+
+		cache->mip_chain_bytes += mip->bytes;
+	}
+	cache->sheet_bytes = cache->mip_chain_bytes * num_layers;
+	if (!cache->sheet_bytes)
+		goto invalid_dim;
+
+	return 0;
+
+invalid_dim:
+	VMW_DEBUG_USER("Invalid surface layout for dirty tracking.\n");
+	return -EINVAL;
+}
+
+/**
+ * svga3dsurface_get_loc - Get a surface location from an offset into the
+ * backing store
+ * @cache: Surface layout data.
+ * @loc: Pointer to a struct svga3dsurface_loc to be filled in.
+ * @offset: Offset into the surface backing store.
+ */
+static inline void
+svga3dsurface_get_loc(const struct svga3dsurface_cache *cache,
+		      struct svga3dsurface_loc *loc,
+		      size_t offset)
+{
+	const struct svga3dsurface_mip *mip = &cache->mip[0];
+	const struct svga3d_surface_desc *desc = cache->desc;
+	u32 layer;
+	int i;
+
+	if (offset >= cache->sheet_bytes)
+		offset %= cache->sheet_bytes;
+
+	layer = offset / cache->mip_chain_bytes;
+	offset -= layer * cache->mip_chain_bytes;
+	for (i = 0; i < cache->num_mip_levels; ++i, ++mip) {
+		if (mip->bytes > offset)
+			break;
+		offset -= mip->bytes;
+	}
+
+	loc->sub_resource = svga3dsurface_subres(cache, i, layer);
+	loc->z = offset / mip->img_stride;
+	offset -= loc->z * mip->img_stride;
+	loc->z *= desc->block_size.depth;
+	loc->y = offset / mip->row_stride;
+	offset -= loc->y * mip->row_stride;
+	loc->y *= desc->block_size.height;
+	loc->x = offset / desc->bytes_per_block;
+	loc->x *= desc->block_size.width;
+}
+
+/**
+ * svga3dsurface_inc_loc - Clamp increment a surface location with one block
+ * size
+ * in each dimension.
+ * @loc: Pointer to a struct svga3dsurface_loc to be incremented.
+ *
+ * When computing the size of a range as size = end - start, the range does not
+ * include the end element. However a location representing the last byte
+ * of a touched region in the backing store *is* included in the range.
+ * This function modifies such a location to match the end definition
+ * given as start + size which is the one used in a SVGA3dBox.
+ */
+static inline void
+svga3dsurface_inc_loc(const struct svga3dsurface_cache *cache,
+		      struct svga3dsurface_loc *loc)
+{
+	const struct svga3d_surface_desc *desc = cache->desc;
+	u32 mip = loc->sub_resource % cache->num_mip_levels;
+	const struct drm_vmw_size *size = &cache->mip[mip].size;
+
+	loc->sub_resource++;
+	loc->x += desc->block_size.width;
+	if (loc->x > size->width)
+		loc->x = size->width;
+	loc->y += desc->block_size.height;
+	if (loc->y > size->height)
+		loc->y = size->height;
+	loc->z += desc->block_size.depth;
+	if (loc->z > size->depth)
+		loc->z = size->depth;
+}
+
+/**
+ * svga3dsurface_min_loc - The start location in a subresource
+ * @cache: Surface layout data.
+ * @sub_resource: The subresource.
+ * @loc: Pointer to a struct svga3dsurface_loc to be filled in.
+ */
+static inline void
+svga3dsurface_min_loc(const struct svga3dsurface_cache *cache,
+		      u32 sub_resource,
+		      struct svga3dsurface_loc *loc)
+{
+	loc->sub_resource = sub_resource;
+	loc->x = loc->y = loc->z = 0;
+}
+
+/**
+ * svga3dsurface_min_loc - The end location in a subresource
+ * @cache: Surface layout data.
+ * @sub_resource: The subresource.
+ * @loc: Pointer to a struct svga3dsurface_loc to be filled in.
+ *
+ * Following the end definition given in svga3dsurface_inc_loc(),
+ * Compute the end location of a surface subresource.
+ */
+static inline void
+svga3dsurface_max_loc(const struct svga3dsurface_cache *cache,
+		      u32 sub_resource,
+		      struct svga3dsurface_loc *loc)
+{
+	const struct drm_vmw_size *size;
+	u32 mip;
+
+	loc->sub_resource = sub_resource + 1;
+	mip = sub_resource % cache->num_mip_levels;
+	size = &cache->mip[mip].size;
+	loc->x = size->width;
+	loc->y = size->height;
+	loc->z = size->depth;
+}
+
 #endif /* _SVGA3D_SURFACEDEFS_H_ */
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index dae3a39bf402..5971c0d47507 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -44,9 +44,9 @@
 #include <linux/sync_file.h>
 
 #define VMWGFX_DRIVER_NAME "vmwgfx"
-#define VMWGFX_DRIVER_DATE "20180704"
+#define VMWGFX_DRIVER_DATE "20190328"
 #define VMWGFX_DRIVER_MAJOR 2
-#define VMWGFX_DRIVER_MINOR 15
+#define VMWGFX_DRIVER_MINOR 16
 #define VMWGFX_DRIVER_PATCHLEVEL 0
 #define VMWGFX_FIFO_STATIC_SIZE (1024*1024)
 #define VMWGFX_MAX_RELOCATIONS 2048
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index c40d44f4d9af..637043f1befa 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -68,6 +68,20 @@ struct vmw_surface_offset {
 	uint32_t bo_offset;
 };
 
+/**
+ * vmw_surface_dirty - Surface dirty-tracker
+ * @cache: Cached layout information of the surface.
+ * @size: Accounting size for the struct vmw_surface_dirty.
+ * @num_subres: Number of subresources.
+ * @boxes: Array of SVGA3dBoxes indicating dirty regions. One per subresource.
+ */
+struct vmw_surface_dirty {
+	struct svga3dsurface_cache cache;
+	size_t size;
+	u32 num_subres;
+	SVGA3dBox boxes[0];
+};
+
 static void vmw_user_surface_free(struct vmw_resource *res);
 static struct vmw_resource *
 vmw_user_surface_base_to_res(struct ttm_base_object *base);
@@ -96,6 +110,13 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 				  struct drm_vmw_gb_surface_ref_ext_rep *rep,
 				  struct drm_file *file_priv);
 
+static void vmw_surface_dirty_free(struct vmw_resource *res);
+static int vmw_surface_dirty_alloc(struct vmw_resource *res);
+static int vmw_surface_dirty_sync(struct vmw_resource *res);
+static void vmw_surface_dirty_range_add(struct vmw_resource *res, size_t start,
+					size_t end);
+static int vmw_surface_clean(struct vmw_resource *res);
+
 static const struct vmw_user_resource_conv user_surface_conv = {
 	.object_type = VMW_RES_SURFACE,
 	.base_obj_to_res = vmw_user_surface_base_to_res,
@@ -133,7 +154,12 @@ static const struct vmw_res_func vmw_gb_surface_func = {
 	.create = vmw_gb_surface_create,
 	.destroy = vmw_gb_surface_destroy,
 	.bind = vmw_gb_surface_bind,
-	.unbind = vmw_gb_surface_unbind
+	.unbind = vmw_gb_surface_unbind,
+	.dirty_alloc = vmw_surface_dirty_alloc,
+	.dirty_free = vmw_surface_dirty_free,
+	.dirty_sync = vmw_surface_dirty_sync,
+	.dirty_range_add = vmw_surface_dirty_range_add,
+	.clean = vmw_surface_clean,
 };
 
 /**
@@ -641,6 +667,7 @@ static void vmw_user_surface_free(struct vmw_resource *res)
 	struct vmw_private *dev_priv = srf->res.dev_priv;
 	uint32_t size = user_srf->size;
 
+	WARN_ON_ONCE(res->dirty);
 	if (user_srf->master)
 		drm_master_put(&user_srf->master);
 	kfree(srf->offsets);
@@ -1174,10 +1201,16 @@ static int vmw_gb_surface_bind(struct vmw_resource *res,
 		cmd2->header.id = SVGA_3D_CMD_UPDATE_GB_SURFACE;
 		cmd2->header.size = sizeof(cmd2->body);
 		cmd2->body.sid = res->id;
-		res->backup_dirty = false;
 	}
 	vmw_fifo_commit(dev_priv, submit_size);
 
+	if (res->backup->dirty && res->backup_dirty) {
+		/* We've just made a full upload. Cear dirty regions. */
+		vmw_bo_dirty_clear_res(res);
+	}
+
+	res->backup_dirty = false;
+
 	return 0;
 }
 
@@ -1642,7 +1675,8 @@ vmw_gb_surface_define_internal(struct drm_device *dev,
 			}
 		}
 	} else if (req->base.drm_surface_flags &
-		   drm_vmw_surface_flag_create_buffer)
+		   (drm_vmw_surface_flag_create_buffer |
+		    drm_vmw_surface_flag_coherent))
 		ret = vmw_user_bo_alloc(dev_priv, tfile,
 					res->backup_size,
 					req->base.drm_surface_flags &
@@ -1656,6 +1690,26 @@ vmw_gb_surface_define_internal(struct drm_device *dev,
 		goto out_unlock;
 	}
 
+	if (req->base.drm_surface_flags & drm_vmw_surface_flag_coherent) {
+		struct vmw_buffer_object *backup = res->backup;
+
+		ttm_bo_reserve(&backup->base, false, false, NULL);
+		if (!res->func->dirty_alloc)
+			ret = -EINVAL;
+		if (!ret)
+			ret = vmw_bo_dirty_add(backup);
+		if (!ret) {
+			res->coherent = true;
+			ret = res->func->dirty_alloc(res);
+		}
+		ttm_bo_unreserve(&backup->base);
+		if (ret) {
+			vmw_resource_unreference(&res);
+			goto out_unlock;
+		}
+
+	}
+
 	tmp = vmw_resource_reference(res);
 	ret = ttm_prime_object_init(tfile, res->backup_size, &user_srf->prime,
 				    req->base.drm_surface_flags &
@@ -1764,3 +1818,338 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 
 	return ret;
 }
+
+/**
+ * vmw_subres_dirty_add - Add a dirty region to a subresource
+ * @dirty: The surfaces's dirty tracker.
+ * @loc_start: The location corresponding to the start of the region.
+ * @loc_end: The location corresponding to the end of the region.
+ *
+ * As we are assuming that @loc_start and @loc_end represent a sequential
+ * range of backing store memory, if the region spans multiple lines then
+ * regardless of the x coordinate, the full lines are dirtied.
+ * Correspondingly if the region spans multiple z slices, then full rather
+ * than partial z slices are dirtied.
+ */
+static void vmw_subres_dirty_add(struct vmw_surface_dirty *dirty,
+				 const struct svga3dsurface_loc *loc_start,
+				 const struct svga3dsurface_loc *loc_end)
+{
+	const struct svga3dsurface_cache *cache = &dirty->cache;
+	SVGA3dBox *box = &dirty->boxes[loc_start->sub_resource];
+	u32 mip = loc_start->sub_resource % cache->num_mip_levels;
+	const struct drm_vmw_size *size = &cache->mip[mip].size;
+	u32 box_c2 = box->z + box->d;
+
+	if (WARN_ON(loc_start->sub_resource >= dirty->num_subres))
+		return;
+
+	if (box->d == 0 || box->z > loc_start->z)
+		box->z = loc_start->z;
+	if (box_c2 < loc_end->z)
+		box->d = loc_end->z - box->z;
+
+	if (loc_start->z + 1 == loc_end->z) {
+		box_c2 = box->y + box->h;
+		if (box->h == 0 || box->y > loc_start->y)
+			box->y = loc_start->y;
+		if (box_c2 < loc_end->y)
+			box->h = loc_end->y - box->y;
+
+		if (loc_start->y + 1 == loc_end->y) {
+			box_c2 = box->x + box->w;
+			if (box->w == 0 || box->x > loc_start->x)
+				box->x = loc_start->x;
+			if (box_c2 < loc_end->x)
+				box->w = loc_end->x - box->x;
+		} else {
+			box->x = 0;
+			box->w = size->width;
+		}
+	} else {
+		box->y = 0;
+		box->h = size->height;
+		box->x = 0;
+		box->w = size->width;
+	}
+}
+
+/**
+ * vmw_subres_dirty_full - Mark a full subresource as dirty
+ * @dirty: The surface's dirty tracker.
+ * @subres: The subresource
+ */
+static void vmw_subres_dirty_full(struct vmw_surface_dirty *dirty, u32 subres)
+{
+	const struct svga3dsurface_cache *cache = &dirty->cache;
+	u32 mip = subres % cache->num_mip_levels;
+	const struct drm_vmw_size *size = &cache->mip[mip].size;
+	SVGA3dBox *box = &dirty->boxes[subres];
+
+	box->x = 0;
+	box->y = 0;
+	box->z = 0;
+	box->w = size->width;
+	box->h = size->height;
+	box->d = size->depth;
+}
+
+/*
+ * vmw_surface_tex_dirty_add_range - The dirty_add_range callback for texture
+ * surfaces.
+ */
+static void vmw_surface_tex_dirty_range_add(struct vmw_resource *res,
+					    size_t start, size_t end)
+{
+	struct vmw_surface_dirty *dirty =
+		(struct vmw_surface_dirty *) res->dirty;
+	size_t backup_end = res->backup_offset + res->backup_size;
+	struct svga3dsurface_loc loc1, loc2;
+	const struct svga3dsurface_cache *cache;
+
+	start = max_t(size_t, start, res->backup_offset) - res->backup_offset;
+	end = min(end, backup_end) - res->backup_offset;
+	cache = &dirty->cache;
+	svga3dsurface_get_loc(cache, &loc1, start);
+	svga3dsurface_get_loc(cache, &loc2, end - 1);
+	svga3dsurface_inc_loc(cache, &loc2);
+
+	if (loc1.sub_resource + 1 == loc2.sub_resource) {
+		/* Dirty range covers a single sub-resource */
+		vmw_subres_dirty_add(dirty, &loc1, &loc2);
+	} else {
+		/* Dirty range covers multiple sub-resources */
+		struct svga3dsurface_loc loc_min, loc_max;
+		u32 sub_res = loc1.sub_resource;
+
+		svga3dsurface_max_loc(cache, loc1.sub_resource, &loc_max);
+		vmw_subres_dirty_add(dirty, &loc1, &loc_max);
+		svga3dsurface_min_loc(cache, loc2.sub_resource - 1, &loc_min);
+		vmw_subres_dirty_add(dirty, &loc_min, &loc2);
+		for (sub_res = loc1.sub_resource + 1;
+		     sub_res < loc2.sub_resource - 1; ++sub_res)
+			vmw_subres_dirty_full(dirty, sub_res);
+	}
+}
+
+/*
+ * vmw_surface_tex_dirty_add_range - The dirty_add_range callback for buffer
+ * surfaces.
+ */
+static void vmw_surface_buf_dirty_range_add(struct vmw_resource *res,
+					    size_t start, size_t end)
+{
+	struct vmw_surface_dirty *dirty =
+		(struct vmw_surface_dirty *) res->dirty;
+	const struct svga3dsurface_cache *cache = &dirty->cache;
+	size_t backup_end = res->backup_offset + cache->mip_chain_bytes;
+	SVGA3dBox *box = &dirty->boxes[0];
+	u32 box_c2;
+
+	box->h = box->d = 1;
+	start = max_t(size_t, start, res->backup_offset) - res->backup_offset;
+	end = min(end, backup_end) - res->backup_offset;
+	box_c2 = box->x + box->w;
+	if (box->w == 0 || box->x > start)
+		box->x = start;
+	if (box_c2 < end)
+		box->w = end - box->x;
+}
+
+/*
+ * vmw_surface_tex_dirty_add_range - The dirty_add_range callback for surfaces
+ */
+static void vmw_surface_dirty_range_add(struct vmw_resource *res, size_t start,
+					size_t end)
+{
+	struct vmw_surface *srf = vmw_res_to_srf(res);
+
+	if (WARN_ON(end <= res->backup_offset ||
+		    start >= res->backup_offset + res->backup_size))
+		return;
+
+	if (srf->format == SVGA3D_BUFFER)
+		vmw_surface_buf_dirty_range_add(res, start, end);
+	else
+		vmw_surface_tex_dirty_range_add(res, start, end);
+}
+
+/*
+ * vmw_surface_dirty_sync - The surface's dirty_sync callback.
+ */
+static int vmw_surface_dirty_sync(struct vmw_resource *res)
+{
+	struct vmw_private *dev_priv = res->dev_priv;
+	bool has_dx = 0;
+	u32 i, num_dirty;
+	struct vmw_surface_dirty *dirty =
+		(struct vmw_surface_dirty *) res->dirty;
+	size_t alloc_size;
+	const struct svga3dsurface_cache *cache = &dirty->cache;
+	struct {
+		SVGA3dCmdHeader header;
+		SVGA3dCmdDXUpdateSubResource body;
+	} *cmd1;
+	struct {
+		SVGA3dCmdHeader header;
+		SVGA3dCmdUpdateGBImage body;
+	} *cmd2;
+	void *cmd;
+
+	num_dirty = 0;
+	for (i = 0; i < dirty->num_subres; ++i) {
+		const SVGA3dBox *box = &dirty->boxes[i];
+
+		if (box->d)
+			num_dirty++;
+	}
+
+	if (!num_dirty)
+		goto out;
+
+	alloc_size = num_dirty * ((has_dx) ? sizeof(*cmd1) : sizeof(*cmd2));
+	cmd = VMW_FIFO_RESERVE(dev_priv, alloc_size);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd1 = cmd;
+	cmd2 = cmd;
+
+	for (i = 0; i < dirty->num_subres; ++i) {
+		const SVGA3dBox *box = &dirty->boxes[i];
+
+		if (!box->d)
+			continue;
+
+		/*
+		 * DX_UPDATE_SUBRESOURCE is aware of array surfaces.
+		 * UPDATE_GB_IMAGE is not.
+		 */
+		if (has_dx) {
+			cmd1->header.id = SVGA_3D_CMD_DX_UPDATE_SUBRESOURCE;
+			cmd1->header.size = sizeof(cmd1->body);
+			cmd1->body.sid = res->id;
+			cmd1->body.subResource = i;
+			cmd1->body.box = *box;
+			cmd1++;
+		} else {
+			cmd2->header.id = SVGA_3D_CMD_UPDATE_GB_IMAGE;
+			cmd2->header.size = sizeof(cmd2->body);
+			cmd2->body.image.sid = res->id;
+			cmd2->body.image.face = i / cache->num_mip_levels;
+			cmd2->body.image.mipmap = i -
+				(cache->num_mip_levels * cmd2->body.image.face);
+			cmd2->body.box = *box;
+			cmd2++;
+		}
+
+	}
+	vmw_fifo_commit(dev_priv, alloc_size);
+ out:
+	memset(&dirty->boxes[0], 0, sizeof(dirty->boxes[0]) *
+	       dirty->num_subres);
+
+	return 0;
+}
+
+/*
+ * vmw_surface_dirty_alloc - The surface's dirty_alloc callback.
+ */
+static int vmw_surface_dirty_alloc(struct vmw_resource *res)
+{
+	struct vmw_surface *srf = vmw_res_to_srf(res);
+	struct vmw_surface_dirty *dirty;
+	u32 num_layers = 1;
+	u32 num_mip;
+	u32 num_subres;
+	u32 num_samples;
+	size_t dirty_size, acc_size;
+	static struct ttm_operation_ctx ctx = {
+		.interruptible = false,
+		.no_wait_gpu = false
+	};
+	int ret;
+
+	if (srf->array_size)
+		num_layers = srf->array_size;
+	else if (srf->flags & SVGA3D_SURFACE_CUBEMAP)
+		num_layers *= SVGA3D_MAX_SURFACE_FACES;
+
+	num_mip = srf->mip_levels[0];
+	if (!num_mip)
+		num_mip = 1;
+
+	num_subres = num_layers * num_mip;
+	dirty_size = sizeof(*dirty) + num_subres * sizeof(dirty->boxes[0]);
+	acc_size = ttm_round_pot(dirty_size);
+	ret = ttm_mem_global_alloc(vmw_mem_glob(res->dev_priv),
+				   acc_size, &ctx);
+	if (ret) {
+		VMW_DEBUG_USER("Out of graphics memory for surface "
+			       "dirty tracker.\n");
+		return ret;
+	}
+
+	dirty = kvzalloc(dirty_size, GFP_KERNEL);
+	if (!dirty) {
+		ret = -ENOMEM;
+		goto out_no_dirty;
+	}
+
+	num_samples = max_t(u32, 1, srf->multisample_count);
+	ret = svga3dsurface_setup_cache(&srf->base_size, srf->format, num_mip,
+					num_layers, num_samples, &dirty->cache);
+	if (ret)
+		goto out_no_cache;
+
+	dirty->num_subres = num_subres;
+	dirty->size = acc_size;
+	res->dirty = (struct vmw_resource_dirty *) dirty;
+
+	return 0;
+
+out_no_cache:
+	kvfree(dirty);
+out_no_dirty:
+	ttm_mem_global_free(vmw_mem_glob(res->dev_priv), acc_size);
+	return ret;
+}
+
+/*
+ * vmw_surface_dirty_free - The surface's dirty_free callback
+ */
+static void vmw_surface_dirty_free(struct vmw_resource *res)
+{
+	struct vmw_surface_dirty *dirty =
+		(struct vmw_surface_dirty *) res->dirty;
+	size_t acc_size = dirty->size;
+
+	kvfree(dirty);
+	ttm_mem_global_free(vmw_mem_glob(res->dev_priv), acc_size);
+	res->dirty = NULL;
+}
+
+/*
+ * vmw_surface_clean - The surface's clean callback
+ */
+static int vmw_surface_clean(struct vmw_resource *res)
+{
+	struct vmw_private *dev_priv = res->dev_priv;
+	size_t alloc_size;
+	struct {
+		SVGA3dCmdHeader header;
+		SVGA3dCmdReadbackGBSurface body;
+	} *cmd;
+
+	alloc_size = sizeof(*cmd);
+	cmd = VMW_FIFO_RESERVE(dev_priv, alloc_size);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->header.id = SVGA_3D_CMD_READBACK_GB_SURFACE;
+	cmd->header.size = sizeof(cmd->body);
+	cmd->body.sid = res->id;
+	vmw_fifo_commit(dev_priv, alloc_size);
+
+	return 0;
+}
diff --git a/include/uapi/drm/vmwgfx_drm.h b/include/uapi/drm/vmwgfx_drm.h
index 399f58317cff..02cab33f2f25 100644
--- a/include/uapi/drm/vmwgfx_drm.h
+++ b/include/uapi/drm/vmwgfx_drm.h
@@ -891,11 +891,13 @@ struct drm_vmw_shader_arg {
  *                                      surface.
  * @drm_vmw_surface_flag_create_buffer: Create a backup buffer if none is
  *                                      given.
+ * @drm_vmw_surface_flag_coherent:      Back surface with coherent memory.
  */
 enum drm_vmw_surface_flags {
 	drm_vmw_surface_flag_shareable = (1 << 0),
 	drm_vmw_surface_flag_scanout = (1 << 1),
-	drm_vmw_surface_flag_create_buffer = (1 << 2)
+	drm_vmw_surface_flag_create_buffer = (1 << 2),
+	drm_vmw_surface_flag_coherent = (1 << 3),
 };
 
 /**
-- 
2.20.1

