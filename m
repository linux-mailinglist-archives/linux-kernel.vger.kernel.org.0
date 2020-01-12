Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D34D1138604
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jan 2020 12:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbgALLaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 06:30:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38054 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732675AbgALLaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 06:30:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so5809404wrh.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 03:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSm7IjczDllIQBdzJHpYkk9BizbkbQU1pIXfoPgr3P8=;
        b=jacPjBbxEHLwtLsQ9Yu3llDPqhrqfGzlJ3FxJ1gXzvVFSUDP0GuiKZz+c/haGzZlt7
         2zm8Uun6TsGs05hO6qtIh1X96cHQ6exFf5bZy3c+WEXbfD7AlsnbWe6rv5bsZZ0U2Qci
         6IAYwi1BABW56oH8dWWJUTwHPQalXGvzt87MTWxuA2IvFnKZELiJBRoc17sLfiOdX2OD
         1SkFKAHa9DJ6vd+ucv/MElYfhwEInQUOIHixfnjSOzhhIPxmyAv86DEQ1/K6ojH/VWh/
         OiYDI3wD6G4XGy2JQpqTPighS9SZ8gJ3XDyZKBfiqat31UHa2cJXvbe/yC8qshJjpPmi
         46JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSm7IjczDllIQBdzJHpYkk9BizbkbQU1pIXfoPgr3P8=;
        b=Su9SI5crbGMEYM+jl/7KgKv5segxQmT680qr4JjiZpYE/RkbrpLeOMq6rARsKOJpfH
         zlwl6EnDOp0/uZcCezSkWZoj6VPtbBwhlnDkmiUmzGf8E2Rr50tky0TkGaaWJTKSAkYI
         iaX8ugGIf5ewTmqTdESTVpwQu5jbDgbDcw6bTyvRSUzSEgY8MjgBayjuq9AO1PwnjdK/
         O5AS3Spk9w6j5bL78IKTx31qcUSxgsAjYJLYPdBMAbh6TJcfHOAE+8v4mxEDYliBATuK
         oJkyHqituvri/YThPaV5eVUIObeTRCFpOl26Ger0Ld+oYpaxVB7iGoucPdfYvBHICWp4
         pFgw==
X-Gm-Message-State: APjAAAUns+iaTzokZUITlMBAneCo3QZlKgl4rNSgBAJgviwFrzlMPIZY
        OpdkKaTeg5K0wFXH5WIjhiIZ0w==
X-Google-Smtp-Source: APXvYqxgvliBKMsfF8PC9AKLAdu/jQnRVrYEIQQcHRWHz3Z+MVgU4zeFYlLobc4BQQBrz7edTCsYKQ==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr13088069wrn.384.1578828610872;
        Sun, 12 Jan 2020 03:30:10 -0800 (PST)
Received: from localhost.localdomain (dh207-5-115.xnet.hr. [88.207.5.115])
        by smtp.googlemail.com with ESMTPSA id y17sm9943045wma.36.2020.01.12.03.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 03:30:10 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Mantas Pucka <mantas@8devices.com>
Subject: [PATCH 1/3] regulator: add IPQ4019 SDHCI VQMMC LDO driver
Date:   Sun, 12 Jan 2020 12:30:01 +0100
Message-Id: <20200112113003.11110-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces the IPQ4019 VQMMC LDO driver needed for
the SD/EMMC driver I/O level operation.
This will enable introducing SD/EMMC support for the built-in controller.

Signed-off-by: Mantas Pucka <mantas@8devices.com>
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/regulator/Kconfig                   |   7 ++
 drivers/regulator/Makefile                  |   1 +
 drivers/regulator/vqmmc-ipq4019-regulator.c | 111 ++++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 drivers/regulator/vqmmc-ipq4019-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 3ee63531f6d5..0a91cf1777c5 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1077,6 +1077,13 @@ config REGULATOR_VEXPRESS
 	  This driver provides support for voltage regulators available
 	  on the ARM Ltd's Versatile Express platform.
 
