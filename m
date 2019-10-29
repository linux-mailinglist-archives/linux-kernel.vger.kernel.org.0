Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A5EE875B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 12:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387550AbfJ2Lnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 07:43:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44042 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732968AbfJ2Lnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:43:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so13239669wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 04:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LgzJ7pQFCKff9Xs1hMxqesT3oy4xl0UnE9H/XfObPj4=;
        b=nrfkJyxmWU9exXhmfEl6xTODynSnW4XMX8danVW0qMRR7E0U+wbZjx5OA/rBD43yfF
         rhdnqOiOqE1WGpYtJ/UfX1IxlYQfbLU/FLPa3gLP3SjAUfyRNI5MIg2D79W3LXqQRld4
         mH+kvyi/hTMPzTGZanrw32jQeclKXqSmP/ownCoIE90Y2G6a/CIWr298bCVkJvLJHpFn
         IApqOZSpabb2ac2d54zReQkiq8BCuw5UoZ/5ByK8oFOIoi+mySy5QW5GObbpp5Mu7Tlb
         0Q50GChJ/BWlF89JKK+pwDdVGqEZQvaHc2AKU3mlAfOydAtY0SQh1PLkco14ZLolKxVN
         gIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LgzJ7pQFCKff9Xs1hMxqesT3oy4xl0UnE9H/XfObPj4=;
        b=muYPPSXb9j9MTeld2T75VeDo9GRzxV9IUxkJ+Kfv71B2K91EMO4NhE4mADCmcSDrYy
         fRHe5oaBjDD5aH4axsjAINXdDjJzfOtN6eqyEstGGAl7g9xXWXpRXNdE6WiedcitygYr
         q7+0i6mjjCxT61xHgp0Hj47S7Z2xT9tR1OoDqhQCOFRJmzB47/HPqdwqkwko5dSPSqs3
         F6nwKS1pTaaotgDjJQ3X9SqbMKHUyqF0Le871Df3JOMZAdeccWbegWZ1VUw78jww6G4x
         WoljWZBDYFbINqhf9N+1YQY1iiFgmNf6FON2Q8ow6l7wIvGnqvX/Iut09iK6M5/IJ5Lq
         XadA==
X-Gm-Message-State: APjAAAUIDnajuSmQokWVJ9ZRFWqDuiwk+dWPpRXDRxYVkxIai1kezTCm
        btfZvhi5qNDxkRiWVembO7kudY1fsh8=
X-Google-Smtp-Source: APXvYqzxo7hr6JNeb0dOaHQBCgmvHrgPhDSnjddqLuyd/WuJgyC2VOcRkWcjXVABnN1Ih8RZH2XsrQ==
X-Received: by 2002:adf:d846:: with SMTP id k6mr3367492wrl.178.1572349420821;
        Tue, 29 Oct 2019 04:43:40 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q25sm26559864wra.3.2019.10.29.04.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 04:43:39 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Freeman Liu <freeman.liu@unisoc.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/10] nvmem: sprd: Add Spreadtrum SoCs eFuse support
Date:   Tue, 29 Oct 2019 11:42:37 +0000
Message-Id: <20191029114240.14905-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029114240.14905-1-srinivas.kandagatla@linaro.org>
References: <20191029114240.14905-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Freeman Liu <freeman.liu@unisoc.com>

The Spreadtrum eFuse controller is widely used to dump chip ID,
configuration setting, function select and so on, as well as
supporting one-time programming.

Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig      |  11 +
 drivers/nvmem/Makefile     |   2 +
 drivers/nvmem/sprd-efuse.c | 424 +++++++++++++++++++++++++++++++++++++
 3 files changed, 437 insertions(+)
 create mode 100644 drivers/nvmem/sprd-efuse.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index c2ec750cae6e..8fd425d38d97 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -230,4 +230,15 @@ config NVMEM_ZYNQMP
 
 	  If sure, say yes. If unsure, say no.
 
