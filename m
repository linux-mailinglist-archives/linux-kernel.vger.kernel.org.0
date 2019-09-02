Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6B9A5373
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 11:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbfIBJxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 05:53:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46650 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731135AbfIBJxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:53:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 502DF28CB74
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
        Collabora kernel ML <kernel@collabora.com>, arnd@arndb.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 01/10] mfd / platform: cros_ec: Handle chained ECs as platform devices
Date:   Mon,  2 Sep 2019 11:53:00 +0200
Message-Id: <20190902095309.18574-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902095309.18574-1-enric.balletbo@collabora.com>
References: <20190902095309.18574-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An MFD is a device that contains several sub-devices (cells). For instance,
the ChromeOS EC fits in this description as usually contains a charger and
can have other devices with different functions like a Real-Time Clock,
an Audio codec, a Real-Time Clock, ...

If you look at the driver, though, we're doing something odd. We have
two MFD cros-ec drivers where one of them (cros-ec-core) instantiates
another MFD driver as sub-driver (cros-ec-dev), and the latest
instantiates the different sub-devices (Real-Time Clock, Audio codec,
etc).

                  MFD
------------------------------------------
   cros-ec-core
       |___ mfd-cellA (cros-ec-dev)
       |       |__ mfd-cell0
       |       |__ mfd-cell1
       |       |__ ...
       |
       |___ mfd-cellB (cros-ec-dev)
               |__ mfd-cell0
               |__ mfd-cell1
               |__ ...

The problem that was trying to solve is to describe some kind of topology for
the case where we have an EC (cros-ec) chained with another EC
(cros-pd). Apart from that this extends the bounds of what MFD was
designed to do we might be interested on have other kinds of topology that
can't be implemented in that way.

Let's prepare the code to move the cros-ec-core part from MFD to
platform/chrome as this is clearly a platform specific thing non-related
to a MFD device.

  platform/chrome  |         MFD
------------------------------------------
                   |
   cros-ec ________|___ cros-ec-dev
                   |       |__ mfd-cell0
                   |       |__ mfd-cell1
                   |       |__ ...
                   |
   cros-pd ________|___ cros-ec-dev
                   |        |__ mfd-cell0
                   |        |__ mfd-cell1
                   |        |__ ...

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Tested-by: Gwendal Grignou <gwendal@chromium.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---

Changes in v7: None
Changes in v6:
- Rebase on top of for-mfd-next to avoid conflicts.
- Add Acked-by tags from Lee jones.

Changes in v5: None
Changes in v4:
- Rebase on top of for-mfd-next to avoid conflicts.

Changes in v3:
- Collect more acks an tested-by

Changes in v2:
- Collect acks received.
- Remove '[PATCH 07/10] mfd: cros_ec: Update with SPDX Licence identifier
  and fix description' to avoid conflicts with some tree-wide patches
  that actually updates the Licence identifier.
- Add '[PATCH 10/10] arm/arm64: defconfig: Update configs to use the new
  CROS_EC options' to update the defconfigs after change some config
  symbols.

 drivers/mfd/cros_ec.c                   | 61 +++++++++++++------------
 drivers/platform/chrome/cros_ec_i2c.c   |  8 ++++
 drivers/platform/chrome/cros_ec_lpc.c   |  3 +-
 drivers/platform/chrome/cros_ec_rpmsg.c |  2 +
 drivers/platform/chrome/cros_ec_spi.c   |  8 ++++
 include/linux/mfd/cros_ec.h             | 18 ++++++++
 6 files changed, 69 insertions(+), 31 deletions(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index 2a9ac5213893..a54ad47c7b02 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -13,7 +13,6 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/mfd/core.h>
 #include <linux/mfd/cros_ec.h>
 #include <linux/suspend.h>
 #include <asm/unaligned.h>
@@ -31,18 +30,6 @@ static struct cros_ec_platform pd_p = {
 	.cmd_offset = EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX),
 };
 
-static const struct mfd_cell ec_cell = {
-	.name = "cros-ec-dev",
-	.platform_data = &ec_p,
-	.pdata_size = sizeof(ec_p),
-};
-
-static const struct mfd_cell ec_pd_cell = {
-	.name = "cros-ec-dev",
-	.platform_data = &pd_p,
-	.pdata_size = sizeof(pd_p),
-};
-
 static irqreturn_t ec_irq_thread(int irq, void *data)
 {
 	struct cros_ec_device *ec_dev = data;
@@ -154,38 +141,42 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		}
 	}
 
-	err = devm_mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO, &ec_cell,
-				   1, NULL, ec_dev->irq, NULL);
-	if (err) {
-		dev_err(dev,
-			"Failed to register Embedded Controller subdevice %d\n",
-			err);
-		return err;
+	/* Register a platform device for the main EC instance */
+	ec_dev->ec = platform_device_register_data(ec_dev->dev, "cros-ec-dev",
+					PLATFORM_DEVID_AUTO, &ec_p,
+					sizeof(struct cros_ec_platform));
+	if (IS_ERR(ec_dev->ec)) {
+		dev_err(ec_dev->dev,
+			"Failed to create CrOS EC platform device\n");
+		return PTR_ERR(ec_dev->ec);
 	}
 
 	if (ec_dev->max_passthru) {
 		/*
-		 * Register a PD device as well on top of this device.
+		 * Register a platform device for the PD behind the main EC.
 		 * We make the following assumptions:
 		 * - behind an EC, we have a pd
 		 * - only one device added.
 		 * - the EC is responsive at init time (it is not true for a
-		 *   sensor hub.
+		 *   sensor hub).
 		 */
-		err = devm_mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO,
-				      &ec_pd_cell, 1, NULL, ec_dev->irq, NULL);
-		if (err) {
-			dev_err(dev,
-				"Failed to register Power Delivery subdevice %d\n",
-				err);
-			return err;
+		ec_dev->pd = platform_device_register_data(ec_dev->dev,
+					"cros-ec-dev",
+					PLATFORM_DEVID_AUTO, &pd_p,
+					sizeof(struct cros_ec_platform));
+		if (IS_ERR(ec_dev->pd)) {
+			dev_err(ec_dev->dev,
+				"Failed to create CrOS PD platform device\n");
+			platform_device_unregister(ec_dev->ec);
+			return PTR_ERR(ec_dev->pd);
 		}
 	}
 
 	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
 		err = devm_of_platform_populate(dev);
 		if (err) {
-			mfd_remove_devices(dev);
+			platform_device_unregister(ec_dev->pd);
+			platform_device_unregister(ec_dev->ec);
 			dev_err(dev, "Failed to register sub-devices\n");
 			return err;
 		}
@@ -206,6 +197,16 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 }
 EXPORT_SYMBOL(cros_ec_register);
 
