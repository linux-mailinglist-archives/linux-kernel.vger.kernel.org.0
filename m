Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEC84131CFF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 02:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbgAGBGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 20:06:50 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:43114 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbgAGBGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 20:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1578359203; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e9Em6f8bL3bvdfbLZRUJ4H56t+oscr7+pG44ZhCfUKs=;
        b=KkoFEM8a6t5Wx/yhaRlrf4daqk9yVDrpqbq2X8+A5Wn92w0zKuGWY7cs8Jwe+w/LCzg1V6
        U40gCzlEgQRanyQd8+w9RcU3MSCLXYqesiom0d2e0lWXNx2GqQ3e52GulAzEOKgj6fuvCw
        zaYJV002ovYkZFJAjFnUuoCatxqNyUE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 2/2] clocksource: Add driver for the Ingenic JZ47xx OST
Date:   Tue,  7 Jan 2020 02:06:30 +0100
Message-Id: <20200107010630.954648-2-paul@crapouillou.net>
In-Reply-To: <20200107010630.954648-1-paul@crapouillou.net>
References: <20200107010630.954648-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maarten ter Huurne <maarten@treewalker.org>

OST is the OS Timer, a 64-bit timer/counter with buffered reading.

SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770 and
JZ4780 have a 64-bit OST.

This driver will register both a clocksource and a sched_clock to the
system.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
    v2: local_irq_save/restore were moved within sched_clock_register

 drivers/clocksource/Kconfig       |   8 ++
 drivers/clocksource/Makefile      |   1 +
 drivers/clocksource/ingenic-ost.c | 218 ++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 drivers/clocksource/ingenic-ost.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5fdd76cb1768..5be2f876f64f 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -697,4 +697,12 @@ config INGENIC_TIMER
 	help
 	  Support for the timer/counter unit of the Ingenic JZ SoCs.
 
+config INGENIC_OST
+	bool "Ingenic JZ47xx Operating System Timer"
+	depends on MIPS || COMPILE_TEST
+	depends on COMMON_CLK
+	select MFD_SYSCON
+	help
+	  Support for the OS Timer of the Ingenic JZ4770 or similar SoC.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 4dfe4225ece7..6bc97a6fd229 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
 obj-$(CONFIG_H8300_TMR8)		+= h8300_timer8.o
 obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
 obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
+obj-$(CONFIG_INGENIC_OST)		+= ingenic-ost.o
 obj-$(CONFIG_INGENIC_TIMER)		+= ingenic-timer.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
