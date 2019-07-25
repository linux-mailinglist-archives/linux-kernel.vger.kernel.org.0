Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92DE075065
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 15:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404598AbfGYN7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 09:59:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58424 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404265AbfGYN6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:58:42 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5DC70200724;
        Thu, 25 Jul 2019 15:58:40 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F13C200053;
        Thu, 25 Jul 2019 15:58:40 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 025EE205E8;
        Thu, 25 Jul 2019 15:58:39 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v3 10/14] crypto: caam - fix MDHA key derivation for certain user key lengths
Date:   Thu, 25 Jul 2019 16:58:22 +0300
Message-Id: <1564063106-9552-11-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1564063106-9552-1-git-send-email-iuliana.prodan@nxp.com>
References: <1564063106-9552-1-git-send-email-iuliana.prodan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia Geantă <horia.geanta@nxp.com>

Fuzz testing uncovered an issue when |user key| > |derived key|.
Derived key generation has to be fixed in two cases:

1. Era >= 6 (DKP is available)
DKP cannot be used with immediate input key if |user key| > |derived key|,
since the resulting descriptor (after DKP execution) would be invalid -
having a few bytes from user key left in descriptor buffer
as incorrect opcodes.

Fix DKP usage both in standalone hmac and in authenc algorithms.
For authenc the logic is simplified, by always storing both virtual
and dma key addresses.

2. Era < 6
The same case (|user key| > |derived key|) fails when DKP
is not available.
Make sure gen_split_key() dma maps max(|user key|, |derived key|),
since this is an in-place (bidirectional) operation.

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>

Changes since v2:
- fix MDHA key derivation for CAAM with era < 6.
---
 drivers/crypto/caam/caamalg.c     | 42 +++++++-----------------
 drivers/crypto/caam/caamalg_qi.c  | 42 +++++++-----------------
 drivers/crypto/caam/caamalg_qi2.c | 67 +++++++++++++++++++++++++++------------
 drivers/crypto/caam/caamhash.c    | 53 ++++++++++++++++++++++---------
 drivers/crypto/caam/desc_constr.h | 24 ++++++++++----
 drivers/crypto/caam/key_gen.c     |  9 +++---
 6 files changed, 132 insertions(+), 105 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index b14a13b..3cc9d5c 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -205,6 +205,18 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 				ctx->cdata.keylen - CTR_RFC3686_NONCE_SIZE);
 	}
 
+	/*
+	 * In case |user key| > |derived key|, using DKP<imm,imm>
+	 * would result in invalid opcodes (last bytes of user key) in
+	 * the resulting descriptor. Use DKP<ptr,imm> instead => both
+	 * virtual and dma key addresses are needed.
+	 */
+	ctx->adata.key_virt = ctx->key;
+	ctx->adata.key_dma = ctx->key_dma;
+
+	ctx->cdata.key_virt = ctx->key + ctx->adata.keylen_pad;
+	ctx->cdata.key_dma = ctx->key_dma + ctx->adata.keylen_pad;
+
 	data_len[0] = ctx->adata.keylen_pad;
 	data_len[1] = ctx->cdata.keylen;
 
@@ -221,16 +233,6 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 			      ARRAY_SIZE(data_len)) < 0)
 		return -EINVAL;
 
-	if (inl_mask & 1)
-		ctx->adata.key_virt = ctx->key;
-	else
-		ctx->adata.key_dma = ctx->key_dma;
-
-	if (inl_mask & 2)
-		ctx->cdata.key_virt = ctx->key + ctx->adata.keylen_pad;
-	else
-		ctx->cdata.key_dma = ctx->key_dma + ctx->adata.keylen_pad;
-
 	ctx->adata.key_inline = !!(inl_mask & 1);
 	ctx->cdata.key_inline = !!(inl_mask & 2);
 
@@ -253,16 +255,6 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 			      ARRAY_SIZE(data_len)) < 0)
 		return -EINVAL;
 
