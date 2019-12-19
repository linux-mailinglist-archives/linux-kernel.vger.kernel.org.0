Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8B581267D3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 18:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfLSRPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 12:15:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52888 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfLSRPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:15:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so6238169wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=95Vj6BCj4He2jTRmy6pbRhSQcUrTJuyZcD7xpHhCyRw=;
        b=bQmZEgC+HJNTCZAgnsFcEGPlB/Le6fAJuzEwDRF9QjXihH2f13xdRuCkGTdJGYRPE6
         ZpAmEJ/VqDXobWYGUrfiJuR7DWTrX8RQ76QG+5uemZEHGLeT9VHlEiapqYJFFDxgp49n
         RlgcE4N9ICvr8mt36oHhcQ6RcP7sVL+y8XGOB5KvwwRpaPRC6ovaNmx3ExbSDL/z43Gs
         zp9XFVDRkimWHsurLky6fYG/lQTala6wTca83xAbbAe2BAjxX0s3cUDTWGqeSiEEB0Wv
         fCJk39i2UMATx8p07LuL4NHP1BWwsamutqFcs59gop0KYcBx2jqWVMjOPQXtuWF46usp
         0E6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=95Vj6BCj4He2jTRmy6pbRhSQcUrTJuyZcD7xpHhCyRw=;
        b=AuxnMdvXQXK3yWOLneFfPw0T+8MqMOxHH+0YIWHSIjab38Z9oMzJHQyKJ6XufMIa/g
         Kwxhc7LL2IGT8Xgd6/mvzAV8xx8lsFdYFE7WWEQ27lCh+X8FkJSbIreGb1u4DBFNZvlQ
         7JWHudw5iKL3GDzuUxowQ9QbSQ72gWfExFgOcKXIntkA7fvIw6HtWwmb7SOW678Y5jDq
         YRwcVCgDk1WKHCKlCvJdA8O7Slvrdb9+BC7serMkjjKwLxOU8GguQlJoaN5xKmpMNbRb
         pph3m9Irfat2pbet7TDfKZX1XuPtZBXeyL7khXnJsn12cMQRDZYdrs5RxfREgJTkFAZ6
         iqNQ==
X-Gm-Message-State: APjAAAVpIu0J47pUPnWK8I8hHHm3KSIfRg+cj8JZLjDVEmUm0/cXlmGE
        JaQ+qZDanz01DkzDc3u0LWDMwA==
X-Google-Smtp-Source: APXvYqxm0zvCVaIjH2Ioute5ihjTo1ftEw4hS33yLMQ+MkcoURrq1G3nOVBcP+SznGiIzIGVk5lvyg==
X-Received: by 2002:a05:600c:290f:: with SMTP id i15mr11517982wmd.115.1576775742039;
        Thu, 19 Dec 2019 09:15:42 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id q6sm7401428wrx.72.2019.12.19.09.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:15:41 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 06/13] gpiolib: use gpiochip_get_desc() in gpio_ioctl()
Date:   Thu, 19 Dec 2019 18:15:21 +0100
Message-Id: <20191219171528.6348-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191219171528.6348-1-brgl@bgdev.pl>
References: <20191219171528.6348-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Unduplicate the offset check by simply calling gpiochip_get_desc() and
checking its return value.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/gpio/gpiolib.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 17796437d7be..b7043946c029 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1175,10 +1175,11 @@ static long gpio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 		if (copy_from_user(&lineinfo, ip, sizeof(lineinfo)))
 			return -EFAULT;
-		if (lineinfo.line_offset >= gdev->ngpio)
-			return -EINVAL;
 
-		desc = &gdev->descs[lineinfo.line_offset];
+		desc = gpiochip_get_desc(chip, lineinfo.line_offset);
+		if (IS_ERR(desc))
+			return PTR_ERR(desc);
+
 		if (desc->name) {
 			strncpy(lineinfo.name, desc->name,
 				sizeof(lineinfo.name));
-- 
2.23.0

