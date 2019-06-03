Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B22A33393
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfFCPbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:31:33 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55088 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfFCPbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559575890; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qpPjjVPcvPAwJQGYcUpfDZwk6ryVkd8SjEitvpuus/w=;
        b=s6s9XT3X819O48mzKCUZ4wQ252SfJTDSKNcQxzjEgFjPJ3loZD4GrRq6g8BjELWpZ7PnEv
        w1r+ARw13Xxay1XA4XXdKTT1oyYrWuL3JJfAcnHIOZYXOT3CFe7P9yk8zX8qo+fA4uvBTG
        MluADHEbZdnyMxF54/liEKC288s9QoQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v4 3/3] drm/panel: simple: Add Sharp LS020B1DD01D panel support
Date:   Mon,  3 Jun 2019 17:31:20 +0200
Message-Id: <20190603153120.23947-3-paul@crapouillou.net>
In-Reply-To: <20190603153120.23947-1-paul@crapouillou.net>
References: <20190603153120.23947-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sharp LS020B1DD01D is a simple 2.0" 240x160 16-bit TFT panel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
    v2: No change
    
    v3: Add DRM_BUS_FLAG_SHARP_SIGNALS to the bus flags
    
    v4: Rebase on drm-misc-next (b232d4ed92ea)

 drivers/gpu/drm/panel/panel-simple.c | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5a93c4edf1e4..5049f0099fdd 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2454,6 +2454,33 @@ static const struct panel_desc sharp_lq150x1lg11 = {
 	.bus_format = MEDIA_BUS_FMT_RGB565_1X16,
 };
 
+static const struct display_timing sharp_ls020b1dd01d_timing = {
+	.pixelclock = { 2000000, 4200000, 5000000 },
+	.hactive = { 240, 240, 240 },
+	.hfront_porch = { 66, 66, 66 },
+	.hback_porch = { 1, 1, 1 },
+	.hsync_len = { 1, 1, 1 },
+	.vactive = { 160, 160, 160 },
+	.vfront_porch = { 52, 52, 52 },
+	.vback_porch = { 6, 6, 6 },
+	.vsync_len = { 10, 10, 10 },
+	.flags = DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW,
+};
+
+static const struct panel_desc sharp_ls020b1dd01d = {
+	.timings = &sharp_ls020b1dd01d_timing,
+	.num_timings = 1,
+	.bpc = 6,
+	.size = {
+		.width = 42,
+		.height = 28,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB565_1X16,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH
+		   | DRM_BUS_FLAG_PIXDATA_NEGEDGE
+		   | DRM_BUS_FLAG_SHARP_SIGNALS,
+};
+
 static const struct drm_display_mode shelly_sca07010_bfn_lnn_mode = {
 	.clock = 33300,
 	.hdisplay = 800,
@@ -3014,6 +3041,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "sharp,lq150x1lg11",
 		.data = &sharp_lq150x1lg11,
+	}, {
+		.compatible = "sharp,ls020b1dd01d",
+		.data = &sharp_ls020b1dd01d,
 	}, {
 		.compatible = "shelly,sca07010-bfn-lnn",
 		.data = &shelly_sca07010_bfn_lnn,
-- 
2.21.0.593.g511ec345e18

