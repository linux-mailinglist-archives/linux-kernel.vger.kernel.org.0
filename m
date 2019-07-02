Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B2A5D29C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 17:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfGBPUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 11:20:13 -0400
Received: from inva021.nxp.com ([92.121.34.21]:49362 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfGBPUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:20:12 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 247E2200C2C;
        Tue,  2 Jul 2019 17:20:09 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 18162200C27;
        Tue,  2 Jul 2019 17:20:09 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5EFBF205ED;
        Tue,  2 Jul 2019 17:20:08 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     shawnguo@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, aisheng.dong@nxp.com,
        weiyongjun1@huawei.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, shengjiu.wang@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] clk: imx8: Add DSP related clocks
Date:   Tue,  2 Jul 2019 18:20:07 +0300
Message-Id: <20190702152007.12190-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QXP contains Hifi4 DSP. There are four clocks
associated with DSP:
  * dsp_lpcg_core_clk
  * dsp_lpcg_ipg_clk
  * dsp_lpcg_adb_aclk
  * ocram_lpcg_ipg_clk

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp-lpcg.c     | 5 +++++
 include/dt-bindings/clock/imx8-clock.h | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
index fb6edf1b8aa2..c0aff7ca6374 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -72,6 +72,11 @@ static const struct imx8qxp_lpcg_data imx8qxp_lpcg_adma[] = {
 	{ IMX_ADMA_LPCG_I2C2_CLK, "i2c2_lpcg_clk", "i2c2_clk", 0, ADMA_LPI2C_2_LPCG, 0, 0, },
 	{ IMX_ADMA_LPCG_I2C3_IPG_CLK, "i2c3_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPI2C_3_LPCG, 16, 0, },
 	{ IMX_ADMA_LPCG_I2C3_CLK, "i2c3_lpcg_clk", "i2c3_clk", 0, ADMA_LPI2C_3_LPCG, 0, 0, },
+
+	{ IMX_ADMA_LPCG_DSP_CORE_CLK, "dsp_lpcg_core_clk", "dma_ipg_clk_root", 0, ADMA_HIFI_LPCG, 28, 0, },
+	{ IMX_ADMA_LPCG_DSP_IPG_CLK, "dsp_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_HIFI_LPCG, 20, 0, },
+	{ IMX_ADMA_LPCG_DSP_ADB_CLK, "dsp_lpcg_adb_clk", "dma_ipg_clk_root", 0, ADMA_HIFI_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_OCRAM_IPG_CLK, "ocram_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_OCRAM_LPCG, 16, 0, },
 };
 
 static const struct imx8qxp_ss_lpcg imx8qxp_ss_adma = {
diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/clock/imx8-clock.h
index 4236818e3be5..673a8c662340 100644
--- a/include/dt-bindings/clock/imx8-clock.h
+++ b/include/dt-bindings/clock/imx8-clock.h
@@ -283,7 +283,11 @@
 #define IMX_ADMA_LPCG_PWM_IPG_CLK			38
 #define IMX_ADMA_LPCG_LCD_PIX_CLK			39
 #define IMX_ADMA_LPCG_LCD_APB_CLK			40
+#define IMX_ADMA_LPCG_DSP_ADB_CLK			41
+#define IMX_ADMA_LPCG_DSP_IPG_CLK			42
+#define IMX_ADMA_LPCG_DSP_CORE_CLK			43
+#define IMX_ADMA_LPCG_OCRAM_IPG_CLK			44
 
-#define IMX_ADMA_LPCG_CLK_END				41
+#define IMX_ADMA_LPCG_CLK_END				45
 
 #endif /* __DT_BINDINGS_CLOCK_IMX_H */
-- 
2.17.1

