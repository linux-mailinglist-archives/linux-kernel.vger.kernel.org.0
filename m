Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D98CD596B4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 11:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfF1JDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 05:03:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfF1JDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:03:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 449A583F3C;
        Fri, 28 Jun 2019 09:03:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4676E1001B12;
        Fri, 28 Jun 2019 09:03:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7CD4C17472; Fri, 28 Jun 2019 11:03:03 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     ckoenig.leichtzumerken@gmail.com, thomas@shipmail.org,
        tzimmermann@suse.de, daniel@ffwll.ch, bskeggs@redhat.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 01/18] drm/ttm: add gem base object
Date:   Fri, 28 Jun 2019 11:02:46 +0200
Message-Id: <20190628090303.29467-2-kraxel@redhat.com>
In-Reply-To: <20190628090303.29467-1-kraxel@redhat.com>
References: <20190628090303.29467-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 28 Jun 2019 09:03:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add drm_gem_object struct to ttm_buffer_object, so ttm objects are a gdm
object superclass.  Add a function to check whenever a given bo actually
uses the embedded drm_gem_object, for the transition period.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 include/drm/ttm/ttm_bo_api.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 49d9cdfc58f2..082550cac92c 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -31,6 +31,7 @@
 #ifndef _TTM_BO_API_H_
 #define _TTM_BO_API_H_
 
+#include <drm/drm_gem.h>
 #include <drm/drm_hashtab.h>
 #include <drm/drm_vma_manager.h>
 #include <linux/kref.h>
@@ -127,6 +128,7 @@ struct ttm_tt;
 /**
  * struct ttm_buffer_object
  *
+ * @base: drm_gem_object superclass data.
  * @bdev: Pointer to the buffer object device structure.
  * @type: The bo type.
  * @destroy: Destruction function. If NULL, kfree is used.
@@ -169,6 +171,8 @@ struct ttm_tt;
  */
 
 struct ttm_buffer_object {
+	struct drm_gem_object base;
+
 	/**
 	 * Members constant at init.
 	 */
@@ -768,4 +772,23 @@ int ttm_bo_swapout(struct ttm_bo_global *glob,
 			struct ttm_operation_ctx *ctx);
 void ttm_bo_swapout_all(struct ttm_bo_device *bdev);
 int ttm_bo_wait_unreserved(struct ttm_buffer_object *bo);
+
+/**
+ * ttm_bo_uses_embedded_gem_object - check if the given bo uses the
+ * embedded drm_gem_object.
+ *
+ * Most ttm drivers are using gem too, so the embedded
+ * ttm_buffer_object.base will be initialized by the driver (before
+ * calling ttm_bo_init).  It is also possible to use ttm without gem
+ * though (vmwgfx does that).
+ *
+ * This helper will figure whenever a given ttm bo is a gem object too
+ * or not.
+ *
+ * @bo: The bo to check.
+ */
+static inline bool ttm_bo_uses_embedded_gem_object(struct ttm_buffer_object *bo)
+{
+	return bo->base.dev != NULL;
+}
 #endif
-- 
2.18.1

