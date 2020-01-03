Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADD812F27C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 02:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgACBDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 20:03:51 -0500
Received: from inva020.nxp.com ([92.121.34.13]:47438 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgACBDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:03:19 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ECDBE1A1B18;
        Fri,  3 Jan 2020 02:03:15 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DFD2F1A1B17;
        Fri,  3 Jan 2020 02:03:15 +0100 (CET)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 892C420567;
        Fri,  3 Jan 2020 02:03:15 +0100 (CET)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: [PATCH v2 09/10] crypto: caam - add crypto_engine support for RSA algorithms
Date:   Fri,  3 Jan 2020 03:02:52 +0200
Message-Id: <1578013373-1956-10-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1578013373-1956-1-git-send-email-iuliana.prodan@nxp.com>
References: <1578013373-1956-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto_engine support for RSA algorithms, to make use of
the engine queue.
The requests, with backlog flag, will be listed into crypto-engine
queue and processed by CAAM when free. In case the queue is empty,
the request is directly sent to CAAM.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/crypto/caam/caampkc.c | 144 ++++++++++++++++++++++++++++++++----------
 drivers/crypto/caam/caampkc.h |   8 +++
 2 files changed, 120 insertions(+), 32 deletions(-)

diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index 858cc95..82d5b55 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -118,19 +118,28 @@ static void rsa_pub_done(struct device *dev, u32 *desc, u32 err, void *context)
 {
 	struct caam_akcipher_request_entry *jrentry = context;
 	struct akcipher_request *req = jrentry->base;
+	struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
+	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
 	struct rsa_edesc *edesc;
 	int ecode = 0;
 
 	if (err)
 		ecode = caam_jr_strstatus(dev, err);
 
-	edesc = container_of(desc, struct rsa_edesc, hw_desc[0]);
+	edesc = req_ctx->edesc;
 
 	rsa_pub_unmap(dev, edesc, req);
 	rsa_io_unmap(dev, edesc, req);
 	kfree(edesc);
 
-	akcipher_request_complete(req, ecode);
+	/*
+	 * If no backlog flag, the completion of the request is done
+	 * by CAAM, not crypto engine.
+	 */
+	if (!jrentry->bklog)
+		akcipher_request_complete(req, ecode);
+	else
+		crypto_finalize_akcipher_request(jrp->engine, req, ecode);
 }
 
 static void rsa_priv_f_done(struct device *dev, u32 *desc, u32 err,
@@ -139,15 +148,17 @@ static void rsa_priv_f_done(struct device *dev, u32 *desc, u32 err,
 	struct caam_akcipher_request_entry *jrentry = context;
 	struct akcipher_request *req = jrentry->base;
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
 	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
 	struct caam_rsa_key *key = &ctx->key;
+	struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
 	struct rsa_edesc *edesc;
 	int ecode = 0;
 
 	if (err)
 		ecode = caam_jr_strstatus(dev, err);
 
-	edesc = container_of(desc, struct rsa_edesc, hw_desc[0]);
+	edesc = req_ctx->edesc;
 
 	switch (key->priv_form) {
 	case FORM1:
@@ -163,7 +174,14 @@ static void rsa_priv_f_done(struct device *dev, u32 *desc, u32 err,
 	rsa_io_unmap(dev, edesc, req);
 	kfree(edesc);
 
-	akcipher_request_complete(req, ecode);
+	/*
+	 * If no backlog flag, the completion of the request is done
+	 * by CAAM, not crypto engine.
+	 */
+	if (!jrentry->bklog)
+		akcipher_request_complete(req, ecode);
+	else
+		crypto_finalize_akcipher_request(jrp->engine, req, ecode);
 }
 
 /**
@@ -312,6 +330,7 @@ static struct rsa_edesc *rsa_edesc_alloc(struct akcipher_request *req,
 	edesc->dst_nents = dst_nents;
 
 	edesc->jrentry.base = req;
+	req_ctx->edesc = edesc;
 
 	if (!sec4_sg_bytes)
 		return edesc;
@@ -343,6 +362,36 @@ static struct rsa_edesc *rsa_edesc_alloc(struct akcipher_request *req,
 	return ERR_PTR(-ENOMEM);
 }
 
+static int akcipher_do_one_req(struct crypto_engine *engine, void *areq)
+{
+	struct akcipher_request *req = container_of(areq,
+						    struct akcipher_request,
+						    base);
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_akcipher_request_entry *jrentry;
+	struct device *jrdev = ctx->dev;
+	u32 *desc = req_ctx->edesc->hw_desc;
+	int ret;
+
+	jrentry = &req_ctx->edesc->jrentry;
+	jrentry->bklog = true;
+
+	ret = caam_jr_enqueue(jrdev, desc, req_ctx->akcipher_op_done,
+			      jrentry);
+
+	if (ret != -EINPROGRESS) {
+		rsa_pub_unmap(jrdev, req_ctx->edesc, req);
+		rsa_io_unmap(jrdev, req_ctx->edesc, req);
+		kfree(req_ctx->edesc);
+	} else {
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static int set_rsa_pub_pdb(struct akcipher_request *req,
 			   struct rsa_edesc *edesc)
 {
@@ -606,10 +655,50 @@ static int set_rsa_priv_f3_pdb(struct akcipher_request *req,
 	return -ENOMEM;
 }
 
+static int akcipher_enqueue_req(struct device *jrdev, u32 *desc,
+				void (*cbk)(struct device *jrdev, u32 *desc,
+					    u32 err, void *context),
+				struct akcipher_request *req,
+				struct rsa_edesc *edesc)
+{
+	struct caam_drv_private_jr *jrpriv = dev_get_drvdata(jrdev);
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_key *key = &ctx->key;
+	int ret;
+
+	if (req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)
+		return crypto_transfer_akcipher_request_to_engine(jrpriv->engine,
+								  req);
+	else
+		ret = caam_jr_enqueue(jrdev, desc, cbk, &edesc->jrentry);
+
+	if (ret != -EINPROGRESS) {
+		switch (key->priv_form) {
+		case FORM1:
+			rsa_priv_f1_unmap(jrdev, edesc, req);
+			break;
+		case FORM2:
+			rsa_priv_f2_unmap(jrdev, edesc, req);
+			break;
+		case FORM3:
+			rsa_priv_f3_unmap(jrdev, edesc, req);
+			break;
+		default:
+			rsa_pub_unmap(jrdev, edesc, req);
+		}
+		rsa_io_unmap(jrdev, edesc, req);
+		kfree(edesc);
+	}
+
+	return ret;
+}
+
 static int caam_rsa_enc(struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
 	struct caam_rsa_key *key = &ctx->key;
 	struct device *jrdev = ctx->dev;
 	struct rsa_edesc *edesc;
@@ -637,13 +726,9 @@ static int caam_rsa_enc(struct akcipher_request *req)
 	/* Initialize Job Descriptor */
 	init_rsa_pub_desc(edesc->hw_desc, &edesc->pdb.pub);
 
-	ret = caam_jr_enqueue(jrdev, edesc->hw_desc, rsa_pub_done,
-			      &edesc->jrentry);
-	if (ret == -EINPROGRESS)
-		return ret;
-
-	rsa_pub_unmap(jrdev, edesc, req);
-
+	req_ctx->akcipher_op_done = rsa_pub_done;
+	return akcipher_enqueue_req(jrdev, edesc->hw_desc, rsa_pub_done,
+				    req, edesc);
 init_fail:
 	rsa_io_unmap(jrdev, edesc, req);
 	kfree(edesc);
@@ -654,6 +739,7 @@ static int caam_rsa_dec_priv_f1(struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
 	struct device *jrdev = ctx->dev;
 	struct rsa_edesc *edesc;
 	int ret;
@@ -671,13 +757,9 @@ static int caam_rsa_dec_priv_f1(struct akcipher_request *req)
 	/* Initialize Job Descriptor */
 	init_rsa_priv_f1_desc(edesc->hw_desc, &edesc->pdb.priv_f1);
 
-	ret = caam_jr_enqueue(jrdev, edesc->hw_desc, rsa_priv_f_done,
-			      &edesc->jrentry);
-	if (ret == -EINPROGRESS)
-		return ret;
-
-	rsa_priv_f1_unmap(jrdev, edesc, req);
-
+	req_ctx->akcipher_op_done = rsa_priv_f_done;
+	return akcipher_enqueue_req(jrdev, edesc->hw_desc, rsa_priv_f_done,
+				    req, edesc);
 init_fail:
 	rsa_io_unmap(jrdev, edesc, req);
 	kfree(edesc);
@@ -688,6 +770,7 @@ static int caam_rsa_dec_priv_f2(struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
 	struct device *jrdev = ctx->dev;
 	struct rsa_edesc *edesc;
 	int ret;
@@ -705,13 +788,9 @@ static int caam_rsa_dec_priv_f2(struct akcipher_request *req)
 	/* Initialize Job Descriptor */
 	init_rsa_priv_f2_desc(edesc->hw_desc, &edesc->pdb.priv_f2);
 
-	ret = caam_jr_enqueue(jrdev, edesc->hw_desc, rsa_priv_f_done,
-			      &edesc->jrentry);
-	if (ret == -EINPROGRESS)
-		return ret;
-
-	rsa_priv_f2_unmap(jrdev, edesc, req);
-
+	req_ctx->akcipher_op_done = rsa_priv_f_done;
+	return akcipher_enqueue_req(jrdev, edesc->hw_desc, rsa_priv_f_done,
+				    req, edesc);
 init_fail:
 	rsa_io_unmap(jrdev, edesc, req);
 	kfree(edesc);
@@ -722,6 +801,7 @@ static int caam_rsa_dec_priv_f3(struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
 	struct device *jrdev = ctx->dev;
 	struct rsa_edesc *edesc;
 	int ret;
@@ -739,13 +819,9 @@ static int caam_rsa_dec_priv_f3(struct akcipher_request *req)
 	/* Initialize Job Descriptor */
 	init_rsa_priv_f3_desc(edesc->hw_desc, &edesc->pdb.priv_f3);
 
-	ret = caam_jr_enqueue(jrdev, edesc->hw_desc, rsa_priv_f_done,
-			      &edesc->jrentry);
-	if (ret == -EINPROGRESS)
-		return ret;
-
-	rsa_priv_f3_unmap(jrdev, edesc, req);
-
+	req_ctx->akcipher_op_done = rsa_priv_f_done;
+	return akcipher_enqueue_req(jrdev, edesc->hw_desc, rsa_priv_f_done,
+				    req, edesc);
 init_fail:
 	rsa_io_unmap(jrdev, edesc, req);
 	kfree(edesc);
@@ -1037,6 +1113,10 @@ static int caam_rsa_init_tfm(struct crypto_akcipher *tfm)
 		return -ENOMEM;
 	}
 
+	ctx->enginectx.op.do_one_request = akcipher_do_one_req;
+
+	akcipher_set_reqsize(tfm, sizeof(struct caam_rsa_req_ctx));
+
 	return 0;
 }
 
diff --git a/drivers/crypto/caam/caampkc.h b/drivers/crypto/caam/caampkc.h
index e0b1076..8e6d7e0 100644
--- a/drivers/crypto/caam/caampkc.h
+++ b/drivers/crypto/caam/caampkc.h
@@ -13,6 +13,7 @@
 #include "compat.h"
 #include "intern.h"
 #include "pdb.h"
+#include <crypto/engine.h>
 
 /**
  * caam_priv_key_form - CAAM RSA private key representation
@@ -88,11 +89,13 @@ struct caam_rsa_key {
 
 /**
  * caam_rsa_ctx - per session context.
+ * @enginectx   : crypto engine context
  * @key         : RSA key in DMA zone
  * @dev         : device structure
  * @padding_dma : dma address of padding, for adding it to the input
  */
 struct caam_rsa_ctx {
+	struct crypto_engine_ctx enginectx;
 	struct caam_rsa_key key;
 	struct device *dev;
 	dma_addr_t padding_dma;
@@ -104,11 +107,16 @@ struct caam_rsa_ctx {
  * @src           : input scatterlist (stripped of leading zeros)
  * @fixup_src     : input scatterlist (that might be stripped of leading zeros)
  * @fixup_src_len : length of the fixup_src input scatterlist
+ * @edesc         : s/w-extended rsa descriptor
+ * @akcipher_op_done : callback used when operation is done
  */
 struct caam_rsa_req_ctx {
 	struct scatterlist src[2];
 	struct scatterlist *fixup_src;
 	unsigned int fixup_src_len;
+	struct rsa_edesc *edesc;
+	void (*akcipher_op_done)(struct device *jrdev, u32 *desc, u32 err,
+				 void *context);
 };
 
 /*
-- 
2.1.0

