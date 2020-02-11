Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90984158F89
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 14:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgBKNNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 08:13:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51290 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgBKNND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:13:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so3487987wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 05:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GheSz6neeN101nnz+FLOMJnrgCH2+MfnhxBOEsDMmXs=;
        b=JShKl6tZS7GpJERb5eCGZI7MTawLLYCPtJqP12ehsJ1w/S50qovoib1cqPZmaDSwg0
         jjXkPqf63XQRrI6dkcBUNHwhVk9h2r0jG4dXBeIqpCcBT3Vp2CDkhhof/pZkGnlZlYjA
         HX7okiZrFbZkWMoHuCiyZfcMCAyrTjP0QCsDpxUHeXhTVmvYAhwrnRcNs/OYyIgqKloa
         QCkvHDHppbjbbApFdEhR2iytUgCVJn53uI7cgovLsrs6rkN8L+rqlpCWT+hm6l2sibim
         yz9kTe32mQ6GA/gud4Ly3szhwO8p42fGavNl3x8XJ5NV/yrJ9Mu2uPXxEb1y96OU+oa1
         Lizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GheSz6neeN101nnz+FLOMJnrgCH2+MfnhxBOEsDMmXs=;
        b=GCvRpoi+NsTcGExnT6qorgsUy+eEQosc7jRDBS4JqE+GL8gpRP8qr6Dy3xhINOorY2
         d7mxlSo3DEz8hXQ4KPR1MvjcZ9llS9T7jQlBcYCwPHzjpQtFDydZmr9SJL2sLeJQsBAy
         B/KmZuKbwXHhRLXHB8jjTZGgDwd370fz2FCcrkuAcHkA9bXkRReHAZxITKiK8yAB0kw8
         ibRdSLHysS9Ny3CUSjWI92TArmzdUiDX/bpwQ2N6q9TDzlYRJlrQjj2l/aJgs07BU1y5
         RYo91em5KfnZMh7Iwy/vjFaTJ8b+B46WGTjUYKpN8mxizsQlakS26x43qFXMEkIqnLRN
         s3tg==
X-Gm-Message-State: APjAAAVl6zhCqwPAi3iUFxbFfqvJQn7cuFASY4w6EF625UzBQuq0Nsl/
        PIbcTSdBIk/tAgd+fkABy1y2Zg==
X-Google-Smtp-Source: APXvYqxd6Cg0lSNsAMRLVwVUdpIg0bBIYoGlnhsECR2LrSlHcPK1OPYbBWi4nu2ydo/l10SOHjhJIg==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr5979102wmc.185.1581426780114;
        Tue, 11 Feb 2020 05:13:00 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id b21sm3873013wmd.37.2020.02.11.05.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 05:12:59 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/6] irq: make irq_domain_reset_irq_data() available even for non-V2 users
Date:   Tue, 11 Feb 2020 14:12:35 +0100
Message-Id: <20200211131240.15853-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211131240.15853-1-brgl@bgdev.pl>
References: <20200211131240.15853-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

irq_domain_reset_irq_data() doesn't modify the parent data, so it can be
made available even if irq domain hierarchy is not being built.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/irqdomain.h |  4 ++--
 kernel/irq/irqdomain.c    | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index b2d47571ab67..20d38621e2f8 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -450,6 +450,7 @@ extern void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
 				irq_hw_number_t hwirq, struct irq_chip *chip,
 				void *chip_data, irq_flow_handler_t handler,
 				void *handler_data, const char *handler_name);
+extern void irq_domain_reset_irq_data(struct irq_data *irq_data);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 extern struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 			unsigned int flags, unsigned int size,
@@ -475,7 +476,6 @@ extern int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 extern void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs);
 extern int irq_domain_activate_irq(struct irq_data *irq_data, bool early);
 extern void irq_domain_deactivate_irq(struct irq_data *irq_data);
-
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)
 {
@@ -491,7 +491,7 @@ extern int irq_domain_set_hwirq_and_chip(struct irq_domain *domain,
 					 irq_hw_number_t hwirq,
 					 struct irq_chip *chip,
 					 void *chip_data);
-extern void irq_domain_reset_irq_data(struct irq_data *irq_data);
+
 extern void irq_domain_free_irqs_common(struct irq_domain *domain,
 					unsigned int virq,
 					unsigned int nr_irqs);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 7527e5ef6fe5..039427c98af8 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1047,6 +1047,18 @@ int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
 	return virq;
 }
 
+/**
+ * irq_domain_reset_irq_data - Clear hwirq, chip and chip_data in @irq_data
+ * @irq_data:	The pointer to irq_data
+ */
+void irq_domain_reset_irq_data(struct irq_data *irq_data)
+{
+	irq_data->hwirq = 0;
+	irq_data->chip = &no_irq_chip;
+	irq_data->chip_data = NULL;
+}
+EXPORT_SYMBOL_GPL(irq_domain_reset_irq_data);
+
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 /**
  * irq_domain_create_hierarchy - Add a irqdomain into the hierarchy
@@ -1247,18 +1259,6 @@ void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
 }
 EXPORT_SYMBOL(irq_domain_set_info);
 
-/**
- * irq_domain_reset_irq_data - Clear hwirq, chip and chip_data in @irq_data
- * @irq_data:	The pointer to irq_data
- */
-void irq_domain_reset_irq_data(struct irq_data *irq_data)
-{
-	irq_data->hwirq = 0;
-	irq_data->chip = &no_irq_chip;
-	irq_data->chip_data = NULL;
-}
-EXPORT_SYMBOL_GPL(irq_domain_reset_irq_data);
-
 /**
  * irq_domain_free_irqs_common - Clear irq_data and free the parent
  * @domain:	Interrupt domain to match
-- 
2.25.0

