Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38FF77B197
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388148AbfG3SSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:18:39 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:35480 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388027AbfG3SQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:30 -0400
Received: by mail-pl1-f171.google.com with SMTP id w24so29209390plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6xmuNPlPNtMvTUhcXxPTDVGKUv1rYmZzQoMEWKAo0Q=;
        b=LO61eippIjNcLDHaCDIcSMlLIIB4w31P9i35JN0rm9n7GH2L8yp1vw7nQxZC+KpQRF
         qE/YEWwnpXZ1eLPRIg4d17sri3fZnDGHbGL16LbTvL4XY6zP/Vr0JHKKLSW6y4wSxuXI
         9j+YWVqGxfKN9akm2kzIx7H2RjFkc6ivoNCpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6xmuNPlPNtMvTUhcXxPTDVGKUv1rYmZzQoMEWKAo0Q=;
        b=bMxRcteP3BIS88qYh4JwnJL7syYUXh9PXcczGCebWn6NgyAHfLRJgBgYUyKVSkHxpw
         S2Kpn3trDYtVNkfWqxHf5VwvIPZmp0GQfDO6/GB4YpPjy2/lV31ya94t+oxhMAaNQ+gK
         /jDkNNcqtEa9vUjJQui4vjclIqEARxdEtFVL5VE/ArCu6IMkxKwtzQaCTrWNIr8tFqJX
         mhGyEAyHiq+krojET2vwmYnChZMCdfr/kaFGtWpmvRIIyO4NVzrtfEjC/iqjNDKcsb+M
         tBasVC8XzxWaICtsk0XO8iCuLVLvl3qqi3i1JMRUfjyv2JWa+RYIrF+1j6cVVqR2367q
         TnHA==
X-Gm-Message-State: APjAAAWlgwYO8/TqlHdveuVcn1/Q0X0663TXDhesy1EyRoR1vvnUnJU5
        Dk7CXUpI1ATahBBqfIsceJS24jOfzo+W4w==
X-Google-Smtp-Source: APXvYqykUx2koPcz/W4VSksYXvx3GCdbNn2GaMevuaZ902tczlcCCuaLKBZjGGCqNUUKDkEIFUkd7A==
X-Received: by 2002:a17:902:1129:: with SMTP id d38mr117882073pla.220.1564510589314;
        Tue, 30 Jul 2019 11:16:29 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:28 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 37/57] regulator: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:37 -0700
Message-Id: <20190730181557.90391-38-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/regulator/da9062-regulator.c | 4 +---
 drivers/regulator/da9063-regulator.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 2ffc64622451..56f3f72d7707 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -1032,10 +1032,8 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 
 	/* LDOs overcurrent event support */
 	irq = platform_get_irq_byname(pdev, "LDO_LIM");
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ.\n");
+	if (irq < 0)
 		return irq;
-	}
 	regulators->irq_ldo_lim = irq;
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 02f816318fba..28b1b20f45bd 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -863,10 +863,8 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 
 	/* LDOs overcurrent event support */
 	irq = platform_get_irq_byname(pdev, "LDO_LIM");
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ.\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
 				NULL, da9063_ldo_lim_event,
-- 
Sent by a computer through tubes

