Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 774FD11724F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 18:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfLIRAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 12:00:12 -0500
Received: from inva020.nxp.com ([92.121.34.13]:57198 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfLIRAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:00:09 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DA7F1A1608;
        Mon,  9 Dec 2019 18:00:06 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 66D2C1A15E5;
        Mon,  9 Dec 2019 18:00:06 +0100 (CET)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 29A6320564;
        Mon,  9 Dec 2019 18:00:06 +0100 (CET)
From:   Andrei Botila <andrei.botila@nxp.com>
To:     Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] crypto: caam/qi2 - remove double buffering for ahash
Date:   Mon,  9 Dec 2019 18:59:56 +0200
Message-Id: <1575910796-13897-2-git-send-email-andrei.botila@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1575910796-13897-1-git-send-email-andrei.botila@nxp.com>
References: <1575910796-13897-1-git-send-email-andrei.botila@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously double buffering was used for storing previous and next
"less-than-block-size" bytes. Double buffering can be removed by moving
the copy of next "less-than-block-size" bytes after current request is
executed by HW.

Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
---
 drivers/crypto/caam/caamalg_qi2.c | 157 +++++++++++-------------------
 1 file changed, 58 insertions(+), 99 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 3443f6d6dd83..3aeacc36ce23 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -2998,15 +2998,13 @@ struct caam_hash_state {
 	dma_addr_t buf_dma;
 	dma_addr_t ctx_dma;
 	int ctx_dma_len;
-	u8 buf_0[CAAM_MAX_HASH_BLOCK_SIZE] ____cacheline_aligned;
-	int buflen_0;
-	u8 buf_1[CAAM_MAX_HASH_BLOCK_SIZE] ____cacheline_aligned;
-	int buflen_1;
+	u8 buf[CAAM_MAX_HASH_BLOCK_SIZE] ____cacheline_aligned;
+	int buflen;
+	int next_buflen;
 	u8 caam_ctx[MAX_CTX_LEN] ____cacheline_aligned;
 	int (*update)(struct ahash_request *req);
 	int (*final)(struct ahash_request *req);
 	int (*finup)(struct ahash_request *req);
-	int current_buf;
 };
 
 struct caam_export_state {
@@ -3018,42 +3016,17 @@ struct caam_export_state {
 	int (*finup)(struct ahash_request *req);
 };
 
-static inline void switch_buf(struct caam_hash_state *state)
-{
-	state->current_buf ^= 1;
-}
-
-static inline u8 *current_buf(struct caam_hash_state *state)
-{
-	return state->current_buf ? state->buf_1 : state->buf_0;
-}
-
-static inline u8 *alt_buf(struct caam_hash_state *state)
-{
-	return state->current_buf ? state->buf_0 : state->buf_1;
-}
-
-static inline int *current_buflen(struct caam_hash_state *state)
-{
-	return state->current_buf ? &state->buflen_1 : &state->buflen_0;
-}
-
-static inline int *alt_buflen(struct caam_hash_state *state)
-{
-	return state->current_buf ? &state->buflen_0 : &state->buflen_1;
-}
-
 /* Map current buffer in state (if length > 0) and put it in link table */
 static inline int buf_map_to_qm_sg(struct device *dev,
 				   struct dpaa2_sg_entry *qm_sg,
 				   struct caam_hash_state *state)
 {
-	int buflen = *current_buflen(state);
+	int buflen = state->buflen;
 
 	if (!buflen)
 		return 0;
 
-	state->buf_dma = dma_map_single(dev, current_buf(state), buflen,
+	state->buf_dma = dma_map_single(dev, state->buf, buflen,
 					DMA_TO_DEVICE);
 	if (dma_mapping_error(dev, state->buf_dma)) {
 		dev_err(dev, "unable to map buf\n");
@@ -3321,7 +3294,7 @@ static inline void ahash_unmap(struct device *dev, struct ahash_edesc *edesc,
 				 DMA_TO_DEVICE);
 
 	if (state->buf_dma) {
-		dma_unmap_single(dev, state->buf_dma, *current_buflen(state),
+		dma_unmap_single(dev, state->buf_dma, state->buflen,
 				 DMA_TO_DEVICE);
 		state->buf_dma = 0;
 	}
@@ -3383,9 +3356,17 @@ static void ahash_done_bi(void *cbk_ctx, u32 status)
 		ecode = caam_qi2_strstatus(ctx->dev, status);
 
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_BIDIRECTIONAL);
-	switch_buf(state);
 	qi_cache_free(edesc);
 
+	scatterwalk_map_and_copy(state->buf, req->src,
+				 req->nbytes - state->next_buflen,
+				 state->next_buflen, 0);
+	state->buflen = state->next_buflen;
+
+	print_hex_dump_debug("buf@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, state->buf,
+			     state->buflen, 1);
+
 	print_hex_dump_debug("ctx@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
 			     ctx->ctx_len, 1);
@@ -3440,9 +3421,17 @@ static void ahash_done_ctx_dst(void *cbk_ctx, u32 status)
 		ecode = caam_qi2_strstatus(ctx->dev, status);
 
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_FROM_DEVICE);
-	switch_buf(state);
 	qi_cache_free(edesc);
 
+	scatterwalk_map_and_copy(state->buf, req->src,
+				 req->nbytes - state->next_buflen,
+				 state->next_buflen, 0);
+	state->buflen = state->next_buflen;
+
+	print_hex_dump_debug("buf@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, state->buf,
+			     state->buflen, 1);
+
 	print_hex_dump_debug("ctx@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
 			     ctx->ctx_len, 1);
@@ -3464,16 +3453,14 @@ static int ahash_update_ctx(struct ahash_request *req)
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		      GFP_KERNEL : GFP_ATOMIC;
-	u8 *buf = current_buf(state);
-	int *buflen = current_buflen(state);
-	u8 *next_buf = alt_buf(state);
-	int *next_buflen = alt_buflen(state), last_buflen;
+	u8 *buf = state->buf;
+	int *buflen = &state->buflen;
+	int *next_buflen = &state->next_buflen;
 	int in_len = *buflen + req->nbytes, to_hash;
 	int src_nents, mapped_nents, qm_sg_bytes, qm_sg_src_index;
 	struct ahash_edesc *edesc;
 	int ret = 0;
 
-	last_buflen = *next_buflen;
 	*next_buflen = in_len & (crypto_tfm_alg_blocksize(&ahash->base) - 1);
 	to_hash = in_len - *next_buflen;
 
@@ -3524,10 +3511,6 @@ static int ahash_update_ctx(struct ahash_request *req)
 		if (mapped_nents) {
 			sg_to_qm_sg_last(req->src, src_len,
 					 sg_table + qm_sg_src_index, 0);
-			if (*next_buflen)
-				scatterwalk_map_and_copy(next_buf, req->src,
-							 to_hash - *buflen,
-							 *next_buflen, 0);
 		} else {
 			dpaa2_sg_set_final(sg_table + qm_sg_src_index - 1,
 					   true);
@@ -3566,14 +3549,11 @@ static int ahash_update_ctx(struct ahash_request *req)
 		scatterwalk_map_and_copy(buf + *buflen, req->src, 0,
 					 req->nbytes, 0);
 		*buflen = *next_buflen;
-		*next_buflen = last_buflen;
-	}
 
-	print_hex_dump_debug("buf@" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, buf, *buflen, 1);
-	print_hex_dump_debug("next buf@" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, next_buf, *next_buflen,
-			     1);
+		print_hex_dump_debug("buf@" __stringify(__LINE__)": ",
+				     DUMP_PREFIX_ADDRESS, 16, 4, buf,
+				     *buflen, 1);
+	}
 
 	return ret;
 unmap_ctx:
@@ -3592,7 +3572,7 @@ static int ahash_final_ctx(struct ahash_request *req)
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		      GFP_KERNEL : GFP_ATOMIC;
-	int buflen = *current_buflen(state);
+	int buflen = state->buflen;
 	int qm_sg_bytes;
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct ahash_edesc *edesc;
@@ -3663,7 +3643,7 @@ static int ahash_finup_ctx(struct ahash_request *req)
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		      GFP_KERNEL : GFP_ATOMIC;
-	int buflen = *current_buflen(state);
+	int buflen = state->buflen;
 	int qm_sg_bytes, qm_sg_src_index;
 	int src_nents, mapped_nents;
 	int digestsize = crypto_ahash_digestsize(ahash);
@@ -3852,8 +3832,8 @@ static int ahash_final_no_ctx(struct ahash_request *req)
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		      GFP_KERNEL : GFP_ATOMIC;
-	u8 *buf = current_buf(state);
-	int buflen = *current_buflen(state);
+	u8 *buf = state->buf;
+	int buflen = state->buflen;
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct ahash_edesc *edesc;
 	int ret = -ENOMEM;
@@ -3925,10 +3905,9 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		      GFP_KERNEL : GFP_ATOMIC;
-	u8 *buf = current_buf(state);
-	int *buflen = current_buflen(state);
-	u8 *next_buf = alt_buf(state);
-	int *next_buflen = alt_buflen(state);
+	u8 *buf = state->buf;
+	int *buflen = &state->buflen;
+	int *next_buflen = &state->next_buflen;
 	int in_len = *buflen + req->nbytes, to_hash;
 	int qm_sg_bytes, src_nents, mapped_nents;
 	struct ahash_edesc *edesc;
@@ -3977,11 +3956,6 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 
 		sg_to_qm_sg_last(req->src, src_len, sg_table + 1, 0);
 
-		if (*next_buflen)
-			scatterwalk_map_and_copy(next_buf, req->src,
-						 to_hash - *buflen,
-						 *next_buflen, 0);
-
 		edesc->qm_sg_dma = dma_map_single(ctx->dev, sg_table,
 						  qm_sg_bytes, DMA_TO_DEVICE);
 		if (dma_mapping_error(ctx->dev, edesc->qm_sg_dma)) {
@@ -4029,14 +4003,11 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 		scatterwalk_map_and_copy(buf + *buflen, req->src, 0,
 					 req->nbytes, 0);
 		*buflen = *next_buflen;
-		*next_buflen = 0;
-	}
 
-	print_hex_dump_debug("buf@" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, buf, *buflen, 1);
-	print_hex_dump_debug("next buf@" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, next_buf, *next_buflen,
-			     1);
+		print_hex_dump_debug("buf@" __stringify(__LINE__)": ",
+				     DUMP_PREFIX_ADDRESS, 16, 4, buf,
+				     *buflen, 1);
+	}
 
 	return ret;
 unmap_ctx:
@@ -4055,7 +4026,7 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		      GFP_KERNEL : GFP_ATOMIC;
-	int buflen = *current_buflen(state);
+	int buflen = state->buflen;
 	int qm_sg_bytes, src_nents, mapped_nents;
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct ahash_edesc *edesc;
@@ -4151,8 +4122,9 @@ static int ahash_update_first(struct ahash_request *req)
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		      GFP_KERNEL : GFP_ATOMIC;
-	u8 *next_buf = alt_buf(state);
-	int *next_buflen = alt_buflen(state);
+	u8 *buf = state->buf;
+	int *buflen = &state->buflen;
+	int *next_buflen = &state->next_buflen;
 	int to_hash;
 	int src_nents, mapped_nents;
 	struct ahash_edesc *edesc;
@@ -4220,10 +4192,6 @@ static int ahash_update_first(struct ahash_request *req)
 			dpaa2_fl_set_addr(in_fle, sg_dma_address(req->src));
 		}
 