+config REGULATOR_VQMMC_IPQ4019
+	tristate "IPQ4019 VQMMC SD LDO regulator support"
+	depends on ARCH_QCOM
+	help
+	  This driver provides support for the VQMMC LDO I/0
+	  voltage regulator of the IPQ4019 SD/EMMC controller.
+
 config REGULATOR_WM831X
 	tristate "Wolfson Microelectronics WM831x PMIC regulators"
 	depends on MFD_WM831X
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 2210ba56f9bd..59f124afd5f5 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -132,6 +132,7 @@ obj-$(CONFIG_REGULATOR_TWL4030) += twl-regulator.o twl6030-regulator.o
 obj-$(CONFIG_REGULATOR_UNIPHIER) += uniphier-regulator.o
 obj-$(CONFIG_REGULATOR_VCTRL) += vctrl-regulator.o
 obj-$(CONFIG_REGULATOR_VEXPRESS) += vexpress-regulator.o
+obj-$(CONFIG_REGULATOR_VQMMC_IPQ4019) += vqmmc-ipq4019-regulator.o
 obj-$(CONFIG_REGULATOR_WM831X) += wm831x-dcdc.o
 obj-$(CONFIG_REGULATOR_WM831X) += wm831x-isink.o
 obj-$(CONFIG_REGULATOR_WM831X) += wm831x-ldo.o
diff --git a/drivers/regulator/vqmmc-ipq4019-regulator.c b/drivers/regulator/vqmmc-ipq4019-regulator.c
new file mode 100644
index 000000000000..dae16094d3a2
--- /dev/null
+++ b/drivers/regulator/vqmmc-ipq4019-regulator.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2019 Mantas Pucka <mantas@8devices.com>
+// Copyright (c) 2019 Robert Marko <robert.marko@sartura.hr>
+//
+// Driver for IPQ4019 SD/MMC controller's I/O LDO voltage regulator
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+static const unsigned int ipq4019_vmmc_voltages[] = {
+	1500000, 1800000, 2500000, 3000000,
+};
+
+static struct regulator_ops ipq4019_regulator_voltage_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+};
+
+static struct regulator_desc vmmc_regulator = {
+	.name		= "vmmcq",
+	.ops		= &ipq4019_regulator_voltage_ops,
+	.type		= REGULATOR_VOLTAGE,
+	.owner		= THIS_MODULE,
+	.volt_table	= ipq4019_vmmc_voltages,
+	.n_voltages	= ARRAY_SIZE(ipq4019_vmmc_voltages),
+	.vsel_reg	= 0,
+	.vsel_mask	= 0x3,
+};
+
+const struct regmap_config ipq4019_vmmcq_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+};
+
+static int ipq4019_regulator_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regulator_init_data *init_data;
+	struct regulator_config cfg = {};
+	struct regulator_dev *rdev;
+	struct resource *res;
+	struct regmap *rmap;
+	void __iomem *base;
+
+	init_data = of_get_regulator_init_data(dev, dev->of_node,
+					       &vmmc_regulator);
+	if (!init_data)
+		return -EINVAL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	rmap = devm_regmap_init_mmio(dev, base, &ipq4019_vmmcq_regmap_config);
+	if (IS_ERR(rmap))
+		return PTR_ERR(rmap);
+
+	cfg.dev = dev;
+	cfg.init_data = init_data;
+	cfg.of_node = dev->of_node;
+	cfg.regmap = rmap;
+
+	rdev = devm_regulator_register(dev, &vmmc_regulator, &cfg);
+	if (IS_ERR(rdev)) {
+		dev_err(dev, "Failed to register regulator: %ld\n",
+			PTR_ERR(rdev));
+		return PTR_ERR(rdev);
+	}
+	platform_set_drvdata(pdev, rdev);
+
+	return 0;
+}
+
+static int ipq4019_regulator_remove(struct platform_device *pdev)
+{
+	struct regulator_dev *rdev = platform_get_drvdata(pdev);
+
+	regulator_unregister(rdev);
+
+	return 0;
+}
+
+static const struct of_device_id regulator_ipq4019_of_match[] = {
+	{ .compatible = "qcom,vqmmc-ipq4019-regulator", },
+	{},
+};
+
+static struct platform_driver ipq4019_regulator_driver = {
+	.probe = ipq4019_regulator_probe,
+	.remove = ipq4019_regulator_remove,
+	.driver = {
+		.name = "vqmmc-ipq4019-regulator",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(regulator_ipq4019_of_match),
+	},
+};
+module_platform_driver(ipq4019_regulator_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mantas Pucka <mantas@8devices.com>");
+MODULE_DESCRIPTION("IPQ4019 VQMMC voltage regulator");
-- 
2.24.1