diff --git a/drivers/clocksource/ingenic-ost.c b/drivers/clocksource/ingenic-ost.c
new file mode 100644
index 000000000000..dbb1d9634771
--- /dev/null
+++ b/drivers/clocksource/ingenic-ost.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * JZ47xx SoCs TCU Operating System Timer driver
+ *
+ * Copyright (C) 2016 Maarten ter Huurne <maarten@treewalker.org>
+ * Copyright (C) 2018 Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <linux/clk.h>
+#include <linux/clocksource.h>
+#include <linux/mfd/ingenic-tcu.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/sched_clock.h>
+
+#define TCU_OST_TCSR_MASK	0xffc0
+#define TCU_OST_TCSR_CNT_MD	BIT(15)
+
+#define TCU_OST_CHANNEL		15
+
+struct ingenic_ost_soc_info {
+	bool is64bit;
+};
+
+struct ingenic_ost {
+	struct regmap *map;
+	struct clk *clk;
+
+	struct clocksource cs;
+};
+
+static struct ingenic_ost *ingenic_ost;
+
+static u64 notrace ingenic_ost_read_cntl(void)
+{
+	u32 val;
+
+	regmap_read(ingenic_ost->map, TCU_REG_OST_CNTL, &val);
+
+	return val;
+}
+
+static u64 notrace ingenic_ost_read_cnth(void)
+{
+	u32 val;
+
+	regmap_read(ingenic_ost->map, TCU_REG_OST_CNTH, &val);
+
+	return val;
+}
+
+static u64 notrace ingenic_ost_clocksource_read64(struct clocksource *cs)
+{
+	u32 val1, val2;
+	u64 count, recount;
+	s64 diff;
+
+	/*
+	 * The buffering of the upper 32 bits of the timer prevents wrong
+	 * results from the bottom 32 bits overflowing due to the timer ticking
+	 * along. However, it does not prevent wrong results from simultaneous
+	 * reads of the timer, which could reset the buffer mid-read.
+	 * Since this kind of wrong read can happen only when the bottom bits
+	 * overflow, there will be minutes between wrong reads, so if we read
+	 * twice in succession, at least one of the reads will be correct.
+	 */
+
+	/* Bypass the regmap here as we must return as soon as possible */
+	regmap_read(ingenic_ost->map, TCU_REG_OST_CNTL, &val1);
+	regmap_read(ingenic_ost->map, TCU_REG_OST_CNTHBUF, &val2);
+	count = (u64)val1 | (u64)val2 << 32;
+
+	regmap_read(ingenic_ost->map, TCU_REG_OST_CNTL, &val1);
+	regmap_read(ingenic_ost->map, TCU_REG_OST_CNTHBUF, &val2);
+	recount = (u64)val1 | (u64)val2 << 32;
+
+	/*
+	 * A wrong read will produce a result that is 1<<32 too high: the bottom
+	 * part from before overflow and the upper part from after overflow.
+	 * Therefore, the lower value of the two reads is the correct value.
+	 */
+
+	diff = (s64)(recount - count);
+	if (unlikely(diff < 0))
+		count = recount;
+
+	return count;
+}
+
+static u64 notrace ingenic_ost_clocksource_read32(struct clocksource *cs)
+{
+	return ingenic_ost_read_cnth();
+}
+
+static int __init ingenic_ost_probe(struct platform_device *pdev)
+{
+	const struct ingenic_ost_soc_info *soc_info;
+	struct device *dev = &pdev->dev;
+	struct ingenic_ost *ost;
+	struct clocksource *cs;
+	unsigned long rate;
+	int err;
+
+	soc_info = device_get_match_data(dev);
+	if (!soc_info)
+		return -EINVAL;
+
+	ost = devm_kzalloc(dev, sizeof(*ost), GFP_KERNEL);
+	if (!ost)
+		return -ENOMEM;
+
+	ingenic_ost = ost;
+
+	ost->map = device_node_to_regmap(dev->parent->of_node);
+	if (!ost->map) {
+		dev_err(dev, "regmap not found\n");
+		return -EINVAL;
+	}
+
+	ost->clk = devm_clk_get(dev, "ost");
+	if (IS_ERR(ost->clk))
+		return PTR_ERR(ost->clk);
+
+	err = clk_prepare_enable(ost->clk);
+	if (err)
+		return err;
+
+	/* Clear counter high/low registers */
+	if (soc_info->is64bit)
+		regmap_write(ost->map, TCU_REG_OST_CNTL, 0);
+	regmap_write(ost->map, TCU_REG_OST_CNTH, 0);
+
+	/* Don't reset counter at compare value. */
+	regmap_update_bits(ost->map, TCU_REG_OST_TCSR,
+			   TCU_OST_TCSR_MASK, TCU_OST_TCSR_CNT_MD);
+
+	rate = clk_get_rate(ost->clk);
+
+	/* Enable OST TCU channel */
+	regmap_write(ost->map, TCU_REG_TESR, BIT(TCU_OST_CHANNEL));
+
+	cs = &ost->cs;
+	cs->name	= "ingenic-ost";
+	cs->rating	= 320;
+	cs->flags	= CLOCK_SOURCE_IS_CONTINUOUS;
+
+	if (soc_info->is64bit) {
+		cs->mask = CLOCKSOURCE_MASK(64);
+		cs->read = ingenic_ost_clocksource_read64;
+	} else {
+		cs->mask = CLOCKSOURCE_MASK(32);
+		cs->read = ingenic_ost_clocksource_read32;
+	}
+
+	err = clocksource_register_hz(cs, rate);
+	if (err) {
+		dev_err(dev, "clocksource registration failed: %d\n", err);
+		clk_disable_unprepare(ost->clk);
+		return err;
+	}
+
+	if (soc_info->is64bit)
+		sched_clock_register(ingenic_ost_read_cntl, 32, rate);
+	else
+		sched_clock_register(ingenic_ost_read_cnth, 32, rate);
+
+	return 0;
+}
+
+static int __maybe_unused ingenic_ost_suspend(struct device *dev)
+{
+	struct ingenic_ost *ost = dev_get_drvdata(dev);
+
+	clk_disable(ost->clk);
+
+	return 0;
+}
+
+static int __maybe_unused ingenic_ost_resume(struct device *dev)
+{
+	struct ingenic_ost *ost = dev_get_drvdata(dev);
+
+	return clk_enable(ost->clk);
+}
+
+static const struct dev_pm_ops __maybe_unused ingenic_ost_pm_ops = {
+	/* _noirq: We want the OST clock to be gated last / ungated first */
+	.suspend_noirq = ingenic_ost_suspend,
+	.resume_noirq  = ingenic_ost_resume,
+};
+
+static const struct ingenic_ost_soc_info jz4725b_ost_soc_info = {
+	.is64bit = false,
+};
+
+static const struct ingenic_ost_soc_info jz4770_ost_soc_info = {
+	.is64bit = true,
+};
+
+static const struct of_device_id ingenic_ost_of_match[] = {
+	{ .compatible = "ingenic,jz4725b-ost", .data = &jz4725b_ost_soc_info, },
+	{ .compatible = "ingenic,jz4770-ost", .data = &jz4770_ost_soc_info, },
+	{ }
+};
+
+static struct platform_driver ingenic_ost_driver = {
+	.driver = {
+		.name = "ingenic-ost",
+#ifdef CONFIG_PM_SUSPEND
+		.pm = &ingenic_ost_pm_ops,
+#endif
+		.of_match_table = ingenic_ost_of_match,
+	},
+};
+builtin_platform_driver_probe(ingenic_ost_driver, ingenic_ost_probe);
-- 
2.24.1

