Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 704AF123BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 01:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfLRAsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 19:48:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35573 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfLRAsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:48:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id b19so214122pfo.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XARKC/uPp/ouydj556D+ZuPhgq9GwUfWK98imXTIJa0=;
        b=kYY7KWhyo2D+wj56yefzQRztkHxqeFQVk/K5+y8EqniVRCmdRx45Y1W449q8cnDYlY
         J3grbu1fAGQGqj9OuOFJJBl7PgCnEUXpi4/4MK+X2ik4z4opB8OFPU9iIQtWzFGCWFZS
         zeajAn0eWyi9E2ZiBnzKaIb/RpzW4Xv3aYI/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XARKC/uPp/ouydj556D+ZuPhgq9GwUfWK98imXTIJa0=;
        b=qrJm5GHCvybqb42CYlNkmhr/L4SSfVHBkust4IFsMHoZoJJ6X1MbvAuztoyM2GIg30
         8KCilBaFKlfp+X5Pa0g0ViMcxbfDxUY816f88lq1MqDkh5gGvPCTz5t2zzV2cBKSgurn
         chXBaadjokKNB2oDRIEW4f0S/lm4qRaFQH0RqjI8Blzd1y/+hhznMfMsVGIJ9lNpup9F
         +yhfZJfNe5FT3gAqTaxMGq9ebF+pfzivFVeOvGXfxHwGyjtT765am6wQ6ZsyPOLn3moZ
         lx1ABf5Ms86jsjopLfJ2DcJ83amBpnWynqONaSZS3oyti/jKbJwsYVIQJSZ18wDIoi7v
         UTWg==
X-Gm-Message-State: APjAAAV8CIZSTtvU2dmOji4OjpFde0N/4+pJf3JUkBbTkF7WxGI8rQVB
        bwtGB/g8zz0xFHTC4EZe+ozvVw==
X-Google-Smtp-Source: APXvYqzBmFbVOM4Ilepr0HQ4P8FG8rttDdCUjwjKUuBlKjBMLo2CvigmW3kWatsSXxYjYZ/2GSJDhw==
X-Received: by 2002:a63:780d:: with SMTP id t13mr850260pgc.82.1576630114511;
        Tue, 17 Dec 2019 16:48:34 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id v72sm139885pjb.25.2019.12.17.16.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 16:48:34 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, seanpaul@chromium.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 7/9] drm/bridge: ti-sn65dsi86: Group DP link training bits in a function
Date:   Tue, 17 Dec 2019 16:47:39 -0800
Message-Id: <20191217164702.v2.7.I1fc75ad11db9048ef08cfe1ab7322753d9a219c7@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191218004741.102067-1-dianders@chromium.org>
References: <20191218004741.102067-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll re-organize the ti_sn_bridge_enable() function a bit to group
together all the parts relating to link training and split them into a
sub-function.  This is not intended to have any functional change and
is in preparation for trying link training several times at different
rates.  One small side effect here is that if link training fails
we'll now leave the DP PLL disabled, but that seems like a sane thing
to do.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Rob Clark <robdclark@gmail.com>
Reviewed-by: Rob Clark <robdclark@gmail.com>
---

Changes in v2: None

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 86 ++++++++++++++++-----------
 1 file changed, 52 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index d5990a0947b9..48fb4dc72e1c 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -530,6 +530,46 @@ static unsigned int ti_sn_get_max_lanes(struct ti_sn_bridge *pdata)
 	return data & DP_LANE_COUNT_MASK;
 }
 
