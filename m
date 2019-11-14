Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60B16FAC91
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 10:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKMJIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 04:08:44 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43178 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfKMJIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:08:44 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAD98YBY110423;
        Wed, 13 Nov 2019 03:08:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573636114;
        bh=L5yB4sXWEphH1kS7OcR6nTpRGX5u3VDhE7QxjQRUxHE=;
        h=From:To:CC:Subject:Date;
        b=GhR8/TA859CcTnzUuhfN9dTXPmy3KXv1W/ZOobZE5qndfQgLlqh+E0IvcwnFwy2Me
         4bQ5Qag9PEda47sL1JDzukOdiic8zchmkLBtablkO5ahaeKeFl96giy6VV0ilQNUS6
         zFDsmDqN+m6tHqlR6l4I47MmvkiTyBWDkbEkv4zw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD98Ykh006184;
        Wed, 13 Nov 2019 03:08:34 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 03:08:16 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 03:08:15 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD98V6k008708;
        Wed, 13 Nov 2019 03:08:32 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <vkoul@kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: qce/dma - Use dma_request_chan() directly for channel request
Date:   Wed, 13 Nov 2019 11:09:47 +0200
Message-ID: <20191113090947.28499-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
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
 drivers/crypto/qce/dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 0984a719144d..40a59214d2e1 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -12,11 +12,11 @@ int qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 {
 	int ret;
 
-	dma->txchan = dma_request_slave_channel_reason(dev, "tx");
+	dma->txchan = dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->txchan))
 		return PTR_ERR(dma->txchan);
 
-	dma->rxchan = dma_request_slave_channel_reason(dev, "rx");
+	dma->rxchan = dma_request_chan(dev, "rx");
 	if (IS_ERR(dma->rxchan)) {
 		ret = PTR_ERR(dma->rxchan);
 		goto error_rx;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

