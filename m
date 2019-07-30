Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E711A7B1BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbfG3STt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:19:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37863 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387553AbfG3SQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id i70so19737018pgd.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1vWUmpmVNnICz7TB6lvEdzPoKbI3ZZ7sRmOecFANbCU=;
        b=NK10/uJHFuNKun4KjPHLULC6X4ualJpqBM9mz8GSXrdEW9Cgf/lNAvKR0d1OQJnyhP
         OXpojQEShlYHOYhMb9JmeIIjih2TamlZoJ57uvUkjitw9VB8vK2wUa0063KOJ0Cki+OA
         7QTI4jLIVeuwwzkk1NyVi4bB72/kvTdVJzDEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1vWUmpmVNnICz7TB6lvEdzPoKbI3ZZ7sRmOecFANbCU=;
        b=cQ+huJbYkLBLb43qgnSLbHt/7J+M/KsZ0/WciDDoZKiXdJcuao5gFiZdz5hVsJzxHF
         WugPXQlULzvCqWnNiuikJpq5NRhIEX2XyAoOwzLuN4eVYLn7N+3CDhn1giGo7ws07aNx
         qRPadlKbn7reyFygb81y7QI4UFtvHy3Ua60aL3kRcNJ2GVAxmkeDjQZ+FbEZ9Qfq/7gn
         UkXWlpFnbVjcjv7n65r4GZtfKjhttNNuD6ZfKWzz47xhqRfiDqcxJFyOD59bBS/yhhKS
         SZZ+M6lSLBiGOwdRwCKtfQnQB9VKen5F7crk82uw0WbodWJMw1niqsmq4v15OlQF0i6I
         lvcg==
X-Gm-Message-State: APjAAAUsY2IkwVva3IW9MC6fsTuwtVWX6xBgdXoCIJSITSJeNLQ4L5jf
        CZpMv1DRGzri9jCXqCWq8oJepq6Ct2k=
X-Google-Smtp-Source: APXvYqw4JRt6DjkgPPL4ADGLOngkuxFcm49Yqtodpx4qAk6+AZL5RD+TGGuAtPdzkd51R9TAMCRyNw==
X-Received: by 2002:a17:90a:5288:: with SMTP id w8mr119352919pjh.61.1564510578193;
        Tue, 30 Jul 2019 11:16:18 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:17 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 23/57] irqchip: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:23 -0700
Message-Id: <20190730181557.90391-24-swboyd@chromium.org>
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

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/irqchip/irq-imgpdc.c        | 8 ++------
 drivers/irqchip/irq-keystone.c      | 4 +---
 drivers/irqchip/qcom-irq-combiner.c | 4 +---
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index d00489a4b54f..698d07f48fed 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -362,10 +362,8 @@ static int pdc_intc_probe(struct platform_device *pdev)
 	}
 	for (i = 0; i < priv->nr_perips; ++i) {
 		irq = platform_get_irq(pdev, 1 + i);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "cannot find perip IRQ #%u\n", i);
+		if (irq < 0)
 			return irq;
-		}
 		priv->perip_irqs[i] = irq;
 	}
 	/* check if too many were provided */
@@ -376,10 +374,8 @@ static int pdc_intc_probe(struct platform_device *pdev)
 
 	/* Get syswake IRQ number */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "cannot find syswake IRQ\n");
+	if (irq < 0)
 		return irq;
-	}
 	priv->syswake_irq = irq;
 
 	/* Set up an IRQ domain */
diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index efbcf8435185..8118ebe80b09 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -164,10 +164,8 @@ static int keystone_irq_probe(struct platform_device *pdev)
 	}
 
 	kirq->irq = platform_get_irq(pdev, 0);
-	if (kirq->irq < 0) {
-		dev_err(dev, "no irq resource %d\n", kirq->irq);
+	if (kirq->irq < 0)
 		return kirq->irq;
-	}
 
 	kirq->dev = dev;
 	kirq->mask = ~0x0;
diff --git a/drivers/irqchip/qcom-irq-combiner.c b/drivers/irqchip/qcom-irq-combiner.c
index d88e993aa66d..abfe59284ff2 100644
--- a/drivers/irqchip/qcom-irq-combiner.c
+++ b/drivers/irqchip/qcom-irq-combiner.c
@@ -248,10 +248,8 @@ static int __init combiner_probe(struct platform_device *pdev)
 		return err;
 
 	combiner->parent_irq = platform_get_irq(pdev, 0);
-	if (combiner->parent_irq <= 0) {
-		dev_err(&pdev->dev, "Error getting IRQ resource\n");
+	if (combiner->parent_irq <= 0)
 		return -EPROBE_DEFER;
-	}
 
 	combiner->domain = irq_domain_create_linear(pdev->dev.fwnode, combiner->nirqs,
 						    &domain_ops, combiner);
-- 
Sent by a computer through tubes

