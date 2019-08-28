Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4869F836
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 04:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfH1CT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 22:19:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36343 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfH1CTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 22:19:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id w2so634434pfi.3;
        Tue, 27 Aug 2019 19:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0+dMjTeRnTWUOUtY5Y5qEbJRKkaqMUR9i5xBsX8C6EU=;
        b=vG3b+7nEBa/2elBzxkm+2aN/qwQlm39sFkNYCsGRiQHJvviHVDTfq2gKtzJe2mFGh4
         wRjwkrFQTjSNDu77sQC0VSqY7QmOccDZG4qjjoA+j5lH7nWFG2SvEgdIPurVzB1OlB5H
         A3TcDWabVdo7KnTh2Yz0lm7iqvmmEp5qoJ1qhCJHjsS9mM+bato28oVcWqQLxPK1krR3
         bcKdrbCTEUZSgRdRzyNb2zv0NT2tcIW5CngtiK39733QK3ULteT2cXjyNBUVPqFWv9/J
         LH8JwPnrQ0IfQidOPSi364OVLZoGNkUjEUsj6hLmp1XEbgwaPuWw4xO0YIrsnWklJ2L/
         mGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+dMjTeRnTWUOUtY5Y5qEbJRKkaqMUR9i5xBsX8C6EU=;
        b=B8gu74jLzzqCZud+zWUyjVN4VmXElb3bBluvinUi/7gs+1bSDbJPHYowU8DvQdOG9z
         nYY+ahbZjiHkxNk1j+JD2EsXcYGoOP4bI/SB9KlyWohQCG4qwvbjGah08WWhciBmqa+z
         4fDLwMbu6lT7drWDdJNV1hLCOIV+ZOr2oKq+EXFOVUUxsvHLpNCTCcwG83/edNpnppkA
         fQE5yqpYOxV5AFZlxUZsOmy/sKsySd4peR+AI9k7U+H5yAG/gk7lfk17Zm5PX1rnD2Rj
         5vXq+hpAgT236fLpQl4P/DoAHIBcOgY3WD+isVjFMaeDqAwKQDqLcz8pYIyCe8uyYIZg
         AHUQ==
X-Gm-Message-State: APjAAAWAJDX4WHIwlbYdZ9822Rnc0yHiBwFHypDzjuU4z4tteGgD08be
        KvlzqtwbWWZM4nemhWpUVzs=
X-Google-Smtp-Source: APXvYqxx5leB7vClgWR/8ru1VCeaX0Wmy4s2jrbuWY49h6OsVbglhOUv7y3mZGpE4SSJzc7dhr9IDg==
X-Received: by 2002:aa7:9e04:: with SMTP id y4mr1950076pfq.18.1566958764704;
        Tue, 27 Aug 2019 19:19:24 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id b18sm673249pfi.160.2019.08.27.19.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 19:19:24 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v2 5/5] mmc: sdhci-sprd: clear the UHS-I modes read from registers
Date:   Wed, 28 Aug 2019 10:17:36 +0800
Message-Id: <20190828021736.22049-6-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828021736.22049-1-zhang.lyra@gmail.com>
References: <20190828021736.22049-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

sprd's sd host controller supports SDR50/SDR104/DDR50 though, the UHS-I
mode used by the specific card can be selected via devicetree only.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host
controller")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>
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

