Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9C11681F9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 16:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgBUPkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 10:40:10 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40062 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728815AbgBUPkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:40:10 -0500
Received: from Internal Mail-Server by MTLPINE2 (envelope-from asmaa@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 21 Feb 2020 17:40:06 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 01LFe5Y3030560;
        Fri, 21 Feb 2020 10:40:05 -0500
Received: (from asmaa@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 01LFe5e4013408;
        Fri, 21 Feb 2020 10:40:05 -0500
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     bgolaszewski@baylibre.com, linus.walleij@linaro.org
Cc:     Asmaa Mnebhi <Asmaa@mellanox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] gpio: add driver for Mellanox BlueField 2 GPIO controller
Date:   Fri, 21 Feb 2020 10:39:55 -0500
Message-Id: <d5d95e7b2823ef45878739ea338a1661df2e6a89.1582299415.git.Asmaa@mellanox.com>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <cover.1582299415.git.Asmaa@mellanox.com>
References: <cover.1582299415.git.Asmaa@mellanox.com>
In-Reply-To: <cover.1582299415.git.Asmaa@mellanox.com>
References: <cover.1582299415.git.Asmaa@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the GPIO controller used by
Mellanox BlueField 2 SOCs.

Signed-off-by: Asmaa Mnebhi <Asmaa@mellanox.com>
---
 drivers/gpio/Kconfig       |   7 +
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-mlxbf2.c | 411 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 419 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf2.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b8013cf..6234ccc 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1399,6 +1399,13 @@ config GPIO_MLXBF
 	help
 	  Say Y here if you want GPIO support on Mellanox BlueField SoC.
 
+config GPIO_MLXBF2
+	tristate "Mellanox BlueField 2 SoC GPIO"
+	depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || (64BIT && COMPILE_TEST)
+	select GPIO_GENERIC
+	help
+	  Say Y here if you want GPIO support on Mellanox BlueField 2 SoC.
+
 config GPIO_ML_IOH
 	tristate "OKI SEMICONDUCTOR ML7213 IOH GPIO support"
 	depends on X86 || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 0b57126..b2cfc21 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_GPIO_MENZ127)		+= gpio-menz127.o
 obj-$(CONFIG_GPIO_MERRIFIELD)		+= gpio-merrifield.o
 obj-$(CONFIG_GPIO_ML_IOH)		+= gpio-ml-ioh.o
 obj-$(CONFIG_GPIO_MLXBF)		+= gpio-mlxbf.o
+obj-$(CONFIG_GPIO_MLXBF2)		+= gpio-mlxbf2.o
 obj-$(CONFIG_GPIO_MM_LANTIQ)		+= gpio-mm-lantiq.o
 obj-$(CONFIG_GPIO_MOCKUP)		+= gpio-mockup.o
 obj-$(CONFIG_GPIO_MOXTET)		+= gpio-moxtet.o
diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c
new file mode 100644
index 0000000..a4ffe0b
--- /dev/null
+++ b/drivers/gpio/gpio-mlxbf2.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/gpio/driver.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/resource.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/version.h>
+
+/*
+ * There are 3 YU GPIO blocks:
+ * gpio[0]: HOST_GPIO0->HOST_GPIO31
+ * gpio[1]: HOST_GPIO32->HOST_GPIO63
+ * gpio[2]: HOST_GPIO64->HOST_GPIO69
+ */
+#define YU_GPIO_BLOCKS		3
+
+/* Max number of pins per YU GPIO block in the YU */
+#define YU_GPIO_BLOCK_MAX_PINS		32
+
+/* Total number of GPIO pins supported */
+#define BF2_HOST_GPIO_NUM		70
+
+#define YU_GPIO0_MAX_GPIO_ID	(YU_GPIO_BLOCK_MAX_PINS - 1)
+#define YU_GPIO1_MAX_GPIO_ID	\
+	(YU_GPIO0_MAX_GPIO_ID + YU_GPIO_BLOCK_MAX_PINS)
+#define YU_GPIO2_MAX_GPIO_ID	(BF2_HOST_GPIO_NUM - 1)
+
+/* Retrieve start address of a YU GPIO block */
+#define YU_GPIO_BLOCK_STRIDE(block)	(block * 0x100)
+
+/*
+ * arm_gpio_lock register:
+ * bit[31]	lock status: active if set
+ * bit[15:0]	set lock
+ * The lock is enabled only if 0xd42f is written to this field
+ */
+#define YU_LOCK_ACTIVE_BIT(val)		(val >> 31)
+#define YU_ARM_GPIO_LOCK_ACQUIRE	0xd42f
+#define YU_ARM_GPIO_LOCK_RELEASE	0x0
+
+/*
+ * gpio[x] block registers and their offset
+ */
+#define YU_GPIO_DATAOUT			0x00
+#define YU_GPIO_DATAIN			0x04
+#define YU_GPIO_MODE1			0x08
+#define YU_GPIO_MODE0			0x0c
+#define YU_GPIO_DATASET			0x14
+#define YU_GPIO_DATACLEAR		0x18
+#define YU_GPIO_MODE1_CLEAR		0x50
+#define YU_GPIO_MODE0_SET		0x54
+#define YU_GPIO_MODE0_CLEAR		0x58
+
+enum {
+	GPIO_BLOCK0,
+	GPIO_BLOCK1,
+	GPIO_BLOCK2
+};
+
+enum {
+	GPIO_BLOCKS,
+	ARM_GPIO_LOCK,
+};
+
+#ifdef CONFIG_PM
+struct mlxbf2_gpio_context_save_regs {
+	u32 gpio_mode0[YU_GPIO_BLOCKS];
+	u32 gpio_mode1[YU_GPIO_BLOCKS];
+};
+#endif
+
+/* BF2 Device state structure. */
+struct mlxbf2_gpio_state {
+	struct gpio_chip gc;
+	struct irq_chip irq_chip;
+
+	/* Must hold this lock to modify shared data. */
+	spinlock_t lock;
+
+	/* YU GPIO blocks address */
+	void __iomem *gpio_io;
+	/* YU ARM GPIO lock address */
+	void __iomem *arm_gpio_lock_io;
+#ifdef CONFIG_PM
+	struct mlxbf2_gpio_context_save_regs *csave_regs;
+#endif
+};
+
+/*
+ * Acquire the YU arm_gpio_lock to be able to change the direction
+ * mode. If the lock_active bit is already set, return an error.
+ */
+static int mlxbf2_gpio_lock_acquire(struct mlxbf2_gpio_state *gs)
+{
+	u32 arm_gpio_lock_val;
+
+	arm_gpio_lock_val = readl(gs->arm_gpio_lock_io);
+
+	/*
+	 * When lock active bit[31] is set, ModeX is write enabled
+	 */
+	if (YU_LOCK_ACTIVE_BIT(arm_gpio_lock_val))
+		return -EINVAL;
+
+	writel(YU_ARM_GPIO_LOCK_ACQUIRE, gs->arm_gpio_lock_io);
+
+	return 0;
+}
+
+/*
+ * Release the YU arm_gpio_lock after changing the direction mode.
+ */
+static void mlxbf2_gpio_lock_release(struct mlxbf2_gpio_state *gs)
+{
+	writel(YU_ARM_GPIO_LOCK_RELEASE, gs->arm_gpio_lock_io);
+}
+
+/* Get the YU gpio block offset based on the GPIO pin. */
+static u32 gpio_pin_to_blk_offset(unsigned int offset)
+{
+	if (offset <= YU_GPIO0_MAX_GPIO_ID)
+		return YU_GPIO_BLOCK_STRIDE(GPIO_BLOCK0);
+	else if (offset <= YU_GPIO1_MAX_GPIO_ID)
+		return YU_GPIO_BLOCK_STRIDE(GPIO_BLOCK1);
+	else if (offset <= YU_GPIO2_MAX_GPIO_ID)
+		return YU_GPIO_BLOCK_STRIDE(GPIO_BLOCK2);
+	else
+		return -EINVAL;
+}
+
+/*
+ * mode0 and mode1 are both locked by the gpio_lock field.
+ *
+ * Together, mode0 and mode1 define the gpio Mode dependeing also
+ * on Reg_DataOut.
+ *
+ * {mode1,mode0}:{Reg_DataOut=0,Reg_DataOut=1}->{DataOut=0,DataOut=1}
+ *
+ * {0,0}:Reg_DataOut{0,1}->{Z,Z} Input PAD
+ * {0,1}:Reg_DataOut{0,1}->{0,1} Full drive Output PAD
+ * {1,0}:Reg_DataOut{0,1}->{0,Z} 0-set PAD to low, 1-float
+ * {1,1}:Reg_DataOut{0,1}->{Z,1} 0-float, 1-set PAD to high
+ */
+
+/*
+ * Set input direction:
+ * {mode1,mode0} = {0,0}
+ */
+static int mlxbf2_gpio_direction_input(struct gpio_chip *chip,
+				       unsigned int offset)
+{
+	struct mlxbf2_gpio_state *gs = gpiochip_get_data(chip);
+	unsigned int local_offset;
+	u32 blk_offset;
+	int ret;
+
+	blk_offset = gpio_pin_to_blk_offset(offset);
+	if (blk_offset < 0)
+		return blk_offset;
+
+	local_offset = (offset % YU_GPIO_BLOCK_MAX_PINS);
+
+	/*
+	 * Although the arm_gpio_lock was set in the probe function, check again
+	 * it is still enabled to be able to write to the ModeX registers.
+	 */
+	spin_lock(&gs->lock);
+	ret = mlxbf2_gpio_lock_acquire(gs);
+	if (ret < 0) {
+		spin_unlock(&gs->lock);
+		return ret;
+	}
+
+	writel(BIT(local_offset), gs->gpio_io + blk_offset +
+		YU_GPIO_MODE0_CLEAR);
+	writel(BIT(local_offset), gs->gpio_io + blk_offset +
+		YU_GPIO_MODE1_CLEAR);
+
+	mlxbf2_gpio_lock_release(gs);
+	spin_unlock(&gs->lock);
+
+	return ret;
+}
+
+/*
+ * Set output direction:
+ * {mode1,mode0} = {0,1}
+ */
+static int mlxbf2_gpio_direction_output(struct gpio_chip *chip,
+					unsigned int offset,
+					int value)
+{
+	struct mlxbf2_gpio_state *gs = gpiochip_get_data(chip);
+	unsigned int local_offset;
+	u32 blk_offset;
+	int ret = 0;
+
+	blk_offset = gpio_pin_to_blk_offset(offset);
+	if (blk_offset < 0)
+		return blk_offset;
+
+	local_offset = (offset % YU_GPIO_BLOCK_MAX_PINS);
+
+	/*
+	 * Although the arm_gpio_lock was set in the probe function,
+	 * check again it is still enabled to be able to write to the
+	 * ModeX registers.
+	 */
+	spin_lock(&gs->lock);
+	ret = mlxbf2_gpio_lock_acquire(gs);
+	if (ret < 0) {
+		spin_unlock(&gs->lock);
+		return ret;
+	}
+
+	writel(BIT(local_offset), gs->gpio_io + blk_offset +
+		YU_GPIO_MODE1_CLEAR);
+	writel(BIT(local_offset), gs->gpio_io + blk_offset +
+		YU_GPIO_MODE0_SET);
+
+	mlxbf2_gpio_lock_release(gs);
+	spin_unlock(&gs->lock);
+
+	return ret;
+}
+
+/* Get state of GPIO pin when direction is set to in */
+static int mlxbf2_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mlxbf2_gpio_state *gs;
+	unsigned int local_offset;
+	u32 blk_offset;
+	u32 value;
+
+	blk_offset = gpio_pin_to_blk_offset(offset);
+	if (blk_offset < 0)
+		return blk_offset;
+
+	local_offset = (offset % YU_GPIO_BLOCK_MAX_PINS);
+
+	gs = gpiochip_get_data(chip);
+
+	spin_lock(&gs->lock);
+	value = readl(gs->gpio_io + blk_offset + YU_GPIO_DATAIN);
+	spin_unlock(&gs->lock);
+
+	return (value >> local_offset) & 1;
+}
+
+/* Set GPIO pin when direction is set to out */
+static void mlxbf2_gpio_set(struct gpio_chip *chip, unsigned int offset,
+	int value)
+{
+	struct mlxbf2_gpio_state *gs;
+	unsigned int local_offset;
+	u32 blk_offset;
+
+	blk_offset = gpio_pin_to_blk_offset(offset);
+	if (blk_offset < 0)
+		return;
+
+	local_offset = (offset % YU_GPIO_BLOCK_MAX_PINS);
+
+	gs = gpiochip_get_data(chip);
+
+	/*
+	 * Use dataset reg if "value" is 1.
+	 * Use dataclear reg if "value" is 0.
+	 * dataset and dataclear enable us to write to dataout
+	 * without having to do a read and mask before.
+	 * Write 0x1 to the corresponding gpio pin in
+	 * both dataset and dataclear reg to set or clear
+	 * a value respectively.
+	 */
+	spin_lock(&gs->lock);
+
+	if (value)
+		writel(BIT(local_offset), gs->gpio_io + blk_offset +
+			YU_GPIO_DATASET);
+	else
+		writel(BIT(local_offset), gs->gpio_io + blk_offset +
+			YU_GPIO_DATACLEAR);
+
+	spin_unlock(&gs->lock);
+}
+
+/* BF2 GPIO driver initialization routine. */
+static int
+mlxbf2_gpio_probe(struct platform_device *pdev)
+{
+	struct mlxbf2_gpio_state *gs;
+	struct device *dev = &pdev->dev;
+	const char *name = dev_name(dev);
+	struct gpio_chip *gc;
+	struct resource *res;
+	int ret;
+
+	gs = devm_kzalloc(dev, sizeof(*gs), GFP_KERNEL);
+	if (!gs)
+		return -ENOMEM;
+
+	/* All 3 YU GPIO block address */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, GPIO_BLOCKS);
+	if (!res)
+		return -ENODEV;
+
+	gs->gpio_io = devm_ioremap(dev, res->start, resource_size(res));
+	if (!gs->gpio_io)
+		return -ENOMEM;
+
+	/* YU ARM GPIO Lock address */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, ARM_GPIO_LOCK);
+	if (!res)
+		return -ENOMEM;
+
+	gs->arm_gpio_lock_io = devm_ioremap_resource(dev, res);
+	if (IS_ERR(gs->arm_gpio_lock_io))
+		return PTR_ERR(gs->arm_gpio_lock_io);
+
+	gc = &gs->gc;
+	gc->direction_input = mlxbf2_gpio_direction_input;
+	gc->direction_output = mlxbf2_gpio_direction_output;
+	gc->get = mlxbf2_gpio_get;
+	gc->set = mlxbf2_gpio_set;
+	gc->label = name;
+	gc->parent = dev;
+	gc->owner = THIS_MODULE;
+	gc->base = -1;
+	gc->ngpio = BF2_HOST_GPIO_NUM;
+
+	spin_lock_init(&gs->lock);
+
+	platform_set_drvdata(pdev, gs);
+
+	ret = devm_gpiochip_add_data(dev, &gs->gc, gs);
+	if (ret) {
+		dev_err(dev, "Failed adding memory mapped gpiochip\n");
+		return ret;
+	}
+
+	dev_info(dev, "Registered Mellanox BlueField 2 GPIO");
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int mlxbf2_gpio_suspend(struct platform_device *pdev,
+				pm_message_t state)
+{
+	struct mlxbf2_gpio_state *gs = platform_get_drvdata(pdev);
+	unsigned int blk;
+
+	for (blk = GPIO_BLOCK0; blk < YU_GPIO_BLOCKS; blk++) {
+		gs->csave_regs->gpio_mode0[blk] = readl(gs->gpio_io +
+		    YU_GPIO_BLOCK_STRIDE(blk) + YU_GPIO_MODE0);
+		gs->csave_regs->gpio_mode1[blk] = readl(gs->gpio_io +
+		    YU_GPIO_BLOCK_STRIDE(blk) + YU_GPIO_MODE1);
+	}
+
+	return 0;
+}
+
+static int mlxbf2_gpio_resume(struct platform_device *pdev)
+{
+	struct mlxbf2_gpio_state *gs = platform_get_drvdata(pdev);
+	unsigned int blk;
+
+	for (blk = GPIO_BLOCK0; blk < YU_GPIO_BLOCKS; blk++) {
+		writel(gs->csave_regs->gpio_mode0[blk], gs->gpio_io +
+		    YU_GPIO_BLOCK_STRIDE(blk) + YU_GPIO_MODE0);
+		writel(gs->csave_regs->gpio_mode1[blk], gs->gpio_io +
+		    YU_GPIO_BLOCK_STRIDE(blk) + YU_GPIO_MODE1);
+	}
+
+	return 0;
+}
+#endif
+
+static const struct acpi_device_id mlxbf2_gpio_acpi_match[] = {
+	{ "MLNXBF22", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, mlxbf2_gpio_acpi_match);
+
+static struct platform_driver mlxbf2_gpio_driver = {
+	.driver = {
+		.name = "mlxbf2_gpio",
+		.acpi_match_table = ACPI_PTR(mlxbf2_gpio_acpi_match),
+	},
+	.probe    = mlxbf2_gpio_probe,
+#ifdef CONFIG_PM
+	.suspend  = mlxbf2_gpio_suspend,
+	.resume   = mlxbf2_gpio_resume,
+#endif
+};
+
+module_platform_driver(mlxbf2_gpio_driver);
+
+MODULE_DESCRIPTION("Mellanox BlueField 2 GPIO Driver");
+MODULE_AUTHOR("Mellanox Technologies");
+MODULE_LICENSE("GPL v2");
-- 
2.1.2

