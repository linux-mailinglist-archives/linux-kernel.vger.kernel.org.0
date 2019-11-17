Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E143FFFC08
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 23:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfKQWbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 17:31:35 -0500
Received: from inva020.nxp.com ([92.121.34.13]:57008 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfKQWbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 17:31:08 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 77FE21A0D15;
        Sun, 17 Nov 2019 23:31:06 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6AF511A0D11;
        Sun, 17 Nov 2019 23:31:06 +0100 (CET)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0577320395;
        Sun, 17 Nov 2019 23:31:05 +0100 (CET)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx <linux-imx@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: [PATCH 09/12] crypto: caam - bypass crypto-engine sw queue, if empty
Date:   Mon, 18 Nov 2019 00:30:42 +0200
Message-Id: <1574029845-22796-10-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1574029845-22796-1-git-send-email-iuliana.prodan@nxp.com>
References: <1574029845-22796-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bypass crypto-engine software queue, if empty, and send the request
directly to hardware. If this returns -ENOSPC, transfer the request to
crypto-engine and let it handle it.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/crypto/caam/jr.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 5c55d3d..ddf3d39 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -476,10 +476,33 @@ int caam_jr_enqueue(struct device *dev, u32 *desc,
 	struct caam_drv_private_jr *jrpriv = dev_get_drvdata(dev);
 	struct caam_jr_request_entry *jrentry = areq;
 	struct crypto_async_request *req = jrentry->base;
+	int ret;
 
-	if (req->flags & CRYPTO_TFM_REQ_MAY_BACKLOG)
-		return transfer_request_to_engine(jrpriv->engine, req);
-
+	if (req->flags & CRYPTO_TFM_REQ_MAY_BACKLOG) {
+		if (crypto_queue_len(&jrpriv->engine->queue) == 0) {
+			/*
+			 * send the request to CAAM, if crypto-engine queue
+			 * is empty
+			 */
+			ret = caam_jr_enqueue_no_bklog(dev, desc, cbk, jrentry);
+			if (ret == -ENOSPC)
+				/*
+				 * CAAM has no space, so transfer the request
+				 * to crypto-engine
+				 */
+				return transfer_request_to_engine(jrpriv->engine,
+								  req);
+			else
+				return ret;
+		} else {
+			/*
+			 * crypto-engine queue is not empty, so transfer the
+			 * request to crypto-engine, to keep the order
+			 * of requests
+			 */
+			return transfer_request_to_engine(jrpriv->engine, req);
+		}
+	}
 	return caam_jr_enqueue_no_bklog(dev, desc, cbk, jrentry);
 }
 EXPORT_SYMBOL(caam_jr_enqueue);
-- 
2.1.0

