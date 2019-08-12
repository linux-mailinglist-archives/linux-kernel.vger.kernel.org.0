Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8128489872
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 10:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfHLIJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 04:09:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbfHLIJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:09:50 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7551D3381FFC3A810CA8;
        Mon, 12 Aug 2019 16:09:21 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 12 Aug 2019
 16:09:14 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] Bluetooth: hci_bcm: Fix -Wunused-const-variable warnings
Date:   Mon, 12 Aug 2019 14:22:11 +0800
Message-ID: <20190812062211.69984-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_ACPI is not set, gcc warn this:

drivers/bluetooth/hci_bcm.c:831:39: warning:
 acpi_bcm_int_last_gpios defined but not used [-Wunused-const-variable=]
drivers/bluetooth/hci_bcm.c:838:39: warning:
 acpi_bcm_int_first_gpios defined but not used [-Wunused-const-variable=]

move them to #ifdef CONFIG_ACPI block.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/bluetooth/hci_bcm.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ae2624f..4d9de20 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -824,6 +824,21 @@ static int bcm_resume(struct device *dev)
 }
 #endif
 
+/* Some firmware reports an IRQ which does not work (wrong pin in fw table?) */
+static const struct dmi_system_id bcm_broken_irq_dmi_table[] = {
+	{
+		.ident = "Meegopad T08",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR,
+					"To be filled by OEM."),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "T3 MRD"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V1.1"),
+		},
+	},
+	{ }
+};
+
+#ifdef CONFIG_ACPI
 static const struct acpi_gpio_params first_gpio = { 0, 0, false };
 static const struct acpi_gpio_params second_gpio = { 1, 0, false };
 static const struct acpi_gpio_params third_gpio = { 2, 0, false };
@@ -842,21 +857,6 @@ static const struct acpi_gpio_mapping acpi_bcm_int_first_gpios[] = {
 	{ },
 };
 
-/* Some firmware reports an IRQ which does not work (wrong pin in fw table?) */
-static const struct dmi_system_id bcm_broken_irq_dmi_table[] = {
-	{
-		.ident = "Meegopad T08",
-		.matches = {
-			DMI_EXACT_MATCH(DMI_BOARD_VENDOR,
-					"To be filled by OEM."),
-			DMI_EXACT_MATCH(DMI_BOARD_NAME, "T3 MRD"),
-			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V1.1"),
-		},
-	},
-	{ }
-};
-
-#ifdef CONFIG_ACPI
 static int bcm_resource(struct acpi_resource *ares, void *data)
 {
 	struct bcm_device *dev = data;
-- 
2.7.4


