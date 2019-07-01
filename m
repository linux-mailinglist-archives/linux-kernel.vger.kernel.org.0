Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B39F946461
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 18:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfFNQhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 12:37:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34906 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfFNQhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:37:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 11A7E28617D
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, kernel@collabora.com,
        dtor@chromium.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 09/10] mfd: cros_ec: Add convenience struct to define autodetectable CrOS EC subdevices
Date:   Fri, 14 Jun 2019 18:36:34 +0200
Message-Id: <20190614163635.22413-10-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614163635.22413-1-enric.balletbo@collabora.com>
References: <20190614163635.22413-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CrOS EC is gaining lots of subdevices that are autodetectable by
sending the EC_FEATURE_GET_CMD, it takes fair amount of boiler plate
code to add those devices. So, add a struct that can be used to quickly
add new subdevices without having to duplicate code.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Changes in v2: None

 drivers/mfd/cros_ec_dev.c | 132 +++++++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 58 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 68fa3a0ba4d6..a8e02a33f82b 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -46,6 +46,18 @@ struct cros_feature_to_name {
 	const char *desc;
 };
 
+/**
+ * cros_feature_to_cells - CrOS feature id to mfd cells association.
+ * @id: The feature identifier.
+ * @mfd_cells: Pointer to the array of mfd cells that needs to be added.
+ * @num_cells: Number of mfd cells into the array.
+ */
+struct cros_feature_to_cells {
+	unsigned int id;
+	const struct mfd_cell *mfd_cells;
+	unsigned int num_cells;
+};
+
 static const struct cros_feature_to_name cros_mcu_devices[] = {
 	{
 		.id	= EC_FEATURE_FINGERPRINT,
@@ -64,6 +76,48 @@ static const struct cros_feature_to_name cros_mcu_devices[] = {
 	},
 };
 
+static const struct mfd_cell cros_ec_cec_cells[] = {
+	{ .name = "cros-ec-cec", },
+};
+
+static const struct mfd_cell cros_ec_rtc_cells[] = {
+	{ .name = "cros-ec-rtc", },
+};
+
+static const struct mfd_cell cros_usbpd_charger_cells[] = {
+	{ .name = "cros-usbpd-charger", },
+	{ .name = "cros-usbpd-logger", },
+};
+
+static const struct cros_feature_to_cells cros_subdevices[] = {
+	{
+		.id		= EC_FEATURE_CEC,
+		.mfd_cells	= cros_ec_cec_cells,
+		.num_cells	= ARRAY_SIZE(cros_ec_cec_cells),
+	},
+	{
+		.id		= EC_FEATURE_RTC,
+		.mfd_cells	= cros_ec_rtc_cells,
+		.num_cells	= ARRAY_SIZE(cros_ec_rtc_cells),
+	},
+	{
+		.id		= EC_FEATURE_USB_PD,
+		.mfd_cells	= cros_usbpd_charger_cells,
+		.num_cells	= ARRAY_SIZE(cros_usbpd_charger_cells),
+	},
+};
+
+static const struct mfd_cell cros_ec_platform_cells[] = {
+	{ .name = "cros-ec-chardev", },
+	{ .name = "cros-ec-debugfs", },
+	{ .name = "cros-ec-lightbar", },
+	{ .name = "cros-ec-sysfs", },
+};
+
+static const struct mfd_cell cros_ec_vbc_cells[] = {
+	{ .name = "cros-ec-vbc", }
+};
+
 static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 {
 	struct cros_ec_command *msg;
@@ -223,30 +277,6 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 	kfree(msg);
 }
 
-static const struct mfd_cell cros_ec_cec_cells[] = {
-	{ .name = "cros-ec-cec" }
-};
-
-static const struct mfd_cell cros_ec_rtc_cells[] = {
-	{ .name = "cros-ec-rtc" }
-};
-
-static const struct mfd_cell cros_usbpd_charger_cells[] = {
-	{ .name = "cros-usbpd-charger" },
-	{ .name = "cros-usbpd-logger" },
-};
-
-static const struct mfd_cell cros_ec_platform_cells[] = {
-	{ .name = "cros-ec-chardev" },
-	{ .name = "cros-ec-debugfs" },
-	{ .name = "cros-ec-lightbar" },
-	{ .name = "cros-ec-sysfs" },
-};
-
-static const struct mfd_cell cros_ec_vbc_cells[] = {
-	{ .name = "cros-ec-vbc" }
-};
-
 static int ec_device_probe(struct platform_device *pdev)
 {
 	int retval = -ENOMEM;
@@ -304,42 +334,28 @@ static int ec_device_probe(struct platform_device *pdev)
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec);
 
-	/* Check whether this EC instance has CEC host command support */
-	if (cros_ec_check_features(ec, EC_FEATURE_CEC)) {
-		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-					 cros_ec_cec_cells,
-					 ARRAY_SIZE(cros_ec_cec_cells),
-					 NULL, 0, NULL);
-		if (retval)
-			dev_err(ec->dev,
-				"failed to add cros-ec-cec device: %d\n",
-				retval);
-	}
-
-	/* Check whether this EC instance has RTC host command support */
-	if (cros_ec_check_features(ec, EC_FEATURE_RTC)) {
-		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-					 cros_ec_rtc_cells,
-					 ARRAY_SIZE(cros_ec_rtc_cells),
-					 NULL, 0, NULL);
-		if (retval)
-			dev_err(ec->dev,
-				"failed to add cros-ec-rtc device: %d\n",
-				retval);
-	}
-
-	/* Check whether this EC instance has the PD charge manager */
-	if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
-		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-					 cros_usbpd_charger_cells,
-					 ARRAY_SIZE(cros_usbpd_charger_cells),
-					 NULL, 0, NULL);
-		if (retval)
-			dev_err(ec->dev,
-				"failed to add cros-usbpd-charger device: %d\n",
-				retval);
+	/*
+	 * The following subdevices can be detected by sending the
+	 * EC_FEATURE_GET_CMD Embedded Controller device.
+	 */
+	for (i = 0; i < ARRAY_SIZE(cros_subdevices); i++) {
+		if (cros_ec_check_features(ec, cros_subdevices[i].id)) {
+			retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
+						 cros_subdevices[i].mfd_cells,
+						 cros_subdevices[i].num_cells,
+						 NULL, 0, NULL);
+			if (retval)
+				dev_err(ec->dev,
+					"failed to add %s subdevice: %d\n",
+					cros_subdevices[i].mfd_cells->name,
+					retval);
+		}
 	}
 
+	/*
+	 * The following subdevices cannot be detected by sending the
+	 * EC_FEATURE_GET_CMD to the Embedded Controller device.
+	 */
 	retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
 				 cros_ec_platform_cells,
 				 ARRAY_SIZE(cros_ec_platform_cells),
-- 
2.20.1

