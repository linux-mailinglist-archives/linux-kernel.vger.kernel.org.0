Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79B96B057B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 00:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfIKWTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 18:19:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45500 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbfIKWTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 18:19:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id 4so12229493pgm.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 15:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2X3SRzIwnpnErNdvMpQKEQIE0nPz8iNvb6s2mmkqEds=;
        b=Swe/IstEy9pJgy/ebR3/loS/F6ULouZpNAU5NMAqHNylVvY3mNNAYA86S47/2tdJZd
         WhL6RXJs2HTYZjJf/1u5hRsPFPZDwLbJ1rKRh+ZuqFi7lWVF2c0cQKuhMhryOIltmXfo
         VnMRj/LeFqBgBI9QC6/OoUunbXEBEg0ebmry1bGY4S25ACVVx4TvuTFs2pJRPOrc2yzg
         nznWtz5O4489ZB7dlT5rF8uDp6/e08vlVO1GFK5zZCaGBPC4iTwYq84rt359mZJnMP+B
         oiy6sxWSDmSWSjNIaAlLZAbU9kGX6aMkw/nwNU8NRSOEblS36HObUny1W+IoD3t+5nX4
         xjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=2X3SRzIwnpnErNdvMpQKEQIE0nPz8iNvb6s2mmkqEds=;
        b=klsN6HKeqfb8M1EbHKDkzUq7E4fzx8kkBqLIrZiHHlwuCcDWCB/CeVpZhSoF96dMIn
         izbmQB7Vc7OWylA31JIbbPN3rEWynkNjcckUZ+IeJv8q428rXn+spctT/TF79iIepE9z
         NbSMMAskdle1dkSpKDoncOhFBpQ8iTOuYHAAjZWstPJ2H6aY4J44NSyOHbnanUsud0yw
         ZrjRgF16HkN+iLv+/LLHzfPo8Yn17DRqu37KjwTefffVcFgKKrUSTCRCzSQRP0Edfypn
         ZIRa94uZEzm/qGUHTg6EiiiDJVPTiFz2DVNGe/3do/wQrpPi16Gl7O9d7xe5nZU+ea7o
         nqtg==
X-Gm-Message-State: APjAAAVeJ5okT2LfNXa5Jjrbu5rlpBSY8sDiYRpJPF2r9kLxhNHehbIq
        GNgsBGsQ5JqS/n5LNj/0Z2VqDSXHDGgvbA==
X-Google-Smtp-Source: APXvYqw5tBXGpyCHobC9PqT+BPqZzA2y82ejBsAPKuGT1mvGwANpkp7rRrgoOvQbqobn6t1RI+V35w==
X-Received: by 2002:a17:90a:37d1:: with SMTP id v75mr8187287pjb.33.1568240345437;
        Wed, 11 Sep 2019 15:19:05 -0700 (PDT)
Received: from localhost ([49.248.179.160])
        by smtp.gmail.com with ESMTPSA id 69sm30084787pfb.145.2019.09.11.15.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 15:19:04 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>
Cc:     linux-clk@vger.kernel.org
Subject: [PATCH 3/4] arm64: Kconfig: Fix VEXPRESS driver dependencies
Date:   Thu, 12 Sep 2019 03:48:47 +0530
Message-Id: <8f539b28c25d22b8f515c131cd6b24c309f7ca90.1568239378.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568239378.git.amit.kucheria@linaro.org>
References: <cover.1568239378.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1568239378.git.amit.kucheria@linaro.org>
References: <cover.1568239378.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Push various VEXPRESS drivers behind ARCH_VEXPRESS dependency so that it
doesn't get enabled by default on other platforms.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/bus/Kconfig           | 2 +-
 drivers/clk/versatile/Kconfig | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index d80e8d70bf10..b2b1beee9953 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -166,7 +166,7 @@ config UNIPHIER_SYSTEM_BUS
 
 config VEXPRESS_CONFIG
 	bool "Versatile Express configuration bus"
-	default y if ARCH_VEXPRESS
+	depends on ARCH_VEXPRESS
 	depends on ARM || ARM64
 	depends on OF
 	select REGMAP
diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
index ac766855ba16..826750292c1e 100644
--- a/drivers/clk/versatile/Kconfig
+++ b/drivers/clk/versatile/Kconfig
@@ -5,8 +5,8 @@ config ICST
 config COMMON_CLK_VERSATILE
 	bool "Clock driver for ARM Reference designs"
 	depends on ARCH_INTEGRATOR || ARCH_REALVIEW || \
-		ARCH_VERSATILE || ARCH_VEXPRESS || ARM64 || \
-		COMPILE_TEST
+		ARCH_VERSATILE || ARCH_VEXPRESS || COMPILE_TEST
+	depends on ARM64
 	select REGMAP_MMIO
 	---help---
           Supports clocking on ARM Reference designs:
-- 
2.17.1

