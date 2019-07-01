Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B33FE1C631
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 11:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfENJg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 05:36:29 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:32933 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726201AbfENJgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:36:24 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4E9WgDo021984;
        Tue, 14 May 2019 11:36:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version : content-type
 : content-transfer-encoding; s=STMicroelectronics;
 bh=p4KJTrB20tDL7D759q2SgCgcwhHiCq4+y8XxWZe2CVk=;
 b=JH+JrhXM2KRQ1Gy7PMP6OgN9+bDXQhVScvsY8CtqFQa4/pReFbAbIWv59MpEbL1bFscA
 twt3rcTyGOI7g3hDTXH4N3KBxRn53lJUbQo5xABuJeMtc1f7dmwmLNLtlnhZFnf6fIJe
 FlRsxXMnCp48TSUo/s5ERsH9on8TaElDjpIRhqC+kwV0hLyMEbiwnLENKwKnw+nHBPVd
 aL7G6+FQpBcbeEBUq6MkchoSuGbcwRpRdG6GuVgD9nQRKJzzjAcVjPdE2Ieil5zav3OI
 WMbR3kH13Caaxz0dgmwYsnz08XkGtNS6MvX0WnNc0shFmcCt66Sl2tvNvbrkdHXEiUc4 rQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sdm5u01m8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 14 May 2019 11:36:13 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BE70D34;
        Tue, 14 May 2019 09:36:12 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9D4F6179A;
        Tue, 14 May 2019 09:36:12 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 14 May
 2019 11:36:12 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 14 May 2019 11:36:11
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/2] drm/stm: dsi: add regulator support
Date:   Tue, 14 May 2019 11:35:56 +0200
Message-ID: <1557826556-10079-3-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557826556-10079-1-git-send-email-yannick.fertre@st.com>
References: <1557826556-10079-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of regulator for the phy part of the DSI
controller.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
Acked-by: Philippe Cornu <philippe.cornu@st.com>
---
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 60 ++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
index 1bef73e..d8e4a14 100644
--- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
+++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
 #include <drm/drmP.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/bridge/dw_mipi_dsi.h>
@@ -76,6 +77,7 @@ struct dw_mipi_dsi_stm {
 	u32 hw_version;
 	int lane_min_kbps;
 	int lane_max_kbps;
+	struct regulator *vdd_supply;
 };
 
 static inline void dsi_write(struct dw_mipi_dsi_stm *dsi, u32 reg, u32 val)
@@ -314,21 +316,36 @@ static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dsi->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(dsi->base)) {
-		DRM_ERROR("Unable to get dsi registers\n");
-		return PTR_ERR(dsi->base);
+		ret = PTR_ERR(dsi->base);
+		DRM_ERROR("Unable to get dsi registers %d\n", ret);
+		return ret;
+	}
+
+	dsi->vdd_supply = devm_regulator_get(dev, "phy-dsi");
+	if (IS_ERR(dsi->vdd_supply)) {
+		ret = PTR_ERR(dsi->vdd_supply);
+		if (ret != -EPROBE_DEFER)
+			DRM_ERROR("Failed to request regulator: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_enable(dsi->vdd_supply);
+	if (ret) {
+		DRM_ERROR("Failed to enable regulator: %d\n", ret);
+		return ret;
 	}
 
 	dsi->pllref_clk = devm_clk_get(dev, "ref");
 	if (IS_ERR(dsi->pllref_clk)) {
 		ret = PTR_ERR(dsi->pllref_clk);
-		dev_err(dev, "Unable to get pll reference clock: %d\n", ret);
-		return ret;
+		DRM_ERROR("Unable to get pll reference clock: %d\n", ret);
+		goto err_clk_get;
 	}
 
 	ret = clk_prepare_enable(dsi->pllref_clk);
 	if (ret) {
-		dev_err(dev, "%s: Failed to enable pllref_clk\n", __func__);
-		return ret;
+		DRM_ERROR("Failed to enable pllref_clk: %d\n", ret);
+		goto err_clk_get;
 	}
 
 	dw_mipi_dsi_stm_plat_data.base = dsi->base;
@@ -338,20 +355,28 @@ static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
 
 	dsi->dsi = dw_mipi_dsi_probe(pdev, &dw_mipi_dsi_stm_plat_data);
 	if (IS_ERR(dsi->dsi)) {
-		DRM_ERROR("Failed to initialize mipi dsi host\n");
-		clk_disable_unprepare(dsi->pllref_clk);
-		return PTR_ERR(dsi->dsi);
+		ret = PTR_ERR(dsi->dsi);
+		DRM_ERROR("Failed to initialize mipi dsi host: %d\n", ret);
+		goto err_dsi_probe;
 	}
 
 	return 0;
+
+err_dsi_probe:
+	clk_disable_unprepare(dsi->pllref_clk);
+err_clk_get:
+	regulator_disable(dsi->vdd_supply);
+
+	return ret;
 }
 
 static int dw_mipi_dsi_stm_remove(struct platform_device *pdev)
 {
 	struct dw_mipi_dsi_stm *dsi = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(dsi->pllref_clk);
 	dw_mipi_dsi_remove(dsi->dsi);
+	clk_disable_unprepare(dsi->pllref_clk);
+	regulator_disable(dsi->vdd_supply);
 
 	return 0;
 }
@@ -363,6 +388,7 @@ static int __maybe_unused dw_mipi_dsi_stm_suspend(struct device *dev)
 	DRM_DEBUG_DRIVER("\n");
 
 	clk_disable_unprepare(dsi->pllref_clk);
+	regulator_disable(dsi->vdd_supply);
 
 	return 0;
 }
@@ -370,10 +396,22 @@ static int __maybe_unused dw_mipi_dsi_stm_suspend(struct device *dev)
 static int __maybe_unused dw_mipi_dsi_stm_resume(struct device *dev)
 {
 	struct dw_mipi_dsi_stm *dsi = dw_mipi_dsi_stm_plat_data.priv_data;
+	int ret;
 
 	DRM_DEBUG_DRIVER("\n");
 
-	clk_prepare_enable(dsi->pllref_clk);
+	ret = regulator_enable(dsi->vdd_supply);
+	if (ret) {
+		DRM_ERROR("Failed to enable regulator: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(dsi->pllref_clk);
+	if (ret) {
+		regulator_disable(dsi->vdd_supply);
+		DRM_ERROR("Failed to enable pllref_clk: %d\n", ret);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.7.4

