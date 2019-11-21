Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC52C1049D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 06:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKUFCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 00:02:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:36394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfKUFCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:02:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1E1DAFF6;
        Thu, 21 Nov 2019 05:02:18 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Aleix Roca Nonell <kernelrocks@gmail.com>,
        James Tai <james.tai@realtek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v5 2/9] irqchip: Add Realtek RTD1295 mux driver
Date:   Thu, 21 Nov 2019 06:02:01 +0100
Message-Id: <20191121050208.11324-3-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191121050208.11324-1-afaerber@suse.de>
References: <20191121050208.11324-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This irq mux driver implements the RTD1295 SoC's non-linear mapping
between status and enable bits.

Based in part on QNAP's arch/arm/mach-rtk119x/rtk_irq_mux.c and
Synology's drivers/irqchip/irq-rtk.c code.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Cc: Aleix Roca Nonell <kernelrocks@gmail.com>
Signed-off-by: James Tai <james.tai@realtek.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v4 -> v5:
 * Renamed enable/disable to unmask/mask (Marc)
 * Factored out ack (Marc)
 * Clear all interrupts just in case
 * Added and mapped WDOG_NMI
 * Suppress mapping NMIs and reserved bits (Marc)
 * Dropped mask checks in mask/unmask (Marc)
 * Dropped mask check in interrupt handler
 * Renamed misc bits by inserting MIS_ for consistency
 * Duplicate irq_chip into rtd1195_mux_data
 * Renamed irq_chip from long rtd1195-mux to iso/misc, tidying /proc/interrupts
 
 v3 -> v4:
 * Drop no-op .irq_set_affinity callback (Thomas)
 * Clear all interrupts (James)
 * Updated SPDX-License-identifier
 * Use tabular formatting (Thomas)
 * Adopt different braces style (Thomas)
 * Use raw_spinlock_t (Thomas)
 * Shortened callback from isr_to_scpu_int_en_mask to isr_to_int_en_mask (Thomas)
 * Fixed of_iomap() error handling to not use IS_ERR()
 * Don't mask unmapped NMIs by checking for a non-zero mask
 * Cache SCPU_INT_EN to avoid superfluous reads (Thomas)
 * Renamed functions and variables from rtd119x to rtd1195
 
 v2 -> v3:
 * Adopted spin_lock_irq{save,restore}() (Marc)
 * Adopted single-write masking (Marc)
 * Adopted misc compatible string
 * Introduced explicit bit mapping
 * Adopted looped processing of pending interrupts (Marc)
 * Replaced unmask implementation with UMSK_ISR write
 * Introduced enable/disable ops and dropped no longer needed UART0 quirk
 
 v1 -> v2:
 * Renamed struct fields to avoid ambiguity (Marc)
 * Refactored offset lookup to avoid per-compatible init functions
 * Inserted white lines to clarify balanced locking (Marc)
 * Dropped forwarding of set_affinity to GIC (Marc)
 * Added spinlocks for consistency (Marc)
 * Limited initialization quirk to iso mux
 * Fixed spinlock initialization (Andrew)
 
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-rtd1195-mux.c | 291 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 292 insertions(+)
 create mode 100644 drivers/irqchip/irq-rtd1195-mux.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e806dda690ea..d678881eebc8 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -104,3 +104,4 @@ obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
 obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
