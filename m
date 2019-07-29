Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D648791B5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 19:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfG2RFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 13:05:04 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:40125 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727487AbfG2RFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 13:05:04 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x6TH3wlC028965;
        Mon, 29 Jul 2019 20:03:58 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 8441)
        id BD76B62A2E; Mon, 29 Jul 2019 20:03:58 +0300 (IDT)
From:   Avi Fishman <avifishman70@gmail.com>
To:     tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        avifishman70@gmail.com
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v5] clocksource/drivers/npcm: fix GENMASK and timer operation
Date:   Mon, 29 Jul 2019 20:03:54 +0300
Message-Id: <20190729170354.202374-1-avifishman70@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NPCM7XX_Tx_OPER GENMASK bits where wrong,
Since NPCM7XX_REG_TICR0 register reset value of those bits was 0,
it did not cause an issue.
in npcm7xx_timer_oneshot() the original NPCM7XX_REG_TCSR0 register was
read again after masking it with ~NPCM7XX_Tx_OPER so the masking didn't
take effect.

npcm7xx_timer_periodic() was not wrong but it wrote to NPCM7XX_REG_TICR0
in a middle of read modify write to NPCM7XX_REG_TCSR0 which is
confusing.
npcm7xx_timer_oneshot() did wrong calculation

Signed-off-by: Avi Fishman <avifishman70@gmail.com>
---
 drivers/clocksource/timer-npcm7xx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-npcm7xx.c b/drivers/clocksource/timer-npcm7xx.c
index 8a30da7f083b..9780ffd8010e 100644
--- a/drivers/clocksource/timer-npcm7xx.c
+++ b/drivers/clocksource/timer-npcm7xx.c
@@ -32,7 +32,7 @@
 #define NPCM7XX_Tx_INTEN		BIT(29)
 #define NPCM7XX_Tx_COUNTEN		BIT(30)
 #define NPCM7XX_Tx_ONESHOT		0x0
-#define NPCM7XX_Tx_OPER			GENMASK(27, 3)
+#define NPCM7XX_Tx_OPER			GENMASK(28, 27)
 #define NPCM7XX_Tx_MIN_PRESCALE		0x1
 #define NPCM7XX_Tx_TDR_MASK_BITS	24
 #define NPCM7XX_Tx_MAX_CNT		0xFFFFFF
@@ -84,8 +84,6 @@ static int npcm7xx_timer_oneshot(struct clock_event_device *evt)
 
 	val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
 	val &= ~NPCM7XX_Tx_OPER;
-
-	val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
 	val |= NPCM7XX_START_ONESHOT_Tx;
 	writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
 
@@ -97,12 +95,11 @@ static int npcm7xx_timer_periodic(struct clock_event_device *evt)
 	struct timer_of *to = to_timer_of(evt);
 	u32 val;
 
+	writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
+
 	val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
 	val &= ~NPCM7XX_Tx_OPER;
-
-	writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
 	val |= NPCM7XX_START_PERIODIC_Tx;
-
 	writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
 
 	return 0;
-- 
2.18.0