-	if (inl_mask & 1)
-		ctx->adata.key_virt = ctx->key;
-	else
-		ctx->adata.key_dma = ctx->key_dma;
-
-	if (inl_mask & 2)
-		ctx->cdata.key_virt = ctx->key + ctx->adata.keylen_pad;
-	else
-		ctx->cdata.key_dma = ctx->key_dma + ctx->adata.keylen_pad;
-
 	ctx->adata.key_inline = !!(inl_mask & 1);
 	ctx->cdata.key_inline = !!(inl_mask & 2);
 
@@ -287,16 +279,6 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 			      ARRAY_SIZE(data_len)) < 0)
 		return -EINVAL;
 
-	if (inl_mask & 1)
-		ctx->adata.key_virt = ctx->key;
-	else
-		ctx->adata.key_dma = ctx->key_dma;
-
-	if (inl_mask & 2)
-		ctx->cdata.key_virt = ctx->key + ctx->adata.keylen_pad;
-	else
-		ctx->cdata.key_dma = ctx->key_dma + ctx->adata.keylen_pad;
-
 	ctx->adata.key_inline = !!(inl_mask & 1);
 	ctx->cdata.key_inline = !!(inl_mask & 2);
 
diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index 452467c..6fe6713 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -105,6 +105,18 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 				ctx->cdata.keylen - CTR_RFC3686_NONCE_SIZE);
 	}
 
+	/*
+	 * In case |user key| > |derived key|, using DKP<imm,imm> would result
+	 * in invalid opcodes (last bytes of user key) in the resulting
+	 * descriptor. Use DKP<ptr,imm> instead => both virtual and dma key
+	 * addresses are needed.
+	 */
+	ctx->adata.key_virt = ctx->key;
+	ctx->adata.key_dma = ctx->key_dma;
+
+	ctx->cdata.key_virt = ctx->key + ctx->adata.keylen_pad;
+	ctx->cdata.key_dma = ctx->key_dma + ctx->adata.keylen_pad;
+
 	data_len[0] = ctx->adata.keylen_pad;
 	data_len[1] = ctx->cdata.keylen;
 
@@ -118,16 +130,6 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 			      ARRAY_SIZE(data_len)) < 0)
 		return -EINVAL;
 
-	if (inl_mask & 1)
-		ctx->adata.key_virt = ctx->key;
-	else
-		ctx->adata.key_dma = ctx->key_dma;
-
-	if (inl_mask & 2)
-		ctx->cdata.key_virt = ctx->key + ctx->adata.keylen_pad;
-	else
-		ctx->cdata.key_dma = ctx->key_dma + ctx->adata.keylen_pad;
-
 	ctx->adata.key_inline = !!(inl_mask & 1);
 	ctx->cdata.key_inline = !!(inl_mask & 2);
 
@@ -143,16 +145,6 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 			      ARRAY_SIZE(data_len)) < 0)
 		return -EINVAL;
 
-	if (inl_mask & 1)
-		ctx->adata.key_virt = ctx->key;
-	else
-		ctx->adata.key_dma = ctx->key_dma;
-
-	if (inl_mask & 2)
-		ctx->cdata.key_virt = ctx->key + ctx->adata.keylen_pad;
-	else
-		ctx->cdata.key_dma = ctx->key_dma + ctx->adata.keylen_pad;
-
 	ctx->adata.key_inline = !!(inl_mask & 1);
 	ctx->cdata.key_inline = !!(inl_mask & 2);
 
@@ -171,16 +163,6 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 			      ARRAY_SIZE(data_len)) < 0)
 		return -EINVAL;
 
-	if (inl_mask & 1)
-		ctx->adata.key_virt = ctx->key;
-	else
-		ctx->adata.key_dma = ctx->key_dma;
-
-	if (inl_mask & 2)
-		ctx->cdata.key_virt = ctx->key + ctx->adata.keylen_pad;
-	else
-		ctx->cdata.key_dma = ctx->key_dma + ctx->adata.keylen_pad;
-
 	ctx->adata.key_inline = !!(inl_mask & 1);
 	ctx->cdata.key_inline = !!(inl_mask & 2);
 
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index c1eca99..66228e7 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -198,6 +198,18 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 				ctx->cdata.keylen - CTR_RFC3686_NONCE_SIZE);
 	}
 
