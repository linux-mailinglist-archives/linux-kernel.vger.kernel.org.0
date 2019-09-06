Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32272AB1EE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 07:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392301AbfIFFL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 01:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732560AbfIFFL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 01:11:59 -0400
Received: from localhost.localdomain (unknown [223.226.32.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F31512082C;
        Fri,  6 Sep 2019 05:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567746717;
        bh=XnP11GvP2IpXf9gm3MXxzhBW+IwTDypL405pNxk9c1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XfnoJxwLnDTbnv+5xHGw5bhqAF1UWblc+4OLYyIfnLXMrbi6SrTih0Vd2miwKPzkG
         FsUauJk6XXCVrVnG44RVA89Y2RGBVcujLJotLLOJ6wbJ+CQtJcMPF0uhYOv46Vhiqd
         0meARH0vwoySVVDT2NunY8uiw4cPkcZKRsqgbSQw=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v2 3/3] phy: qcom-qmp: Add SM8150 QMP UFS PHY support
Date:   Fri,  6 Sep 2019 10:40:17 +0530
Message-Id: <20190906051017.26846-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906051017.26846-1-vkoul@kernel.org>
References: <20190906051017.26846-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8150 UFS PHY is v4 of QMP phy. Add support for V4 QMP phy register
defines and support for SM8150 QMP UFS PHY.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 125 ++++++++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h |  96 +++++++++++++++++++++
 2 files changed, 221 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 34ff6434da8f..92d3048f2b36 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -164,6 +164,11 @@ static const unsigned int sdm845_ufsphy_regs_layout[] = {
 	[QPHY_PCS_READY_STATUS]		= 0x160,
 };
 
+static const unsigned int sm8150_ufsphy_regs_layout[] = {
+	[QPHY_START_CTRL]		= 0x00,
+	[QPHY_PCS_READY_STATUS]		= 0x180,
+};
+
 static const struct qmp_phy_init_tbl msm8996_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x1c),
 	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_ENABLE1, 0x10),
@@ -878,6 +883,93 @@ static const struct qmp_phy_init_tbl msm8998_usb3_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
 };
 
+static const struct qmp_phy_init_tbl sm8150_ufsphy_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_POWER_DOWN_CONTROL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_SYSCLK_EN_SEL, 0xd9),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_HSCLK_SEL, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_HSCLK_HS_SWITCH_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_LOCK_CMP_EN, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_VCO_TUNE_MAP, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_VCO_TUNE_INITVAL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_BIN_VCOCAL_HSCLK_SEL, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_LOCK_CMP1_MODE0, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_LOCK_CMP2_MODE0, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_BIN_VCOCAL_CMP_CODE1_MODE0, 0xac),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_DEC_START_MODE1, 0x98),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_LOCK_CMP1_MODE1, 0x32),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_LOCK_CMP2_MODE1, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_BIN_VCOCAL_CMP_CODE1_MODE1, 0xdd),
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_BIN_VCOCAL_CMP_CODE2_MODE1, 0x23),
+
+	/* Rate B */
+	QMP_PHY_INIT_CFG(QSERDES_COM_V4_VCO_TUNE_MAP, 0x06),
+};
+
+static const struct qmp_phy_init_tbl sm8150_ufsphy_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_4_DIVIDER_BAND0_1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_TRAN_DRVR_EMP_EN, 0x0c),
+};
+
+static const struct qmp_phy_init_tbl sm8150_ufsphy_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_LVL, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_BAND, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x4b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0xf1),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_TERM_BW, 0x1b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_MEASURE_TIME, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xf6),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x3d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0xe0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0xb1),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_LOW, 0xe0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH2, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH3, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH4, 0xb1),
+
+};
+
+static const struct qmp_phy_init_tbl sm8150_ufsphy_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_RX_SIGDET_CTRL2, 0x6d),
+	QMP_PHY_INIT_CFG(QPHY_V4_TX_LARGE_AMP_DRV_LVL, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_V4_TX_SMALL_AMP_DRV_LVL, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V4_TX_MID_TERM_CTRL1, 0x43),
+	QMP_PHY_INIT_CFG(QPHY_V4_DEBUG_BUS_CLKSEL, 0x1f),
+	QMP_PHY_INIT_CFG(QPHY_V4_RX_MIN_HIBERN8_TIME, 0xff),
+	QMP_PHY_INIT_CFG(QPHY_V4_MULTI_LANE_CTRL1, 0x02),
+};
 
 /* struct qmp_phy_cfg - per-PHY initialization config */
 struct qmp_phy_cfg {
@@ -1038,6 +1130,10 @@ static const char * const sdm845_ufs_phy_clk_l[] = {
 	"ref", "ref_aux",
 };
 
+static const char * const sm8150_ufs_phy_clk_l[] = {
+	"ref", "ref_aux",
+};
+
 /* list of resets */
 static const char * const msm8996_pciephy_reset_l[] = {
 	"phy", "common", "cfg",
@@ -1284,6 +1380,32 @@ static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
 	.is_dual_lane_phy       = true,
 };
 
+static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
+	.type			= PHY_TYPE_UFS,
+	.nlanes			= 2,
+
+	.serdes_tbl		= sm8150_ufsphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_serdes_tbl),
+	.tx_tbl			= sm8150_ufsphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_tx_tbl),
+	.rx_tbl			= sm8150_ufsphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_rx_tbl),
+	.pcs_tbl		= sm8150_ufsphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8150_ufsphy_pcs_tbl),
+	.clk_list		= sm8150_ufs_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(sm8150_ufs_phy_clk_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sm8150_ufsphy_regs_layout,
+
+	.start_ctrl		= SERDES_START,
+	.pwrdn_ctrl		= SW_PWRDN,
+	.mask_pcs_ready		= PCS_READY,
+
+	.is_dual_lane_phy	= true,
+	.no_pcs_sw_reset	= true,
+};
+
 static void qcom_qmp_phy_configure(void __iomem *base,
 				   const unsigned int *regs,
 				   const struct qmp_phy_init_tbl tbl[],
@@ -1999,6 +2121,9 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
 	}, {
 		.compatible = "qcom,msm8998-qmp-usb3-phy",
 		.data = &msm8998_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,sm8150-qmp-ufs-phy",
+		.data = &sm8150_ufsphy_cfg,
 	},
 	{ },
 };
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 335ea5d7ef40..0eefd8621669 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -313,4 +313,100 @@
 #define QPHY_V3_PCS_MISC_OSC_DTCT_MODE2_CONFIG4		0x5c
 #define QPHY_V3_PCS_MISC_OSC_DTCT_MODE2_CONFIG5		0x60
 
