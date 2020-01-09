Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A592135801
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 12:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbgAILbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 06:31:15 -0500
Received: from mail.manjaro.org ([176.9.38.148]:36562 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgAILbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:31:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 0BE9036E4E5F;
        Thu,  9 Jan 2020 12:31:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vlTgAkb2G5RS; Thu,  9 Jan 2020 12:31:10 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [RESEND 1/1] drm/panel: Add support for BOE NV140FHM-N49 panel to panel-simple
Date:   Thu,  9 Jan 2020 12:29:52 +0100
Message-Id: <20200109112952.2620-2-t.schramm@manjaro.org>
In-Reply-To: <20200109112952.2620-1-t.schramm@manjaro.org>
References: <20200109112952.2620-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the BOE NV140FHM-N49 panel to the panel-simple
driver. The panel is used by the pine64 Pinebook Pro.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 35 ++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5d487686d25c..6320df9765f3 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1036,6 +1036,38 @@ static const struct panel_desc boe_nv101wxmn51 = {
 	},
 };
 
+static const struct drm_display_mode boe_nv140fhmn49_modes[] = {
+	{
+		.clock = 148500,
+		.hdisplay = 1920,
+		.hsync_start = 1920 + 48,
+		.hsync_end = 1920 + 48 + 32,
+		.htotal = 2200,
+		.vdisplay = 1080,
+		.vsync_start = 1080 + 3,
+		.vsync_end = 1080 + 3 + 5,
+		.vtotal = 1125,
+		.vrefresh = 60,
+	},
+};
+
+static const struct panel_desc boe_nv140fhmn49 = {
+	.modes = boe_nv140fhmn49_modes,
+	.num_modes = ARRAY_SIZE(boe_nv140fhmn49_modes),
+	.bpc = 6,
+	.size = {
+		.width = 309,
+		.height = 174,
+	},
+	.delay = {
+		.prepare = 210,
+		.enable = 50,
+		.unprepare = 160,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+	.connector_type = DRM_MODE_CONNECTOR_eDP,
+};
+
 static const struct drm_display_mode cdtech_s043wq26h_ct7_mode = {
 	.clock = 9000,
 	.hdisplay = 480,
@@ -3161,6 +3193,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "boe,nv101wxmn51",
 		.data = &boe_nv101wxmn51,
+	}, {
+		.compatible = "boe,nv140fhmn49",
+		.data = &boe_nv140fhmn49,
 	}, {
 		.compatible = "cdtech,s043wq26h-ct7",
 		.data = &cdtech_s043wq26h_ct7,
-- 
2.24.1