+	/*
+	 * In case |user key| > |derived key|, using DKP<imm,imm> would result
+	 * in invalid opcodes (last bytes of user key) in the resulting
+	 * descriptor. Use DKP<ptr,imm> instead => both virtual and dma key
+	 * addresses are needed.
+	 */
+	ctx->adata.key_virt = ctx->key;
+	ctx->adata.key_dma = ctx->key_dma;
+
+	ctx->cdata.key_virt = ctx->key + ctx->adata.keylen_pad;
+	ctx->cdata.key_dma = ctx->key_dma + ctx->adata.keylen_pad;
+
 	data_len[0] = ctx->adata.keylen_pad;
 	data_len[1] = ctx->cdata.keylen;
 
@@ -209,16 +221,6 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 			      ARRAY_SIZE(data_len)) < 0)
 		return -EINVAL;
 
-	if (inl_mask & 1)
-		ctx->adata.key_virt = ctx->key;
-	else
-		ctx->adata.key_dma = ctx->key_dma;
-
-	if (inl_mask & 2)
-		ctx->cdata.key_virt = ctx->key + ctx->adata.keylen_pad;
-	else
-		ctx->cdata.key_dma = ctx->key_dma + ctx->adata.keylen_pad;
-
 	ctx->adata.key_inline = !!(inl_mask & 1);
 	ctx->cdata.key_inline = !!(inl_mask & 2);
 
@@ -247,16 +249,6 @@ static int aead_set_sh_desc(struct crypto_aead *aead)
 			      ARRAY_SIZE(data_len)) < 0)
 		return -EINVAL;
 
-	if (inl_mask & 1)
-		ctx->adata.key_virt = ctx->key;
-	else
-		ctx->adata.key_dma = ctx->key_dma;
-
-	if (inl_mask & 2)
-		ctx->cdata.key_virt = ctx->key + ctx->adata.keylen_pad;
-	else
-		ctx->cdata.key_dma = ctx->key_dma + ctx->adata.keylen_pad;
-
 	ctx->adata.key_inline = !!(inl_mask & 1);
 	ctx->cdata.key_inline = !!(inl_mask & 2);
 
