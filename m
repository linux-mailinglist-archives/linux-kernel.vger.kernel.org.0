Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD009F2AF9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 10:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387896AbfKGJmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 04:42:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45082 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbfKGJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:42:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id z4so2219828pfn.12;
        Thu, 07 Nov 2019 01:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5g0wg9nG73biBQBhbBMB+jIqV4+wI2At3m6HY4ADTtU=;
        b=mDfTEj1bVZMTvTNRCsj15Nj061n/I8mVyj2v0DFN41iSeu9V2BH7F2TbURf46Fxl1t
         +oD9cUmO/i5S+JpQAYlKhZtzzjA7geIp0jHI+lh79PQELBFCd7SesevLh/83K/PGpASI
         8ffWhFcrM6F97uO44Z3ZWw5YogNoWbMBWD8Uq6HFtFWsCkhf3m05OTw7BqCvrLH8i6L8
         qUg9d2v/DgdTxDhjm7RHKWoWXRSQ72X/ZL5P99jtI4QtLhRSMFJ7Z2RSiEAJA2UkwhAn
         QWdNZ+E2Ourh0pmuIY7R80NqGMiB67yYAaOyMOLAA+ES51L16mJEETSyp1VZLF+ukKYr
         vVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5g0wg9nG73biBQBhbBMB+jIqV4+wI2At3m6HY4ADTtU=;
        b=Abkle/povhO7KygiAUFuVqfv79tQ6BiL8ykOdKdmjF290l1LfdzT3nViqUpt1EzZMA
         WClfcKiib7PoZPuUsX/RQVA3xFJHwRJOU6bA7yH8aNePowgX1tT1rhOOx7pt3AvdKUsN
         QTcXwG48lP+2c3+c7uTLoXykT4ZjS9+img5ic5kufSt8+ohcrcfW4TXZushvDb3wf8NZ
         QJsmXFvLPzi6gWhm7FHzfFUW0HGE0jE21LezvhAUObK/EOatiwTI/PnvVQGezyKUdTBF
         sEN7mAW2cxU5PYDKdqN/FUEC2gFkJh8yVouLptIhd7kJ6ii+LCzfN/ldqiyqdA9PfPH5
         zXuw==
X-Gm-Message-State: APjAAAVlxhejqZgNXxTEIaBtcY5bmPjytgC9+6vnPBoVFDGLk0keU6dy
        Jnf6ObGncXQzwH6+gXitQsZZ0lK7sTE=
X-Google-Smtp-Source: APXvYqw1XQhbfb6dttDEP2IN6YNGoksIAys6RePn2ents3O0fOsdYTxgxR728iYc1a7PSlrEsmFC6w==
X-Received: by 2002:a63:181f:: with SMTP id y31mr3207921pgl.186.1573119762904;
        Thu, 07 Nov 2019 01:42:42 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id 12sm1958195pfp.79.2019.11.07.01.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 01:42:42 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v2 1/4] clocksource: fttmr010: Parametrise shutdown
Date:   Thu,  7 Nov 2019 20:12:15 +1030
Message-Id: <20191107094218.13210-2-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191107094218.13210-1-joel@jms.id.au>
References: <20191107094218.13210-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting the ast2600 which uses a different method
to clear bits in the control register, use a callback for performing the
shutdown sequence.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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

