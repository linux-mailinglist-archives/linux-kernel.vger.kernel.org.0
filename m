Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D62F4136172
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 20:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbgAITx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 14:53:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41192 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730498AbgAITx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:53:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so8714393wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 11:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LBdA2cAlniiYKqy+PseSpIbr7B+It1AjSK38CMoR1rc=;
        b=okI7vhRmr1LEAeyLsS+nhTCHeYkSYxr7oAmLwmZVotW6yV5nDuwiLXIf9NB+iPULzg
         KRias+Lclxou2GFWSG2FZOal/D0Kq/evR5RNIZPRQS1BdLYzUwtgmsSXxnxc5eyV9tsF
         wMGGqujoVVSHDqsZZe7vZSYl/kGEOCWeOALrIWmwDa0lsCFgC0cq3nPvhMf0LqqLNQlU
         cqy9o4IlwJZd4fPEzZLC55n0OcbikCheE96Ihc3+bYof15sl1Eu7JnfXspb4nOrAM3e5
         Ol3RqCZv2yQlY9e5RopAPUywjzsMBt4jb5Z5IBe6B5G7vFa51L8vhhm6txmAh6X/EbHt
         BIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LBdA2cAlniiYKqy+PseSpIbr7B+It1AjSK38CMoR1rc=;
        b=Co/xuAaK5eshUkejwuiDr22U7IrXxzKrB1MunM5fm8dR9yV2RnbeizjUVexltAINjc
         94fRBOUDOZgk4UMgqhlxxW3km5X3rGaj19mG901e7bJZY5s2Ja1McRyd+UplcoHd0Aw+
         2Zk7e3w2WfHAP7/gtmbNVvfwqtk7U9KmGfu+Xadb5e6q9gTUVp6jgWRxFxq574aXQI8U
         /UhTymGQPLa7qEdW9Q7PynZYYiKfm5AfuQ32DW5bVBEJ2Ee+DzkEKK3ztxgD91Q3qUWp
         cU+tBUqYO3O0XT5dfBUjjwNhIWwx65nq7A5JvLGvFUA4D/Z9B9OZG3TqDq4Ca9bSwgEy
         9NeA==
X-Gm-Message-State: APjAAAUPEr2eWBVJicLSNX7wZti9wdAfrv5O4Q+EpzkA4pfqVvDFaHox
        Yi3NN1QW9Ykzrxze9ZWR3+417YO1w+Phgg==
X-Google-Smtp-Source: APXvYqyTjXfYhELi1A8Ic4aTHhQFTfCGCOfJtK9pH0NMLLE2V4RUCLn7S53ginw7+hAUBfHEuPXwKQ==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr12311971wrq.37.1578599635627;
        Thu, 09 Jan 2020 11:53:55 -0800 (PST)
Received: from localhost.localdomain (p5B3F655B.dip0.t-ipconnect.de. [91.63.101.91])
        by smtp.gmail.com with ESMTPSA id z11sm9304593wrt.82.2020.01.09.11.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 11:53:54 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v7] regulator: mpq7920: add mpq7920 regulator driver
Date:   Thu,  9 Jan 2020 20:53:46 +0100
Message-Id: <20200109195346.30270-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding regulator driver for the device mpq7920.
The MPQ7920 PMIC device contains four DC-DC buck converters and
five regulators, is designed for automotive and accessed over I2C.

Fixed sparse warning reported on this patch
Reported-by: kbuild test robot <lkp@intel.com>

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---

Notes:
    patch based on -next.

 drivers/regulator/Kconfig   |  10 ++
 drivers/regulator/Makefile  |   1 +
 drivers/regulator/mpq7920.c | 346 ++++++++++++++++++++++++++++++++++++
 drivers/regulator/mpq7920.h |  68 +++++++
 4 files changed, 425 insertions(+)
 create mode 100644 drivers/regulator/mpq7920.c
 create mode 100644 drivers/regulator/mpq7920.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 593733a88a61..9fe2aa9fbbc1 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -623,6 +623,16 @@ config REGULATOR_MP8859
 	  Say M here if you want to include support for the regulator as a
 	  module. The module will be named "mp8859".
 
