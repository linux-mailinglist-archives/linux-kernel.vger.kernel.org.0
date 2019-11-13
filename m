Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21536FAD10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 10:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfKMJfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 04:35:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47520 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfKMJfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:35:21 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAD9Z8pX120169;
        Wed, 13 Nov 2019 03:35:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573637708;
        bh=u3ZvJsFOOfO8a0rAzgmvXe0foFjNhQpaW0ZsCfur1kw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bn7l0zfNnZ8KC8BrugwAGVFgVIdZalaFTGg9uLrXOOvAW56pIu7/5UpSqQaM9YPBB
         YkYcxCd1OXO7O4qbbwFCGsXIIqVWIVlt4RaL+7wRcwEmjJiB5AHj0l2ZlvfRe2kgwC
         Oc4sjAEheYmA2JJAoVaqrsski1WLpcR1YCckrAbM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9Z8s4051456;
        Wed, 13 Nov 2019 03:35:08 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 03:34:50 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 03:34:50 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9Z0hV086866;
        Wed, 13 Nov 2019 03:35:06 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <ulf.hansson@linaro.org>, <ludovic.desroches@microchip.com>
CC:     <vkoul@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] mmc: moxart: Use dma_request_chan() directly for channel request
Date:   Wed, 13 Nov 2019 11:36:16 +0200
Message-ID: <20191113093616.32474-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113093616.32474-1-peter.ujfalusi@ti.com>
References: <20191113093616.32474-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_request_slave_channel_reason() is:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mmc/host/moxart-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index a0670e9cd012..fc6b9cf27d0b 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -608,8 +608,8 @@ static int moxart_probe(struct platform_device *pdev)
 	host->timeout = msecs_to_jiffies(1000);
 	host->sysclk = clk_get_rate(clk);
 	host->fifo_width = readl(host->base + REG_FEATURE) << 2;
-	host->dma_chan_tx = dma_request_slave_channel_reason(dev, "tx");
-	host->dma_chan_rx = dma_request_slave_channel_reason(dev, "rx");
+	host->dma_chan_tx = dma_request_chan(dev, "tx");
+	host->dma_chan_rx = dma_request_chan(dev, "rx");
 
 	spin_lock_init(&host->lock);
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

