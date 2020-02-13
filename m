Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C564015BF23
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 14:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgBMNWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 08:22:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31550 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729973AbgBMNWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581600133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=5EatEPQudpiUKbeJ4n/F+XA+cWPrST5Nenz3vPabTag=;
        b=LHpZ9IKvXzXYASnGfFoU1fvtTLlfrr4/KmvfVnAWrSxOyHdnHwj4M+PbDC3yYyXy/W9s94
        FSCEh+Q72XWD1M0/egbOOL1xkcn0tclUk//hSh4lGhgD3bLXcYJniQVjQonZFUG9kgb5mZ
        tg4p/RsCVP9+skOc5O6lQwpsus1Tfmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-VFNE9Dm_M5aACxdNPrO6Cg-1; Thu, 13 Feb 2020 08:22:09 -0500
X-MC-Unique: VFNE9Dm_M5aACxdNPrO6Cg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38C901005502;
        Thu, 13 Feb 2020 13:22:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com [10.36.117.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5163660BF4;
        Thu, 13 Feb 2020 13:22:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 992CD3EC25; Thu, 13 Feb 2020 14:22:04 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/4] drm/virtio: batch display query.
Date:   Thu, 13 Feb 2020 14:22:03 +0100
Message-Id: <20200213132203.23441-5-kraxel@redhat.com>
In-Reply-To: <20200213132203.23441-1-kraxel@redhat.com>
References: <20200213132203.23441-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move virtio_gpu_notify() to higher-level functions for
virtio_gpu_cmd_get_display_info() and virtio_gpu_cmd_get_edids().

virtio_gpu_config_changed_work_func() and virtio_gpu_init() will
batch commands and notify only once per update

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 2 ++
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 4009c2f97d08..8fd7acef960f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -44,6 +44,7 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
 		if (vgdev->has_edid)
 			virtio_gpu_cmd_get_edids(vgdev);
 		virtio_gpu_cmd_get_display_info(vgdev);
+		virtio_gpu_notify(vgdev);
 		drm_helper_hpd_irq_event(vgdev->ddev);
 		events_clear |= VIRTIO_GPU_EVENT_DISPLAY;
 	}
@@ -205,6 +206,7 @@ int virtio_gpu_init(struct drm_device *dev)
 	if (vgdev->has_edid)
 		virtio_gpu_cmd_get_edids(vgdev);
 	virtio_gpu_cmd_get_display_info(vgdev);
+	virtio_gpu_notify(vgdev);
 	wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
 			   5 * HZ);
 	return 0;
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 778b7acf2f7f..f5740d7b67be 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -774,7 +774,6 @@ int virtio_gpu_cmd_get_display_info(struct virtio_gpu_device *vgdev)
 	vgdev->display_info_pending = true;
 	cmd_p->type = cpu_to_le32(VIRTIO_GPU_CMD_GET_DISPLAY_INFO);
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
-	virtio_gpu_notify(vgdev);
 	return 0;
 }
 
@@ -902,7 +901,6 @@ int virtio_gpu_cmd_get_edids(struct virtio_gpu_device *vgdev)
 		cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_GET_EDID);
 		cmd_p->scanout = cpu_to_le32(scanout);
 		virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
-		virtio_gpu_notify(vgdev);
 	}
 
 	return 0;
-- 
2.18.2

