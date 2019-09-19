Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6BDB7042
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 02:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbfISAz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 20:55:59 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43076 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbfISAz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:55:58 -0400
Received: by mail-yw1-f68.google.com with SMTP id q7so639860ywe.10;
        Wed, 18 Sep 2019 17:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2iXv5Hsh+1LBY24AKyClbwA95JiK12EU0d4z81X8e2E=;
        b=lArZNdHdTFkLE/tSnp3C1+0BBf2OU+lMLzWIVSjJVRNv+neBL1MDWXHV36N+8EBDJ6
         4km2nhlf5AlivXnw5cm2pXwsSLVaS2PVEhHqtDHjxj+95kIjlfqrs9jqZMjJLmp4FZYL
         r8mPDbqskvNabTQTYqYuqVFebJFTQNyjHsIb7uyeVZ1ODuDU5CRoxEYks8MtynD17U0o
         BdzFxhYLDOvMgJ9Xs+vDCD0DvSZfdISjlt5AGjTAA8uQ8TXm/S4GqU1enlUgkyAgFWFj
         N/Lb28raINQeQaNkX8/onto1CCjs90dwroKKGe7s56CWoNWV1Pgn1/re/y7cJlTWOJS9
         VXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2iXv5Hsh+1LBY24AKyClbwA95JiK12EU0d4z81X8e2E=;
        b=tKqs684T5PInfuCWpMPJFv7+y2s46QozFl9mFKzlEBpwv7yavJqto6uSxwDc9sVpVX
         DZwu1ynpdpEjX971G2nbO8C6qZebyeCEUkUwQ2kKIoxC8l5UtxuVgydEo0+fds54Jpam
         QNqnBQxZmb4ox3jiqTYUdMVbtGlVOJU10IHUW+NOyN1HJItd0SlAzg2MBvb8Aqbjc3xm
         TopKAKjEhSL11Azkp+oTfYES80l5/bJyIppfdiQssiirQgSTdN215krn1i/P4qEKjU2C
         9L6iyz/Gt1Rzfr9r2/CW4+DgUeeG+RlxXzupY5zZ/+4bzupdUumK3qXSKP1fTc93IiPG
         VeQg==
X-Gm-Message-State: APjAAAXk7KotNaU2rtWZ37hoTs7hiazgvPaiF/5WuZ1wEp8t+yXGJpsk
        QhWuYOMWcr1oUGb3hMab5ck7sJ3fpg==
X-Google-Smtp-Source: APXvYqzreG1w/Htg4SkrTtCQCNq+4qhoQx5H13a3heGunyr5qqpZyDVL+G7ppkRLJwnSQYb+lcNoGw==
X-Received: by 2002:a81:9401:: with SMTP id l1mr6059624ywg.421.1568854557636;
        Wed, 18 Sep 2019 17:55:57 -0700 (PDT)
Received: from 960.localdomain ([64.192.53.12])
        by smtp.gmail.com with ESMTPSA id u69sm1692475ywu.93.2019.09.18.17.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 17:55:57 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] platform/x86: huawei-wmi: Add quirks and module parameters
Date:   Wed, 18 Sep 2019 20:54:54 -0400
Message-Id: <20190919005505.23822-3-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190919005505.23822-1-ayman.bagabas@gmail.com>
References: <20190919005505.23822-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce quirks and module parameters. 3 quirks are added:
1. Fixes reporting brightness keys twice since it's already handled by
   acpi-video.
2. Some models need a short delay when setting battery thresholds to
   prevent a race condition when two processes read/write. (will be used later)
3. Matebook X (2017) handles micmute led through the "legacy" interface
   which is not currently implemented. Use ACPI EC method to control
   this led. (will be used later)

2 module parameters are added to enable this short delay and/or report
  brightness keys through this driver.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 77 +++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 9496ea3c78b5..97ff3d868765 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <linux/leds.h>
@@ -22,7 +23,21 @@
 #define WMI0_EXPENSIVE_GUID "39142400-C6A3-40fa-BADB-8A2652834100"
 #define WMI0_EVENT_GUID "59142400-C6A3-40fa-BADB-8A2652834100"
 
+struct quirk_entry {
+	bool battery_reset;
+	bool ec_micmute;
+	bool report_brightness;
+};
+
+static struct quirk_entry *quirks;
+
+struct huawei_wmi_debug {
+	struct dentry *root;
+	u64 arg;
+};
+
 struct huawei_wmi {
+	struct huawei_wmi_debug debug;
 	struct input_dev *idev[2];
 	struct led_classdev cdev;
 	struct platform_device *pdev;
@@ -49,6 +64,58 @@ static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_END,	 0 }
 };
 
+static bool battery_reset;
+static bool report_brightness;
+
+module_param(battery_reset, bool, 0444);
+MODULE_PARM_DESC(battery_reset,
+		"Reset battery charge values to (0-0) before disabling it using (0-100)");
+module_param(report_brightness, bool, 0444);
+MODULE_PARM_DESC(report_brightness,
+		"Report brightness keys.");
+
+/* Quirks */
+
+static int __init dmi_matched(const struct dmi_system_id *dmi)
+{
+	quirks = dmi->driver_data;
+	return 1;
+}
+
+static struct quirk_entry quirk_unknown = {
+};
+
+static struct quirk_entry quirk_battery_reset = {
+	.battery_reset = true,
+};
+
+static struct quirk_entry quirk_matebook_x = {
+	.ec_micmute = true,
+	.report_brightness = true,
+};
+
+static const struct dmi_system_id huawei_quirks[] = {
+	{
+		.callback = dmi_matched,
+		.ident = "Huawei MACH-WX9",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MACH-WX9"),
+		},
+		.driver_data = &quirk_battery_reset
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Huawei MateBook X",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HUAWEI MateBook X")
+		},
+		.driver_data = &quirk_matebook_x
+	},
+	{  }
+};
+
 static int huawei_wmi_micmute_led_set(struct led_classdev *led_cdev,
 		enum led_brightness brightness)
 {
@@ -139,6 +206,11 @@ static void huawei_wmi_process_key(struct input_dev *idev, int code)
 		return;
 	}
 
+	if (quirks && !quirks->report_brightness &&
+			(key->sw.code == KEY_BRIGHTNESSDOWN ||
+			key->sw.code == KEY_BRIGHTNESSUP))
+		return;
+
 	sparse_keymap_report_entry(idev, key, 1, true);
 }
 
@@ -253,6 +325,11 @@ static __init int huawei_wmi_init(void)
 	if (!huawei_wmi)
 		return -ENOMEM;
 
+	quirks = &quirk_unknown;
+	dmi_check_system(huawei_quirks);
+	quirks->battery_reset |= battery_reset;
+	quirks->report_brightness |= report_brightness;
+
 	err = platform_driver_register(&huawei_wmi_driver);
 	if (err)
 		goto pdrv_err;
-- 
2.21.0

