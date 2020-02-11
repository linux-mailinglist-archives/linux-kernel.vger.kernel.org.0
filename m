Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F368D158F96
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 14:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgBKNNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 08:13:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54009 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbgBKNNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:13:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id s10so3472950wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 05:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f+82O1OuBB3itFL0o65sBPeQjxKbsseoBh5Dt/Kun5Y=;
        b=1jvVusFzmlhzxZfNTJYcIcWAhYOXsvC8wyNQkaeYZ5qJyntOxfoWQgnmgOXW6jchYp
         Iu02eDVYR6McIUfUL/VvFFm0qrea5OtXU2TrWDUC627cE+5bkdrK64ofCM/jOnYhQRWb
         c44LrAvxURzTDxJYWAe1B4TztYkJxXOgxPMA0Z5+tRseJu0hF6zckMivlEPCqIIUWedp
         ztA1RAOwZ86g50jC5ePdx1lesa/MPL2wdo4qGVDBfFpbUu1sCFqt8+OFsYMlkLoTMV/t
         R1czk5ccNrwYP0oixc766Su6GZMmsCdZ3Cir8rx47YZ/LzVmn5wRrLqEze0l3sfRm2lF
         ymWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f+82O1OuBB3itFL0o65sBPeQjxKbsseoBh5Dt/Kun5Y=;
        b=jeZS0YrRs8UBK5tbsMjb/watzIVRMGaRJgSpN/PaRM9I/AkQsgCm1AVhYRW45U5cw/
         W/Nens3CJtOQ65nvDVtxX1IPoCCvY6oHZz2K2NUtyVzxX0ga7lnXMkXGu5eRdLHgsb9m
         /vvzz+HBS4amADqYsL2MCmD8dZR1Oy+l/UEdm+J/avQCAZEEmwuzh+Hb5flzVdIJbcvz
         KNX7xJUR3O0f+lcMi/7qrmwwlQD4IGqlG6CA3RtVuAlh60J8MlIJhiM4rU+2iVrtvQ15
         NeYIqKU+PVy5lS9DkZBjDEQ7i2xstLg+TrKr89bamPiP6aY9srVIUi3L2nJSHpVUSzeh
         AHCg==
X-Gm-Message-State: APjAAAURa4+rvqY0okQKmIS75UScIO1JPvmPqMYSTEakGRNSNvbK7qzu
        73TtqR2Eo2rMh2NldywQSAhy1w==
X-Google-Smtp-Source: APXvYqzljNsEnWt6VAXASHyN5ZUk1Glg/tkFgMB+ilT6DVfsMIc5l3auu39ziddsgEQzSNQdJY1mqw==
X-Received: by 2002:a7b:c4c5:: with SMTP id g5mr5768157wmk.85.1581426783999;
        Tue, 11 Feb 2020 05:13:03 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id b21sm3873013wmd.37.2020.02.11.05.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 05:13:03 -0800 (PST)
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
Subject: [PATCH v2 4/6] irq/irq_sim: remove irq_domain_remove_sim()
Date:   Tue, 11 Feb 2020 14:12:38 +0100
Message-Id: <20200211131240.15853-5-brgl@bgdev.pl>
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

Use the new remove() callback in irq_domain_ops to dispose of any
private data associated with the sim domain. This allows us to drop
the dedicated irq_domain_remove_sim() function and instead just use
the regular irq_domain_remove().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iio/dummy/iio_dummy_evgen.c |  2 +-
 include/linux/irq_sim.h             |  1 -
 kernel/irq/irq_sim.c                | 32 ++++++++++++-----------------
 3 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
index 31c9e012abeb..47620bdae845 100644
--- a/drivers/iio/dummy/iio_dummy_evgen.c
+++ b/drivers/iio/dummy/iio_dummy_evgen.c
@@ -118,7 +118,7 @@ EXPORT_SYMBOL_GPL(iio_dummy_evgen_get_regs);
 
 static void iio_dummy_evgen_free(void)
 {
-	irq_domain_remove_sim(iio_evgen->irq_sim_domain);
+	irq_domain_remove(iio_evgen->irq_sim_domain);
 	kfree(iio_evgen);
 }
 
diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
index 26bf6164dcc7..90e910fa2f91 100644
--- a/include/linux/irq_sim.h
+++ b/include/linux/irq_sim.h
@@ -21,7 +21,6 @@ struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
 struct irq_domain *devm_irq_domain_create_sim(struct device *dev,
 					      struct fwnode_handle *fwnode,
 					      unsigned int num_irqs);
-void irq_domain_remove_sim(struct irq_domain *domain);
 void irq_sim_fire(int virq);
 
 #endif /* _LINUX_IRQ_SIM_H */
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 575c1e3d32a9..a4400aed5fb2 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -108,9 +108,19 @@ static void irq_sim_domain_unmap(struct irq_domain *domain, unsigned int virq)
 	kfree(irq_ctx);
 }
 
+static void irq_sim_domain_remove(struct irq_domain *domain)
+{
+	struct irq_sim_work_ctx *work_ctx = domain->host_data;
+
+	irq_work_sync(&work_ctx->work);
+	bitmap_free(work_ctx->pending);
+	kfree(work_ctx);
+}
+
 static const struct irq_domain_ops irq_sim_domain_ops = {
 	.map		= irq_sim_domain_map,
 	.unmap		= irq_sim_domain_unmap,
+	.remove		= irq_sim_domain_remove,
 };
 
 /**
@@ -122,6 +132,8 @@ static const struct irq_domain_ops irq_sim_domain_ops = {
  *
  * On success: return a new irq_domain object.
  * On failure: a negative errno wrapped with ERR_PTR().
+ *
+ * The returned domain can be freed using irq_domain_remove().
  */
 struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
 					 unsigned int num_irqs)
@@ -156,29 +168,11 @@ struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(irq_domain_create_sim);
 
-/**
- * irq_domain_remove_sim - Deinitialize the interrupt simulator domain: free
- *                         the interrupt descriptors and allocated memory.
- *
- * @domain:     The interrupt simulator domain to tear down.
- */
-void irq_domain_remove_sim(struct irq_domain *domain)
-{
-	struct irq_sim_work_ctx *work_ctx = domain->host_data;
-
-	irq_work_sync(&work_ctx->work);
-	bitmap_free(work_ctx->pending);
-	kfree(work_ctx);
-
-	irq_domain_remove(domain);
-}
-EXPORT_SYMBOL_GPL(irq_domain_remove_sim);
-
 static void devm_irq_domain_release_sim(struct device *dev, void *res)
 {
 	struct irq_sim_devres *this = res;
 
-	irq_domain_remove_sim(this->domain);
+	irq_domain_remove(this->domain);
 }
 
 /**
-- 
2.25.0

