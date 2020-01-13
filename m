Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 792C613963F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 17:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgAMQ2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 11:28:52 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37956 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728942AbgAMQ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:28:48 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 13 Jan 2020 18:28:45 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 00DGSefa032667;
        Mon, 13 Jan 2020 18:28:45 +0200
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v3 05/11] platform/x86: mlx-platform: Add more definitions for system attributes
Date:   Mon, 13 Jan 2020 16:28:33 +0000
Message-Id: <20200113162839.18103-6-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200113162839.18103-1-vadimp@mellanox.com>
References: <20200113162839.18103-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new attributes for "next-generation" type systems:
- Reset cause indication, when system reset has been caused by the
  platform reset request through CPLD, by AC power failure,
  by software power off request through CPLD. by signal asserted by SOC
  through ACPI register. It introduces more reset causes, which can
  be monitored after the reboots.
- Setting and removing system VPD (EEPROM) hardware write protection.
  It allows to access VPD during production cycle and prevents VPD
  corruption on system in field.
- Voltage regulator devices configuration update status and version. It
  allows to monitor configuration update status and current active
  version for such sort of devices.
- PCIe ASIC reset disable - when set ASIC will go down upon PCIe
  root complex reset, otherwise ASIC will stay up during PCIe root
  complex reset.
- System configuration Ids to provide system static topology
  identification, like system's static I2C topology, number and type of
  FPGA devices within the system and so on.

Add the existing attribute for "iio" bank selection for system type
"msn21xx".

All the above attributes are exposed through "sysfs" by "mlxreg-io"
driver.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/x86/mlx-platform.c | 84 +++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index 565a67a65554..7e92dc52071f 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -35,6 +35,8 @@
 #define MLXPLAT_CPLD_LPC_REG_LED4_OFFSET	0x23
 #define MLXPLAT_CPLD_LPC_REG_LED5_OFFSET	0x24
 #define MLXPLAT_CPLD_LPC_REG_FAN_DIRECTION	0x2a
+#define MLXPLAT_CPLD_LPC_REG_GP0_RO_OFFSET	0x2b
+#define MLXPLAT_CPLD_LPC_REG_GP0_OFFSET		0x2e
 #define MLXPLAT_CPLD_LPC_REG_GP1_OFFSET		0x30
 #define MLXPLAT_CPLD_LPC_REG_WP1_OFFSET		0x31
 #define MLXPLAT_CPLD_LPC_REG_GP2_OFFSET		0x32
@@ -68,6 +70,7 @@
 #define MLXPLAT_CPLD_LPC_REG_WD3_TMR_OFFSET	0xd1
 #define MLXPLAT_CPLD_LPC_REG_WD3_TLEFT_OFFSET	0xd2
 #define MLXPLAT_CPLD_LPC_REG_WD3_ACT_OFFSET	0xd3
+#define MLXPLAT_CPLD_LPC_REG_UFM_VERSION_OFFSET	0xe2
 #define MLXPLAT_CPLD_LPC_REG_PWM1_OFFSET	0xe3
 #define MLXPLAT_CPLD_LPC_REG_TACHO1_OFFSET	0xe4
 #define MLXPLAT_CPLD_LPC_REG_TACHO2_OFFSET	0xe5
@@ -85,6 +88,8 @@
 #define MLXPLAT_CPLD_LPC_REG_FAN_CAP2_OFFSET	0xf6
 #define MLXPLAT_CPLD_LPC_REG_FAN_DRW_CAP_OFFSET	0xf7
 #define MLXPLAT_CPLD_LPC_REG_TACHO_SPEED_OFFSET	0xf8
+#define MLXPLAT_CPLD_LPC_REG_CONFIG1_OFFSET	0xfb
+#define MLXPLAT_CPLD_LPC_REG_CONFIG2_OFFSET	0xfc
 #define MLXPLAT_CPLD_LPC_IO_RANGE		0x100
 #define MLXPLAT_CPLD_LPC_I2C_CH1_OFF		0xdb
 #define MLXPLAT_CPLD_LPC_I2C_CH2_OFF		0xda
@@ -117,6 +122,7 @@
 #define MLXPLAT_CPLD_FAN_NG_MASK	GENMASK(5, 0)
 #define MLXPLAT_CPLD_LED_LO_NIBBLE_MASK	GENMASK(7, 4)
 #define MLXPLAT_CPLD_LED_HI_NIBBLE_MASK	GENMASK(3, 0)
+#define MLXPLAT_CPLD_VOLTREG_UPD_MASK	GENMASK(5, 4)
 
 /* Default I2C parent bus number */
 #define MLXPLAT_CPLD_PHYS_ADAPTER_DEF_NR	1
