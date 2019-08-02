Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2A87FC85
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 16:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404349AbfHBOsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 10:48:02 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1740 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731919AbfHBOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:48:02 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72EaJNq005392;
        Fri, 2 Aug 2019 16:47:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=N8rgZWIZfOw81q7QuM18Tttp0ZdrCfm1/QUNIZC/5bM=;
 b=KqUvXDckPZyMTnjcTF4guAysii2fBpfThquE/WOr+K6iec9ZCasTAjCaVoHBc694o/nA
 IocwSQWQ9NiMwq5QF2oY40wO4jJZ7mbzbLYAWz/44U3O1kyYXaYCRfMWN/+Gnmyhqq3h
 koYoCPpSZSAcBPN1XfGoiyVTdRSW3RczZnlNDgfimraWV9IbHNMpWHyQ32ETRf7TjLOz
 Nv011AIcA7qb3HtK6DQ5Dni+YbVRPbP93ZxJsI+XBR/bhohdv0MpgMB5hQVAIKNWFGDT
 Icw0ZbXBFx2Vh4HxzOnXGWvBS9k1cMl8n4lpWWsZLtx0nZq2v20lut9fEJfjyGBPoTE+ 6A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u3vd07vqr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 02 Aug 2019 16:47:50 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EA83231;
        Fri,  2 Aug 2019 14:47:49 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D68092C54E2;
        Fri,  2 Aug 2019 16:47:49 +0200 (CEST)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 2 Aug 2019
 16:47:49 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 2 Aug 2019 16:47:49
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH] drm/stm: ltdc: add pinctrl for DPI encoder mode
Date:   Fri, 2 Aug 2019 16:47:42 +0200
Message-ID: <1564757262-6166-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation of functions encoder_enable and encoder_disable
make possible to control the pinctrl according to the encoder type.
The pinctrl must be activated only if the encoder type is DPI.
This helps to move the DPI-related pinctrl configuration from
all the panel or bridge to the LTDC dt node.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 3ab4fbf..1c4fde0 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_graph.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -1040,6 +1041,36 @@ static const struct drm_encoder_funcs ltdc_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
 
+static void ltdc_encoder_disable(struct drm_encoder *encoder)
+{
+	struct drm_device *ddev = encoder->dev;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	/* Set to sleep state the pinctrl whatever type of encoder */
+	pinctrl_pm_select_sleep_state(ddev->dev);
+}
+
+static void ltdc_encoder_enable(struct drm_encoder *encoder)
+{
+	struct drm_device *ddev = encoder->dev;
+
+	DRM_DEBUG_DRIVER("\n");
+
+	/*
+	 * Set to default state the pinctrl only with DPI type.
+	 * Others types like DSI, don't need pinctrl due to
+	 * internal bridge (the signals do not come out of the chipset).
+	 */
+	if (encoder->encoder_type == DRM_MODE_ENCODER_DPI)
+		pinctrl_pm_select_default_state(ddev->dev);
+}
+
+static const struct drm_encoder_helper_funcs ltdc_encoder_helper_funcs = {
+	.disable = ltdc_encoder_disable,
+	.enable = ltdc_encoder_enable,
+};
+
 static int ltdc_encoder_init(struct drm_device *ddev, struct drm_bridge *bridge)
 {
 	struct drm_encoder *encoder;
@@ -1055,6 +1086,8 @@ static int ltdc_encoder_init(struct drm_device *ddev, struct drm_bridge *bridge)
 	drm_encoder_init(ddev, encoder, &ltdc_encoder_funcs,
 			 DRM_MODE_ENCODER_DPI, NULL);
 
+	drm_encoder_helper_add(encoder, &ltdc_encoder_helper_funcs);
+
 	ret = drm_bridge_attach(encoder, bridge, NULL);
 	if (ret) {
 		drm_encoder_cleanup(encoder);
@@ -1280,6 +1313,8 @@ int ltdc_load(struct drm_device *ddev)
 
 	clk_disable_unprepare(ldev->pixel_clk);
 
+	pinctrl_pm_select_sleep_state(ddev->dev);
+
 	pm_runtime_enable(ddev->dev);
 
 	return 0;
-- 
2.7.4