@@ -2998,6 +2990,7 @@ enum hash_optype {
 /**
  * caam_hash_ctx - ahash per-session context
  * @flc: Flow Contexts array
+ * @key: authentication key
  * @flc_dma: I/O virtual addresses of the Flow Contexts
  * @dev: dpseci device
  * @ctx_len: size of Context Register
@@ -3005,6 +2998,7 @@ enum hash_optype {
  */
 struct caam_hash_ctx {
 	struct caam_flc flc[HASH_NUM_OP];
+	u8 key[CAAM_MAX_HASH_BLOCK_SIZE] ____cacheline_aligned;
 	dma_addr_t flc_dma[HASH_NUM_OP];
 	struct device *dev;
 	int ctx_len;
@@ -3305,6 +3299,19 @@ static int ahash_setkey(struct crypto_ahash *ahash, const u8 *key,
 	ctx->adata.key_virt = key;
 	ctx->adata.key_inline = true;
 
+	/*
+	 * In case |user key| > |derived key|, using DKP<imm,imm> would result
+	 * in invalid opcodes (last bytes of user key) in the resulting
+	 * descriptor. Use DKP<ptr,imm> instead => both virtual and dma key
+	 * addresses are needed.
+	 */
+	if (keylen > ctx->adata.keylen_pad) {
+		memcpy(ctx->key, key, keylen);
+		dma_sync_single_for_device(ctx->dev, ctx->adata.key_dma,
+					   ctx->adata.keylen_pad,
+					   DMA_TO_DEVICE);
+	}
+
 	ret = ahash_set_sh_desc(ahash);
 	kfree(hashed_key);
 	return ret;
@@ -4535,11 +4542,27 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 
 	ctx->dev = caam_hash->dev;
 
+	if (alg->setkey) {
+		ctx->adata.key_dma = dma_map_single_attrs(ctx->dev, ctx->key,
+							  ARRAY_SIZE(ctx->key),
+							  DMA_TO_DEVICE,
+							  DMA_ATTR_SKIP_CPU_SYNC);
+		if (dma_mapping_error(ctx->dev, ctx->adata.key_dma)) {
+			dev_err(ctx->dev, "unable to map key\n");
+			return -ENOMEM;
+		}
+	}
+
 	dma_addr = dma_map_single_attrs(ctx->dev, ctx->flc, sizeof(ctx->flc),
 					DMA_BIDIRECTIONAL,
 					DMA_ATTR_SKIP_CPU_SYNC);
 	if (dma_mapping_error(ctx->dev, dma_addr)) {
 		dev_err(ctx->dev, "unable to map shared descriptors\n");
+		if (ctx->adata.key_dma)
+			dma_unmap_single_attrs(ctx->dev, ctx->adata.key_dma,
+					       ARRAY_SIZE(ctx->key),
+					       DMA_TO_DEVICE,
+					       DMA_ATTR_SKIP_CPU_SYNC);
 		return -ENOMEM;
 	}
 
@@ -4565,6 +4588,10 @@ static void caam_hash_cra_exit(struct crypto_tfm *tfm)
 
 	dma_unmap_single_attrs(ctx->dev, ctx->flc_dma[0], sizeof(ctx->flc),
 			       DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);
+	if (ctx->adata.key_dma)
+		dma_unmap_single_attrs(ctx->dev, ctx->adata.key_dma,
+				       ARRAY_SIZE(ctx->key), DMA_TO_DEVICE,
+				       DMA_ATTR_SKIP_CPU_SYNC);
 }
 
 static struct caam_hash_alg *caam_hash_alloc(struct device *dev,
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 49ab6ca..7147190 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -96,6 +96,7 @@ struct caam_hash_ctx {
 	dma_addr_t sh_desc_fin_dma;
 	dma_addr_t sh_desc_digest_dma;
 	enum dma_data_direction dir;
+	enum dma_data_direction key_dir;
 	struct device *jrdev;
 	int ctx_len;
 	struct alginfo adata;
@@ -476,6 +477,18 @@ static int ahash_setkey(struct crypto_ahash *ahash,
 			goto bad_free_key;
 
 		memcpy(ctx->key, key, keylen);
+
+		/*
+		 * In case |user key| > |derived key|, using DKP<imm,imm>
+		 * would result in invalid opcodes (last bytes of user key) in
+		 * the resulting descriptor. Use DKP<ptr,imm> instead => both
+		 * virtual and dma key addresses are needed.
+		 */
+		if (keylen > ctx->adata.keylen_pad)
+			dma_sync_single_for_device(ctx->jrdev,
+						   ctx->adata.key_dma,
+						   ctx->adata.keylen_pad,
+						   DMA_TO_DEVICE);
 	} else {
 		ret = gen_split_key(ctx->jrdev, ctx->key, &ctx->adata, key,
 				    keylen, CAAM_MAX_HASH_KEY_SIZE);
@@ -1825,40 +1838,50 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 
 	if (is_xcbc_aes(caam_hash->alg_type)) {
 		ctx->dir = DMA_TO_DEVICE;
+		ctx->key_dir = DMA_BIDIRECTIONAL;
 		ctx->adata.algtype = OP_TYPE_CLASS1_ALG | caam_hash->alg_type;
 		ctx->ctx_len = 48;
-
-		ctx->adata.key_dma = dma_map_single_attrs(ctx->jrdev, ctx->key,
-							  ARRAY_SIZE(ctx->key),
-							  DMA_BIDIRECTIONAL,
-							  DMA_ATTR_SKIP_CPU_SYNC);
-		if (dma_mapping_error(ctx->jrdev, ctx->adata.key_dma)) {
-			dev_err(ctx->jrdev, "unable to map key\n");
-			caam_jr_free(ctx->jrdev);
-			return -ENOMEM;
-		}
 	} else if (is_cmac_aes(caam_hash->alg_type)) {
 		ctx->dir = DMA_TO_DEVICE;
+		ctx->key_dir = DMA_NONE;
 		ctx->adata.algtype = OP_TYPE_CLASS1_ALG | caam_hash->alg_type;
 		ctx->ctx_len = 32;
 	} else {
-		ctx->dir = priv->era >= 6 ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
+		if (priv->era >= 6) {
+			ctx->dir = DMA_BIDIRECTIONAL;
+			ctx->key_dir = alg->setkey ? DMA_TO_DEVICE : DMA_NONE;
+		} else {
+			ctx->dir = DMA_TO_DEVICE;
+			ctx->key_dir = DMA_NONE;
+		}
 		ctx->adata.algtype = OP_TYPE_CLASS2_ALG | caam_hash->alg_type;
 		ctx->ctx_len = runninglen[(ctx->adata.algtype &
 					   OP_ALG_ALGSEL_SUBMASK) >>
 					  OP_ALG_ALGSEL_SHIFT];
 	}
 
+	if (ctx->key_dir != DMA_NONE) {
+		ctx->adata.key_dma = dma_map_single_attrs(ctx->jrdev, ctx->key,
+							  ARRAY_SIZE(ctx->key),
+							  ctx->key_dir,
+							  DMA_ATTR_SKIP_CPU_SYNC);
+		if (dma_mapping_error(ctx->jrdev, ctx->adata.key_dma)) {
+			dev_err(ctx->jrdev, "unable to map key\n");
+			caam_jr_free(ctx->jrdev);
+			return -ENOMEM;
+		}
+	}
+
 	dma_addr = dma_map_single_attrs(ctx->jrdev, ctx->sh_desc_update,
 					offsetof(struct caam_hash_ctx, key),
 					ctx->dir, DMA_ATTR_SKIP_CPU_SYNC);
 	if (dma_mapping_error(ctx->jrdev, dma_addr)) {
 		dev_err(ctx->jrdev, "unable to map shared descriptors\n");
 
-		if (is_xcbc_aes(caam_hash->alg_type))
+		if (ctx->key_dir != DMA_NONE)
 			dma_unmap_single_attrs(ctx->jrdev, ctx->adata.key_dma,
 					       ARRAY_SIZE(ctx->key),
-					       DMA_BIDIRECTIONAL,
+					       ctx->key_dir,
 					       DMA_ATTR_SKIP_CPU_SYNC);
 
 		caam_jr_free(ctx->jrdev);
@@ -1891,9 +1914,9 @@ static void caam_hash_cra_exit(struct crypto_tfm *tfm)
 	dma_unmap_single_attrs(ctx->jrdev, ctx->sh_desc_update_dma,
 			       offsetof(struct caam_hash_ctx, key),
 			       ctx->dir, DMA_ATTR_SKIP_CPU_SYNC);
-	if (is_xcbc_aes(ctx->adata.algtype))
+	if (ctx->key_dir != DMA_NONE)
 		dma_unmap_single_attrs(ctx->jrdev, ctx->adata.key_dma,
-				       ARRAY_SIZE(ctx->key), DMA_BIDIRECTIONAL,
+				       ARRAY_SIZE(ctx->key), ctx->key_dir,
 				       DMA_ATTR_SKIP_CPU_SYNC);
 	caam_jr_free(ctx->jrdev);
 }
diff --git a/drivers/crypto/caam/desc_constr.h b/drivers/crypto/caam/desc_constr.h
index 8154174..536f360 100644
--- a/drivers/crypto/caam/desc_constr.h
+++ b/drivers/crypto/caam/desc_constr.h
@@ -533,14 +533,26 @@ static inline void append_proto_dkp(u32 * const desc, struct alginfo *adata)
 	if (adata->key_inline) {
 		int words;
 
-		append_operation(desc, OP_TYPE_UNI_PROTOCOL | protid |
-				 OP_PCL_DKP_SRC_IMM | OP_PCL_DKP_DST_IMM |
-				 adata->keylen);
-		append_data(desc, adata->key_virt, adata->keylen);
+		if (adata->keylen > adata->keylen_pad) {
+			append_operation(desc, OP_TYPE_UNI_PROTOCOL | protid |
+					 OP_PCL_DKP_SRC_PTR |
+					 OP_PCL_DKP_DST_IMM | adata->keylen);
+			append_ptr(desc, adata->key_dma);
+
+			words = (ALIGN(adata->keylen_pad, CAAM_CMD_SZ) -
+				 CAAM_PTR_SZ) / CAAM_CMD_SZ;
+		} else {
+			append_operation(desc, OP_TYPE_UNI_PROTOCOL | protid |
+					 OP_PCL_DKP_SRC_IMM |
+					 OP_PCL_DKP_DST_IMM | adata->keylen);
+			append_data(desc, adata->key_virt, adata->keylen);
+
+			words = (ALIGN(adata->keylen_pad, CAAM_CMD_SZ) -
+				 ALIGN(adata->keylen, CAAM_CMD_SZ)) /
+				CAAM_CMD_SZ;
+		}
 
 		/* Reserve space in descriptor buffer for the derived key */
-		words = (ALIGN(adata->keylen_pad, CAAM_CMD_SZ) -
-			 ALIGN(adata->keylen, CAAM_CMD_SZ)) / CAAM_CMD_SZ;
 		if (words)
 			(*desc) = cpu_to_caam32(caam32_to_cpu(*desc) + words);
 	} else {
diff --git a/drivers/crypto/caam/key_gen.c b/drivers/crypto/caam/key_gen.c
index c6f8375..5a851dd 100644
--- a/drivers/crypto/caam/key_gen.c
+++ b/drivers/crypto/caam/key_gen.c
@@ -48,18 +48,20 @@ int gen_split_key(struct device *jrdev, u8 *key_out,
 	u32 *desc;
 	struct split_key_result result;
 	dma_addr_t dma_addr;
+	unsigned int local_max;
 	int ret = -ENOMEM;
 
 	adata->keylen = split_key_len(adata->algtype & OP_ALG_ALGSEL_MASK);
 	adata->keylen_pad = split_key_pad_len(adata->algtype &
 					      OP_ALG_ALGSEL_MASK);
+	local_max = max(keylen, adata->keylen_pad);
 
 	dev_dbg(jrdev, "split keylen %d split keylen padded %d\n",
 		adata->keylen, adata->keylen_pad);
 	print_hex_dump_debug("ctx.key@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key_in, keylen, 1);
 
-	if (adata->keylen_pad > max_keylen)
+	if (local_max > max_keylen)
 		return -EINVAL;
 
 	desc = kmalloc(CAAM_CMD_SZ * 6 + CAAM_PTR_SZ * 2, GFP_KERNEL | GFP_DMA);
@@ -70,8 +72,7 @@ int gen_split_key(struct device *jrdev, u8 *key_out,
 
 	memcpy(key_out, key_in, keylen);
 
-	dma_addr = dma_map_single(jrdev, key_out, adata->keylen_pad,
-				  DMA_BIDIRECTIONAL);
+	dma_addr = dma_map_single(jrdev, key_out, local_max, DMA_BIDIRECTIONAL);
 	if (dma_mapping_error(jrdev, dma_addr)) {
 		dev_err(jrdev, "unable to map key memory\n");
 		goto out_free;
@@ -117,7 +118,7 @@ int gen_split_key(struct device *jrdev, u8 *key_out,
 				     adata->keylen_pad, 1);
 	}
 
-	dma_unmap_single(jrdev, dma_addr, adata->keylen_pad, DMA_BIDIRECTIONAL);
+	dma_unmap_single(jrdev, dma_addr, local_max, DMA_BIDIRECTIONAL);
 out_free:
 	kfree(desc);
 	return ret;
-- 
2.1.0

