Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D32B105041
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 11:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfKUKQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 05:16:22 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39814 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUKQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:16:20 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xALAG9EA088314;
        Thu, 21 Nov 2019 04:16:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574331369;
        bh=XnVgtIGZIbTs/l5ZJ/zrcJQ2aeyG9tflJUgP5IVOAAQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=s3lSlrmLeVGp/iGr5GEC3Gj8QRQESu7/ZJSbhrsVlrlzNWHGxe8Gi5cfy0A9HAWjy
         +2U9596E6gyv4xQxZPGQ4oS1g2wr3cA99JDoA6zGI6R1hFy5LJXmQB/8GKEkkPMM0S
         AO/AU2CQUfVas4/08myLQmhN/y5GTKPD2N9suXe4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xALAG81b010703
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Nov 2019 04:16:09 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 21
 Nov 2019 04:16:08 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 21 Nov 2019 04:16:08 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xALAG3b5105173;
        Thu, 21 Nov 2019 04:16:06 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <vkoul@kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] crypto: atmel-aes - Retire dma_request_slave_channel_compat()
Date:   Thu, 21 Nov 2019 12:16:00 +0200
Message-ID: <20191121101602.21941-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191121101602.21941-1-peter.ujfalusi@ti.com>
References: <20191121101602.21941-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver no longer boots in legacy mode, only via DT. This makes the
dma_request_slave_channel_compat() redundant.
If ever the filter function would be executed it will return false as the
dma_slave is not really initialized.

Switch to use dma_request_chan() which would allow legacy boot if ever
needed again by configuring dma_slave_map for the DMA driver.

At the same time skip allocating memory for dma_slave as it is not used
anymore.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/crypto/atmel-aes.c | 50 ++++++++------------------------------
 1 file changed, 10 insertions(+), 40 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 3c88c164c3dc..30c41598fa2a 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -38,7 +38,6 @@
 #include <crypto/internal/aead.h>
 #include <crypto/internal/skcipher.h>
 #include <linux/platform_data/crypto-atmel.h>
-#include <dt-bindings/dma/at91.h>
 #include "atmel-aes-regs.h"
 #include "atmel-authenc.h"
 
@@ -2364,39 +2363,23 @@ static void atmel_aes_buff_cleanup(struct atmel_aes_dev *dd)
 	free_page((unsigned long)dd->buf);
 }
 
-static bool atmel_aes_filter(struct dma_chan *chan, void *slave)
-{
-	struct at_dma_slave	*sl = slave;
-
-	if (sl && sl->dma_dev == chan->device->dev) {
-		chan->private = sl;
-		return true;
-	} else {
-		return false;
-	}
-}
-
 static int atmel_aes_dma_init(struct atmel_aes_dev *dd,
 			      struct crypto_platform_data *pdata)
 {
-	struct at_dma_slave *slave;
-	dma_cap_mask_t mask;
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
+	int ret;
 
 	/* Try to grab 2 DMA channels */
-	slave = &pdata->dma_slave->rxdata;
-	dd->src.chan = dma_request_slave_channel_compat(mask, atmel_aes_filter,
-							slave, dd->dev, "tx");
-	if (!dd->src.chan)
+	dd->src.chan = dma_request_chan(dd->dev, "tx");
+	if (IS_ERR(dd->src.chan)) {
+		ret = PTR_ERR(dd->src.chan);
 		goto err_dma_in;
+	}
 
-	slave = &pdata->dma_slave->txdata;
-	dd->dst.chan = dma_request_slave_channel_compat(mask, atmel_aes_filter,
-							slave, dd->dev, "rx");
-	if (!dd->dst.chan)
+	dd->dst.chan = dma_request_chan(dd->dev, "rx");
+	if (IS_ERR(dd->dst.chan)) {
+		ret = PTR_ERR(dd->dst.chan);
 		goto err_dma_out;
+	}
 
 	return 0;
 
@@ -2404,7 +2387,7 @@ static int atmel_aes_dma_init(struct atmel_aes_dev *dd,
 	dma_release_channel(dd->src.chan);
 err_dma_in:
 	dev_warn(dd->dev, "no DMA channel available\n");
-	return -ENODEV;
+	return ret;
 }
 
 static void atmel_aes_dma_cleanup(struct atmel_aes_dev *dd)
@@ -2592,14 +2575,6 @@ static struct crypto_platform_data *atmel_aes_of_init(struct platform_device *pd
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
-	pdata->dma_slave = devm_kzalloc(&pdev->dev,
-					sizeof(*(pdata->dma_slave)),
-					GFP_KERNEL);
-	if (!pdata->dma_slave) {
-		devm_kfree(&pdev->dev, pdata);
-		return ERR_PTR(-ENOMEM);
-	}
-
 	return pdata;
 }
 #else
@@ -2626,11 +2601,6 @@ static int atmel_aes_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (!pdata->dma_slave) {
-		err = -ENXIO;
-		goto aes_dd_err;
-	}
-
 	aes_dd = devm_kzalloc(&pdev->dev, sizeof(*aes_dd), GFP_KERNEL);
 	if (aes_dd == NULL) {
 		err = -ENOMEM;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

