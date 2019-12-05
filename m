Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E28A8113C50
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 08:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfLEH1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 02:27:41 -0500
Received: from inva020.nxp.com ([92.121.34.13]:46896 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfLEH1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 02:27:39 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A65361A0008;
        Thu,  5 Dec 2019 08:27:36 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EE5381A1734;
        Thu,  5 Dec 2019 08:27:31 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 20C3A40296;
        Thu,  5 Dec 2019 15:27:26 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wen He <wen.he_1@nxp.com>
Subject: [v11 2/2] clk: ls1028a: Add clock driver for Display output interface
Date:   Thu,  5 Dec 2019 15:26:53 +0800
Message-Id: <20191205072653.34701-2-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205072653.34701-1-wen.he_1@nxp.com>
References: <20191205072653.34701-1-wen.he_1@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock driver for QorIQ LS1028A Display output interfaces(LCD, DPHY),
as implemented in TSMC CLN28HPM PLL, this PLL supports the programmable
integer division and range of the display output pixel clock's 27-594MHz.

Signed-off-by: Wen He <wen.he_1@nxp.com>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/clk/Kconfig      |  10 ++
 drivers/clk/Makefile     |   1 +
 drivers/clk/clk-plldig.c | 297 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 308 insertions(+)
 create mode 100644 drivers/clk/clk-plldig.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 0530bebfc25a..9f6b0196c604 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -218,6 +218,16 @@ config CLK_QORIQ
 	  This adds the clock driver support for Freescale QorIQ platforms
 	  using common clock framework.
 
+config CLK_LS1028A_PLLDIG
+        tristate "Clock driver for LS1028A Display output"
+        depends on ARCH_LAYERSCAPE || COMPILE_TEST
+        default ARCH_LAYERSCAPE
+        help
+          This driver support the Display output interfaces(LCD, DPHY) pixel clocks
+          of the QorIQ Layerscape LS1028A, as implemented TSMC CLN28HPM PLL. Not all
+          features of the PLL are currently supported by the driver. By default,
+          configured bypass mode with this PLL.
+
 config COMMON_CLK_XGENE
 	bool "Clock driver for APM XGene SoC"
 	default ARCH_XGENE
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 0138fb14e6f8..97d1e5bc6de5 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_ARCH_NPCM7XX)	    	+= clk-npcm7xx.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
 obj-$(CONFIG_COMMON_CLK_OXNAS)		+= clk-oxnas.o
 obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
+obj-$(CONFIG_CLK_LS1028A_PLLDIG)	+= clk-plldig.o
 obj-$(CONFIG_COMMON_CLK_PWM)		+= clk-pwm.o
 obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
 obj-$(CONFIG_COMMON_CLK_RK808)		+= clk-rk808.o
