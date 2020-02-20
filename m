Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30B20165B07
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 11:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgBTKCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 05:02:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37538 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgBTKBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:01:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id a6so1328020wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 02:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PxNamP/tY+VJSZ59R58OjGFNv8KfDwh59F4Xljb8y3g=;
        b=FJvt1dBidHKQ9i6NzW7D3scasMhmuxHzOekGkhyG1QrETE1a0KjWbaQb+C5iZSSyBA
         taIaO4VYqzahsrY7V4zWsc7+NzLmZiJHAIeBUNljknwYq3yk4fsKoU70gDwmrt8r+b4O
         kPDf28Xy/7PWbZsfzgXu+YqeDMALSj51asraPrJh/PKnyAR3B+rrH/hd+gYEOFPN9YH3
         5jp+JWgbihgNGpsfEEg+OC0ZaUHPCNhoKIpleB1lCx+/ygsk0PwzDDZcVqf84kRTzSOl
         vEhY9HAPZk0QvprzPPbQKrAhMv4CW9A6iB3zj9iDUL7vis/TmnIvVxFyWW/OkRo5qBUL
         dcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PxNamP/tY+VJSZ59R58OjGFNv8KfDwh59F4Xljb8y3g=;
        b=PnXvJjOia9CPe0Dz0TDPhFqGtG1ZxurXsNL6VKr3Gd4/4b1T6fiBV1W5d9MsSpdu7p
         ZCQWsYEx2yd7uaV4a+4rggnkNr/lj1/D1fEvqMUvqlpTqh/1La9QJFvmP+vnoF0hcQVj
         LQkeHsxt1G553F2hYExYxqG4ysnzy1xGDC7eiFR7kNmqg5sTq2/VVsQBtByAMJghaSup
         gNDxRTyQcoGJsHhsgCoL8EVO/qXHqA8/ik6LB37mGSlnKbqdduteKlgYrajsEtGNSemE
         pABWscLEOunIOAXg8Pwe5zENH2B2h9TMTEccuGrA2tDrhvrAhxfLgtZm5olRAGlU8BrK
         /rDw==
X-Gm-Message-State: APjAAAXThZJnoate7GFKz70BeY8ijxb6CcyU5qDh735IIsZSEmpV87Io
        RuXo4GQRTIu1Am2BM0+zV7kTrw==
X-Google-Smtp-Source: APXvYqywHwbPABTcol9PZLK4z7duQcvtOXJx1amFWGMSjrEKzVlTmOaPX0CLi7edYiQlkGUw8VP0cA==
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr3431903wma.84.1582192907990;
        Thu, 20 Feb 2020 02:01:47 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-188-94.w2-15.abo.wanadoo.fr. [2.15.37.94])
        by smtp.gmail.com with ESMTPSA id z1sm3663496wmf.42.2020.02.20.02.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 02:01:47 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 2/4] gpiolib: use kref in gpio_desc
Date:   Thu, 20 Feb 2020 11:01:39 +0100
Message-Id: <20200220100141.5905-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220100141.5905-1-brgl@bgdev.pl>
References: <20200220100141.5905-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

GPIO descriptors are freed by consumers using gpiod_put(). The name of
this function suggests some reference counting is going on but it's not
true.

Use kref to actually introduce reference counting for gpio_desc objects.
Add a corresponding gpiod_get() helper for increasing the reference count.

This doesn't change anything for already existing (correct) drivers but
allows us to keep track of GPIO descs used by multiple users.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c        | 36 ++++++++++++++++++++++++++++++++---
 drivers/gpio/gpiolib.h        |  1 +
 include/linux/gpio/consumer.h |  1 +
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 753283486037..42f820356279 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2798,6 +2798,8 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 		goto done;
 	}
 
+	kref_init(&desc->ref);
+
 	if (chip->request) {
 		/* chip->request may sleep */
 		spin_unlock_irqrestore(&gpio_lock, flags);
@@ -2933,6 +2935,13 @@ void gpiod_free(struct gpio_desc *desc)
 	}
 }
 
+static void gpiod_free_kref(struct kref *ref)
+{
+	struct gpio_desc *desc = container_of(ref, struct gpio_desc, ref);
+
+	gpiod_free(desc);
+}
+
 /**
  * gpiochip_is_requested - return string iff signal was requested
  * @chip: controller managing the signal
@@ -5047,18 +5056,39 @@ struct gpio_descs *__must_check gpiod_get_array_optional(struct device *dev,
 EXPORT_SYMBOL_GPL(gpiod_get_array_optional);
 
 /**
- * gpiod_put - dispose of a GPIO descriptor
- * @desc:	GPIO descriptor to dispose of
+ * gpiod_put - decrease the reference count of a GPIO descriptor
+ * @desc:	GPIO descriptor to unref
  *
  * No descriptor can be used after gpiod_put() has been called on it.
  */
 void gpiod_put(struct gpio_desc *desc)
 {
 	if (desc)
-		gpiod_free(desc);
+		kref_put(&desc->ref, gpiod_free_kref);
 }
 EXPORT_SYMBOL_GPL(gpiod_put);
 
+/**
+ * gpiod_ref - increase the reference count of a GPIO descriptor
+ * @desc:	GPIO descriptor to reference
+ *
+ * Returns the same gpio_desc after increasing the reference count.
+ */
+struct gpio_desc *gpiod_ref(struct gpio_desc *desc)
+{
+	if (!desc)
+		return NULL;
+
+	if (!test_bit(FLAG_REQUESTED, &desc->flags)) {
+		pr_warn("gpiolib: unable to increase the reference count of unrequested GPIO descriptor\n");
+		return desc;
+	}
+
+	kref_get(&desc->ref);
+	return desc;
+}
+EXPORT_SYMBOL_GPL(gpiod_ref);
+
 /**
  * gpiod_put_array - dispose of multiple GPIO descriptors
  * @descs:	struct gpio_descs containing an array of descriptors
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 3e0aab2945d8..51a92c43dd55 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -119,6 +119,7 @@ struct gpio_desc {
 	const char		*label;
 	/* Name of the GPIO */
 	const char		*name;
+	struct kref		ref;
 };
 
 int gpiod_request(struct gpio_desc *desc, const char *label);
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index bf2d017dd7b7..c7b5fb3d9d64 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -81,6 +81,7 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 struct gpio_descs *__must_check gpiod_get_array_optional(struct device *dev,
 							const char *con_id,
 							enum gpiod_flags flags);
+struct gpio_desc *gpiod_ref(struct gpio_desc *desc);
 void gpiod_put(struct gpio_desc *desc);
 void gpiod_put_array(struct gpio_descs *descs);
 
-- 
2.25.0

