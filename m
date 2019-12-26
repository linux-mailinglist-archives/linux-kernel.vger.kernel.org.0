Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0328112ABEB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Dec 2019 12:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfLZLar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Dec 2019 06:30:47 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51596 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLZLaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 06:30:46 -0500
Received: by mail-pj1-f65.google.com with SMTP id j11so3237649pjs.1;
        Thu, 26 Dec 2019 03:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=nVzp8rqaDTTY7sAFNAFLTve3VsfLdzj2ihK4V7/f3fA=;
        b=ER38NVUikj9LKkO+PKHphFVhTpPNZ5RTvBMVH0/YW9i62NS6/mZDGt4rJ/Y6MvuV1N
         rXbelOVjgErqyhsTRH473+kD2AjHsrt5TVMDFcNUOe3R63qdXt0YX3hnJMSQFvfKpoJg
         IFogqTshY0PrLDK/LUx9+0jEqZGshmemI20uTosGBWgRv2sOlVGxtw3G7I402AwfMp66
         MpLGlF+LBeamdovN+8Jk4AJPLj+03GAL3sso/Kra67melCCn4TYY1cTpoEXUiwu13CKz
         MTnSSyU/wuXmanm8pX5RDfZC00TETsZ0DDUbDnzdaxy5GT5VQtyNxRPceRh23lkz4/k2
         StGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=nVzp8rqaDTTY7sAFNAFLTve3VsfLdzj2ihK4V7/f3fA=;
        b=PfswPEW1J7ZVbRnf4bcTpmVhJMYRnUjYY77n+MDc7RNlDAdg+SQFZNm+nUBWY5NS33
         FBjeBE8Q5805+CDQUd1gP4Umfo0uVVLMUWuuJy65A5IOMZX38eQUF/aCeY+v7VAtV3dn
         pD5xO0I6l1bIi7NbwAw7O97S5vnW6R5lGov7+jPn9OCKiB7NjuPrgONirFeGMX31EaOD
         qFAZRL4FjdbiBfqwFD8/ipqPGLjbwse9qX/J/LtxGdHiryaK1bSvzldlaQDF6JcHFZSR
         X01HPpZa23E5Lpoi0MactnPLtSBo1ngCqX4PPrcvsK3bMIzjlfhxDScaRHLaFGP2arEa
         LgSw==
X-Gm-Message-State: APjAAAXGqBmZ+VuCqDdloYpDvpeJamqKUovbx0QWz8/ynnI1jf1pjNHQ
        aBAohcpP5mgym4a1aEhIff220uzcGIA=
X-Google-Smtp-Source: APXvYqy1Bi9yFpB3OFRmVbEKE3dAhm789YqC2w7sTK/eEF5EhnQDlK81qMK0fiKUyYEBzr08Oiu4Tw==
X-Received: by 2002:a17:90a:ec10:: with SMTP id l16mr18384302pjy.19.1577359845458;
        Thu, 26 Dec 2019 03:30:45 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y6sm33743287pgc.10.2019.12.26.03.30.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Dec 2019 03:30:45 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mmc: host: sdhci-sprd: Implement the request_atomic() API
Date:   Thu, 26 Dec 2019 19:29:20 +0800
Message-Id: <bbaf5843628c2f217fb857f3208693dd1914bc91.1577358666.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1577358666.git.baolin.wang7@gmail.com>
References: <cover.1577358666.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1577358666.git.baolin.wang7@gmail.com>
References: <cover.1577358666.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the request_atomic() API for nonremovable cards, that means
we can submit next request in the irq hard handler context to reduce
latency.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci-sprd.c |   28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index d346223..ae9acb8 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -426,6 +426,27 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	sdhci_request(mmc, mrq);
 }
 
+static void sdhci_sprd_request_atomic(struct mmc_host *mmc,
+				      struct mmc_request *mrq)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
+
+	host->flags |= sprd_host->flags & SDHCI_AUTO_CMD23;
+
+	/*
+	 * From version 4.10 onward, ARGUMENT2 register is also as 32-bit
+	 * block count register which doesn't support stuff bits of
+	 * CMD23 argument on Spreadtrum's sd host controller.
+	 */
+	if (host->version >= SDHCI_SPEC_410 &&
+	    mrq->sbc && (mrq->sbc->arg & SDHCI_SPRD_ARG2_STUFF) &&
+	    (host->flags & SDHCI_AUTO_CMD23))
+		host->flags &= ~SDHCI_AUTO_CMD23;
+
+	sdhci_request_atomic(mmc, mrq);
+}
+
 static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -561,6 +582,11 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	if (ret)
 		goto pltfm_free;
 
+	if (!mmc_card_is_removable(host->mmc))
+		host->mmc_host_ops.request_atomic = sdhci_sprd_request_atomic;
+	else
+		host->always_defer_done = true;
+
 	sprd_host = TO_SPRD_HOST(host);
 	sdhci_sprd_phy_param_parse(sprd_host, pdev->dev.of_node);
 
@@ -654,8 +680,6 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_cleanup_host;
 
-	host->always_defer_done = true;
-
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
-- 
1.7.9.5