diff --git a/drivers/clk/clk-plldig.c b/drivers/clk/clk-plldig.c
new file mode 100644
index 000000000000..1942686f0254
--- /dev/null
+++ b/drivers/clk/clk-plldig.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 NXP
+ *
+ * Clock driver for LS1028A Display output interfaces(LCD, DPHY).
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/bitfield.h>
+
+/* PLLDIG register offsets and bit masks */
+#define PLLDIG_REG_PLLSR            0x24
+#define PLLDIG_LOCK_MASK            BIT(2)
+#define PLLDIG_REG_PLLDV            0x28
+#define PLLDIG_MFD_MASK             GENMASK(7, 0)
+#define PLLDIG_RFDPHI1_MASK         GENMASK(30, 25)
+#define PLLDIG_REG_PLLFM            0x2c
+#define PLLDIG_SSCGBYP_ENABLE       BIT(30)
+#define PLLDIG_REG_PLLFD            0x30
+#define PLLDIG_FDEN                 BIT(30)
+#define PLLDIG_FRAC_MASK            GENMASK(15, 0)
+#define PLLDIG_REG_PLLCAL1          0x38
+#define PLLDIG_REG_PLLCAL2          0x3c
+
+/* Range of the VCO frequencies, in Hz */
+#define PLLDIG_MIN_VCO_FREQ         650000000
+#define PLLDIG_MAX_VCO_FREQ         1300000000
+
+/* Range of the output frequencies, in Hz */
+#define PHI1_MIN_FREQ               27000000
+#define PHI1_MAX_FREQ               600000000
+
+/* Maximum value of the reduced frequency divider */
+#define MAX_RFDPHI1          63UL
+
+/* Best value of multiplication factor divider */
+#define PLLDIG_DEFAULT_MFD   44
+
+/*
+ * Denominator part of the fractional part of the
+ * loop multiplication factor.
+ */
+#define MFDEN          20480
+
+static const struct clk_parent_data parent_data[] = {
+	{.index = 0},
+};
+
+struct clk_plldig {
+	struct clk_hw hw;
+	void __iomem *regs;
+	unsigned int vco_freq;
+};
+
+#define to_clk_plldig(_hw)	container_of(_hw, struct clk_plldig, hw)
+
+static int plldig_enable(struct clk_hw *hw)
+{
+	struct clk_plldig *data = to_clk_plldig(hw);
+	u32 val;
+
+	val = readl(data->regs + PLLDIG_REG_PLLFM);
+	/*
+	 * Use Bypass mode with PLL off by default, the frequency overshoot
+	 * detector output was disable. SSCG Bypass mode should be enable.
+	 */
+	val |= PLLDIG_SSCGBYP_ENABLE;
+	writel(val, data->regs + PLLDIG_REG_PLLFM);
+
+	return 0;
+}
+
+static void plldig_disable(struct clk_hw *hw)
+{
+	struct clk_plldig *data = to_clk_plldig(hw);
+	u32 val;
+
+	val = readl(data->regs + PLLDIG_REG_PLLFM);
+
+	val &= ~PLLDIG_SSCGBYP_ENABLE;
+	val |= FIELD_PREP(PLLDIG_SSCGBYP_ENABLE, 0x0);
+
+	writel(val, data->regs + PLLDIG_REG_PLLFM);
+}
+
+static int plldig_is_enabled(struct clk_hw *hw)
+{
+	struct clk_plldig *data = to_clk_plldig(hw);
+
+	return (readl(data->regs + PLLDIG_REG_PLLFM) &
+			      PLLDIG_SSCGBYP_ENABLE);
+}
+
+static unsigned long plldig_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct clk_plldig *data = to_clk_plldig(hw);
+	u32 val, rfdphi1;
+
+	val = readl(data->regs + PLLDIG_REG_PLLDV);
+
+	/* Check if PLL is bypassed */
+	if (val & PLLDIG_SSCGBYP_ENABLE)
+		return parent_rate;
+
+	rfdphi1 = FIELD_GET(PLLDIG_RFDPHI1_MASK, val);
+
+	/*
+	 * If RFDPHI1 has a value of 1 the VCO frequency is also divided by
+	 * one.
+	 */
+	if (!rfdphi1)
+		rfdphi1 = 1;
+
+	return DIV_ROUND_UP(data->vco_freq, rfdphi1);
+}
+
+static unsigned long plldig_calc_target_div(unsigned long vco_freq,
+					    unsigned long target_rate)
+{
+	unsigned long div;
+
+	div = DIV_ROUND_CLOSEST(vco_freq, target_rate);
+	div = max(1UL, div);
+	div = min(div, MAX_RFDPHI1);
+
+	return div;
+}
+
+static int plldig_determine_rate(struct clk_hw *hw,
+				 struct clk_rate_request *req)
+{
+	struct clk_plldig *data = to_clk_plldig(hw);
+	unsigned int div;
+
+	if (req->rate < PHI1_MIN_FREQ)
+		req->rate = PHI1_MIN_FREQ;
+	if (req->rate > PHI1_MAX_FREQ)
+		req->rate = PHI1_MAX_FREQ;
+
+	div = plldig_calc_target_div(data->vco_freq, req->rate);
+	req->rate = DIV_ROUND_UP(data->vco_freq, div);
+
+	return 0;
+}
+
+static int plldig_set_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long parent_rate)
+{
+	struct clk_plldig *data = to_clk_plldig(hw);
+	unsigned int val, cond;
+	unsigned int rfdphi1;
+
+	if (rate < PHI1_MIN_FREQ)
+		rate = PHI1_MIN_FREQ;
+	if (rate > PHI1_MAX_FREQ)
+		rate = PHI1_MAX_FREQ;
+
+	rfdphi1 = plldig_calc_target_div(data->vco_freq, rate);
+
+	/* update the divider value */
+	val = readl(data->regs + PLLDIG_REG_PLLDV);
+	val &= ~PLLDIG_RFDPHI1_MASK;
+	val |= FIELD_PREP(PLLDIG_RFDPHI1_MASK, rfdphi1);
+	writel(val, data->regs + PLLDIG_REG_PLLDV);
+
+	/* delay 200us make sure that old lock state is cleared */
+	udelay(200);
+
+	/* Wait until PLL is locked or timeout (maximum 1000 usecs) */
+	return readl_poll_timeout_atomic(data->regs + PLLDIG_REG_PLLSR, cond,
+					 cond & PLLDIG_LOCK_MASK, 0,
+					 USEC_PER_MSEC);
+}
+
+static const struct clk_ops plldig_clk_ops = {
+	.enable = plldig_enable,
+	.disable = plldig_disable,
+	.is_enabled = plldig_is_enabled,
+	.recalc_rate = plldig_recalc_rate,
+	.determine_rate = plldig_determine_rate,
+	.set_rate = plldig_set_rate,
+};
+
+static int plldig_init(struct clk_hw *hw)
+{
+	struct clk_plldig *data = to_clk_plldig(hw);
+	struct clk_hw *parent = clk_hw_get_parent(hw);
+	unsigned long parent_rate = clk_hw_get_rate(parent);
+	unsigned long val;
+	unsigned long long lltmp;
+	unsigned int mfd, fracdiv = 0;
+
+	if (!parent)
+		return -EINVAL;
+
+	if (data->vco_freq) {
+		mfd = data->vco_freq / parent_rate;
+		lltmp = data->vco_freq % parent_rate;
+		lltmp *= MFDEN;
+		do_div(lltmp, parent_rate);
+		fracdiv = lltmp;
+	} else {
+		mfd = PLLDIG_DEFAULT_MFD;
+		data->vco_freq = parent_rate * mfd;
+	}
+
+	val = FIELD_PREP(PLLDIG_MFD_MASK, mfd);
+	writel(val, data->regs + PLLDIG_REG_PLLDV);
+
+	if (fracdiv) {
+		val = FIELD_PREP(PLLDIG_FRAC_MASK, fracdiv);
+		/* Enable fractional divider */
+		val |= PLLDIG_FDEN;
+		writel(val, data->regs + PLLDIG_REG_PLLFD);
+	}
+
+	return 0;
+}
+
+static int plldig_clk_probe(struct platform_device *pdev)
+{
+	struct clk_plldig *data;
+	struct resource *mem;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->regs = devm_ioremap_resource(dev, mem);
+	if (IS_ERR(data->regs))
+		return PTR_ERR(data->regs);
+
+	data->hw.init = CLK_HW_INIT_PARENTS_DATA("dpclk",
+						 parent_data,
+						 &plldig_clk_ops,
+						 0);
+
+	ret = devm_clk_hw_register(dev, &data->hw);
+	if (ret) {
+		dev_err(dev, "failed to register %s clock\n",
+						dev->of_node->name);
+		return ret;
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					  &data->hw);
+	if (ret) {
+		dev_err(dev, "unable to add clk provider\n");
+		return ret;
+	}
+
+	/*
+	 * The frequency of the VCO cannot be changed during runtime.
+	 * Therefore, let the user specify a desired frequency.
+	 */
+	if (!of_property_read_u32(dev->of_node, "fsl,vco-hz",
+				  &data->vco_freq)) {
+		if (data->vco_freq < PLLDIG_MIN_VCO_FREQ ||
+		    data->vco_freq > PLLDIG_MAX_VCO_FREQ)
+			return -EINVAL;
+	}
+
+	return plldig_init(&data->hw);
+}
+
+static const struct of_device_id plldig_clk_id[] = {
+	{ .compatible = "fsl,ls1028a-plldig"},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, plldig_clk_id);
+
+static struct platform_driver plldig_clk_driver = {
+	.driver = {
+		.name = "plldig-clock",
+		.of_match_table = plldig_clk_id,
+	},
+	.probe = plldig_clk_probe,
+};
+module_platform_driver(plldig_clk_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Wen He <wen.he_1@nxp.com>");
+MODULE_DESCRIPTION("LS1028A Display output interface pixel clock driver");
-- 
2.17.1

