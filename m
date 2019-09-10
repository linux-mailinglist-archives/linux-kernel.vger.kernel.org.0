Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 586CEAE56F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 10:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfIJIWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 04:22:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38131 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfIJIWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 04:22:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id l11so18228237wrx.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 01:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RMKlXc+O7D5bCEwjDFFMVCcJWJjC2HcosOo5F0af2FI=;
        b=w5yp3SAoZLSEZHdc4COhQMLChm6+6lkbYEEEox3jiTQJlbtARAZq0gCWGPUZbvCR1N
         Fa28W1OpRk6mjYDIeE4Q3QDcQzEZef+qYmuz1Tl1SktRh24VyKr5+UaleXWmlK8iXYvA
         OTedXapPS/oe2CR46mDhaAsNYE6Jc3mvwjcyHTwQ2019/hOvrPvZSpTucSsY55149Azr
         FYUUT9T9xmvBIE8NsXwokYqaEXA/FhRuLa7qNK/IR3fvAIrGBr4qVQkvURboA2mqVUfs
         8xTP1rWx8wj+SsUGMoXzy1+DXMZXOeaFqFj3wpbuXBA2cZ59Enp9bcacLMSs9Y49dBrn
         jWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RMKlXc+O7D5bCEwjDFFMVCcJWJjC2HcosOo5F0af2FI=;
        b=CDMPFVd1S060Z0kadmWIFpPb/A/GVOfd9quIypON9Y+nrwyfrl6hc+Wb6twgAaT0t6
         mWcW/BvA+t0aDsv675mA/dKxvTf9/LeIPpIIN5KORPo9WYxAjHipc0IolXZb/5fc704n
         70G/B7Yit7dMc4+pdq3pOq979uNKySXeuTQNFVb/YRmO7NGyYHsgFNTTY4tuYn7fZsqB
         tiv4YmJGLyIWn81EXv0UM7B9Kxxx/AlUKN6yYrfhzzLaRAv2OdCXDsVKZgeqItGYwSgs
         MVqF22w0C6fbEQBcA25/548pI5x2EW1TVJVY5sxj4ffuSqXtQ0UXyjOJmTd/6CoCLfSV
         xBDw==
X-Gm-Message-State: APjAAAU3bziy5PRoqTTP7ICe3oxMV/GOlSieQo7keceKfHOJVURwZhaz
        bQc38h9aNgXp34KzHo93l+PpEA==
X-Google-Smtp-Source: APXvYqyM5+/RiHdg9qMKBydxzwyIXjhSzKk7we5ZuMc9Gn9PbbHTDuepiFwku8fXnT/Vo+JTAk0qyQ==
X-Received: by 2002:adf:dc41:: with SMTP id m1mr11190301wrj.46.1568103738351;
        Tue, 10 Sep 2019 01:22:18 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id 189sm2534813wmz.19.2019.09.10.01.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 01:22:17 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org, Kent Gibson <warthog618@gmail.com>
Subject: [PATCH] gpiolib: don't clear FLAG_IS_OUT when emulating open-drain/open-source
Date:   Tue, 10 Sep 2019 10:21:38 +0200
Message-Id: <20190910082138.30193-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

When emulating open-drain/open-source by not actively driving the output
lines - we're simply changing their mode to input. This is wrong as it
will then make it impossible to change the value of such line - it's now
considered to actually be in input mode. If we want to still use the
direction_input() callback for simplicity then we need to set FLAG_IS_OUT
manually in gpiod_direction_output() and not clear it in
gpio_set_open_drain_value_commit() and
gpio_set_open_source_value_commit().

Fixes: c663e5f56737 ("gpio: support native single-ended hardware drivers")
Cc: stable@vger.kernel.org
Reported-by: Kent Gibson <warthog618@gmail.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index cca749010cd0..6bb4191d3844 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2769,8 +2769,10 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 		if (!ret)
 			goto set_output_value;
 		/* Emulate open drain by not actively driving the line high */
-		if (value)
-			return gpiod_direction_input(desc);
+		if (value) {
+			ret = gpiod_direction_input(desc);
+			goto set_output_flag;
+		}
 	}
 	else if (test_bit(FLAG_OPEN_SOURCE, &desc->flags)) {
 		ret = gpio_set_config(gc, gpio_chip_hwgpio(desc),
@@ -2778,8 +2780,10 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 		if (!ret)
 			goto set_output_value;
 		/* Emulate open source by not actively driving the line low */
-		if (!value)
-			return gpiod_direction_input(desc);
+		if (!value) {
+			ret = gpiod_direction_input(desc);
+			goto set_output_flag;
+		}
 	} else {
 		gpio_set_config(gc, gpio_chip_hwgpio(desc),
 				PIN_CONFIG_DRIVE_PUSH_PULL);
@@ -2787,6 +2791,17 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 
 set_output_value:
 	return gpiod_direction_output_raw_commit(desc, value);
+
+set_output_flag:
+	/*
+	 * When emulating open-source or open-drain functionalities by not
+	 * actively driving the line (setting mode to input) we still need to
+	 * set the IS_OUT flag or otherwise we won't be able to set the line
+	 * value anymore.
+	 */
+	if (ret == 0)
+		set_bit(FLAG_IS_OUT, &desc->flags);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(gpiod_direction_output);
 
@@ -3147,8 +3162,6 @@ static void gpio_set_open_drain_value_commit(struct gpio_desc *desc, bool value)
 
 	if (value) {
 		err = chip->direction_input(chip, offset);
-		if (!err)
-			clear_bit(FLAG_IS_OUT, &desc->flags);
 	} else {
 		err = chip->direction_output(chip, offset, 0);
 		if (!err)
@@ -3178,8 +3191,6 @@ static void gpio_set_open_source_value_commit(struct gpio_desc *desc, bool value
 			set_bit(FLAG_IS_OUT, &desc->flags);
 	} else {
 		err = chip->direction_input(chip, offset);
-		if (!err)
-			clear_bit(FLAG_IS_OUT, &desc->flags);
 	}
 	trace_gpio_direction(desc_to_gpio(desc), !value, err);
 	if (err < 0)
-- 
2.21.0