+int cros_ec_unregister(struct cros_ec_device *ec_dev)
+{
+	if (ec_dev->pd)
+		platform_device_unregister(ec_dev->pd);
+	platform_device_unregister(ec_dev->ec);
+
+	return 0;
+}
+EXPORT_SYMBOL(cros_ec_unregister);
+
 #ifdef CONFIG_PM_SLEEP
 int cros_ec_suspend(struct cros_ec_device *ec_dev)
 {
diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
index 61d75395f86d..6bb82dfa7dae 100644
--- a/drivers/platform/chrome/cros_ec_i2c.c
+++ b/drivers/platform/chrome/cros_ec_i2c.c
@@ -307,6 +307,13 @@ static int cros_ec_i2c_probe(struct i2c_client *client,
 	return 0;
 }
 
+static int cros_ec_i2c_remove(struct i2c_client *client)
+{
+	struct cros_ec_device *ec_dev = i2c_get_clientdata(client);
+
+	return cros_ec_unregister(ec_dev);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int cros_ec_i2c_suspend(struct device *dev)
 {
@@ -357,6 +364,7 @@ static struct i2c_driver cros_ec_driver = {
 		.pm	= &cros_ec_i2c_pm_ops,
 	},
 	.probe		= cros_ec_i2c_probe,
+	.remove		= cros_ec_i2c_remove,
 	.id_table	= cros_ec_i2c_id,
 };
 
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 2c44c7f3322a..5939c4a5869c 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -421,6 +421,7 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 
 static int cros_ec_lpc_remove(struct platform_device *pdev)
 {
+	struct cros_ec_device *ec_dev = platform_get_drvdata(pdev);
 	struct acpi_device *adev;
 
 	adev = ACPI_COMPANION(&pdev->dev);
@@ -428,7 +429,7 @@ static int cros_ec_lpc_remove(struct platform_device *pdev)
 		acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
 					   cros_ec_lpc_acpi_notify);
 
-	return 0;
+	return cros_ec_unregister(ec_dev);
 }
 
 static const struct acpi_device_id cros_ec_lpc_acpi_device_ids[] = {
diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
index 5d3fb2abad1d..520e507bfa54 100644
--- a/drivers/platform/chrome/cros_ec_rpmsg.c
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -233,6 +233,8 @@ static void cros_ec_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct cros_ec_device *ec_dev = dev_get_drvdata(&rpdev->dev);
 	struct cros_ec_rpmsg *ec_rpmsg = ec_dev->priv;
 
+	cros_ec_unregister(ec_dev);
+
 	cancel_work_sync(&ec_rpmsg->host_event_work);
 }
 
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 006a8ff64057..2e21f2776063 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -785,6 +785,13 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
+static int cros_ec_spi_remove(struct spi_device *spi)
+{
+	struct cros_ec_device *ec_dev = spi_get_drvdata(spi);
+
+	return cros_ec_unregister(ec_dev);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int cros_ec_spi_suspend(struct device *dev)
 {
@@ -823,6 +830,7 @@ static struct spi_driver cros_ec_driver_spi = {
 		.pm	= &cros_ec_spi_pm_ops,
 	},
 	.probe		= cros_ec_spi_probe,
+	.remove		= cros_ec_spi_remove,
 	.id_table	= cros_ec_spi_id,
 };
 
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 77805c3f2de7..bcccda0257ff 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -121,6 +121,10 @@ struct cros_ec_command {
  * @event_data: Raw payload transferred with the MKBP event.
  * @event_size: Size in bytes of the event data.
  * @host_event_wake_mask: Mask of host events that cause wake from suspend.
+ * @ec: The platform_device used by the mfd driver to interface with the
+ *      main EC.
+ * @pd: The platform_device used by the mfd driver to interface with the
+ *      PD behind an EC.
  */
 struct cros_ec_device {
 	/* These are used by other drivers that want to talk to the EC */
@@ -157,6 +161,10 @@ struct cros_ec_device {
 	int event_size;
 	u32 host_event_wake_mask;
 	u32 last_resume_result;
+
+	/* The platform devices used by the mfd driver */
+	struct platform_device *ec;
+	struct platform_device *pd;
 };
 
 /**
@@ -291,6 +299,16 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
  */
 int cros_ec_register(struct cros_ec_device *ec_dev);
 
+/**
+ * cros_ec_unregister() - Remove a ChromeOS EC.
+ * @ec_dev: Device to unregister.
+ *
+ * Call this to deregister a ChromeOS EC, then clean up any private data.
+ *
+ * Return: 0 on success or negative error code.
+ */
+int cros_ec_unregister(struct cros_ec_device *ec_dev);
+
 /**
  * cros_ec_query_all() -  Query the protocol version supported by the
  *         ChromeOS EC.
-- 
2.20.1

