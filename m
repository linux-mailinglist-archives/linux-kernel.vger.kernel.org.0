Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446AD34A77
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 16:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfFDOaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 10:30:35 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52946 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfFDOab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559658629; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1QQEOmDDU0lF3sOmTDK7Taw+rmxXkskpHPmXe+jtxY=;
        b=wZzQdAKFbRPH0nOXG/+14KslEO3nMsRwNEtz03y5UL9+HOPwyHAIYltkrxE0MiBpD4/+nv
        uAluxIU7aAyMk10qFVoUzrqgOW/cAHNhyzW+aoteyDCQZPrPQAoao8M8Hu79FevdFUg9ry
        KCCQ3L+dl4PtMkkUXtLtdpuaG2ZVCgU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
Subject: [RE-RESEND PATCH v3 4/4] memory: jz4780_nemc: Add support for the JZ4740
Date:   Tue,  4 Jun 2019 16:30:18 +0200
Message-Id: <20190604143018.11644-4-paul@crapouillou.net>
In-Reply-To: <20190604143018.11644-1-paul@crapouillou.net>
References: <20190604143018.11644-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the JZ4740 SoC from Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---

Notes:
    v2: No change
    
    v3: Support the JZ4740 instead of the JZ4725B (exact same functionality
        but JZ4740 is already fully upstream)

 drivers/memory/jz4780-nemc.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
index 66b8b43eaeff..f3a19b9b76ac 100644
--- a/drivers/memory/jz4780-nemc.c
+++ b/drivers/memory/jz4780-nemc.c
@@ -44,9 +44,14 @@
 #define NEMC_NFCSR_NFCEn(n)	BIT((((n) - 1) << 1) + 1)
 #define NEMC_NFCSR_TNFEn(n)	BIT(16 + (n) - 1)
 
+struct jz_soc_info {
+	u8 tas_tah_cycles_max;
+};
+
 struct jz4780_nemc {
 	spinlock_t lock;
 	struct device *dev;
+	const struct jz_soc_info *soc_info;
 	void __iomem *base;
 	struct clk *clk;
 	uint32_t clk_period;
@@ -202,7 +207,7 @@ static bool jz4780_nemc_configure_bank(struct jz4780_nemc *nemc,
 	if (of_property_read_u32(node, "ingenic,nemc-tAS", &val) == 0) {
 		smcr &= ~NEMC_SMCR_TAS_MASK;
 		cycles = jz4780_nemc_ns_to_cycles(nemc, val);
-		if (cycles > 15) {
+		if (cycles > nemc->soc_info->tas_tah_cycles_max) {
 			dev_err(nemc->dev, "tAS %u is too high (%u cycles)\n",
 				val, cycles);
 			return false;
@@ -214,7 +219,7 @@ static bool jz4780_nemc_configure_bank(struct jz4780_nemc *nemc,
 	if (of_property_read_u32(node, "ingenic,nemc-tAH", &val) == 0) {
 		smcr &= ~NEMC_SMCR_TAH_MASK;
 		cycles = jz4780_nemc_ns_to_cycles(nemc, val);
-		if (cycles > 15) {
+		if (cycles > nemc->soc_info->tas_tah_cycles_max) {
 			dev_err(nemc->dev, "tAH %u is too high (%u cycles)\n",
 				val, cycles);
 			return false;
@@ -278,6 +283,10 @@ static int jz4780_nemc_probe(struct platform_device *pdev)
 	if (!nemc)
 		return -ENOMEM;
 
+	nemc->soc_info = device_get_match_data(dev);
+	if (!nemc->soc_info)
+		return -EINVAL;
+
 	spin_lock_init(&nemc->lock);
 	nemc->dev = dev;
 
@@ -370,8 +379,17 @@ static int jz4780_nemc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct jz_soc_info jz4740_soc_info = {
+	.tas_tah_cycles_max = 7,
+};
+
+static const struct jz_soc_info jz4780_soc_info = {
+	.tas_tah_cycles_max = 15,
+};
+
 static const struct of_device_id jz4780_nemc_dt_match[] = {
-	{ .compatible = "ingenic,jz4780-nemc" },
+	{ .compatible = "ingenic,jz4740-nemc", .data = &jz4740_soc_info, },
+	{ .compatible = "ingenic,jz4780-nemc", .data = &jz4780_soc_info, },
 	{},
 };
 
-- 
2.21.0.593.g511ec345e18

