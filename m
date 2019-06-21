Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6524E787
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 13:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfFUL6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 07:58:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfFUL6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:58:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1433AC057F2B;
        Fri, 21 Jun 2019 11:58:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-212.ams2.redhat.com [10.36.116.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8CE45C221;
        Fri, 21 Jun 2019 11:58:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 6D2519D6B; Fri, 21 Jun 2019 13:58:00 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     ckoenig.leichtzumerken@gmail.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 18/18] drm/ttm: drop ttm_buffer_object->resv
Date:   Fri, 21 Jun 2019 13:57:55 +0200
Message-Id: <20190621115755.8481-19-kraxel@redhat.com>
In-Reply-To: <20190621115755.8481-1-kraxel@redhat.com>
References: <20190621115755.8481-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 21 Jun 2019 11:58:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users moved to ttm_buffer_object->base.resv

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/ttm/ttm_bo_api.h | 1 -
 drivers/gpu/drm/ttm/ttm_bo.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 77bd420a147a..af331d56951c 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -231,7 +231,6 @@ struct ttm_buffer_object {
 
 	struct sg_table *sg;
 
-	struct reservation_object *resv;
 	struct mutex wu_mutex;
 };
 
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index e0792fd38b54..7465bf62e54c 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1330,11 +1330,9 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
 	bo->acc_size = acc_size;
 	bo->sg = sg;
 	if (resv) {
-		bo->resv = resv;
 		bo->base.resv = resv;
 		reservation_object_assert_held(bo->base.resv);
 	} else {
-		bo->resv = &bo->base._resv;
 		bo->base.resv = &bo->base._resv;
 	}
 	if (!ttm_bo_uses_embedded_gem_object(bo)) {
-- 
2.18.1

