Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E42E879A51
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 22:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388240AbfG2Uup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 16:50:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39518 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387869AbfG2Uup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:50:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so28840670pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 13:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X7NRnVGXrnkZVd1ruHSDb2QmanWeOsJggEzv5XoJGLk=;
        b=g8Xe3U6r1WMKS9LpTAo8v7PyLN4NImhzdcIDuTFJxjhqOMMqVGDOJjqGbC75u9jGrJ
         9rsfp0fNe+B9+Hbw+xEHeY2lF+yRVDjVlZsBN1gUShyUBLJukIfvAsmnbEfn0tVfS53J
         OAT0K+ESCnlT0PVCnpsbnTZ7Gr+WLrfaxnnnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X7NRnVGXrnkZVd1ruHSDb2QmanWeOsJggEzv5XoJGLk=;
        b=qtikcx+44AGPJG6xD9HNMe7JXFrOyD49xzLm1uf9OC/9m1jkT6OweM80O3WKkFGeJs
         pm3+U0RIUS8TJFanJ1w1thF93g1LV5oaHlNiZh4TzSioM6+XDc8sPPDo1xO3bbj+nvfQ
         wr0cArcV82bWRhDLvaLTjNe1afnqjGEZCvd+Oz71SJJBtTNs4Hxk+/hsyxNT2bMFMDWC
         zjEavpEIn6FcmPzEuu2w2oz1HTnEch0jclmjF/Dq4KgmI2sdYSBTp8cnMHrrB9/zgokq
         kKryq6fHWk4tLrrHp3U+fOYFLPdfx0gHjSjZ8vUA/P0FKbULi5czny1B5CSiCtZPgk9t
         9VBA==
X-Gm-Message-State: APjAAAUSLj26iSM909LxxGRmL/AjaQuCYtCtQtd5Tgoq1v36DyFUm+wl
        fu4VWVggqLL62QXVl5cNt4NJvQ==
X-Google-Smtp-Source: APXvYqxP+VotuzvhmIqzWu9T/9V4wCTVnjtv++12+Cq7MoRt8by6kh1T/3tOa+KoGk5BEbIp77zndA==
X-Received: by 2002:aa7:9146:: with SMTP id 6mr37179555pfi.67.1564433444420;
        Mon, 29 Jul 2019 13:50:44 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id l44sm55364485pje.29.2019.07.29.13.50.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 13:50:43 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, andriy.shevchenko@linux.intel.com,
        Salvatore Bellizzi <salvatore.bellizzi@linux.seppia.net>,
        andy.shevchenko@gmail.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        egranata@chromium.org, egranata@google.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-acpi@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Brian Norris <briannorris@chromium.org>, stable@vger.kernel.org
Subject: [PATCH] driver core: platform: return -ENXIO for missing GpioInt
Date:   Mon, 29 Jul 2019 13:49:54 -0700
Message-Id: <20190729204954.25510-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit daaef255dc96 ("driver: platform: Support parsing GpioInt 0 in
platform_get_irq()") broke the Embedded Controller driver on most LPC
Chromebooks (i.e., most x86 Chromebooks), because cros_ec_lpc expects
platform_get_irq() to return -ENXIO for non-existent IRQs.
Unfortunately, acpi_dev_gpio_irq_get() doesn't follow this convention
and returns -ENOENT instead. So we get this error from cros_ec_lpc:

   couldn't retrieve IRQ number (-2)

I see a variety of drivers that treat -ENXIO specially, so rather than
fix all of them, let's fix up the API to restore its previous behavior.

I reported this on v2 of this patch:

https://lore.kernel.org/lkml/20190220180538.GA42642@google.com/

but apparently the patch had already been merged before v3 got sent out:

https://lore.kernel.org/lkml/20190221193429.161300-1-egranata@chromium.org/

and the result is that the bug landed and remains unfixed.

I differ from the v3 patch by:
 * allowing for ret==0, even though acpi_dev_gpio_irq_get() specifically
   documents (and enforces) that 0 is not a valid return value (noted on
   the v3 review)
 * adding a small comment

Reported-by: Brian Norris <briannorris@chromium.org>
Reported-by: Salvatore Bellizzi <salvatore.bellizzi@linux.seppia.net>
Cc: Enrico Granata <egranata@chromium.org>
Cc: <stable@vger.kernel.org>
Fixes: daaef255dc96 ("driver: platform: Support parsing GpioInt 0 in platform_get_irq()")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Side note: it might have helped alleviate some of this pain if there
were email notifications to the mailing list when a patch gets applied.
I didn't realize (and I'm not sure if Enrico did) that v2 was already
merged by the time I noted its mistakes. If I had known, I would have
suggested a follow-up patch, not a v3.

I know some maintainers' "tip bots" do this, but not all apparently.

 drivers/base/platform.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 506a0175a5a7..ec974ba9c0c4 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -157,8 +157,13 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 	 * the device will only expose one IRQ, and this fallback
 	 * allows a common code path across either kind of resource.
 	 */
-	if (num == 0 && has_acpi_companion(&dev->dev))
-		return acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
+	if (num == 0 && has_acpi_companion(&dev->dev)) {
+		int ret = acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
+
+		/* Our callers expect -ENXIO for missing IRQs. */
+		if (ret >= 0 || ret == -EPROBE_DEFER)
+			return ret;
+	}
 
 	return -ENXIO;
 #endif
-- 
2.22.0.709.g102302147b-goog

