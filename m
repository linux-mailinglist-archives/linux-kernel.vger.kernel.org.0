Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 222F5148400
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 12:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392024AbgAXLjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 06:39:42 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.7]:46547 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391499AbgAXLZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:25:35 -0500
Received: from [46.226.52.108] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-7.bemta.az-a.eu-west-1.aws.symcld.net id E6/F5-00394-C24DA2E5; Fri, 24 Jan 2020 11:25:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRWlGSWpSXmKPExsVy8IPnUV2dK1p
  xBgtmylrc/3qU0eLyrjlsDkwed67tYfP4vEkugCmKNTMvKb8igTXj76JGxoK1IRVz3p9mb2Bs
  9Oxi5OIQEljPKLFuy3/WLkZOIKdComvfGXYQm1cgU2JCVz8jiM0p4C5x8Mlhti5GDqAaN4kVP
  Z4gYTYBC4nJJx6wgdgsAqoSy0+1gY0RFoiTWLluISNIuYiAisS5N+YgJrNAhMSfU8wQwwUlTs
  58wgJiMwtISBx88YIZ4gADidMLGsHiEgL2EtPfX2UGaZUQ0JdoPBYLETaU+D7rGwtE2Fxi7Tq
  vCYyCs5AMnYVk6AJGplWMFklFmekZJbmJmTm6hgYGuoaGRrqGliZA2lQvsUo3US+1VLc8tbhE
  11AvsbxYr7gyNzknRS8vtWQTIzCMUwoOFe9gfPP1rd4hRkkOJiVR3q65WnFCfEn5KZUZicUZ8
  UWlOanFhxhlODiUJHjtLwHlBItS01Mr0jJzgDEFk5bg4FES4fUESfMWFyTmFmemQ6ROMepy7D
  w6bxGzEEtefl6qlDjvbJAiAZCijNI8uBGw+L7EKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZg
  3DWQKT2ZeCdymV0BHMAEd4aIEdkRJIkJKqoGpdf8dx+UZem0eN3PYrov8sfy1xkf+1Hb25dvz
  2I4Xbdht7XM49tuHSOXYC4uU5FztQ5z7Am4fOSeyjOfe1kz9dXKHf5141CCquH/ih/AJ0tbGh
  98838Lsc/BlB9vdVTL5inH2HVOytU9tsZlZenCl1/WiFjFbxlf3rE6fexv8zveD/ZJJKxpOFv
  D5CPlusnAVs+VRbZodcWbiMfFPrV8zJ8aUKsdGOHq8S3k1f2FhpPG6jYcm8Bdntd10q7x6/Kr
  sC/kD5cv9dVy5FiQXCL+OeMJ//t58V56FRypC9gULM92/5PDrsM3CR4JXDxzd1a7J9s34uBx3
  6DNxabWZTroFCcfsv/Q9P1BYcji5J32yEktxRqKhFnNRcSIAi2YiOGoDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-28.tower-272.messagelabs.com!1579865131!1056631!2
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26644 invoked from network); 24 Jan 2020 11:25:32 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-28.tower-272.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 24 Jan 2020 11:25:32 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.468.0; Fri, 24 Jan 2020 11:25:31 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 6C7303FBE5; Fri, 24 Jan 2020 11:25:31 +0000 (GMT)
Message-ID: <c75e6e04281fd8da78cd209a888664c35a6fb8c1.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Fri, 24 Jan 2020 11:25:31 +0000
Subject: [RESEND PATCH 1/2] mfd: da9063: Fix revision handling to correctly select
 reg tables
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 24/01/2020 10:17:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation performs checking in the i2c_probe()
function of the variant_code but does this immediately after the
containing struct has been initialised as all zero. This means the
check for variant code will always default to using the BB tables
and will never select AD. The variant code is subsequently set
by device_init() and later used by the RTC so really it's a little
fortunate this mismatch works.

