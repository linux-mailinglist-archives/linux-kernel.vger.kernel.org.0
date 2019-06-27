Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A34E258659
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 17:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfF0Pxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 11:53:34 -0400
Received: from foss.arm.com ([217.140.110.172]:57558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfF0Pxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:53:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B109C1477;
        Thu, 27 Jun 2019 08:53:31 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78AA33F246;
        Thu, 27 Jun 2019 08:53:29 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] drm/panfrost: Use drm_gem_map_offset()
Date:   Thu, 27 Jun 2019 16:53:18 +0100
Message-Id: <20190627155318.38053-3-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627155318.38053-1-steven.price@arm.com>
References: <20190627155318.38053-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

panfrost_ioctl_mmap_bo() contains a reimplementation of
drm_gem_map_offset() but with a bug - it allows mapping imported
objects (without going through the exporter). Fix this by switching to
use the newly renamed drm_gem_map_offset() function instead which has
the bonus of simplifying the code.

Signed-off-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index e34e86a7378a..1498b9b07a8f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -259,26 +259,14 @@ static int panfrost_ioctl_mmap_bo(struct drm_device *dev, void *data,
 		      struct drm_file *file_priv)
 {
 	struct drm_panfrost_mmap_bo *args = data;
-	struct drm_gem_object *gem_obj;
-	int ret;
 
 	if (args->flags != 0) {
 		DRM_INFO("unknown mmap_bo flags: %d\n", args->flags);
 		return -EINVAL;
 	}
 
-	gem_obj = drm_gem_object_lookup(file_priv, args->handle);
-	if (!gem_obj) {
-		DRM_DEBUG("Failed to look up GEM BO %d\n", args->handle);
-		return -ENOENT;
-	}
-
-	ret = drm_gem_create_mmap_offset(gem_obj);
-	if (ret == 0)
-		args->offset = drm_vma_node_offset_addr(&gem_obj->vma_node);
-	drm_gem_object_put_unlocked(gem_obj);
-
-	return ret;
+	return drm_gem_map_offset(file_priv, dev, args->handle,
+				       &args->offset);
 }
 
 static int panfrost_ioctl_get_bo_offset(struct drm_device *dev, void *data,
-- 
2.20.1

