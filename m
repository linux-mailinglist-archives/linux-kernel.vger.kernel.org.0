Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBA9163012
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 20:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgBRTdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 14:33:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35606 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgBRTd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so4241022wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fhwn2ZW4+Oeu69BMvqd1Amzh30rqArEOAoeVg6PmOWg=;
        b=x0+U/skHhXnfbCeAgDwjQ8qJmDqyWtwDQlK7yFyQgERkVEMatsfBRZLy22osPctvse
         3q/bu1g2a1LEB3zjxbu3vETUdfOTugPNK76akGMUrub/BXHMFAG4ytSUwarKnCwwvjpO
         JNM05lNSHeykBpxAZFmqERzbfjrpwHZUTPKfErl5MFcDqYgeXfT6Hy1uikV6IJG94m1v
         T8xnTTvkJoN5gpQom6SHVyZUlLtuo21m58D+APxd1ixlpSXrkhOiD1q5u9XfEJr0ySDX
         aEhqNTVRPMUET3PRSWjME5kMLFoH2qjYOGYOSIk2kfBHDdi+UxjnyTNb6Ch5+SEw8wnD
         XXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fhwn2ZW4+Oeu69BMvqd1Amzh30rqArEOAoeVg6PmOWg=;
        b=DdKT8U95XtdWUR4HDbfvxvUi10WuQ4NuxfBwsc1QkOzuS4eYT8VEP5VJvTFg0x7686
         IVOr09gf4hR22r9Mx3UbFQArpga/oX+GUMCUnIIKSybxafsUUBkqSd36rsfJrcMpzbKq
         Snkm7eGQJcD50mZnWQGydA6SBVhfIFtzSvvY47eXtw8SAOdvpxoY20gbJaewmwJTS2Pk
         HxXiKnsQ1tJdbkNaDA6OhqHXISQHHYh8dZIiZ9BWGqUW1d6M1r8lbY6gfrl6lrXgZK2f
         9v+aoQntZe1MoAEBeTSjloOehCWZ1XUqLU524XbgTIm/YVx0NqQ0dm+JUzjgTZ7hdigR
         0OcA==
X-Gm-Message-State: APjAAAWPydSleqlhymP7ltm1UOOd75GmOqnmgnEmuw+AaTCpdC1yuZ2D
        4SucAQNU9/zzKOPqYcRT2qLX2Q==
X-Google-Smtp-Source: APXvYqwU6LtJ+4yda1ST5mI7xKccXgYcyuYDViGv3r6yI47nRAJx8KQ7bO49LiFdYcP4+WBJfA7+AQ==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr4945747wmb.114.1582054407086;
        Tue, 18 Feb 2020 11:33:27 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:26 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 13/20] usb: gadget: r8a66597-udc: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:32:56 +0000
Message-Id: <1582054383-35760-14-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
References: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_driver name is const char pointer, so it not useful to cast
udc_name (which is already const char).

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/usb/gadget/udc/r8a66597-udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index 582a16165ea9..537094b485bf 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1968,7 +1968,7 @@ static int r8a66597_probe(struct platform_device *pdev)
 static struct platform_driver r8a66597_driver = {
 	.remove =	r8a66597_remove,
 	.driver		= {
-		.name =	(char *) udc_name,
+		.name =	udc_name,
 	},
 };
 
-- 
2.24.1