This update creates an initial temporary regmap instantiation to
simply read the chip and variant/revision information (common to
all revisions) so that it can subsequently correctly choose the
proper regmap tables for real initialisation.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/mfd/da9063-core.c            |  31 -------
 drivers/mfd/da9063-i2c.c             | 167 +++++++++++++++++++++++++++++++----
 include/linux/mfd/da9063/registers.h |  15 ++--
 3 files changed, 160 insertions(+), 53 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index b125f90d..a353d52 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -160,7 +160,6 @@ static int da9063_clear_fault_log(struct da9063 *da9063)
 
 int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 {
-	int model, variant_id, variant_code;
 	int ret;
 
 	ret = da9063_clear_fault_log(da9063);
@@ -171,36 +170,6 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 	da9063->irq_base = -1;
 	da9063->chip_irq = irq;
 
-	ret = regmap_read(da9063->regmap, DA9063_REG_CHIP_ID, &model);
-	if (ret < 0) {
-		dev_err(da9063->dev, "Cannot read chip model id.\n");
-		return -EIO;
-	}
-	if (model != PMIC_CHIP_ID_DA9063) {
-		dev_err(da9063->dev, "Invalid chip model id: 0x%02x\n", model);
-		return -ENODEV;
-	}
-
-	ret = regmap_read(da9063->regmap, DA9063_REG_CHIP_VARIANT, &variant_id);
-	if (ret < 0) {
-		dev_err(da9063->dev, "Cannot read chip variant id.\n");
-		return -EIO;
-	}
-
-	variant_code = variant_id >> DA9063_CHIP_VARIANT_SHIFT;
-
-	dev_info(da9063->dev,
-		 "Device detected (chip-ID: 0x%02X, var-ID: 0x%02X)\n",
-		 model, variant_id);
-
-	if (variant_code < PMIC_DA9063_BB && variant_code != PMIC_DA9063_AD) {
-		dev_err(da9063->dev,
-			"Cannot support variant code: 0x%02X\n", variant_code);
-		return -ENODEV;
-	}
-
-	da9063->variant_code = variant_code;
-
 	ret = da9063_irq_init(da9063);
 	if (ret) {
 		dev_err(da9063->dev, "Cannot initialize interrupts.\n");
diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 455de74..c7f3057 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -22,12 +22,107 @@
 #include <linux/of.h>
 #include <linux/regulator/of_regulator.h>
 
+/*
+ * Temporary regmap config for just accessing chip and variant info before we
+ * know which device is present. The info read from the device using this config
+ * is then used to select the correct regmap tables.
+ */
+
+static const struct regmap_range da9063_tmp_readable_ranges[] = {
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_PAGE_CON),
+	regmap_reg_range(DA9063_REG_DEVICE_ID, DA9063_REG_VARIANT_ID),
+};
+
+static const struct regmap_range da9063_tmp_writeable_ranges[] = {
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_PAGE_CON),
+};
+
+static const struct regmap_access_table da9063_tmp_readable_table = {
+	.yes_ranges = da9063_tmp_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9063_tmp_readable_ranges),
+};
+
+static const struct regmap_access_table da9063_tmp_writeable_table = {
+	.yes_ranges = da9063_tmp_writeable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(da9063_tmp_writeable_ranges),
+};
+
+static const struct regmap_range_cfg da9063_tmp_range_cfg[] = {
+	{
+		.range_min = DA9063_REG_PAGE_CON,
+		.range_max = DA9063_REG_VARIANT_ID,
+		.selector_reg = DA9063_REG_PAGE_CON,
+		.selector_mask = 1 << DA9063_I2C_PAGE_SEL_SHIFT,
+		.selector_shift = DA9063_I2C_PAGE_SEL_SHIFT,
+		.window_start = 0,
+		.window_len = 256,
+	}
+};
+
+static struct regmap_config da9063_tmp_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.ranges = da9063_tmp_range_cfg,
+	.num_ranges = ARRAY_SIZE(da9063_tmp_range_cfg),
+	.max_register = DA9063_REG_VARIANT_ID,
+	.cache_type = REGCACHE_NONE,
+	.rd_table = &da9063_tmp_readable_table,
+	.wr_table = &da9063_tmp_writeable_table,
+};
+
+static int da9063_get_device_type(struct i2c_client *i2c, struct da9063 *da9063)
+{
+	int ret;
+	int device_id, variant_id;
+	struct regmap *tmp_regmap;
+
+	tmp_regmap = regmap_init_i2c(i2c, &da9063_tmp_regmap_config);
+	if (IS_ERR(tmp_regmap)) {
+		dev_err(da9063->dev,
+			"Failed to allocate temporary register map\n");
+		return PTR_ERR(tmp_regmap);
+	}
+
+	ret = regmap_read(tmp_regmap, DA9063_REG_DEVICE_ID, &device_id);
+	if (ret < 0) {
+		dev_err(da9063->dev, "Cannot read chip device id.\n");
+		return -EIO;
+	}
+
+	if (device_id != PMIC_CHIP_ID_DA9063) {
+		dev_err(da9063->dev,
+			"Invalid chip device id: 0x%02x\n", device_id);
+		return -ENODEV;
+	}
+
+	ret = regmap_read(tmp_regmap, DA9063_REG_VARIANT_ID, &variant_id);
+	if (ret < 0) {
+		dev_err(da9063->dev, "Cannot read chip variant id.\n");
+		return -EIO;
+	}
+
+	dev_info(da9063->dev,
+		 "Device detected (chip-ID: 0x%02X, var-ID: 0x%02X)\n",
+		 device_id, variant_id);
+
+	da9063->variant_code = (variant_id & DA9063_VARIANT_ID_MRC_MASK)
+			       >> DA9063_VARIANT_ID_MRC_SHIFT;
+
+	regmap_exit(tmp_regmap);
+
+	return 0;
+}
+
+/*
+ * Variant specific regmap configs
+ */
+
 static const struct regmap_range da9063_ad_readable_ranges[] = {
 	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_AD_REG_SECOND_D),
 	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
 	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
 	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_AD_REG_GP_ID_19),
