Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC70213574B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 11:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbgAIKnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 05:43:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52256 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbgAIKnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:43:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so2351524wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tXpo5MYGeWvRjvLGBcgNx4X2h+6aZ6zfLICyaTGuIUI=;
        b=My8DmB5olwApnKKCvFVwxMr/v2iQP+0A8hHlAm654JXhpMg5Q9TEXV0SJ7C3K1vTOg
         jSzLPx4QTudKMOBUOYzLJDlEUBvB3yAMOEN8aTA6/RZe4H1/jcjHJ09kzGQwnteziFWa
         G//ngvcBJbdQU/iq2146XfoKDzZW5jlBDHvc7UV9OFKMr5SEJYULBOXe3ovU9E6CcI0F
         pX9lXHfLkoCBGtAytjcWkXB9dXAbPTMLpYiClsFQ38eu0YOfnnhQDjBh5HDS26dMesbw
         qYmni0/Ibam0yQFLnIGRS2i0LxVJX8piLS7ahmQwdgl08cPxozQSVCR1Ma4kW1WLWods
         neag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tXpo5MYGeWvRjvLGBcgNx4X2h+6aZ6zfLICyaTGuIUI=;
        b=RzikjKoeKaG6U6Wsg5CI0qCa9MnXklNzGko6sIJuK4JZgD0T5GJ5ANCuDWUW6avYeg
         h9cAZ1QB1Y8wq8EqonMGUO2siwoUJSbOBj70uQj3chBwAisVA0ZC0EGXVB+EzzbK4y46
         +KRXlsgrqcDFL8S1ARfBD70evNIbgT/U1ZN7Uh8/6cLlWNFnvbKCT+N1ccHgiMnuxfY1
         wPeLAsu3c64FAlaviQRHQAICkW+udQgkT0Hfd6K219aowuwQostTYn5FX2EYGxE2DYE6
         4H2rsUSjas0Ugf7XB2aG6VqxntFzAFDjGSwSJOjyMdjz5CH1/0hP3Szpkoi2Jwiir7pO
         KuIQ==
X-Gm-Message-State: APjAAAXE+ZNNDW9nIG6Vv6T0U/6lidJ+o6RehLVQKjcTSwT24Uffy2qm
        KVVVMDgqEF1UESVwCKhr3QwFjw==
X-Google-Smtp-Source: APXvYqxIIYtqFKRMNSIKDcAb5L/+eaHkyC2++l5LvjLq/4NkV3xN9MOMzfCuZK3amBt2RcpYC+BSFA==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr3944041wmi.45.1578566581595;
        Thu, 09 Jan 2020 02:43:01 -0800 (PST)
Received: from glaroque-ThinkPad-T480.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q68sm2587167wme.14.2020.01.09.02.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:43:01 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc:     johan@kernel.org, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Subject: [PATCH v6 2/2] bluetooth: hci_bcm: enable IRQ capability from devicetree
Date:   Thu,  9 Jan 2020 11:42:57 +0100
Message-Id: <20200109104257.6942-3-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109104257.6942-1-glaroque@baylibre.com>
References: <20200109104257.6942-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for getting IRQ directly from DT instead of relying on
converting a GPIO to IRQ. This is needed for platforms with GPIO
controllers that that do not support gpiod_to_irq().

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/bluetooth/hci_bcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 769bb4404bd1..b236cb11c0dc 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/property.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/platform_device.h>
@@ -1151,6 +1152,8 @@ static int bcm_of_probe(struct bcm_device *bdev)
 	device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_speed);
 	device_property_read_u8_array(bdev->dev, "brcm,bt-pcm-int-params",
 				      bdev->pcm_int_params, 5);
+	bdev->irq = of_irq_get_byname(bdev->dev->of_node, "host-wakeup");
+
 	return 0;
 }
 
-- 
2.17.1

