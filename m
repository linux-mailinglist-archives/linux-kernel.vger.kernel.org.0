Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1442E118B52
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 15:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfLJOm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 09:42:27 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:50120 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfLJOm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1575988921; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYwtMOW9m704uzJQidOmDJN9rPdrQ5RvFlN8Zv2YE/o=;
        b=DlqUHBNH52HPZtFzdyGHOXj04HeTDWssvHMxTavbLSuBvWg8VEH+SdLkR4pLP3lVHQ5h+H
        B+D9Xxcoatom0Qcn9rU+xeft5yjMJZSZBB18N2RhumXZIK90tXwhUIShA4IobDYi0whl8Y
        KW21MehXsT2iMdJQdW3sgTsCz0VL2CY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 5/6] gpu/drm: ingenic: Check for display size in CRTC atomic check
Date:   Tue, 10 Dec 2019 15:41:41 +0100
Message-Id: <20191210144142.33143-5-paul@crapouillou.net>
In-Reply-To: <20191210144142.33143-1-paul@crapouillou.net>
References: <20191210144142.33143-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that the requested display size isn't above the limits supported
by the CRTC.

- JZ4750 and older support up to 800x600;
- JZ4755 supports up to 1024x576;
- JZ4760 and JZ4770 support up to 720p;
- JZ4780 supports up to 2k.

v2: No change

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index cef2f29a9d7a..da681214d0b6 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -152,6 +152,7 @@ struct ingenic_dma_hwdesc {
 
 struct jz_soc_info {
 	bool needs_dev_clk;
+	unsigned int max_width, max_height;
 };
 
 struct ingenic_drm {
@@ -163,6 +164,7 @@ struct ingenic_drm {
 	struct device *dev;
 	struct regmap *map;
 	struct clk *lcd_clk, *pix_clk;
+	const struct jz_soc_info *soc_info;
 
 	struct ingenic_dma_hwdesc *dma_hwdesc;
 	dma_addr_t dma_hwdesc_phys;
@@ -325,6 +327,10 @@ static int ingenic_drm_crtc_atomic_check(struct drm_crtc *crtc,
 	if (!drm_atomic_crtc_needs_modeset(state))
 		return 0;
 
+	if (state->mode.hdisplay > priv->soc_info->max_height ||
+	    state->mode.vdisplay > priv->soc_info->max_width)
+		return -EINVAL;
+
 	rate = clk_round_rate(priv->pix_clk,
 			      state->adjusted_mode.clock * 1000);
 	if (rate < 0)
@@ -620,6 +626,7 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->soc_info = soc_info;
 	priv->dev = dev;
 	drm = &priv->drm;
 	drm->dev_private = priv;
@@ -635,7 +642,7 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 	drm_mode_config_init(drm);
 	drm->mode_config.min_width = 0;
 	drm->mode_config.min_height = 0;
-	drm->mode_config.max_width = 800;
+	drm->mode_config.max_width = soc_info->max_width;
 	drm->mode_config.max_height = 4095;
 	drm->mode_config.funcs = &ingenic_drm_mode_config_funcs;
 
@@ -813,10 +820,14 @@ static int ingenic_drm_remove(struct platform_device *pdev)
 
 static const struct jz_soc_info jz4740_soc_info = {
 	.needs_dev_clk = true,
+	.max_width = 800,
+	.max_height = 600,
 };
 
 static const struct jz_soc_info jz4725b_soc_info = {
 	.needs_dev_clk = false,
+	.max_width = 800,
+	.max_height = 600,
 };
 
 static const struct of_device_id ingenic_drm_of_match[] = {
-- 
2.24.0

