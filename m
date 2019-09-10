Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 822B4AEE65
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 17:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405762AbfIJPTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 11:19:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33033 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfIJPTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:19:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so21109572wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 08:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vmUuCMkzir2Sv0OO2nHQXi9m+juUE2w8XHaiTSroSHA=;
        b=kYw/oUI/H82GJRyFfkUzR4+OURd1LYYPwpXS5Eassv7VrsNI7XMdZAjX/Hem4mUJmh
         Q07kd8PYu2S/HY2W5SC/lu+yJ4R0w793l/6htAF9mDMKAzMoFl2DMq1iT6b+LwK6IaQ7
         UOtLAN5bR7qX4XSlusnmqgKWZ9hozJtU1Zp8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vmUuCMkzir2Sv0OO2nHQXi9m+juUE2w8XHaiTSroSHA=;
        b=WknDHH3DC4HHGtlK4LuwqnG9k9d0Y7QbofwBdp69CJpHh+4Bt4qLVBx/b3PcJshthk
         TpeqZ+a4U97LIgkqcXVVyDYaTZYknLA7LURBhxI9425tfbNBW3j4B7cWBCQEVuichH87
         4PiRbzimsAQ7M6JuZfhCknI2Trd1hQVXnnUa4MupfhEI3H5D19u+b+68tMrecNWJ5U5G
         B0rAM4Evsxbjno/AQQk0s46T9lXnpss1IFR4NY2+udsp2JgfVAd9eUkqLbXHoOfkhqSk
         6hjlDooLYNNhWsLQTH5ZBhOdkbdmYZcObwobUtMD0BR1tIzcYjBLhjaERhNy5E4orJnw
         Y/4w==
X-Gm-Message-State: APjAAAVKQ4FN+8ihYPHxBVnYen0ybTyP0I5N2oXDiBxtWG1vRPZKSN1Z
        NODRZbSyBM1P1bsXhr0Hb8NVuY6lru3owR2A
X-Google-Smtp-Source: APXvYqw39BL6cpTQ2h3WRAEb89m10wkW4DGlcBRXCORRYb3DbUpcGPbZICuw3hLTec/QOR2bEOCGEQ==
X-Received: by 2002:a5d:678a:: with SMTP id v10mr26708489wru.145.1568128788717;
        Tue, 10 Sep 2019 08:19:48 -0700 (PDT)
Received: from penguin.lxd ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id o22sm32753305wra.96.2019.09.10.08.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 08:19:48 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Duncan Laurie <dlaurie@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH] rtc: wilco-ec: Sanitize values received from RTC
Date:   Tue, 10 Sep 2019 16:19:29 +0100
Message-Id: <20190910151929.780-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that the time received from the RTC HW is valid,
otherwise the computation of rtc_year_days() in the next
line could, and sometimes does, crash the kernel.

While we're at it, fix the license to plain "GPL".

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/rtc/rtc-wilco-ec.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
index 8ad4c4e6d557..0ccbf2dce832 100644
--- a/drivers/rtc/rtc-wilco-ec.c
+++ b/drivers/rtc/rtc-wilco-ec.c
@@ -110,8 +110,16 @@ static int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
 	tm->tm_mday	= rtc.day;
 	tm->tm_mon	= rtc.month - 1;
 	tm->tm_year	= rtc.year + (rtc.century * 100) - 1900;
-	tm->tm_yday	= rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
 
+	if (rtc_valid_tm(tm)) {
+		dev_warn(dev,
+			 "Time computed from EC RTC is invalid: sec=%d, min=%d, hour=%d, mday=%d, mon=%d, year=%d",
+			 tm->tm_sec, tm->tm_min, tm->tm_hour, tm->mday,
+			 tm->mon, tm->year);
+		return -EIO;
+	}
+
+	tm->tm_yday = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
 	/* Don't compute day of week, we don't need it. */
 	tm->tm_wday = -1;
 
@@ -188,5 +196,5 @@ module_platform_driver(wilco_ec_rtc_driver);
 
 MODULE_ALIAS("platform:rtc-wilco-ec");
 MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Wilco EC RTC driver");
-- 
2.11.0

