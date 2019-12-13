Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62DC511E26D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 11:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLMKzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 05:55:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43278 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfLMKzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:55:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so6112408wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 02:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=p415J89+YNScswOm0Ig+Gz4iio3dTiRz0IYzmtQJ8Wg=;
        b=esFnpRQ81UxTGd7lVa9vrscL5Wo31bYIRK/esBzJwjTw0hN6Z2GUhicpEUuGmed16f
         vziddOcnCkRW/Zmii476mpzLbVqUyUh1qc2Gne+M2STHXuec0yJ//xxfyclNHGmhvA5X
         OKnVUG8jTyZsuDcUQU31HboP7r7T5822VdErFuZEYy9zurHBzU3YoW/hOnsBLmHGdmPc
         4jIszGaWBAElk1jA7fLhBesqzZhUGnxTBfl3bcHXZyjTOwWjvjiO+vL1UckskaAIPbhM
         1YJKAnKreCL7FgEhuFXi/RpAhhYtYY8sRiKonILuepHAdYoPhJttbSk30Ujhm4C4nxmU
         l9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p415J89+YNScswOm0Ig+Gz4iio3dTiRz0IYzmtQJ8Wg=;
        b=tR+Y+/Labj5sHNnP74B0aP5/h+/PSrxzEoXVQhOS0yAX7dcWjMBPEpd+vgXaQHudAE
         RQqfEx3WhVAhwdWEK0pyfsa7uRyqrLr7S94fqJLsX4YmEu3Dh80pIFZs3nUD6M+jOdc2
         GzP4DhxPEnmreZQdxgypgofA/QpqhGpKkmyolIE0G8X6U55Wtnniqfeuhqn4KwaeEonB
         oIJfvMzDBQ3UPBaX+XltBJeNuzdAIjecvpblcVZa8+iSZ6zK6z+NppNhygf+/hkjpkog
         Dw0hnJudwbNP8u+XCKJZbsneZBoOwuirVihHkbwkTfX7ARvmUc39J9YqHkIgfza6u9q7
         xR9g==
X-Gm-Message-State: APjAAAW4g87i6F2lcdlD0yyBnDN220n+e622KG6YQpWEBsaNxG5V+vDa
        le2HgEVrC7Z99jrJ9kkdqrbjkA==
X-Google-Smtp-Source: APXvYqzOfpJA5Vuw50woqY71RTwVq2767+KlZHxm+PmsLzgH6mBL4XJMA/L4DXoADGKJ+fDyAQpIKg==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr12675842wru.6.1576234523179;
        Fri, 13 Dec 2019 02:55:23 -0800 (PST)
Received: from localhost.localdomain ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id s82sm10401368wms.28.2019.12.13.02.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 02:55:22 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        khilman@baylibre.com
Subject: [PATCH v4] bluetooth: hci_bcm: enable IRQ capability from node
Date:   Fri, 13 Dec 2019 11:55:21 +0100
Message-Id: <20191213105521.4290-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually IRQ can be found from GPIO but all platforms don't support
gpiod_to_irq, it's the case on amlogic chip.
so to have possibility to use interrupt mode we need to add interrupts
field in node and support it in driver.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/bluetooth/hci_bcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f8f5c593a05c..aa194f8d703e 100644
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
@@ -1421,6 +1422,7 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 #endif
 	bcmdev->serdev_hu.serdev = serdev;
 	serdev_device_set_drvdata(serdev, bcmdev);
+	bcmdev->irq = of_irq_get(bcmdev->dev->of_node, 0);
 
 	/* Initialize routing field to an unused value */
 	bcmdev->pcm_int_params[0] = 0xff;
-- 
2.17.1

