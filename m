Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5263115C49
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2019 14:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfLGNBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Dec 2019 08:01:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45736 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfLGNBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 08:01:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id b9so4347374pgk.12;
        Sat, 07 Dec 2019 05:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dG8vxX7uZglDTdab2aKg6N47zqValFwiCvXmsp/VnHc=;
        b=dKihn8JERK6MPaKyRKVunDCCS+72eAMzM0U++7ADDGPUSgHz+FlDa6R/xkFq23ujtD
         okzoaNRMQ7Uw5xku1m0ONEItGidb46BDIJ5vfDc7J8UBWL3BEjYV13yHOlXV5YEb1uSj
         6pYtjz8lB9gOl913KrqhTFCZq8RMOmVZhoXFbbFqUxQIt1A6fxYTMUmTrkeCGe83EhKS
         GTjy4TivYDJWQXs1W05QZ69pFlBmJ28I1LmqfJY3tYNeACSpiv/V6X/krR8tT4imPSVD
         dOrl2ZxnRjXVPCbm7DJjkLyKJjlBUE7tUxfCPtHwKmxGwmAxEgk30o8J9aCjgTvQ5Kt+
         VcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dG8vxX7uZglDTdab2aKg6N47zqValFwiCvXmsp/VnHc=;
        b=RVDY4Yb27D/Hnqz4Ztsi1CdW+Xr524aX+IkO0QZtCA6eHe1dgleW3wyacjlJ6BRtLg
         legVTxFb6IrmTIwZMiqkA4JGR/CnN/xIV3C+bixGQ8wBSx/rNHvnuqbTLmCHndUJ1VIk
         dAx7ydTJo7SiLXCkwsQZeYIdSKbqjNzoz9j60kHzcpGTZMTLj2JfRNGgG6pcxHryRuPl
         OY9HhckXpyvomeEaM0g6ptWS4K7evkhNK451fu3hZ1mDEHPf/4KT6hW182MNlELthDiI
         MDim+g5vq9bHnV81+RiaCmCA8UnACPfUXa5wvXk118ExKUQJA2UcQn909liuwfkYq0rF
         qCww==
X-Gm-Message-State: APjAAAXtRue+f6JsCrTbuaskVDm28XavkyJ/3WGqPpKAhwcMmMgneelR
        2dqgjYrLUGu9n3DwU7a7SKs=
X-Google-Smtp-Source: APXvYqz+k3c87NitGmT2B9GRr1u3gfx0IO0f+nvexgDJ2siS9kivL7lqN+FrZVU/+FSSz+hMdFFSxw==
X-Received: by 2002:aa7:8f05:: with SMTP id x5mr19707044pfr.86.1575723681648;
        Sat, 07 Dec 2019 05:01:21 -0800 (PST)
Received: from localhost.localdomain ([211.243.117.64])
        by smtp.gmail.com with ESMTPSA id f7sm10241246pfk.183.2019.12.07.05.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 05:01:21 -0800 (PST)
From:   Hyunki Koo <hyunki00.koo@gmail.com>
To:     linux@armlinux.org.uk, kgene@kernel.org, krzk@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Hyunki Koo <hyunki00.koo@samsung.com>
Subject: [PATCH 1/2] irqchip: define EXYNOS_IRQ_COMBINER
Date:   Sat,  7 Dec 2019 22:00:48 +0900
Message-Id: <20191207130049.27533-2-hyunki00.koo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191207130049.27533-1-hyunki00.koo@gmail.com>
References: <20191207130049.27533-1-hyunki00.koo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyunki Koo <hyunki00.koo@samsung.com>

Not all exynos device have IRQ_COMBINER.
Thus add the config for EXYNOS_IRQ_COMBINER.

Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
---
 drivers/irqchip/Kconfig  | 7 +++++++
 drivers/irqchip/Makefile | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index ba152954324b..3ed7b7f2ae26 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -499,4 +499,11 @@ config SIFIVE_PLIC
 
 	   If you don't know what to do here, say Y.
 
+config EXYNOS_IRQ_COMBINER
+	bool "Samsung Exynos IRQ combiner support"
+	depends on ARCH_EXYNOS
+	help
+	  Say yes here to add support for the IRQ combiner devices embedded
+	  in Samsung Exynos chips.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e806dda690ea..60d7c7260fc3 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
 obj-$(CONFIG_DAVINCI_AINTC)		+= irq-davinci-aintc.o
 obj-$(CONFIG_DAVINCI_CP_INTC)		+= irq-davinci-cp-intc.o
-obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
+obj-$(CONFIG_EXYNOS_IRQ_COMBINER)	+= exynos-combiner.o
 obj-$(CONFIG_FARADAY_FTINTC010)		+= irq-ftintc010.o
 obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
 obj-$(CONFIG_ARCH_LPC32XX)		+= irq-lpc32xx.o
-- 
2.17.1

