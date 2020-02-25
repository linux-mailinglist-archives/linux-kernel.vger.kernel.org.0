Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB3216B8C4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 06:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgBYFIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 00:08:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33069 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbgBYFIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:08:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id n7so6555708pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 21:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4dT1j16IciiytxpKHBSJM5MDLlGyaxsTmdCg+EeHcyk=;
        b=SCflCDTnra+X8RiaT5pduzy9d+l2Jf7TMEo1AIIZ6FhWILO3GN9Ia4TZ8MvgxP62y6
         jEOxIN/VIFGGTpmGAj+CeyEuBScAnLxMlOwd+W4x1DT/P6Bb5OdUQMHzzFAhe1BWkSxs
         qLo9A8M32cwjcVdF1rFjfJwcoZlXWkox2tEUaC0NWVSoJX9IY16SKE3LiMNtOTyJpZIj
         21HGc6Zd+Etv8SwVpX5TnBsDF28v5Wp7AAc/ckldwD3yetYqqlLCcubZoMXJzTHB8BZC
         Exjz8ka1Zgo4eysigntlYUxwOsWojDKPFMZjkplzeXMpXb8VQPfXL254YlnOT0okKHuF
         G9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4dT1j16IciiytxpKHBSJM5MDLlGyaxsTmdCg+EeHcyk=;
        b=GY1/TA819q6bQvvjT8vgAFDPM83+eOAJVP80GNKuZB8MVPrdgI1pJA/thKpaWNk7nw
         As6Gn8yAa/pnBvBIElCswvMvDU7xssXJYNiZZ9PysCdaeg1cLwQMEIfOtOmrlUSnybB5
         1q6z8XTIxOxDSuPxJqyY8+Hyq7ztSlba3lWE92GcGelQUgukYYBbVUB4CV1ezlLrnkIl
         MWjHL8zPW1wJdtsznGQ65vHbimtapBSxExkA+QviQ9lGlsjDkcP1byF3y4McvhyjFlqt
         69HlsjYuyJJlR1+f0XdOfIKY39pDv6A+e7RDjwLPaL4QcSsXBiQc6ebrVRAX2Qu+wsxW
         y2zg==
X-Gm-Message-State: APjAAAW3oGu4qz9T+guEFtVkD1PJUfSVaTr6e5cPuQdaIvZCR1FVrllY
        hWcr7mvkBtYn3/LANQW/JZPZqyTaek4=
X-Google-Smtp-Source: APXvYqz6vMRedv6tkkMlwmoMLzeiJWwmaD/B49LsWi3HkfkxgdYxvFNQl+03CHoLiBqwx+ivrRzo9w==
X-Received: by 2002:a63:dc0d:: with SMTP id s13mr54109834pgg.129.1582607329264;
        Mon, 24 Feb 2020 21:08:49 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id r66sm15156450pfc.74.2020.02.24.21.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 21:08:48 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 4/6] driver core: Remove driver_deferred_probe_check_state_continue()
Date:   Tue, 25 Feb 2020 05:08:26 +0000
Message-Id: <20200225050828.56458-5-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225050828.56458-1-john.stultz@linaro.org>
References: <20200225050828.56458-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that driver_deferred_probe_check_state() works better, and
we've converted the only user of
driver_deferred_probe_check_state_continue() we can simply
remove it and simplify some of the logic.

Cc: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/base/dd.c             | 53 ++++++-----------------------------
 include/linux/device/driver.h |  1 -
 2 files changed, 8 insertions(+), 46 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index fe26f2574a6d..c09e4e7277d4 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -244,19 +244,6 @@ static int __init deferred_probe_timeout_setup(char *str)
 }
 __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
 
-static int __driver_deferred_probe_check_state(struct device *dev)
-{
-	if (!IS_ENABLED(CONFIG_MODULES) && initcalls_done)
-		return -ENODEV;
-
-	if (!deferred_probe_timeout) {
-		dev_WARN(dev, "deferred probe timeout, ignoring dependency");
-		return -ETIMEDOUT;
-	}
-
-	return -EPROBE_DEFER;
-}
-
 /**
  * driver_deferred_probe_check_state() - Check deferred probe state
  * @dev: device to check
@@ -272,39 +259,15 @@ static int __driver_deferred_probe_check_state(struct device *dev)
  */
 int driver_deferred_probe_check_state(struct device *dev)
 {
-	int ret;
-
-	ret = __driver_deferred_probe_check_state(dev);
-	if (ret != -ENODEV)
-		return ret;
-
-	dev_warn(dev, "ignoring dependency for device, assuming no driver");
-
-	return -ENODEV;
-}
-
-/**
- * driver_deferred_probe_check_state_continue() - check deferred probe state
- * @dev: device to check
- *
- * Returns -ETIMEDOUT if deferred probe debug timeout has expired, or
- * -EPROBE_DEFER otherwise.
- *
- * Drivers or subsystems can opt-in to calling this function instead of
- * directly returning -EPROBE_DEFER.
- *
- * This is similar to driver_deferred_probe_check_state(), but it allows the
- * subsystem to keep deferring probe after built-in drivers have had a chance
- * to probe. One scenario where that is useful is if built-in drivers rely on
- * resources that are provided by modular drivers.
- */
-int driver_deferred_probe_check_state_continue(struct device *dev)
-{
-	int ret;
+	if (!IS_ENABLED(CONFIG_MODULES) && initcalls_done) {
+		dev_warn(dev, "ignoring dependency for device, assuming no driver");
+		return -ENODEV;
+	}
 
-	ret = __driver_deferred_probe_check_state(dev);
-	if (ret != -ENODEV)
-		return ret;
+	if (!deferred_probe_timeout) {
+		dev_WARN(dev, "deferred probe timeout, ignoring dependency");
+		return -ETIMEDOUT;
+	}
 
 	return -EPROBE_DEFER;
 }
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 1188260f9a02..5242afabfaba 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -238,7 +238,6 @@ driver_find_device_by_acpi_dev(struct device_driver *drv, const void *adev)
 
 void driver_deferred_probe_add(struct device *dev);
 int driver_deferred_probe_check_state(struct device *dev);
-int driver_deferred_probe_check_state_continue(struct device *dev);
 void driver_init(void);
 
 /**
-- 
2.17.1

