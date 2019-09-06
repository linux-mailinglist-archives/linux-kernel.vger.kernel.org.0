Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D36AB031
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 03:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbfIFBfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 21:35:19 -0400
Received: from inva020.nxp.com ([92.121.34.13]:46392 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730279AbfIFBfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 21:35:18 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 009C51A050C;
        Fri,  6 Sep 2019 03:35:16 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A52BD1A0B7A;
        Fri,  6 Sep 2019 03:35:07 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 947C440296;
        Fri,  6 Sep 2019 09:34:57 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, abel.vesa@nxp.com, peng.fan@nxp.com,
        ping.bai@nxp.com, chen.fang@nxp.com, shengjiu.wang@nxp.com,
        aisheng.dong@nxp.com, sfr@canb.auug.org.au, l.stach@pengutronix.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 1/2] clk: imx8mm: Move 1443X/1416X PLL clock structure to common place
Date:   Fri,  6 Sep 2019 09:34:05 -0400
Message-Id: <1567776846-6373-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many i.MX8M SoCs use same 1443X/1416X PLL, such as i.MX8MM,
i.MX8MN and later i.MX8M SoCs, moving these PLL definitions
to pll14xx driver can save a lot of duplicated code on each
platform.

Meanwhile, no need to define PLL clock structure for every
module which uses same type of PLL, e.g., audio/video/dram use
1443X PLL, arm/gpu/vpu/sys use 1416X PLL, define 2 PLL clock
structure for each group is enough.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- Move 1443X/1416X PLL clock table/structure to pll14xx driver.
---
 drivers/clk/imx/clk-imx8mm.c  | 87 +++++--------------------------------------
 drivers/clk/imx/clk-pll14xx.c | 30 +++++++++++++++
 drivers/clk/imx/clk.h         |  3 ++
 3 files changed, 43 insertions(+), 77 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 2758e3f..9649250 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -26,73 +26,6 @@ static u32 share_count_disp;
 static u32 share_count_pdm;
 static u32 share_count_nand;
 
-static const struct imx_pll14xx_rate_table imx8mm_pll1416x_tbl[] = {
-	PLL_1416X_RATE(1800000000U, 225, 3, 0),
-	PLL_1416X_RATE(1600000000U, 200, 3, 0),
-	PLL_1416X_RATE(1200000000U, 300, 3, 1),
-	PLL_1416X_RATE(1000000000U, 250, 3, 1),
-	PLL_1416X_RATE(800000000U,  200, 3, 1),
-	PLL_1416X_RATE(750000000U,  250, 2, 2),
-	PLL_1416X_RATE(700000000U,  350, 3, 2),
-	PLL_1416X_RATE(600000000U,  300, 3, 2),
-};
-
-static const struct imx_pll14xx_rate_table imx8mm_audiopll_tbl[] = {
-	PLL_1443X_RATE(393216000U, 262, 2, 3, 9437),
-	PLL_1443X_RATE(361267200U, 361, 3, 3, 17511),
-};
-
-static const struct imx_pll14xx_rate_table imx8mm_videopll_tbl[] = {
-	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
-	PLL_1443X_RATE(594000000U, 198, 2, 2, 0),
-};
-
-static const struct imx_pll14xx_rate_table imx8mm_drampll_tbl[] = {
-	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
-};
-
-static struct imx_pll14xx_clk imx8mm_audio_pll = {
-		.type = PLL_1443X,
-		.rate_table = imx8mm_audiopll_tbl,
-		.rate_count = ARRAY_SIZE(imx8mm_audiopll_tbl),
-};
-
-static struct imx_pll14xx_clk imx8mm_video_pll = {
-		.type = PLL_1443X,
-		.rate_table = imx8mm_videopll_tbl,
-		.rate_count = ARRAY_SIZE(imx8mm_videopll_tbl),
-};
-
-static struct imx_pll14xx_clk imx8mm_dram_pll = {
-		.type = PLL_1443X,
-		.rate_table = imx8mm_drampll_tbl,
-		.rate_count = ARRAY_SIZE(imx8mm_drampll_tbl),
-};
-
-static struct imx_pll14xx_clk imx8mm_arm_pll = {
-		.type = PLL_1416X,
-		.rate_table = imx8mm_pll1416x_tbl,
-		.rate_count = ARRAY_SIZE(imx8mm_pll1416x_tbl),
-};
-
-static struct imx_pll14xx_clk imx8mm_gpu_pll = {
-		.type = PLL_1416X,
-		.rate_table = imx8mm_pll1416x_tbl,
-		.rate_count = ARRAY_SIZE(imx8mm_pll1416x_tbl),
-};
-
-static struct imx_pll14xx_clk imx8mm_vpu_pll = {
-		.type = PLL_1416X,
-		.rate_table = imx8mm_pll1416x_tbl,
-		.rate_count = ARRAY_SIZE(imx8mm_pll1416x_tbl),
-};
-
-static struct imx_pll14xx_clk imx8mm_sys_pll = {
-		.type = PLL_1416X,
-		.rate_table = imx8mm_pll1416x_tbl,
-		.rate_count = ARRAY_SIZE(imx8mm_pll1416x_tbl),
-};
-
 static const char *pll_ref_sels[] = { "osc_24m", "dummy", "dummy", "dummy", };
 static const char *audio_pll1_bypass_sels[] = {"audio_pll1", "audio_pll1_ref_sel", };
 static const char *audio_pll2_bypass_sels[] = {"audio_pll2", "audio_pll2_ref_sel", };
