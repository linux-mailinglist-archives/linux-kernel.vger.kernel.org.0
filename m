Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147F5135D4E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 16:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbgAIP7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 10:59:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47088 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732721AbgAIP7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:59:16 -0500
Received: by mail-pg1-f194.google.com with SMTP id z124so3394573pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 07:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BBjMceqifOSdeK4z+Ks0h7Q/aDc8IcTUGADsTXrO7L0=;
        b=N4S0B6F8IiE4z7opHsaM94l0+7I7mIXpXfhh4cWzMU03K7Rq+OB/5q9XAJaHpFq9UL
         kO5VFAvpuZBHubHCqOLlzSS62K2N8C+f0DZzVa3f7OlSG2OuTQCsigLZsa+5xEjyqnL/
         sfzuU1BJPn3tzn5+tX5ZsxuPR+IYrZmfrm2pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBjMceqifOSdeK4z+Ks0h7Q/aDc8IcTUGADsTXrO7L0=;
        b=Z8Y2xu01fBocVNwr7QqRB9oU1u7mZ88f9/2WbdhzcmPooT6+IccKTF3Jf6LqTILVCX
         HySuKIXBlm5oeco77UWWIJsI2DMU0ftllL3O27WaLOLwmXQHTLAqj+drVAgFFCZKfale
         k1SkPwlW1pKJ+zc7pbHI20yBuHsXC/vGWhH9w9tyqCDTPCaQEOvW1rt8zbbm6Hb6mlkN
         F+Trg4kBC3WQJF80fN988WxdNTYYbPbAljvs6TtrRgUjL3fV0EzcaYX3U28YjVTjWl7x
         yCL7zIWIjm9VGvJg/uZn0Fyb3FVqvf5BRUzJsEk1msVxJ8qxb4jGknP/uxeO5ft7J6+Q
         ETrg==
X-Gm-Message-State: APjAAAUf+ULIRhwQiX4vDZIWyXXvE0cItRaSuMgi1skOIUtNQUlAS2hE
        PoJVMqxEAxHxQZtdx1Xu3Ivgfg==
X-Google-Smtp-Source: APXvYqxZQBTxxTUzwW63ixfVQkxfS1lOCFCTsOehZM4baWW5fOxuZtd1cXy9Hkr9yzUPJlSXgd1FWA==
X-Received: by 2002:a63:28c7:: with SMTP id o190mr11615317pgo.394.1578585554258;
        Thu, 09 Jan 2020 07:59:14 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j20sm7832793pfe.168.2020.01.09.07.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 07:59:13 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4/4] alarmtimer: Always export alarmtimer_get_rtcdev() and update docs
Date:   Thu,  9 Jan 2020 07:59:10 -0800
Message-Id: <20200109155910.907-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20200109155910.907-1-swboyd@chromium.org>
References: <20200109155910.907-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The export isn't there for the stubbed version of
alarmtimer_get_rtcdev(), so move the export outside of the ifdef. And
rtcdev isn't used outside of this ifdef so we don't need to redefine it
as NULL.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 kernel/time/alarmtimer.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index be057638e89d..dc4d3edc2a7d 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -64,8 +64,6 @@ static DEFINE_SPINLOCK(rtcdev_lock);
  * alarmtimer_get_rtcdev - Return selected rtcdevice
  *
  * This function returns the rtc device to use for wakealarms.
- * If one has not already been chosen, it checks to see if a
- * functional rtc device is available.
  */
 struct rtc_device *alarmtimer_get_rtcdev(void)
 {
@@ -78,7 +76,6 @@ struct rtc_device *alarmtimer_get_rtcdev(void)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(alarmtimer_get_rtcdev);
 
 static int alarmtimer_rtc_add_device(struct device *dev,
 				struct class_interface *class_intf)
@@ -143,11 +140,11 @@ struct rtc_device *alarmtimer_get_rtcdev(void)
 {
 	return NULL;
 }
-#define rtcdev (NULL)
 static inline int alarmtimer_rtc_interface_setup(void) { return 0; }
 static inline void alarmtimer_rtc_interface_remove(void) { }
 static inline void alarmtimer_rtc_timer_init(void) { }
 #endif
+EXPORT_SYMBOL_GPL(alarmtimer_get_rtcdev);
 
 /**
  * alarmtimer_enqueue - Adds an alarm timer to an alarm_base timerqueue
-- 
Sent by a computer, using git, on the internet

