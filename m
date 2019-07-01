Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC214C577
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 04:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbfFTCig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 22:38:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53115 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726389AbfFTCib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 22:38:31 -0400
X-UUID: 96c5f77ad7d5415b87a0ac5dcab1762d-20190620
X-UUID: 96c5f77ad7d5415b87a0ac5dcab1762d-20190620
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1256054898; Thu, 20 Jun 2019 10:38:21 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 20 Jun 2019 10:38:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 20 Jun 2019 10:38:20 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v6 13/14] soc: mediatek: Add MT8183 scpsys support
Date:   Thu, 20 Jun 2019 10:38:05 +0800
Message-ID: <1560998286-9189-14-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1560998286-9189-1-git-send-email-weiyi.lu@mediatek.com>
References: <1560998286-9189-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add scpsys driver for MT8183

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 226 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 226 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index d3fdb3f..ea5a221 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -20,6 +20,7 @@
 #include <dt-bindings/power/mt7622-power.h>
 #include <dt-bindings/power/mt7623a-power.h>
 #include <dt-bindings/power/mt8173-power.h>
+#include <dt-bindings/power/mt8183-power.h>
 
 #define MTK_POLL_DELAY_US   10
 #define MTK_POLL_TIMEOUT    USEC_PER_SEC
@@ -1129,6 +1130,217 @@ static void mtk_register_power_domains(struct platform_device *pdev,
 	{MT8173_POWER_DOMAIN_MFG_2D, MT8173_POWER_DOMAIN_MFG},
 };
 
