Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B720023104
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 12:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbfETKMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 06:12:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42967 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732461AbfETKMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:12:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id x15so6498355pln.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 03:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=eMFBxEvVv73muoLZwkqzMu7EIBYQwUE2J5IELje2f28=;
        b=yhDed4i3RBqLUdnBe0hSuSFflewfmbhjRUNIe2b4fdBam6M4LQXIcG30ecgTYWvlC+
         9dU9LfmgcnAP8zsReUaDsEr5Xkmyy+W+pifErnX2xqlkaoUVT84a6aehb3b8pawL92iR
         tQ54TONm22Ktua4YOvnugQXU4KlKB/1aAcPyvWXSuSW64HljYJCqgd1DWuOatqdmXFRj
         6fwiys1x5GW60TDPFElDeyOzqvrhUcpcfeidDVdlaDIaMX7F8nJhoUWFquwJiMN01rG0
         u66gGoyroNQY7cRQKDV72UuHYZm6w3oFXuDHMj6WbC0ofrey3hgNjnN5j00zbksct8+W
         nhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=eMFBxEvVv73muoLZwkqzMu7EIBYQwUE2J5IELje2f28=;
        b=fZDgCeTKkdPY19p1VZGXR2fF9+VvKTFyLIitFQMCW/GieyM7fsIeH7sm6KkTwqNisC
         2Bzjk2/UB1rtPo15TXeNBcQf5E5C49+Dd80/gDuxEprBim5mDYzKmQKTN7sEmydet7t0
         VqmBOJK8RBTmjDDyXB/4QwOO30+7ZkNYsOkn8CUqOCFcV10xK2M5eDKEk3e3DCjlwhK8
         VzW8T2Yj3KXopEM3jQ2hIRN6yrZh1dMv06RxRESLAVN/JfPtlm9dgd3SZbOGSFA4XeEX
         YsK6eXN3v+KgM+/vc3M10wkk42yCS2E1uPsvHYjZD15A3dT8Lw0ZnI4wUEACFIpU/k17
         l/+Q==
X-Gm-Message-State: APjAAAVnFVJ84rFvzI1mtPk0OO7LbPGvDGFeDRFkMorpgMvBnzTdxXNT
        uyx/plOqTJlmh69nUUmeJZgHwA==
X-Google-Smtp-Source: APXvYqyagoopJB9p1BnqQ6YN0ozqRnIvUdoq5+OupDz9YCTaL4q6kZYz7+VmAylRGHVAI+KKkgG4KA==
X-Received: by 2002:a17:902:6ac6:: with SMTP id i6mr75225533plt.336.1558347160980;
        Mon, 20 May 2019 03:12:40 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b3sm30098127pfr.146.2019.05.20.03.12.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 03:12:40 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 4/9] mmc: sdhci-sprd: Implement the get_max_timeout_count() interface
Date:   Mon, 20 May 2019 18:11:57 +0800
Message-Id: <ae6e23d4de6bb25cd697412f1402036d5ecc9843.1558346019.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the get_max_timeout_count() interface to set the Spredtrum SD
host controller actual maximum timeout count.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 31ba7d6..d91281d 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -285,6 +285,12 @@ static void sdhci_sprd_hw_reset(struct sdhci_host *host)
 	usleep_range(300, 500);
 }
 
+static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
+{
+	/* The Spredtrum controller actual maximum timeout count is 1 << 31 */
+	return 1 << 31;
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
@@ -296,6 +302,7 @@ static void sdhci_sprd_hw_reset(struct sdhci_host *host)
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
 	.hw_reset = sdhci_sprd_hw_reset,
+	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
 };
 
 static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
-- 
1.7.9.5

