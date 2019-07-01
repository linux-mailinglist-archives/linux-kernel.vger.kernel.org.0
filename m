Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8521F073
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 13:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbfEOL0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 07:26:03 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44668 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732068AbfEOLZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:25:55 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5EB681A0221;
        Wed, 15 May 2019 13:25:53 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 520B01A002D;
        Wed, 15 May 2019 13:25:53 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 07D98205F4;
        Wed, 15 May 2019 13:25:52 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v2 2/2] crypto: caam - strip input without changing crypto request
Date:   Wed, 15 May 2019 14:25:46 +0300
Message-Id: <1557919546-360-2-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1557919546-360-1-git-send-email-iuliana.prodan@nxp.com>
References: <1557919546-360-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For rsa/pkcs1pad(rsa-caam, sha256), CAAM expects an input of modulus size.
For this we strip the leading zeros in case the size is more than modulus.
This commit avoids modifying the crypto request while striping zeros from
input, to comply with the crypto API requirement. This is done by adding
a fixup input pointer and length.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
Changes since V1:
	- changed the commit message and summary.
---
 drivers/crypto/caam/caampkc.c | 39 ++++++++++++++++++++++++++-------------
 drivers/crypto/caam/caampkc.h |  7 ++++++-
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index e356413..41591f8 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -32,8 +32,10 @@ static u8 *zero_buffer;
 static void rsa_io_unmap(struct device *dev, struct rsa_edesc *edesc,
 			 struct akcipher_request *req)
 {
+	struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
+
 	dma_unmap_sg(dev, req->dst, edesc->dst_nents, DMA_FROM_DEVICE);
-	dma_unmap_sg(dev, req->src, edesc->src_nents, DMA_TO_DEVICE);
+	dma_unmap_sg(dev, req_ctx->fixup_src, edesc->src_nents, DMA_TO_DEVICE);
 
 	if (edesc->sec4_sg_bytes)
 		dma_unmap_single(dev, edesc->sec4_sg_dma, edesc->sec4_sg_bytes,
@@ -251,17 +253,21 @@ static struct rsa_edesc *rsa_edesc_alloc(struct akcipher_request *req,
 		if (lzeros < 0)
 			return ERR_PTR(lzeros);
 
-		req->src_len -= lzeros;
-		req->src = scatterwalk_ffwd(req_ctx->src, req->src, lzeros);
+		req_ctx->fixup_src = scatterwalk_ffwd(req_ctx->src, req->src,
+						      lzeros);
+		req_ctx->fixup_src_len = req->src_len - lzeros;
 	} else {
 		/*
 		 * input src is less then n key modulus,
 		 * so there will be zero padding
 		 */
 		diff_size = key->n_sz - req->src_len;
+		req_ctx->fixup_src = req->src;
+		req_ctx->fixup_src_len = req->src_len;
 	}
 
-	src_nents = sg_nents_for_len(req->src, req->src_len);
+	src_nents = sg_nents_for_len(req_ctx->fixup_src,
+				     req_ctx->fixup_src_len);
 	dst_nents = sg_nents_for_len(req->dst, req->dst_len);
 
 	if (!diff_size && src_nents == 1)
@@ -280,7 +286,7 @@ static struct rsa_edesc *rsa_edesc_alloc(struct akcipher_request *req,
 	if (!edesc)
 		return ERR_PTR(-ENOMEM);
 
-	sgc = dma_map_sg(dev, req->src, src_nents, DMA_TO_DEVICE);
+	sgc = dma_map_sg(dev, req_ctx->fixup_src, src_nents, DMA_TO_DEVICE);
 	if (unlikely(!sgc)) {
 		dev_err(dev, "unable to map source\n");
 		goto src_fail;
@@ -298,8 +304,8 @@ static struct rsa_edesc *rsa_edesc_alloc(struct akcipher_request *req,
 				   0);
 
 	if (sec4_sg_index)
-		sg_to_sec4_sg_last(req->src, src_nents, edesc->sec4_sg +
-				   !!diff_size, 0);
+		sg_to_sec4_sg_last(req_ctx->fixup_src, src_nents,
+				   edesc->sec4_sg + !!diff_size, 0);
 
 	if (dst_nents > 1)
 		sg_to_sec4_sg_last(req->dst, dst_nents,
@@ -330,7 +336,7 @@ static struct rsa_edesc *rsa_edesc_alloc(struct akcipher_request *req,
 sec4_sg_fail:
 	dma_unmap_sg(dev, req->dst, dst_nents, DMA_FROM_DEVICE);
 dst_fail:
-	dma_unmap_sg(dev, req->src, src_nents, DMA_TO_DEVICE);
+	dma_unmap_sg(dev, req_ctx->fixup_src, src_nents, DMA_TO_DEVICE);
 src_fail:
 	kfree(edesc);
 	return ERR_PTR(-ENOMEM);
@@ -340,6 +346,7 @@ static int set_rsa_pub_pdb(struct akcipher_request *req,
 			   struct rsa_edesc *edesc)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
 	struct caam_rsa_ctx *ctx = akcipher_tfm_ctx(tfm);
 	struct caam_rsa_key *key = &ctx->key;
 	struct device *dev = ctx->dev;
@@ -364,7 +371,7 @@ static int set_rsa_pub_pdb(struct akcipher_request *req,
 		pdb->f_dma = edesc->sec4_sg_dma;
 		sec4_sg_index += edesc->src_nents;
 	} else {
-		pdb->f_dma = sg_dma_address(req->src);
+		pdb->f_dma = sg_dma_address(req_ctx->fixup_src);
 	}
 
 	if (edesc->dst_nents > 1) {
@@ -376,7 +383,7 @@ static int set_rsa_pub_pdb(struct akcipher_request *req,
 	}
 
 	pdb->sgf |= (key->e_sz << RSA_PDB_E_SHIFT) | key->n_sz;
-	pdb->f_len = req->src_len;
+	pdb->f_len = req_ctx->fixup_src_len;
 
 	return 0;
 }
@@ -409,7 +416,9 @@ static int set_rsa_priv_f1_pdb(struct akcipher_request *req,
 		pdb->g_dma = edesc->sec4_sg_dma;
 		sec4_sg_index += edesc->src_nents;
 	} else {
-		pdb->g_dma = sg_dma_address(req->src);
+		struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
+
+		pdb->g_dma = sg_dma_address(req_ctx->fixup_src);
 	}
 
 	if (edesc->dst_nents > 1) {
@@ -472,7 +481,9 @@ static int set_rsa_priv_f2_pdb(struct akcipher_request *req,
 		pdb->g_dma = edesc->sec4_sg_dma;
 		sec4_sg_index += edesc->src_nents;
 	} else {
-		pdb->g_dma = sg_dma_address(req->src);
+		struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
+
+		pdb->g_dma = sg_dma_address(req_ctx->fixup_src);
 	}
 
 	if (edesc->dst_nents > 1) {
@@ -559,7 +570,9 @@ static int set_rsa_priv_f3_pdb(struct akcipher_request *req,
 		pdb->g_dma = edesc->sec4_sg_dma;
 		sec4_sg_index += edesc->src_nents;
 	} else {
-		pdb->g_dma = sg_dma_address(req->src);
+		struct caam_rsa_req_ctx *req_ctx = akcipher_request_ctx(req);
+
+		pdb->g_dma = sg_dma_address(req_ctx->fixup_src);
 	}
 
 	if (edesc->dst_nents > 1) {
diff --git a/drivers/crypto/caam/caampkc.h b/drivers/crypto/caam/caampkc.h
index 5ac7201..2c488c9 100644
--- a/drivers/crypto/caam/caampkc.h
+++ b/drivers/crypto/caam/caampkc.h
@@ -95,14 +95,19 @@ struct caam_rsa_ctx {
 	struct caam_rsa_key key;
 	struct device *dev;
 	dma_addr_t padding_dma;
+
 };
 
 /**
  * caam_rsa_req_ctx - per request context.
- * @src: input scatterlist (stripped of leading zeros)
+ * @src           : input scatterlist (stripped of leading zeros)
+ * @fixup_src     : input scatterlist (that might be stripped of leading zeros)
+ * @fixup_src_len : length of the fixup_src input scatterlist
  */
 struct caam_rsa_req_ctx {
 	struct scatterlist src[2];
+	struct scatterlist *fixup_src;
+	unsigned int fixup_src_len;
 };
 
 /**
-- 
2.1.0

