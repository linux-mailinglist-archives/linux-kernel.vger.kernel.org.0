Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1F5A1892
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 13:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfH2La4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 07:30:56 -0400
Received: from inva021.nxp.com ([92.121.34.21]:49330 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbfH2La3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:30:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 29CAC20033E;
        Thu, 29 Aug 2019 13:30:27 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D38D200335;
        Thu, 29 Aug 2019 13:30:27 +0200 (CEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 43D0120613;
        Thu, 29 Aug 2019 13:30:26 +0200 (CEST)
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
Subject: [PATCH v4 11/14] drm/mxsfb: Improve the axi clock usage
Date:   Thu, 29 Aug 2019 14:30:12 +0300
Message-Id: <1567078215-31601-12-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567078215-31601-1-git-send-email-robert.chiras@nxp.com>
References: <1567078215-31601-1-git-send-email-robert.chiras@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the enable of the axi clock return status is ignored, causing
issues when the enable fails then we try to disable it. Therefore, it is
better to check the return status and disable it only when enable
succeeded.
Also, remove the helper functions around clk_axi, since we can directly
use the clk API function for enable/disable the clock. Those functions
are already checking for NULL clk and returning 0 if that's the case.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
Acked-by: Leonard Crestez <leonard.crestez@nxp.com>
Tested-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c |  8 ++++----
 drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 32 +++++++++++++-------------------
 drivers/gpu/drm/mxsfb/mxsfb_drv.h  |  3 ---
 3 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index a4ba368..e727f5e 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -408,7 +408,7 @@ void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
 {
 	dma_addr_t paddr;
 
-	mxsfb_enable_axi_clk(mxsfb);
+	clk_prepare_enable(mxsfb->clk_axi);
 	writel(0, mxsfb->base + LCDC_CTRL);
 	mxsfb_crtc_mode_set_nofb(mxsfb);
 
@@ -425,7 +425,7 @@ void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
 void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb)
 {
 	mxsfb_disable_controller(mxsfb);
-	mxsfb_disable_axi_clk(mxsfb);
+	clk_disable_unprepare(mxsfb->clk_axi);
 }
 
 void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
@@ -451,8 +451,8 @@ void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
 
 	paddr = mxsfb_get_fb_paddr(mxsfb);
 	if (paddr) {
-		mxsfb_enable_axi_clk(mxsfb);
+		clk_prepare_enable(mxsfb->clk_axi);
 		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
-		mxsfb_disable_axi_clk(mxsfb);
+		clk_disable_unprepare(mxsfb->clk_axi);
 	}
 }
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index d8686c7..888b520 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -94,18 +94,6 @@ drm_pipe_to_mxsfb_drm_private(struct drm_simple_display_pipe *pipe)
 	return container_of(pipe, struct mxsfb_drm_private, pipe);
 }
 
-void mxsfb_enable_axi_clk(struct mxsfb_drm_private *mxsfb)
-{
-	if (mxsfb->clk_axi)
-		clk_prepare_enable(mxsfb->clk_axi);
-}
-
-void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsfb)
-{
-	if (mxsfb->clk_axi)
-		clk_disable_unprepare(mxsfb->clk_axi);
-}
-
 /**
  * mxsfb_atomic_helper_check - validate state object
  * @dev: DRM device
@@ -265,25 +253,31 @@ static void mxsfb_pipe_update(struct drm_simple_display_pipe *pipe,
 static int mxsfb_pipe_enable_vblank(struct drm_simple_display_pipe *pipe)
 {
 	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
+	int ret = 0;
+
+	ret = clk_prepare_enable(mxsfb->clk_axi);
+	if (ret)
+		return ret;
 
 	/* Clear and enable VBLANK IRQ */
-	mxsfb_enable_axi_clk(mxsfb);
 	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
 	writel(CTRL1_CUR_FRAME_DONE_IRQ_EN, mxsfb->base + LCDC_CTRL1 + REG_SET);
-	mxsfb_disable_axi_clk(mxsfb);
+	clk_disable_unprepare(mxsfb->clk_axi);
 
-	return 0;
+	return ret;
 }
 
 static void mxsfb_pipe_disable_vblank(struct drm_simple_display_pipe *pipe)
 {
 	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
 
+	if (clk_prepare_enable(mxsfb->clk_axi))
+		return;
+
 	/* Disable and clear VBLANK IRQ */
-	mxsfb_enable_axi_clk(mxsfb);
 	writel(CTRL1_CUR_FRAME_DONE_IRQ_EN, mxsfb->base + LCDC_CTRL1 + REG_CLR);
 	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
-	mxsfb_disable_axi_clk(mxsfb);
+	clk_disable_unprepare(mxsfb->clk_axi);
 }
 
 static struct drm_simple_display_pipe_funcs mxsfb_funcs = {
@@ -444,7 +438,7 @@ static irqreturn_t mxsfb_irq_handler(int irq, void *data)
 	struct mxsfb_drm_private *mxsfb = drm->dev_private;
 	u32 reg;
 
-	mxsfb_enable_axi_clk(mxsfb);
+	clk_prepare_enable(mxsfb->clk_axi);
 
 	reg = readl(mxsfb->base + LCDC_CTRL1);
 
@@ -453,7 +447,7 @@ static irqreturn_t mxsfb_irq_handler(int irq, void *data)
 
 	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
 
-	mxsfb_disable_axi_clk(mxsfb);
+	clk_disable_unprepare(mxsfb->clk_axi);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
index a178173..54c0644 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
@@ -39,9 +39,6 @@ struct mxsfb_drm_private {
 int mxsfb_setup_crtc(struct drm_device *dev);
 int mxsfb_create_output(struct drm_device *dev);
 
-void mxsfb_enable_axi_clk(struct mxsfb_drm_private *mxsfb);
-void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsfb);
-
 void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb);
 void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb);
 void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
-- 
2.7.4

