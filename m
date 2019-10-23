Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D94F8E1B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 14:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404556AbfJWM6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 08:58:20 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59250 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404484AbfJWM6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:58:19 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9NCwFlB047972;
        Wed, 23 Oct 2019 07:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571835495;
        bh=jRiMBMJmewgGUtO0LFCTHdqgyIH530kaVVBhLOHLdL8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ehCiMypEs8dy28DKFz29neWaqqeu69rbZM4v9fOUyvoMudK5M86MaiONDFzggoyOU
         PcZfOu6Z4UNcflxX0WfmKFtBzUdrX52aQSnPj/Ni5tFgbyG+IPly+QWy9TCjeZPZYL
         GgfuLlvHk5wTK/wnsg+ruGdbRx8E955EvJ1gSks0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NCwFvj064418;
        Wed, 23 Oct 2019 07:58:15 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 07:58:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 07:58:05 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NCw5o7061147;
        Wed, 23 Oct 2019 07:58:13 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     Anil Varughese <aniljoy@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 03/14] phy: cadence: Sierra: Use "regmap" for read and write to Sierra registers
Date:   Wed, 23 Oct 2019 18:27:24 +0530
Message-ID: <20191023125735.4713-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023125735.4713-1-kishon@ti.com>
References: <20191023125735.4713-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "regmap" for read and write to Sierra registers. This is in
perparation for adding SERDES_16G support present in TI's J721E
SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 289 ++++++++++++++++++-----
 1 file changed, 235 insertions(+), 54 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index bed68c25682f..d0e7ae1c67b1 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -22,49 +22,61 @@
 #include <dt-bindings/phy/phy.h>
 
 /* PHY register offsets */
