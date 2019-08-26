Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7BB9C7D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 05:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfHZDTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 23:19:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34608 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbfHZDTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:19:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so9682388pgc.1;
        Sun, 25 Aug 2019 20:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrKXb1c+fhWL6XvI6Q8/QhED1MUXcVFYoSihiJAZjTw=;
        b=slhUxvnhGpV6q597AQTrd/fdto0uqCVHTUkFdHIuxFjXjGw31s9GinpL1xDyvEM9KD
         ALUyg1Aruz9FyXfUSWbiINUptanxSXIg2ONksosjrl+TPEHh/nPOGP4QGSIYmFUKw5im
         e5IrhSYWlfawHlB8PvZeAlfZ9T15ue6Y1oR0TkcOKHzOcPAMK7VOYXxUqtfVMm4vtQbC
         BTtUQjDSn7ziAsWJISuPlckXsFOhrSkcEA4sKL24HSL4q+LHNcZamXsOttEEyAAoK9Y0
         pTTqfSmD4svCfaKnT5dLKS9hoSTNoqVfvX9EKEed+Ywmpckg8p767hZHL1X5HwM8mvm0
         2iAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrKXb1c+fhWL6XvI6Q8/QhED1MUXcVFYoSihiJAZjTw=;
        b=JhrEH2AU3XiVakWiUzx0LaTkPMysFpLPEQiD0FglfnJP+2AkQN3lT+XFw8c0aloTIZ
         CW7SBFguo5scgEBqp+eLGGOI/Av6wklXyJT1KbOfFGY/D7lJBSlW/mtyZotXyA3TSoT/
         x/j6YeMRuULhB/mDsxPiX056IofRtUbZBtb/OucgezNMMqoNqfcRo0yLxLz16mDu5768
         rFX+ejUffy6UmmjH93L2hdnebgIn66PLKNTEjKSkMtjPgDZkR1dbSp9s0PEKJv7Ng18Q
         q01gg9FL52VTMV694/Slap0TvSN2hX5YTPmXjjDgn0s2Olr0j7HhpPhdXn+7eXL/+wsr
         NGZA==
X-Gm-Message-State: APjAAAURCBdh+ij88GlJR8kpY8fThRUbD2Ef8FHwuo/rMZLtbfxEQwaf
        iWaD719zGY9KHvwrjs3nCRZUKU/J
X-Google-Smtp-Source: APXvYqxFQi3ogEq2PItJyW2uQWyx/dSjwssauzEKVYeY3WomX4VlQwGScvONgZlEs6bzn6o3LPPb6A==
X-Received: by 2002:a65:4546:: with SMTP id x6mr14195563pgr.266.1566789545234;
        Sun, 25 Aug 2019 20:19:05 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y23sm12565905pfr.86.2019.08.25.20.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 20:19:04 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 5/5] mmc: sdhci-sprd: clear the UHS-I modes read from registers
Date:   Mon, 26 Aug 2019 11:18:30 +0800
Message-Id: <20190826031830.30931-6-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826031830.30931-1-zhang.lyra@gmail.com>
References: <20190826031830.30931-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

sprd's sd host controller supports SDR50/SDR104/DDR50 though, the UHS-I
mode used by the specific card can be selected via devicetree only.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/mmc/host/sdhci-sprd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 1fecf055682c..d3c3e95676f0 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -509,7 +509,8 @@ static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_host,
 
 static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
-		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_MISSING_CAPS,
 	.quirks2 = SDHCI_QUIRK2_BROKEN_HS200 |
 		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT |
 		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
@@ -614,6 +615,16 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 
 	sdhci_enable_v4_mode(host);
 
+	/*
+	 * Supply the existing CAPS, but clear the UHS-I modes. This
+	 * will allow these modes to be specified only by device
+	 * tree properties through mmc_of_parse().
+	 */
+	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
+			 SDHCI_SUPPORT_DDR50);
+
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto pm_runtime_disable;
-- 
2.20.1