-	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
+	regmap_reg_range(DA9063_REG_DEVICE_ID, DA9063_REG_VARIANT_ID),
 };
 
 static const struct regmap_range da9063_ad_writeable_ranges[] = {
@@ -72,7 +167,7 @@
 	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
 	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
 	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_BB_REG_GP_ID_19),
-	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
+	regmap_reg_range(DA9063_REG_DEVICE_ID, DA9063_REG_VARIANT_ID),
 };
 
 static const struct regmap_range da9063_bb_writeable_ranges[] = {
@@ -117,7 +212,7 @@
 	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
 	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
 	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_BB_REG_GP_ID_19),
-	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
+	regmap_reg_range(DA9063_REG_DEVICE_ID, DA9063_REG_VARIANT_ID),
 };
 
 static const struct regmap_range da9063l_bb_writeable_ranges[] = {
@@ -159,7 +254,7 @@
 static const struct regmap_range_cfg da9063_range_cfg[] = {
 	{
 		.range_min = DA9063_REG_PAGE_CON,
-		.range_max = DA9063_REG_CHIP_VARIANT,
+		.range_max = DA9063_REG_CONFIG_ID,
 		.selector_reg = DA9063_REG_PAGE_CON,
 		.selector_mask = 1 << DA9063_I2C_PAGE_SEL_SHIFT,
 		.selector_shift = DA9063_I2C_PAGE_SEL_SHIFT,
@@ -173,7 +268,7 @@
 	.val_bits = 8,
 	.ranges = da9063_range_cfg,
 	.num_ranges = ARRAY_SIZE(da9063_range_cfg),
-	.max_register = DA9063_REG_CHIP_VARIANT,
+	.max_register = DA9063_REG_CONFIG_ID,
 
 	.cache_type = REGCACHE_RBTREE,
 };
@@ -199,18 +294,56 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 	da9063->chip_irq = i2c->irq;
 	da9063->type = id->driver_data;
 
-	if (da9063->variant_code == PMIC_DA9063_AD) {
-		da9063_regmap_config.rd_table = &da9063_ad_readable_table;
-		da9063_regmap_config.wr_table = &da9063_ad_writeable_table;
-		da9063_regmap_config.volatile_table = &da9063_ad_volatile_table;
-	} else if (da9063->type == PMIC_TYPE_DA9063L) {
-		da9063_regmap_config.rd_table = &da9063l_bb_readable_table;
-		da9063_regmap_config.wr_table = &da9063l_bb_writeable_table;
-		da9063_regmap_config.volatile_table = &da9063l_bb_volatile_table;
-	} else {
-		da9063_regmap_config.rd_table = &da9063_bb_readable_table;
-		da9063_regmap_config.wr_table = &da9063_bb_writeable_table;
-		da9063_regmap_config.volatile_table = &da9063_bb_volatile_table;
+	ret = da9063_get_device_type(i2c, da9063);
+	if (ret < 0)
+		return ret;
+
+	switch (da9063->type) {
+	case PMIC_TYPE_DA9063:
+		switch (da9063->variant_code) {
+		case PMIC_DA9063_AD:
+			da9063_regmap_config.rd_table =
+				&da9063_ad_readable_table;
+			da9063_regmap_config.wr_table =
+				&da9063_ad_writeable_table;
+			da9063_regmap_config.volatile_table =
+				&da9063_ad_volatile_table;
+			break;
+		case PMIC_DA9063_BB:
+		case PMIC_DA9063_CA:
+			da9063_regmap_config.rd_table =
+				&da9063_bb_readable_table;
+			da9063_regmap_config.wr_table =
+				&da9063_bb_writeable_table;
+			da9063_regmap_config.volatile_table =
+				&da9063_bb_volatile_table;
+			break;
+		default:
+			dev_err(da9063->dev,
+				"Chip variant not supported for DA9063\n");
+			return -ENODEV;
+		}
+		break;
+	case PMIC_TYPE_DA9063L:
+		switch (da9063->variant_code) {
+		case PMIC_DA9063_BB:
+		case PMIC_DA9063_CA:
+			da9063_regmap_config.rd_table =
+				&da9063l_bb_readable_table;
+			da9063_regmap_config.wr_table =
+				&da9063l_bb_writeable_table;
+			da9063_regmap_config.volatile_table =
+				&da9063l_bb_volatile_table;
+			break;
+		default:
+			dev_err(da9063->dev,
+				"Chip variant not supported for DA9063L\n");
+			return -ENODEV;
+		}
+		break;
+	default:
+		dev_err(da9063->dev, "Chip type not supported\n");
+		return -ENODEV;
 	}
 
 	da9063->regmap = devm_regmap_init_i2c(i2c, &da9063_regmap_config);
diff --git a/include/linux/mfd/da9063/registers.h b/include/linux/mfd/da9063/registers.h
index ba706b0..1dbabf1 100644
--- a/include/linux/mfd/da9063/registers.h
+++ b/include/linux/mfd/da9063/registers.h
@@ -292,8 +292,10 @@
 #define	DA9063_BB_REG_GP_ID_19		0x134
 
 /* Chip ID and variant */
-#define	DA9063_REG_CHIP_ID		0x181
-#define	DA9063_REG_CHIP_VARIANT		0x182
+#define	DA9063_REG_DEVICE_ID		0x181
+#define	DA9063_REG_VARIANT_ID		0x182
+#define	DA9063_REG_CUSTOMER_ID		0x183
+#define	DA9063_REG_CONFIG_ID		0x184
 
 /*
  * PMIC registers bits
@@ -929,9 +931,6 @@
 #define	DA9063_RTC_CLOCK			0x40
 #define	DA9063_OUT_32K_EN			0x80
 
-/* DA9063_REG_CHIP_VARIANT */
-#define	DA9063_CHIP_VARIANT_SHIFT		4
-
 /* DA9063_REG_BUCK_ILIM_A (addr=0x9A) */
 #define DA9063_BIO_ILIM_MASK			0x0F
 #define DA9063_BMEM_ILIM_MASK			0xF0
@@ -1065,4 +1064,10 @@
 #define		DA9063_MON_A10_IDX_LDO9		0x04
 #define		DA9063_MON_A10_IDX_LDO10	0x05
 
+/* DA9063_REG_VARIANT_ID (addr=0x182) */
+#define	DA9063_VARIANT_ID_VRC_SHIFT		0
+#define DA9063_VARIANT_ID_VRC_MASK		0x0F
+#define	DA9063_VARIANT_ID_MRC_SHIFT		4
+#define DA9063_VARIANT_ID_MRC_MASK		0xF0
+
 #endif /* _DA9063_REG_H */
-- 
1.9.1

