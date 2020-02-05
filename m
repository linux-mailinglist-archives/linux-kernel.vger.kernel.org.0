Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E35AC1528A2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 10:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgBEJsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 04:48:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:53956 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgBEJsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:48:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 01:48:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,405,1574150400"; 
   d="scan'208";a="431808778"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 05 Feb 2020 01:48:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5157B17C; Wed,  5 Feb 2020 11:48:29 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nick Crews <ncrews@chromium.org>, linux-kernel@vger.kernel.org,
        Daniel Campello <campello@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] platform/chrome: wilco_ec: Platform data shan't include kernel.h
Date:   Wed,  5 Feb 2020 11:48:28 +0200
Message-Id: <20200205094828.77940-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace with appropriate types.h.

Also there is no need to include device.h, but mutex.h.
For the pointers to unknown structures use forward declarations.

In the *.c files we need to include all headers that provide APIs
being used in the module.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: update *.c files (kbuild test robot)
 drivers/platform/chrome/wilco_ec/properties.c | 3 +++
 drivers/platform/chrome/wilco_ec/sysfs.c      | 4 ++++
 include/linux/platform_data/wilco-ec.h        | 8 ++++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/properties.c b/drivers/platform/chrome/wilco_ec/properties.c
index e69682c95ea2..a0cbd8bd2851 100644
--- a/drivers/platform/chrome/wilco_ec/properties.c
+++ b/drivers/platform/chrome/wilco_ec/properties.c
@@ -3,8 +3,11 @@
  * Copyright 2019 Google LLC
  */
 
+#include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/platform_data/wilco-ec.h>
 #include <linux/string.h>
+#include <linux/types.h>
 #include <linux/unaligned/le_memmove.h>
 
 /* Operation code; what the EC should do with the property */
diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
index f0d174b6bb21..3c587b4054a5 100644
--- a/drivers/platform/chrome/wilco_ec/sysfs.c
+++ b/drivers/platform/chrome/wilco_ec/sysfs.c
@@ -8,8 +8,12 @@
  * See Documentation/ABI/testing/sysfs-platform-wilco-ec for more information.
  */
 
+#include <linux/device.h>
+#include <linux/kernel.h>
 #include <linux/platform_data/wilco-ec.h>
+#include <linux/string.h>
 #include <linux/sysfs.h>
+#include <linux/types.h>
 
 #define CMD_KB_CMOS			0x7C
 #define SUB_CMD_KB_CMOS_AUTO_ON		0x03
diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
index afede15a95bf..25f46a939637 100644
--- a/include/linux/platform_data/wilco-ec.h
+++ b/include/linux/platform_data/wilco-ec.h
@@ -8,8 +8,8 @@
 #ifndef WILCO_EC_H
 #define WILCO_EC_H
 
-#include <linux/device.h>
-#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
 
 /* Message flags for using the mailbox() interface */
 #define WILCO_EC_FLAG_NO_RESPONSE	BIT(0) /* EC does not respond */
@@ -17,6 +17,10 @@
 /* Normal commands have a maximum 32 bytes of data */
 #define EC_MAILBOX_DATA_SIZE		32
 
+struct device;
+struct resource;
+struct platform_device;
+
 /**
  * struct wilco_ec_device - Wilco Embedded Controller handle.
  * @dev: Device handle.
-- 
2.24.1

