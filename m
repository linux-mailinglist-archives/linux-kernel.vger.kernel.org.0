Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C22D191AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 21:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgCXU2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 16:28:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44847 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgCXU14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:27:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id b72so9899670pfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L6Xkkxw+OtI3K0TdNj5ZNvGMwMn26AVCkhCOCElY92g=;
        b=BGzv+v9RwoXv3iDU0onqRId2oBDvCiAVFMkNKUvSOLU4KPZZyCUxJRqK4FNSDCvigJ
         DEzBfCvciwpVhQKA+Bxoo7ZsBvdjrlVmDDq6gqBCpA+kNMiF2BM7wn0kIemh6axV/X1t
         XeKIM9VJL0aiSmln12rub/u7wV2DrwCkawTgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L6Xkkxw+OtI3K0TdNj5ZNvGMwMn26AVCkhCOCElY92g=;
        b=dbdqIipD32iLDH9ECEFC+PsJibRY1bMyDC//eDPt3PUG+u9ow2/zgQ7DpcMrcJEplR
         BqkuUki0uL90/la4lAVTOvPCoyt6PiIIg1FC2xykfhElQpTdg1LQR2pK4W9+p1fZzUY8
         4z/XEQR6omtNtmnsI0i/gnNw8Hi5k/Vc9JACVxue4Jpk55jJOvnwM9e19AUHKqwk2GTJ
         oWdwLhoDItcm8IBXWXSPt3ezvQQhZzLRIIikgkIoeLf1mUAjHLNdIBiG9RST0JT0tJ+V
         7od7bkNmeSgS9AbolgGIeWMHRiAZ5ims4wV2jhI08uNrsCp67D9N71INFWs0gLc7TUL7
         fYaA==
X-Gm-Message-State: ANhLgQ0n6Epwa4mznRT55ddWOqDx/MXreAk5FpJq/jUj/Eabapx06AQ4
        By4Te9dMOSueSPesMXXIj4baaA==
X-Google-Smtp-Source: ADFU+vtOaXB3ynSuhTM+7qF9JrKZUAehCGVNvqBn/Z8wHVXOvJSCx9omLD3zvqUirBJJVFK42UaloA==
X-Received: by 2002:a63:144e:: with SMTP id 14mr29951381pgu.264.1585081675065;
        Tue, 24 Mar 2020 13:27:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id r70sm5378036pfr.116.2020.03.24.13.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 13:27:54 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v6 07/11] iio: cros_ec: Remove pm function
Date:   Tue, 24 Mar 2020 13:27:32 -0700
Message-Id: <20200324202736.243314-8-gwendal@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200324202736.243314-1-gwendal@chromium.org>
References: <20200324202736.243314-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since cros_ec_sensorhub is shutting down the FIFO when the device
suspends, no need to slow down the EC sampling period rate.
It was necesseary to do that before command CMD_FIFO_INT_ENABLE was
introduced, but now all supported chromebooks have it.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v6:
- No changes.
Changes in v5:
  Added ack.
No changes in v4, v3.
New in v2.

 .../cros_ec_sensors/cros_ec_lid_angle.c       |  1 -
 .../common/cros_ec_sensors/cros_ec_sensors.c  |  1 -
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 47 -------------------
 drivers/iio/light/cros_ec_light_prox.c        |  1 -
 .../linux/iio/common/cros_ec_sensors_core.h   |  5 --
 5 files changed, 55 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
index e30a59fcf0f95..af801e203623e 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
@@ -127,7 +127,6 @@ MODULE_DEVICE_TABLE(platform, cros_ec_lid_angle_ids);
 static struct platform_driver cros_ec_lid_angle_platform_driver = {
 	.driver = {
 		.name	= DRV_NAME,
-		.pm	= &cros_ec_sensors_pm_ops,
 	},
 	.probe		= cros_ec_lid_angle_probe,
 	.id_table	= cros_ec_lid_angle_ids,
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 711134d67ddee..fad21a90bc7e8 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -314,7 +314,6 @@ MODULE_DEVICE_TABLE(platform, cros_ec_sensors_ids);
 static struct platform_driver cros_ec_sensors_platform_driver = {
 	.driver = {
 		.name	= "cros-ec-sensors",
-		.pm	= &cros_ec_sensors_pm_ops,
 	},
 	.probe		= cros_ec_sensors_probe,
 	.id_table	= cros_ec_sensors_ids,
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 01513cb933653..a1ecbd55ea767 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -738,52 +738,5 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_write);
 
-static int __maybe_unused cros_ec_sensors_prepare(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
-
-	if (st->curr_sampl_freq == 0)
-		return 0;
-
-	/*
-	 * If the sensors are sampled at high frequency, we will not be able to
-	 * sleep. Set sampling to a long period if necessary.
-	 */
-	if (st->curr_sampl_freq < CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY) {
-		mutex_lock(&st->cmd_lock);
-		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
-		st->param.ec_rate.data = CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY;
-		cros_ec_motion_send_host_cmd(st, 0);
-		mutex_unlock(&st->cmd_lock);
-	}
-	return 0;
-}
-
-static void __maybe_unused cros_ec_sensors_complete(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
-
-	if (st->curr_sampl_freq == 0)
-		return;
-
-	if (st->curr_sampl_freq < CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY) {
-		mutex_lock(&st->cmd_lock);
-		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
-		st->param.ec_rate.data = st->curr_sampl_freq;
-		cros_ec_motion_send_host_cmd(st, 0);
-		mutex_unlock(&st->cmd_lock);
-	}
-}
-
-const struct dev_pm_ops cros_ec_sensors_pm_ops = {
-#ifdef CONFIG_PM_SLEEP
-	.prepare = cros_ec_sensors_prepare,
-	.complete = cros_ec_sensors_complete
-#endif
-};
-EXPORT_SYMBOL_GPL(cros_ec_sensors_pm_ops);
-
 MODULE_DESCRIPTION("ChromeOS EC sensor hub core functions");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index 03c951ff4a3c3..e10b35de4c2fa 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -255,7 +255,6 @@ MODULE_DEVICE_TABLE(platform, cros_ec_light_prox_ids);
 static struct platform_driver cros_ec_light_prox_platform_driver = {
 	.driver = {
 		.name	= "cros-ec-light-prox",
-		.pm	= &cros_ec_sensors_pm_ops,
 	},
 	.probe		= cros_ec_light_prox_probe,
 	.id_table	= cros_ec_light_prox_ids,
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index b8f573ca9dcc9..96ea4551945e2 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -30,9 +30,6 @@ enum {
  */
 #define CROS_EC_SAMPLE_SIZE  (sizeof(s64) * 2)
 
-/* Minimum sampling period to use when device is suspending */
-#define CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY 1000  /* 1 second */
-
 typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
 
 /**
@@ -117,8 +114,6 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 			       struct iio_chan_spec const *chan,
 			       int val, int val2, long mask);
 
-extern const struct dev_pm_ops cros_ec_sensors_pm_ops;
-
 /* List of extended channel specification for all sensors */
 extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
 
-- 
2.25.1.696.g5e7596f4ac-goog