+/* Only for QMP V4 PHY - QSERDES COM registers */
+#define QSERDES_COM_V4_SYSCLK_EN_SEL			0x094
+#define QSERDES_COM_V4_HSCLK_SEL			0x158
+#define QSERDES_COM_V4_HSCLK_HS_SWITCH_SEL		0x15C
+#define QSERDES_COM_V4_LOCK_CMP_EN			0x0A4
+#define QSERDES_COM_V4_VCO_TUNE_MAP			0x10C
+#define QSERDES_COM_V4_PLL_IVCO				0x058
+#define QSERDES_COM_V4_VCO_TUNE_INITVAL2		0x124
+#define QSERDES_COM_V4_BIN_VCOCAL_HSCLK_SEL		0x1BC
+#define QSERDES_COM_V4_DEC_START_MODE0			0x0BC
+#define QSERDES_COM_V4_CP_CTRL_MODE0			0x074
+#define QSERDES_COM_V4_PLL_RCTRL_MODE0			0x07C
+#define QSERDES_COM_V4_PLL_CCTRL_MODE0			0x084
+#define QSERDES_COM_V4_LOCK_CMP1_MODE0			0x0AC
+#define QSERDES_COM_V4_LOCK_CMP2_MODE0			0x0B0
+#define QSERDES_COM_V4_BIN_VCOCAL_CMP_CODE1_MODE0	0x1AC
+#define QSERDES_COM_V4_BIN_VCOCAL_CMP_CODE2_MODE0	0x1B0
+#define QSERDES_COM_V4_DEC_START_MODE1			0x0C4
+#define QSERDES_COM_V4_CP_CTRL_MODE1			0x078
+#define QSERDES_COM_V4_PLL_RCTRL_MODE1			0x080
+#define QSERDES_COM_V4_PLL_CCTRL_MODE1			0x088
+#define QSERDES_COM_V4_LOCK_CMP1_MODE1			0x0B4
+#define QSERDES_COM_V4_LOCK_CMP2_MODE1			0x0B8
+#define QSERDES_COM_V4_BIN_VCOCAL_CMP_CODE1_MODE1	0x1B4
+#define QSERDES_COM_V4_BIN_VCOCAL_CMP_CODE2_MODE1	0x1B8
+#define QSERDES_COM_V4_CMN_IPTRIM			0x060
+
+/* Only for QMP V4 PHY - TX registers */
+#define QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1	0xD8
+#define QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1	0xDC
+#define QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1	0xE0
+#define QSERDES_V4_TX_PWM_GEAR_4_DIVIDER_BAND0_1	0xE4
+#define QSERDES_V4_TX_LANE_MODE_1			0x84
+#define QSERDES_V4_TX_TRAN_DRVR_EMP_EN			0xB8
+
+/* Only for QMP V4 PHY - RX registers */
+#define QSERDES_V4_RX_SIGDET_LVL			0x120
+#define QSERDES_V4_RX_SIGDET_CNTRL			0x11C
+#define QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL		0x124
+#define QSERDES_V4_RX_RX_BAND				0x128
+#define QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN		0x030
+#define QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE	0x034
+#define QSERDES_V4_RX_UCDR_PI_CONTROLS			0x044
+#define QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW		0x03C
+#define QSERDES_V4_RX_UCDR_PI_CTRL2			0x048
+#define QSERDES_V4_RX_RX_TERM_BW			0x080
+#define QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2		0x0EC
+#define QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3		0x0F0
+#define QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4		0x0F4
+#define QSERDES_V4_RX_RX_OFFSET_ADAPTOR_CNTRL2		0x114
+#define QSERDES_V4_RX_RX_IDAC_MEASURE_TIME		0x100
+#define QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW		0x0F8
+#define QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH		0x0FC
+#define QSERDES_V4_RX_RX_MODE_00_LOW			0x170
+#define QSERDES_V4_RX_RX_MODE_00_HIGH			0x174
+#define QSERDES_V4_RX_RX_MODE_00_HIGH2			0x178
+#define QSERDES_V4_RX_RX_MODE_00_HIGH3			0x17C
+#define QSERDES_V4_RX_RX_MODE_00_HIGH4			0x180
+#define QSERDES_V4_RX_RX_MODE_01_LOW			0x184
+#define QSERDES_V4_RX_RX_MODE_01_HIGH			0x188
+#define QSERDES_V4_RX_RX_MODE_01_HIGH2			0x18C
+#define QSERDES_V4_RX_RX_MODE_01_HIGH3			0x190
+#define QSERDES_V4_RX_RX_MODE_01_HIGH4			0x194
+#define QSERDES_V4_RX_RX_MODE_10_LOW			0x198
+#define QSERDES_V4_RX_RX_MODE_10_HIGH			0x19C
+#define QSERDES_V4_RX_RX_MODE_10_HIGH2			0x1A0
+#define QSERDES_V4_RX_RX_MODE_10_HIGH3			0x1A4
+#define QSERDES_V4_RX_RX_MODE_10_HIGH4			0x1A8
+#define QSERDES_V4_RX_DCC_CTRL1				0x1BC
+#define QSERDES_V4_RX_AC_JTAG_ENABLE			0x068
+#define QSERDES_V4_RX_UCDR_FO_GAIN			0x008
+#define QSERDES_V4_RX_UCDR_SO_GAIN			0x014
+#define QSERDES_V4_RX_AC_JTAG_MODE			0x078
+
+/* Only for QMP V4 PHY - PCS registers */
+#define QPHY_V4_PHY_START				0x000
+#define QPHY_V4_POWER_DOWN_CONTROL			0x004
+#define QPHY_V4_SW_RESET				0x008
+#define QPHY_V4_PCS_READY_STATUS			0x180
+#define QPHY_V4_LINECFG_DISABLE				0x148
+#define QPHY_V4_MULTI_LANE_CTRL1			0x1E0
+#define QPHY_V4_RX_SIGDET_CTRL2				0x158
+#define QPHY_V4_TX_LARGE_AMP_DRV_LVL			0x030
+#define QPHY_V4_TX_SMALL_AMP_DRV_LVL			0x038
+#define QPHY_V4_TX_MID_TERM_CTRL1			0x1D8
+#define QPHY_V4_DEBUG_BUS_CLKSEL			0x124
+#define QPHY_V4_PLL_CNTL				0x02C
+#define QPHY_V4_TIMER_20US_CORECLK_STEPS_MSB		0x00C
+#define QPHY_V4_TIMER_20US_CORECLK_STEPS_LSB		0x010
+#define QPHY_V4_TX_PWM_GEAR_BAND			0x160
+#define QPHY_V4_TX_HS_GEAR_BAND				0x168
+#define QPHY_V4_TX_HSGEAR_CAPABILITY			0x074
+#define QPHY_V4_RX_HSGEAR_CAPABILITY			0x0B4
+#define QPHY_V4_RX_MIN_HIBERN8_TIME			0x150
+#define QPHY_V4_BIST_FIXED_PAT_CTRL			0x060
+
 #endif
-- 
2.20.1

