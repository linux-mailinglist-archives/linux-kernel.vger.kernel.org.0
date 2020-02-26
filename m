Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B224A16F678
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 05:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgBZEaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 23:30:55 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:33598 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgBZEay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1582691453; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=EBs+WyA9SoX0izZ/2YmeENtSC3EofRpkHiHuspGvF2k=;
        b=IWlayfR7Bunx4LFkE4p/wAp7BSODGzofuzBCHue4eX+xxz559in2m6Opf0JBNiCgI3FL3B
        y6iNKebknpDSFT0C8kuXLbA+I9wNvGVD9/WYBH37JmnzN+DlrbUyVHl2AoxbIDekC17JTr
        rtCiqoTGTX927hJ5zMIpjEQ+yD3ph2w=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/3] gpu/drm: ingenic: Add trick to support 16bpp on 24-bit panels
Date:   Wed, 26 Feb 2020 01:30:39 -0300
Message-Id: <20200226043041.289764-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the panel interface is 24-bit but our primary plane is 16bpp,
configure as if the panel was 18-bit. This tricks permits the display
of 16bpp data on a 24-bit panel by wiring each color component to the
MSBs of the 24-bit interface.

v2: Check bytes-per-pixel count instead of fourcc format

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index 6d47ef7b148c..5493a80d7d2f 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -400,6 +400,8 @@ static void ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
 	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
 	struct drm_connector *conn = conn_state->connector;
 	struct drm_display_info *info = &conn->display_info;
+	struct drm_plane_state *plane_state = crtc_state->crtc->primary->state;
+	const struct drm_format_info *finfo = NULL;
 	unsigned int cfg;
 
 	priv->panel_is_sharp = info->bus_flags & DRM_BUS_FLAG_SHARP_SIGNALS;
@@ -435,7 +437,21 @@ static void ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
 				cfg |= JZ_LCD_CFG_MODE_GENERIC_18BIT;
 				break;
 			case MEDIA_BUS_FMT_RGB888_1X24:
-				cfg |= JZ_LCD_CFG_MODE_GENERIC_24BIT;
+				if (plane_state && plane_state->fb)
+					finfo = plane_state->fb->format;
+
+				/*
+				 * If the panel interface is 24-bit but our
+				 * primary plane is 16bpp, configure as if the
+				 * panel was 18-bit. This tricks permits the
+				 * display of 16bpp data on a 24-bit panel by
+				 * wiring each color component to the MSBs of
+				 * the 24-bit interface.
+				 */
+				if (finfo && finfo->cpp[0] < 3)
+					cfg |= JZ_LCD_CFG_MODE_GENERIC_18BIT;
+				else
+					cfg |= JZ_LCD_CFG_MODE_GENERIC_24BIT;
 				break;
 			case MEDIA_BUS_FMT_RGB888_3X8:
 				cfg |= JZ_LCD_CFG_MODE_8BIT_SERIAL;
-- 
2.25.0