@@ -1157,6 +1163,12 @@ static struct mlxreg_core_data mlxplat_mlxcpld_msn21xx_regs_io_data[] = {
 		.mode = 0200,
 	},
 	{
+		.label = "select_iio",
+		.reg = MLXPLAT_CPLD_LPC_REG_GP2_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(6),
+		.mode = 0644,
+	},
+	{
 		.label = "asic_health",
 		.reg = MLXPLAT_CPLD_LPC_REG_ASIC_HEALTH_OFFSET,
 		.mask = MLXPLAT_CPLD_ASIC_MASK,
@@ -1245,6 +1257,18 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_ng_regs_io_data[] = {
 		.mode = 0444,
 	},
 	{
+		.label = "reset_platform",
+		.reg = MLXPLAT_CPLD_LPC_REG_RST_CAUSE1_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(4),
+		.mode = 0444,
+	},
+	{
+		.label = "reset_soc",
+		.reg = MLXPLAT_CPLD_LPC_REG_RST_CAUSE1_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(5),
+		.mode = 0444,
+	},
+	{
 		.label = "reset_comex_wd",
 		.reg = MLXPLAT_CPLD_LPC_REG_RST_CAUSE1_OFFSET,
 		.mask = GENMASK(7, 0) & ~BIT(6),
@@ -1263,6 +1287,12 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_ng_regs_io_data[] = {
 		.mode = 0444,
 	},
 	{
+		.label = "reset_sw_pwr_off",
+		.reg = MLXPLAT_CPLD_LPC_REG_RST_CAUSE2_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(2),
+		.mode = 0444,
+	},
+	{
 		.label = "reset_comex_thermal",
 		.reg = MLXPLAT_CPLD_LPC_REG_RST_CAUSE2_OFFSET,
 		.mask = GENMASK(7, 0) & ~BIT(3),
@@ -1275,6 +1305,12 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_ng_regs_io_data[] = {
 		.mode = 0444,
 	},
 	{
+		.label = "reset_ac_pwr_fail",
+		.reg = MLXPLAT_CPLD_LPC_REG_RST_CAUSE2_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(6),
+		.mode = 0444,
+	},
+	{
 		.label = "psu1_on",
 		.reg = MLXPLAT_CPLD_LPC_REG_GP1_OFFSET,
 		.mask = GENMASK(7, 0) & ~BIT(0),
@@ -1317,6 +1353,43 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_ng_regs_io_data[] = {
 		.bit = GENMASK(7, 0),
 		.mode = 0444,
 	},
+	{
+		.label = "voltreg_update_status",
+		.reg = MLXPLAT_CPLD_LPC_REG_GP0_RO_OFFSET,
+		.mask = MLXPLAT_CPLD_VOLTREG_UPD_MASK,
+		.bit = 5,
+		.mode = 0444,
+	},
+	{
+		.label = "vpd_wp",
+		.reg = MLXPLAT_CPLD_LPC_REG_GP0_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(3),
+		.mode = 0644,
+	},
+	{
+		.label = "pcie_asic_reset_dis",
+		.reg = MLXPLAT_CPLD_LPC_REG_GP0_OFFSET,
+		.mask = GENMASK(7, 0) & ~BIT(4),
+		.mode = 0644,
+	},
+	{
+		.label = "config1",
+		.reg = MLXPLAT_CPLD_LPC_REG_CONFIG1_OFFSET,
+		.bit = GENMASK(7, 0),
+		.mode = 0444,
+	},
+	{
+		.label = "config2",
+		.reg = MLXPLAT_CPLD_LPC_REG_CONFIG2_OFFSET,
+		.bit = GENMASK(7, 0),
+		.mode = 0444,
+	},
+	{
+		.label = "ufm_version",
+		.reg = MLXPLAT_CPLD_LPC_REG_UFM_VERSION_OFFSET,
+		.bit = GENMASK(7, 0),
+		.mode = 0444,
+	},
 };
 
 static struct mlxreg_core_platform_data mlxplat_default_ng_regs_io_data = {
@@ -1575,6 +1648,7 @@ static bool mlxplat_mlxcpld_writeable_reg(struct device *dev, unsigned int reg)
 	case MLXPLAT_CPLD_LPC_REG_LED3_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_LED4_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_LED5_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_GP0_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_GP1_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_WP1_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_GP2_OFFSET:
@@ -1621,6 +1695,8 @@ static bool mlxplat_mlxcpld_readable_reg(struct device *dev, unsigned int reg)
 	case MLXPLAT_CPLD_LPC_REG_LED4_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_LED5_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_FAN_DIRECTION:
+	case MLXPLAT_CPLD_LPC_REG_GP0_RO_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_GP0_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_GP1_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_WP1_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_GP2_OFFSET:
@@ -1671,6 +1747,9 @@ static bool mlxplat_mlxcpld_readable_reg(struct device *dev, unsigned int reg)
 	case MLXPLAT_CPLD_LPC_REG_FAN_CAP2_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_FAN_DRW_CAP_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_TACHO_SPEED_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CONFIG1_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CONFIG2_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_UFM_VERSION_OFFSET:
 		return true;
 	}
 	return false;
@@ -1692,6 +1771,8 @@ static bool mlxplat_mlxcpld_volatile_reg(struct device *dev, unsigned int reg)
 	case MLXPLAT_CPLD_LPC_REG_LED4_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_LED5_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_FAN_DIRECTION:
+	case MLXPLAT_CPLD_LPC_REG_GP0_RO_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_GP0_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_GP1_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_GP2_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_AGGR_OFFSET:
@@ -1734,6 +1815,9 @@ static bool mlxplat_mlxcpld_volatile_reg(struct device *dev, unsigned int reg)
 	case MLXPLAT_CPLD_LPC_REG_FAN_CAP2_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_FAN_DRW_CAP_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_TACHO_SPEED_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CONFIG1_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CONFIG2_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_UFM_VERSION_OFFSET:
 		return true;
 	}
 	return false;
-- 
2.11.0

