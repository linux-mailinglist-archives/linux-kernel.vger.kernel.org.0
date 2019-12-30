Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C1B12CE30
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 10:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfL3JWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 04:22:40 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40454 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfL3JWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 04:22:39 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBU9MXUB106994;
        Mon, 30 Dec 2019 03:22:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577697753;
        bh=+WrmWkextCd+cYVbBa5fxCxHjWM2NsKQQzbXjWS0YsY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uMKCP9DysNsFQcrFJw+TdzkKZHx6CrxJZHBPoL137zx+kr3MRwgFdjJZKa5JFCp6D
         PdB1ZwHdMiT5twoUarBA1RuAryZubMPlaZLdkZSWLsWhGs2TYqx3V/1i35/qkdomRr
         TBHJC6LP1YsZOq5q3ZpDKtbMc8d4yqAFJ5ZbHn1M=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBU9MX8u104159;
        Mon, 30 Dec 2019 03:22:33 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 30
 Dec 2019 03:22:33 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 30 Dec 2019 03:22:33 -0600
Received: from a0230074-OptiPlex-7010.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBU9MOJl109856;
        Mon, 30 Dec 2019 03:22:31 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>, <shawn.lin@rock-chips.com>
Subject: [RFT PATCH 3/3] mmc: sdhci-of-arasan: Fix Command Queuing enable handling
Date:   Mon, 30 Dec 2019 14:53:43 +0530
Message-ID: <20191230092343.30692-4-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20191230092343.30692-1-faiz_abbas@ti.com>
References: <20191230092343.30692-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a need to dump data from the buffer before enabling command
queuing because of leftover data from tuning. Reset the data lines to
fix this at the source.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index e49b44b4d82e..1495ae72b902 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -376,22 +376,8 @@ static void sdhci_arasan_dumpregs(struct mmc_host *mmc)
 	sdhci_dumpregs(mmc_priv(mmc));
 }
 
-static void sdhci_arasan_cqe_enable(struct mmc_host *mmc)
-{
-	struct sdhci_host *host = mmc_priv(mmc);
-	u32 reg;
-
-	reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
-	while (reg & SDHCI_DATA_AVAILABLE) {
-		sdhci_readl(host, SDHCI_BUFFER);
-		reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
-	}
-
-	sdhci_cqe_enable(mmc);
-}
-
 static const struct cqhci_host_ops sdhci_arasan_cqhci_ops = {
-	.enable         = sdhci_arasan_cqe_enable,
+	.enable         = sdhci_cqe_enable,
 	.disable        = sdhci_cqe_disable,
 	.dumpregs       = sdhci_arasan_dumpregs,
 };
@@ -410,8 +396,9 @@ static const struct sdhci_ops sdhci_arasan_cqe_ops = {
 static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
 	.ops = &sdhci_arasan_cqe_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN	|
+		   SDHCI_QUIRK2_RESET_DATA_POST_TUNING	|
+		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 };
 
 static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
-- 
2.19.2

