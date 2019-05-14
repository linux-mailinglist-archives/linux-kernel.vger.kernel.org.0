Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D431CF65
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 20:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfENSug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 14:50:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43405 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfENSuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:50:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so20351526wro.10;
        Tue, 14 May 2019 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QahSchxTBIWvI+J0jeWN31ISJjvI737a7ggT3tukSCc=;
        b=bi+Vyf31V5rZkxtQ6SBt1edDB9wu533w8hjLnqyJ3p1zpQ5Lqc7IKc3FhHuJeLbLdZ
         NCp68XJfyHfb+C5gRySGeesutkds2cgY+3YAkUUHKhclwevOp7AR5nOl+1sORsFWV6UC
         jyE0w81jcpwfi0GaFpJhtFlsqGpXlKknojjF/Ewehjs7nAyqLzL0nzQzRTnSYQdbkwOV
         cT+A4pDjTEDrJwXH7a+yBZK0ztlkWbXONMkg+dM6yzOFIEMR5/eJLZFgOQ4McqdvUjyF
         BZw40fh0pC10bSqFxNXkSyYS+Ib05f5ff5bm0tssHIJ07m8BkIGKTj/JjZKdTblsyJu1
         ILng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QahSchxTBIWvI+J0jeWN31ISJjvI737a7ggT3tukSCc=;
        b=j7J6sy01SKm6CA1PkuJHCQySFsr4NjU4JdQSYog/3X+HESRzqyKoAEN0fhm6BaNre2
         Dl9WCW/09ZMioSX+n3+whowaEw3K9IMpRmPyitDTxvt3SSMohILwsnAZ/Iyw3eqmyINg
         dTW84yjaE34gst+phJBq3le7NAp796ICZkgSeJZCyThDbK0bsmLWQfFz2QFd/JlnTsFk
         ghPUMa9DUz3dt7fdzniQUwEtJkZWWqLRe3NLuJbMsy4fwW6R2887IOLB+zzEWXryjMKH
         jnxhhIzTOrFDFe0cx/Zx6PFx5OaN0WGhbx0R8kaUxwsghrphK6bxRKlbTTELu36G1ayE
         kV9A==
X-Gm-Message-State: APjAAAXPpIsdGKhowu6e1yEntJ0kQmaDeSxU+/IAUv3zGLoVN1MzpKof
        NNwTNlTWtMk1fcSIbzRfVe3QqcpY
X-Google-Smtp-Source: APXvYqzO2xlinDEk0pB6UN1QnjwARAPwp7hPExd3lViuV1pxpwF8F61asqnlTQu+c8ziwjGohtU93A==
X-Received: by 2002:a5d:6710:: with SMTP id o16mr20610564wru.173.1557859833462;
        Tue, 14 May 2019 11:50:33 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id i25sm6049372wmb.46.2019.05.14.11.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:50:32 -0700 (PDT)
Subject: [PATCH v4 01/13] platform/x86: asus-wmi: Fix hwmon device cleanup
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
Message-ID: <e0f78773-518b-b62d-3d95-12225724ea5f@gmail.com>
Date:   Tue, 14 May 2019 20:50:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not clean up the hwmon device on exit or error. To
reproduce the bug, repeat rmmod, insmod to verify that device number
/sys/devices/platform/asus-nb-wmi/hwmon/hwmon?? grows every time. Replace
call for registering device with devm_* version that unregisters it
automatically.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index f94691615881..62567766bdfb 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1428,11 +1428,12 @@ __ATTRIBUTE_GROUPS(hwmon_attribute);
 
 static int asus_wmi_hwmon_init(struct asus_wmi *asus)
 {
+	struct device *dev = &asus->platform_device->dev;
 	struct device *hwmon;
 
-	hwmon = hwmon_device_register_with_groups(&asus->platform_device->dev,
-						  "asus", asus,
-						  hwmon_attribute_groups);
+	hwmon = devm_hwmon_device_register_with_groups(dev, "asus", asus,
+			hwmon_attribute_groups);
+
 	if (IS_ERR(hwmon)) {
 		pr_err("Could not register asus hwmon device\n");
 		return PTR_ERR(hwmon);
-- 
2.17.1

