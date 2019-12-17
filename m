Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5532512277B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 10:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfLQJVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 04:21:00 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:16892 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbfLQJU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 04:20:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576574458; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=PlIaJ4ZqEnoCA+hUESMOQjOQKmzzZq0WvaSfGafB3xY=; b=lt+uD0frOqheKQj1V0kzN0O54Rn8IyhI75qWXHrUIMGgmDk7omS9iW5basifgxeimZad0YgS
 gkSWlpc/VdrUV44ztBoRMT9NPoEWIf4Eabxz1cThIz7cY11hovk25OXIWfKcLpHh5GhMSbbJ
 3EIcrtivngYtE8muIuWEHKLCVgw=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df89df6.7f2d925816c0-smtp-out-n03;
 Tue, 17 Dec 2019 09:20:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E4538C4479C; Tue, 17 Dec 2019 09:20:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from sthella-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sthella)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 383A4C447A9;
        Tue, 17 Dec 2019 09:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 383A4C447A9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sthella@codeaurora.org
From:   Shyam Kumar Thella <sthella@codeaurora.org>
To:     srinivas.kandagatla@linaro.org
Cc:     Shyam Kumar Thella <sthella@codeaurora.org>, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] nvmem: add QTI SDAM driver
Date:   Tue, 17 Dec 2019 14:50:32 +0530
Message-Id: <1576574432-9649-1-git-send-email-sthella@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QTI SDAM driver allows PMIC peripherals to access the shared memory
that is available on QTI PMICs.

Change-Id: I40005646ab1fbba9e0e4aa68e0a61cfbc7b51ba6
Signed-off-by: Shyam Kumar Thella <sthella@codeaurora.org>
---
 drivers/nvmem/Kconfig          |   8 ++
 drivers/nvmem/Makefile         |   1 +
 drivers/nvmem/qcom-spmi-sdam.c | 197 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+)
 create mode 100644 drivers/nvmem/qcom-spmi-sdam.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 73567e9..35efab1 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -109,6 +109,14 @@ config QCOM_QFPROM
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem_qfprom.
 
+config NVMEM_SPMI_SDAM
+	tristate "SPMI SDAM Support"
+	depends on SPMI
+	help
+	  This driver supports the Shared Direct Access Memory Module on
+	  Qualcomm Technologies, Inc. PMICs. It provides the clients
+	  an interface to read/write to the SDAM module's shared memory.
+
 config ROCKCHIP_EFUSE
 	tristate "Rockchip eFuse Support"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 9e66782..877a0b0 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_MTK_EFUSE)		+= nvmem_mtk-efuse.o
 nvmem_mtk-efuse-y		:= mtk-efuse.o
 obj-$(CONFIG_QCOM_QFPROM)	+= nvmem_qfprom.o
 nvmem_qfprom-y			:= qfprom.o
+obj-$(CONFIG_NVMEM_SPMI_SDAM)	+= qcom-spmi-sdam.o
 obj-$(CONFIG_ROCKCHIP_EFUSE)	+= nvmem_rockchip_efuse.o
 nvmem_rockchip_efuse-y		:= rockchip-efuse.o
 obj-$(CONFIG_ROCKCHIP_OTP)	+= nvmem-rockchip-otp.o
diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
new file mode 100644
index 0000000..e80a446
--- /dev/null
+++ b/drivers/nvmem/qcom-spmi-sdam.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017 The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/nvmem-provider.h>
+#include <linux/regmap.h>
+
+#define SDAM_MEM_START			0x40
+#define REGISTER_MAP_ID			0x40
+#define REGISTER_MAP_VERSION		0x41
+#define SDAM_SIZE			0x44
+#define SDAM_PBS_TRIG_SET		0xE5
+#define SDAM_PBS_TRIG_CLR		0xE6
+
+struct sdam_chip {
+	struct platform_device		*pdev;
+	struct regmap			*regmap;
+	int				base;
+	int				size;
+};
+
+/* read only register offsets */
+static const u8 sdam_ro_map[] = {
+	REGISTER_MAP_ID,
+	REGISTER_MAP_VERSION,
+	SDAM_SIZE
+};
+
+static bool is_valid(struct sdam_chip *sdam, unsigned int offset, size_t len)
+{
+	int sdam_mem_end = SDAM_MEM_START + sdam->size - 1;
+
+	if (!len)
+		return false;
+
+	if (offset >= SDAM_MEM_START && offset <= sdam_mem_end
+				&& (offset + len - 1) <= sdam_mem_end)
+		return true;
+	else if ((offset == SDAM_PBS_TRIG_SET || offset == SDAM_PBS_TRIG_CLR)
+				&& (len == 1))
+		return true;
+
+	return false;
+}
+
+static bool is_ro(unsigned int offset, size_t len)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sdam_ro_map); i++)
+		if (offset <= sdam_ro_map[i] && (offset + len) > sdam_ro_map[i])
+			return true;
+
+	return false;
+}
+
+static int sdam_read(void *priv, unsigned int offset, void *val, size_t bytes)
+{
+	struct sdam_chip *sdam = priv;
+	int rc;
+
+	if (!is_valid(sdam, offset, bytes)) {
+		pr_err("Invalid SDAM offset 0x%02x len=%zd\n", offset, bytes);
+		return -EINVAL;
+	}
+
+	rc = regmap_bulk_read(sdam->regmap, sdam->base + offset, val, bytes);
+	if (rc < 0)
+		pr_err("Failed to read SDAM offset 0x%02x len=%zd, rc=%d\n",
+						offset, bytes, rc);
+
+	return rc;
+}
+
+static int sdam_write(void *priv, unsigned int offset, void *val, size_t bytes)
+{
+	struct sdam_chip *sdam = priv;
+	int rc;
+
+	if (!is_valid(sdam, offset, bytes)) {
+		pr_err("Invalid SDAM offset 0x%02x len=%zd\n", offset, bytes);
+		return -EINVAL;
+	}
+
+	if (is_ro(offset, bytes)) {
+		pr_err("Invalid write offset 0x%02x len=%zd\n", offset, bytes);
+		return -EINVAL;
+	}
+
+	rc = regmap_bulk_write(sdam->regmap, sdam->base + offset, val, bytes);
+	if (rc < 0)
+		pr_err("Failed to write SDAM offset 0x%02x len=%zd, rc=%d\n",
+						offset, bytes, rc);
+
+	return rc;
+}
+
+static int sdam_probe(struct platform_device *pdev)
+{
+	struct sdam_chip *sdam;
+	struct nvmem_device *nvmem;
+	struct nvmem_config *sdam_config;
+	unsigned int val = 0;
+	int rc;
+
+	sdam = devm_kzalloc(&pdev->dev, sizeof(*sdam), GFP_KERNEL);
+	if (!sdam)
+		return -ENOMEM;
+
+	sdam_config = devm_kzalloc(&pdev->dev, sizeof(*sdam_config),
+							GFP_KERNEL);
+	if (!sdam_config)
+		return -ENOMEM;
+
+	sdam->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!sdam->regmap) {
+		pr_err("Failed to get regmap handle\n");
+		return -ENXIO;
+	}
+
+	rc = of_property_read_u32(pdev->dev.of_node, "reg", &sdam->base);
+	if (rc < 0) {
+		pr_err("Failed to get SDAM base, rc=%d\n", rc);
+		return -EINVAL;
+	}
+
+	rc = regmap_read(sdam->regmap, sdam->base + SDAM_SIZE, &val);
+	if (rc < 0) {
+		pr_err("Failed to read SDAM_SIZE rc=%d\n", rc);
+		return -EINVAL;
+	}
+	sdam->size = val * 32;
+
+	sdam_config->dev = &pdev->dev;
+	sdam_config->name = "spmi_sdam";
+	sdam_config->id = pdev->id;
+	sdam_config->owner = THIS_MODULE,
+	sdam_config->stride = 1;
+	sdam_config->word_size = 1;
+	sdam_config->reg_read = sdam_read;
+	sdam_config->reg_write = sdam_write;
+	sdam_config->priv = sdam;
+
+	nvmem = nvmem_register(sdam_config);
+	if (IS_ERR(nvmem)) {
+		pr_err("Failed to register SDAM nvmem device rc=%ld\n",
+						PTR_ERR(nvmem));
+		return -ENXIO;
+	}
+	platform_set_drvdata(pdev, nvmem);
+
+	pr_info("SDAM base=0x%04x size=%d registered successfully\n",
+						sdam->base, sdam->size);
+
+	return 0;
+}
+
+static int sdam_remove(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
+
+	return nvmem_unregister(nvmem);
+}
+
+static const struct of_device_id sdam_match_table[] = {
+	{.compatible = "qcom,spmi-sdam"},
+	{},
+};
+
+static struct platform_driver sdam_driver = {
+	.driver = {
+		.name = "qcom,spmi-sdam",
+		.of_match_table = sdam_match_table,
+	},
+	.probe		= sdam_probe,
+	.remove		= sdam_remove,
+};
+
+static int __init sdam_init(void)
+{
+	return platform_driver_register(&sdam_driver);
+}
+subsys_initcall(sdam_init);
+
+static void __exit sdam_exit(void)
+{
+	return platform_driver_unregister(&sdam_driver);
+}
+module_exit(sdam_exit);
+
+MODULE_DESCRIPTION("QCOM SPMI SDAM driver");
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project
