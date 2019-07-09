Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD44D63B97
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 21:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfGITAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 15:00:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38718 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfGITAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:00:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id z75so9915992pgz.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kVvpaDbzpEWbBjYARfR8dh/gP0bxxZgHm+m/Jkyi7lE=;
        b=ml+EGHk2gBbO+Ix+y3IXBdYnqYmz2DJ80cGljmi3CgE65/Et2Vg5hVrN5terF5lHFL
         S8tCFSnVYVpvKoafo00DLzPqA9hwRTKA8NY6EdeYlR4aSVKABT4hmSAr0Q9X7SnlphZC
         jHDTSVqfquQ6omSj4rf4xOaEmRWxY5QFJmPZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kVvpaDbzpEWbBjYARfR8dh/gP0bxxZgHm+m/Jkyi7lE=;
        b=Q0EsF0ggm7naY/kERNE+15XKmDWTPLzJCcMPAquvkHejnAN9qiJVtHQ9o7G7VSIkqn
         0/vx1p2QjQ2o6cpMEY21IHZ17WovTmZ81b7JUEPpiOXknzYttInoDpqTfDv9kkC+OdVu
         VrcSBaOVp4zc1pHSczvxDggrjFIJYhJUFfPW2YNPOutAY8ji6mjqUK9G5me/ZZ7Cp00v
         zViillsMViOBgqvDbGzuyD6V8ZvWj1dpnFRHtT0es1IULSGSZonKzMDVVfGwy1JDdwH/
         j66KpTTIM7YIT2Hg92/E2zkWRn8UrqIAwamqPQ+KRMO8fOGjSPaBDa9yRzEN6+GotDyj
         A3Wg==
X-Gm-Message-State: APjAAAXAieirxbAxs11LnNOYvCSzRdB8s52k4SLsAK/DjM1UxXMyq1pg
        l+Z6mHBa+7drayEiXrJoVCW8eg==
X-Google-Smtp-Source: APXvYqwBv0ikAuzn0RvswN8IgnqKDvN7XJZoGxWHBvHVxIkxhLmxMvq0Xmq/5AXVyvtVcIKhjRshPQ==
X-Received: by 2002:a17:90a:c58e:: with SMTP id l14mr1789873pjt.104.1562698817408;
        Tue, 09 Jul 2019 12:00:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id o14sm2998437pjp.19.2019.07.09.12.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 12:00:16 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 3/4] backlight: pwm_bl: Set scale type for CIE 1931 curves
Date:   Tue,  9 Jul 2019 12:00:06 -0700
Message-Id: <20190709190007.91260-4-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190709190007.91260-1-mka@chromium.org>
References: <20190709190007.91260-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For backlight curves calculated with the CIE 1931 algorithm set
the brightness scale type to non-linear. This makes the scale type
available to userspace via the 'scale' sysfs attribute.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
Changes in v3:
- mark scale as non-linear instead of using the CIE1931 type which
  has been removed
- updated commit message

Changes in v2:
- added Enric's 'Tested-by' tag
- added Daniel's 'Acked-by' tag
---
 drivers/video/backlight/pwm_bl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index fb45f866b923..7c6dfc4a601d 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -553,6 +553,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
+	memset(&props, 0, sizeof(struct backlight_properties));
+
 	if (data->levels) {
 		/*
 		 * For the DT case, only when brightness levels is defined
@@ -591,6 +593,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 			pb->levels = data->levels;
 		}
+
+		props.scale = BACKLIGHT_SCALE_NON_LINEAR;
 	} else {
 		/*
 		 * That only happens for the non-DT case, where platform data
@@ -601,7 +605,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
 
-	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = data->max_brightness;
 	bl = backlight_device_register(dev_name(&pdev->dev), &pdev->dev, pb,
-- 
2.22.0.410.gd8fdbe21b5-goog

