Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9D9914D4CF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 01:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgA3At7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 19:49:59 -0500
Received: from inva020.nxp.com ([92.121.34.13]:42310 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbgA3Ats (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 19:49:48 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8E1901A169F;
        Thu, 30 Jan 2020 01:49:46 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 80B3B1A1428;
        Thu, 30 Jan 2020 01:49:46 +0100 (CET)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 22828204BE;
        Thu, 30 Jan 2020 01:49:46 +0100 (CET)
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
Subject: [PATCH v5 7/9] crypto: caam - add crypto_engine support for AEAD algorithms
Date:   Thu, 30 Jan 2020 02:49:22 +0200
Message-Id: <1580345364-7606-8-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1580345364-7606-1-git-send-email-iuliana.prodan@nxp.com>
References: <1580345364-7606-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto_engine support for AEAD algorithms, to make use of
the engine queue.
The requests, with backlog flag, will be listed into crypto-engine
queue and processed by CAAM when free.
If sending just the backlog request to crypto-engine, and non-blocking
directly to CAAM, the latter requests have a better chance to be
executed since JR has up to 1024 entries, more than the 10 entries
from crypto-engine.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/crypto/caam/caamalg.c | 108 ++++++++++++++++++++++++++++++------------
 1 file changed, 78 insertions(+), 30 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index 909d6d6..58a1abb 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -120,6 +120,10 @@ struct caam_skcipher_req_ctx {
 	struct skcipher_edesc *edesc;
 };
 
+struct caam_aead_req_ctx {
+	struct aead_edesc *edesc;
+};
+
 static int aead_null_set_sh_desc(struct crypto_aead *aead)
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(aead);
@@ -864,6 +868,7 @@ static int xts_skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
  * @mapped_src_nents: number of segments in input h/w link table
  * @mapped_dst_nents: number of segments in output h/w link table
  * @sec4_sg_bytes: length of dma mapped sec4_sg space
+ * @bklog: stored to determine if the request needs backlog
  * @sec4_sg_dma: bus physical mapped address of h/w link table
  * @sec4_sg: pointer to h/w link table
  * @hw_desc: the h/w job descriptor followed by any referenced link tables
@@ -874,6 +879,7 @@ struct aead_edesc {
 	int mapped_src_nents;
 	int mapped_dst_nents;
 	int sec4_sg_bytes;
+	bool bklog;
 	dma_addr_t sec4_sg_dma;
 	struct sec4_sg_entry *sec4_sg;
 	u32 hw_desc[];
@@ -953,12 +959,14 @@ static void aead_crypt_done(struct device *jrdev, u32 *desc, u32 err,
 			    void *context)
 {
 	struct aead_request *req = context;
+	struct caam_aead_req_ctx *rctx = aead_request_ctx(req);
+	struct caam_drv_private_jr *jrp = dev_get_drvdata(jrdev);
 	struct aead_edesc *edesc;
 	int ecode = 0;
 
 	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
-	edesc = container_of(desc, struct aead_edesc, hw_desc[0]);
+	edesc = rctx->edesc;
 
 	if (err)
 		ecode = caam_jr_strstatus(jrdev, err);
@@ -967,7 +975,14 @@ static void aead_crypt_done(struct device *jrdev, u32 *desc, u32 err,
 
 	kfree(edesc);
 
-	aead_request_complete(req, ecode);
+	/*
+	 * If no backlog flag, the completion of the request is done
+	 * by CAAM, not crypto engine.
+	 */
+	if (!edesc->bklog)
+		aead_request_complete(req, ecode);
+	else
+		crypto_finalize_aead_request(jrp->engine, req, ecode);
 }
 
 static void skcipher_crypt_done(struct device *jrdev, u32 *desc, u32 err,
@@ -1262,6 +1277,7 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
 	struct caam_ctx *ctx = crypto_aead_ctx(aead);
 	struct device *jrdev = ctx->jrdev;
+	struct caam_aead_req_ctx *rctx = aead_request_ctx(req);
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		       GFP_KERNEL : GFP_ATOMIC;
 	int src_nents, mapped_src_nents, dst_nents = 0, mapped_dst_nents = 0;
@@ -1362,6 +1378,10 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 	edesc->mapped_dst_nents = mapped_dst_nents;
 	edesc->sec4_sg = (void *)edesc + sizeof(struct aead_edesc) +
 			 desc_bytes;
+
+	edesc->bklog = false;
+	rctx->edesc = edesc;
+
 	*all_contig_ptr = !(mapped_src_nents > 1);
 
 	sec4_sg_index = 0;
@@ -1392,6 +1412,33 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 	return edesc;
 }
 
+static int aead_enqueue_req(struct device *jrdev, struct aead_request *req)
+{
+	struct caam_drv_private_jr *jrpriv = dev_get_drvdata(jrdev);
+	struct caam_aead_req_ctx *rctx = aead_request_ctx(req);
+	struct aead_edesc *edesc = rctx->edesc;
+	u32 *desc = edesc->hw_desc;
+	int ret;
+
+	/*
+	 * Only the backlog request are sent to crypto-engine since the others
+	 * can be handled by CAAM, if free, especially since JR has up to 1024
+	 * entries (more than the 10 entries from crypto-engine).
+	 */
+	if (req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)
+		ret = crypto_transfer_aead_request_to_engine(jrpriv->engine,
+							     req);
+	else
+		ret = caam_jr_enqueue(jrdev, desc, aead_crypt_done, req);
+
+	if ((ret != -EINPROGRESS) && (ret != -EBUSY)) {
+		aead_unmap(jrdev, edesc, req);
+		kfree(rctx->edesc);
+	}
+
+	return ret;
+}
+
 static inline int chachapoly_crypt(struct aead_request *req, bool encrypt)
 {
 	struct aead_edesc *edesc;
@@ -1400,7 +1447,6 @@ static inline int chachapoly_crypt(struct aead_request *req, bool encrypt)
 	struct device *jrdev = ctx->jrdev;
 	bool all_contig;
 	u32 *desc;
-	int ret;
 
 	edesc = aead_edesc_alloc(req, CHACHAPOLY_DESC_JOB_IO_LEN, &all_contig,
 				 encrypt);
@@ -1414,13 +1460,7 @@ static inline int chachapoly_crypt(struct aead_request *req, bool encrypt)
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
 			     1);
 
-	ret = caam_jr_enqueue(jrdev, desc, aead_crypt_done, req);
-	if (ret != -EINPROGRESS) {
-		aead_unmap(jrdev, edesc, req);
-		kfree(edesc);
-	}
-
-	return ret;
+	return aead_enqueue_req(jrdev, req);
 }
 
 static int chachapoly_encrypt(struct aead_request *req)
@@ -1440,8 +1480,6 @@ static inline int aead_crypt(struct aead_request *req, bool encrypt)
 	struct caam_ctx *ctx = crypto_aead_ctx(aead);
 	struct device *jrdev = ctx->jrdev;
 	bool all_contig;
-	u32 *desc;
-	int ret = 0;
 
 	/* allocate extended descriptor */
 	edesc = aead_edesc_alloc(req, AUTHENC_DESC_JOB_IO_LEN,
@@ -1456,14 +1494,7 @@ static inline int aead_crypt(struct aead_request *req, bool encrypt)
 			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
 			     desc_bytes(edesc->hw_desc), 1);
 
-	desc = edesc->hw_desc;
-	ret = caam_jr_enqueue(jrdev, desc, aead_crypt_done, req);
-	if (ret != -EINPROGRESS) {
-		aead_unmap(jrdev, edesc, req);
-		kfree(edesc);
-	}
-
-	return ret;
+	return aead_enqueue_req(jrdev, req);
 }
 
 static int aead_encrypt(struct aead_request *req)
@@ -1476,6 +1507,28 @@ static int aead_decrypt(struct aead_request *req)
 	return aead_crypt(req, false);
 }
 
+static int aead_do_one_req(struct crypto_engine *engine, void *areq)
+{
+	struct aead_request *req = aead_request_cast(areq);
+	struct caam_ctx *ctx = crypto_aead_ctx(crypto_aead_reqtfm(req));
+	struct caam_aead_req_ctx *rctx = aead_request_ctx(req);
+	u32 *desc = rctx->edesc->hw_desc;
+	int ret;
+
+	rctx->edesc->bklog = true;
+
+	ret = caam_jr_enqueue(ctx->jrdev, desc, aead_crypt_done, req);
+
+	if (ret != -EINPROGRESS) {
+		aead_unmap(ctx->jrdev, rctx->edesc, req);
+		kfree(rctx->edesc);
+	} else {
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static inline int gcm_crypt(struct aead_request *req, bool encrypt)
 {
 	struct aead_edesc *edesc;
@@ -1483,8 +1536,6 @@ static inline int gcm_crypt(struct aead_request *req, bool encrypt)
 	struct caam_ctx *ctx = crypto_aead_ctx(aead);
 	struct device *jrdev = ctx->jrdev;
 	bool all_contig;
-	u32 *desc;
-	int ret = 0;
 
 	/* allocate extended descriptor */
 	edesc = aead_edesc_alloc(req, GCM_DESC_JOB_IO_LEN, &all_contig,
@@ -1499,14 +1550,7 @@ static inline int gcm_crypt(struct aead_request *req, bool encrypt)
 			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
 			     desc_bytes(edesc->hw_desc), 1);
 
-	desc = edesc->hw_desc;
-	ret = caam_jr_enqueue(jrdev, desc, aead_crypt_done, req);
-	if (ret != -EINPROGRESS) {
-		aead_unmap(jrdev, edesc, req);
-		kfree(edesc);
-	}
-
-	return ret;
+	return aead_enqueue_req(jrdev, req);
 }
 
 static int gcm_encrypt(struct aead_request *req)
@@ -3336,6 +3380,10 @@ static int caam_aead_init(struct crypto_aead *tfm)
 		 container_of(alg, struct caam_aead_alg, aead);
 	struct caam_ctx *ctx = crypto_aead_ctx(tfm);
 
+	crypto_aead_set_reqsize(tfm, sizeof(struct caam_aead_req_ctx));
+
+	ctx->enginectx.op.do_one_request = aead_do_one_req;
+
 	return caam_init_common(ctx, &caam_alg->caam, !caam_alg->caam.nodkp);
 }
 
-- 
2.1.0