+static int ti_sn_link_training(struct ti_sn_bridge *pdata)
+{
+	unsigned int val;
+	int ret;
+
+	/* set dp clk frequency value */
+	ti_sn_bridge_set_dp_rate(pdata);
+
+	/* enable DP PLL */
+	regmap_write(pdata->regmap, SN_PLL_ENABLE_REG, 1);
+
+	ret = regmap_read_poll_timeout(pdata->regmap, SN_DPPLL_SRC_REG, val,
+				       val & DPPLL_SRC_DP_PLL_LOCK, 1000,
+				       50 * 1000);
+	if (ret) {
+		DRM_ERROR("DP_PLL_LOCK polling failed (%d)\n", ret);
+		goto exit;
+	}
+
+	/* Semi auto link training mode */
+	regmap_write(pdata->regmap, SN_ML_TX_MODE_REG, 0x0A);
+	ret = regmap_read_poll_timeout(pdata->regmap, SN_ML_TX_MODE_REG, val,
+				       val == ML_TX_MAIN_LINK_OFF ||
+				       val == ML_TX_NORMAL_MODE, 1000,
+				       500 * 1000);
+	if (ret) {
+		DRM_ERROR("Training complete polling failed (%d)\n", ret);
+	} else if (val == ML_TX_MAIN_LINK_OFF) {
+		DRM_ERROR("Link training failed, link is off\n");
+		ret = -EIO;
+	}
+
+exit:
+	/* Disable the PLL if we failed */
+	if (ret)
+		regmap_write(pdata->regmap, SN_PLL_ENABLE_REG, 0);
+
+	return ret;
+}
+
 static void ti_sn_bridge_enable(struct drm_bridge *bridge)
 {
 	struct ti_sn_bridge *pdata = bridge_to_ti_sn_bridge(bridge);
@@ -555,29 +595,8 @@ static void ti_sn_bridge_enable(struct drm_bridge *bridge)
 	regmap_update_bits(pdata->regmap, SN_DSI_LANES_REG,
 			   CHA_DSI_LANES_MASK, val);
 
-	/* Set the DP output format (18 bpp or 24 bpp) */
-	val = (ti_sn_bridge_get_bpp(pdata) == 18) ? BPP_18_RGB : 0;
-	regmap_update_bits(pdata->regmap, SN_DATA_FORMAT_REG, BPP_18_RGB, val);
-
-	/* DP lane config */
-	val = DP_NUM_LANES(min(pdata->dp_lanes, 3));
-	regmap_update_bits(pdata->regmap, SN_SSC_CONFIG_REG, DP_NUM_LANES_MASK,
-			   val);
-
-	/* set dsi/dp clk frequency value */
+	/* set dsi clk frequency value */
 	ti_sn_bridge_set_dsi_rate(pdata);
-	ti_sn_bridge_set_dp_rate(pdata);
-
-	/* enable DP PLL */
-	regmap_write(pdata->regmap, SN_PLL_ENABLE_REG, 1);
-
-	ret = regmap_read_poll_timeout(pdata->regmap, SN_DPPLL_SRC_REG, val,
-				       val & DPPLL_SRC_DP_PLL_LOCK, 1000,
-				       50 * 1000);
-	if (ret) {
-		DRM_ERROR("DP_PLL_LOCK polling failed (%d)\n", ret);
-		return;
-	}
 
 	/**
 	 * The SN65DSI86 only supports ASSR Display Authentication method and
@@ -588,19 +607,18 @@ static void ti_sn_bridge_enable(struct drm_bridge *bridge)
 	drm_dp_dpcd_writeb(&pdata->aux, DP_EDP_CONFIGURATION_SET,
 			   DP_ALTERNATE_SCRAMBLER_RESET_ENABLE);
 
-	/* Semi auto link training mode */
-	regmap_write(pdata->regmap, SN_ML_TX_MODE_REG, 0x0A);
-	ret = regmap_read_poll_timeout(pdata->regmap, SN_ML_TX_MODE_REG, val,
-				       val == ML_TX_MAIN_LINK_OFF ||
-				       val == ML_TX_NORMAL_MODE, 1000,
-				       500 * 1000);
-	if (ret) {
-		DRM_ERROR("Training complete polling failed (%d)\n", ret);
-		return;
-	} else if (val == ML_TX_MAIN_LINK_OFF) {
-		DRM_ERROR("Link training failed, link is off\n");
+	/* Set the DP output format (18 bpp or 24 bpp) */
+	val = (ti_sn_bridge_get_bpp(pdata) == 18) ? BPP_18_RGB : 0;
+	regmap_update_bits(pdata->regmap, SN_DATA_FORMAT_REG, BPP_18_RGB, val);
+
+	/* DP lane config */
+	val = DP_NUM_LANES(min(pdata->dp_lanes, 3));
+	regmap_update_bits(pdata->regmap, SN_SSC_CONFIG_REG, DP_NUM_LANES_MASK,
+			   val);
+
+	ret = ti_sn_link_training(pdata);
+	if (ret)
 		return;
-	}
 
 	/* config video parameters */
 	ti_sn_bridge_set_video_timings(pdata);
-- 
2.24.1.735.g03f4e72817-goog

