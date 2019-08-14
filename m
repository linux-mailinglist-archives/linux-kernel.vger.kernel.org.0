Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE55A8D15D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 12:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfHNKtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 06:49:09 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55182 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbfHNKtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:49:06 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C80971A0395;
        Wed, 14 Aug 2019 12:49:04 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BB6A81A039B;
        Wed, 14 Aug 2019 12:49:04 +0200 (CEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C3F0C2060E;
        Wed, 14 Aug 2019 12:49:03 +0200 (CEST)
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
Subject: [PATCH v2 08/15] drm/mxsfb: Signal mode changed when bpp changed
Date:   Wed, 14 Aug 2019 13:48:44 +0300
Message-Id: <1565779731-1300-9-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565779731-1300-1-git-send-email-robert.chiras@nxp.com>
References: <1565779731-1300-1-git-send-email-robert.chiras@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mirela Rabulea <mirela.rabulea@nxp.com>

Add mxsfb_atomic_helper_check to signal mode changed when bpp changed.
This will trigger the execution of disable/enable on
a modeset with different bpp than the current one.

Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>
Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 45 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 829abec..59c8ba7 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -26,6 +26,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_irq.h>
@@ -108,9 +109,51 @@ void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsfb)
 		clk_disable_unprepare(mxsfb->clk_axi);
 }
 
+/**
+ * mxsfb_atomic_helper_check - validate state object
+ * @dev: DRM device
+ * @state: the driver state object
+ *
+ * On top of the drm imlementation drm_atomic_helper_check,
+ * check if the bpp is changed, if so, signal mode_changed,
+ * this will trigger disable/enable
+ *
+ * RETURNS:
+ * Zero for success or -errno
+ */
+static int mxsfb_atomic_helper_check(struct drm_device *dev,
+				     struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *new_state;
+	int i, ret;
+
+	ret = drm_atomic_helper_check(dev, state);
+	if (ret)
+		return ret;
+
+	for_each_new_crtc_in_state(state, crtc, new_state, i) {
+		struct drm_plane_state *primary_state;
+		int old_bpp = 0;
+		int new_bpp = 0;
+
+		if (!crtc->primary || !crtc->primary->old_fb)
+			continue;
+		primary_state =
+			drm_atomic_get_plane_state(state, crtc->primary);
+		if (!primary_state || !primary_state->fb)
+			continue;
+		old_bpp = crtc->primary->old_fb->format->depth;
+		new_bpp = primary_state->fb->format->depth;
+		if (old_bpp != new_bpp)
+			new_state->mode_changed = true;
+	}
+	return ret;
+}
+
 static const struct drm_mode_config_funcs mxsfb_mode_config_funcs = {
 	.fb_create		= drm_gem_fb_create,
-	.atomic_check		= drm_atomic_helper_check,
+	.atomic_check		= mxsfb_atomic_helper_check,
 	.atomic_commit		= drm_atomic_helper_commit,
 };
 
-- 
2.7.4

