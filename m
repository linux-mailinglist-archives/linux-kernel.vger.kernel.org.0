Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1595FBB47C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 14:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439720AbfIWMzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 08:55:02 -0400
Received: from regular1.263xmail.com ([211.150.70.200]:42354 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437464AbfIWMzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:55:01 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.174])
        by regular1.263xmail.com (Postfix) with ESMTP id D7EDA327;
        Mon, 23 Sep 2019 20:54:59 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P29405T140104878241536S1569243297686069_;
        Mon, 23 Sep 2019 20:54:58 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7f510e2dec1a5fec4a829d4e2f2a610e>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     hjc@rock-chips.com, linux-kernel@vger.kernel.org
Subject: [PATCH 36/36] drm/omapdrm: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:54:56 +0800
Message-Id: <1569243296-183701-1-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/omapdrm/omap_fb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index 1b8b510..d18aafa 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -87,7 +87,7 @@ static u32 get_linear_addr(struct drm_framebuffer *fb,
 	u32 offset;
 
 	offset = fb->offsets[n]
-	       + (x * format->cpp[n] / (n == 0 ? 1 : format->hsub))
+	       + (x * format->bpp[n] / 8 / (n == 0 ? 1 : format->hsub))
 	       + (y * fb->pitches[n] / (n == 0 ? 1 : format->vsub));
 
 	return plane->dma_addr + offset;
@@ -206,7 +206,7 @@ void omap_framebuffer_update_scanout(struct drm_framebuffer *fb,
 	}
 
 	/* convert to pixels: */
-	info->screen_width /= format->cpp[0];
+	info->screen_width /= format->bpp[0] / 8;
 
 	if (fb->format->format == DRM_FORMAT_NV12) {
 		plane = &omap_fb->planes[1];
@@ -382,10 +382,10 @@ struct drm_framebuffer *omap_framebuffer_init(struct drm_device *dev,
 		goto fail;
 	}
 
-	if (pitch % format->cpp[0]) {
+	if (pitch % (format->bpp[0] / 8)) {
 		dev_dbg(dev->dev,
 			"buffer pitch (%u bytes) is not a multiple of pixel size (%u bytes)\n",
-			pitch, format->cpp[0]);
+			pitch, format->bpp[0] / 8);
 		ret = -EINVAL;
 		goto fail;
 	}
-- 
2.7.4



