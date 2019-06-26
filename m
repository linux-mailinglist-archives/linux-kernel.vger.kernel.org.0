Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010FF56A88
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 15:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfFZNcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 09:32:41 -0400
Received: from inva021.nxp.com ([92.121.34.21]:57602 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727776AbfFZNcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:32:31 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DEFAA2009A8;
        Wed, 26 Jun 2019 15:32:28 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D1C802009B2;
        Wed, 26 Jun 2019 15:32:28 +0200 (CEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 24DA1205DB;
        Wed, 26 Jun 2019 15:32:28 +0200 (CEST)
From:   Robert Chiras <robert.chiras@nxp.com>
To:     Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>
Subject: [PATCH 09/10] drm/mxsfb: Clear OUTSTANDING_REQS bits
Date:   Wed, 26 Jun 2019 16:32:17 +0300
Message-Id: <1561555938-21595-10-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561555938-21595-1-git-send-email-robert.chiras@nxp.com>
References: <1561555938-21595-1-git-send-email-robert.chiras@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bit 21 can alter the CTRL2_OUTSTANDING_REQS value right after the eLCDIF
is enabled, since it comes up with default value of 1 (this behaviour
has been seen on some imx8 platforms).
In order to fix this, clear CTRL2_OUTSTANDING_REQS bits before setting
its value.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index 45ca16b..02a5684 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -223,7 +223,14 @@ static void mxsfb_enable_controller(struct mxsfb_drm_private *mxsfb)
 	clk_prepare_enable(mxsfb->clk);
 
 	if (mxsfb->devdata->ipversion >= 4) {
-		writel(CTRL2_OUTSTANDING_REQS__REQ_16,
+		/*
+		 * On some platforms, bit 21 is defaulted to 1, which may alter
+		 * the below setting. So, to make sure we have the right setting
+		 * clear all the bits for CTRL2_OUTSTANDING_REQS.
+		 */
+		writel(CTRL2_OUTSTANDING_REQS(0x7),
+		       mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
+		writel(CTRL2_OUTSTANDING_REQS(REQ_16),
 		       mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
 		/* Assert LCD Reset bit */
 		writel(CTRL2_LCD_RESET, mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
-- 
2.7.4

