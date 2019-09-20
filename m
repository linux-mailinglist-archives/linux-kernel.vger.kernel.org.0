Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819C6B94D3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 18:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfITQDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 12:03:31 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38770 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbfITQDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:03:30 -0400
Received: by mail-yw1-f66.google.com with SMTP id s6so2659076ywe.5;
        Fri, 20 Sep 2019 09:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UTE7QtTKG0Qt8VGCOJuFvDtSDxGzSKqUw1u9Hg2orpU=;
        b=jcINIcFwJb22TEwLQnI5a8gzNrKM6iOfG/VZTjLm6e8CdQNqFRdP+rwdJl1gZHIQX4
         PKzkwBRVe6Mm4VVLVioZPslfvrw07pcr0SRPiEXs8opXnFtfwRowNmm74vR6b0UCaA8O
         OqrgzZJRNIo9fukMHHpBIyfzIeAfCyPCwV0v4ArVTA6gYfRq2i5M+S2vBmkc7QxaZ7ji
         BW0e7KzPdPEnv57RT0o5vFi5MXE86pXf/9+h5c+0rwHeXO39lIQjhFA8fZV93ql1A82v
         DYQ9WeffQZAsosVgX50Z/D8N1kanb3xk+tCLD6b1nMI+YzoDi/xJsgCd9f/r1G9/lJDl
         tOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UTE7QtTKG0Qt8VGCOJuFvDtSDxGzSKqUw1u9Hg2orpU=;
        b=o6gLsHujGTBpMbP8ZYDh0iiCHtX6LOJiXUsI+6ibV3UpS6cMsIMGsCnvEh/7AIUgSz
         DTlC+RMRf+ntbg2waSoFdYWubj4LQhGNaZnB8CLPfNyPJnf5I4HzujMQxSA1N8J12s7Y
         MKIhuIBh/vuqj/OKbqIHuENavWvOx06/eNkl7OK1Jt7ZDnqXkfHpHTiihLXODcIO0Jf6
         zSGGS21FLm2w9m9F2xsgAqbCkX+RA8d3j0pBCmKTzxSgV297lA9PwhkdTYUBsh6KTY87
         4I5UoPJdLpKQEjGgpdshGa3dtGTOyj6E/it2fTKgPp4rHpVoICATnQey6KZ1DC+1LufI
         SJcw==
X-Gm-Message-State: APjAAAU5hwCVOfW8E1fzvHCsnAuujFVehmvDp1C4zQKT3Rl+bEFO1iVU
        Neny8XxTxH6XHzJmO4I+BQ==
X-Google-Smtp-Source: APXvYqzPDQ9+JUuiBtsu0/flyNZiRHlJnv/bxav5gcj6Gjz1zOjhEfLhynmauPOejtoSKDMJk1ZKNg==
X-Received: by 2002:a81:2849:: with SMTP id o70mr12703966ywo.389.1568995409441;
        Fri, 20 Sep 2019 09:03:29 -0700 (PDT)
Received: from localhost.localdomain ([12.156.111.130])
        by smtp.gmail.com with ESMTPSA id 207sm518086ywu.106.2019.09.20.09.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 09:03:28 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Matan Ziv-Av <matan@svgalib.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] platform/x86: huawei-wmi: Move to platform driver
Date:   Fri, 20 Sep 2019 12:02:34 -0400
Message-Id: <20190920160250.12510-2-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920160250.12510-1-ayman.bagabas@gmail.com>
References: <20190920160250.12510-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move from WMI driver to platform driver. This move is necessary since
the driver is no longer a hotkeys driver only. Platform driver makes it
easier for users to access sysfs attributes under (i.e.
/sys/devices/platform/huawei-wmi) compared to wmi driver.

Use WMI device UID, AMW0 has a UID of HWMI. WMI0 is the device name
and doesn't have a UID so keep it as it is.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/Kconfig      |   7 +-
 drivers/platform/x86/huawei-wmi.c | 226 ++++++++++++++++++++----------
 2 files changed, 156 insertions(+), 77 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 1b67bb578f9f..61bf180d25c7 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1304,7 +1304,7 @@ config INTEL_ATOMISP2_PM
 	  will be called intel_atomisp2_pm.
 
 config HUAWEI_WMI
-	tristate "Huawei WMI hotkeys driver"
+	tristate "Huawei WMI laptop extras driver"
 	depends on ACPI_WMI
 	depends on INPUT
 	select INPUT_SPARSEKMAP
