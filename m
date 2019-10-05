Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3433CC949
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 12:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfJEKO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 06:14:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34775 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfJEKO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 06:14:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id b128so5466068pfa.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3RTNY8wK4fg6Ur2FSGs8j8MYz5LC7K5RU1Q9U1f79zE=;
        b=bd/SpF5Z6uDGHkSQeb9tqR1c4yP+9mM2N9y/zARpg7UBQjUfkGuHWVD77pi+c099tj
         +wXHtq/uN3a7co3rwkD4JKB9YLAEu1l5Sgy29gzliPJvDlGGMiYV+siW6/bvfFqgiqSz
         owpXUicJzYPD5Rygwqj3waXUdqN7oOWKN2lik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3RTNY8wK4fg6Ur2FSGs8j8MYz5LC7K5RU1Q9U1f79zE=;
        b=r0X6WR6b9YhNi6gC1wKhH3DZZX09g7l+6yrUj7XtSTVXJrq6oWg7tPScS7MJ3WMu6z
         dNkpeBJeBrXVsXncN0lZygpdL/WOjYC8AyJZBeidF0xma798o1LpUSR0v8Kas9Ore9kc
         anJfP1xWRjcgFAGQtrjWo+tryjzF9lWWld2TT0HWnepSgfPP0QDuFLbZasAv2OBjH0RR
         nYRSRyiMfVG02MJygi072hJ/8HWxLyOFVKShsPCqLQJgJQr3feMemFjGXyUnbdMCkXf+
         hJhYMSmzEXBFZDfm1cfjBg/g9Y1rS6Kzht+jzoYDAGJa9cJ3j3ngdHLP/604HLo7H9re
         OsXw==
X-Gm-Message-State: APjAAAW85QTnwdug4XTKbMnCXGEwm6cCbil70CWyltHNrQAhCOP/FDx4
        RksH5VrkQ6FcEPMZvPd8+F7Btg==
X-Google-Smtp-Source: APXvYqy819c+zDO2gbBv4p7WXcuJLsdEBSZATNeDcK4UJhT+HMC7FijTUsBwBco/wu4fFgEuDbevRw==
X-Received: by 2002:a63:4616:: with SMTP id t22mr20787000pga.123.1570270496997;
        Sat, 05 Oct 2019 03:14:56 -0700 (PDT)
Received: from ikjn-glaptop.roam.corp.google.com ([61.254.209.103])
        by smtp.gmail.com with ESMTPSA id m123sm9607933pfb.133.2019.10.05.03.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 03:14:56 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Enrico Granata <egranata@google.com>,
        Ting Shen <phoenixshen@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH 2/3] HID: google: Add of_match table to Whiskers switch device.
Date:   Sat,  5 Oct 2019 18:14:44 +0800
Message-Id: <20191005101444.146554-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree match table.

Change-Id: Iaee68311073cefa4b99cde182bd37d1a67c94ea6
Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/hid/hid-google-hammer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 31e4a39946f5..bf2b6c6c9787 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -17,6 +17,7 @@
 #include <linux/hid.h>
 #include <linux/leds.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
@@ -272,12 +273,21 @@ static const struct acpi_device_id cbas_ec_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, cbas_ec_acpi_ids);
 
+#ifdef CONFIG_OF
+static const struct of_device_id cbas_ec_of_match[] = {
+	{ .compatible = "google,cros-cbas" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, cbas_ec_of_match);
+#endif
+
 static struct platform_driver cbas_ec_driver = {
 	.probe = cbas_ec_probe,
 	.remove = cbas_ec_remove,
 	.driver = {
 		.name = "cbas_ec",
 		.acpi_match_table = ACPI_PTR(cbas_ec_acpi_ids),
+		.of_match_table = of_match_ptr(cbas_ec_of_match),
 		.pm = &cbas_ec_pm_ops,
 	},
 };
-- 
2.23.0.581.g78d2f28ef7-goog

