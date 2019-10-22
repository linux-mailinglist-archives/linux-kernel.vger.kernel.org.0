Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3F3ADFD6E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 08:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbfJVF7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 01:59:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40274 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731015AbfJVF7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 01:59:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id 15so3921426pgt.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 22:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=shSJXxHkqiOnwVznDt/3eHxUBXqubG/+hrNMGFN/+WI=;
        b=gAXkknV0IucthKymxPq6B+aWK9aCNWfbX4eYnr4pyGjA0hMdT1OztIzNZPrdJn7u8K
         Z1ykMhxLWpFO52vL4nSGDmaXBg+yCIt3WUr5hC4LqFjJCh/9miVn2JYz6FDwSHJ5rFXq
         uKshCmFJeG51cvhsB/FCvyJMaMOR6jdMl+vwmRu0R2fPAZ9dL3hob3qfBhmq39zsre3T
         aFf99CL7FKDHbIfcWo4UYJrbL26o6TJ2rPcyXlShN2rhCvyM3ZMkNy/3y+oCYI7zs6aX
         kuLEneqiXs1VLpG6Z9mZMCaID7JPILuVPGFcZMBgpkq+mEdPedz0vjEeUA5z3X2fiZrJ
         L0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=shSJXxHkqiOnwVznDt/3eHxUBXqubG/+hrNMGFN/+WI=;
        b=cIZWZQ44tvJuYE3TBqL6FVfK+rcfXNXZFyTOhl4moB1p44crVUlUaFq7DTppMiyPzI
         4mp+cYyUh8+LuKfq1gRglhqiacObl5w8/j8pncGlAcBWczc4/k2IldOMIzeFQWXUAXwR
         ER42jVHp3JrSAYeK+bYSybUjouDlpSdAMGuicSz/rqEQd4FYq+an8cHyIKqQg4xOyfec
         s/Oy+EqdAL+7+3xaCzTE7/mcfEEsepPw0mqIXm9DocAbEoArmptKWdusx8NGRl1mYjT3
         9sBKgWBCLursf0Ip0zotCUHm0fQU64BL0v8nJ+rDsDAgs3OseYLuABuzCKu+5kb7WSex
         u6Mw==
X-Gm-Message-State: APjAAAVUCPOeMdpKQpVOsPJ7GCFSCohcSv2hKg9vwq6pNk1dPSsy4g+P
        nYcRDyVIuyeL5wMqftVTVLRweA==
X-Google-Smtp-Source: APXvYqzjoLSvUGt8Q1QqZRMMmRg+VMwOLpmfXvYascTlsJAQYMKM43f/kIbY3Q4CvcoWWUgNKGr7HQ==
X-Received: by 2002:a63:1d60:: with SMTP id d32mr1932366pgm.37.1571723989575;
        Mon, 21 Oct 2019 22:59:49 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id g35sm16568061pgg.42.2019.10.21.22.59.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Oct 2019 22:59:48 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] mmc: host: sdhci-sprd: Add software queue support
Date:   Tue, 22 Oct 2019 13:58:57 +0800
Message-Id: <eea9982c738e90c527de2e92c6f2ca97ac74d97f.1571722391.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1571722391.git.baolin.wang@linaro.org>
References: <cover.1571722391.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1571722391.git.baolin.wang@linaro.org>
References: <cover.1571722391.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add software queue support to improve the performance.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/Kconfig      |    1 +
 drivers/mmc/host/sdhci-sprd.c |   26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index efa4019..54b86f6 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -632,6 +632,7 @@ config MMC_SDHCI_SPRD
 	depends on ARCH_SPRD
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_HSQ
 	help
 	  This selects the SDIO Host Controller in Spreadtrum
 	  SoCs, this driver supports R11(IP version: R11P0).
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index d07b979..3cc1277 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 
 #include "sdhci-pltfm.h"
+#include "mmc_hsq.h"
 
 /* SDHCI_ARGUMENT2 register high 16bit */
 #define SDHCI_SPRD_ARG2_STUFF		GENMASK(31, 16)
@@ -379,6 +380,16 @@ static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
 	return 0;
 }
 
+static void sdhci_sprd_request_done(struct sdhci_host *host,
+				    struct mmc_request *mrq)
+{
+	/* Validate if the request was from software queue firstly. */
+	if (mmc_hsq_finalize_request(host->mmc, mrq))
+		return;
+
+	 mmc_request_done(host->mmc, mrq);
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
@@ -392,6 +403,7 @@ static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
 	.hw_reset = sdhci_sprd_hw_reset,
 	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
 	.get_ro = sdhci_sprd_get_ro,
+	.request_done = sdhci_sprd_request_done,
 };
 
 static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -521,6 +533,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
 	struct sdhci_sprd_host *sprd_host;
+	struct mmc_hsq *hsq;
 	struct clk *clk;
 	int ret = 0;
 
@@ -631,6 +644,16 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 
 	sprd_host->flags = host->flags;
 
+	hsq = devm_kzalloc(&pdev->dev, sizeof(*hsq), GFP_KERNEL);
+	if (!hsq) {
+		ret = -ENOMEM;
+		goto err_cleanup_host;
+	}
+
+	ret = mmc_hsq_init(hsq, host->mmc);
+	if (ret)
+		goto err_cleanup_host;
+
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
@@ -689,6 +712,7 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 
+	mmc_hsq_suspend(host->mmc);
 	sdhci_runtime_suspend_host(host);
 
 	clk_disable_unprepare(sprd_host->clk_sdio);
@@ -717,6 +741,8 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
 		goto clk_disable;
 
 	sdhci_runtime_resume_host(host, 1);
+	mmc_hsq_resume(host->mmc);
+
 	return 0;
 
 clk_disable:
-- 
1.7.9.5

