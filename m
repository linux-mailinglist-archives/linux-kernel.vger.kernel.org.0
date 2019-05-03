Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1BCB13255
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfECQi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 12:38:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47710 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfECQi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:38:29 -0400
Received: from localhost.localdomain (unknown [IPv6:2a02:2450:102f:3e0:9052:5862:59e9:e098])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robertfoss)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 94AD526104F;
        Fri,  3 May 2019 17:38:26 +0100 (BST)
From:   Robert Foss <robert.foss@collabora.com>
To:     airlied@linux.ie, kraxel@redhat.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Chia-I Wu <olvaffe@gmail.com>
Cc:     Robert Foss <robert.foss@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Subject: [PATCH] drm/virtio: Remove redundant return type
Date:   Fri,  3 May 2019 18:38:04 +0200
Message-Id: <20190503163804.31922-1-robert.foss@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio_gpu_fence_emit() always returns 0, since it
has no error paths.

Consequently no calls for virtio_gpu_fence_emit()
use the return value, and it can be removed.

Signed-off-by: Robert Foss <robert.foss@collabora.com>
Suggested-by: Emil Velikov <emil.velikov@collabora.com>
---

This patch was suggested in this email thread:

[PATCH] drm/virtio: allocate fences with GFP_KERNEL
https://www.spinics.net/lists/dri-devel/msg208536.html

 drivers/gpu/drm/virtio/virtgpu_drv.h   | 2 +-
 drivers/gpu/drm/virtio/virtgpu_fence.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index d577cb76f5ad..9bc56887fbdb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -334,7 +334,7 @@ int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma);
 /* virtio_gpu_fence.c */
 struct virtio_gpu_fence *virtio_gpu_fence_alloc(
 	struct virtio_gpu_device *vgdev);
-int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
+void virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
 			  struct virtio_gpu_fence *fence);
 void virtio_gpu_fence_event_process(struct virtio_gpu_device *vdev,
diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
index 21bd4c4a32d1..e0744ac768cc 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fence.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
@@ -81,7 +81,7 @@ struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev)
 	return fence;
 }
 
-int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
+void virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
 			  struct virtio_gpu_fence *fence)
 {
@@ -96,7 +96,6 @@ int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 
 	cmd_hdr->flags |= cpu_to_le32(VIRTIO_GPU_FLAG_FENCE);
 	cmd_hdr->fence_id = cpu_to_le64(fence->seq);
-	return 0;
 }
 
 void virtio_gpu_fence_event_process(struct virtio_gpu_device *vgdev,
-- 
2.20.1

