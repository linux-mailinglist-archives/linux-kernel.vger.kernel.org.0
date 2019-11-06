Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D05B4F0EA1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 07:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbfKFGDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 01:03:20 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35553 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfKFGDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:03:19 -0500
Received: by mail-pl1-f193.google.com with SMTP id s10so75586plp.2;
        Tue, 05 Nov 2019 22:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3naVDG9c+hz6/Z7X8/ImB3hSE5w7Qy3YFszuHTpM04M=;
        b=XmK+NQsTBFz9CKETkjVznn+1L7EJ3D0imyScMrlzjZGY24V0ctvPQ8rSOEh5WJSxUe
         DPXmr71CtdiTRjvn6gMe//mlJHA5/vcz/LegSIQDBYPhUn/ac28TNy5neIxysCl9LFFg
         PL32Sn7Qdiwfan/pSlCbLptCJ0C17zjw7JnN0BliGactrdqt5OHt0uqVsOFXnB8OeQtE
         DDm0+31LNk10vvmXA+/5OyTnoBykiwCngSYstfdHiXEHD0zyh2A9OVHQaeLeiVxz+P4q
         FN/hYZN5cy1DhveKhQVoZtpmU95hEObtFVu+vXBtWbGA7UFoaw9Ir0aKI+jxIJQnjF2a
         Hz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3naVDG9c+hz6/Z7X8/ImB3hSE5w7Qy3YFszuHTpM04M=;
        b=nQDh5bqKRWmfxyCwXAPKrzfqZ8wWbeLvwM8zwZuY6HKDDronLwnCY0C991R6JR+pH5
         AFSyPm7X/zFmgVariY7bzFbbCiPuVFPaWoYZgVN6nWHEQp29wKyfGb9sVLpIqhR2yXLr
         g105BOK82I77K4jK64UtqRWsoS2jykvPDzocCN/LWYEhg7nICbmLp+3m2TYLsmhut33J
         a30M6dAxDZqZ8Tp1d3HXUOmsYlK+YJLzjHUti5jfT7HNBYyHRteoWnxBMzTs/RbqBPnk
         PMfZ5MWfSWgPirWoGgzCLVFUnaLCrAw45t6BdJbcOG0erk+J9mhQkCvMg7ojuRB/WkuY
         0iaw==
X-Gm-Message-State: APjAAAWp/lu61a5A9D8UDpUfo6KCRhRsPExKsgaIvVKABxgLiyrNbK+V
        yf3WDQRK02vCqoswuxsnHqY=
X-Google-Smtp-Source: APXvYqyXRGhxFdsTRCBvR9/1VjHdoQAROfTEGvn5WIGs6If2SaHgTYFWGWRKumj7Du/x8zVKsrgp1g==
X-Received: by 2002:a17:902:9a88:: with SMTP id w8mr828498plp.129.1573020198544;
        Tue, 05 Nov 2019 22:03:18 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id u65sm23177676pfb.35.2019.11.05.22.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 22:03:17 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH 1/4] clocksource: fttmr010: Parametrise shutdown
Date:   Wed,  6 Nov 2019 16:32:58 +1030
Message-Id: <20191106060301.17408-2-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191106060301.17408-1-joel@jms.id.au>
References: <20191106060301.17408-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting the ast2600 which uses a different method
to clear bits in the control register, use a callback for performing the
shutdown sequence.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/clocksource/timer-fttmr010.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index fadff7915dd9..c2d30eb9dc72 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -97,6 +97,7 @@ struct fttmr010 {
 	bool is_aspeed;
 	u32 t1_enable_val;
 	struct clock_event_device clkevt;
+	int (*timer_shutdown)(struct clock_event_device *evt);
 #ifdef CONFIG_ARM
 	struct delay_timer delay_timer;
 #endif
@@ -140,9 +141,7 @@ static int fttmr010_timer_set_next_event(unsigned long cycles,
 	u32 cr;
 
 	/* Stop */
-	cr = readl(fttmr010->base + TIMER_CR);
-	cr &= ~fttmr010->t1_enable_val;
-	writel(cr, fttmr010->base + TIMER_CR);
+	fttmr010->timer_shutdown(evt);
 
 	if (fttmr010->is_aspeed) {
 		/*
@@ -183,9 +182,7 @@ static int fttmr010_timer_set_oneshot(struct clock_event_device *evt)
 	u32 cr;
 
 	/* Stop */
-	cr = readl(fttmr010->base + TIMER_CR);
-	cr &= ~fttmr010->t1_enable_val;
-	writel(cr, fttmr010->base + TIMER_CR);
+	fttmr010->timer_shutdown(evt);
 
 	/* Setup counter start from 0 or ~0 */
 	writel(0, fttmr010->base + TIMER1_COUNT);
@@ -211,9 +208,7 @@ static int fttmr010_timer_set_periodic(struct clock_event_device *evt)
 	u32 cr;
 
 	/* Stop */
-	cr = readl(fttmr010->base + TIMER_CR);
-	cr &= ~fttmr010->t1_enable_val;
-	writel(cr, fttmr010->base + TIMER_CR);
+	fttmr010->timer_shutdown(evt);
 
 	/* Setup timer to fire at 1/HZ intervals. */
 	if (fttmr010->is_aspeed) {
@@ -350,6 +345,8 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 				     fttmr010->tick_rate);
 	}
 
+	fttmr010->timer_shutdown = fttmr010_timer_shutdown;
+
 	/*
 	 * Setup clockevent timer (interrupt-driven) on timer 1.
 	 */
@@ -370,10 +367,10 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 	fttmr010->clkevt.features = CLOCK_EVT_FEAT_PERIODIC |
 		CLOCK_EVT_FEAT_ONESHOT;
 	fttmr010->clkevt.set_next_event = fttmr010_timer_set_next_event;
-	fttmr010->clkevt.set_state_shutdown = fttmr010_timer_shutdown;
+	fttmr010->clkevt.set_state_shutdown = fttmr010->timer_shutdown;
 	fttmr010->clkevt.set_state_periodic = fttmr010_timer_set_periodic;
 	fttmr010->clkevt.set_state_oneshot = fttmr010_timer_set_oneshot;
-	fttmr010->clkevt.tick_resume = fttmr010_timer_shutdown;
+	fttmr010->clkevt.tick_resume = fttmr010->timer_shutdown;
 	fttmr010->clkevt.cpumask = cpumask_of(0);
 	fttmr010->clkevt.irq = irq;
 	clockevents_config_and_register(&fttmr010->clkevt,
-- 
2.24.0.rc1

