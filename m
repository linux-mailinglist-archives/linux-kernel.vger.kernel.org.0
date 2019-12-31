Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2274312D7F0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 11:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfLaK3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Dec 2019 05:29:38 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:60231 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727122AbfLaK3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 05:29:33 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 31 Dec 2019 12:29:26 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xBVATJ7d008518;
        Tue, 31 Dec 2019 12:29:26 +0200
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v1 6/9] platform/x86: mlx-platform: Add support for new system type
Date:   Tue, 31 Dec 2019 10:29:14 +0000
Message-Id: <20191231102917.24181-7-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191231102917.24181-1-vadimp@mellanox.com>
References: <20191231102917.24181-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for new Mellanox system types of basic class VMOD0009,
containing Mellanox systems equipped with the switch devices
Spectrum 1 (32x100GbE Ethernet switch) and Switch-IB/Switch-IB2
(36x100Gbe InfiniBand switch).
These are the Top of the Rack system, equipped with Mellanox Comex
card.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/x86/mlx-platform.c | 241 +++++++++++++++++++++++++++++++++++-
 1 file changed, 239 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index 0a41668b1587..31c04ee53989 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -48,6 +48,8 @@
 #define MLXPLAT_CPLD_LPC_REG_AGGRLO_MASK_OFFSET	0x41
 #define MLXPLAT_CPLD_LPC_REG_AGGRCO_OFFSET	0x42
 #define MLXPLAT_CPLD_LPC_REG_AGGRCO_MASK_OFFSET	0x43
+#define MLXPLAT_CPLD_LPC_REG_AGGRCX_OFFSET	0x44
+#define MLXPLAT_CPLD_LPC_REG_AGGRCX_MASK_OFFSET 0x45
 #define MLXPLAT_CPLD_LPC_REG_ASIC_HEALTH_OFFSET 0x50
 #define MLXPLAT_CPLD_LPC_REG_ASIC_EVENT_OFFSET	0x51
 #define MLXPLAT_CPLD_LPC_REG_ASIC_MASK_OFFSET	0x52
@@ -93,6 +95,7 @@
 #define MLXPLAT_CPLD_LPC_IO_RANGE		0x100
 #define MLXPLAT_CPLD_LPC_I2C_CH1_OFF		0xdb
 #define MLXPLAT_CPLD_LPC_I2C_CH2_OFF		0xda
+#define MLXPLAT_CPLD_LPC_I2C_CH3_OFF		0xdc
 
 #define MLXPLAT_CPLD_LPC_PIO_OFFSET		0x10000UL
 #define MLXPLAT_CPLD_LPC_REG1	((MLXPLAT_CPLD_LPC_REG_BASE_ADRR + \
@@ -101,6 +104,9 @@
 #define MLXPLAT_CPLD_LPC_REG2	((MLXPLAT_CPLD_LPC_REG_BASE_ADRR + \
 				  MLXPLAT_CPLD_LPC_I2C_CH2_OFF) | \
 				  MLXPLAT_CPLD_LPC_PIO_OFFSET)
+#define MLXPLAT_CPLD_LPC_REG3	((MLXPLAT_CPLD_LPC_REG_BASE_ADRR + \
+				  MLXPLAT_CPLD_LPC_I2C_CH3_OFF) | \
+				  MLXPLAT_CPLD_LPC_PIO_OFFSET)
 
 /* Masks for aggregation, psu, pwr and fan event in CPLD related registers. */
 #define MLXPLAT_CPLD_AGGR_ASIC_MASK_DEF	0x04
@@ -124,11 +130,18 @@
 #define MLXPLAT_CPLD_LED_HI_NIBBLE_MASK	GENMASK(3, 0)
 #define MLXPLAT_CPLD_VOLTREG_UPD_MASK	GENMASK(5, 4)
 
+/* Masks for aggregation for comex carriers */
+#define MLXPLAT_CPLD_AGGR_MASK_CARRIER	BIT(1)
+#define MLXPLAT_CPLD_AGGR_MASK_CARR_DEF	(MLXPLAT_CPLD_AGGR_ASIC_MASK_DEF | \
+					 MLXPLAT_CPLD_AGGR_MASK_CARRIER)
+#define MLXPLAT_CPLD_LOW_AGGRCX_MASK	0xc1
+
 /* Default I2C parent bus number */
 #define MLXPLAT_CPLD_PHYS_ADAPTER_DEF_NR	1
 
 /* Maximum number of possible physical buses equipped on system */
 #define MLXPLAT_CPLD_MAX_PHYS_ADAPTER_NUM	16
