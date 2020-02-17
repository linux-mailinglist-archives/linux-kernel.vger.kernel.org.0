Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 409641608D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 04:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgBQD0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 22:26:44 -0500
Received: from inva020.nxp.com ([92.121.34.13]:46182 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbgBQD0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:26:42 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 319131A1F31;
        Mon, 17 Feb 2020 04:26:40 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 29A4D1A1F41;
        Mon, 17 Feb 2020 04:26:30 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E78E340320;
        Mon, 17 Feb 2020 11:26:18 +0800 (SGT)
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, aisheng.dong@nxp.com, peng.fan@nxp.com,
        fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 4/7] clk: imx: imx8qxp: Enable SCU and LPCG clocks for I2C in CM40 SS
Date:   Mon, 17 Feb 2020 11:19:18 +0800
Message-Id: <1581909561-12058-5-git-send-email-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581909561-12058-1-git-send-email-qiangqing.zhang@nxp.com>
References: <1581909561-12058-1-git-send-email-qiangqing.zhang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SCU and LPCG clocks for I2C in CM40 SS.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp-lpcg.c | 12 ++++++++++++
 drivers/clk/imx/clk-imx8qxp-lpcg.h |  3 +++
 drivers/clk/imx/clk-imx8qxp.c      |  4 ++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
index 04c8ee35e14c..795909ecfba6 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -151,6 +151,17 @@ static const struct imx8qxp_lpcg_data imx8qxp_lpcg_lsio[] = {
 	{ IMX_LSIO_LPCG_PWM6_IPG_MSTR_CLK, "pwm6_lpcg_ipg_mstr_clk", "pwm6_clk", 0, LSIO_PWM_6_LPCG, 24, 0, },
 };
 
+static const struct imx8qxp_lpcg_data imx8qxp_lpcg_cm40[] = {
+	{ IMX_CM40_LPCG_I2C_CLK, "cm40_lpcg_i2c_clk", "cm40_i2c_clk", 0, CM40_I2C_LPCG, 0, 0, },
+	{ IMX_CM40_LPCG_I2C_IPG_CLK, "cm40_lpcg_i2c_ipg_clk", "cm40_ipg_clk_root", 0, CM40_I2C_LPCG, 16, 0, },
+};
+
+static const struct imx8qxp_ss_lpcg imx8qxp_ss_cm40 = {
+	.lpcg = imx8qxp_lpcg_cm40,
+	.num_lpcg = ARRAY_SIZE(imx8qxp_lpcg_cm40),
+	.num_max = IMX_CM40_LPCG_CLK_END,
+};
+
 static const struct imx8qxp_ss_lpcg imx8qxp_ss_lsio = {
 	.lpcg = imx8qxp_lpcg_lsio,
 	.num_lpcg = ARRAY_SIZE(imx8qxp_lpcg_lsio),
@@ -219,6 +230,7 @@ static const struct of_device_id imx8qxp_lpcg_match[] = {
 	{ .compatible = "fsl,imx8qxp-lpcg-adma", &imx8qxp_ss_adma, },
 	{ .compatible = "fsl,imx8qxp-lpcg-conn", &imx8qxp_ss_conn, },
 	{ .compatible = "fsl,imx8qxp-lpcg-lsio", &imx8qxp_ss_lsio, },
+	{ .compatible = "fsl,imx8qxp-lpcg-cm40", &imx8qxp_ss_cm40, },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.h b/drivers/clk/imx/clk-imx8qxp-lpcg.h
index 2a37ce57c500..28ca730dd135 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.h
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.h
@@ -99,4 +99,7 @@
 #define ADMA_FLEXCAN_1_LPCG		0x1ce0000
 #define ADMA_FLEXCAN_2_LPCG		0x1cf0000
 
+/* CM40 SS */
+#define CM40_I2C_LPCG			0x60000
+
 #endif /* _IMX8QXP_LPCG_H */
diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 5e2903efc488..d051073ff042 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -53,6 +53,7 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	clks[IMX_HSIO_PER_CLK]		= clk_hw_register_fixed_rate(NULL, "hsio_per_clk_root", NULL, 0, 133333333);
 	clks[IMX_LSIO_MEM_CLK]		= clk_hw_register_fixed_rate(NULL, "lsio_mem_clk_root", NULL, 0, 200000000);
 	clks[IMX_LSIO_BUS_CLK]		= clk_hw_register_fixed_rate(NULL, "lsio_bus_clk_root", NULL, 0, 100000000);
+	clks[IMX_CM40_IPG_CLK]		= clk_hw_register_fixed_rate(NULL, "cm40_ipg_clk_root", NULL, 0, 132000000);
 
 	/* ARM core */
 	clks[IMX_A35_CLK]		= imx_clk_scu("a35_clk", IMX_SC_R_A35, IMX_SC_PM_CLK_CPU);
@@ -128,6 +129,9 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	clks[IMX_GPU0_CORE_CLK]		= imx_clk_scu("gpu_core0_clk",	 IMX_SC_R_GPU_0_PID0, IMX_SC_PM_CLK_PER);
 	clks[IMX_GPU0_SHADER_CLK]	= imx_clk_scu("gpu_shader0_clk", IMX_SC_R_GPU_0_PID0, IMX_SC_PM_CLK_MISC);
 
+	/* CM40 SS */
+	clks[IMX_CM40_I2C_CLK]		= imx_clk_scu("cm40_i2c_clk", IMX_SC_R_M4_0_I2C, IMX_SC_PM_CLK_PER);
+
 	for (i = 0; i < clk_data->num; i++) {
 		if (IS_ERR(clks[i]))
 			pr_warn("i.MX clk %u: register failed with %ld\n",
-- 
2.17.1