@@ -1313,9 +1313,8 @@ config HUAWEI_WMI
 	select LEDS_TRIGGER_AUDIO
 	select NEW_LEDS
 	help
-	  This driver provides support for Huawei WMI hotkeys.
-	  It enables the missing keys and adds support to the micmute
-	  LED found on some of these laptops.
+	  This driver provides support for Huawei WMI hotkeys, battery charge
+	  control, fn-lock, mic-mute LED, and other extra features.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called huawei-wmi.
diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 195a7f3638cb..9496ea3c78b5 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Huawei WMI hotkeys
+ *  Huawei WMI laptop extras driver
  *
  *  Copyright (C) 2018	      Ayman Bagabas <ayman.bagabas@gmail.com>
  */
@@ -10,23 +10,28 @@
 #include <linux/input/sparse-keymap.h>
 #include <linux/leds.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/wmi.h>
 
 /*
  * Huawei WMI GUIDs
  */
-#define WMI0_EVENT_GUID "59142400-C6A3-40fa-BADB-8A2652834100"
-#define AMW0_EVENT_GUID "ABBC0F5C-8EA1-11D1-A000-C90629100000"
+#define HWMI_EVENT_GUID "ABBC0F5C-8EA1-11D1-A000-C90629100000"
 
+/* Legacy GUIDs */
 #define WMI0_EXPENSIVE_GUID "39142400-C6A3-40fa-BADB-8A2652834100"
+#define WMI0_EVENT_GUID "59142400-C6A3-40fa-BADB-8A2652834100"
 
-struct huawei_wmi_priv {
-	struct input_dev *idev;
+struct huawei_wmi {
+	struct input_dev *idev[2];
 	struct led_classdev cdev;
+	struct platform_device *pdev;
 	acpi_handle handle;
 	char *acpi_method;
 };
 
+struct huawei_wmi *huawei_wmi;
+
 static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_KEY,    0x281, { KEY_BRIGHTNESSDOWN } },
 	{ KE_KEY,    0x282, { KEY_BRIGHTNESSUP } },
@@ -37,7 +42,7 @@ static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_KEY,    0x289, { KEY_WLAN } },
 	// Huawei |M| key
 	{ KE_KEY,    0x28a, { KEY_CONFIG } },
