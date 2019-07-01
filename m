Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 099BA20A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 16:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfEPO4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 10:56:01 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:42075 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfEPO4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:56:01 -0400
Received: from localhost.localdomain (aaubervilliers-681-1-43-46.w90-88.abo.wanadoo.fr [90.88.161.46])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 3935720001A;
        Thu, 16 May 2019 14:55:53 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v9 1/4] drm/vc4: Reformat and the binner bo allocation helper
Date:   Thu, 16 May 2019 16:55:41 +0200
Message-Id: <20190516145544.29051-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190516145544.29051-1-paul.kocialkowski@bootlin.com>
References: <20190516145544.29051-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for wrapping the binner bo allocation helper with
put/get helpers, pass the vc4 dev directly and drop the vc4 prefix.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/vc4/vc4_v3d.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index a4b6859e3af6..7c490106e185 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -213,7 +213,7 @@ int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
 }
 
 /**
- * vc4_allocate_bin_bo() - allocates the memory that will be used for
+ * bin_bo_alloc() - allocates the memory that will be used for
  * tile binning.
  *
  * The binner has a limitation that the addresses in the tile state
@@ -234,9 +234,8 @@ int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
  * overall CMA pool before they make scenes complicated enough to run
  * out of bin space.
  */
-static int vc4_allocate_bin_bo(struct drm_device *drm)
+static int bin_bo_alloc(struct vc4_dev *vc4)
 {
-	struct vc4_dev *vc4 = to_vc4_dev(drm);
 	struct vc4_v3d *v3d = vc4->v3d;
 	uint32_t size = 16 * 1024 * 1024;
 	int ret = 0;
@@ -251,7 +250,7 @@ static int vc4_allocate_bin_bo(struct drm_device *drm)
 	INIT_LIST_HEAD(&list);
 
 	while (true) {
-		struct vc4_bo *bo = vc4_bo_create(drm, size, true,
+		struct vc4_bo *bo = vc4_bo_create(vc4->dev, size, true,
 						  VC4_BO_TYPE_BIN);
 
 		if (IS_ERR(bo)) {
@@ -333,7 +332,7 @@ static int vc4_v3d_runtime_resume(struct device *dev)
 	struct vc4_dev *vc4 = v3d->vc4;
 	int ret;
 
-	ret = vc4_allocate_bin_bo(vc4->dev);
+	ret = bin_bo_alloc(vc4);
 	if (ret)
 		return ret;
 
@@ -403,7 +402,7 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 	if (ret != 0)
 		return ret;
 
-	ret = vc4_allocate_bin_bo(drm);
+	ret = bin_bo_alloc(vc4);
 	if (ret) {
 		clk_disable_unprepare(v3d->clk);
 		return ret;
-- 
2.21.0

