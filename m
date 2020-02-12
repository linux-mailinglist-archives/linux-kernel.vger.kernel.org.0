Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4FFD15AF3B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 18:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgBLRz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 12:55:57 -0500
Received: from inva020.nxp.com ([92.121.34.13]:35730 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbgBLRzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:55:55 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A16C1A7A82;
        Wed, 12 Feb 2020 18:55:53 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3D36B1C27C5;
        Wed, 12 Feb 2020 18:55:53 +0100 (CET)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C8763204D3;
        Wed, 12 Feb 2020 18:55:52 +0100 (CET)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: [PATCH v6 4/9] crypto: caam - refactor RSA private key _done callbacks
Date:   Wed, 12 Feb 2020 19:55:19 +0200
Message-Id: <1581530124-9135-5-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1581530124-9135-1-git-send-email-iuliana.prodan@nxp.com>
References: <1581530124-9135-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a common rsa_priv_f_done function, which based
on private key form calls the specific unmap function.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
---
 drivers/crypto/caam/caampkc.c | 61 +++++++++++++------------------------------
 1 file changed, 18 insertions(+), 43 deletions(-)

diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index 6619c51..ebf1677 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -132,29 +132,13 @@ static void rsa_pub_done(struct device *dev, u32 *desc, u32 err, void *context)
 	akcipher_request_complete(req, ecode);
 }
 
-static void rsa_priv_f1_done(struct device *dev, u32 *desc, u32 err,
-			     void *context)
-{
-	struct akcipher_request *req = context;
-	struct rsa_edesc *edesc;
-	int ecode = 0;
-
-	if (err)
-		ecode = caam_jr_strstatus(dev, err);
-
-	edesc = container_of(desc, struct rsa_edesc, hw_desc[0]);
-
-	rsa_priv_f1_unmap(dev, edesc, req);
-	rsa_io_unmap(dev, edesc, req);
-	kfree(edesc);
-
-	akcipher_request_complete(req, ecode);
-}
-
-static void rsa_priv_f2_done(struct device *dev, u32 *desc, u32 err,
-			     void *context)
+static void rsa_priv_f_done(struct device *dev, u32 *desc, u32 err,
+			    void *context)
 {
 	struct akcipher_request *req = context;
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_key *key = &ctx->key;
 	struct rsa_edesc *edesc;
 	int ecode = 0;
 
@@ -163,26 +147,17 @@ static void rsa_priv_f2_done(struct device *dev, u32 *desc, u32 err,
 
 	edesc = container_of(desc, struct rsa_edesc, hw_desc[0]);
 
-	rsa_priv_f2_unmap(dev, edesc, req);
-	rsa_io_unmap(dev, edesc, req);
-	kfree(edesc);
-
-	akcipher_request_complete(req, ecode);
-}
-
-static void rsa_priv_f3_done(struct device *dev, u32 *desc, u32 err,
-			     void *context)
-{
-	struct akcipher_request *req = context;
-	struct rsa_edesc *edesc;
-	int ecode = 0;
-
-	if (err)
-		ecode = caam_jr_strstatus(dev, err);
-
-	edesc = container_of(desc, struct rsa_edesc, hw_desc[0]);
+	switch (key->priv_form) {
+	case FORM1:
+		rsa_priv_f1_unmap(dev, edesc, req);
+		break;
+	case FORM2:
+		rsa_priv_f2_unmap(dev, edesc, req);
+		break;
+	case FORM3:
+		rsa_priv_f3_unmap(dev, edesc, req);
+	}
 
-	rsa_priv_f3_unmap(dev, edesc, req);
 	rsa_io_unmap(dev, edesc, req);
 	kfree(edesc);
 
@@ -691,7 +666,7 @@ static int caam_rsa_dec_priv_f1(struct akcipher_request *req)
 	/* Initialize Job Descriptor */
 	init_rsa_priv_f1_desc(edesc->hw_desc, &edesc->pdb.priv_f1);
 
-	ret = caam_jr_enqueue(jrdev, edesc->hw_desc, rsa_priv_f1_done, req);
+	ret = caam_jr_enqueue(jrdev, edesc->hw_desc, rsa_priv_f_done, req);
 	if (!ret)
 		return -EINPROGRESS;
 
@@ -724,7 +699,7 @@ static int caam_rsa_dec_priv_f2(struct akcipher_request *req)
 	/* Initialize Job Descriptor */
 	init_rsa_priv_f2_desc(edesc->hw_desc, &edesc->pdb.priv_f2);
 
-	ret = caam_jr_enqueue(jrdev, edesc->hw_desc, rsa_priv_f2_done, req);
+	ret = caam_jr_enqueue(jrdev, edesc->hw_desc, rsa_priv_f_done, req);
 	if (!ret)
 		return -EINPROGRESS;
 
@@ -757,7 +732,7 @@ static int caam_rsa_dec_priv_f3(struct akcipher_request *req)
 	/* Initialize Job Descriptor */
 	init_rsa_priv_f3_desc(edesc->hw_desc, &edesc->pdb.priv_f3);
 
-	ret = caam_jr_enqueue(jrdev, edesc->hw_desc, rsa_priv_f3_done, req);
+	ret = caam_jr_enqueue(jrdev, edesc->hw_desc, rsa_priv_f_done, req);
 	if (!ret)
 		return -EINPROGRESS;
 
-- 
2.1.0