@@ -396,16 +329,16 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	clks[IMX8MM_SYS_PLL2_REF_SEL] = imx_clk_mux("sys_pll2_ref_sel", base + 0x104, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	clks[IMX8MM_SYS_PLL3_REF_SEL] = imx_clk_mux("sys_pll3_ref_sel", base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 
-	clks[IMX8MM_AUDIO_PLL1] = imx_clk_pll14xx("audio_pll1", "audio_pll1_ref_sel", base, &imx8mm_audio_pll);
-	clks[IMX8MM_AUDIO_PLL2] = imx_clk_pll14xx("audio_pll2", "audio_pll2_ref_sel", base + 0x14, &imx8mm_audio_pll);
-	clks[IMX8MM_VIDEO_PLL1] = imx_clk_pll14xx("video_pll1", "video_pll1_ref_sel", base + 0x28, &imx8mm_video_pll);
-	clks[IMX8MM_DRAM_PLL] = imx_clk_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx8mm_dram_pll);
-	clks[IMX8MM_GPU_PLL] = imx_clk_pll14xx("gpu_pll", "gpu_pll_ref_sel", base + 0x64, &imx8mm_gpu_pll);
-	clks[IMX8MM_VPU_PLL] = imx_clk_pll14xx("vpu_pll", "vpu_pll_ref_sel", base + 0x74, &imx8mm_vpu_pll);
-	clks[IMX8MM_ARM_PLL] = imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel", base + 0x84, &imx8mm_arm_pll);
-	clks[IMX8MM_SYS_PLL1] = imx_clk_pll14xx("sys_pll1", "sys_pll1_ref_sel", base + 0x94, &imx8mm_sys_pll);
-	clks[IMX8MM_SYS_PLL2] = imx_clk_pll14xx("sys_pll2", "sys_pll2_ref_sel", base + 0x104, &imx8mm_sys_pll);
-	clks[IMX8MM_SYS_PLL3] = imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_sel", base + 0x114, &imx8mm_sys_pll);
+	clks[IMX8MM_AUDIO_PLL1] = imx_clk_pll14xx("audio_pll1", "audio_pll1_ref_sel", base, &imx_1443x_pll);
+	clks[IMX8MM_AUDIO_PLL2] = imx_clk_pll14xx("audio_pll2", "audio_pll2_ref_sel", base + 0x14, &imx_1443x_pll);
+	clks[IMX8MM_VIDEO_PLL1] = imx_clk_pll14xx("video_pll1", "video_pll1_ref_sel", base + 0x28, &imx_1443x_pll);
+	clks[IMX8MM_DRAM_PLL] = imx_clk_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx_1443x_pll);
+	clks[IMX8MM_GPU_PLL] = imx_clk_pll14xx("gpu_pll", "gpu_pll_ref_sel", base + 0x64, &imx_1416x_pll);
+	clks[IMX8MM_VPU_PLL] = imx_clk_pll14xx("vpu_pll", "vpu_pll_ref_sel", base + 0x74, &imx_1416x_pll);
+	clks[IMX8MM_ARM_PLL] = imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel", base + 0x84, &imx_1416x_pll);
+	clks[IMX8MM_SYS_PLL1] = imx_clk_pll14xx("sys_pll1", "sys_pll1_ref_sel", base + 0x94, &imx_1416x_pll);
+	clks[IMX8MM_SYS_PLL2] = imx_clk_pll14xx("sys_pll2", "sys_pll2_ref_sel", base + 0x104, &imx_1416x_pll);
+	clks[IMX8MM_SYS_PLL3] = imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_sel", base + 0x114, &imx_1416x_pll);
 
 	/* PLL bypass out */
 	clks[IMX8MM_AUDIO_PLL1_BYPASS] = imx_clk_mux_flags("audio_pll1_bypass", base, 4, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels), CLK_SET_RATE_PARENT);
diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index b721302..4a61743 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -41,6 +41,36 @@ struct clk_pll14xx {
 
 #define to_clk_pll14xx(_hw) container_of(_hw, struct clk_pll14xx, hw)
 
+const struct imx_pll14xx_rate_table imx_pll1416x_tbl[] = {
+	PLL_1416X_RATE(1800000000U, 225, 3, 0),
+	PLL_1416X_RATE(1600000000U, 200, 3, 0),
+	PLL_1416X_RATE(1200000000U, 300, 3, 1),
+	PLL_1416X_RATE(1000000000U, 250, 3, 1),
+	PLL_1416X_RATE(800000000U,  200, 3, 1),
+	PLL_1416X_RATE(750000000U,  250, 2, 2),
+	PLL_1416X_RATE(700000000U,  350, 3, 2),
+	PLL_1416X_RATE(600000000U,  300, 3, 2),
+};
+
+const struct imx_pll14xx_rate_table imx_pll1443x_tbl[] = {
+	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
+	PLL_1443X_RATE(594000000U, 198, 2, 2, 0),
+	PLL_1443X_RATE(393216000U, 262, 2, 3, 9437),
+	PLL_1443X_RATE(361267200U, 361, 3, 3, 17511),
+};
+
+struct imx_pll14xx_clk imx_1443x_pll = {
+	.type = PLL_1443X,
+	.rate_table = imx_pll1443x_tbl,
+	.rate_count = ARRAY_SIZE(imx_pll1443x_tbl),
+};
+
+struct imx_pll14xx_clk imx_1416x_pll = {
+	.type = PLL_1416X,
+	.rate_table = imx_pll1416x_tbl,
+	.rate_count = ARRAY_SIZE(imx_pll1416x_tbl),
+};
+
 static const struct imx_pll14xx_rate_table *imx_get_pll_settings(
 		struct clk_pll14xx *pll, unsigned long rate)
 {
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index f7a389a..bc5bb6a 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -50,6 +50,9 @@ struct imx_pll14xx_clk {
 	int flags;
 };
 
+extern struct imx_pll14xx_clk imx_1416x_pll;
+extern struct imx_pll14xx_clk imx_1443x_pll;
+
 #define imx_clk_cpu(name, parent_name, div, mux, pll, step) \
 	imx_clk_hw_cpu(name, parent_name, div, mux, pll, step)->clk
 
-- 
2.7.4

