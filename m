Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62079120F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 17:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfLPQVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 11:21:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56090 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLPQVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:21:40 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1igt7o-0004Vj-Tk; Mon, 16 Dec 2019 16:21:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/gma500: fix null dereference of pointer fb before null check
Date:   Mon, 16 Dec 2019 16:21:36 +0000
Message-Id: <20191216162136.270114-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer fb is being dereferenced when assigning dev before it
is null checked.  Fix this by only dereferencing dev after the
null check.

Fixes: 6b7ce2c4161a ("drm/gma500: Remove struct psb_fbdev")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/gma500/accel_2d.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/accel_2d.c b/drivers/gpu/drm/gma500/accel_2d.c
index b9e5a38632f7..adc0507545bf 100644
--- a/drivers/gpu/drm/gma500/accel_2d.c
+++ b/drivers/gpu/drm/gma500/accel_2d.c
@@ -228,8 +228,8 @@ static void psbfb_copyarea_accel(struct fb_info *info,
 {
 	struct drm_fb_helper *fb_helper = info->par;
 	struct drm_framebuffer *fb = fb_helper->fb;
-	struct drm_device *dev = fb->dev;
-	struct drm_psb_private *dev_priv = dev->dev_private;
+	struct drm_device *dev;
+	struct drm_psb_private *dev_priv;
 	uint32_t offset;
 	uint32_t stride;
 	uint32_t src_format;
@@ -238,6 +238,8 @@ static void psbfb_copyarea_accel(struct fb_info *info,
 	if (!fb)
 		return;
 
+	dev = fb->dev;
+	dev_priv = dev->dev_private;
 	offset = to_gtt_range(fb->obj[0])->offset;
 	stride = fb->pitches[0];
 
-- 
2.24.0