-#define SIERRA_PHY_PLL_CFG		(0xc00e << 2)
-#define SIERRA_DET_STANDEC_A		(0x4000 << 2)
-#define SIERRA_DET_STANDEC_B		(0x4001 << 2)
-#define SIERRA_DET_STANDEC_C		(0x4002 << 2)
-#define SIERRA_DET_STANDEC_D		(0x4003 << 2)
-#define SIERRA_DET_STANDEC_E		(0x4004 << 2)
-#define SIERRA_PSM_LANECAL		(0x4008 << 2)
-#define SIERRA_PSM_DIAG			(0x4015 << 2)
-#define SIERRA_PSC_TX_A0		(0x4028 << 2)
-#define SIERRA_PSC_TX_A1		(0x4029 << 2)
-#define SIERRA_PSC_TX_A2		(0x402A << 2)
-#define SIERRA_PSC_TX_A3		(0x402B << 2)
-#define SIERRA_PSC_RX_A0		(0x4030 << 2)
-#define SIERRA_PSC_RX_A1		(0x4031 << 2)
-#define SIERRA_PSC_RX_A2		(0x4032 << 2)
-#define SIERRA_PSC_RX_A3		(0x4033 << 2)
-#define SIERRA_PLLCTRL_SUBRATE		(0x403A << 2)
-#define SIERRA_PLLCTRL_GEN_D		(0x403E << 2)
-#define SIERRA_DRVCTRL_ATTEN		(0x406A << 2)
-#define SIERRA_CLKPATHCTRL_TMR		(0x4081 << 2)
-#define SIERRA_RX_CREQ_FLTR_A_MODE1	(0x4087 << 2)
-#define SIERRA_RX_CREQ_FLTR_A_MODE0	(0x4088 << 2)
-#define SIERRA_CREQ_CCLKDET_MODE01	(0x408E << 2)
-#define SIERRA_RX_CTLE_MAINTENANCE	(0x4091 << 2)
-#define SIERRA_CREQ_FSMCLK_SEL		(0x4092 << 2)
-#define SIERRA_CTLELUT_CTRL		(0x4098 << 2)
-#define SIERRA_DFE_ECMP_RATESEL		(0x40C0 << 2)
-#define SIERRA_DFE_SMP_RATESEL		(0x40C1 << 2)
-#define SIERRA_DEQ_VGATUNE_CTRL		(0x40E1 << 2)
-#define SIERRA_TMRVAL_MODE3		(0x416E << 2)
-#define SIERRA_TMRVAL_MODE2		(0x416F << 2)
-#define SIERRA_TMRVAL_MODE1		(0x4170 << 2)
-#define SIERRA_TMRVAL_MODE0		(0x4171 << 2)
-#define SIERRA_PICNT_MODE1		(0x4174 << 2)
-#define SIERRA_CPI_OUTBUF_RATESEL	(0x417C << 2)
-#define SIERRA_LFPSFILT_NS		(0x418A << 2)
-#define SIERRA_LFPSFILT_RD		(0x418B << 2)
-#define SIERRA_LFPSFILT_MP		(0x418C << 2)
-#define SIERRA_SDFILT_H2L_A		(0x4191 << 2)
+#define SIERRA_COMMON_CDB_OFFSET	0x0
+#define SIERRA_MACRO_ID_REG		0x0
+
+#define SIERRA_LANE_CDB_OFFSET(ln, offset)	\
+				(0x4000 + ((ln) * (0x800 >> (2 - (offset)))))
+#define SIERRA_DET_STANDEC_A		0x000
+#define SIERRA_DET_STANDEC_B		0x001
+#define SIERRA_DET_STANDEC_C		0x002
+#define SIERRA_DET_STANDEC_D		0x003
+#define SIERRA_DET_STANDEC_E		0x004
+#define SIERRA_PSM_LANECAL		0x008
+#define SIERRA_PSM_DIAG			0x015
+#define SIERRA_PSC_TX_A0		0x028
+#define SIERRA_PSC_TX_A1		0x029
+#define SIERRA_PSC_TX_A2		0x02A
+#define SIERRA_PSC_TX_A3		0x02B
+#define SIERRA_PSC_RX_A0		0x030
+#define SIERRA_PSC_RX_A1		0x031
+#define SIERRA_PSC_RX_A2		0x032
+#define SIERRA_PSC_RX_A3		0x033
+#define SIERRA_PLLCTRL_SUBRATE		0x03A
+#define SIERRA_PLLCTRL_GEN_D		0x03E
+#define SIERRA_DRVCTRL_ATTEN		0x06A
+#define SIERRA_CLKPATHCTRL_TMR		0x081
+#define SIERRA_RX_CREQ_FLTR_A_MODE1	0x087
+#define SIERRA_RX_CREQ_FLTR_A_MODE0	0x088
+#define SIERRA_CREQ_CCLKDET_MODE01	0x08E
+#define SIERRA_RX_CTLE_MAINTENANCE	0x091
+#define SIERRA_CREQ_FSMCLK_SEL		0x092
+#define SIERRA_CTLELUT_CTRL		0x098
+#define SIERRA_DFE_ECMP_RATESEL		0x0C0
+#define SIERRA_DFE_SMP_RATESEL		0x0C1
+#define SIERRA_DEQ_VGATUNE_CTRL		0x0E1
+#define SIERRA_TMRVAL_MODE3		0x16E
+#define SIERRA_TMRVAL_MODE2		0x16F
+#define SIERRA_TMRVAL_MODE1		0x170
+#define SIERRA_TMRVAL_MODE0		0x171
+#define SIERRA_PICNT_MODE1		0x174
+#define SIERRA_CPI_OUTBUF_RATESEL	0x17C
+#define SIERRA_LFPSFILT_NS		0x18A
+#define SIERRA_LFPSFILT_RD		0x18B
+#define SIERRA_LFPSFILT_MP		0x18C
+#define SIERRA_SDFILT_H2L_A		0x191
+
+#define SIERRA_PHY_CONFIG_CTRL_OFFSET	0xc000
+#define SIERRA_PHY_PLL_CFG		0xe
 
 #define SIERRA_MACRO_ID			0x00007364
 #define SIERRA_MAX_LANES		4
 
