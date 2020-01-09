Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B579B135D4B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 16:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbgAIP7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 10:59:14 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40435 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgAIP7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:59:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id q8so3566655pfh.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 07:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cC7e4sZIYg821eKJO+DDGUYsV8tW+ZiFX2jSc3a6ejs=;
        b=At/pA97Tww81Ck12OJGBSP+upDXjgtRUrwsWrp8PB9s1GN8Z85Z7M3rXhTpZOd9SnR
         4NUWhUwehZhMfsFZKKFk0nt6ITtgoVvySpLZ9Sy72kMBlw6UHDS5KIlbo1qUOou4crLp
         1/YW4O0Y19yy8yyU2zJ+1NFa/mORG80/DWTFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cC7e4sZIYg821eKJO+DDGUYsV8tW+ZiFX2jSc3a6ejs=;
        b=DA264JklTAgGXETfJr3ZA8IFG2uGb8cRVFZApVu+iy36i7yf8gGSfngScIWQ3QBfGT
         MECGBh8XVtevTfdfkEOPkxyiPnzqY9UFAh+VrzYgxS04rB71Xztd0KNaDUPSFj33qVFn
         Oz+JFkzOdf9VWo0qMvtVmHxY0nv+Xzu8Nbn9bNV+/oU1D+dtnElWpjRIaDZdNqfDSAOd
         D6+j/2q6MnaONvKf47hFzkAv/Fb873rnpfrjZ6YLLOFX7qqiB6MauiYeCDar6l10/vvX
         u1w8ij0k9OZnk4oCmcvaiC8jieuyF+/0w37VlSJdBqLo4wapLhmUX3VcLERyCV6YTbC6
         nKgg==
X-Gm-Message-State: APjAAAUy2Ap/L8grv+KBFP+sUQ2fAS/jGtKBCxQi5E0I2lYwUMwaaFxo
        AZ2lsG7tBfE2AQhG0aXIGzTwfA==
X-Google-Smtp-Source: APXvYqyxieBN38VR8F8yHHtVQjEXLbpQ0B93+J6gdfkt9/TPkHxP2KqLFyqedxOQuVY8tPY3VOijZg==
X-Received: by 2002:a63:d906:: with SMTP id r6mr11992384pgg.440.1578585552780;
        Thu, 09 Jan 2020 07:59:12 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j20sm7832793pfe.168.2020.01.09.07.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 07:59:12 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 2/4] alarmtimer: Make alarmtimer platform device child of RTC device
Date:   Thu,  9 Jan 2020 07:59:08 -0800
Message-Id: <20200109155910.907-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20200109155910.907-1-swboyd@chromium.org>
References: <20200109155910.907-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alarmtimer_suspend() function will fail if an RTC device is on a bus
such as SPI or i2c and that RTC device registers and probes after
alarmtimer_init() registers and probes the 'alarmtimer' platform device.
This is because system wide suspend suspends devices in the reverse
order of their probe. When alarmtimer_suspend() attempts to program the
RTC for a wakeup it will try to program an RTC device on a bus that has
already been suspended.

Let's move the alarmtimer device registration to be when the RTC we use
for wakeup is registered. Register the 'alarmtimer' platform device as a
child of the RTC device too, so that we can be guaranteed that the RTC
device won't be suspended when alarmtimer_suspend() is called.

Reported-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 kernel/time/alarmtimer.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 4b11f0309eee..ccb6aea4f1d4 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -88,6 +88,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 	unsigned long flags;
 	struct rtc_device *rtc = to_rtc_device(dev);
 	struct wakeup_source *__ws;
+	struct platform_device *pdev;
 	int ret = 0;
 
 	if (rtcdev)
@@ -99,6 +100,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 		return -1;
 
 	__ws = wakeup_source_register(dev, "alarmtimer");
+	pdev = platform_device_register_data(dev, "alarmtimer", -1, NULL, 0);
 
 	spin_lock_irqsave(&rtcdev_lock, flags);
 	if (!rtcdev) {
@@ -112,10 +114,12 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 		get_device(dev);
 		ws = __ws;
 		__ws = NULL;
+		pdev = NULL;
 	}
 unlock:
 	spin_unlock_irqrestore(&rtcdev_lock, flags);
 
+	platform_device_unregister(pdev);
 	wakeup_source_unregister(__ws);
 
 	return ret;
@@ -876,8 +880,7 @@ static struct platform_driver alarmtimer_driver = {
  */
 static int __init alarmtimer_init(void)
 {
-	struct platform_device *pdev;
-	int error = 0;
+	int error;
 	int i;
 
 	alarmtimer_rtc_timer_init();
@@ -900,15 +903,7 @@ static int __init alarmtimer_init(void)
 	if (error)
 		goto out_if;
 
-	pdev = platform_device_register_simple("alarmtimer", -1, NULL, 0);
-	if (IS_ERR(pdev)) {
-		error = PTR_ERR(pdev);
-		goto out_drv;
-	}
 	return 0;
-
-out_drv:
-	platform_driver_unregister(&alarmtimer_driver);
 out_if:
 	alarmtimer_rtc_interface_remove();
 	return error;
-- 
Sent by a computer, using git, on the internet

