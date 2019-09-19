Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB6FB7048
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 02:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbfISA4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 20:56:24 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39443 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbfISA4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:56:23 -0400
Received: by mail-yw1-f66.google.com with SMTP id n11so653187ywn.6;
        Wed, 18 Sep 2019 17:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JJH+9aYvC39hzPNn9AdnGxRyUmbShCql0tZe9p98y0I=;
        b=DmOPaKBRGzPfptToMr2LY5C4co7NtJWOaynkWxs5iJINrwzuSgcteChheXtFyrwVlx
         Ez7S/Fx7293pqCQQuU6Q+sqsm04PDOdEIkWMJI6eSSB7p1yovEuq43M7xIFTDFS9CkQH
         dLP7ZyP7mkACiynY27L09JvwnL1CA4tfIgyXJBedyPWwTBtbx//Is/Fat6l2PBKJlADS
         hzITHuX6+25rSTZjsYn2KIeoKIjefU3qRBwE3Oss9lFQzQNAvn0+OARuFEKLFahQhOAx
         rz4L6YkNxTysNGVuaaeAvOALvdXzTZf7t50Y5hTMijh7LxWWxhJHwzrGyabXGpK9picx
         veSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJH+9aYvC39hzPNn9AdnGxRyUmbShCql0tZe9p98y0I=;
        b=R2A8j1LKYyC734F7IgdK6u7HQvOm2hqPqJ4WeBrsBNkOL/0vqXlzZbCF5kCE7itI3O
         xlxidiyRRA68rRUDNAMA2uMIASLd8JtkAZNhft7R8OUYGBAO0/BXsHjL1d4180t6TzrH
         zNhMVREr8+d9ZoEt0Ww0kohTpWpiuGMCEwHklocFWGmrwqLgr3FEy2Do3PP4rXo+7s1m
         uBDrq0UhDOadjFtg/tyQjUzmwbqX08/huFuNsHM2UZTytUzdKgIqLZ94gbCyRMJFbVN0
         kVHlWc1g6M+lCwhPb/U8zPYeA0AZP7bxFOR/HdQD7DLLUZr37K+J9Tst3mCxYmQDeFb4
         4HXg==
X-Gm-Message-State: APjAAAUDlkpRVa4prKcL2rKxKAUOZtOrCBkyzLBuVnt+XSihwDfuRilC
        FxmrYfJmF8XkA/4Ob2brxw==
X-Google-Smtp-Source: APXvYqy5kn3aIjrfw8Ody69S/41PeLalsZrWDGl2UViLfEnCGgWpcj3ModlIUMABbyHX4yR5mhKv+w==
X-Received: by 2002:a81:6387:: with SMTP id x129mr5701215ywb.242.1568854582835;
        Wed, 18 Sep 2019 17:56:22 -0700 (PDT)
Received: from 960.localdomain ([64.192.53.12])
        by smtp.gmail.com with ESMTPSA id u69sm1692475ywu.93.2019.09.18.17.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 17:56:22 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] platform/x86: huawei-wmi: Add fn-lock support
Date:   Wed, 18 Sep 2019 20:54:57 -0400
Message-Id: <20190919005505.23822-6-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190919005505.23822-1-ayman.bagabas@gmail.com>
References: <20190919005505.23822-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huawei Matebook laptops uses Fn key and toggle to access F1-F12 keys.
Along with that, there is this feature called fn-lock that inverts the
behavior of this Fn key and the F1-F12 row.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 85 +++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 231b5cce00db..48be55c6027e 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -59,6 +59,7 @@ struct huawei_wmi_debug {
 
 struct huawei_wmi {
 	bool battery_available;
+	bool fn_lock_available;
 
 	struct huawei_wmi_debug debug;
 	struct input_dev *idev[2];
@@ -515,6 +516,88 @@ static void huawei_wmi_battery_exit(struct device *dev)
 	}
 }
 
+/* Fn lock */
+
+static int huawei_wmi_fn_lock_get(int *on)
+{
+	u8 ret[0x100] = { 0 };
+	int err, i;
+
+	err = huawei_wmi_cmd(FN_LOCK_GET, ret, 0x100);
+	if (err)
+		return err;
+
+	/* Find the first non-zero value. Return status is ignored. */
+	i = 1;
+	do {
+		if (on)
+			*on = ret[i] - 1; // -1 undefined, 0 off, 1 on.
+	} while (i < 0x100 && !ret[i++]);
+
+	return 0;
+}
+
+static int huawei_wmi_fn_lock_set(int on)
+{
+	union hwmi_arg arg;
+
+	arg.cmd = FN_LOCK_SET;
+	arg.args[2] = on + 1; // 0 undefined, 1 off, 2 on.
+
+	return huawei_wmi_cmd(arg.cmd, NULL, NULL);
+}
+
+static ssize_t fn_lock_state_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int err, on;
+
+	err = huawei_wmi_fn_lock_get(&on);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%d\n", on);
+}
+
+static ssize_t fn_lock_state_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	int on, err;
+
+	if (kstrtoint(buf, 10, &on) ||
+			on < 0 || on > 1)
+		return -EINVAL;
+
+	err = huawei_wmi_fn_lock_set(on);
+	if (err)
+		return err;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(fn_lock_state);
+
+static void huawei_wmi_fn_lock_setup(struct device *dev)
+{
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
+
+	huawei->fn_lock_available = true;
+	if (huawei_wmi_fn_lock_get(NULL)) {
+		huawei->fn_lock_available = false;
+		return;
+	}
+
+	device_create_file(dev, &dev_attr_fn_lock_state);
+}
+
+static void huawei_wmi_fn_lock_exit(struct device *dev)
+{
+	if (huawei_wmi->fn_lock_available)
+		device_remove_file(dev, &dev_attr_fn_lock_state);
+}
+
 /* Input */
 
 static void huawei_wmi_process_key(struct input_dev *idev, int code)
@@ -638,6 +721,7 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 		mutex_init(&huawei_wmi->battery_lock);
 
 		huawei_wmi_leds_setup(&pdev->dev);
+		huawei_wmi_fn_lock_setup(&pdev->dev);
 		huawei_wmi_battery_setup(&pdev->dev);
 	}
 
@@ -657,6 +741,7 @@ static int huawei_wmi_remove(struct platform_device *pdev)
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
 		huawei_wmi_battery_exit(&pdev->dev);
+		huawei_wmi_fn_lock_exit(&pdev->dev);
 	}
 
 	return 0;
-- 
2.21.0

