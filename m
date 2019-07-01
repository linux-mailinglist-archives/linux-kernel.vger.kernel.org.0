Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93E074646A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 18:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfFNQh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 12:37:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34898 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfFNQhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:37:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4E5B7286173
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, kernel@collabora.com,
        dtor@chromium.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 08/10] mfd: cros_ec: Add convenience struct to define dedicated CrOS EC MCUs
Date:   Fri, 14 Jun 2019 18:36:33 +0200
Message-Id: <20190614163635.22413-9-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614163635.22413-1-enric.balletbo@collabora.com>
References: <20190614163635.22413-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the increasing use of dedicated CrOS EC MCUs, it takes a fair amount
of boiler plate code to add those devices, add a struct that can be used
to specify a dedicated CrOS EC MCU so we can just add a new item to it to
define a new dedicated MCU.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Changes in v2: None

 drivers/mfd/cros_ec_dev.c | 72 +++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 818eb1ba77bb..68fa3a0ba4d6 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -34,6 +34,36 @@ static struct class cros_class = {
 	.name           = "chromeos",
 };
 
+/**
+ * cros_feature_to_name - CrOS feature id to name/short description.
+ * @id: The feature identifier.
+ * @name: Device name associated with the feature id.
+ * @desc: Short name that will be displayed.
+ */
+struct cros_feature_to_name {
+	unsigned int id;
+	const char *name;
+	const char *desc;
+};
+
+static const struct cros_feature_to_name cros_mcu_devices[] = {
+	{
+		.id	= EC_FEATURE_FINGERPRINT,
+		.name	= CROS_EC_DEV_FP_NAME,
+		.desc	= "Fingerprint",
+	},
+	{
+		.id	= EC_FEATURE_ISH,
+		.name	= CROS_EC_DEV_ISH_NAME,
+		.desc	= "Integrated Sensor Hub",
+	},
+	{
+		.id	= EC_FEATURE_TOUCHPAD,
+		.name	= CROS_EC_DEV_TP_NAME,
+		.desc	= "Touchpad",
+	},
+};
+
 static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 {
 	struct cros_ec_command *msg;
@@ -224,6 +254,7 @@ static int ec_device_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
 	struct cros_ec_dev *ec = kzalloc(sizeof(*ec), GFP_KERNEL);
+	int i;
 
 	if (!ec)
 		return retval;
@@ -236,37 +267,20 @@ static int ec_device_probe(struct platform_device *pdev)
 	ec->features[1] = -1U; /* Not cached yet */
 	device_initialize(&ec->class_dev);
 
-	/* Check whether this is actually a Fingerprint MCU rather than an EC */
-	if (cros_ec_check_features(ec, EC_FEATURE_FINGERPRINT)) {
-		dev_info(dev, "CrOS Fingerprint MCU detected.\n");
+	for (i = 0; i < ARRAY_SIZE(cros_mcu_devices); i++) {
 		/*
-		 * Help userspace differentiating ECs from FP MCU,
-		 * regardless of the probing order.
+		 * Check whether this is actually a dedicated MCU rather
+		 * than an standard EC.
 		 */
-		ec_platform->ec_name = CROS_EC_DEV_FP_NAME;
-	}
-
-	/*
-	 * Check whether this is actually an Integrated Sensor Hub (ISH)
-	 * rather than an EC.
-	 */
-	if (cros_ec_check_features(ec, EC_FEATURE_ISH)) {
-		dev_info(dev, "CrOS ISH MCU detected.\n");
-		/*
-		 * Help userspace differentiating ECs from ISH MCU,
-		 * regardless of the probing order.
-		 */
-		ec_platform->ec_name = CROS_EC_DEV_ISH_NAME;
-	}
-
-	/* Check whether this is actually a Touchpad MCU rather than an EC */
-	if (cros_ec_check_features(ec, EC_FEATURE_TOUCHPAD)) {
-		dev_info(dev, "CrOS Touchpad MCU detected.\n");
-		/*
-		 * Help userspace differentiating ECs from TP MCU,
-		 * regardless of the probing order.
-		 */
-		ec_platform->ec_name = CROS_EC_DEV_TP_NAME;
+		if (cros_ec_check_features(ec, cros_mcu_devices[i].id)) {
+			dev_info(dev, "CrOS %s MCU detected\n",
+				 cros_mcu_devices[i].desc);
+			/*
+			 * Help userspace differentiating ECs from other MCU,
+			 * regardless of the probing order.
+			 */
+			ec_platform->ec_name = cros_mcu_devices[i].name;
+		}
 	}
 
 	/*
-- 
2.20.1

