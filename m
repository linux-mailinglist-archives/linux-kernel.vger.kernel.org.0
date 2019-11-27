Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE8610B043
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 14:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfK0Nf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 08:35:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38918 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfK0NfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:35:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so23595273wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 05:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mslRHHSp/cuNnBW29h3HN5M5/Ygh6sAx6mKJrlS5yNM=;
        b=L39O5l1Bh6Cg0zjRCGUW/UflTYnRO4ha2Z0/IveUnm+6Sf3fIABsaxY5HcOiUll4tX
         x2Gr/Z+v0FIrOG2dO4+VRjeD0GBswHqmZ+opa5ZN5YNQedNV+qZaYgvLdraYJFslD2ND
         Jg91Uolb+8TxfqtZDE+syGwM0rCVGd+T2aDHHMNzjqGEOX+c8aRrqVrtMX6V+uk68ZG1
         tsNBo1lJFS8hXybSasuygzNLdl9WUNnGq7u9zGAUtMZt0VOygeB8DGqfPPjO8XFG0jTa
         6Q1YknCZMU3y7aPFOw4GUxGPk24/5z+zFbn0cOdeSOUXsnjXP74/mycfVg5zXQB3zKEN
         ZrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mslRHHSp/cuNnBW29h3HN5M5/Ygh6sAx6mKJrlS5yNM=;
        b=todnWgLLu41A8RhKc5OWVI+MbiIIKhs2gkkgWnTUzcpG7Hrw3SzKEr3FR9JwoXRV34
         Msht+WmsZAEIWzt+s0zrHGD1KZDnYF4+0/lRqcsRtskml90WOubXnz0ce82ka34E8YlT
         ommbbJ6xECGmK4GqBc0tWvLj2sQIt1CN5cSJm3Ia7eGyovbj9v3xoxxbawTUt+PU2q8i
         Azd9YgXy6XH5H/K1RvX/PpPSYPOfeg4WqjFGO/y5eQuf2SaXPrwPpRESc+yeI+S/WFh5
         /uaTEBrkoqZlOSsrBByhlbT+SZ76TcZbHPbYByZX34eyDWTXxOkUiwIKFqjeTZwjld5n
         apgQ==
X-Gm-Message-State: APjAAAVvV86ArrMiEPzkUAYDco9I33eI3ub3uTqpDu2uJlB4Z1LWcxXD
        PzQA8+xo9r4uIwi/RrafW6cDsA==
X-Google-Smtp-Source: APXvYqyAL8GNWC/XCDpS5JxQnTXQ8FqElpFCYjM+0pMe4ZXEcT20wryOobfhO6/NZLWXhnD5s3f48g==
X-Received: by 2002:adf:ef03:: with SMTP id e3mr7326835wro.216.1574861721256;
        Wed, 27 Nov 2019 05:35:21 -0800 (PST)
Received: from debian-brgl.home (lfbn-1-7087-108.w90-116.abo.wanadoo.fr. [90.116.255.108])
        by smtp.gmail.com with ESMTPSA id k18sm19663687wrm.82.2019.11.27.05.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 05:35:20 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/8] gpiolib: use 'unsigned int' instead of 'unsigned' in gpio_set_config()
Date:   Wed, 27 Nov 2019 14:35:03 +0100
Message-Id: <20191127133510.10614-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191127133510.10614-1-brgl@bgdev.pl>
References: <20191127133510.10614-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Checkpatch complains about using 'unsigned' instead of 'unsigned int'.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 21b02a0064f8..a31797fe78fa 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3042,7 +3042,7 @@ EXPORT_SYMBOL_GPL(gpiochip_free_own_desc);
  * rely on gpio_request() having been called beforehand.
  */
 
-static int gpio_set_config(struct gpio_chip *gc, unsigned offset,
+static int gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 			   enum pin_config_param mode)
 {
 	unsigned long config;
-- 
2.23.0

