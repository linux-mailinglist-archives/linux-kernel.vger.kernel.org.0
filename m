Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31667163021
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 20:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBRTdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 14:33:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55920 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgBRTdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so3959073wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MaLAtkjRxzJam7Y2UUkQL0f+cfe4YM8Rlep2oOYDR4k=;
        b=kAbhpKkW6Qgf8n1gsp1qpisZqrAfOgVqPywaJl9q0N7aQAo5i9LsHbxPp49sb2xW9A
         3UCjfTTxyQH8SLjFsjhp3xFTTml+jboMB1DqnvKg1zVl0HouT6gjFlC67xr5nYu1SaAw
         4d4lnUUHzNlYu4K0FkHR3WbjYIS9FAOCdZgsmIIclVEPxOtHXaJIphzy6XdFu2f1h0cp
         ilFXA8PK2zAUfhEGMkiouWb9K7PaU8ZbBf1h3DeM1hB0FWS4EBEAMvarMJsWWHESP6k+
         yT3FIhr53D1jIio5A0NQ4eg4suK2ojST4Xw0YGA2DUUTij0M9ku6ffuhTAShAqvW3CGU
         SYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MaLAtkjRxzJam7Y2UUkQL0f+cfe4YM8Rlep2oOYDR4k=;
        b=oAZzbUKImgzc2FH4C+nCzh09keH0FJnwpFioHKB5vP4q9NQpNniGe2dIggcK9orrRi
         NyRcnQlueLkeSx5HwzvOnVCF0rUszdIMLQlfNgpSPK4j7DzMBlWM99mqMWpmgWEMkAee
         BgWWnde2WaL14lpxpLkMA/jptiXvqRjrHkwzw1kSaAgL5A/C4n+9T3W9JROKJK0uL003
         0s/vc3OpEMvawjpJaeltctLx/eSlFGgBbXM6oSAhM3tcgeAM7jYECFQvKJBPvWfY3YTU
         DMf1ggxhJfKHlzGJaYfSBWQUCvRZt/Am9lYP9OGdz1Y2757v05u44W9TQfxnedirzyLB
         MUYw==
X-Gm-Message-State: APjAAAWugP7A23sFcF6D5BKmorYerFXuvk85SPUvtUzfOyRYfJlqtfwS
        FZzDAwTR+6l6ywqJRPGoxA3pDg==
X-Google-Smtp-Source: APXvYqxcx1r+IcoGtXHd2hQV1AZzw6FglIgIvVP3Ij/NByDoGTZj5rYGpAki6fUvsL6Az9tGsFk0eA==
X-Received: by 2002:a1c:a5c7:: with SMTP id o190mr4836846wme.183.1582054398819;
        Tue, 18 Feb 2020 11:33:18 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:18 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 04/20] usb: gadget: at91_udc: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:32:47 +0000
Message-Id: <1582054383-35760-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
References: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_driver name is const char pointer, so it not useful to cast
driver_name (which is already const char).

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/usb/gadget/udc/at91_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index 1b2b548c59a0..eede5cedacb4 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -2021,7 +2021,7 @@ static struct platform_driver at91_udc_driver = {
 	.suspend	= at91udc_suspend,
 	.resume		= at91udc_resume,
 	.driver		= {
-		.name	= (char *) driver_name,
+		.name	= driver_name,
 		.of_match_table	= at91_udc_dt_ids,
 	},
 };
-- 
2.24.1

