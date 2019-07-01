Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF448596E0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 11:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfF1JED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 05:04:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbfF1JDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:03:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5210487633;
        Fri, 28 Jun 2019 09:03:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 689214DA32;
        Fri, 28 Jun 2019 09:03:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 6DD2E11AA3; Fri, 28 Jun 2019 11:03:09 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     ckoenig.leichtzumerken@gmail.com, thomas@shipmail.org,
        tzimmermann@suse.de, daniel@ffwll.ch, bskeggs@redhat.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 16/18] drm/qxl: switch driver from bo->resv to bo->base.resv
Date:   Fri, 28 Jun 2019 11:03:01 +0200
Message-Id: <20190628090303.29467-17-kraxel@redhat.com>
In-Reply-To: <20190628090303.29467-1-kraxel@redhat.com>
References: <20190628090303.29467-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 28 Jun 2019 09:03:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/qxl/qxl_debugfs.c | 2 +-
 drivers/gpu/drm/qxl/qxl_release.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_debugfs.c b/drivers/gpu/drm/qxl/qxl_debugfs.c
index 013b938986c7..f30460782f05 100644
--- a/drivers/gpu/drm/qxl/qxl_debugfs.c
+++ b/drivers/gpu/drm/qxl/qxl_debugfs.c
@@ -61,7 +61,7 @@ qxl_debugfs_buffers_info(struct seq_file *m, void *data)
 		int rel;
 
 		rcu_read_lock();
-		fobj = rcu_dereference(bo->tbo.resv->fence);
+		fobj = rcu_dereference(bo->tbo.base.resv->fence);
 		rel = fobj ? fobj->shared_count : 0;
 		rcu_read_unlock();
 
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 32126e8836b3..1b7be82c8e68 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -234,7 +234,7 @@ static int qxl_release_validate_bo(struct qxl_bo *bo)
 			return ret;
 	}
 
-	ret = reservation_object_reserve_shared(bo->tbo.resv, 1);
+	ret = reservation_object_reserve_shared(bo->tbo.base.resv, 1);
 	if (ret)
 		return ret;
 
@@ -454,9 +454,9 @@ void qxl_release_fence_buffer_objects(struct qxl_release *release)
 	list_for_each_entry(entry, &release->bos, head) {
 		bo = entry->bo;
 
-		reservation_object_add_shared_fence(bo->resv, &release->base);
+		reservation_object_add_shared_fence(bo->base.resv, &release->base);
 		ttm_bo_add_to_lru(bo);
-		reservation_object_unlock(bo->resv);
+		reservation_object_unlock(bo->base.resv);
 	}
 	spin_unlock(&glob->lru_lock);
 	ww_acquire_fini(&release->ticket);
-- 
2.18.1

