Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21CB6163011
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 20:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgBRTd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 14:33:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39159 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgBRTd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:33:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so25380232wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ByhSpSk0RbpBmQb/3fbgoL2btiyO1MoLUthBlNAP+jw=;
        b=Ginbqi3BPfw0S21lnWHbzwTt97BQiojH1B+yjE0E6p3LIu9F++u/cPgEBU2neON+7T
         ilap8jk8Bq2qhW4pjVsdxK2TuSzQajG2qsOd2l7g0bY4PLZ6a9K0EY7bP9PwCrqvqtLT
         XuRPTuZQy3vnvHs3ay6cCXlUaK+ngA26TxdcFeXsOi6jghvyynux2xFVs27m9ifmlDv7
         FKw27wyhjBLhKzrL8rvQvGgMBaYGNP4KmX2jHjbBdCIv+XQLDinPPIJgcf0KzwHraTl/
         /poQAnaUr6Trchy2eisDWZXXlMcP7v4+jPEFfr0XxZov/nS9UomHUTr9L18L3A0Ybite
         St1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ByhSpSk0RbpBmQb/3fbgoL2btiyO1MoLUthBlNAP+jw=;
        b=M1y5L2+3NAqY4d299PB+UGKAmd7oaZP73Q2xF/1qOKtREYkcc4oGpbEtwx1c8Cej+Y
         wwMnrS/Cilsd8c3zUWEEhLIaGx/Og/oHTpu+z7SdzhqDzuZxVnBicRj9n8f0OPNNPOom
         SRpg4X9g0bhRYWiSNzGgn7/Ri1xsVoEHJsuFRqF93eWXX5OfVpEHgRkKcGwd4bFk4vo0
         JqLj50g6vBeV5laILpvisUXWcogPdP6DvOLbedQMrwenP7LCkz8RlD6i7lyXd5Gkx/I9
         4yMzMDkaOWKUJ3kDDqtRluHon2okk5L4zJ6UXaVLi7oqSIEpFZwhWRjRGL6i62lsADpc
         APHg==
X-Gm-Message-State: APjAAAV6omttZdIk3gVD7TVHmyetcADVGsSe9Hl6BJ6EWHDV/ds/l2qo
        o6qdTQ1jGr7u9Ajajfp2tTUCbQ==
X-Google-Smtp-Source: APXvYqwM1AhZpMBzLvaJB+hOg8Ca8jvotSklINB1IsiGR01YYW45xXdNQg0YraL/2BoAWvsd55Wang==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr32456351wrt.229.1582054405339;
        Tue, 18 Feb 2020 11:33:25 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id k16sm7649266wru.0.2020.02.18.11.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 11:33:24 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 11/20] usb: gadget: net2280: remove useless cast for driver.name
Date:   Tue, 18 Feb 2020 19:32:54 +0000
Message-Id: <1582054383-35760-12-git-send-email-clabbe@baylibre.com>
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
 drivers/usb/gadget/udc/net2280.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index 1fd1b9186e46..4a815aab8f5b 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -3857,7 +3857,7 @@ MODULE_DEVICE_TABLE(pci, pci_ids);
 
 /* pci driver glue; this is a "new style" PCI driver module */
 static struct pci_driver net2280_pci_driver = {
-	.name =		(char *) driver_name,
+	.name =		driver_name,
 	.id_table =	pci_ids,
 
 	.probe =	net2280_probe,
-- 
2.24.1