-		if (*next_buflen)
-			scatterwalk_map_and_copy(next_buf, req->src, to_hash,
-						 *next_buflen, 0);
-
 		state->ctx_dma_len = ctx->ctx_len;
 		state->ctx_dma = dma_map_single(ctx->dev, state->caam_ctx,
 						ctx->ctx_len, DMA_FROM_DEVICE);
@@ -4257,14 +4225,14 @@ static int ahash_update_first(struct ahash_request *req)
 		state->update = ahash_update_no_ctx;
 		state->finup = ahash_finup_no_ctx;
 		state->final = ahash_final_no_ctx;
-		scatterwalk_map_and_copy(next_buf, req->src, 0,
+		scatterwalk_map_and_copy(buf, req->src, 0,
 					 req->nbytes, 0);
-		switch_buf(state);
-	}
+		*buflen = *next_buflen;
 
-	print_hex_dump_debug("next buf@" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, next_buf, *next_buflen,
-			     1);
+		print_hex_dump_debug("buf@" __stringify(__LINE__)": ",
+				     DUMP_PREFIX_ADDRESS, 16, 4, buf,
+				     *buflen, 1);
+	}
 
 	return ret;
 unmap_ctx:
@@ -4288,10 +4256,9 @@ static int ahash_init(struct ahash_request *req)
 
 	state->ctx_dma = 0;
 	state->ctx_dma_len = 0;