+obj-$(CONFIG_ARCH_REALTEK)		+= irq-rtd1195-mux.o
diff --git a/drivers/irqchip/irq-rtd1195-mux.c b/drivers/irqchip/irq-rtd1195-mux.c
new file mode 100644
index 000000000000..0e86973aafca
--- /dev/null
+++ b/drivers/irqchip/irq-rtd1195-mux.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Realtek RTD1295 IRQ mux
+ *
+ * Copyright (c) 2017-2019 Andreas Färber
+ */
+
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/slab.h>
+
+#define UMSK_ISR_WRITE_DATA	BIT(0)
+#define ISR_WRITE_DATA		BIT(0)
+
+struct rtd1195_irq_mux_info {
+	const char	*name;
+	unsigned int	isr_offset;
+	unsigned int	umsk_isr_offset;
+	unsigned int	scpu_int_en_offset;
+	const u32	*isr_to_int_en_mask;
+};
+
+#define SCPU_INT_EN_RSV_MASK	0
+#define SCPU_INT_EN_NMI_MASK	GENMASK(31, 0)
+
+struct rtd1195_irq_mux_data {
+	void __iomem				*reg_isr;
+	void __iomem				*reg_umsk_isr;
+	void __iomem				*reg_scpu_int_en;
+	const struct rtd1195_irq_mux_info	*info;
+	int					irq;
+	u32					scpu_int_en;
+	struct irq_chip				chip;
+	struct irq_domain			*domain;
+	raw_spinlock_t				lock;
+};
+
+static void rtd1195_mux_irq_handle(struct irq_desc *desc)
+{
+	struct rtd1195_irq_mux_data *mux = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 isr;
+	int i;
+
+	chained_irq_enter(chip, desc);
+
+	isr = readl_relaxed(mux->reg_isr);
+
+	while (isr) {
+		i = __ffs(isr);
+		isr &= ~BIT(i);
+
+		generic_handle_irq(irq_find_mapping(mux->domain, i));
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void rtd1195_mux_ack_irq(struct irq_data *data)
+{
+	struct rtd1195_irq_mux_data *mux = irq_data_get_irq_chip_data(data);
+
+	writel_relaxed(BIT(data->hwirq) & ~ISR_WRITE_DATA, mux->reg_isr);
+}
+
+static void rtd1195_mux_mask_irq(struct irq_data *data)
+{
+	struct rtd1195_irq_mux_data *mux = irq_data_get_irq_chip_data(data);
+	u32 mask = mux->info->isr_to_int_en_mask[data->hwirq];
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&mux->lock, flags);
+
+	mux->scpu_int_en &= ~mask;
+	writel_relaxed(mux->scpu_int_en, mux->reg_scpu_int_en);
+
+	raw_spin_unlock_irqrestore(&mux->lock, flags);
+}
+
+static void rtd1195_mux_unmask_irq(struct irq_data *data)
+{
+	struct rtd1195_irq_mux_data *mux = irq_data_get_irq_chip_data(data);
+	u32 mask = mux->info->isr_to_int_en_mask[data->hwirq];
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&mux->lock, flags);
+
+	mux->scpu_int_en |= mask;
+	writel_relaxed(mux->scpu_int_en, mux->reg_scpu_int_en);
+
+	raw_spin_unlock_irqrestore(&mux->lock, flags);
+}
+
+static const struct irq_chip rtd1195_mux_irq_chip = {
+	.irq_ack		= rtd1195_mux_ack_irq,
+	.irq_mask		= rtd1195_mux_mask_irq,
+	.irq_unmask		= rtd1195_mux_unmask_irq,
+};
+
+static int rtd1195_mux_irq_domain_map(struct irq_domain *d,
+		unsigned int irq, irq_hw_number_t hw)
+{
+	struct rtd1195_irq_mux_data *mux = d->host_data;
+	u32 mask;
+
+	if (BIT(hw) == ISR_WRITE_DATA)
+		return -EINVAL;
+
+	mask = mux->info->isr_to_int_en_mask[hw];
+	if (mask == SCPU_INT_EN_RSV_MASK)
+		return -EINVAL;
+
+	if (mask == SCPU_INT_EN_NMI_MASK)
+		return -ENOTSUPP;
+
+	irq_set_chip_and_handler(irq, &mux->chip, handle_level_irq);
+	irq_set_chip_data(irq, mux);
+	irq_set_probe(irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops rtd1195_mux_irq_domain_ops = {
+	.xlate	= irq_domain_xlate_onecell,
+	.map	= rtd1195_mux_irq_domain_map,
+};
+
+enum rtd1295_iso_isr_bits {
+	RTD1295_ISO_ISR_UR0_SHIFT		= 2,
+	RTD1295_ISO_ISR_IRDA_SHIFT		= 5,
+	RTD1295_ISO_ISR_I2C0_SHIFT		= 8,
+	RTD1295_ISO_ISR_I2C1_SHIFT		= 11,
+	RTD1295_ISO_ISR_RTC_HSEC_SHIFT		= 12,
+	RTD1295_ISO_ISR_RTC_ALARM_SHIFT		= 13,
+	RTD1295_ISO_ISR_GPIOA_SHIFT		= 19,
+	RTD1295_ISO_ISR_GPIODA_SHIFT		= 20,
+	RTD1295_ISO_ISR_GPHY_DV_SHIFT		= 29,
+	RTD1295_ISO_ISR_GPHY_AV_SHIFT		= 30,
+	RTD1295_ISO_ISR_I2C1_REQ_SHIFT		= 31,
+};
+
+static const u32 rtd1295_iso_isr_to_scpu_int_en_mask[32] = {
+	[RTD1295_ISO_ISR_UR0_SHIFT]		= BIT(2),
+	[RTD1295_ISO_ISR_IRDA_SHIFT]		= BIT(5),
+	[RTD1295_ISO_ISR_I2C0_SHIFT]		= BIT(8),
+	[RTD1295_ISO_ISR_I2C1_SHIFT]		= BIT(11),
+	[RTD1295_ISO_ISR_RTC_HSEC_SHIFT]	= BIT(12),
+	[RTD1295_ISO_ISR_RTC_ALARM_SHIFT]	= BIT(13),
+	[RTD1295_ISO_ISR_GPIOA_SHIFT]		= BIT(19),
+	[RTD1295_ISO_ISR_GPIODA_SHIFT]		= BIT(20),
+	[RTD1295_ISO_ISR_GPHY_DV_SHIFT]		= BIT(29),
+	[RTD1295_ISO_ISR_GPHY_AV_SHIFT]		= BIT(30),
+	[RTD1295_ISO_ISR_I2C1_REQ_SHIFT]	= BIT(31),
+};
+
+enum rtd1295_misc_isr_bits {
+	RTD1295_MIS_ISR_WDOG_NMI_SHIFT		= 2,
+	RTD1295_MIS_ISR_UR1_SHIFT		= 3,
+	RTD1295_MIS_ISR_UR1_TO_SHIFT		= 5,
+	RTD1295_MIS_ISR_UR2_SHIFT		= 8,
+	RTD1295_MIS_ISR_RTC_MIN_SHIFT		= 10,
+	RTD1295_MIS_ISR_RTC_HOUR_SHIFT		= 11,
+	RTD1295_MIS_ISR_RTC_DATA_SHIFT		= 12,
+	RTD1295_MIS_ISR_UR2_TO_SHIFT		= 13,
+	RTD1295_MIS_ISR_I2C5_SHIFT		= 14,
+	RTD1295_MIS_ISR_I2C4_SHIFT		= 15,
+	RTD1295_MIS_ISR_GPIOA_SHIFT		= 19,
+	RTD1295_MIS_ISR_GPIODA_SHIFT		= 20,
+	RTD1295_MIS_ISR_LSADC0_SHIFT		= 21,
+	RTD1295_MIS_ISR_LSADC1_SHIFT		= 22,
+	RTD1295_MIS_ISR_I2C3_SHIFT		= 23,
+	RTD1295_MIS_ISR_SC0_SHIFT		= 24,
+	RTD1295_MIS_ISR_I2C2_SHIFT		= 26,
+	RTD1295_MIS_ISR_GSPI_SHIFT		= 27,
+	RTD1295_MIS_ISR_FAN_SHIFT		= 29,
+};
+
+static const u32 rtd1295_misc_isr_to_scpu_int_en_mask[32] = {
+	[RTD1295_MIS_ISR_UR1_SHIFT]		= BIT(3),
+	[RTD1295_MIS_ISR_UR1_TO_SHIFT]		= BIT(5),
+	[RTD1295_MIS_ISR_UR2_TO_SHIFT]		= BIT(6),
+	[RTD1295_MIS_ISR_UR2_SHIFT]		= BIT(7),
+	[RTD1295_MIS_ISR_RTC_MIN_SHIFT]		= BIT(10),
+	[RTD1295_MIS_ISR_RTC_HOUR_SHIFT]	= BIT(11),
+	[RTD1295_MIS_ISR_RTC_DATA_SHIFT]	= BIT(12),
+	[RTD1295_MIS_ISR_I2C5_SHIFT]		= BIT(14),
+	[RTD1295_MIS_ISR_I2C4_SHIFT]		= BIT(15),
+	[RTD1295_MIS_ISR_GPIOA_SHIFT]		= BIT(19),
+	[RTD1295_MIS_ISR_GPIODA_SHIFT]		= BIT(20),
+	[RTD1295_MIS_ISR_LSADC0_SHIFT]		= BIT(21),
+	[RTD1295_MIS_ISR_LSADC1_SHIFT]		= BIT(22),
+	[RTD1295_MIS_ISR_SC0_SHIFT]		= BIT(24),
+	[RTD1295_MIS_ISR_I2C2_SHIFT]		= BIT(26),
+	[RTD1295_MIS_ISR_GSPI_SHIFT]		= BIT(27),
+	[RTD1295_MIS_ISR_I2C3_SHIFT]		= BIT(28),
+	[RTD1295_MIS_ISR_FAN_SHIFT]		= BIT(29),
+	[RTD1295_MIS_ISR_WDOG_NMI_SHIFT]	= SCPU_INT_EN_NMI_MASK,
+};
+
+static const struct rtd1195_irq_mux_info rtd1295_iso_irq_mux_info = {
+	.name			= "iso",
+	.isr_offset		= 0x0,
+	.umsk_isr_offset	= 0x4,
+	.scpu_int_en_offset	= 0x40,
+	.isr_to_int_en_mask	= rtd1295_iso_isr_to_scpu_int_en_mask,
+};
+
+static const struct rtd1195_irq_mux_info rtd1295_misc_irq_mux_info = {
+	.name			= "misc",
+	.umsk_isr_offset	= 0x8,
+	.isr_offset		= 0xc,
+	.scpu_int_en_offset	= 0x80,
+	.isr_to_int_en_mask	= rtd1295_misc_isr_to_scpu_int_en_mask,
+};
+
+static const struct of_device_id rtd1295_irq_mux_dt_matches[] = {
+	{
+		.compatible = "realtek,rtd1295-iso-irq-mux",
+		.data = &rtd1295_iso_irq_mux_info,
+	},
+	{
+		.compatible = "realtek,rtd1295-misc-irq-mux",
+		.data = &rtd1295_misc_irq_mux_info,
+	},
+	{
+	}
+};
+
+static int __init rtd1195_irq_mux_init(struct device_node *node,
+				       struct device_node *parent)
+{
+	struct rtd1195_irq_mux_data *mux;
+	const struct of_device_id *match;
+	const struct rtd1195_irq_mux_info *info;
+	void __iomem *base;
+
+	match = of_match_node(rtd1295_irq_mux_dt_matches, node);
+	if (!match)
+		return -EINVAL;
+
+	info = match->data;
+	if (!info)
+		return -EINVAL;
+
+	base = of_iomap(node, 0);
+	if (!base)
+		return -EIO;
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return -ENOMEM;
+
+	mux->info		= info;
+	mux->reg_isr		= base + info->isr_offset;
+	mux->reg_umsk_isr	= base + info->umsk_isr_offset;
+	mux->reg_scpu_int_en	= base + info->scpu_int_en_offset;
+	mux->chip		= rtd1195_mux_irq_chip;
+	mux->chip.name		= info->name;
+
+	mux->irq = irq_of_parse_and_map(node, 0);
+	if (mux->irq <= 0) {
+		kfree(mux);
+		return -EINVAL;
+	}
+
+	raw_spin_lock_init(&mux->lock);
+
+	/* Disable (mask) all interrupts */
+	writel_relaxed(mux->scpu_int_en, mux->reg_scpu_int_en);
+
+	/* Ack (clear) all interrupts - not all are in UMSK_ISR, so use ISR */
+	writel_relaxed(~ISR_WRITE_DATA, mux->reg_isr);
+
+	mux->domain = irq_domain_add_linear(node, 32,
+				&rtd1195_mux_irq_domain_ops, mux);
+	if (!mux->domain) {
+		kfree(mux);
+		return -ENOMEM;
+	}
+
+	irq_set_chained_handler_and_data(mux->irq, rtd1195_mux_irq_handle, mux);
+
+	return 0;
+}
+IRQCHIP_DECLARE(rtd1295_iso_mux, "realtek,rtd1295-iso-irq-mux", rtd1195_irq_mux_init);
+IRQCHIP_DECLARE(rtd1295_misc_mux, "realtek,rtd1295-misc-irq-mux", rtd1195_irq_mux_init);
-- 
2.16.4