+config SPRD_EFUSE
+	tristate "Spreadtrum SoC eFuse Support"
+	depends on ARCH_SPRD || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This is a simple driver to dump specified values of Spreadtrum
+	  SoCs from eFuse.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-sprd-efuse.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index e5c153d99a67..7c19870a6bbe 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -50,3 +50,5 @@ obj-$(CONFIG_SC27XX_EFUSE)	+= nvmem-sc27xx-efuse.o
 nvmem-sc27xx-efuse-y		:= sc27xx-efuse.o
 obj-$(CONFIG_NVMEM_ZYNQMP)	+= nvmem_zynqmp_nvmem.o
 nvmem_zynqmp_nvmem-y		:= zynqmp_nvmem.o
+obj-$(CONFIG_SPRD_EFUSE)	+= nvmem_sprd_efuse.o
+nvmem_sprd_efuse-y		:= sprd-efuse.o
diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
new file mode 100644
index 000000000000..2f1e0fbd1901
--- /dev/null
+++ b/drivers/nvmem/sprd-efuse.c
@@ -0,0 +1,424 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019 Spreadtrum Communications Inc.
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/hwspinlock.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#define SPRD_EFUSE_ENABLE		0x20
+#define SPRD_EFUSE_ERR_FLAG		0x24
+#define SPRD_EFUSE_ERR_CLR		0x28
+#define SPRD_EFUSE_MAGIC_NUM		0x2c
+#define SPRD_EFUSE_FW_CFG		0x50
+#define SPRD_EFUSE_PW_SWT		0x54
+#define SPRD_EFUSE_MEM(val)		(0x1000 + ((val) << 2))
+
+#define SPRD_EFUSE_VDD_EN		BIT(0)
+#define SPRD_EFUSE_AUTO_CHECK_EN	BIT(1)
+#define SPRD_EFUSE_DOUBLE_EN		BIT(2)
+#define SPRD_EFUSE_MARGIN_RD_EN		BIT(3)
+#define SPRD_EFUSE_LOCK_WR_EN		BIT(4)
+
+#define SPRD_EFUSE_ERR_CLR_MASK		GENMASK(13, 0)
+
+#define SPRD_EFUSE_ENK1_ON		BIT(0)
+#define SPRD_EFUSE_ENK2_ON		BIT(1)
+#define SPRD_EFUSE_PROG_EN		BIT(2)
+
+#define SPRD_EFUSE_MAGIC_NUMBER		0x8810
+
+/* Block width (bytes) definitions */
+#define SPRD_EFUSE_BLOCK_WIDTH		4
+
+/*
+ * The Spreadtrum AP efuse contains 2 parts: normal efuse and secure efuse,
+ * and we can only access the normal efuse in kernel. So define the normal
+ * block offset index and normal block numbers.
+ */
+#define SPRD_EFUSE_NORMAL_BLOCK_NUMS	24
+#define SPRD_EFUSE_NORMAL_BLOCK_OFFSET	72
+
+/* Timeout (ms) for the trylock of hardware spinlocks */
+#define SPRD_EFUSE_HWLOCK_TIMEOUT	5000
+
+/*
+ * Since different Spreadtrum SoC chip can have different normal block numbers
+ * and offset. And some SoC can support block double feature, which means
+ * when reading or writing data to efuse memory, the controller can save double
+ * data in case one data become incorrect after a long period.
+ *
+ * Thus we should save them in the device data structure.
+ */
+struct sprd_efuse_variant_data {
+	u32 blk_nums;
+	u32 blk_offset;
+	bool blk_double;
+};
+
+struct sprd_efuse {
+	struct device *dev;
+	struct clk *clk;
+	struct hwspinlock *hwlock;
+	struct mutex mutex;
+	void __iomem *base;
+	const struct sprd_efuse_variant_data *data;
+};
+
+static const struct sprd_efuse_variant_data ums312_data = {
+	.blk_nums = SPRD_EFUSE_NORMAL_BLOCK_NUMS,
+	.blk_offset = SPRD_EFUSE_NORMAL_BLOCK_OFFSET,
+	.blk_double = false,
+};
+
+/*
+ * On Spreadtrum platform, we have multi-subsystems will access the unique
+ * efuse controller, so we need one hardware spinlock to synchronize between
+ * the multiple subsystems.
+ */
+static int sprd_efuse_lock(struct sprd_efuse *efuse)
+{
+	int ret;
+
+	mutex_lock(&efuse->mutex);
+
+	ret = hwspin_lock_timeout_raw(efuse->hwlock,
+				      SPRD_EFUSE_HWLOCK_TIMEOUT);
+	if (ret) {
+		dev_err(efuse->dev, "timeout get the hwspinlock\n");
+		mutex_unlock(&efuse->mutex);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void sprd_efuse_unlock(struct sprd_efuse *efuse)
+{
+	hwspin_unlock_raw(efuse->hwlock);
+	mutex_unlock(&efuse->mutex);
+}
+
+static void sprd_efuse_set_prog_power(struct sprd_efuse *efuse, bool en)
+{
+	u32 val = readl(efuse->base + SPRD_EFUSE_PW_SWT);
+
+	if (en)
+		val &= ~SPRD_EFUSE_ENK2_ON;
+	else
+		val &= ~SPRD_EFUSE_ENK1_ON;
+
+	writel(val, efuse->base + SPRD_EFUSE_PW_SWT);
+
+	/* Open or close efuse power need wait 1000us to make power stable. */
+	usleep_range(1000, 1200);
+
+	if (en)
+		val |= SPRD_EFUSE_ENK1_ON;
+	else
+		val |= SPRD_EFUSE_ENK2_ON;
+
+	writel(val, efuse->base + SPRD_EFUSE_PW_SWT);
+
+	/* Open or close efuse power need wait 1000us to make power stable. */
+	usleep_range(1000, 1200);
+}
+
+static void sprd_efuse_set_read_power(struct sprd_efuse *efuse, bool en)
+{
+	u32 val = readl(efuse->base + SPRD_EFUSE_ENABLE);
+
+	if (en)
+		val |= SPRD_EFUSE_VDD_EN;
+	else
+		val &= ~SPRD_EFUSE_VDD_EN;
+
+	writel(val, efuse->base + SPRD_EFUSE_ENABLE);
+
+	/* Open or close efuse power need wait 1000us to make power stable. */
+	usleep_range(1000, 1200);
+}
+
+static void sprd_efuse_set_prog_lock(struct sprd_efuse *efuse, bool en)
+{
+	u32 val = readl(efuse->base + SPRD_EFUSE_ENABLE);
+
+	if (en)
+		val |= SPRD_EFUSE_LOCK_WR_EN;
+	else
+		val &= ~SPRD_EFUSE_LOCK_WR_EN;
+
+	writel(val, efuse->base + SPRD_EFUSE_ENABLE);
+}
+
+static void sprd_efuse_set_auto_check(struct sprd_efuse *efuse, bool en)
+{
+	u32 val = readl(efuse->base + SPRD_EFUSE_ENABLE);
+
+	if (en)
+		val |= SPRD_EFUSE_AUTO_CHECK_EN;
+	else
+		val &= ~SPRD_EFUSE_AUTO_CHECK_EN;
+
+	writel(val, efuse->base + SPRD_EFUSE_ENABLE);
+}
+
+static void sprd_efuse_set_data_double(struct sprd_efuse *efuse, bool en)
+{
+	u32 val = readl(efuse->base + SPRD_EFUSE_ENABLE);
+
+	if (en)
+		val |= SPRD_EFUSE_DOUBLE_EN;
+	else
+		val &= ~SPRD_EFUSE_DOUBLE_EN;
+
+	writel(val, efuse->base + SPRD_EFUSE_ENABLE);
+}
+
+static void sprd_efuse_set_prog_en(struct sprd_efuse *efuse, bool en)
+{
+	u32 val = readl(efuse->base + SPRD_EFUSE_PW_SWT);
+
+	if (en)
+		val |= SPRD_EFUSE_PROG_EN;
+	else
+		val &= ~SPRD_EFUSE_PROG_EN;
+
+	writel(val, efuse->base + SPRD_EFUSE_PW_SWT);
+}
+
+static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
+			       bool lock, u32 *data)
+{
+	u32 status;
+	int ret = 0;
+
+	/*
+	 * We need set the correct magic number before writing the efuse to
+	 * allow programming, and block other programming until we clear the
+	 * magic number.
+	 */
+	writel(SPRD_EFUSE_MAGIC_NUMBER,
+	       efuse->base + SPRD_EFUSE_MAGIC_NUM);
+
+	/*
+	 * Power on the efuse, enable programme and enable double data
+	 * if asked.
+	 */
+	sprd_efuse_set_prog_power(efuse, true);
+	sprd_efuse_set_prog_en(efuse, true);
+	sprd_efuse_set_data_double(efuse, doub);
+
+	/*
+	 * Enable the auto-check function to validate if the programming is
+	 * successful.
+	 */
+	sprd_efuse_set_auto_check(efuse, true);
+
+	writel(*data, efuse->base + SPRD_EFUSE_MEM(blk));
+
+	/* Disable auto-check and data double after programming */
+	sprd_efuse_set_auto_check(efuse, false);
+	sprd_efuse_set_data_double(efuse, false);
+
+	/*
+	 * Check the efuse error status, if the programming is successful,
+	 * we should lock this efuse block to avoid programming again.
+	 */
+	status = readl(efuse->base + SPRD_EFUSE_ERR_FLAG);
+	if (status) {
+		dev_err(efuse->dev,
+			"write error status %d of block %d\n", ret, blk);
+
+		writel(SPRD_EFUSE_ERR_CLR_MASK,
+		       efuse->base + SPRD_EFUSE_ERR_CLR);
+		ret = -EBUSY;
+	} else {
+		sprd_efuse_set_prog_lock(efuse, lock);
+		writel(*data, efuse->base + SPRD_EFUSE_MEM(blk));
+		sprd_efuse_set_prog_lock(efuse, false);
+	}
+
+	sprd_efuse_set_prog_power(efuse, false);
+	writel(0, efuse->base + SPRD_EFUSE_MAGIC_NUM);
+
+	return ret;
+}
+
+static int sprd_efuse_raw_read(struct sprd_efuse *efuse, int blk, u32 *val,
+			       bool doub)
+{
+	u32 status;
+
+	/*
+	 * Need power on the efuse before reading data from efuse, and will
+	 * power off the efuse after reading process.
+	 */
+	sprd_efuse_set_read_power(efuse, true);
+
+	/* Enable double data if asked */
+	sprd_efuse_set_data_double(efuse, doub);
+
+	/* Start to read data from efuse block */
+	*val = readl(efuse->base + SPRD_EFUSE_MEM(blk));
+
+	/* Disable double data */
+	sprd_efuse_set_data_double(efuse, false);
+
+	/* Power off the efuse */
+	sprd_efuse_set_read_power(efuse, false);
+
+	/*
+	 * Check the efuse error status and clear them if there are some
+	 * errors occurred.
+	 */
+	status = readl(efuse->base + SPRD_EFUSE_ERR_FLAG);
+	if (status) {
+		dev_err(efuse->dev,
+			"read error status %d of block %d\n", status, blk);
+
+		writel(SPRD_EFUSE_ERR_CLR_MASK,
+		       efuse->base + SPRD_EFUSE_ERR_CLR);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int sprd_efuse_read(void *context, u32 offset, void *val, size_t bytes)
+{
+	struct sprd_efuse *efuse = context;
+	bool blk_double = efuse->data->blk_double;
+	u32 index = offset / SPRD_EFUSE_BLOCK_WIDTH + efuse->data->blk_offset;
+	u32 blk_offset = (offset % SPRD_EFUSE_BLOCK_WIDTH) * BITS_PER_BYTE;
+	u32 data;
+	int ret;
+
+	ret = sprd_efuse_lock(efuse);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(efuse->clk);
+	if (ret)
+		goto unlock;
+
+	ret = sprd_efuse_raw_read(efuse, index, &data, blk_double);
+	if (!ret) {
+		data >>= blk_offset;
+		memcpy(val, &data, bytes);
+	}
+
+	clk_disable_unprepare(efuse->clk);
+
+unlock:
+	sprd_efuse_unlock(efuse);
+	return ret;
+}
+
+static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
+{
+	struct sprd_efuse *efuse = context;
+	int ret;
+
+	ret = sprd_efuse_lock(efuse);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(efuse->clk);
+	if (ret)
+		goto unlock;
+
+	ret = sprd_efuse_raw_prog(efuse, offset, false, false, val);
+
+	clk_disable_unprepare(efuse->clk);
+
+unlock:
+	sprd_efuse_unlock(efuse);
+	return ret;
+}
+
+static int sprd_efuse_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct nvmem_device *nvmem;
+	struct nvmem_config econfig = { };
+	struct sprd_efuse *efuse;
+	const struct sprd_efuse_variant_data *pdata;
+	int ret;
+
+	pdata = of_device_get_match_data(&pdev->dev);
+	if (!pdata) {
+		dev_err(&pdev->dev, "No matching driver data found\n");
+		return -EINVAL;
+	}
+
+	efuse = devm_kzalloc(&pdev->dev, sizeof(*efuse), GFP_KERNEL);
+	if (!efuse)
+		return -ENOMEM;
+
+	efuse->base = devm_platform_ioremap_resource(pdev, 0);
+	if (!efuse->base)
+		return -ENOMEM;
+
+	ret = of_hwspin_lock_get_id(np, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get hwlock id\n");
+		return ret;
+	}
+
+	efuse->hwlock = devm_hwspin_lock_request_specific(&pdev->dev, ret);
+	if (!efuse->hwlock) {
+		dev_err(&pdev->dev, "failed to request hwlock\n");
+		return -ENXIO;
+	}
+
+	efuse->clk = devm_clk_get(&pdev->dev, "enable");
+	if (IS_ERR(efuse->clk)) {
+		dev_err(&pdev->dev, "failed to get enable clock\n");
+		return PTR_ERR(efuse->clk);
+	}
+
+	mutex_init(&efuse->mutex);
+	efuse->dev = &pdev->dev;
+	efuse->data = pdata;
+
+	econfig.stride = 1;
+	econfig.word_size = 1;
+	econfig.read_only = false;
+	econfig.name = "sprd-efuse";
+	econfig.size = efuse->data->blk_nums * SPRD_EFUSE_BLOCK_WIDTH;
+	econfig.reg_read = sprd_efuse_read;
+	econfig.reg_write = sprd_efuse_write;
+	econfig.priv = efuse;
+	econfig.dev = &pdev->dev;
+	nvmem = devm_nvmem_register(&pdev->dev, &econfig);
+	if (IS_ERR(nvmem)) {
+		dev_err(&pdev->dev, "failed to register nvmem\n");
+		return PTR_ERR(nvmem);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id sprd_efuse_of_match[] = {
+	{ .compatible = "sprd,ums312-efuse", .data = &ums312_data },
+	{ }
+};
+
+static struct platform_driver sprd_efuse_driver = {
+	.probe = sprd_efuse_probe,
+	.driver = {
+		.name = "sprd-efuse",
+		.of_match_table = sprd_efuse_of_match,
+	},
+};
+
+module_platform_driver(sprd_efuse_driver);
+
+MODULE_AUTHOR("Freeman Liu <freeman.liu@spreadtrum.com>");
+MODULE_DESCRIPTION("Spreadtrum AP efuse driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

