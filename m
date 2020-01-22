Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 482651453B1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 12:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgAVLX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 06:23:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:19606 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729151AbgAVLXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 06:23:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 03:23:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,349,1574150400"; 
   d="scan'208";a="427378218"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jan 2020 03:23:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B6C134DB; Wed, 22 Jan 2020 13:23:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 7/9] platform/x86: surface3_wmi: Switch DMI table match to a test of variable
Date:   Wed, 22 Jan 2020 13:23:04 +0200
Message-Id: <20200122112306.64598-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
References: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have a common x86 quirk that provides an exported variable,
use it instead of local DMI table match.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/surface3-wmi.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/surface3-wmi.c b/drivers/platform/x86/surface3-wmi.c
index 130b6f52a600..5eeedc4ddb8a 100644
--- a/drivers/platform/x86/surface3-wmi.c
+++ b/drivers/platform/x86/surface3-wmi.c
@@ -11,9 +11,9 @@
 #include <linux/slab.h>
 
 #include <linux/acpi.h>
-#include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/mutex.h>
+#include <linux/platform_data/x86/machine.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 
@@ -29,18 +29,6 @@ MODULE_LICENSE("GPL");
 
 MODULE_ALIAS("wmi:" SURFACE3_LID_GUID);
 
-static const struct dmi_system_id surface3_dmi_table[] = {
-#if defined(CONFIG_X86)
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
-		},
-	},
-#endif
-	{ }
-};
-
 struct surface3_wmi {
 	struct acpi_device *touchscreen_adev;
 	struct acpi_device *pnp0c0d_adev;
@@ -201,7 +189,7 @@ static int __init s3_wmi_probe(struct platform_device *pdev)
 {
 	int error;
 
-	if (!dmi_check_system(surface3_dmi_table))
+	if (!x86_microsoft_surface_3_machine)
 		return -ENODEV;
 
 	memset(&s3_wmi, 0, sizeof(s3_wmi));
-- 
2.24.1

