Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F08D3B704A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 02:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbfISA4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 20:56:32 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37910 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbfISA4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:56:32 -0400
Received: by mail-yb1-f195.google.com with SMTP id o18so709779ybp.5;
        Wed, 18 Sep 2019 17:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gliQnWiLZy4GHcRR9eFMi5rKboC47gniTTdsujj6gQg=;
        b=ERNEoENvC6ogVHDHS3uhuhKkMts29PZ9pIvOqPrKZNl80bS3J9O1JJR6iy8O1dVtm0
         zKuDYvA6cCAXC3JTVuP7GTr34wbQA7FI7ZLUFzUW3q6Aama44MURIeL6P36cE7PFB995
         BAaI28MHB7aIcWLVrphgZhwMwP9GyBbzwCjsEi3ztb+PUm5p6+DcUliR0IV/RyE11SpB
         HklU+wJ84uTiks5me6WQ+sKgfDjeOkqCCKFbFsTvmSMJxYnNxGVpSttZpmO4jPEIrBcG
         Bo2yT8kQYiPYe4+O9+7GsxMAdi3fXJWbU1nDMiUB1HeDq1IU2mls3jXvf+FWTzK5ayLW
         l+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gliQnWiLZy4GHcRR9eFMi5rKboC47gniTTdsujj6gQg=;
        b=LbWF8CjxrfJnqF7ImuGsVkmH2gfUWkSu+t7mljq75EX5TFlzSYIFmjN15cVZiaqCkq
         Q6xYECaRIJmAcVfy6iYFclpIAQ8yjN99zcozR52HsgUPgyxuWzLqtem/Unrg4//Za+EC
         O3WOyHNup58kBcKkwnVib9PEuSafXqxOneOYm7C0LQpkwURDuS6hSpNLL0+0KTIvHHpw
         KWQgkBfoH8P5fR0t8wwxguQE1iLoTsdnwJqJgHMQeb+T6Sv5MhcKFoQWQ6oKoUQPe2hl
         knSFd5avoS4WitDOr/PxrHHJjGYYZisEvzoIflXfsZQUqtJNcR4iUUrgbpOpLrIYZjH7
         V7fg==
X-Gm-Message-State: APjAAAWEWLCzvNIWXkeMz06HG2H38oD/yFELyYlh361LrlWxEfl4LwdZ
        kpQAuzCz0r07Pq8Uqm0GZw==
X-Google-Smtp-Source: APXvYqxAx64eSzE5DVKwNqUd80ksiqv2l+7EpBqq2Z+U4c+9qjyAFI75IvmWfQqc5KHM6ct1jUl/Tg==
X-Received: by 2002:a25:b9cd:: with SMTP id y13mr4601577ybj.499.1568854590986;
        Wed, 18 Sep 2019 17:56:30 -0700 (PDT)
Received: from 960.localdomain ([64.192.53.12])
        by smtp.gmail.com with ESMTPSA id u69sm1692475ywu.93.2019.09.18.17.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 17:56:30 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] platform/x86: huawei-wmi: Add debugfs support
Date:   Wed, 18 Sep 2019 20:54:58 -0400
Message-Id: <20190919005505.23822-7-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190919005505.23822-1-ayman.bagabas@gmail.com>
References: <20190919005505.23822-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a debugfs interface that can be used to call the WMI management
interface function if available.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 91 +++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 48be55c6027e..9ae2ecadeb10 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/input.h>
@@ -598,6 +599,94 @@ static void huawei_wmi_fn_lock_exit(struct device *dev)
 		device_remove_file(dev, &dev_attr_fn_lock_state);
 }
 
+/* debugfs */
+
+static void huawei_wmi_debugfs_call_dump(struct seq_file *m, void *data,
+		union acpi_object *obj)
+{
+	struct huawei_wmi *huawei = m->private;
+	int i;
+
+	switch (obj->type) {
+	case ACPI_TYPE_INTEGER:
+		seq_printf(m, "0x%llx", obj->integer.value);
+		break;
+	case ACPI_TYPE_STRING:
+		seq_printf(m, "\"%*s\"", obj->string.length, obj->string.pointer);
+		break;
+	case ACPI_TYPE_BUFFER:
+		seq_puts(m, "{");
+		for (i = 0; i < obj->buffer.length; i++) {
+			seq_printf(m, "0x%02x", obj->buffer.pointer[i]);
+			if (i < obj->buffer.length - 1)
+				seq_puts(m, ",");
+		}
+		seq_puts(m, "}");
+		break;
+	case ACPI_TYPE_PACKAGE:
+		seq_puts(m, "[");
+		for (i = 0; i < obj->package.count; i++) {
+			huawei_wmi_debugfs_call_dump(m, huawei, &obj->package.elements[i]);
+			if (i < obj->package.count - 1)
+				seq_puts(m, ",");
+		}
+		seq_puts(m, "]");
+		break;
+	default:
+		dev_err(&huawei->pdev->dev, "Unexpected obj type, got %d\n", obj->type);
+		return;
+	}
+}
+
+static int huawei_wmi_debugfs_call_show(struct seq_file *m, void *data)
+{
+	struct huawei_wmi *huawei = m->private;
+	struct acpi_buffer out = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer in;
+	union acpi_object *obj;
+	int err;
+
+	in.length = sizeof(u64);
+	in.pointer = &huawei->debug.arg;
+
+	err = huawei_wmi_call(&in, &out);
+	if (err)
+		return err;
+
+	obj = out.pointer;
+	if (!obj) {
+		err = -EIO;
+		goto fail_debugfs_call;
+	}
+
+	huawei_wmi_debugfs_call_dump(m, huawei, obj);
+
+fail_debugfs_call:
+	kfree(out.pointer);
+	return err;
+}
+
+DEFINE_SHOW_ATTRIBUTE(huawei_wmi_debugfs_call);
+
+static void huawei_wmi_debugfs_setup(struct device *dev)
+{
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
+
+	huawei->debug.root = debugfs_create_dir("huawei-wmi", NULL);
+
+	debugfs_create_x64("arg", 0644, huawei->debug.root,
+		&huawei->debug.arg);
+	debugfs_create_file("call", 0400,
+		huawei->debug.root, huawei, &huawei_wmi_debugfs_call_fops);
+}
+
+static void huawei_wmi_debugfs_exit(struct device *dev)
+{
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
+
+	debugfs_remove_recursive(huawei->debug.root);
+}
+
 /* Input */
 
 static void huawei_wmi_process_key(struct input_dev *idev, int code)
@@ -723,6 +812,7 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 		huawei_wmi_leds_setup(&pdev->dev);
 		huawei_wmi_fn_lock_setup(&pdev->dev);
 		huawei_wmi_battery_setup(&pdev->dev);
+		huawei_wmi_debugfs_setup(&pdev->dev);
 	}
 
 	return 0;
@@ -740,6 +830,7 @@ static int huawei_wmi_remove(struct platform_device *pdev)
 	}
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
+		huawei_wmi_debugfs_exit(&pdev->dev);
 		huawei_wmi_battery_exit(&pdev->dev);
 		huawei_wmi_fn_lock_exit(&pdev->dev);
 	}
-- 
2.21.0

