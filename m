Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D864A162F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 12:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfH2Kdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 06:33:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbfH2KdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:33:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C510B7FDEE;
        Thu, 29 Aug 2019 10:33:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-95.ams2.redhat.com [10.36.116.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9A6E5C1D6;
        Thu, 29 Aug 2019 10:33:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2B33A31E84; Thu, 29 Aug 2019 12:33:02 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 02/18] drm/virtio: switch virtio_gpu_wait_ioctl() to gem helper.
Date:   Thu, 29 Aug 2019 12:32:45 +0200
Message-Id: <20190829103301.3539-3-kraxel@redhat.com>
In-Reply-To: <20190829103301.3539-1-kraxel@redhat.com>
References: <20190829103301.3539-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 29 Aug 2019 10:33:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use drm_gem_reservation_object_wait() in virtio_gpu_wait_ioctl().
This also makes the ioctl run lockless.

v9: fix return value.
v5: handle lookup failure.
v2: use reservation_object_test_signaled_rcu for VIRTGPU_WAIT_NOWAIT.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 28 +++++++++++++++-----------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 0a88ef11b9d3..a662394f6892 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -463,25 +463,29 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm_device *dev, void *data,
 }
 
 static int virtio_gpu_wait_ioctl(struct drm_device *dev, void *data,
-			    struct drm_file *file)
+				 struct drm_file *file)
 {
 	struct drm_virtgpu_3d_wait *args = data;
-	struct drm_gem_object *gobj = NULL;
-	struct virtio_gpu_object *qobj = NULL;
+	struct drm_gem_object *obj;
+	long timeout = 15 * HZ;
 	int ret;
-	bool nowait = false;
 
-	gobj = drm_gem_object_lookup(file, args->handle);
-	if (gobj == NULL)
+	obj = drm_gem_object_lookup(file, args->handle);
+	if (obj == NULL)
 		return -ENOENT;
 
-	qobj = gem_to_virtio_gpu_obj(gobj);
+	if (args->flags & VIRTGPU_WAIT_NOWAIT) {
+		ret = dma_resv_test_signaled_rcu(obj->resv, true);
+	} else {
+		ret = dma_resv_wait_timeout_rcu(obj->resv, true, true,
+						timeout);
+	}
+	if (ret == 0)
+		ret = -EBUSY;
+	else if (ret > 0)
+		ret = 0;
 
-	if (args->flags & VIRTGPU_WAIT_NOWAIT)
-		nowait = true;
-	ret = virtio_gpu_object_wait(qobj, nowait);
-
-	drm_gem_object_put_unlocked(gobj);
+	drm_gem_object_put_unlocked(obj);
 	return ret;
 }
 
-- 
2.18.1

