Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09660BC3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 10:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504067AbfIXIIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 04:08:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43472 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436587AbfIXIIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 04:08:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so807620wrx.10;
        Tue, 24 Sep 2019 01:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hi1ifQQR9gpdPmRZ1GOZNnhiHESsDUToV+uCj5M5hAM=;
        b=NxoJWtHNY256XL25Cim07uB4YuUcEkGp4Xpw7ePOsYhsTGdon2Dr2B5zkiwa92pnlq
         Tu4yyXG51bdy0iytfp8LPPWkwsz5JJKsj/jEXFlNHO41LxVQoWvf3ytsFG49CkYIjhv3
         iEuX1kVXJB7JTZ95HaD+EWnsadj1J3qy0MGnMlfZUSiffmQe5BHG5OFQ9urMZeCC9Ypd
         pT3PVy/IyhIJ0vqRySbXDYGugnbQE6TEkpccoBGA1tZJfImNe6a+rnKI+qN7+tUT6aqK
         zm/ZvTwsU8w0qppOnQV9daojHP5xcoj0jl3Ih2+nOJxucLUcKRcR+7U/fIUB1zbaswm1
         glgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hi1ifQQR9gpdPmRZ1GOZNnhiHESsDUToV+uCj5M5hAM=;
        b=D+bgqPnep7h+B9KBkg/PyNAeWaU6naTZV4hgU2FQqEsZOTlv5Cs9EUbHcgkRHTIexh
         GV+eANFKoOfjCuU/Wo0b4qvmfIbGffr1gMe1ZCG0HZE8z4SMD2IbaxPcnOJ+CmPHMkSX
         JumMo4Y+DwrogFQPOWffVQHjpDFV10M/OApmZLFnp0ZI3jir0xYrEKkoNANgCUe4/5xu
         TV94M5FWGICJAKmdbcf+0d/lQN0qb2ewgOfEL49NnRastLF2h/8g8W4YSqbQ2vzfI/5f
         fwr0mepUCmouhhnV04Zn/4fTwE3PrcViMI4gTvfwBj+WYR65FTko50cSTdarjgQpCNoP
         Burw==
X-Gm-Message-State: APjAAAUBsg5Ych5QjhBrfZPKDSyEQFe87inkNsaNeSFNclPyxdkPxA7A
        gHwHr+wWpvwIohT4456JqKo=
X-Google-Smtp-Source: APXvYqyBp86G51lnDZqf2X6fA9zUA+/GeXP/EiBQc20uwIte8LmWVoe6X9w8UA4yJLMs9lTWyum5qw==
X-Received: by 2002:adf:efcb:: with SMTP id i11mr1255379wrp.69.1569312516938;
        Tue, 24 Sep 2019 01:08:36 -0700 (PDT)
Received: from Red.local ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id u22sm1825256wru.72.2019.09.24.01.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 01:08:36 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v3 1/2] crypto: sun4i-ss: simplify enable/disable of the device
Date:   Tue, 24 Sep 2019 10:08:31 +0200
Message-Id: <20190924080832.18694-2-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190924080832.18694-1-clabbe.montjoie@gmail.com>
References: <20190924080832.18694-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch regroups resource enabling/disabling in dedicated function.
This simplify error handling and will permit to support power
management.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/crypto/sunxi-ss/sun4i-ss-core.c | 77 +++++++++++++++----------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-core.c b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
index 9aa6fe081a27..6c2db5d83b06 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-core.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
@@ -223,6 +223,45 @@ static struct sun4i_ss_alg_template ss_algs[] = {
 #endif
 };
 
+static void sun4i_ss_disable(struct sun4i_ss_ctx *ss)
+{
+	if (ss->reset)
+		reset_control_assert(ss->reset);
+
+	clk_disable_unprepare(ss->ssclk);
+	clk_disable_unprepare(ss->busclk);
+}
+
+static int sun4i_ss_enable(struct sun4i_ss_ctx *ss)
+{
+	int err;
+
+	err = clk_prepare_enable(ss->busclk);
+	if (err) {
+		dev_err(ss->dev, "Cannot prepare_enable busclk\n");
+		goto err_enable;
+	}
+
+	err = clk_prepare_enable(ss->ssclk);
+	if (err) {
+		dev_err(ss->dev, "Cannot prepare_enable ssclk\n");
+		goto err_enable;
+	}
+
+	if (ss->reset) {
+		err = reset_control_deassert(ss->reset);
+		if (err) {
+			dev_err(ss->dev, "Cannot deassert reset control\n");
+			goto err_enable;
+		}
+	}
+
+	return err;
+err_enable:
+	sun4i_ss_disable(ss);
+	return err;
+}
+
 static int sun4i_ss_probe(struct platform_device *pdev)
 {
 	u32 v;
@@ -269,17 +308,9 @@ static int sun4i_ss_probe(struct platform_device *pdev)
 		ss->reset = NULL;
 	}
 
-	/* Enable both clocks */
-	err = clk_prepare_enable(ss->busclk);
-	if (err) {
-		dev_err(&pdev->dev, "Cannot prepare_enable busclk\n");
-		return err;
-	}
-	err = clk_prepare_enable(ss->ssclk);
-	if (err) {
-		dev_err(&pdev->dev, "Cannot prepare_enable ssclk\n");
-		goto error_ssclk;
-	}
+	err = sun4i_ss_enable(ss);
+	if (err)
+		goto error_enable;
 
 	/*
 	 * Check that clock have the correct rates given in the datasheet
@@ -288,16 +319,7 @@ static int sun4i_ss_probe(struct platform_device *pdev)
 	err = clk_set_rate(ss->ssclk, cr_mod);
 	if (err) {
 		dev_err(&pdev->dev, "Cannot set clock rate to ssclk\n");
-		goto error_clk;
-	}
-
-	/* Deassert reset if we have a reset control */
-	if (ss->reset) {
-		err = reset_control_deassert(ss->reset);
-		if (err) {
-			dev_err(&pdev->dev, "Cannot deassert reset control\n");
-			goto error_clk;
-		}
+		goto error_enable;
 	}
 
 	/*
@@ -387,12 +409,8 @@ static int sun4i_ss_probe(struct platform_device *pdev)
 			break;
 		}
 	}
-	if (ss->reset)
-		reset_control_assert(ss->reset);
-error_clk:
-	clk_disable_unprepare(ss->ssclk);
-error_ssclk:
-	clk_disable_unprepare(ss->busclk);
+error_enable:
+	sun4i_ss_disable(ss);
 	return err;
 }
 
@@ -416,10 +434,7 @@ static int sun4i_ss_remove(struct platform_device *pdev)
 	}
 
 	writel(0, ss->base + SS_CTL);
-	if (ss->reset)
-		reset_control_assert(ss->reset);
-	clk_disable_unprepare(ss->busclk);
-	clk_disable_unprepare(ss->ssclk);
+	sun4i_ss_disable(ss);
 	return 0;
 }
 
-- 
2.21.0

