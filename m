Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16FCD580AA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 12:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfF0KlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 06:41:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45102 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF0KlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:41:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2210F2899F2
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
        Collabora kernel ML <kernel@collabora.com>
Subject: [PATCH v4 10/11] mfd: cros_ec: Use mfd_add_hotplug_devices() helper
Date:   Thu, 27 Jun 2019 12:40:38 +0200
Message-Id: <20190627104039.26285-11-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627104039.26285-1-enric.balletbo@collabora.com>
References: <20190627104039.26285-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use mfd_add_hotplug_devices() helper to register the subdevices.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v4: None
Changes in v3:
- Add a new patch to use mfd_add_hoplug_devices to register subdevices

Changes in v2: None

 drivers/mfd/cros_ec_dev.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 73f186b9fda8..fd6edecaccb6 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -340,10 +340,8 @@ static void cros_ec_accel_legacy_register(struct cros_ec_dev *ec)
 	 * Register 2 accelerometers, we will fail in the IIO driver if there
 	 * are no sensors.
 	 */
-	ret = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-			      cros_ec_accel_legacy_cells,
-			      ARRAY_SIZE(cros_ec_accel_legacy_cells),
-			      NULL, 0, NULL);
+	ret = mfd_add_hotplug_devices(ec->dev, cros_ec_accel_legacy_cells,
+				      ARRAY_SIZE(cros_ec_accel_legacy_cells));
 	if (ret)
 		dev_err(ec_dev->dev, "failed to add EC sensors\n");
 }
@@ -429,10 +427,8 @@ static int ec_device_probe(struct platform_device *pdev)
 	 * The following subdevices cannot be detected by sending the
 	 * EC_FEATURE_GET_CMD to the Embedded Controller device.
 	 */
-	retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-				 cros_ec_platform_cells,
-				 ARRAY_SIZE(cros_ec_platform_cells),
-				 NULL, 0, NULL);
+	retval = mfd_add_hotplug_devices(ec->dev, cros_ec_platform_cells,
+					 ARRAY_SIZE(cros_ec_platform_cells));
 	if (retval)
 		dev_warn(ec->dev,
 			 "failed to add cros-ec platform devices: %d\n",
@@ -441,10 +437,8 @@ static int ec_device_probe(struct platform_device *pdev)
 	/* Check whether this EC instance has a VBC NVRAM */
 	node = ec->ec_dev->dev->of_node;
 	if (of_property_read_bool(node, "google,has-vbc-nvram")) {
-		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
-					 cros_ec_vbc_cells,
-					 ARRAY_SIZE(cros_ec_vbc_cells),
-					 NULL, 0, NULL);
+		retval = mfd_add_hotplug_devices(ec->dev, cros_ec_vbc_cells,
+						ARRAY_SIZE(cros_ec_vbc_cells));
 		if (retval)
 			dev_warn(ec->dev, "failed to add VBC devices: %d\n",
 				 retval);
-- 
2.20.1

