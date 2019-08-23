Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 621949AC36
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 11:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390459AbfHWJzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 05:55:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389561AbfHWJzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:55:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DCDF3064FCF;
        Fri, 23 Aug 2019 09:55:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com [10.36.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D7EC6092D;
        Fri, 23 Aug 2019 09:55:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 52D9231E80; Fri, 23 Aug 2019 11:55:03 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 02/18] drm/virtio: switch virtio_gpu_wait_ioctl() to gem helper.
Date:   Fri, 23 Aug 2019 11:54:47 +0200
Message-Id: <20190823095503.2261-3-kraxel@redhat.com>
In-Reply-To: <20190823095503.2261-1-kraxel@redhat.com>
References: <20190823095503.2261-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 23 Aug 2019 09:55:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use drm_gem_reservation_object_wait() in virtio_gpu_wait_ioctl().
This also makes the ioctl run lockless.

v5: handle lookup failure.
v2: use reservation_object_test_signaled_rcu for VIRTGPU_WAIT_NOWAIT.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 0a88ef11b9d3..74b6bad01d7f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -466,23 +466,20 @@ static int virtio_gpu_wait_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *file)
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
-		return -ENOENT;
+	if (args->flags & VIRTGPU_WAIT_NOWAIT) {
+		obj = drm_gem_object_lookup(file, args->handle);
+		if (obj == NULL)
+			return -ENOENT;
+		ret = dma_resv_test_signaled_rcu(obj->resv, true);
+		drm_gem_object_put_unlocked(obj);
+		return ret ? 0 : -EBUSY;
+	}
 
-	qobj = gem_to_virtio_gpu_obj(gobj);
-
-	if (args->flags & VIRTGPU_WAIT_NOWAIT)
-		nowait = true;
-	ret = virtio_gpu_object_wait(qobj, nowait);
-
-	drm_gem_object_put_unlocked(gobj);
-	return ret;
+	return drm_gem_dma_resv_wait(file, args->handle, true, timeout);
 }
 
 static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
-- 
2.18.1

