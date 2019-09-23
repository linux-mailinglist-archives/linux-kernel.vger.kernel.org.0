Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5A87BB44F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 14:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439578AbfIWMwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 08:52:08 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:37188 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404967AbfIWMwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:52:07 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 0DEC2B96;
        Mon, 23 Sep 2019 20:44:00 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P3051T140289744058112S1569242621440080_;
        Mon, 23 Sep 2019 20:44:00 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <6e704a054898d3f23dd3220778556226>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     hjc@rock-chips.com, linux-kernel@vger.kernel.org
Subject: [PATCH 10/36] drm/arm: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:41:14 +0800
Message-Id: <1569242500-182337-11-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569242500-182337-7-git-send-email-hjc@rock-chips.com>
References: <1569242500-182337-7-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c | 2 +-
 drivers/gpu/drm/arm/malidp_hw.c                         | 2 +-
 drivers/gpu/drm/arm/malidp_planes.c                     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
index 3b0a70e..d02dfc6 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
@@ -89,7 +89,7 @@ komeda_fb_afbc_size_check(struct komeda_fb *kfb, struct drm_file *file,
 				    alignment_header);
 
 	kfb->afbc_size = kfb->offset_payload + n_blocks *
-			 ALIGN(info->cpp[0] * AFBC_SUPERBLK_PIXELS,
+			 ALIGN(info->bpp[0] / 8 * AFBC_SUPERBLK_PIXELS,
 			       AFBC_SUPERBLK_ALIGNMENT);
 	min_size = kfb->afbc_size + fb->offsets[0];
 	if (min_size > obj->size) {
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index bd8265f..54be8d1 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -384,7 +384,7 @@ static void malidp500_modeset(struct malidp_hw_device *hwdev, struct videomode *
 int malidp_format_get_bpp(u32 fmt)
 {
 	const struct drm_format_info *info = drm_format_info(fmt);
-	int bpp = info->cpp[0] * 8;
+	int bpp = info->bpp[0];
 
 	if (bpp == 0) {
 		switch (fmt) {
diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 3c70a53..628f325 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -225,7 +225,7 @@ bool malidp_format_mod_supported(struct drm_device *drm,
 
 	if (modifier & AFBC_SPLIT) {
 		if (!info->is_yuv) {
-			if (info->cpp[0] <= 2) {
+			if (info->bpp[0] <= 16) {
 				DRM_DEBUG_KMS("RGB formats <= 16bpp are not supported with SPLIT\n");
 				return false;
 			}
-- 
2.7.4