+config REGULATOR_MPQ7920
+	tristate "Monolithic MPQ7920 PMIC"
+	depends on I2C && OF
+	select REGMAP_I2C
+	help
+	  Say y here to support the MPQ7920 PMIC. This will enable supports
+	  the software controllable 4 buck and 5 LDO regulators.
+	  This driver supports the control of different power rails of device
+	  through regulator interface.
+
 config REGULATOR_MT6311
 	tristate "MediaTek MT6311 PMIC"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 8ba8e5deebbd..b8c9072f8500 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_REGULATOR_MC13892) += mc13892-regulator.o
 obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=  mc13xxx-regulator-core.o
 obj-$(CONFIG_REGULATOR_MCP16502) += mcp16502.o
 obj-$(CONFIG_REGULATOR_MP8859) += mp8859.o
+obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6358)	+= mt6358-regulator.o
diff --git a/drivers/regulator/mpq7920.c b/drivers/regulator/mpq7920.c
new file mode 100644
index 000000000000..c603d60fb87b
--- /dev/null
+++ b/drivers/regulator/mpq7920.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// mpq7920.c  - regulator driver for mps mpq7920
+//
+// Copyright 2019 Monolithic Power Systems, Inc
+//
+// Author: Saravanan Sekar <sravanhome@gmail.com>
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include "mpq7920.h"
+
+#define MPQ7920_BUCK_VOLT_RANGE \
+	((MPQ7920_VOLT_MAX - MPQ7920_BUCK_VOLT_MIN)/MPQ7920_VOLT_STEP + 1)
+#define MPQ7920_LDO_VOLT_RANGE \
+	((MPQ7920_VOLT_MAX - MPQ7920_LDO_VOLT_MIN)/MPQ7920_VOLT_STEP + 1)
+
+#define MPQ7920BUCK(_name, _id, _ilim)					\
+	[MPQ7920_BUCK ## _id] = {					\
+		.id = MPQ7920_BUCK ## _id,				\
+		.name = _name,						\
+		.of_match = _name,					\
+		.regulators_node = "regulators",			\
+		.of_parse_cb = mpq7920_parse_cb,			\
+		.ops = &mpq7920_buck_ops,				\
+		.min_uV = MPQ7920_BUCK_VOLT_MIN,			\
+		.uV_step = MPQ7920_VOLT_STEP,				\
+		.n_voltages = MPQ7920_BUCK_VOLT_RANGE,			\
+		.curr_table = _ilim,					\
+		.n_current_limits = ARRAY_SIZE(_ilim),			\
+		.csel_reg = MPQ7920_BUCK ##_id## _REG_C,		\
+		.csel_mask = MPQ7920_MASK_BUCK_ILIM,			\
+		.enable_reg = MPQ7920_REG_REGULATOR_EN,			\
+		.enable_mask = BIT(MPQ7920_REGULATOR_EN_OFFSET -	\
+					 MPQ7920_BUCK ## _id),		\
+		.vsel_reg = MPQ7920_BUCK ##_id## _REG_A,		\
+		.vsel_mask = MPQ7920_MASK_VREF,				\
+		.active_discharge_on	= MPQ7920_DISCHARGE_ON,		\
+		.active_discharge_reg	= MPQ7920_BUCK ##_id## _REG_B,	\
+		.active_discharge_mask	= MPQ7920_MASK_DISCHARGE,	\
+		.soft_start_reg		= MPQ7920_BUCK ##_id## _REG_C,	\
+		.soft_start_mask	= MPQ7920_MASK_SOFTSTART,	\
+		.owner			= THIS_MODULE,			\
+	}
+
+#define MPQ7920LDO(_name, _id, _ops, _ilim, _ilim_sz, _creg, _cmask)	\
+	[MPQ7920_LDO ## _id] = {					\
+		.id = MPQ7920_LDO ## _id,				\
+		.name = _name,						\
+		.of_match = _name,					\
+		.regulators_node = "regulators",			\
+		.ops = _ops,						\
+		.min_uV = MPQ7920_LDO_VOLT_MIN,				\
+		.uV_step = MPQ7920_VOLT_STEP,				\
+		.n_voltages = MPQ7920_LDO_VOLT_RANGE,			\
+		.vsel_reg = MPQ7920_LDO ##_id## _REG_A,			\
+		.vsel_mask = MPQ7920_MASK_VREF,				\
+		.curr_table = _ilim,					\
+		.n_current_limits = _ilim_sz,				\
+		.csel_reg = _creg,					\
+		.csel_mask = _cmask,					\
+		.enable_reg = (_id == 1) ? 0 : MPQ7920_REG_REGULATOR_EN,\
+		.enable_mask = BIT(MPQ7920_REGULATOR_EN_OFFSET -	\
+					MPQ7920_LDO ##_id + 1),		\
+		.active_discharge_on	= MPQ7920_DISCHARGE_ON,		\
+		.active_discharge_mask	= MPQ7920_MASK_DISCHARGE,	\
+		.active_discharge_reg	= MPQ7920_LDO ##_id## _REG_B,	\
+		.type			= REGULATOR_VOLTAGE,		\
+		.owner			= THIS_MODULE,			\
+	}
+
+enum mpq7920_regulators {
+	MPQ7920_BUCK1,
+	MPQ7920_BUCK2,
+	MPQ7920_BUCK3,
+	MPQ7920_BUCK4,
+	MPQ7920_LDO1, /* LDORTC */
+	MPQ7920_LDO2,
+	MPQ7920_LDO3,
+	MPQ7920_LDO4,
+	MPQ7920_LDO5,
+	MPQ7920_MAX_REGULATORS,
+};
+
+struct mpq7920_regulator_info {
+	struct device *dev;
+	struct regmap *regmap;
+	struct regulator_dev *rdev[MPQ7920_MAX_REGULATORS];
+	struct regulator_desc *rdesc;
+};
+
+static const struct regmap_config mpq7920_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x25,
+};
+
+/* Current limits array (in uA)
+ * ILIM1 & ILIM3
+ */
+static const unsigned int mpq7920_I_limits1[] = {
+	4600000, 6600000, 7600000, 9300000
+};
+
+/* ILIM2 & ILIM4 */
+static const unsigned int mpq7920_I_limits2[] = {
+	2700000, 3900000, 5100000, 6100000
+};
+
+/* LDO4 & LDO5 */
+static const unsigned int mpq7920_I_limits3[] = {
+	300000, 700000
+};
+
+static int mpq7920_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay);
+static int mpq7920_parse_cb(struct device_node *np,
+				const struct regulator_desc *rdesc,
+				struct regulator_config *config);
+
+/* RTCLDO not controllable, always ON */
+static const struct regulator_ops mpq7920_ldortc_ops = {
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+};
+
+static const struct regulator_ops mpq7920_ldo_wo_current_ops = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.set_active_discharge	= regulator_set_active_discharge_regmap,
+};
+
+static const struct regulator_ops mpq7920_ldo_ops = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.set_active_discharge	= regulator_set_active_discharge_regmap,
+	.get_current_limit	= regulator_get_current_limit_regmap,
+	.set_current_limit	= regulator_set_current_limit_regmap,
+};
+
+static const struct regulator_ops mpq7920_buck_ops = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.set_active_discharge	= regulator_set_active_discharge_regmap,
+	.set_soft_start		= regulator_set_soft_start_regmap,
+	.set_ramp_delay		= mpq7920_set_ramp_delay,
+};
+
+static struct regulator_desc mpq7920_regulators_desc[MPQ7920_MAX_REGULATORS] = {
+	MPQ7920BUCK("buck1", 1, mpq7920_I_limits1),
+	MPQ7920BUCK("buck2", 2, mpq7920_I_limits2),
+	MPQ7920BUCK("buck3", 3, mpq7920_I_limits1),
+	MPQ7920BUCK("buck4", 4, mpq7920_I_limits2),
+	MPQ7920LDO("ldortc", 1, &mpq7920_ldortc_ops, NULL, 0, 0, 0),
+	MPQ7920LDO("ldo2", 2, &mpq7920_ldo_wo_current_ops, NULL, 0, 0, 0),
+	MPQ7920LDO("ldo3", 3, &mpq7920_ldo_wo_current_ops, NULL, 0, 0, 0),
+	MPQ7920LDO("ldo4", 4, &mpq7920_ldo_ops, mpq7920_I_limits3,
+			ARRAY_SIZE(mpq7920_I_limits3), MPQ7920_LDO4_REG_B,
+			MPQ7920_MASK_LDO_ILIM),
+	MPQ7920LDO("ldo5", 5, &mpq7920_ldo_ops, mpq7920_I_limits3,
+			ARRAY_SIZE(mpq7920_I_limits3), MPQ7920_LDO5_REG_B,
+			MPQ7920_MASK_LDO_ILIM),
+};
+
+/*
+ * DVS ramp rate BUCK1 to BUCK4
+ * 00-01: Reserved
+ * 10: 8mV/us
+ * 11: 4mV/us
+ */
+static int mpq7920_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
+{
+	unsigned int ramp_val;
+
+	if (ramp_delay > 8000 || ramp_delay < 0)
+		return -EINVAL;
+
+	if (ramp_delay <= 4000)
+		ramp_val = 3;
+	else
+		ramp_val = 2;
+
+	return regmap_update_bits(rdev->regmap, MPQ7920_REG_CTL0,
+				  MPQ7920_MASK_DVS_SLEWRATE, ramp_val << 6);
+}
+
+static int mpq7920_parse_cb(struct device_node *np,
+				const struct regulator_desc *desc,
+				struct regulator_config *config)
+{
+	uint8_t val;
+	int ret;
+	struct mpq7920_regulator_info *info = config->driver_data;
+	struct regulator_desc *rdesc = &info->rdesc[desc->id];
+
+	if (of_property_read_bool(np, "mps,buck-ovp-disable")) {
+		regmap_update_bits(config->regmap,
+				MPQ7920_BUCK1_REG_B + (rdesc->id * 4),
+				BIT(6), ~BIT(6));
+	}
+
+	ret = of_property_read_u8(np, "mps,buck-phase-delay", &val);
+	if (!ret) {
+		regmap_update_bits(config->regmap,
+				MPQ7920_BUCK1_REG_C + (rdesc->id * 4),
+				MPQ7920_MASK_BUCK_PHASE_DEALY,
+				(val & 3) << 4);
+	}
+
+	ret = of_property_read_u8(np, "mps,buck-softstart", &val);
+	if (!ret)
+		rdesc->soft_start_val_on = (val & 3) << 2;
+
+	return 0;
+}
+
+static void mpq7920_parse_dt(struct device *dev,
+		 struct mpq7920_regulator_info *info)
+{
+	int ret;
+	struct device_node *np = dev->of_node;
+	uint8_t freq;
+
+	np = of_get_child_by_name(np, "regulators");
+	if (!np) {
+		dev_err(dev, "missing 'regulators' subnode in DT\n");
+		return;
+	}
+
+	ret = of_property_read_u8(np, "mps,switch-freq", &freq);
+	if (!ret) {
+		regmap_update_bits(info->regmap, MPQ7920_REG_CTL0,
+					MPQ7920_MASK_SWITCH_FREQ,
+					(freq & 3) << 4);
+	}
+
+	of_node_put(np);
+}
+
+static inline int mpq7920_regulator_register(
+				struct mpq7920_regulator_info *info,
+				struct regulator_config *config)
+{
+	int i;
+	struct regulator_desc *rdesc;
+
+	for (i = 0; i < MPQ7920_MAX_REGULATORS; i++) {
+		rdesc = &info->rdesc[i];
+
+		info->rdev[i] = devm_regulator_register(info->dev, rdesc,
+					 config);
+		if (IS_ERR(info->rdev))
+			return PTR_ERR(info->rdev);
+	}
+
+	return 0;
+}
+
+static int mpq7920_i2c_probe(struct i2c_client *client,
+				    const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct mpq7920_regulator_info *info;
+	struct regulator_config config = { NULL, };
+	struct regmap *regmap;
+	int ret;
+
+	info = devm_kzalloc(dev, sizeof(struct mpq7920_regulator_info),
+				GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->dev = dev;
+	info->rdesc = mpq7920_regulators_desc;
+	regmap = devm_regmap_init_i2c(client, &mpq7920_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to allocate regmap!\n");
+		return PTR_ERR(regmap);
+	}
+
+	i2c_set_clientdata(client, info);
+	info->regmap = regmap;
+	if (client->dev.of_node)
+		mpq7920_parse_dt(&client->dev, info);
+
+	config.dev = info->dev;
+	config.regmap = regmap;
+	config.driver_data = info;
+
+	ret = mpq7920_regulator_register(info, &config);
+	if (ret < 0)
+		dev_err(dev, "Failed to register regulator!\n");
+
+	return ret;
+}
+
+static const struct of_device_id mpq7920_of_match[] = {
+	{ .compatible = "mps,mpq7920"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mpq7920_of_match);
+
+static const struct i2c_device_id mpq7920_id[] = {
+	{ "mpq7920", },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, mpq7920_id);
+
+static struct i2c_driver mpq7920_regulator_driver = {
+	.driver = {
+		.name = "mpq7920",
+		.of_match_table = of_match_ptr(mpq7920_of_match),
+	},
+	.probe = mpq7920_i2c_probe,
+	.id_table = mpq7920_id,
+};
+module_i2c_driver(mpq7920_regulator_driver);
+
+MODULE_AUTHOR("Saravanan Sekar <sravanhome@gmail.com>");
+MODULE_DESCRIPTION("MPQ7920 PMIC regulator driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/mpq7920.h b/drivers/regulator/mpq7920.h
new file mode 100644
index 000000000000..6a93bfbc750c
--- /dev/null
+++ b/drivers/regulator/mpq7920.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * mpq7920.h  -  Regulator definitions for mpq7920
+ *
+ * Copyright 2019 Monolithic Power Systems, Inc
+ *
+ */
+
+#ifndef __MPQ7920_H__
+#define __MPQ7920_H__
+
+#define MPQ7920_REG_CTL0		0x00
+#define MPQ7920_REG_CTL1		0x01
+#define MPQ7920_REG_CTL2		0x02
+#define MPQ7920_BUCK1_REG_A		0x03
+#define MPQ7920_BUCK1_REG_B		0x04
+#define MPQ7920_BUCK1_REG_C		0x05
+#define MPQ7920_BUCK1_REG_D		0x06
+#define MPQ7920_BUCK2_REG_A		0x07
+#define MPQ7920_BUCK2_REG_B		0x08
+#define MPQ7920_BUCK2_REG_C		0x09
+#define MPQ7920_BUCK2_REG_D		0x0a
+#define MPQ7920_BUCK3_REG_A		0x0b
+#define MPQ7920_BUCK3_REG_B		0x0c
+#define MPQ7920_BUCK3_REG_C		0x0d
+#define MPQ7920_BUCK3_REG_D		0x0e
+#define MPQ7920_BUCK4_REG_A		0x0f
+#define MPQ7920_BUCK4_REG_B		0x10
+#define MPQ7920_BUCK4_REG_C		0x11
+#define MPQ7920_BUCK4_REG_D		0x12
+#define MPQ7920_LDO1_REG_A		0x13
+#define MPQ7920_LDO1_REG_B		0x0
+#define MPQ7920_LDO2_REG_A		0x14
+#define MPQ7920_LDO2_REG_B		0x15
+#define MPQ7920_LDO2_REG_C		0x16
+#define MPQ7920_LDO3_REG_A		0x17
+#define MPQ7920_LDO3_REG_B		0x18
+#define MPQ7920_LDO3_REG_C		0x19
+#define MPQ7920_LDO4_REG_A		0x1a
+#define MPQ7920_LDO4_REG_B		0x1b
+#define MPQ7920_LDO4_REG_C		0x1c
+#define MPQ7920_LDO5_REG_A		0x1d
+#define MPQ7920_LDO5_REG_B		0x1e
+#define MPQ7920_LDO5_REG_C		0x1f
+#define MPQ7920_REG_MODE		0x20
+#define MPQ7920_REG_REGULATOR_EN1	0x22
+#define MPQ7920_REG_REGULATOR_EN	0x22
+
+#define MPQ7920_MASK_VREF		0x7f
+#define MPQ7920_MASK_BUCK_ILIM		0xd0
+#define MPQ7920_MASK_LDO_ILIM		BIT(6)
+#define MPQ7920_MASK_DISCHARGE		BIT(5)
+#define MPQ7920_MASK_MODE		0xc0
+#define MPQ7920_MASK_SOFTSTART		0x0c
+#define MPQ7920_MASK_SWITCH_FREQ	0x30
+#define MPQ7920_MASK_BUCK_PHASE_DEALY	0x30
+#define MPQ7920_MASK_DVS_SLEWRATE	0xc0
+#define MPQ7920_DISCHARGE_ON		0x1
+
+#define MPQ7920_REGULATOR_EN_OFFSET	7
+
+/* values in mV */
+#define MPQ7920_BUCK_VOLT_MIN		400000
+#define MPQ7920_LDO_VOLT_MIN		650000
+#define MPQ7920_VOLT_MAX		3587500
+#define MPQ7920_VOLT_STEP		12500
+
+#endif /* __MPQ7920_H__ */
-- 
2.17.1

