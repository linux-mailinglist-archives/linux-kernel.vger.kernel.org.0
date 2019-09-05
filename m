Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985B4A9B23
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 09:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbfIEHF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 03:05:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731734AbfIEHFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:05:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BFEFC05E740;
        Thu,  5 Sep 2019 07:05:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-72.ams2.redhat.com [10.36.117.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6197D5C207;
        Thu,  5 Sep 2019 07:05:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B0CC231F00; Thu,  5 Sep 2019 09:05:10 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 6/8] drm/qxl: switch to gem vma offset manager
Date:   Thu,  5 Sep 2019 09:05:07 +0200
Message-Id: <20190905070509.22407-7-kraxel@redhat.com>
In-Reply-To: <20190905070509.22407-1-kraxel@redhat.com>
References: <20190905070509.22407-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 05 Sep 2019 07:05:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass gem vma_offset_manager to ttm_bo_device_init(), so ttm uses it
instead of its own embedded struct.  This makes some gem functions
(specifically drm_gem_object_lookup) work on ttm objects.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 69da0eea6e4c..cbc6c2ba8630 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -325,7 +325,7 @@ int qxl_ttm_init(struct qxl_device *qdev)
 	r = ttm_bo_device_init(&qdev->mman.bdev,
 			       &qxl_bo_driver,
 			       qdev->ddev.anon_inode->i_mapping,
-			       NULL,
+			       qdev->ddev.vma_offset_manager,
 			       false);
 	if (r) {
 		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
-- 
2.18.1