+/*
+ * MT8183 power domain support
+ */
+
+static const struct scp_domain_data scp_domain_data_mt8183[] = {
+	[MT8183_POWER_DOMAIN_AUDIO] = {
+		.name = "audio",
+		.sta_mask = PWR_STATUS_AUDIO,
+		.ctl_offs = 0x0314,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.basic_clk_id = {"audio", "audio1", "audio2"},
+	},
+	[MT8183_POWER_DOMAIN_CONN] = {
+		.name = "conn",
+		.sta_mask = PWR_STATUS_CONN,
+		.ctl_offs = 0x032c,
+		.sram_pdn_bits = 0,
+		.sram_pdn_ack_bits = 0,
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
+				BIT(13) | BIT(14), BIT(13) | BIT(14)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_MFG_ASYNC] = {
+		.name = "mfg_async",
+		.sta_mask = PWR_STATUS_MFG_ASYNC,
+		.ctl_offs = 0x0334,
+		.sram_pdn_bits = 0,
+		.sram_pdn_ack_bits = 0,
+		.basic_clk_id = {"mfg"},
+	},
+	[MT8183_POWER_DOMAIN_MFG] = {
+		.name = "mfg",
+		.sta_mask = PWR_STATUS_MFG,
+		.ctl_offs = 0x0338,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8183_POWER_DOMAIN_MFG_CORE0] = {
+		.name = "mfg_core0",
+		.sta_mask = BIT(7),
+		.ctl_offs = 0x034c,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8183_POWER_DOMAIN_MFG_CORE1] = {
+		.name = "mfg_core1",
+		.sta_mask = BIT(20),
+		.ctl_offs = 0x0310,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8183_POWER_DOMAIN_MFG_2D] = {
+		.name = "mfg_2d",
+		.sta_mask = PWR_STATUS_MFG_2D,
+		.ctl_offs = 0x0348,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2a8, 0x2ac, 0, 0x258,
+				BIT(19) | BIT(20) | BIT(21),
+				BIT(19) | BIT(20) | BIT(21)),
+			BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
+				BIT(21) | BIT(22), BIT(21) | BIT(22)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_DISP] = {
+		.name = "disp",
+		.sta_mask = PWR_STATUS_DISP,
+		.ctl_offs = 0x030c,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.basic_clk_id = {"mm"},
+		.subsys_clk_prefix = "mm",
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2a8, 0x2ac, 0, 0x258,
+				BIT(16) | BIT(17), BIT(16) | BIT(17)),
+			BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
+				BIT(10) | BIT(11), BIT(10) | BIT(11)),
+			BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
+				GENMASK(7, 0), GENMASK(7, 0)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_CAM] = {
+		.name = "cam",
+		.sta_mask = BIT(25),
+		.ctl_offs = 0x0344,
+		.sram_pdn_bits = GENMASK(9, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.basic_clk_id = {"cam"},
+		.subsys_clk_prefix = "cam",
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
+				BIT(4) | BIT(5) | BIT(9) | BIT(13),
+				BIT(4) | BIT(5) | BIT(9) | BIT(13)),
+			BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
+				BIT(28), BIT(28)),
+			BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
+				BIT(11), 0),
+			BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
+				BIT(3) | BIT(4), BIT(3) | BIT(4)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_ISP] = {
+		.name = "isp",
+		.sta_mask = PWR_STATUS_ISP,
+		.ctl_offs = 0x0308,
+		.sram_pdn_bits = GENMASK(9, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.basic_clk_id = {"isp"},
+		.subsys_clk_prefix = "isp",
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
+				BIT(3) | BIT(8), BIT(3) | BIT(8)),
+			BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
+				BIT(10), 0),
+			BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
+				BIT(2), BIT(2)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_VDEC] = {
+		.name = "vdec",
+		.sta_mask = BIT(31),
+		.ctl_offs = 0x0300,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_table = {
+			BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
+				BIT(7), BIT(7)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_VENC] = {
+		.name = "venc",
+		.sta_mask = PWR_STATUS_VENC,
+		.ctl_offs = 0x0304,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.bp_table = {
+			BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
+				BIT(1), BIT(1)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_VPU_TOP] = {
+		.name = "vpu_top",
+		.sta_mask = BIT(26),
+		.ctl_offs = 0x0324,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.basic_clk_id = {"vpu", "vpu1"},
+		.subsys_clk_prefix = "vpu",
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
+				GENMASK(9, 6) | BIT(12),
+				GENMASK(9, 6) | BIT(12)),
+			BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
+				BIT(27), BIT(27)),
+			BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
+				BIT(10) | BIT(11), BIT(10) | BIT(11)),
+			BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
+				BIT(5) | BIT(6), BIT(5) | BIT(6)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_VPU_CORE0] = {
+		.name = "vpu_core0",
+		.sta_mask = BIT(27),
+		.ctl_offs = 0x33c,
+		.sram_iso_ctrl = true,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.basic_clk_id = {"vpu2"},
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
+				BIT(6), BIT(6)),
+			BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
+				BIT(0) | BIT(2) | BIT(4),
+				BIT(0) | BIT(2) | BIT(4)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_VPU_CORE1] = {
+		.name = "vpu_core1",
+		.sta_mask = BIT(28),
+		.ctl_offs = 0x0340,
+		.sram_iso_ctrl = true,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.basic_clk_id = {"vpu3"},
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
+				BIT(7), BIT(7)),
+			BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
+				BIT(1) | BIT(3) | BIT(5),
+				BIT(1) | BIT(3) | BIT(5)),
+		},
+	},
+};
+
+static const struct scp_subdomain scp_subdomain_mt8183[] = {
+	{MT8183_POWER_DOMAIN_MFG_ASYNC, MT8183_POWER_DOMAIN_MFG},
+	{MT8183_POWER_DOMAIN_MFG, MT8183_POWER_DOMAIN_MFG_2D},
+	{MT8183_POWER_DOMAIN_MFG, MT8183_POWER_DOMAIN_MFG_CORE0},
+	{MT8183_POWER_DOMAIN_MFG, MT8183_POWER_DOMAIN_MFG_CORE1},
+	{MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_CAM},
+	{MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_ISP},
+	{MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_VDEC},
+	{MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_VENC},
+	{MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_VPU_TOP},
+	{MT8183_POWER_DOMAIN_VPU_TOP, MT8183_POWER_DOMAIN_VPU_CORE0},
+	{MT8183_POWER_DOMAIN_VPU_TOP, MT8183_POWER_DOMAIN_VPU_CORE1},
+};
+
 static const struct scp_soc_data mt2701_data = {
 	.domains = scp_domain_data_mt2701,
 	.num_domains = ARRAY_SIZE(scp_domain_data_mt2701),
@@ -1195,6 +1407,17 @@ static void mtk_register_power_domains(struct platform_device *pdev,
 	.bus_prot_reg_update = true,
 };
 
+static const struct scp_soc_data mt8183_data = {
+	.domains = scp_domain_data_mt8183,
+	.num_domains = ARRAY_SIZE(scp_domain_data_mt8183),
+	.subdomains = scp_subdomain_mt8183,
+	.num_subdomains = ARRAY_SIZE(scp_subdomain_mt8183),
+	.regs = {
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184
+	}
+};
+
 /*
  * scpsys driver init
  */
@@ -1219,6 +1442,9 @@ static void mtk_register_power_domains(struct platform_device *pdev,
 		.compatible = "mediatek,mt8173-scpsys",
 		.data = &mt8173_data,
 	}, {
+		.compatible = "mediatek,mt8183-scpsys",
+		.data = &mt8183_data,
+	}, {
 		/* sentinel */
 	}
 };
-- 
1.8.1.1.dirty

