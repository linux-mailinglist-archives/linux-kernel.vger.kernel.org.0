Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54E0412A26A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 15:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfLXOjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 09:39:23 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44367 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfLXOjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 09:39:22 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id F31BDE000C;
        Tue, 24 Dec 2019 14:39:18 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        <linux-rockchip@lists.infradead.org>
Cc:     <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 05/11] drm/rockchip: lvds: Change platform data
Date:   Tue, 24 Dec 2019 15:38:54 +0100
Message-Id: <20191224143900.23567-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224143900.23567-1-miquel.raynal@bootlin.com>
References: <20191224143900.23567-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare the introduction of PX30 support by using
drm_encoder_helper_funcs as platform data instead of multiple register
names which are specific to rk3288 and not generic to all Rockchip
IPs. This way adding support for a new flavor of a similar IP will be
a matter of adding the relevant helper funcs.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 32 ++++++++----------------
 drivers/gpu/drm/rockchip/rockchip_lvds.h |  3 +++
 2 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 3c08e50923ae..271e126476e1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -38,16 +38,10 @@
 
 /**
  * rockchip_lvds_soc_data - rockchip lvds Soc private data
- * @ch1_offset: lvds channel 1 registe offset
- * grf_soc_con6: general registe offset for LVDS contrl
- * grf_soc_con7: general registe offset for LVDS contrl
- * has_vop_sel: to indicate whether need to choose from different VOP.
+ * @helper_funcs: LVDS connector helper functions
  */
 struct rockchip_lvds_soc_data {
-	u32 ch1_offset;
-	int grf_soc_con6;
-	int grf_soc_con7;
-	bool has_vop_sel;
+	const struct drm_encoder_helper_funcs *helper_funcs;
 };
 
 struct rockchip_lvds {
@@ -72,7 +66,7 @@ static inline void rk3288_writel(struct rockchip_lvds *lvds, u32 offset,
 	writel_relaxed(val, lvds->regs + offset);
 	if (lvds->output == DISPLAY_OUTPUT_LVDS)
 		return;
-	writel_relaxed(val, lvds->regs + offset + lvds->soc_data->ch1_offset);
+	writel_relaxed(val, lvds->regs + offset + RK3288_LVDS_CH1_OFFSET);
 }
 
 static inline int rockchip_lvds_name_to_format(const char *s)
@@ -187,7 +181,7 @@ static void rk3288_lvds_poweroff(struct rockchip_lvds *lvds)
 		      RK3288_LVDS_CFG_REGC_PLL_ENABLE);
 	val = LVDS_DUAL | LVDS_TTL_EN | LVDS_CH0_EN | LVDS_CH1_EN | LVDS_PWRDN;
 	val |= val << 16;
-	ret = regmap_write(lvds->grf, lvds->soc_data->grf_soc_con7, val);
+	ret = regmap_write(lvds->grf, RK3288_LVDS_GRF_SOC_CON7, val);
 	if (ret != 0)
 		DRM_DEV_ERROR(lvds->dev, "Could not write to GRF: %d\n", ret);
 
@@ -241,7 +235,7 @@ static void rk3288_lvds_grf_config(struct drm_encoder *encoder,
 
 	val |= (pin_dclk << 8) | (pin_hsync << 9);
 	val |= (0xffff << 16);
-	ret = regmap_write(lvds->grf, lvds->soc_data->grf_soc_con7, val);
+	ret = regmap_write(lvds->grf, RK3288_LVDS_GRF_SOC_CON7, val);
 	if (ret != 0) {
 		DRM_DEV_ERROR(lvds->dev, "Could not write to GRF: %d\n", ret);
 		return;
@@ -254,9 +248,6 @@ static int rk3288_lvds_set_vop_source(struct rockchip_lvds *lvds,
 	u32 val;
 	int ret;
 
-	if (!lvds->soc_data->has_vop_sel)
-		return 0;
-
 	ret = drm_of_encoder_active_endpoint_id(lvds->dev->of_node, encoder);
 	if (ret < 0)
 		return ret;
@@ -265,7 +256,7 @@ static int rk3288_lvds_set_vop_source(struct rockchip_lvds *lvds,
 	if (ret)
 		val |= RK3288_LVDS_SOC_CON6_SEL_VOP_LIT;
 
-	ret = regmap_write(lvds->grf, lvds->soc_data->grf_soc_con6, val);
+	ret = regmap_write(lvds->grf, RK3288_LVDS_GRF_SOC_CON6, val);
 	if (ret < 0)
 		return ret;
 
@@ -323,10 +314,7 @@ static const struct drm_encoder_funcs rockchip_lvds_encoder_funcs = {
 };
 
 static const struct rockchip_lvds_soc_data rk3288_lvds_data = {
-	.ch1_offset = 0x100,
-	.grf_soc_con6 = 0x025c,
-	.grf_soc_con7 = 0x0260,
-	.has_vop_sel = true,
+	.helper_funcs = &rk3288_lvds_encoder_helper_funcs,
 };
 
 static const struct of_device_id rockchip_lvds_dt_ids[] = {
@@ -417,7 +405,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		goto err_put_remote;
 	}
 
-	drm_encoder_helper_add(encoder, &rk3288_lvds_encoder_helper_funcs);
+	drm_encoder_helper_add(encoder, lvds->soc_data->helper_funcs);
 
 	if (lvds->panel) {
 		connector = &lvds->connector;
@@ -478,8 +466,10 @@ static void rockchip_lvds_unbind(struct device *dev, struct device *master,
 				void *data)
 {
 	struct rockchip_lvds *lvds = dev_get_drvdata(dev);
+	const struct drm_encoder_helper_funcs *encoder_funcs;
 
-	rk3288_lvds_encoder_disable(&lvds->encoder);
+	encoder_funcs = lvds->soc_data->helper_funcs;
+	encoder_funcs->disable(&lvds->encoder);
 	if (lvds->panel)
 		drm_panel_detach(lvds->panel);
 	pm_runtime_disable(dev);
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.h b/drivers/gpu/drm/rockchip/rockchip_lvds.h
index 1387bcbc4bc0..e41e9ab3c306 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.h
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.h
@@ -72,6 +72,9 @@
 #define RK3288_LVDS_CFG_REG21_TX_DISABLE	0x00
 #define RK3288_LVDS_CH1_OFFSET			0x100
 
+#define RK3288_LVDS_GRF_SOC_CON6		0x025C
+#define RK3288_LVDS_GRF_SOC_CON7		0x0260
+
 /* fbdiv value is split over 2 registers, with bit8 in reg2 */
 #define RK3288_LVDS_PLL_FBDIV_REG2(_fbd) \
 		(_fbd & BIT(8) ? RK3288_LVDS_CH0_REG2_PLL_FBDIV8 : 0)
-- 
2.20.1

