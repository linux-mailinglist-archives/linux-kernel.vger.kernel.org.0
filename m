Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 555541041C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 18:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfKTRKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 12:10:53 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:54866 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfKTRKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1574269837; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q7XM9VKEul3WoIle4adCI8wIKzVFhhXtSEViQ1Z4XrQ=;
        b=TdN7U5ylrFeveewEL9FpwmfbR1Pp9uHzNKPAoE4pE6mNPqn6fvXCceCHOCCVe+Ms3wNTKZ
        2PuV+gO+0cZ/CmM5M2b7m+fn/DPmp3qmqer1HSe6uc24+Rp9lUSgVSCOiKrrbb4UErusdG
        mscwdhuIDkoTz/ytUkAJbxseUOfBpRs=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] drm/panel: simple: Add support for the Frida FRD350H54004 panel
Date:   Wed, 20 Nov 2019 18:10:27 +0100
Message-Id: <20191120171027.1102250-3-paul@crapouillou.net>
In-Reply-To: <20191120171027.1102250-1-paul@crapouillou.net>
References: <20191120171027.1102250-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FRD350H54004 is a simple 3.5" 320x240 24-bit TFT panel, found for
instance inside the Anbernic RG-350 handheld gaming console.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 28fa6ba7b767..8c03f7fe461c 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1378,6 +1378,32 @@ static const struct panel_desc evervision_vgg804821 = {
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_NEGEDGE,
 };
 
+static const struct drm_display_mode frida_frd350h54004_mode = {
+	.clock = 6777,
+	.hdisplay = 320,
+	.hsync_start = 320 + 70,
+	.hsync_end = 320 + 70 + 50,
+	.htotal = 320 + 70 + 50 + 10,
+	.vdisplay = 240,
+	.vsync_start = 240 + 5,
+	.vsync_end = 240 + 5 + 1,
+	.vtotal = 240 + 5 + 1 + 5,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+};
+
+static const struct panel_desc frida_frd350h54004 = {
+	.modes = &frida_frd350h54004_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 77,
+		.height = 64,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
+};
+
 static const struct drm_display_mode foxlink_fl500wvr00_a0t_mode = {
 	.clock = 32260,
 	.hdisplay = 800,
@@ -3186,6 +3212,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "evervision,vgg804821",
 		.data = &evervision_vgg804821,
+	}, {
+		.compatible = "frida,frd350h54004",
+		.data = &frida_frd350h54004,
 	}, {
 		.compatible = "foxlink,fl500wvr00-a0t",
 		.data = &foxlink_fl500wvr00_a0t,
-- 
2.24.0

