Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4370CC350C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 15:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbfJAM7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 08:59:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53505 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388155AbfJAM7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:59:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so3275146wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 05:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YdPiqrMx4DGxjMQly7Bs8yH/i3WsBA2bl/JSPtLQAlU=;
        b=lcmE3vN8QgAF/cvQx92RbIvCHD9TYk2CybtaaltOK66//ZtmicBFCv2YZD0wNJvk9Z
         x3LWJ+IpV72x0eGb6WR/OKHiXkz/P1HC/meJgjLIvflb9QGtyNheUwiAWw6v0AZhKnxB
         ma/y6xvB5CrMHLfFUQrJ1vXBqRLMnRT6sligmSUsafHf0QBngMOebQIuuzuFoLhA8n5c
         Mqqoz9Gcq2KG8i2AVZ5fRdKa0/rHB5XgABwyVLJvA2ebNiGjsWWjn39+XDAKhOnB2z+y
         lelRUsfcCN7WiEIuGroQUsEAA6kHafmjUUuh9/DaSZw5CZ7MvPyqGmqgDhR3bnc7tldn
         areQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YdPiqrMx4DGxjMQly7Bs8yH/i3WsBA2bl/JSPtLQAlU=;
        b=XPIcXMpMachZjvh1jvhjiAd5p7xwCZgI5QdkCvwYxu/6NZV9jG98DLVJ0S4qBHH7iX
         NbjcmOagzZPkushCAygNNHVeUkYu4ILhrvmSKNOBfg/etcXtC1zr5FxuCq2OkupP2DpU
         BpiUQ3XIt2N/OObcJDigGM8ii9n//HvK17AniO9QXp9fBFNxpU/HDIPUhQDHvy0VHWr4
         qK6DmwRTse332E/z9jeJ9gJsLE726PkPIiRO4wlZboml45cGV4+rHtCFhOqsCw24LwUp
         ohrDHwhHJdvRbO0++V5Updp3KmRsw53Uz4WyphEcaoggUrvB2qrkbFeR6XLC4XRUJdol
         GXxw==
X-Gm-Message-State: APjAAAWmM2GbXr5vbnl9RAINs+9eFRmeYON+gASES5VR/zMhWA+caU3D
        U3jJ8fMZjbD+R8YXzkuE7S8Wrg==
X-Google-Smtp-Source: APXvYqyfFhsII8M6bT8z0Hza0LDbhxIPYRpZT0+h7X+cw4RTZ4ywSFMziDChoEo0eoy8GmQhERWw+g==
X-Received: by 2002:a1c:9988:: with SMTP id b130mr3769813wme.164.1569934769902;
        Tue, 01 Oct 2019 05:59:29 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id 3sm3561400wmo.22.2019.10.01.05.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 05:59:29 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 4/7] sh: ecovec24: don't set unused fields in platform data
Date:   Tue,  1 Oct 2019 14:58:34 +0200
Message-Id: <20191001125837.4472-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001125837.4472-1-brgl@bgdev.pl>
References: <20191001125837.4472-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Platform data fields other than fbdev are no longer used by the
backlight driver. Remove them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/sh/boards/mach-ecovec24/setup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index aaa8ea62636f..dd427bac5cde 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -386,9 +386,6 @@ static struct property_entry gpio_backlight_props[] = {
 
 static struct gpio_backlight_platform_data gpio_backlight_data = {
 	.fbdev = &lcdc_device.dev,
-	.gpio = GPIO_PTR1,
-	.def_value = 1,
-	.name = "backlight",
 };
 
 static const struct platform_device_info gpio_backlight_device_info = {
-- 
2.23.0

