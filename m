Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C7517BA7E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 11:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCFKjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 05:39:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:44310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbgCFKj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:39:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7C308B230;
        Fri,  6 Mar 2020 10:39:26 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, f.fainelli@gmail.com, phil@raspberrypi.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] mmc: sdhci: am654: Use quirk instead of custom set_power()
Date:   Fri,  6 Mar 2020 11:38:52 +0100
Message-Id: <20200306103857.23962-8-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306103857.23962-1-nsaenzjulienne@suse.de>
References: <20200306103857.23962-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of SDHCI_QUIRK2_SET_BUS_VOLTAGE there is no need
to use a custom set_power() implementation as the quirk takes care of
configuring the bus voltage register even when powering trough a
regulator.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/mmc/host/sdhci_am654.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 58183b5f4e82..4629596da86a 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -255,17 +255,6 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	sdhci_set_clock(host, clock);
 }
 
-static void sdhci_am654_set_power(struct sdhci_host *host, unsigned char mode,
-				  unsigned short vdd)
-{
-	if (!IS_ERR(host->mmc->supply.vmmc)) {
-		struct mmc_host *mmc = host->mmc;
-
-		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
-	}
-	sdhci_set_power_noreg(host, mode, vdd);
-}
-
 static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
 {
 	unsigned char timing = host->mmc->ios.timing;
@@ -321,7 +310,6 @@ static struct sdhci_ops sdhci_am654_ops = {
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 	.set_bus_width = sdhci_set_bus_width,
-	.set_power = sdhci_am654_set_power,
 	.set_clock = sdhci_am654_set_clock,
 	.write_b = sdhci_am654_write_b,
 	.irq = sdhci_am654_cqhci_irq,
@@ -331,7 +319,8 @@ static struct sdhci_ops sdhci_am654_ops = {
 static const struct sdhci_pltfm_data sdhci_am654_pdata = {
 	.ops = &sdhci_am654_ops,
 	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_SET_BUS_VOLTAGE,
 };
 
 static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
@@ -344,7 +333,6 @@ static struct sdhci_ops sdhci_j721e_8bit_ops = {
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 	.set_bus_width = sdhci_set_bus_width,
-	.set_power = sdhci_am654_set_power,
 	.set_clock = sdhci_am654_set_clock,
 	.write_b = sdhci_am654_write_b,
 	.irq = sdhci_am654_cqhci_irq,
@@ -354,7 +342,8 @@ static struct sdhci_ops sdhci_j721e_8bit_ops = {
 static const struct sdhci_pltfm_data sdhci_j721e_8bit_pdata = {
 	.ops = &sdhci_j721e_8bit_ops,
 	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_SET_BUS_VOLTAGE,
 };
 
 static const struct sdhci_am654_driver_data sdhci_j721e_8bit_drvdata = {
@@ -367,7 +356,6 @@ static struct sdhci_ops sdhci_j721e_4bit_ops = {
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 	.set_bus_width = sdhci_set_bus_width,
-	.set_power = sdhci_am654_set_power,
 	.set_clock = sdhci_j721e_4bit_set_clock,
 	.write_b = sdhci_am654_write_b,
 	.irq = sdhci_am654_cqhci_irq,
@@ -377,7 +365,8 @@ static struct sdhci_ops sdhci_j721e_4bit_ops = {
 static const struct sdhci_pltfm_data sdhci_j721e_4bit_pdata = {
 	.ops = &sdhci_j721e_4bit_ops,
 	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_SET_BUS_VOLTAGE,
 };
 
 static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
-- 
2.25.1

