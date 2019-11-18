Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFFD210008D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 09:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfKRIjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 03:39:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34897 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfKRIjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:39:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id 8so17744723wmo.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 00:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D1zssAdL7pmeEJKGyrbWVna4auQ8NQ+QMvHRe4E43zU=;
        b=LBRhudfRE6Dqy5rM35/tYO/W6FZA67rqh+c9d/WPZ7v7BAXGP6mSKGb/I3M9U+Ydyg
         X6wH7iqTv9ypX9aChJLlMpnBeAIRI5j34yE+BpSeymm2in1SkzxwJlqSDVeIYjMzeXOM
         ldGb2gLfJl2FXcYOrjSDsCT8SkJo69IjBVTX/xXmTu3YlJngqyb71GZFJpiH2G9JWnCS
         NKhdmOtd2hkqXkUQ7+JNFHoaT30UPld+gLtFpOWSFun/tHOghsKKaNsAJtPZJ/Ok+fl+
         4DKBLrR3jI7AU7QFs3xjCeIdEamMndxa1kPJ74Ih9u5wLQ77oSlWUiFjWyON7Q7YmqMn
         j9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D1zssAdL7pmeEJKGyrbWVna4auQ8NQ+QMvHRe4E43zU=;
        b=NnF1hPgjJMlvV9IfVRngbhSjmniyBB7c9Gf4elOUc2YFUvMO+WGUUElCAS4D0uLjWS
         77nVkXTMv0bSlKQOsUca1+3tJxlEPinoFFHiv5oWp1kwb68I3pzmywj9eWVTC982AiF4
         lUy6W4jOKjLfS5ME/AFaySKGdxBK1eX8igyf4oSTzF3ZErT4E0fOuDWGW7vwfD3te5Ks
         QTWy5zZLw+fizPIN2bCQtAwMP1zj50ZOpaUfzXh88lwszzTpbhZP0SpPJ+fC5Z05bViw
         UTEJh689s/zPzklE9WoSviBgQ7wqDVl/4/S/k8uiFcK4Kr8Yurlek6VOGsCYy0HuPGQx
         mVBQ==
X-Gm-Message-State: APjAAAXt1GUh8BXI/zFJ7Ate0KhlG8e+uBioDT4nednjjyW0fM5FEBe0
        ClzWLIpNxPwZ0h8N7tPkLIoT5u0h8HK8zml7
X-Google-Smtp-Source: APXvYqxhoHYw2UwIFnHgS40i9BS2WfJgW0E+O5UD7WRaD2TjAtXL6aBia8pSYw/v6Wtt3OLLn7JqVA==
X-Received: by 2002:a7b:c211:: with SMTP id x17mr26192081wmi.71.1574066354338;
        Mon, 18 Nov 2019 00:39:14 -0800 (PST)
Received: from rudolphp.9e.network (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id z14sm21700530wrl.60.2019.11.18.00.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 00:39:13 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arthur Heymans <arthur@aheymans.xyz>
Subject: [Patch v2 1/3] firmware: google: Release devices before unregistering the bus
Date:   Mon, 18 Nov 2019 09:38:58 +0100
Message-Id: <20191118083903.19311-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Fix a bug where the kernel module can't be loaded after it has been
unloaded as the devices are still present and conflicting with the
to be created coreboot devices.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/firmware/google/coreboot_table.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 8d132e4f008a..0205987a4fd4 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -163,8 +163,15 @@ static int coreboot_table_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int __cb_dev_unregister(struct device *dev, void *dummy)
+{
+	device_unregister(dev);
+	return 0;
+}
+
 static int coreboot_table_remove(struct platform_device *pdev)
 {
+	bus_for_each_dev(&coreboot_bus_type, NULL, NULL, __cb_dev_unregister);
 	bus_unregister(&coreboot_bus_type);
 	return 0;
 }
-- 
2.21.0

