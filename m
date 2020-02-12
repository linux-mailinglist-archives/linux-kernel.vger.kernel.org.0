Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE43A15AF39
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 18:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgBLRzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 12:55:55 -0500
Received: from inva021.nxp.com ([92.121.34.21]:45240 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbgBLRzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:55:53 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 51E0D2076A9;
        Wed, 12 Feb 2020 18:55:50 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 44EC8207661;
        Wed, 12 Feb 2020 18:55:50 +0100 (CET)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id DA02120567;
        Wed, 12 Feb 2020 18:55:49 +0100 (CET)
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
Subject: [PATCH v6 3/9] crypto: caam - refactor ahash_edesc_alloc
Date:   Wed, 12 Feb 2020 19:55:18 +0200
Message-Id: <1581530124-9135-4-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1581530124-9135-1-git-send-email-iuliana.prodan@nxp.com>
References: <1581530124-9135-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed parameters for ahash_edesc_alloc function:
- remove flags since they can be computed in
ahash_edesc_alloc, the only place they are needed;
- use ahash_request instead of caam_hash_ctx, to be
able to compute gfp flags.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
---
 drivers/crypto/caam/caamhash.c | 62 +++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 59881a8..4db8507 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -661,11 +661,14 @@ static void ahash_done_ctx_dst(struct device *jrdev, u32 *desc, u32 err,
  * Allocate an enhanced descriptor, which contains the hardware descriptor
  * and space for hardware scatter table containing sg_num entries.
  */
-static struct ahash_edesc *ahash_edesc_alloc(struct caam_hash_ctx *ctx,
+static struct ahash_edesc *ahash_edesc_alloc(struct ahash_request *req,
 					     int sg_num, u32 *sh_desc,
-					     dma_addr_t sh_desc_dma,
-					     gfp_t flags)
+					     dma_addr_t sh_desc_dma)
 {
+	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
+		       GFP_KERNEL : GFP_ATOMIC;
 	struct ahash_edesc *edesc;
 	unsigned int sg_size = sg_num * sizeof(struct sec4_sg_entry);
 
@@ -724,8 +727,6 @@ static int ahash_update_ctx(struct ahash_request *req)
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
 	struct caam_hash_state *state = ahash_request_ctx(req);
 	struct device *jrdev = ctx->jrdev;
-	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
-		       GFP_KERNEL : GFP_ATOMIC;
 	u8 *buf = state->buf;
 	int *buflen = &state->buflen;
 	int *next_buflen = &state->next_buflen;
@@ -779,8 +780,8 @@ static int ahash_update_ctx(struct ahash_request *req)
 		 * allocate space for base edesc and hw desc commands,
 		 * link tables
 		 */
-		edesc = ahash_edesc_alloc(ctx, pad_nents, ctx->sh_desc_update,
-					  ctx->sh_desc_update_dma, flags);
+		edesc = ahash_edesc_alloc(req, pad_nents, ctx->sh_desc_update,
+					  ctx->sh_desc_update_dma);
 		if (!edesc) {
 			dma_unmap_sg(jrdev, req->src, src_nents, DMA_TO_DEVICE);
 			return -ENOMEM;
@@ -854,8 +855,6 @@ static int ahash_final_ctx(struct ahash_request *req)
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
 	struct caam_hash_state *state = ahash_request_ctx(req);
 	struct device *jrdev = ctx->jrdev;
-	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
-		       GFP_KERNEL : GFP_ATOMIC;
 	int buflen = state->buflen;
 	u32 *desc;
 	int sec4_sg_bytes;
@@ -867,8 +866,8 @@ static int ahash_final_ctx(struct ahash_request *req)
 			sizeof(struct sec4_sg_entry);
 
 	/* allocate space for base edesc and hw desc commands, link tables */
-	edesc = ahash_edesc_alloc(ctx, 4, ctx->sh_desc_fin,
-				  ctx->sh_desc_fin_dma, flags);
+	edesc = ahash_edesc_alloc(req, 4, ctx->sh_desc_fin,
+				  ctx->sh_desc_fin_dma);
 	if (!edesc)
 		return -ENOMEM;
 
@@ -920,8 +919,6 @@ static int ahash_finup_ctx(struct ahash_request *req)
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
 	struct caam_hash_state *state = ahash_request_ctx(req);
 	struct device *jrdev = ctx->jrdev;
-	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
-		       GFP_KERNEL : GFP_ATOMIC;
 	int buflen = state->buflen;
 	u32 *desc;
 	int sec4_sg_src_index;
@@ -950,9 +947,8 @@ static int ahash_finup_ctx(struct ahash_request *req)
 	sec4_sg_src_index = 1 + (buflen ? 1 : 0);
 
 	/* allocate space for base edesc and hw desc commands, link tables */
-	edesc = ahash_edesc_alloc(ctx, sec4_sg_src_index + mapped_nents,
-				  ctx->sh_desc_fin, ctx->sh_desc_fin_dma,
-				  flags);
+	edesc = ahash_edesc_alloc(req, sec4_sg_src_index + mapped_nents,
+				  ctx->sh_desc_fin, ctx->sh_desc_fin_dma);
 	if (!edesc) {
 		dma_unmap_sg(jrdev, req->src, src_nents, DMA_TO_DEVICE);
 		return -ENOMEM;
@@ -1000,8 +996,6 @@ static int ahash_digest(struct ahash_request *req)
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
 	struct caam_hash_state *state = ahash_request_ctx(req);
 	struct device *jrdev = ctx->jrdev;
-	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
-		       GFP_KERNEL : GFP_ATOMIC;
 	u32 *desc;
 	int digestsize = crypto_ahash_digestsize(ahash);
 	int src_nents, mapped_nents;
@@ -1028,9 +1022,8 @@ static int ahash_digest(struct ahash_request *req)
 	}
 
 	/* allocate space for base edesc and hw desc commands, link tables */
-	edesc = ahash_edesc_alloc(ctx, mapped_nents > 1 ? mapped_nents : 0,
-				  ctx->sh_desc_digest, ctx->sh_desc_digest_dma,
-				  flags);
+	edesc = ahash_edesc_alloc(req, mapped_nents > 1 ? mapped_nents : 0,
+				  ctx->sh_desc_digest, ctx->sh_desc_digest_dma);
 	if (!edesc) {
 		dma_unmap_sg(jrdev, req->src, src_nents, DMA_TO_DEVICE);
 		return -ENOMEM;
@@ -1077,8 +1070,6 @@ static int ahash_final_no_ctx(struct ahash_request *req)
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
 	struct caam_hash_state *state = ahash_request_ctx(req);
 	struct device *jrdev = ctx->jrdev;
-	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
-		       GFP_KERNEL : GFP_ATOMIC;
 	u8 *buf = state->buf;
 	int buflen = state->buflen;
 	u32 *desc;
@@ -1087,8 +1078,8 @@ static int ahash_final_no_ctx(struct ahash_request *req)
 	int ret;
 
 	/* allocate space for base edesc and hw desc commands, link tables */
-	edesc = ahash_edesc_alloc(ctx, 0, ctx->sh_desc_digest,
-				  ctx->sh_desc_digest_dma, flags);
+	edesc = ahash_edesc_alloc(req, 0, ctx->sh_desc_digest,
+				  ctx->sh_desc_digest_dma);
 	if (!edesc)
 		return -ENOMEM;
 
@@ -1136,8 +1127,6 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
 	struct caam_hash_state *state = ahash_request_ctx(req);
 	struct device *jrdev = ctx->jrdev;
-	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
-		       GFP_KERNEL : GFP_ATOMIC;
 	u8 *buf = state->buf;
 	int *buflen = &state->buflen;
 	int *next_buflen = &state->next_buflen;
@@ -1190,10 +1179,9 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 		 * allocate space for base edesc and hw desc commands,
 		 * link tables
 		 */
-		edesc = ahash_edesc_alloc(ctx, pad_nents,
+		edesc = ahash_edesc_alloc(req, pad_nents,
 					  ctx->sh_desc_update_first,
-					  ctx->sh_desc_update_first_dma,
-					  flags);
+					  ctx->sh_desc_update_first_dma);
 		if (!edesc) {
 			dma_unmap_sg(jrdev, req->src, src_nents, DMA_TO_DEVICE);
 			return -ENOMEM;
@@ -1261,8 +1249,6 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
 	struct caam_hash_state *state = ahash_request_ctx(req);
 	struct device *jrdev = ctx->jrdev;
-	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
-		       GFP_KERNEL : GFP_ATOMIC;
 	int buflen = state->buflen;
 	u32 *desc;
 	int sec4_sg_bytes, sec4_sg_src_index, src_nents, mapped_nents;
@@ -1292,9 +1278,8 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
 			 sizeof(struct sec4_sg_entry);
 
 	/* allocate space for base edesc and hw desc commands, link tables */
-	edesc = ahash_edesc_alloc(ctx, sec4_sg_src_index + mapped_nents,
-				  ctx->sh_desc_digest, ctx->sh_desc_digest_dma,
-				  flags);
+	edesc = ahash_edesc_alloc(req, sec4_sg_src_index + mapped_nents,
+				  ctx->sh_desc_digest, ctx->sh_desc_digest_dma);
 	if (!edesc) {
 		dma_unmap_sg(jrdev, req->src, src_nents, DMA_TO_DEVICE);
 		return -ENOMEM;
@@ -1347,8 +1332,6 @@ static int ahash_update_first(struct ahash_request *req)
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
 	struct caam_hash_state *state = ahash_request_ctx(req);
 	struct device *jrdev = ctx->jrdev;
-	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
-		       GFP_KERNEL : GFP_ATOMIC;
 	u8 *buf = state->buf;
 	int *buflen = &state->buflen;
 	int *next_buflen = &state->next_buflen;
@@ -1396,11 +1379,10 @@ static int ahash_update_first(struct ahash_request *req)
 		 * allocate space for base edesc and hw desc commands,
 		 * link tables
 		 */
-		edesc = ahash_edesc_alloc(ctx, mapped_nents > 1 ?
+		edesc = ahash_edesc_alloc(req, mapped_nents > 1 ?
 					  mapped_nents : 0,
 					  ctx->sh_desc_update_first,
-					  ctx->sh_desc_update_first_dma,
-					  flags);
+					  ctx->sh_desc_update_first_dma);
 		if (!edesc) {
 			dma_unmap_sg(jrdev, req->src, src_nents, DMA_TO_DEVICE);
 			return -ENOMEM;
-- 
2.1.0

