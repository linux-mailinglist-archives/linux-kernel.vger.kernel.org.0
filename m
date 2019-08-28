Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABD4CA0096
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 13:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfH1LPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 07:15:48 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:36514 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfH1LPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:15:48 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x7SBF8HP005401;
        Wed, 28 Aug 2019 20:15:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x7SBF8HP005401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566990909;
        bh=MdtqdcsaYYtubyrph0eVlOgNKdl1skgOg+CqHwrAlBI=;
        h=From:To:Cc:Subject:Date:From;
        b=GflElf6h+dvtfciFao7F+P2gIOJLedbsXJT5Vd65bQqphG5BPKBHhf8ogZgp9pqxw
         8OapcO/+xmabw9r0t4r/t0XKm7NoFkO2aOS8YiaeQ+5PlJF+e83przEhH+igEiZuYx
         5kTi/VX+M45Cw3UchMm/OZZar2yzAqmIS9BgH2LKZNC0VSGYfvqxE72/VGbHF66pBB
         1YHIlYJPJQoVsTwJFeazWf37unbLhz2I6ZcG0ERQ52YlJn3nZwQDlW+TkI8VIUvSRT
         cowsq9jIyhkWU5ej5FAcBOGS+aRakF4xJHl1JW6b5erMUcqHgegyvWaJ0WSY4CNTmC
         LHxajcsg1rYuA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci: use lower/upper_32_bits() macros for DMA addresses
Date:   Wed, 28 Aug 2019 20:14:53 +0900
Message-Id: <20190828111453.4023-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the DMA addresses are casted to (u64) for the upper 32bits
to avoid "right shift count >= width of type" warning.

<linux/kernel.h> provides macros to address this, and the macro names
are self-documenting.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a5dc5aae973e..07144a195a9f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -668,10 +668,10 @@ void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
 	/* 32-bit and 64-bit descriptors have these members in same position */
 	dma_desc->cmd = cpu_to_le16(cmd);
 	dma_desc->len = cpu_to_le16(len);
-	dma_desc->addr_lo = cpu_to_le32((u32)addr);
+	dma_desc->addr_lo = cpu_to_le32(lower_32_bits(addr));
 
 	if (host->flags & SDHCI_USE_64_BIT_DMA)
-		dma_desc->addr_hi = cpu_to_le32((u64)addr >> 32);
+		dma_desc->addr_hi = cpu_to_le32(upper_32_bits(addr));
 
 	*desc += host->desc_sz;
 }
@@ -827,9 +827,10 @@ static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
 static void sdhci_set_sdma_addr(struct sdhci_host *host, dma_addr_t addr)
 {
 	if (host->v4_mode) {
-		sdhci_writel(host, addr, SDHCI_ADMA_ADDRESS);
+		sdhci_writel(host, lower_32_bits(addr), SDHCI_ADMA_ADDRESS);
 		if (host->flags & SDHCI_USE_64_BIT_DMA)
-			sdhci_writel(host, (u64)addr >> 32, SDHCI_ADMA_ADDRESS_HI);
+			sdhci_writel(host, upper_32_bits(addr),
+				     SDHCI_ADMA_ADDRESS_HI);
 	} else {
 		sdhci_writel(host, addr, SDHCI_DMA_ADDRESS);
 	}
@@ -1096,10 +1097,11 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 		} else if (host->flags & SDHCI_USE_ADMA) {
 			sdhci_adma_table_pre(host, data, sg_cnt);
 
-			sdhci_writel(host, host->adma_addr, SDHCI_ADMA_ADDRESS);
+			sdhci_writel(host, lower_32_bits(host->adma_addr),
+				     SDHCI_ADMA_ADDRESS);
 			if (host->flags & SDHCI_USE_64_BIT_DMA)
 				sdhci_writel(host,
-					     (u64)host->adma_addr >> 32,
+					     upper_32_bits(host->adma_addr),
 					     SDHCI_ADMA_ADDRESS_HI);
 		} else {
 			WARN_ON(sg_cnt != 1);
-- 
2.17.1

