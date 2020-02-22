Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBDC169230
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 00:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgBVXOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 18:14:34 -0500
Received: from vps.xff.cz ([195.181.215.36]:33994 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbgBVXOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 18:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582413271; bh=EbeAOpviq24JHTSqKTtGGCUdeye+O8up0OquvyuB0Sg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lcuPU+GfEZsPTBkMZdO9IBD8LxhgGqJSAaMWttZ1ZocTjfnyf9sAKW6N1ahFP7fGz
         StwBRq5EfBO2lhChY6aEQpwUqZtJP4NxdO3ivnACiadBHws37Y1Rm+NLEz3Y9tlabt
         8eeuHQxdfTXPykC9tD30SXbLhOVdfIwsdm119nOw=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Luca Weiss <luca@z3ntu.xyz>, Tomas Novotny <tomas@novotny.cz>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] input: gpio-vibra: Allow to use vcc-supply alone to control the vibrator
Date:   Sun, 23 Feb 2020 00:14:26 +0100
Message-Id: <20200222231428.233621-3-megous@megous.com>
In-Reply-To: <20200222231428.233621-1-megous@megous.com>
References: <20200222231428.233621-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make enable-gpio optional to allow using this driver with
boards that have vibrator connected to a power supply without
intermediate gpio based enable circuitry.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/input/misc/gpio-vibra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/gpio-vibra.c b/drivers/input/misc/gpio-vibra.c
index f79f75595dd73..f11877f04b43c 100644
--- a/drivers/input/misc/gpio-vibra.c
+++ b/drivers/input/misc/gpio-vibra.c
@@ -121,7 +121,8 @@ static int gpio_vibrator_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	vibrator->gpio = devm_gpiod_get(&pdev->dev, "enable", GPIOD_OUT_LOW);
+	vibrator->gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
+						 GPIOD_OUT_LOW);
 	err = PTR_ERR_OR_ZERO(vibrator->gpio);
 	if (err) {
 		if (err != -EPROBE_DEFER)
-- 
2.25.1

