Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07FF450B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 15:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbfFXNOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 09:14:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51059 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbfFXNOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:14:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so12778098wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 06:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7QzkaTCV3I7NgoLWSlqzvltTcK62DUmr4R57ORffNTM=;
        b=edO6aPEP58ioKdqIasfS9Zjvh73POdMrN4X8etJfFka0LxkGuLgGoDrv0M5pwm88uP
         /yX8icxiLs0Oc9gECnhNwwKVhmlPrhJ7PmEOeK0UFsEKakynLLLau+4psJ7T6IK86qHn
         nOqqSXD7encRu+XgoVp9KWbCJVb9oiD5zrTuXnDZ0EVSh3jK53n2X6481JVPLfD6Nbu+
         +gn5K+BKREHFEf9sf6p4T1qjPV6JZuYs73AIl1/s+eHhTcU5VDs/eGxVcvQfBSNV+5/H
         yLfaZ5pcktJMHz5511G3nE1ssKyQDCcqD3wwO8qjaCg/gg0oKlUvAOf3aLytgJMZqKSE
         T1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7QzkaTCV3I7NgoLWSlqzvltTcK62DUmr4R57ORffNTM=;
        b=ksAMPObqz2kqKeA/65y2ctnmaZfbZ9KnhiAIqXk1fvwf5DrNV3xiAVrhuGKVxGnF9m
         BqEpGd2TWfE6TsT5cjj/ufNeScm9mYFbaYqGd1ndwqfwrBVu2or3+kRwCvFxIiqNuaVE
         65N6yl6lGb4T4n4fZOSuITY58iX5JnIAa6ArR0oHrR81bin61mX9CfzRMbDroo9TthqL
         NWeZdU9klA2gCW1nwj4MxeO31zG4Kt92oV0MaxucFc7vHlnaps+v2ZjYOUDIUm1Ef/eX
         f3E5F1EyDI/i8u0zUHz5vRuJEIcmGLfnJjMEowYLtJuGoSixXAeGkchKQnSb804ho0V2
         58MQ==
X-Gm-Message-State: APjAAAXgfn8udJMU4tAe2z6Mid6UWLah+425Ub6vzpZXXdSiBSZOkidX
        MMZTaHlxKQvAfz0HQwB9WBNLDg==
X-Google-Smtp-Source: APXvYqwVFqcCUQwQhci8y9g7envcvDcRv+Wn+pc6LI5R5mNzl8SLt8XJoW+JJe2vPDvfeIL0skR+Gw==
X-Received: by 2002:a7b:c34b:: with SMTP id l11mr16313292wmj.69.1561382045600;
        Mon, 24 Jun 2019 06:14:05 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id y2sm9535526wrl.4.2019.06.24.06.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:14:04 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 04/10] ARM: davinci: da830: switch to using the clocksource driver
Date:   Mon, 24 Jun 2019 15:13:45 +0200
Message-Id: <20190624131351.3732-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190624131351.3732-1-brgl@bgdev.pl>
References: <20190624131351.3732-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have a proper clocksource driver for davinci. Switch the da830
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/da830.c | 41 ++++++++++++-----------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 220e99438ae0..018ab4b549f1 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -21,7 +21,8 @@
 #include <mach/common.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "irqs.h"
 #include "mux.h"
@@ -676,32 +677,17 @@ int __init da830_register_gpio(void)
 	return da8xx_register_gpio(&da830_gpio_platform_data);
 }
 
-static struct davinci_timer_instance da830_timer_instance[2] = {
-	{
-		.base		= DA8XX_TIMER64P0_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_0),
-		.cmp_off	= DA830_CMP12_0,
-		.cmp_irq	= DAVINCI_INTC_IRQ(IRQ_DA830_T12CMPINT0_0),
-	},
-	{
-		.base		= DA8XX_TIMER64P1_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_1),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_1),
-		.cmp_off	= DA830_CMP12_0,
-		.cmp_irq	= DAVINCI_INTC_IRQ(IRQ_DA830_T12CMPINT0_1),
-	},
-};
-
 /*
- * T0_BOT: Timer 0, bottom		: Used for clock_event & clocksource
- * T0_TOP: Timer 0, top			: Used by DSP
- * T1_BOT, T1_TOP: Timer 1, bottom & top: Used for watchdog timer
+ * Bottom half of timer0 is used both for clock even and clocksource.
+ * Top half is used by DSP.
  */
-static struct davinci_timer_info da830_timer_info = {
-	.timers		= da830_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_BOT,
+static const struct davinci_timer_cfg da830_timer_cfg = {
+	.reg = DEFINE_RES_IO(DA8XX_TIMER64P0_BASE, SZ_4K),
+	.irq = {
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA830_T12CMPINT0_0)),
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0)),
+	},
+	.cmp_off = DA830_CMP12_0,
 };
 
 static const struct davinci_soc_info davinci_soc_info_da830 = {
@@ -713,7 +699,6 @@ static const struct davinci_soc_info davinci_soc_info_da830 = {
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
 	.pinmux_pins		= da830_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da830_pins),
-	.timer_info		= &da830_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 };
 
@@ -743,6 +728,7 @@ void __init da830_init_time(void)
 {
 	void __iomem *pll;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA830_REF_FREQ);
 
@@ -756,7 +742,8 @@ void __init da830_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &da830_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource da830_psc0_resources[] = {
-- 
2.21.0

