Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1066C976E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 12:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfHUKQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 06:16:27 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44760 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbfHUKQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:16:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 481221A00CC;
        Wed, 21 Aug 2019 12:16:21 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B53E1A0045;
        Wed, 21 Aug 2019 12:16:21 +0200 (CEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8C2D7205D3;
        Wed, 21 Aug 2019 12:16:20 +0200 (CEST)
From:   Robert Chiras <robert.chiras@nxp.com>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/15] drm/mxsfb: Fix the vblank events
Date:   Wed, 21 Aug 2019 13:15:47 +0300
Message-Id: <1566382555-12102-8-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
References: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the vblank support is not correctly implemented in MXSFB_DRM
driver. The call to drm_vblank_init is made with mode_config.num_crtc
which at that time is 0. Because of this, vblank is not activated, so
there won't be any vblank event submitted.
For example, when running modetest with the '-v' parameter will result
in an astronomical refresh rate (10000+ Hz), because of that.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 2743975..78a2382 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -38,6 +38,9 @@
 #include "mxsfb_drv.h"
 #include "mxsfb_regs.h"
 
+/* The eLCDIF max possible CRTCs */
+#define MAX_CRTCS 1
+
 enum mxsfb_devtype {
 	MXSFB_V3,
 	MXSFB_V4,
@@ -138,6 +141,8 @@ static void mxsfb_pipe_enable(struct drm_simple_display_pipe *pipe,
 		mxsfb->connector = &mxsfb->panel_connector;
 	}
 
+	drm_crtc_vblank_on(&pipe->crtc);
+
 	pm_runtime_get_sync(drm->dev);
 	drm_panel_prepare(mxsfb->panel);
 	mxsfb_crtc_enable(mxsfb);
@@ -164,6 +169,8 @@ static void mxsfb_pipe_disable(struct drm_simple_display_pipe *pipe)
 	}
 	spin_unlock_irq(&drm->event_lock);
 
+	drm_crtc_vblank_off(&pipe->crtc);
+
 	if (mxsfb->connector != &mxsfb->panel_connector)
 		mxsfb->connector = NULL;
 }
@@ -246,7 +253,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
 
 	pm_runtime_enable(drm->dev);
 
-	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
+	ret = drm_vblank_init(drm, MAX_CRTCS);
 	if (ret < 0) {
 		dev_err(drm->dev, "Failed to initialise vblank\n");
 		goto err_vblank;
-- 
2.7.4

