Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17E831491FD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jan 2020 00:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbgAXXZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 18:25:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46896 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387447AbgAXXZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 18:25:24 -0500
Received: by mail-pl1-f196.google.com with SMTP id y8so1388733pll.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 15:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FARh9+NSyoh9cEVojaQ5yO/5qNpny8hvAgXD5nEC67I=;
        b=H06xmx89YXaZ0rcfRMS2TzEW37mYI8VF98nq0ZMSaYi3lu8uAeqHa9gZSfOnFRnKYm
         qoFdh8VmrW/jYfFXK8gbQ2XlEKnW0TJ3P54II9lv3xnVRSLXaGayP+I8D1beKJxMK8bs
         oKHBzJRcMOmv12M0LXdfYDDpetCcuhWsZ6r5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FARh9+NSyoh9cEVojaQ5yO/5qNpny8hvAgXD5nEC67I=;
        b=VsCEgAhCEnXJyBGGnxyYZ821CIuLSTM93C/DyxTFO26qRiYvcJ+3qLoqUya7WO8OIB
         yQwRS9JWrqVs1K2wPDHCt5RRKbof66+dsyKP2kMEbKoRY13VLTjfYG/5JIw9RWXtLjDK
         pbU/tkAPayZ4mBu4w97csA15WzzhPVoSn1BWrOU6/C4G7bNQyGaI3B72D/ojAr900rk5
         1v1XpGG4sht2hbsTuPlbQvHW3NYIkLU9cQNcj1Sb2zs7jwf4xS0270CR5+RyILORIKwU
         RXw5HKBz81/7AdU7ccbj+eikx46hWJaFWuUafpseB15QlebzKPw7KAuDI+V/kwgR0T/S
         rc+Q==
X-Gm-Message-State: APjAAAVrGHi//MRbgYMPJPk85TUJZDYXKoYq9EakfGvjiO1FDHfZgS+U
        mMRxtlI6pPUwj2i+F81K1aTs7w==
X-Google-Smtp-Source: APXvYqyHd5FT8CvoOI9/vPxv4sxwo5PHmJDSN6SkVVSjaI1OtaJ7MDk1gnotjCGKLpyZEXEYrUGOcA==
X-Received: by 2002:a17:90a:9c1:: with SMTP id 59mr1846965pjo.65.1579908323338;
        Fri, 24 Jan 2020 15:25:23 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id b12sm2823103pfr.26.2020.01.24.15.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 15:25:22 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org, sre@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v8 3/4] mfd: cros_ec: Check DT node for usbpd-notify add
Date:   Fri, 24 Jan 2020 15:18:36 -0800
Message-Id: <20200124231834.63628-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200124231834.63628-1-pmalani@chromium.org>
References: <20200124231834.63628-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check to ensure there is indeed an EC device tree entry before
adding the cros-usbpd-notify device. This covers configs where both
CONFIG_ACPI and CONFIG_OF are defined, but the EC device is defined
using device tree and not in ACPI.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v8:
- Patch first introduced in v8 of the series.

 drivers/mfd/cros_ec_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index d0c28a4c10ad0..411e80fc9a066 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -212,7 +212,7 @@ static int ec_device_probe(struct platform_device *pdev)
 	 * explicitly added on platforms that don't have the PD notifier ACPI
 	 * device entry defined.
 	 */
-	if (IS_ENABLED(CONFIG_OF)) {
+	if (IS_ENABLED(CONFIG_OF) && ec->ec_dev->dev->of_node) {
 		if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
 			retval = mfd_add_hotplug_devices(ec->dev,
 					cros_usbpd_notify_cells,
-- 
2.25.0.341.g760bfbb309-goog