-	// Keyboard backlight
+	// Keyboard backlit
 	{ KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
 	{ KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
 	{ KE_IGNORE, 0x295, { KEY_KBDILLUMUP } },
@@ -47,7 +52,7 @@ static const struct key_entry huawei_wmi_keymap[] = {
 static int huawei_wmi_micmute_led_set(struct led_classdev *led_cdev,
 		enum led_brightness brightness)
 {
-	struct huawei_wmi_priv *priv = dev_get_drvdata(led_cdev->dev->parent);
+	struct huawei_wmi *huawei = dev_get_drvdata(led_cdev->dev->parent);
 	acpi_status status;
 	union acpi_object args[3];
 	struct acpi_object_list arg_list = {
@@ -58,52 +63,53 @@ static int huawei_wmi_micmute_led_set(struct led_classdev *led_cdev,
 	args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;
 	args[1].integer.value = 0x04;
 
-	if (strcmp(priv->acpi_method, "SPIN") == 0) {
+	if (strcmp(huawei->acpi_method, "SPIN") == 0) {
 		args[0].integer.value = 0;
 		args[2].integer.value = brightness ? 1 : 0;
-	} else if (strcmp(priv->acpi_method, "WPIN") == 0) {
+	} else if (strcmp(huawei->acpi_method, "WPIN") == 0) {
 		args[0].integer.value = 1;
 		args[2].integer.value = brightness ? 0 : 1;
 	} else {
 		return -EINVAL;
 	}
 
-	status = acpi_evaluate_object(priv->handle, priv->acpi_method, &arg_list, NULL);
+	status = acpi_evaluate_object(huawei->handle, huawei->acpi_method, &arg_list, NULL);
 	if (ACPI_FAILURE(status))
 		return -ENXIO;
 
 	return 0;
 }
 
-static int huawei_wmi_leds_setup(struct wmi_device *wdev)
+static void huawei_wmi_leds_setup(struct device *dev)
 {
-	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
 
-	priv->handle = ec_get_handle();
-	if (!priv->handle)
-		return 0;
+	huawei->handle = ec_get_handle();
+	if (!huawei->handle)
+		return;
 
-	if (acpi_has_method(priv->handle, "SPIN"))
-		priv->acpi_method = "SPIN";
-	else if (acpi_has_method(priv->handle, "WPIN"))
-		priv->acpi_method = "WPIN";
+	if (acpi_has_method(huawei->handle, "SPIN"))
+		huawei->acpi_method = "SPIN";
+	else if (acpi_has_method(huawei->handle, "WPIN"))
+		huawei->acpi_method = "WPIN";
 	else
-		return 0;
+		return;
 
-	priv->cdev.name = "platform::micmute";
-	priv->cdev.max_brightness = 1;
-	priv->cdev.brightness_set_blocking = huawei_wmi_micmute_led_set;
-	priv->cdev.default_trigger = "audio-micmute";
-	priv->cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
-	priv->cdev.dev = &wdev->dev;
-	priv->cdev.flags = LED_CORE_SUSPENDRESUME;
+	huawei->cdev.name = "platform::micmute";
+	huawei->cdev.max_brightness = 1;
+	huawei->cdev.brightness_set_blocking = &huawei_wmi_micmute_led_set;
+	huawei->cdev.default_trigger = "audio-micmute";
+	huawei->cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
+	huawei->cdev.dev = dev;
+	huawei->cdev.flags = LED_CORE_SUSPENDRESUME;
 
-	return devm_led_classdev_register(&wdev->dev, &priv->cdev);
+	devm_led_classdev_register(dev, &huawei->cdev);
 }
 
-static void huawei_wmi_process_key(struct wmi_device *wdev, int code)
+/* Input */
+
+static void huawei_wmi_process_key(struct input_dev *idev, int code)
 {
-	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
 	const struct key_entry *key;
 
 	/*
@@ -127,81 +133,155 @@ static void huawei_wmi_process_key(struct wmi_device *wdev, int code)
 		kfree(response.pointer);
 	}
 
-	key = sparse_keymap_entry_from_scancode(priv->idev, code);
+	key = sparse_keymap_entry_from_scancode(idev, code);
 	if (!key) {
-		dev_info(&wdev->dev, "Unknown key pressed, code: 0x%04x\n", code);
+		dev_info(&idev->dev, "Unknown key pressed, code: 0x%04x\n", code);
 		return;
 	}
 
-	sparse_keymap_report_entry(priv->idev, key, 1, true);
+	sparse_keymap_report_entry(idev, key, 1, true);
 }
 
-static void huawei_wmi_notify(struct wmi_device *wdev,
-		union acpi_object *obj)
+static void huawei_wmi_input_notify(u32 value, void *context)
 {
-	if (obj->type == ACPI_TYPE_INTEGER)
-		huawei_wmi_process_key(wdev, obj->integer.value);
+	struct input_dev *idev = (struct input_dev *)context;
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
+
+	status = wmi_get_event_data(value, &response);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&idev->dev, "Unable to get event data\n");
+		return;
+	}
+
+	obj = (union acpi_object *)response.pointer;
+	if (obj && obj->type == ACPI_TYPE_INTEGER)
+		huawei_wmi_process_key(idev, obj->integer.value);
 	else
-		dev_info(&wdev->dev, "Bad response type %d\n", obj->type);
+		dev_err(&idev->dev, "Bad response type\n");
+
+	kfree(response.pointer);
 }
 
-static int huawei_wmi_input_setup(struct wmi_device *wdev)
+static int huawei_wmi_input_setup(struct device *dev,
+		const char *guid,
+		struct input_dev **idev)
 {
-	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
-	int err;
-
-	priv->idev = devm_input_allocate_device(&wdev->dev);
-	if (!priv->idev)
+	*idev = devm_input_allocate_device(dev);
+	if (!*idev)
 		return -ENOMEM;
 
-	priv->idev->name = "Huawei WMI hotkeys";
-	priv->idev->phys = "wmi/input0";
-	priv->idev->id.bustype = BUS_HOST;
-	priv->idev->dev.parent = &wdev->dev;
+	(*idev)->name = "Huawei WMI hotkeys";
+	(*idev)->phys = "wmi/input0";
+	(*idev)->id.bustype = BUS_HOST;
+	(*idev)->dev.parent = dev;
 
-	err = sparse_keymap_setup(priv->idev, huawei_wmi_keymap, NULL);
-	if (err)
-		return err;
+	return sparse_keymap_setup(*idev, huawei_wmi_keymap, NULL) ||
+		input_register_device(*idev) ||
+		wmi_install_notify_handler(guid, huawei_wmi_input_notify,
+				*idev);
+}
 
-	return input_register_device(priv->idev);
+static void huawei_wmi_input_exit(struct device *dev, const char *guid)
+{
+	wmi_remove_notify_handler(guid);
 }
 
-static int huawei_wmi_probe(struct wmi_device *wdev, const void *context)
+/* Huawei driver */
+
+static const struct wmi_device_id huawei_wmi_events_id_table[] = {
+	{ .guid_string = WMI0_EVENT_GUID },
+	{  }
+};
+
+static int huawei_wmi_probe(struct platform_device *pdev)
 {
-	struct huawei_wmi_priv *priv;
+	const struct wmi_device_id *guid = huawei_wmi_events_id_table;
 	int err;
 
-	priv = devm_kzalloc(&wdev->dev, sizeof(struct huawei_wmi_priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	platform_set_drvdata(pdev, huawei_wmi);
+	huawei_wmi->pdev = pdev;
 
-	dev_set_drvdata(&wdev->dev, priv);
+	while (*guid->guid_string) {
+		struct input_dev *idev = *huawei_wmi->idev;
 
-	err = huawei_wmi_input_setup(wdev);
-	if (err)
-		return err;
+		if (wmi_has_guid(guid->guid_string)) {
+			err = huawei_wmi_input_setup(&pdev->dev, guid->guid_string, &idev);
+			if (err) {
+				dev_err(&pdev->dev, "Failed to setup input on %s\n", guid->guid_string);
+				return err;
+			}
+		}
 
-	return huawei_wmi_leds_setup(wdev);
+		idev++;
+		guid++;
+	}
+
+	huawei_wmi_leds_setup(&pdev->dev);
+	return 0;
 }
 
-static const struct wmi_device_id huawei_wmi_id_table[] = {
-	{ .guid_string = WMI0_EVENT_GUID },
-	{ .guid_string = AMW0_EVENT_GUID },
-	{  }
-};
+static int huawei_wmi_remove(struct platform_device *pdev)
+{
+	const struct wmi_device_id *guid = huawei_wmi_events_id_table;
+
+	while (*guid->guid_string) {
+		if (wmi_has_guid(guid->guid_string))
+			huawei_wmi_input_exit(&pdev->dev, guid->guid_string);
+
+		guid++;
+	}
 
-static struct wmi_driver huawei_wmi_driver = {
+	return 0;
+}
+
+static struct platform_driver huawei_wmi_driver = {
 	.driver = {
 		.name = "huawei-wmi",
 	},
-	.id_table = huawei_wmi_id_table,
 	.probe = huawei_wmi_probe,
-	.notify = huawei_wmi_notify,
+	.remove = huawei_wmi_remove,
 };
 
-module_wmi_driver(huawei_wmi_driver);
+static __init int huawei_wmi_init(void)
+{
+	struct platform_device *pdev;
+	int err;
+
+	huawei_wmi = kzalloc(sizeof(struct huawei_wmi), GFP_KERNEL);
+	if (!huawei_wmi)
+		return -ENOMEM;
+
+	err = platform_driver_register(&huawei_wmi_driver);
+	if (err)
+		goto pdrv_err;
+
+	pdev = platform_device_register_simple("huawei-wmi", -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		err = PTR_ERR(pdev);
+		goto pdev_err;
+	}
+
+	return 0;
+
+pdev_err:
+	platform_driver_unregister(&huawei_wmi_driver);
+pdrv_err:
+	kfree(huawei_wmi);
+	return err;
+}
+
+static __exit void huawei_wmi_exit(void)
+{
+	platform_device_unregister(huawei_wmi->pdev);
+	platform_driver_unregister(&huawei_wmi_driver);
+}
+
+module_init(huawei_wmi_init);
+module_exit(huawei_wmi_exit);
 
-MODULE_DEVICE_TABLE(wmi, huawei_wmi_id_table);
+MODULE_DEVICE_TABLE(wmi, huawei_wmi_events_id_table);
 MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
-MODULE_DESCRIPTION("Huawei WMI hotkeys");
+MODULE_DESCRIPTION("Huawei WMI laptop extras driver");
 MODULE_LICENSE("GPL v2");
-- 
2.21.0

