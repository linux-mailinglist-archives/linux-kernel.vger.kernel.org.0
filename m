Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39CB614D4CC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 01:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgA3Atu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 19:49:50 -0500
Received: from inva021.nxp.com ([92.121.34.21]:52962 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbgA3Att (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 19:49:49 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7BBB9203E31;
        Thu, 30 Jan 2020 01:49:47 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D2D020120D;
        Thu, 30 Jan 2020 01:49:47 +0100 (CET)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0EEAD204BE;
        Thu, 30 Jan 2020 01:49:47 +0100 (CET)
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
Subject: [PATCH v5 9/9] crypto: caam - add crypto_engine support for HASH algorithms
Date:   Thu, 30 Jan 2020 02:49:24 +0200
Message-Id: <1580345364-7606-10-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1580345364-7606-1-git-send-email-iuliana.prodan@nxp.com>
References: <1580345364-7606-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto_engine support for HASH algorithms, to make use of
the engine queue.
The requests, with backlog flag, will be listed into crypto-engine
queue and processed by CAAM when free.
Only the backlog request are sent to crypto-engine since the others
can be handled by CAAM, if free, especially since JR has up to 1024
entries (more than the 10 entries from crypto-engine).

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/crypto/caam/caamhash.c | 177 +++++++++++++++++++++++++++++------------
 1 file changed, 128 insertions(+), 49 deletions(-)

diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 2af9e66..63c7ef7 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -65,6 +65,7 @@
 #include "sg_sw_sec4.h"
 #include "key_gen.h"
 #include "caamhash_desc.h"
+#include <crypto/engine.h>
 
 #define CAAM_CRA_PRIORITY		3000
 
@@ -86,6 +87,7 @@ static struct list_head hash_list;
 
 /* ahash per-session context */
 struct caam_hash_ctx {
+	struct crypto_engine_ctx enginectx;
 	u32 sh_desc_update[DESC_HASH_MAX_USED_LEN] ____cacheline_aligned;
 	u32 sh_desc_update_first[DESC_HASH_MAX_USED_LEN] ____cacheline_aligned;
 	u32 sh_desc_fin[DESC_HASH_MAX_USED_LEN] ____cacheline_aligned;
@@ -111,9 +113,12 @@ struct caam_hash_state {
 	int buflen;
 	int next_buflen;
 	u8 caam_ctx[MAX_CTX_LEN] ____cacheline_aligned;
-	int (*update)(struct ahash_request *req);
+	int (*update)(struct ahash_request *req) ____cacheline_aligned;
 	int (*final)(struct ahash_request *req);
 	int (*finup)(struct ahash_request *req);
+	struct ahash_edesc *edesc;
+	void (*ahash_op_done)(struct device *jrdev, u32 *desc, u32 err,
+			      void *context);
 };
 
 struct caam_export_state {
@@ -123,6 +128,9 @@ struct caam_export_state {
 	int (*update)(struct ahash_request *req);
 	int (*final)(struct ahash_request *req);
 	int (*finup)(struct ahash_request *req);
+	struct ahash_edesc *edesc;
+	void (*ahash_op_done)(struct device *jrdev, u32 *desc, u32 err,
+			      void *context);
 };
 
 static inline bool is_cmac_aes(u32 algtype)
@@ -521,6 +529,7 @@ static int acmac_setkey(struct crypto_ahash *ahash, const u8 *key,
  * @sec4_sg_dma: physical mapped address of h/w link table
  * @src_nents: number of segments in input scatterlist
  * @sec4_sg_bytes: length of dma mapped sec4_sg space
+ * @bklog: stored to determine if the request needs backlog
  * @hw_desc: the h/w job descriptor followed by any referenced link tables
  * @sec4_sg: h/w link table
  */
@@ -528,6 +537,7 @@ struct ahash_edesc {
 	dma_addr_t sec4_sg_dma;
 	int src_nents;
 	int sec4_sg_bytes;
+	bool bklog;
 	u32 hw_desc[DESC_JOB_IO_LEN_MAX / sizeof(u32)] ____cacheline_aligned;
 	struct sec4_sg_entry sec4_sg[0];
 };
@@ -569,6 +579,7 @@ static inline void ahash_done_cpy(struct device *jrdev, u32 *desc, u32 err,
 				  void *context, enum dma_data_direction dir)
 {
 	struct ahash_request *req = context;
+	struct caam_drv_private_jr *jrp = dev_get_drvdata(jrdev);
 	struct ahash_edesc *edesc;
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
 	int digestsize = crypto_ahash_digestsize(ahash);
@@ -578,7 +589,8 @@ static inline void ahash_done_cpy(struct device *jrdev, u32 *desc, u32 err,
 
 	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
-	edesc = container_of(desc, struct ahash_edesc, hw_desc[0]);
+	edesc = state->edesc;
+
 	if (err)
 		ecode = caam_jr_strstatus(jrdev, err);
 
@@ -590,7 +602,14 @@ static inline void ahash_done_cpy(struct device *jrdev, u32 *desc, u32 err,
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
 			     ctx->ctx_len, 1);
 
-	req->base.complete(&req->base, ecode);
+	/*
+	 * If no backlog flag, the completion of the request is done
+	 * by CAAM, not crypto engine.
+	 */
+	if (!edesc->bklog)
+		req->base.complete(&req->base, ecode);
+	else
+		crypto_finalize_hash_request(jrp->engine, req, ecode);
 }
 
 static void ahash_done(struct device *jrdev, u32 *desc, u32 err,
@@ -609,6 +628,7 @@ static inline void ahash_done_switch(struct device *jrdev, u32 *desc, u32 err,
 				     void *context, enum dma_data_direction dir)
 {
 	struct ahash_request *req = context;
+	struct caam_drv_private_jr *jrp = dev_get_drvdata(jrdev);
 	struct ahash_edesc *edesc;
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
@@ -618,7 +638,7 @@ static inline void ahash_done_switch(struct device *jrdev, u32 *desc, u32 err,
 
 	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
-	edesc = container_of(desc, struct ahash_edesc, hw_desc[0]);
+	edesc = state->edesc;
 	if (err)
 		ecode = caam_jr_strstatus(jrdev, err);
 
@@ -642,7 +662,15 @@ static inline void ahash_done_switch(struct device *jrdev, u32 *desc, u32 err,
 				     DUMP_PREFIX_ADDRESS, 16, 4, req->result,
 				     digestsize, 1);
 
-	req->base.complete(&req->base, ecode);
+	/*
+	 * If no backlog flag, the completion of the request is done
+	 * by CAAM, not crypto engine.
+	 */
+	if (!edesc->bklog)
+		req->base.complete(&req->base, ecode);
+	else
+		crypto_finalize_hash_request(jrp->engine, req, ecode);
+
 }
 
 static void ahash_done_bi(struct device *jrdev, u32 *desc, u32 err,
@@ -667,6 +695,7 @@ static struct ahash_edesc *ahash_edesc_alloc(struct ahash_request *req,
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct caam_hash_state *state = ahash_request_ctx(req);
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		       GFP_KERNEL : GFP_ATOMIC;
 	struct ahash_edesc *edesc;
@@ -678,6 +707,8 @@ static struct ahash_edesc *ahash_edesc_alloc(struct ahash_request *req,
 		return NULL;
 	}
 
+	state->edesc = edesc;
+
 	init_job_desc_shared(edesc->hw_desc, sh_desc_dma, desc_len(sh_desc),
 			     HDR_SHARE_DEFER | HDR_REVERSE);
 
@@ -720,6 +751,62 @@ static int ahash_edesc_add_src(struct caam_hash_ctx *ctx,
 	return 0;
 }
 
+static int ahash_do_one_req(struct crypto_engine *engine, void *areq)
+{
+	struct ahash_request *req = ahash_request_cast(areq);
+	struct caam_hash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
+	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct device *jrdev = ctx->jrdev;
+	u32 *desc = state->edesc->hw_desc;
+	int ret;
+
+	state->edesc->bklog = true;
+
+	ret = caam_jr_enqueue(jrdev, desc, state->ahash_op_done, req);
+
+	if (ret != -EINPROGRESS) {
+		ahash_unmap(jrdev, state->edesc, req, 0);
+		kfree(state->edesc);
+	} else {
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int ahash_enqueue_req(struct device *jrdev,
+			     void (*cbk)(struct device *jrdev, u32 *desc,
+					 u32 err, void *context),
+			     struct ahash_request *req,
+			     int dst_len, enum dma_data_direction dir)
+{
+	struct caam_drv_private_jr *jrpriv = dev_get_drvdata(jrdev);
+	struct caam_hash_state *state = ahash_request_ctx(req);
+	struct ahash_edesc *edesc = state->edesc;
+	u32 *desc = edesc->hw_desc;
+	int ret;
+
+	state->ahash_op_done = cbk;
+
+	/*
+	 * Only the backlog request are sent to crypto-engine since the others
+	 * can be handled by CAAM, if free, especially since JR has up to 1024
+	 * entries (more than the 10 entries from crypto-engine).
+	 */
+	if (req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)
+		ret = crypto_transfer_hash_request_to_engine(jrpriv->engine,
+							     req);
+	else
+		ret = caam_jr_enqueue(jrdev, desc, cbk, req);
+
+	if ((ret != -EINPROGRESS) && (ret != -EBUSY)) {
+		ahash_unmap_ctx(jrdev, edesc, req, dst_len, dir);
+		kfree(edesc);
+	}
+
+	return ret;
+}
+
 /* submit update job descriptor */
 static int ahash_update_ctx(struct ahash_request *req)
 {
@@ -827,9 +914,8 @@ static int ahash_update_ctx(struct ahash_request *req)
 				     DUMP_PREFIX_ADDRESS, 16, 4, desc,
 				     desc_bytes(desc), 1);
 
-		ret = caam_jr_enqueue(jrdev, desc, ahash_done_bi, req);
-		if (ret != -EINPROGRESS)
-			goto unmap_ctx;
+		ret = ahash_enqueue_req(jrdev, ahash_done_bi, req,
+					ctx->ctx_len, DMA_BIDIRECTIONAL);
 	} else if (*next_buflen) {
 		scatterwalk_map_and_copy(buf + *buflen, req->src, 0,
 					 req->nbytes, 0);
@@ -900,10 +986,8 @@ static int ahash_final_ctx(struct ahash_request *req)
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
 			     1);
 
-	ret = caam_jr_enqueue(jrdev, desc, ahash_done_ctx_src, req);
-	if (ret == -EINPROGRESS)
-		return ret;
-
+	return ahash_enqueue_req(jrdev, ahash_done_ctx_src, req,
+				 digestsize, DMA_BIDIRECTIONAL);
  unmap_ctx:
 	ahash_unmap_ctx(jrdev, edesc, req, digestsize, DMA_BIDIRECTIONAL);
 	kfree(edesc);
@@ -976,10 +1060,8 @@ static int ahash_finup_ctx(struct ahash_request *req)
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
 			     1);
 
-	ret = caam_jr_enqueue(jrdev, desc, ahash_done_ctx_src, req);
-	if (ret == -EINPROGRESS)
-		return ret;
-
+	return ahash_enqueue_req(jrdev, ahash_done_ctx_src, req,
+				 digestsize, DMA_BIDIRECTIONAL);
  unmap_ctx:
 	ahash_unmap_ctx(jrdev, edesc, req, digestsize, DMA_BIDIRECTIONAL);
 	kfree(edesc);
@@ -1048,13 +1130,8 @@ static int ahash_digest(struct ahash_request *req)
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
 			     1);
 
-	ret = caam_jr_enqueue(jrdev, desc, ahash_done, req);
-	if (ret != -EINPROGRESS) {
-		ahash_unmap_ctx(jrdev, edesc, req, digestsize, DMA_FROM_DEVICE);
-		kfree(edesc);
-	}
-
-	return ret;
+	return ahash_enqueue_req(jrdev, ahash_done, req, digestsize,
+				 DMA_FROM_DEVICE);
 }
 
 /* submit ahash final if it the first job descriptor */
@@ -1098,18 +1175,12 @@ static int ahash_final_no_ctx(struct ahash_request *req)
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
 			     1);
 
-	ret = caam_jr_enqueue(jrdev, desc, ahash_done, req);
-	if (ret != -EINPROGRESS) {
-		ahash_unmap_ctx(jrdev, edesc, req, digestsize, DMA_FROM_DEVICE);
-		kfree(edesc);
-	}
-
-	return ret;
+	return ahash_enqueue_req(jrdev, ahash_done, req,
+				 digestsize, DMA_FROM_DEVICE);
  unmap:
 	ahash_unmap(jrdev, edesc, req, digestsize);
 	kfree(edesc);
 	return -ENOMEM;
-
 }
 
 /* submit ahash update if it the first job descriptor after update */
@@ -1209,9 +1280,8 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 				     DUMP_PREFIX_ADDRESS, 16, 4, desc,
 				     desc_bytes(desc), 1);
 
-		ret = caam_jr_enqueue(jrdev, desc, ahash_done_ctx_dst, req);
-		if (ret != -EINPROGRESS)
-			goto unmap_ctx;
+		ret = ahash_enqueue_req(jrdev, ahash_done_ctx_dst, req,
+					ctx->ctx_len, DMA_TO_DEVICE);
 
 		state->update = ahash_update_ctx;
 		state->finup = ahash_finup_ctx;
@@ -1300,13 +1370,8 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
 			     1);
 
-	ret = caam_jr_enqueue(jrdev, desc, ahash_done, req);
-	if (ret != -EINPROGRESS) {
-		ahash_unmap_ctx(jrdev, edesc, req, digestsize, DMA_FROM_DEVICE);
-		kfree(edesc);
-	}
-
-	return ret;
+	return ahash_enqueue_req(jrdev, ahash_done, req,
+				 digestsize, DMA_FROM_DEVICE);
  unmap:
 	ahash_unmap(jrdev, edesc, req, digestsize);
 	kfree(edesc);
@@ -1394,9 +1459,8 @@ static int ahash_update_first(struct ahash_request *req)
 				     DUMP_PREFIX_ADDRESS, 16, 4, desc,
 				     desc_bytes(desc), 1);
 
-		ret = caam_jr_enqueue(jrdev, desc, ahash_done_ctx_dst, req);
-		if (ret != -EINPROGRESS)
-			goto unmap_ctx;
+		ret = ahash_enqueue_req(jrdev, ahash_done_ctx_dst, req,
+					ctx->ctx_len, DMA_TO_DEVICE);
 
 		state->update = ahash_update_ctx;
 		state->finup = ahash_finup_ctx;
@@ -1477,6 +1541,8 @@ static int ahash_export(struct ahash_request *req, void *out)
 	export->update = state->update;
 	export->final = state->final;
 	export->finup = state->finup;
+	export->edesc = state->edesc;
+	export->ahash_op_done = state->ahash_op_done;
 
 	return 0;
 }
@@ -1493,6 +1559,8 @@ static int ahash_import(struct ahash_request *req, const void *in)
 	state->update = export->update;
 	state->final = export->final;
 	state->finup = export->finup;
+	state->edesc = export->edesc;
+	state->ahash_op_done = export->ahash_op_done;
 
 	return 0;
 }
@@ -1752,7 +1820,9 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 	}
 
 	dma_addr = dma_map_single_attrs(ctx->jrdev, ctx->sh_desc_update,
-					offsetof(struct caam_hash_ctx, key),
+					offsetof(struct caam_hash_ctx, key) -
+					offsetof(struct caam_hash_ctx,
+						 sh_desc_update),
 					ctx->dir, DMA_ATTR_SKIP_CPU_SYNC);
 	if (dma_mapping_error(ctx->jrdev, dma_addr)) {
 		dev_err(ctx->jrdev, "unable to map shared descriptors\n");
@@ -1770,11 +1840,19 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 	ctx->sh_desc_update_dma = dma_addr;
 	ctx->sh_desc_update_first_dma = dma_addr +
 					offsetof(struct caam_hash_ctx,
-						 sh_desc_update_first);
+						 sh_desc_update_first) -
+					offsetof(struct caam_hash_ctx,
+						 sh_desc_update);
 	ctx->sh_desc_fin_dma = dma_addr + offsetof(struct caam_hash_ctx,
-						   sh_desc_fin);
+						   sh_desc_fin) -
+					  offsetof(struct caam_hash_ctx,
+						   sh_desc_update);
 	ctx->sh_desc_digest_dma = dma_addr + offsetof(struct caam_hash_ctx,
-						      sh_desc_digest);
+						      sh_desc_digest) -
+					     offsetof(struct caam_hash_ctx,
+						      sh_desc_update);
+
+	ctx->enginectx.op.do_one_request = ahash_do_one_req;
 
 	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
 				 sizeof(struct caam_hash_state));
@@ -1791,7 +1869,8 @@ static void caam_hash_cra_exit(struct crypto_tfm *tfm)
 	struct caam_hash_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	dma_unmap_single_attrs(ctx->jrdev, ctx->sh_desc_update_dma,
-			       offsetof(struct caam_hash_ctx, key),
+			       offsetof(struct caam_hash_ctx, key) -
+			       offsetof(struct caam_hash_ctx, sh_desc_update),
 			       ctx->dir, DMA_ATTR_SKIP_CPU_SYNC);
 	if (ctx->key_dir != DMA_NONE)
 		dma_unmap_single_attrs(ctx->jrdev, ctx->adata.key_dma,
-- 
2.1.0