+static const struct reg_field macro_id_type =
+				REG_FIELD(SIERRA_MACRO_ID_REG, 0, 15);
+static const struct reg_field phy_pll_cfg_1 =
+				REG_FIELD(SIERRA_PHY_PLL_CFG, 1, 1);
+
 struct cdns_sierra_inst {
 	struct phy *phy;
 	u32 phy_type;
@@ -80,28 +92,93 @@ struct cdns_reg_pairs {
 
 struct cdns_sierra_data {
 		u32 id_value;
+		u8 block_offset_shift;
+		u8 reg_offset_shift;
 		u32 pcie_regs;
 		u32 usb_regs;
 		struct cdns_reg_pairs *pcie_vals;
 		struct cdns_reg_pairs  *usb_vals;
 };
 
-struct cdns_sierra_phy {
+struct cdns_regmap_cdb_context {
 	struct device *dev;
 	void __iomem *base;
+	u8 reg_offset_shift;
+};
+
+struct cdns_sierra_phy {
+	struct device *dev;
+	struct regmap *regmap;
 	struct cdns_sierra_data *init_data;
 	struct cdns_sierra_inst phys[SIERRA_MAX_LANES];
 	struct reset_control *phy_rst;
 	struct reset_control *apb_rst;
+	struct regmap *regmap_lane_cdb[SIERRA_MAX_LANES];
+	struct regmap *regmap_phy_config_ctrl;
+	struct regmap *regmap_common_cdb;
+	struct regmap_field *macro_id_type;
+	struct regmap_field *phy_pll_cfg_1;
 	struct clk *clk;
 	int nsubnodes;
 	bool autoconf;
 };
 
+static int cdns_regmap_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct cdns_regmap_cdb_context *ctx = context;
+	u32 offset = reg << ctx->reg_offset_shift;
+
+	writew(val, ctx->base + offset);
+
+	return 0;
+}
+
+static int cdns_regmap_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct cdns_regmap_cdb_context *ctx = context;
+	u32 offset = reg << ctx->reg_offset_shift;
+
+	*val = readw(ctx->base + offset);
+	return 0;
+}
+
+#define SIERRA_LANE_CDB_REGMAP_CONF(n) \
+{ \
+	.name = "sierra_lane" n "_cdb", \
+	.reg_stride = 1, \
+	.fast_io = true, \
+	.reg_write = cdns_regmap_write, \
+	.reg_read = cdns_regmap_read, \
+}
+
+static struct regmap_config cdns_sierra_lane_cdb_config[] = {
+	SIERRA_LANE_CDB_REGMAP_CONF("0"),
+	SIERRA_LANE_CDB_REGMAP_CONF("1"),
+	SIERRA_LANE_CDB_REGMAP_CONF("2"),
+	SIERRA_LANE_CDB_REGMAP_CONF("3"),
+};
+
+static struct regmap_config cdns_sierra_common_cdb_config = {
+	.name = "sierra_common_cdb",
+	.reg_stride = 1,
+	.fast_io = true,
+	.reg_write = cdns_regmap_write,
+	.reg_read = cdns_regmap_read,
+};
+
+static struct regmap_config cdns_sierra_phy_config_ctrl_config = {
+	.name = "sierra_phy_config_ctrl",
+	.reg_stride = 1,
+	.fast_io = true,
+	.reg_write = cdns_regmap_write,
+	.reg_read = cdns_regmap_read,
+};
+
 static void cdns_sierra_phy_init(struct phy *gphy)
 {
 	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
 	struct cdns_sierra_phy *phy = dev_get_drvdata(gphy->dev.parent);
+	struct regmap *regmap = phy->regmap;
 	int i, j;
 	struct cdns_reg_pairs *vals;
 	u32 num_regs;
@@ -115,10 +192,12 @@ static void cdns_sierra_phy_init(struct phy *gphy)
 	} else {
 		return;
 	}
-	for (i = 0; i < ins->num_lanes; i++)
-		for (j = 0; j < num_regs ; j++)
-			writel(vals[j].val, phy->base +
-				vals[j].off + (i + ins->mlane) * 0x800);
+	for (i = 0; i < ins->num_lanes; i++) {
+		for (j = 0; j < num_regs ; j++) {
+			regmap = phy->regmap_lane_cdb[i + ins->mlane];
+			regmap_write(regmap, vals[j].off, vals[j].val);
+		}
+	}
 }
 
 static int cdns_sierra_phy_on(struct phy *gphy)
@@ -159,37 +238,136 @@ static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
 
 static const struct of_device_id cdns_sierra_id_table[];
 