-	state->current_buf = 0;
 	state->buf_dma = 0;
-	state->buflen_0 = 0;
-	state->buflen_1 = 0;
+	state->buflen = 0;
+	state->next_buflen = 0;
 
 	return 0;
 }
@@ -4321,16 +4288,8 @@ static int ahash_export(struct ahash_request *req, void *out)
 {
 	struct caam_hash_state *state = ahash_request_ctx(req);
 	struct caam_export_state *export = out;
-	int len;
-	u8 *buf;
-
-	if (state->current_buf) {
-		buf = state->buf_1;
-		len = state->buflen_1;
-	} else {
-		buf = state->buf_0;
-		len = state->buflen_0;
-	}
+	u8 *buf = state->buf;
+	int len = state->buflen;
 
 	memcpy(export->buf, buf, len);
 	memcpy(export->caam_ctx, state->caam_ctx, sizeof(export->caam_ctx));
@@ -4348,9 +4307,9 @@ static int ahash_import(struct ahash_request *req, const void *in)
 	const struct caam_export_state *export = in;
 
 	memset(state, 0, sizeof(*state));
-	memcpy(state->buf_0, export->buf, export->buflen);
+	memcpy(state->buf, export->buf, export->buflen);
 	memcpy(state->caam_ctx, export->caam_ctx, sizeof(state->caam_ctx));
-	state->buflen_0 = export->buflen;
+	state->buflen = export->buflen;
 	state->update = export->update;
 	state->final = export->final;
 	state->finup = export->finup;
-- 
2.17.1

