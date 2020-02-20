Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08EFF16567F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 06:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgBTFFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 00:05:09 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45548 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgBTFFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:05:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so1044933pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aixlBG1IUMuyRnlbsO9Bddkyq8kq21Uvz9l57YstKEY=;
        b=j2ufgc2A6/zlTZrKnv+kOV8+1hQXXn3hsLZe88ekx9d15lUcmJnyFUmhDsip74svCh
         pr7/+G5aP6LdzE4a7lEJUZgNTJMhvYQE/MKQ4aG/rMEG02biDlVWqaIUw8PgVwbDxwS1
         dSJ/9VHA7hhoPMtn++Xrple53Lem5Nsayidp3GA+3+TlpYNWCwa+N3TKHz5zYeol9AUp
         trdAnxxH31Bt/cY/j24Bq+ddIJ0mb+gOBv9XXnT3AUQdT4FVG0FHMS/eyoxgshaj0aDe
         NuXP3JUSwR6i0KECbbq/OVFbX3uAJmVBj+k/4sVu8kBtxetNlMs4NXbFXIasx0g2OUz6
         U9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aixlBG1IUMuyRnlbsO9Bddkyq8kq21Uvz9l57YstKEY=;
        b=mPcbTm36q/CZWPXrmT7q+V6wRbVoq6Xm9UPrlkhbOhFhWTQLD/PuIX8efChzdM8mE3
         TFMzgt58h4xd048V0SdGPfg3xoyj7O3fu8Uav5ydtYgNXpdUU0BKv4cdF8grJebGcXB6
         oJ4bqD6pQhRSveuY9BIIuQtkPPbM4WVlqZjCq029qcxAUqpt+5PMRZDG5dLPcCek3LgM
         DrLNmZ9J98KivgWA5h1x9vY1aMENMmw61kwiGFACrIuXuELGWocxE5NoQTPdJ6IY3nJP
         MntLWz0YMA5MkLZ72Pih++Ru44hdmEu0uTjUqw6hlU0Zjf2MNMDnq8PLmopqs9kbKMuK
         9Pfw==
X-Gm-Message-State: APjAAAVScXzRsB9jNri4hCYEsfftK7nFGTsOXutu9Jci35L08Sf9g6/C
        hlPcIj6V9LpTp4ll2WHfHEtp4j/kyuk=
X-Google-Smtp-Source: APXvYqzmBhGA+NC9IeOnvf5JOOp42iqCCjHX+Qckv0WLtqV7PEDyvMGdktmnkX5JTyIHsNGyOPPQUA==
X-Received: by 2002:a17:90a:cc10:: with SMTP id b16mr1393657pju.55.1582175106420;
        Wed, 19 Feb 2020 21:05:06 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id z4sm1400847pfn.42.2020.02.19.21.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:05:05 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 4/6] driver core: Remove driver_deferred_probe_check_state_continue()
Date:   Thu, 20 Feb 2020 05:04:38 +0000
Message-Id: <20200220050440.45878-5-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220050440.45878-1-john.stultz@linaro.org>
References: <20200220050440.45878-1-john.stultz@linaro.org>
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
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
Change-Id: Id5cd5e9264cfb0fbd70a702715174cc4b10006f4
---
 drivers/base/dd.c             | 49 +++++------------------------------
 include/linux/device/driver.h |  1 -
 2 files changed, 6 insertions(+), 44 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index fa138f24e2d3..408e4da081da 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -244,19 +244,6 @@ static int __init deferred_probe_timeout_setup(char *str)
 }
 __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
 
-static int __driver_deferred_probe_check_state(struct device *dev)
-{
-	if (!initcalls_done || deferred_probe_timeout > 0)
-		return -EPROBE_DEFER;
-
-	if (!deferred_probe_timeout) {
-		dev_WARN(dev, "deferred probe timeout, ignoring dependency");
-		return -ETIMEDOUT;
-	}
-
-	return 0;
-}
-
 /**
  * driver_deferred_probe_check_state() - Check deferred probe state
  * @dev: device to check
@@ -272,43 +259,19 @@ static int __driver_deferred_probe_check_state(struct device *dev)
  */
 int driver_deferred_probe_check_state(struct device *dev)
 {
-	int ret;
+	if (!initcalls_done || deferred_probe_timeout > 0)
+		return -EPROBE_DEFER;
 
-	ret = __driver_deferred_probe_check_state(dev);
-	if (ret < 0)
-		return ret;
+	if (!deferred_probe_timeout) {
+		dev_WARN(dev, "deferred probe timeout, ignoring dependency");
+		return -ETIMEDOUT;
+	}
 
 	dev_warn(dev, "ignoring dependency for device, assuming no driver");
 
 	return -ENODEV;
 }
 
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
-
-	ret = __driver_deferred_probe_check_state(dev);
-	if (ret < 0)
-		return ret;
-
-	return -EPROBE_DEFER;
-}
-
 static void deferred_probe_timeout_work_func(struct work_struct *work)
 {
 	struct device_private *private, *p;
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

