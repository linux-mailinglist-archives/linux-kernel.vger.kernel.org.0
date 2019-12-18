Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 744E7124C19
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 16:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfLRPrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 10:47:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37889 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfLRPqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:46:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so2427831wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 07:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BH6e3bahFkWBTjXwfWXdljOGokLAIKV+wnWDzABNP74=;
        b=omVWiHXLRaPV/ydWfQBU04NH95kIXEj2dP02jegjAK8kLmWE1KU9Sv2MygDYSmBgkL
         1ySn1Eg/LgD5mL9l+KRkxDFRz2gv953PmMSDRsrQBAo/F7O/W5q6KD0uoxxGGcDekonL
         DGuBsISgSk8tB2EIOvreCPHyC7I7P2x8fa387bjQ/3VKRFNOZAiMEsS/C6eYzEuAumNh
         veZmmKEcVuNhypTLKgeCF2HQS6he78ot8MfdB+D2QeKM2llpVOKFk4zo9P48fsL2C0QH
         4vv1KTfy0eq2bDMXcB9bWw0GHBf1bGZAh4xXpKb/nNhlCAHnJg0GhFwhYEFD3oNbHwA1
         Ul1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BH6e3bahFkWBTjXwfWXdljOGokLAIKV+wnWDzABNP74=;
        b=pnvMIPwj+PiO4cNixQKzceZ+ZMWMwdC/yFmE966DruSArhisBRc5ajLUGyPbMOSCxU
         r0hj938ueaUmrFl1oZq2lHRzBLU0q6psIRWJcOL9TZbz1BkCfeP5Ewez6F7IZMZudYvs
         H8Fbx75Vz96E/6cRzixpbS05FX7vHpInxxQNC6FKVGacUzDnXSD4DaFQOBLDe1DPDkKM
         ZLx9FLu31xuXk0HX3fVptoC620u1hPXJEUq+hmDyGj/ZLgyLCrv9gTtqr7z+/f/jWTkw
         Z6Gl3ylMj5XtRgoknwucnRAZfXMaDKJ0ikUh84n3I0yXaH6b73KbuD91F8EyJf0z3AV6
         5/vA==
X-Gm-Message-State: APjAAAWLZMIiXb6gNQVwz+aPK0h2tMohG8WkYT5vN+YIu/EvyRxUqaOR
        Z2C7of0JCJEORrZ9pBcXyYHNXg==
X-Google-Smtp-Source: APXvYqwiMmPBuwhf+2rWRor3F5AMIaAs7w/h+pInq8Kwk/3+4ZeaOmiz1xHepKTgUKges0nOG5L2Hw==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr4206960wmj.54.1576684008490;
        Wed, 18 Dec 2019 07:46:48 -0800 (PST)
Received: from bender.baylibre.local (lfbn-nic-1-505-157.w90-116.abo.wanadoo.fr. [90.116.92.157])
        by smtp.gmail.com with ESMTPSA id x1sm2891492wru.50.2019.12.18.07.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 07:46:47 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/10] drm/meson: venc: add support for YUV420 setup
Date:   Wed, 18 Dec 2019 16:46:35 +0100
Message-Id: <20191218154637.17509-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191218154637.17509-1-narmstrong@baylibre.com>
References: <20191218154637.17509-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds encoding support for the YUV420 output from the
Amlogic Meson SoCs Video Processing Unit to the HDMI Controller.

The YUV420 is obtained by generating a YUV444 pixel stream like
the classic HDMI display modes, but then the Video Encoder output
can be configured to down-sample the YUV444 pixel stream to a YUV420
stream.

In addition if pixel stream down-sampling, the Y Cb Cr components must
also be mapped differently to align with the HDMI2.0 specifications.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 3 ++-
 drivers/gpu/drm/meson/meson_venc.c    | 8 +++++---
 drivers/gpu/drm/meson/meson_venc.h    | 2 ++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 69926d5d8756..75c133a048d3 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -772,7 +772,8 @@ static void meson_venc_hdmi_encoder_mode_set(struct drm_bridge *bridge,
 	DRM_DEBUG_DRIVER("\"%s\" vic %d\n", mode->name, vic);
 
 	/* VENC + VENC-DVI Mode setup */
-	meson_venc_hdmi_mode_set(priv, vic, mode);
+	meson_venc_hdmi_mode_set(priv, vic, ycrcb_map, false,
+				 VPU_HDMI_OUTPUT_CBYCR);
 
 	/* VCLK Set clock */
 	dw_hdmi_set_vclk(dw_hdmi, mode);
diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index a9ab78970bfe..f93c725b6f02 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -946,6 +946,8 @@ bool meson_venc_hdmi_venc_repeat(int vic)
 EXPORT_SYMBOL_GPL(meson_venc_hdmi_venc_repeat);
 
 void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
+			      unsigned int ycrcb_map,
+			      bool yuv420_mode,
 			      const struct drm_display_mode *mode)
 {
 	union meson_hdmi_venc_mode *vmode = NULL;
@@ -1528,14 +1530,14 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		reg |= VPU_HDMI_INV_VSYNC;
 
-	/* Output data format: CbYCr */
-	reg |= VPU_HDMI_OUTPUT_CBYCR;
+	/* Output data format */
+	reg |= ycrcb_map;
 
 	/*
 	 * Write rate to the async FIFO between VENC and HDMI.
 	 * One write every 2 wr_clk.
 	 */
-	if (venc_repeat)
+	if (venc_repeat || yuv420_mode)
 		reg |= VPU_HDMI_WR_RATE(2);
 
 	/*
diff --git a/drivers/gpu/drm/meson/meson_venc.h b/drivers/gpu/drm/meson/meson_venc.h
index 1abdcbdf51c0..9138255ffc9e 100644
--- a/drivers/gpu/drm/meson/meson_venc.h
+++ b/drivers/gpu/drm/meson/meson_venc.h
@@ -60,6 +60,8 @@ extern struct meson_cvbs_enci_mode meson_cvbs_enci_ntsc;
 void meson_venci_cvbs_mode_set(struct meson_drm *priv,
 			       struct meson_cvbs_enci_mode *mode);
 void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
+			      unsigned int ycrcb_map,
+			      bool yuv420_mode,
 			      const struct drm_display_mode *mode);
 unsigned int meson_venci_get_field(struct meson_drm *priv);
 
-- 
2.22.0

