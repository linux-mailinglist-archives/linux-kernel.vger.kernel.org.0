Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7BE9B001
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 14:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394936AbfHWMy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 08:54:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46422 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfHWMy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:54:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4FC4328D33D
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 08/11] mfd: cros_ec: Add convenience struct to define dedicated CrOS EC MCUs
Date:   Fri, 23 Aug 2019 14:53:28 +0200
Message-Id: <20190823125331.5070-9-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190823125331.5070-1-enric.balletbo@collabora.com>
References: <20190823125331.5070-1-enric.balletbo@collabora.com>
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
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Tested-by: Gwendal Grignou <gwendal@chromium.org>
---

Changes in v6:
- Add a break statement once the MCU type has been determined (Lee Jones)

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mfd/cros_ec_dev.c | 88 ++++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 39 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 148f39c79f41..31da038effc0 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -23,6 +23,41 @@ static struct class cros_class = {
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
+		.id	= EC_FEATURE_SCP,
+		.name	= CROS_EC_DEV_SCP_NAME,
+		.desc	= "System Control Processor",
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
@@ -279,6 +314,7 @@ static int ec_device_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
 	struct cros_ec_dev *ec = kzalloc(sizeof(*ec), GFP_KERNEL);
+	int i;
 
 	if (!ec)
 		return retval;
@@ -291,47 +327,21 @@ static int ec_device_probe(struct platform_device *pdev)
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
-	}
-
-	/* Check whether this is actually a SCP rather than an EC. */
-	if (cros_ec_check_features(ec, EC_FEATURE_SCP)) {
-		dev_info(dev, "CrOS SCP MCU detected.\n");
-		/*
-		 * Help userspace differentiating ECs from SCP,
-		 * regardless of the probing order.
-		 */
-		ec_platform->ec_name = CROS_EC_DEV_SCP_NAME;
+		if (cros_ec_check_features(ec, cros_mcu_devices[i].id)) {
+			dev_info(dev, "CrOS %s MCU detected\n",
+				 cros_mcu_devices[i].desc);
+			/*
+			 * Help userspace differentiating ECs from other MCU,
+			 * regardless of the probing order.
+			 */
+			ec_platform->ec_name = cros_mcu_devices[i].name;
+			break;
+		}
 	}
 
 	/*
-- 
2.20.1

