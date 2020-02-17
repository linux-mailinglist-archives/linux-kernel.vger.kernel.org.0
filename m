Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C889160CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 09:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgBQIPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 03:15:17 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51860 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbgBQIPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:15:17 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 01H8F432028939, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 01H8F432028939
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Feb 2020 16:15:04 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 17 Feb 2020 16:15:03 +0800
Received: from localhost.localdomain (172.21.83.110) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 17 Feb 2020 16:15:03 +0800
From:   <max.chou@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
        <hildawu@realtek.com>, <kidman@realtek.com>
Subject: [PATCH v2] Bluetooth: hci_h5: btrtl: Add support for RTL8822C
Date:   Mon, 17 Feb 2020 16:14:55 +0800
Message-ID: <20200217081455.30938-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.83.110]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB03.realtek.com.tw (172.21.6.96)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Chou <max.chou@realtek.com>

Add new compatible and FW loading support for RTL8822C.

Signed-off-by: Max Chou <max.chou@realtek.com>
---
Changes in v2:
- Separate the code description for ACPI and OF
- Note that forgiving my less experience, I can not find bt3wire.c from the
upstream. I just find hci_h5.c can support Realtek Bluetooth controller,
so I modify the code here for new chip support.
---
 drivers/bluetooth/Kconfig  |  2 +-
 drivers/bluetooth/btrtl.c  | 12 ++++++++++++
 drivers/bluetooth/hci_h5.c | 19 +++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index f7aa2dc1ff85..052020b07e56 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -211,7 +211,7 @@ config BT_HCIUART_RTL
 	depends on BT_HCIUART
 	depends on BT_HCIUART_SERDEV
 	depends on GPIOLIB
-	depends on ACPI
+	depends on (ACPI || SERIAL_DEV_CTRL_TTYPORT)
 	select BT_HCIUART_3WIRE
 	select BT_RTL
 	help
diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 577cfa3329db..67f4bc21e7c5 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -136,6 +136,18 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8761a_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8761a_config" },
 
+	/* 8822C with UART interface */
+	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV |
+			 IC_MATCH_FL_HCIBUS,
+	  .lmp_subver = RTL_ROM_LMP_8822B,
+	  .hci_rev = 0x000c,
+	  .hci_ver = 0x0a,
+	  .hci_bus = HCI_UART,
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8822cs_config" },
+
 	/* 8822C with USB interface */
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc),
 	  .config_needed = false,
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 0b14547482a7..4e4d58a73295 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -11,6 +11,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
 #include <linux/serdev.h>
 #include <linux/skbuff.h>
 
@@ -786,6 +787,7 @@ static const struct hci_uart_proto h5p = {
 static int h5_serdev_probe(struct serdev_device *serdev)
 {
 	const struct acpi_device_id *match;
+	const void *data;
 	struct device *dev = &serdev->dev;
 	struct h5 *h5;
 
@@ -810,8 +812,15 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 		if (h5->vnd->acpi_gpio_map)
 			devm_acpi_dev_add_driver_gpios(dev,
 						       h5->vnd->acpi_gpio_map);
+	} else {
+		data = of_device_get_match_data(dev);
+		if (!data)
+			return -ENODEV;
+
+		h5->vnd = (const struct h5_vnd *)data;
 	}
 
+
 	h5->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(h5->enable_gpio))
 		return PTR_ERR(h5->enable_gpio);
@@ -1003,6 +1012,15 @@ static const struct dev_pm_ops h5_serdev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(h5_serdev_suspend, h5_serdev_resume)
 };
 
+static const struct of_device_id rtl_bluetooth_of_match[] = {
+#ifdef CONFIG_BT_HCIUART_RTL
+	{ .compatible = "realtek,rtl8822cs-bt",
+	  .data = (const void *)&rtl_vnd },
+#endif
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rtl_bluetooth_of_match);
+
 static struct serdev_device_driver h5_serdev_driver = {
 	.probe = h5_serdev_probe,
 	.remove = h5_serdev_remove,
@@ -1010,6 +1028,7 @@ static struct serdev_device_driver h5_serdev_driver = {
 		.name = "hci_uart_h5",
 		.acpi_match_table = ACPI_PTR(h5_acpi_match),
 		.pm = &h5_serdev_pm_ops,
+		.of_match_table = rtl_bluetooth_of_match,
 	},
 };
 
-- 
2.17.1

