Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA3DBED56
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 10:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfIZIZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 04:25:10 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:37624 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfIZIZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:25:09 -0400
Received: from localhost (unknown [192.168.167.193])
        by lucky1.263xmail.com (Postfix) with ESMTP id 58F406F948;
        Thu, 26 Sep 2019 16:25:06 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P24701T140118476191488S1569486296531843_;
        Thu, 26 Sep 2019 16:25:05 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <d8546e140cddddc8a983673ce8310bc9>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     hjc@rock-chips.com, heiko@sntech.de, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drm: Add some new format DRM_FORMAT_NVXX_10
Date:   Thu, 26 Sep 2019 16:24:47 +0800
Message-Id: <1569486289-152061-2-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569486289-152061-1-git-send-email-hjc@rock-chips.com>
References: <1569486289-152061-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These new format is supported by some rockchip socs:

DRM_FORMAT_NV12_10/DRM_FORMAT_NV21_10
DRM_FORMAT_NV16_10/DRM_FORMAT_NV61_10
DRM_FORMAT_NV24_10/DRM_FORMAT_NV42_10

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 18 ++++++++++++++++++
 include/uapi/drm/drm_fourcc.h | 14 ++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index c630064..ccd78a3 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -261,6 +261,24 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_P016,		.depth = 0,  .num_planes = 2,
 		  .char_per_block = { 2, 4, 0 }, .block_w = { 1, 0, 0 }, .block_h = { 1, 0, 0 },
 		  .hsub = 2, .vsub = 2, .is_yuv = true},
+		{ .format = DRM_FORMAT_NV12_10,		.depth = 0,  .num_planes = 2,
+		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
+		  .hsub = 2, .vsub = 2, .is_yuv = true},
+		{ .format = DRM_FORMAT_NV21_10,		.depth = 0,  .num_planes = 2,
+		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
+		  .hsub = 2, .vsub = 2, .is_yuv = true},
+		{ .format = DRM_FORMAT_NV16_10,		.depth = 0,  .num_planes = 2,
+		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
+		  .hsub = 2, .vsub = 1, .is_yuv = true},
+		{ .format = DRM_FORMAT_NV61_10,		.depth = 0,  .num_planes = 2,
+		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
+		  .hsub = 2, .vsub = 1, .is_yuv = true},
+		{ .format = DRM_FORMAT_NV24_10,		.depth = 0,  .num_planes = 2,
+		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
+		  .hsub = 1, .vsub = 1, .is_yuv = true},
+		{ .format = DRM_FORMAT_NV42_10,		.depth = 0,  .num_planes = 2,
+		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
+		  .hsub = 1, .vsub = 1, .is_yuv = true},
 		{ .format = DRM_FORMAT_P210,		.depth = 0,
 		  .num_planes = 2, .char_per_block = { 2, 4, 0 },
 		  .block_w = { 1, 0, 0 }, .block_h = { 1, 0, 0 }, .hsub = 2,
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 3feeaa3..08e2221 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -238,6 +238,20 @@ extern "C" {
 #define DRM_FORMAT_NV42		fourcc_code('N', 'V', '4', '2') /* non-subsampled Cb:Cr plane */
 
 /*
+ * 2 plane YCbCr
+ * index 0 = Y plane, Y3:Y2:Y1:Y0 10:10:10:10
+ * index 1 = Cb:Cr plane, Cb3:Cr3:Cb2:Cr2:Cb1:Cr1:Cb0:Cr0 10:10:10:10:10:10:10:10
+ * or
+ * index 1 = Cr:Cb plane, Cr3:Cb3:Cr2:Cb2:Cr1:Cb1:Cr0:Cb0 10:10:10:10:10:10:10:10
+ */
+#define DRM_FORMAT_NV12_10	fourcc_code('N', 'A', '1', '2') /* 2x2 subsampled Cr:Cb plane */
+#define DRM_FORMAT_NV21_10	fourcc_code('N', 'A', '2', '1') /* 2x2 subsampled Cb:Cr plane */
+#define DRM_FORMAT_NV16_10	fourcc_code('N', 'A', '1', '6') /* 2x1 subsampled Cr:Cb plane */
+#define DRM_FORMAT_NV61_10	fourcc_code('N', 'A', '6', '1') /* 2x1 subsampled Cb:Cr plane */
+#define DRM_FORMAT_NV24_10	fourcc_code('N', 'A', '2', '4') /* non-subsampled Cr:Cb plane */
+#define DRM_FORMAT_NV42_10	fourcc_code('N', 'A', '4', '2') /* non-subsampled Cb:Cr plane */
+
+/*
  * 2 plane YCbCr MSB aligned
  * index 0 = Y plane, [15:0] Y:x [10:6] little endian
  * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
-- 
2.7.4



