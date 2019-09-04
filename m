Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAD5A78CC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 04:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfIDCfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 22:35:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46741 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbfIDCfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:35:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id m3so10307789pgv.13;
        Tue, 03 Sep 2019 19:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RzbHrWIg0lBmbShcmgiv3bz+4va6hNwAkwxG7N3nZBA=;
        b=ufvRrBj+X4/HCzkx/G0GmmmdwOwqBYJF3kBUUebp9LPIMk548rPc6wAJ6NqmcFzPZU
         /6IKwQmbgBYpGtoSBgshWR5c499Lpr/BbJ/LhM1u3qKyLms1jtMmOETLC9vaOfoyAfsf
         cRGjvTSDUz0HqtSVXPD5lGmd52VPAbBOF6kXm/w8jKmMB6uba7m9O8KkCcyylAKQ4sRe
         Zn0m1CJnj5eAQkG17ftnKzsEvDX6CP4ulOgvJbnXnsyVgCAHuTxwVC3oz4QdGM3lwR7s
         Nyt6X9/5gkcbv3USjWheep1tq4JCWfzPrnMzRi8Ew6xX0K77YJDWnmrZ3Tm2fTDk429s
         Zmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RzbHrWIg0lBmbShcmgiv3bz+4va6hNwAkwxG7N3nZBA=;
        b=qSIh85dvpVXUq9vVMh+EppTHFox4mnQb9L0w3CQhI43wWhDwsebpCyXw7SYvjqayQ/
         r9pHkD06vwwLcsdGMeD8fA/8ICjzA2zUjxWm1aWVhJgGs5Hy3DfKCE/0zdT8TfMVPB5p
         fu1HChP45m1clRCiHaFNeV7DOwt4crLokDAOHZYu7Alcrn1RM4leqpZyYap8/SkkjoZn
         /J27qI7AKu/8AW4gJORJjVKOHUMwQ41E9jse9sLQb65mlj3CJes9gTdE81+2SIfI5xBD
         sio+5U8Srmc2sr1jbJZMnNCo6eVr94vf7johdtoQp9J2CdJtNNBYulvZ4wO7Oc/6WgvZ
         KTQg==
X-Gm-Message-State: APjAAAW7pV1k+rA4Af+SMXrZfXlcgCrYcYp/AY7K/UflgwpfAlctXI1p
        z9RXWT3crDnZVc1rln5pxQB/eZyIJnY=
X-Google-Smtp-Source: APXvYqyyz1ppKDoCfLzcc42jJI63cCVNbyYUIXxpPJ8LP/vk3zxG1+L1pTb2r3pPJePVtvcp+2hZPA==
X-Received: by 2002:a17:90a:24a1:: with SMTP id i30mr2729879pje.128.1567564536188;
        Tue, 03 Sep 2019 19:35:36 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id i74sm7480250pfe.28.2019.09.03.19.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 19:35:35 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] crypto: caam - dispose of IRQ mapping only after IRQ is freed
Date:   Tue,  3 Sep 2019 19:35:07 -0700
Message-Id: <20190904023515.7107-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190904023515.7107-1-andrew.smirnov@gmail.com>
References: <20190904023515.7107-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With IRQ requesting being managed by devres we need to make sure that
we dispose of IRQ mapping after and not before it is free'd (otherwise
we'll end up with a warning from the kernel). To achieve that simply
convert IRQ mapping to rely on devres as well.

Fixes: f314f12db65c ("crypto: caam - convert caam_jr_init() to use devres")
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/jr.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 2732f3a0725a..d11956bc358f 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -146,7 +146,6 @@ static int caam_jr_remove(struct platform_device *pdev)
 	ret = caam_jr_shutdown(jrdev);
 	if (ret)
 		dev_err(jrdev, "Failed to shut down job ring\n");
-	irq_dispose_mapping(jrpriv->irq);
 
 	return ret;
 }
@@ -487,6 +486,10 @@ static int caam_jr_init(struct device *dev)
 	return error;
 }
 
+static void caam_jr_irq_dispose_mapping(void *data)
+{
+	irq_dispose_mapping((int)data);
+}
 
 /*
  * Probe routine for each detected JobR subsystem.
@@ -542,12 +545,15 @@ static int caam_jr_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	error = devm_add_action_or_reset(jrdev, caam_jr_irq_dispose_mapping,
+					 (void *)jrpriv->irq);
+	if (error)
+		return error;
+
 	/* Now do the platform independent part */
 	error = caam_jr_init(jrdev); /* now turn on hardware */
-	if (error) {
-		irq_dispose_mapping(jrpriv->irq);
+	if (error)
 		return error;
-	}
 
 	jrpriv->dev = jrdev;
 	spin_lock(&driver_data.jr_alloc_lock);
-- 
2.21.0

