Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C2FE102C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 04:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389323AbfJWCoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 22:44:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36901 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730655AbfJWCoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 22:44:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so11916042pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 19:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5W92hpu9o2rfIqUdBJQ593S46hA9FmRbacTloyOcBmk=;
        b=Cz1S/hEASfHabZysQzaNJmmdPyjwvzDxCl1oMvCDts3RUy9CMp1HWjleV6TLy73uQZ
         VEVjfHBa1t4z4EZf/BVd8O1H/KZg6D1UKruKKNxzP9xuOSjWEmzWS9GqonDPvhBi5yQz
         pftvpUgBN2d7vkXepwS8iDeeHqzPoFjpvnHdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5W92hpu9o2rfIqUdBJQ593S46hA9FmRbacTloyOcBmk=;
        b=ZUoiNjPfQlOFDp1XFDSynYnnmxUwKC0fseNTddyYwEoBBkDpHZtLStIWe/q3/1ThfC
         unTVz+GdyTq8dnZxQAXqa7VOD4g2VK/hMqSoXnqHxpdiujA+sk56pFkvT2crCTRhhIZr
         JpOYINS9Z/dJpjPpccJFJBwIKbf11NsEaPKb38HQY4E29dpuZpTGHTJco9S2P6hT1aDO
         ZV8CMeXR+xnOFPeQdW7qn5jaFCGFojK619pMHWguPSitQyJnETxKGFvPq3z4lGkvtYyO
         DgqPUYMq6bI1hSB7hkfEo6Gn/k/LNun0AjhgdLzXoddv1MZNyO5Mxp0NmIhJaTvK+FzP
         VDRQ==
X-Gm-Message-State: APjAAAULr4yXBTxZZql+skFPgNxkdRH3326EehsL2u4fFX2qqkZkU7Qp
        FbQKrLXUFm/2hxbzltrXCwPhPQ==
X-Google-Smtp-Source: APXvYqx3SnrbDx9WrU4Kjo0xAHrjmP5RwWDnuypSKuZ+TG2NTLP+7/l2++P8mHJJIiGGuejLVOoLJg==
X-Received: by 2002:a17:90a:246c:: with SMTP id h99mr8213439pje.127.1571798656034;
        Tue, 22 Oct 2019 19:44:16 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:254e:2b40:ef8:ee17])
        by smtp.gmail.com with ESMTPSA id h2sm30134631pfq.108.2019.10.22.19.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 19:44:15 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org,
        Nicolas Boitchat <drinkcat@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v3 2/2] HID: google: Add of_match table to Whiskers switch device.
Date:   Wed, 23 Oct 2019 10:44:10 +0800
Message-Id: <20191023024410.226524-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree match table.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-google-hammer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 84f8c127ebdc..b726f8a15044 100644
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
@@ -264,12 +265,21 @@ static const struct acpi_device_id cbas_ec_acpi_ids[] = {
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
2.23.0.866.gb869b98d4c-goog

