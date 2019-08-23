Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFFF89AFFD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 14:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394900AbfHWMyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 08:54:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46340 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394888AbfHWMyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:54:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 556C228D382
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
Subject: [PATCH v6 05/11] mfd / platform: cros_ec: Rename config to a better name
Date:   Fri, 23 Aug 2019 14:53:25 +0200
Message-Id: <20190823125331.5070-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190823125331.5070-1-enric.balletbo@collabora.com>
References: <20190823125331.5070-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cros-ec-dev is a multifunction device that now doesn't implement any
chardev communication interface. MFD_CROS_EC_CHARDEV doesn't look
a good name to describe that device and can cause confusion. Hence
rename it to CROS_EC_DEV.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Tested-by: Gwendal Grignou <gwendal@chromium.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mfd/Kconfig             | 17 ++++++++++-------
 drivers/mfd/Makefile            |  2 +-
 drivers/platform/chrome/Kconfig | 22 +++++++++++-----------
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 1079aff13f54..5a2590bf05e4 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -211,15 +211,18 @@ config MFD_AXP20X_RSB
 	  components like regulators or the PEK (Power Enable Key) under the
 	  corresponding menus.
 
-config MFD_CROS_EC_CHARDEV
-	tristate "Chrome OS Embedded Controller userspace device interface"
-	depends on CROS_EC
+config MFD_CROS_EC_DEV
+	tristate "ChromeOS Embedded Controller multifunction device"
 	select MFD_CORE
-	---help---
-	  This driver adds support to talk with the ChromeOS EC from userspace.
+	depends on CROS_EC
+	default CROS_EC
+	help
+	  Select this to get support for ChromeOS Embedded Controller
+	  sub-devices. This driver will instantiate additional drivers such
+	  as RTC, USBPD, etc. but you have to select the individual drivers.
 
-	  If you have a supported Chromebook, choose Y or M here.
-	  The module will be called cros_ec_dev.
+	  To compile this driver as a module, choose M here: the module will be
+	  called cros-ec-dev.
 
 config MFD_MADERA
 	tristate "Cirrus Logic Madera codecs"
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index b7ea093dd097..331beadaec36 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
 obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
 obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
-obj-$(CONFIG_MFD_CROS_EC_CHARDEV) += cros_ec_dev.o
+obj-$(CONFIG_MFD_CROS_EC_DEV)	+= cros_ec_dev.o
 obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
 
 obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index bd3524bd6b37..62726acb3a61 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -87,7 +87,7 @@ config CROS_EC_RPMSG
 
 config CROS_EC_ISHTP
 	tristate "ChromeOS Embedded Controller (ISHTP)"
-	depends on MFD_CROS_EC
+	depends on CROS_EC
 	depends on INTEL_ISH_HID
 	help
 	  If you say Y here, you get support for talking to the ChromeOS EC
@@ -138,8 +138,8 @@ config CROS_KBD_LED_BACKLIGHT
 
 config CROS_EC_CHARDEV
 	tristate "ChromeOS EC miscdevice"
-	depends on MFD_CROS_EC_CHARDEV
-	default MFD_CROS_EC_CHARDEV
+	depends on MFD_CROS_EC_DEV
+	default MFD_CROS_EC_DEV
 	help
 	  This driver adds file operations support to talk with the
 	  ChromeOS EC from userspace via a character device.
@@ -149,8 +149,8 @@ config CROS_EC_CHARDEV
 
 config CROS_EC_LIGHTBAR
 	tristate "Chromebook Pixel's lightbar support"
-	depends on MFD_CROS_EC_CHARDEV
-	default MFD_CROS_EC_CHARDEV
+	depends on MFD_CROS_EC_DEV
+	default MFD_CROS_EC_DEV
 	help
 	  This option exposes the Chromebook Pixel's lightbar to
 	  userspace.
@@ -160,8 +160,8 @@ config CROS_EC_LIGHTBAR
 
 config CROS_EC_VBC
 	tristate "ChromeOS EC vboot context support"
-	depends on MFD_CROS_EC_CHARDEV && OF
-	default MFD_CROS_EC_CHARDEV
+	depends on MFD_CROS_EC_DEV && OF
+	default MFD_CROS_EC_DEV
 	help
 	  This option exposes the ChromeOS EC vboot context nvram to
 	  userspace.
@@ -171,8 +171,8 @@ config CROS_EC_VBC
 
 config CROS_EC_DEBUGFS
 	tristate "Export ChromeOS EC internals in DebugFS"
-	depends on MFD_CROS_EC_CHARDEV && DEBUG_FS
-	default MFD_CROS_EC_CHARDEV
+	depends on MFD_CROS_EC_DEV && DEBUG_FS
+	default MFD_CROS_EC_DEV
 	help
 	  This option exposes the ChromeOS EC device internals to
 	  userspace.
@@ -182,8 +182,8 @@ config CROS_EC_DEBUGFS
 
 config CROS_EC_SYSFS
 	tristate "ChromeOS EC control and information through sysfs"
-	depends on MFD_CROS_EC_CHARDEV && SYSFS
-	default MFD_CROS_EC_CHARDEV
+	depends on MFD_CROS_EC_DEV && SYSFS
+	default MFD_CROS_EC_DEV
 	help
 	  This option exposes some sysfs attributes to control and get
 	  information from ChromeOS EC.
-- 
2.20.1