+#define MLXPLAT_CPLD_MAX_PHYS_EXT_ADAPTER_NUM	24
 
 /* Number of channels in group */
 #define MLXPLAT_CPLD_GRP_CHNL_NUM		8
@@ -136,9 +149,10 @@
 /* Start channel numbers */
 #define MLXPLAT_CPLD_CH1			2
 #define MLXPLAT_CPLD_CH2			10
+#define MLXPLAT_CPLD_CH3			18
 
 /* Number of LPC attached MUX platform devices */
-#define MLXPLAT_CPLD_LPC_MUX_DEVS		2
+#define MLXPLAT_CPLD_LPC_MUX_DEVS		3
 
 /* Hotplug devices adapter numbers */
 #define MLXPLAT_CPLD_NR_NONE			-1
@@ -244,6 +258,35 @@ static int mlxplat_max_adap_num;
 static int mlxplat_mux_num;
 static struct i2c_mux_reg_platform_data *mlxplat_mux_data;
 
+/* Platform extended mux data */
+static struct i2c_mux_reg_platform_data mlxplat_extended_mux_data[] = {
+	{
+		.parent = 1,
+		.base_nr = MLXPLAT_CPLD_CH1,
+		.write_only = 1,
+		.reg = (void __iomem *)MLXPLAT_CPLD_LPC_REG1,
+		.reg_size = 1,
+		.idle_in_use = 1,
+	},
+	{
+		.parent = 1,
+		.base_nr = MLXPLAT_CPLD_CH2,
+		.write_only = 1,
+		.reg = (void __iomem *)MLXPLAT_CPLD_LPC_REG3,
+		.reg_size = 1,
+		.idle_in_use = 1,
+	},
+	{
+		.parent = 1,
+		.base_nr = MLXPLAT_CPLD_CH3,
+		.write_only = 1,
+		.reg = (void __iomem *)MLXPLAT_CPLD_LPC_REG2,
+		.reg_size = 1,
+		.idle_in_use = 1,
+	},
+
+};
+
 /* Platform hotplug devices */
 static struct i2c_board_info mlxplat_mlxcpld_psu[] = {
 	{
@@ -287,6 +330,22 @@ static struct i2c_board_info mlxplat_mlxcpld_fan[] = {
 	},
 };
 
+/* Platform hotplug comex carrier system family data */
+static struct mlxreg_core_data mlxplat_mlxcpld_comex_psu_items_data[] = {
+	{
+		.label = "psu1",
+		.reg = MLXPLAT_CPLD_LPC_REG_PSU_OFFSET,
+		.mask = BIT(0),
+		.hpdev.nr = MLXPLAT_CPLD_NR_NONE,
+	},
+	{
+		.label = "psu2",
+		.reg = MLXPLAT_CPLD_LPC_REG_PSU_OFFSET,
+		.mask = BIT(1),
+		.hpdev.nr = MLXPLAT_CPLD_NR_NONE,
+	},
+};
+
 /* Platform hotplug default data */
 static struct mlxreg_core_data mlxplat_mlxcpld_default_psu_items_data[] = {
 	{
@@ -401,6 +460,45 @@ static struct mlxreg_core_item mlxplat_mlxcpld_default_items[] = {
 	},
 };
 
+static struct mlxreg_core_item mlxplat_mlxcpld_comex_items[] = {
+	{
+		.data = mlxplat_mlxcpld_comex_psu_items_data,
+		.aggr_mask = MLXPLAT_CPLD_AGGR_MASK_CARRIER,
+		.reg = MLXPLAT_CPLD_LPC_REG_PSU_OFFSET,
+		.mask = MLXPLAT_CPLD_PSU_MASK,
+		.count = ARRAY_SIZE(mlxplat_mlxcpld_psu),
+		.inversed = 1,
+		.health = false,
+	},
+	{
+		.data = mlxplat_mlxcpld_default_pwr_items_data,
+		.aggr_mask = MLXPLAT_CPLD_AGGR_MASK_CARRIER,
+		.reg = MLXPLAT_CPLD_LPC_REG_PWR_OFFSET,
+		.mask = MLXPLAT_CPLD_PWR_MASK,
+		.count = ARRAY_SIZE(mlxplat_mlxcpld_pwr),
+		.inversed = 0,
+		.health = false,
+	},
+	{
+		.data = mlxplat_mlxcpld_default_fan_items_data,
+		.aggr_mask = MLXPLAT_CPLD_AGGR_MASK_CARRIER,
+		.reg = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
+		.mask = MLXPLAT_CPLD_FAN_MASK,
+		.count = ARRAY_SIZE(mlxplat_mlxcpld_fan),
+		.inversed = 1,
+		.health = false,
+	},
+	{
+		.data = mlxplat_mlxcpld_default_asic_items_data,
+		.aggr_mask = MLXPLAT_CPLD_AGGR_ASIC_MASK_DEF,
+		.reg = MLXPLAT_CPLD_LPC_REG_ASIC_HEALTH_OFFSET,
+		.mask = MLXPLAT_CPLD_ASIC_MASK,
+		.count = ARRAY_SIZE(mlxplat_mlxcpld_default_asic_items_data),
+		.inversed = 0,
+		.health = true,
+	},
+};
+
 static
 struct mlxreg_core_hotplug_platform_data mlxplat_mlxcpld_default_data = {
 	.items = mlxplat_mlxcpld_default_items,
@@ -411,6 +509,16 @@ struct mlxreg_core_hotplug_platform_data mlxplat_mlxcpld_default_data = {
 	.mask_low = MLXPLAT_CPLD_LOW_AGGR_MASK_LOW,
 };
 
+static
+struct mlxreg_core_hotplug_platform_data mlxplat_mlxcpld_comex_data = {
+	.items = mlxplat_mlxcpld_comex_items,
+	.counter = ARRAY_SIZE(mlxplat_mlxcpld_comex_items),
+	.cell = MLXPLAT_CPLD_LPC_REG_AGGR_OFFSET,
+	.mask = MLXPLAT_CPLD_AGGR_MASK_CARR_DEF,
+	.cell_low = MLXPLAT_CPLD_LPC_REG_AGGRCX_OFFSET,
+	.mask_low = MLXPLAT_CPLD_LOW_AGGRCX_MASK,
+};
+
 static struct mlxreg_core_data mlxplat_mlxcpld_msn21xx_pwr_items_data[] = {
 	{
 		.label = "pwr1",
@@ -975,6 +1083,80 @@ static struct mlxreg_core_platform_data mlxplat_default_ng_led_data = {
 		.counter = ARRAY_SIZE(mlxplat_mlxcpld_default_ng_led_data),
 };
 
+/* Platform led for Comex based 100GbE systems */
+static struct mlxreg_core_data mlxplat_mlxcpld_comex_100G_led_data[] = {
+	{
+		.label = "status:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED1_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "status:red",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED1_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK
+	},
+	{
+		.label = "psu:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED1_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "psu:red",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED1_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "fan1:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED2_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "fan1:red",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED2_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "fan2:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED2_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "fan2:red",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED2_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "fan3:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED3_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "fan3:red",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED3_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+	{
+		.label = "fan4:green",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED3_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "fan4:red",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED3_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_HI_NIBBLE_MASK,
+	},
+	{
+		.label = "uid:blue",
+		.reg = MLXPLAT_CPLD_LPC_REG_LED5_OFFSET,
+		.mask = MLXPLAT_CPLD_LED_LO_NIBBLE_MASK,
+	},
+};
+
+static struct mlxreg_core_platform_data mlxplat_comex_100G_led_data = {
+		.data = mlxplat_mlxcpld_comex_100G_led_data,
+		.counter = ARRAY_SIZE(mlxplat_mlxcpld_comex_100G_led_data),
+};
+
 /* Platform register access default */
 static struct mlxreg_core_data mlxplat_mlxcpld_default_regs_io_data[] = {
 	{
@@ -1661,6 +1843,7 @@ static bool mlxplat_mlxcpld_writeable_reg(struct device *dev, unsigned int reg)
 	case MLXPLAT_CPLD_LPC_REG_AGGR_MASK_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGRLO_MASK_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGRCO_MASK_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_AGGRCX_MASK_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_ASIC_EVENT_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_ASIC_MASK_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_PSU_EVENT_OFFSET:
@@ -1712,6 +1895,8 @@ static bool mlxplat_mlxcpld_readable_reg(struct device *dev, unsigned int reg)
 	case MLXPLAT_CPLD_LPC_REG_AGGRLO_MASK_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGRCO_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGRCO_MASK_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_AGGRCX_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_AGGRCX_MASK_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_ASIC_HEALTH_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_ASIC_EVENT_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_ASIC_MASK_OFFSET:
@@ -1786,6 +1971,8 @@ static bool mlxplat_mlxcpld_volatile_reg(struct device *dev, unsigned int reg)
 	case MLXPLAT_CPLD_LPC_REG_AGGRLO_MASK_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGRCO_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGRCO_MASK_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_AGGRCX_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_AGGRCX_MASK_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_ASIC_HEALTH_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_ASIC_EVENT_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_ASIC_MASK_OFFSET:
@@ -1840,6 +2027,12 @@ static const struct reg_default mlxplat_mlxcpld_regmap_ng[] = {
 	{ MLXPLAT_CPLD_LPC_REG_WD_CLEAR_WP_OFFSET, 0x00 },
 };
 
+static const struct reg_default mlxplat_mlxcpld_regmap_comex_default[] = {
+	{ MLXPLAT_CPLD_LPC_REG_AGGRCX_MASK_OFFSET,
+	  MLXPLAT_CPLD_LOW_AGGRCX_MASK },
+	{ MLXPLAT_CPLD_LPC_REG_PWM_CONTROL_OFFSET, 0x00 },
+};
+
 struct mlxplat_mlxcpld_regmap_context {
 	void __iomem *base;
 };
@@ -1892,6 +2085,20 @@ static const struct regmap_config mlxplat_mlxcpld_regmap_config_ng = {
 	.reg_write = mlxplat_mlxcpld_reg_write,
 };
 
+static const struct regmap_config mlxplat_mlxcpld_regmap_config_comex = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 255,
+	.cache_type = REGCACHE_FLAT,
+	.writeable_reg = mlxplat_mlxcpld_writeable_reg,
+	.readable_reg = mlxplat_mlxcpld_readable_reg,
+	.volatile_reg = mlxplat_mlxcpld_volatile_reg,
+	.reg_defaults = mlxplat_mlxcpld_regmap_comex_default,
+	.num_reg_defaults = ARRAY_SIZE(mlxplat_mlxcpld_regmap_comex_default),
+	.reg_read = mlxplat_mlxcpld_reg_read,
+	.reg_write = mlxplat_mlxcpld_reg_write,
+};
+
 static struct resource mlxplat_mlxcpld_resources[] = {
 	[0] = DEFINE_RES_IRQ_NAMED(17, "mlxreg-hotplug"),
 };
@@ -2018,7 +2225,31 @@ static int __init mlxplat_dmi_qmb7xx_matched(const struct dmi_system_id *dmi)
 	mlxplat_regmap_config = &mlxplat_mlxcpld_regmap_config_ng;
 
 	return 1;
-};
+}
+
+static int __init mlxplat_dmi_comex_matched(const struct dmi_system_id *dmi)
+{
+	int i;
+
+	mlxplat_max_adap_num = MLXPLAT_CPLD_MAX_PHYS_EXT_ADAPTER_NUM;
+	mlxplat_mux_num = ARRAY_SIZE(mlxplat_extended_mux_data);
+	mlxplat_mux_data = mlxplat_extended_mux_data;
+	for (i = 0; i < mlxplat_mux_num; i++) {
+		mlxplat_mux_data[i].values = mlxplat_msn21xx_channels;
+		mlxplat_mux_data[i].n_values =
+				ARRAY_SIZE(mlxplat_msn21xx_channels);
+	}
+	mlxplat_hotplug = &mlxplat_mlxcpld_comex_data;
+	mlxplat_hotplug->deferred_nr = MLXPLAT_CPLD_MAX_PHYS_EXT_ADAPTER_NUM;
+	mlxplat_led = &mlxplat_comex_100G_led_data;
+	mlxplat_regs_io = &mlxplat_default_ng_regs_io_data;
+	mlxplat_fan = &mlxplat_default_fan_data;
+	for (i = 0; i < ARRAY_SIZE(mlxplat_mlxcpld_wd_set_type2); i++)
+		mlxplat_wd_data[i] = &mlxplat_mlxcpld_wd_set_type2[i];
+	mlxplat_regmap_config = &mlxplat_mlxcpld_regmap_config_comex;
+
+	return 1;
+}
 
 static const struct dmi_system_id mlxplat_dmi_table[] __initconst = {
 	{
@@ -2058,6 +2289,12 @@ static const struct dmi_system_id mlxplat_dmi_table[] __initconst = {
 		},
 	},
 	{
+		.callback = mlxplat_dmi_comex_matched,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "VMOD0009"),
+		},
+	},
+	{
 		.callback = mlxplat_dmi_msn274x_matched,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Mellanox Technologies"),
-- 
2.11.0