+static struct regmap *cdns_regmap_init(struct device *dev, void __iomem *base,
+				       u32 block_offset, u8 block_offset_shift,
+				       u8 reg_offset_shift,
+				       const struct regmap_config *config)
+{
+	struct cdns_regmap_cdb_context *ctx;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->dev = dev;
+	ctx->base = base + (block_offset << block_offset_shift);
+	ctx->reg_offset_shift = reg_offset_shift;
+
+	return devm_regmap_init(dev, NULL, ctx, config);
+}
+
+static int cdns_regfield_init(struct cdns_sierra_phy *sp)
+{
+	struct device *dev = sp->dev;
+	struct regmap_field *field;
+	struct regmap *regmap;
+
+	regmap = sp->regmap_common_cdb;
+	field = devm_regmap_field_alloc(dev, regmap, macro_id_type);
+	if (IS_ERR(field)) {
+		dev_err(dev, "MACRO_ID_TYPE reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	sp->macro_id_type = field;
+
+	regmap = sp->regmap_phy_config_ctrl;
+	field = devm_regmap_field_alloc(dev, regmap, phy_pll_cfg_1);
+	if (IS_ERR(field)) {
+		dev_err(dev, "PHY_PLL_CFG_1 reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	sp->phy_pll_cfg_1 = field;
+
+	return 0;
+}
+
+static int cdns_regmap_init_blocks(struct cdns_sierra_phy *sp,
+				   void __iomem *base, u8 block_offset_shift,
+				   u8 reg_offset_shift)
+{
+	struct device *dev = sp->dev;
+	struct regmap *regmap;
+	u32 block_offset;
+	int i;
+
+	for (i = 0; i < SIERRA_MAX_LANES; i++) {
+		block_offset = SIERRA_LANE_CDB_OFFSET(i, reg_offset_shift);
+		regmap = cdns_regmap_init(dev, base, block_offset,
+					  block_offset_shift, reg_offset_shift,
+					  &cdns_sierra_lane_cdb_config[i]);
+		if (IS_ERR(regmap)) {
+			dev_err(dev, "Failed to init lane CDB regmap\n");
+			return PTR_ERR(regmap);
+		}
+		sp->regmap_lane_cdb[i] = regmap;
+	}
+
+	regmap = cdns_regmap_init(dev, base, SIERRA_COMMON_CDB_OFFSET,
+				  block_offset_shift, reg_offset_shift,
+				  &cdns_sierra_common_cdb_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to init common CDB regmap\n");
+		return PTR_ERR(regmap);
+	}
+	sp->regmap_common_cdb = regmap;
+
+	regmap = cdns_regmap_init(dev, base, SIERRA_PHY_CONFIG_CTRL_OFFSET,
+				  block_offset_shift, reg_offset_shift,
+				  &cdns_sierra_phy_config_ctrl_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to init PHY config and control regmap\n");
+		return PTR_ERR(regmap);
+	}
+	sp->regmap_phy_config_ctrl = regmap;
+
+	return 0;
+}
+
 static int cdns_sierra_phy_probe(struct platform_device *pdev)
 {
 	struct cdns_sierra_phy *sp;
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
+	struct cdns_sierra_data *data;
+	unsigned int id_value;
 	struct resource *res;
 	int i, ret, node = 0;
+	void __iomem *base;
 	struct device_node *dn = dev->of_node, *child;
 
 	if (of_get_child_count(dn) == 0)
 		return -ENODEV;
 
+	/* Get init data for this PHY */
+	match = of_match_device(cdns_sierra_id_table, dev);
+	if (!match)
+		return -EINVAL;
+
+	data = (struct cdns_sierra_data *)match->data;
+
 	sp = devm_kzalloc(dev, sizeof(*sp), GFP_KERNEL);
 	if (!sp)
 		return -ENOMEM;
 	dev_set_drvdata(dev, sp);
 	sp->dev = dev;
+	sp->init_data = data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sp->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(sp->base)) {
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base)) {
 		dev_err(dev, "missing \"reg\"\n");
-		return PTR_ERR(sp->base);
+		return PTR_ERR(base);
 	}
 
-	/* Get init data for this PHY */
-	match = of_match_device(cdns_sierra_id_table, dev);
-	if (!match)
-		return -EINVAL;
-	sp->init_data = (struct cdns_sierra_data *)match->data;
+	ret = cdns_regmap_init_blocks(sp, base, data->block_offset_shift,
+				      data->reg_offset_shift);
+	if (ret)
+		return ret;
+
+	ret = cdns_regfield_init(sp);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, sp);
 
@@ -219,7 +397,8 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	reset_control_deassert(sp->apb_rst);
 
 	/* Check that PHY is present */
-	if  (sp->init_data->id_value != readl(sp->base)) {
+	regmap_field_read(sp->macro_id_type, &id_value);
+	if  (sp->init_data->id_value != id_value) {
 		ret = -EINVAL;
 		goto clk_disable;
 	}
@@ -267,7 +446,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 
 	/* If more than one subnode, configure the PHY as multilink */
 	if (!sp->autoconf && sp->nsubnodes > 1)
-		writel(2, sp->base + SIERRA_PHY_PLL_CFG);
+		regmap_field_write(sp->phy_pll_cfg_1, 0x1);
 
 	pm_runtime_enable(dev);
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
@@ -364,6 +543,8 @@ static struct cdns_reg_pairs cdns_pcie_regs[] = {
 
 static const struct cdns_sierra_data cdns_map_sierra = {
 	SIERRA_MACRO_ID,
+	0x2,
+	0x2,
 	ARRAY_SIZE(cdns_pcie_regs),
 	ARRAY_SIZE(cdns_usb_regs),
 	cdns_pcie_regs,
-- 
2.17.1

