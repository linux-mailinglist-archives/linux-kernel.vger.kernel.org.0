Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E902E87E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 00:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfE2WtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 18:49:14 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:56056 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfE2WtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 18:49:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id D92FE1803086A;
        Thu, 30 May 2019 00:49:09 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-crypto@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, festevam@gmail.com, kernel@pengutronix.de,
        s.hauer@pengutronix.de, shawnguo@kernel.org, davem@davemloft.net,
        herbert@gondor.apana.org.au, david@sigma-star.at,
        Richard Weinberger <richard@nod.at>
Subject: [RFC PATCH 2/2] crypto: mxs-dcp: Implement reference keys
Date:   Thu, 30 May 2019 00:48:44 +0200
Message-Id: <20190529224844.25203-2-richard@nod.at>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190529224844.25203-1-richard@nod.at>
References: <20190529224844.25203-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DCP allows working with secure keys. These keys can reside in a
protected memory region of the crypto accelerator, burned in
eFuses or being an internal chip key. To use these keys a key
reference is transferred to the chip instead of a AES key.
For DCP these references can be:
0x00 to 0x03: Key slot number in the secure memory region
0xfe: Unique device key
0xff: OTP key (burned in eFuse)

To utilize this functionality we check for the
CRYPTO_TFM_REQ_REF_KEY flag, if it is set the key as provided
via mxs_dcp_aes_setkey() is used as reference.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/crypto/mxs-dcp.c | 77 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index b4429891e368..22b048a3a91b 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -147,6 +147,10 @@ static struct dcp *global_sdcp;
 
 #define MXS_DCP_CONTEXT				0x50
 
+#define MXS_DCP_KEY				0x60
+#define MXS_DCP_KEY_IDX(id, word)		(((id) << 4) | (word))
+#define MXS_DCP_KEYDATA				0x70
+
 #define MXS_DCP_CH_N_CMDPTR(n)			(0x100 + ((n) * 0x40))
 
 #define MXS_DCP_CH_N_SEMA(n)			(0x110 + ((n) * 0x40))
@@ -158,6 +162,7 @@ static struct dcp *global_sdcp;
 #define MXS_DCP_CONTROL0_HASH_TERM		(1 << 13)
 #define MXS_DCP_CONTROL0_HASH_INIT		(1 << 12)
 #define MXS_DCP_CONTROL0_PAYLOAD_KEY		(1 << 11)
+#define MXS_DCP_CONTROL0_OTP_KEY		(1 << 10)
 #define MXS_DCP_CONTROL0_CIPHER_ENCRYPT		(1 << 8)
 #define MXS_DCP_CONTROL0_CIPHER_INIT		(1 << 9)
 #define MXS_DCP_CONTROL0_ENABLE_HASH		(1 << 6)
@@ -222,15 +227,22 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
 	struct dcp *sdcp = global_sdcp;
 	struct dcp_dma_desc *desc = &sdcp->coh->desc[actx->chan];
 	struct dcp_aes_req_ctx *rctx = ablkcipher_request_ctx(req);
+	struct crypto_async_request *arq = &req->base;
+	bool key_referenced = !!(crypto_tfm_get_flags(arq->tfm) &
+				 CRYPTO_TFM_REQ_REF_KEY);
+	dma_addr_t src_phys, dst_phys, key_phys = {0};
 	int ret;
 
-	dma_addr_t key_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_key,
-					     2 * AES_KEYSIZE_128,
-					     DMA_TO_DEVICE);
-	dma_addr_t src_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_in_buf,
-					     DCP_BUF_SZ, DMA_TO_DEVICE);
-	dma_addr_t dst_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_out_buf,
-					     DCP_BUF_SZ, DMA_FROM_DEVICE);
+	if (!key_referenced) {
+		key_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_key,
+						     2 * AES_KEYSIZE_128,
+						     DMA_TO_DEVICE);
+	}
+
+	src_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_in_buf,
+				  DCP_BUF_SZ, DMA_TO_DEVICE);
+	dst_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_out_buf,
+				  DCP_BUF_SZ, DMA_FROM_DEVICE);
 
 	if (actx->fill % AES_BLOCK_SIZE) {
 		dev_err(sdcp->dev, "Invalid block size!\n");
@@ -243,8 +255,12 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
 		    MXS_DCP_CONTROL0_INTERRUPT |
 		    MXS_DCP_CONTROL0_ENABLE_CIPHER;
 
-	/* Payload contains the key. */
-	desc->control0 |= MXS_DCP_CONTROL0_PAYLOAD_KEY;
+	if (key_referenced) {
+		desc->control0 |= MXS_DCP_CONTROL0_OTP_KEY;
+	} else {
+		/* Payload contains the key. */
+		desc->control0 |= MXS_DCP_CONTROL0_PAYLOAD_KEY;
+	}
 
 	if (rctx->enc)
 		desc->control0 |= MXS_DCP_CONTROL0_CIPHER_ENCRYPT;
@@ -258,18 +274,26 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
 	else
 		desc->control1 |= MXS_DCP_CONTROL1_CIPHER_MODE_CBC;
 
+	if (key_referenced)
+		desc->control1 |= sdcp->coh->aes_key[0] << 8;
+
 	desc->next_cmd_addr = 0;
 	desc->source = src_phys;
 	desc->destination = dst_phys;
 	desc->size = actx->fill;
-	desc->payload = key_phys;
+	if (key_referenced)
+		desc->payload = 0;
+	else
+		desc->payload = key_phys;
 	desc->status = 0;
 
 	ret = mxs_dcp_start_dma(actx);
 
 aes_done_run:
-	dma_unmap_single(sdcp->dev, key_phys, 2 * AES_KEYSIZE_128,
-			 DMA_TO_DEVICE);
+	if (!key_referenced) {
+		dma_unmap_single(sdcp->dev, key_phys, 2 * AES_KEYSIZE_128,
+				 DMA_TO_DEVICE);
+	}
 	dma_unmap_single(sdcp->dev, src_phys, DCP_BUF_SZ, DMA_TO_DEVICE);
 	dma_unmap_single(sdcp->dev, dst_phys, DCP_BUF_SZ, DMA_FROM_DEVICE);
 
@@ -498,15 +522,40 @@ static int mxs_dcp_aes_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
 			      unsigned int len)
 {
 	struct dcp_async_ctx *actx = crypto_ablkcipher_ctx(tfm);
+	bool key_referenced = !!(crypto_ablkcipher_get_flags(tfm) &
+				 CRYPTO_TFM_REQ_REF_KEY);
 	unsigned int ret;
 
 	/*
-	 * AES 128 is supposed by the hardware, store key into temporary
+	 * AES 128 is supported by the hardware, store key into temporary
 	 * buffer and exit. We must use the temporary buffer here, since
 	 * there can still be an operation in progress.
 	 */
 	actx->key_len = len;
-	if (len == AES_KEYSIZE_128) {
+
+	if (key_referenced) {
+		/*
+		 * If a hardware key is used, no software fallback is possible.
+		 */
+		if (len != AES_KEYSIZE_128)
+			return -EINVAL;
+
+		/*
+		 * DCP supports the following key slots.
+		 */
+		switch (key[0]) {
+		case 0x00:
+		case 0x01:
+		case 0x02:
+		case 0x03:
+		case 0xfe:
+		case 0xff:
+			memcpy(actx->key, key, len);
+			return 0;
+		default:
+			return -EINVAL;
+		}
+	} else if (len == AES_KEYSIZE_128) {
 		memcpy(actx->key, key, len);
 		return 0;
 	}
-- 
2.16.4

