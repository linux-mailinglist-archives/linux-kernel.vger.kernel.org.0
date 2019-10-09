Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73569D1BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 00:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbfJIWkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 18:40:22 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:54289 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732260AbfJIWkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:40:19 -0400
X-Originating-IP: 86.202.229.42
Received: from localhost (lfbn-lyo-1-146-42.w86-202.abo.wanadoo.fr [86.202.229.42])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id EF3B920003;
        Wed,  9 Oct 2019 22:40:16 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 8/8] clocksource/drivers/timer-atmel-tcb: add sama5d2 support
Date:   Thu, 10 Oct 2019 00:40:06 +0200
Message-Id: <20191009224006.5021-9-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009224006.5021-1-alexandre.belloni@bootlin.com>
References: <20191009224006.5021-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first divisor for the sama5d2 is actually the gclk selector. Because
the currently remaining divisors are fitting the use case, currently ensure
it is skipped.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clocksource/timer-atmel-tcb.c | 11 ++++++++++-
 include/soc/at91/atmel_tcb.h          |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index ccb77b9cb489..e373b02d509a 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -359,9 +359,15 @@ static struct atmel_tcb_config tcb_sam9x5_config = {
 	.counter_width = 32,
 };
 
+static struct atmel_tcb_config tcb_sama5d2_config = {
+	.counter_width = 32,
+	.has_gclk = 1,
+};
+
 static const struct of_device_id atmel_tcb_of_match[] = {
 	{ .compatible = "atmel,at91rm9200-tcb", .data = &tcb_rm9200_config, },
 	{ .compatible = "atmel,at91sam9x5-tcb", .data = &tcb_sam9x5_config, },
+	{ .compatible = "atmel,sama5d2-tcb", .data = &tcb_sama5d2_config, },
 	{ /* sentinel */ }
 };
 
@@ -426,7 +432,10 @@ static int __init tcb_clksrc_init(struct device_node *node)
 
 	/* How fast will we be counting?  Pick something over 5 MHz.  */
 	rate = (u32) clk_get_rate(t0_clk);
-	for (i = 0; i < ARRAY_SIZE(atmel_tcb_divisors); i++) {
+	i = 0;
+	if (tc.tcb_config->has_gclk)
+		i = 1;
+	for (; i < ARRAY_SIZE(atmel_tcb_divisors); i++) {
 		unsigned divisor = atmel_tcb_divisors[i];
 		unsigned tmp;
 
diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
index c3c7200ce151..fbf5474f4484 100644
--- a/include/soc/at91/atmel_tcb.h
+++ b/include/soc/at91/atmel_tcb.h
@@ -39,6 +39,7 @@ struct clk;
  */
 struct atmel_tcb_config {
 	size_t	counter_width;
+	unsigned int has_gclk:1;
 };
 
 /**
-- 
2.21.0

