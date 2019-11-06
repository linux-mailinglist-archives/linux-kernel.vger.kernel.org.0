Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E71F0EA3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 07:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbfKFGDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 01:03:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44106 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfKFGDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:03:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id q26so18000842pfn.11;
        Tue, 05 Nov 2019 22:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wigKnx55CwbHshgUiFaVzzGEeLAYy1kZhbF9mN3t1iQ=;
        b=fSwNEiMfRyxD2QUPGH3qIOL5nKZap+JEIPRAGtKhA3RJzY9bg8Uuq7XUaoWms/U+J3
         M1YNO82g7kQQPkUk6Cbblv0pPq5zTQ3bFnhoWz8p1OGz3UX+oa0BzgfgyLdAK0KMm/Re
         RUuI1408xJq+t32sZnOy4uwYUSHZ97zVG71FEQgomtA7ApGNz1RAFAORbumiBXhwv+E1
         s6bZT6YjEtZ927HiDEya7hsToW40MDOTep8u4VXCgCb3c9LHOXo//4yfkiQoR+jw26QO
         yV8RuT05L7iM4XsLAZjLMQsGwRnnUJ5ilywOu5BiNEc8zozxBrO+TJrM3ymdz6kEfqUW
         GDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wigKnx55CwbHshgUiFaVzzGEeLAYy1kZhbF9mN3t1iQ=;
        b=BxQivh38wysNRyG9C00d95vR65DmkKVI8BC20ZaFs0shZAYqvHDFJVzr0sjUf9lDU0
         QFXhgMIFQAlxpGE2jFuXlUtoXWoKjw7x8rTh/bieV+c4o7tY9PQgbaWIggVTr7z980Bm
         UJgh6+ydZLL9z3zG14AwaMBiEJdYv9qjAU3mceXIH4WRpXZvRCOiI4TK5epqQQTMg/Ug
         sLN4L3nauM6nLr8NtqVedzd5BKcBHH7OuIQmb9kBnblMGdPJhMbnKzVXvwMHCuAondO5
         17cWBw97mwM4oEquAR0u4p00+fMKNVuCCtrA5l9IVaMAwa/zA2zYnYw6eyOwz/kXUhzC
         4vDw==
X-Gm-Message-State: APjAAAVf9oTNPw7O5D6nWJanKLWYm/NzPjXMyz3MjE17hiQgfeihTKXn
        zesOsWd0W+jzid66UoAst0w=
X-Google-Smtp-Source: APXvYqxvxvJFjrA4w6wIzW/LIGBxPP5L8U7fxTPsqElSOd637v8l3/FSi8dbjYpE08NSI1pxktR48g==
X-Received: by 2002:a65:5a06:: with SMTP id y6mr911719pgs.9.1573020202371;
        Tue, 05 Nov 2019 22:03:22 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id u65sm23177676pfb.35.2019.11.05.22.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 22:03:21 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH 2/4] clocksource: fttmr010: Set interrupt and shutdown
Date:   Wed,  6 Nov 2019 16:32:59 +1030
Message-Id: <20191106060301.17408-3-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191106060301.17408-1-joel@jms.id.au>
References: <20191106060301.17408-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting the ast2600, pass the shutdown and
interrupt functions to the common init callback.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/clocksource/timer-fttmr010.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index c2d30eb9dc72..8a79025339d0 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -244,7 +244,10 @@ static irqreturn_t fttmr010_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
+static int __init fttmr010_common_init(struct device_node *np,
+		bool is_aspeed,
+		int (*timer_shutdown)(struct clock_event_device *),
+		irq_handler_t handler)
 {
 	struct fttmr010 *fttmr010;
 	int irq;
@@ -345,7 +348,7 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 				     fttmr010->tick_rate);
 	}
 
-	fttmr010->timer_shutdown = fttmr010_timer_shutdown;
+	fttmr010->timer_shutdown = timer_shutdown;
 
 	/*
 	 * Setup clockevent timer (interrupt-driven) on timer 1.
@@ -354,7 +357,7 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 	writel(0, fttmr010->base + TIMER1_LOAD);
 	writel(0, fttmr010->base + TIMER1_MATCH1);
 	writel(0, fttmr010->base + TIMER1_MATCH2);
-	ret = request_irq(irq, fttmr010_timer_interrupt, IRQF_TIMER,
+	ret = request_irq(irq, handler, IRQF_TIMER,
 			  "FTTMR010-TIMER1", &fttmr010->clkevt);
 	if (ret) {
 		pr_err("FTTMR010-TIMER1 no IRQ\n");
@@ -403,12 +406,16 @@ static int __init fttmr010_common_init(struct device_node *np, bool is_aspeed)
 
 static __init int aspeed_timer_init(struct device_node *np)
 {
-	return fttmr010_common_init(np, true);
+	return fttmr010_common_init(np, true,
+			fttmr010_timer_shutdown,
+			fttmr010_timer_interrupt);
 }
 
 static __init int fttmr010_timer_init(struct device_node *np)
 {
-	return fttmr010_common_init(np, false);
+	return fttmr010_common_init(np, false,
+			fttmr010_timer_shutdown,
+			fttmr010_timer_interrupt);
 }
 
 TIMER_OF_DECLARE(fttmr010, "faraday,fttmr010", fttmr010_timer_init);
-- 
2.24.0.rc1

