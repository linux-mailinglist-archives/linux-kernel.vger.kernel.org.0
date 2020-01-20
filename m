Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8B142AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 13:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgATMZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 07:25:18 -0500
Received: from inva021.nxp.com ([92.121.34.21]:46908 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgATMYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:24:19 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E9DE3201523;
        Mon, 20 Jan 2020 13:24:16 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DC9EF20136B;
        Mon, 20 Jan 2020 13:24:16 +0100 (CET)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 71C8E20414;
        Mon, 20 Jan 2020 13:24:16 +0100 (CET)
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
Subject: [PATCH v4 6/9] crypto: caam - support crypto_engine framework for SKCIPHER algorithms
Date:   Mon, 20 Jan 2020 14:24:05 +0200
Message-Id: <1579523048-21078-7-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1579523048-21078-1-git-send-email-iuliana.prodan@nxp.com>
References: <1579523048-21078-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Integrate crypto_engine into CAAM, to make use of the engine queue.
Add support for SKCIPHER algorithms.

This is intended to be used for CAAM backlogging support.
The requests, with backlog flag (e.g. from dm-crypt) will be listed
into crypto-engine queue and processed by CAAM when free.
This changes the return codes for enqueuing a request:
-EINPROGRESS if OK, -EBUSY if request is backlogged (via
crypto-engine), -ENOSPC if the queue is full, -EIO if it
cannot map the caller's descriptor.

The requests, with backlog flag, will be listed into crypto-engine
queue and processed by CAAM when free. Only the backlog request are
sent to crypto-engine since the others can be handled by CAAM, if free,
especially since JR has up to 1024 entries (more than the 10 entries
from crypto-engine).

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
---
 drivers/crypto/caam/Kconfig   |  1 +
 drivers/crypto/caam/caamalg.c | 80 ++++++++++++++++++++++++++++++++++++++-----
 drivers/crypto/caam/intern.h  |  2 ++
 drivers/crypto/caam/jr.c      | 29 ++++++++++++++++
 4 files changed, 104 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/caam/Kconfig b/drivers/crypto/caam/Kconfig
index fac5b2e..64f8226 100644
--- a/drivers/crypto/caam/Kconfig
+++ b/drivers/crypto/caam/Kconfig
@@ -33,6 +33,7 @@ config CRYPTO_DEV_FSL_CAAM_DEBUG
 
 menuconfig CRYPTO_DEV_FSL_CAAM_JR
 	tristate "Freescale CAAM Job Ring driver backend"
+	select CRYPTO_ENGINE
 	default y
 	help
 	  Enables the driver module for Job Rings which are part of
diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index c1dd885..292db60 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -56,6 +56,7 @@
 #include "sg_sw_sec4.h"
 #include "key_gen.h"
 #include "caamalg_desc.h"
+#include <crypto/engine.h>
 
 /*
  * crypto alg
@@ -101,6 +102,7 @@ struct caam_skcipher_alg {
  * per-session context
  */
 struct caam_ctx {
+	struct crypto_engine_ctx enginectx;
 	u32 sh_desc_enc[DESC_MAX_USED_LEN];
 	u32 sh_desc_dec[DESC_MAX_USED_LEN];
 	u8 key[CAAM_MAX_KEY_SIZE];
@@ -114,6 +116,10 @@ struct caam_ctx {
 	unsigned int authsize;
 };
 
+struct caam_skcipher_req_ctx {
+	struct skcipher_edesc *edesc;
+};
+
 static int aead_null_set_sh_desc(struct crypto_aead *aead)
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(aead);
@@ -882,6 +888,7 @@ struct aead_edesc {
  * @iv_dma: dma address of iv for checking continuity and link table
  * @sec4_sg_bytes: length of dma mapped sec4_sg space
  * @sec4_sg_dma: bus physical mapped address of h/w link table
+ * @bklog: stored to determine if the request needs backlog
  * @sec4_sg: pointer to h/w link table
  * @hw_desc: the h/w job descriptor followed by any referenced link tables
  *	     and IV
@@ -894,6 +901,7 @@ struct skcipher_edesc {
 	dma_addr_t iv_dma;
 	int sec4_sg_bytes;
 	dma_addr_t sec4_sg_dma;
+	bool bklog;
 	struct sec4_sg_entry *sec4_sg;
 	u32 hw_desc[0];
 };
@@ -967,13 +975,15 @@ static void skcipher_crypt_done(struct device *jrdev, u32 *desc, u32 err,
 {
 	struct skcipher_request *req = context;
 	struct skcipher_edesc *edesc;
+	struct caam_skcipher_req_ctx *rctx = skcipher_request_ctx(req);
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
+	struct caam_drv_private_jr *jrp = dev_get_drvdata(jrdev);
 	int ivsize = crypto_skcipher_ivsize(skcipher);
 	int ecode = 0;
 
 	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
-	edesc = container_of(desc, struct skcipher_edesc, hw_desc[0]);
+	edesc = rctx->edesc;
 	if (err)
 		ecode = caam_jr_strstatus(jrdev, err);
 
@@ -999,7 +1009,14 @@ static void skcipher_crypt_done(struct device *jrdev, u32 *desc, u32 err,
 
 	kfree(edesc);
 
-	skcipher_request_complete(req, ecode);
+	/*
+	 * If no backlog flag, the completion of the request is done
+	 * by CAAM, not crypto engine.
+	 */
+	if (!edesc->bklog)
+		skcipher_request_complete(req, ecode);
+	else
+		crypto_finalize_skcipher_request(jrp->engine, req, ecode);
 }
 
 /*
@@ -1520,6 +1537,7 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 {
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
 	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
+	struct caam_skcipher_req_ctx *rctx = skcipher_request_ctx(req);
 	struct device *jrdev = ctx->jrdev;
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		       GFP_KERNEL : GFP_ATOMIC;
@@ -1618,6 +1636,8 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 	edesc->sec4_sg_bytes = sec4_sg_bytes;
 	edesc->sec4_sg = (struct sec4_sg_entry *)((u8 *)edesc->hw_desc +
 						  desc_bytes);
+	edesc->bklog = false;
+	rctx->edesc = edesc;
 
 	/* Make sure IV is located in a DMAable area */
 	if (ivsize) {
@@ -1673,12 +1693,35 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 	return edesc;
 }
 
+static int skcipher_do_one_req(struct crypto_engine *engine, void *areq)
+{
+	struct skcipher_request *req = skcipher_request_cast(areq);
+	struct caam_ctx *ctx = crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+	struct caam_skcipher_req_ctx *rctx = skcipher_request_ctx(req);
+	u32 *desc = rctx->edesc->hw_desc;
+	int ret;
+
+	rctx->edesc->bklog = true;
+
+	ret = caam_jr_enqueue(ctx->jrdev, desc, skcipher_crypt_done, req);
+
+	if (ret != -EINPROGRESS) {
+		skcipher_unmap(ctx->jrdev, rctx->edesc, req);
+		kfree(rctx->edesc);
+	} else {
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static inline int skcipher_crypt(struct skcipher_request *req, bool encrypt)
 {
 	struct skcipher_edesc *edesc;
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
 	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
 	struct device *jrdev = ctx->jrdev;
+	struct caam_drv_private_jr *jrpriv = dev_get_drvdata(jrdev);
 	u32 *desc;
 	int ret = 0;
 
@@ -1698,9 +1741,18 @@ static inline int skcipher_crypt(struct skcipher_request *req, bool encrypt)
 			     desc_bytes(edesc->hw_desc), 1);
 
 	desc = edesc->hw_desc;
-	ret = caam_jr_enqueue(jrdev, desc, skcipher_crypt_done, req);
+	/*
+	 * Only the backlog request are sent to crypto-engine since the others
+	 * can be handled by CAAM, if free, especially since JR has up to 1024
+	 * entries (more than the 10 entries from crypto-engine).
+	 */
+	if (req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)
+		ret = crypto_transfer_skcipher_request_to_engine(jrpriv->engine,
+								 req);
+	else
+		ret = caam_jr_enqueue(jrdev, desc, skcipher_crypt_done, req);
 
-	if (ret != -EINPROGRESS) {
+	if ((ret != -EINPROGRESS) && (ret != -EBUSY)) {
 		skcipher_unmap(jrdev, edesc, req);
 		kfree(edesc);
 	}
@@ -3236,7 +3288,9 @@ static int caam_init_common(struct caam_ctx *ctx, struct caam_alg_entry *caam,
 
 	dma_addr = dma_map_single_attrs(ctx->jrdev, ctx->sh_desc_enc,
 					offsetof(struct caam_ctx,
-						 sh_desc_enc_dma),
+						 sh_desc_enc_dma) -
+					offsetof(struct caam_ctx,
+						 sh_desc_enc),
 					ctx->dir, DMA_ATTR_SKIP_CPU_SYNC);
 	if (dma_mapping_error(ctx->jrdev, dma_addr)) {
 		dev_err(ctx->jrdev, "unable to map key, shared descriptors\n");
@@ -3246,8 +3300,12 @@ static int caam_init_common(struct caam_ctx *ctx, struct caam_alg_entry *caam,
 
 	ctx->sh_desc_enc_dma = dma_addr;
 	ctx->sh_desc_dec_dma = dma_addr + offsetof(struct caam_ctx,
-						   sh_desc_dec);
-	ctx->key_dma = dma_addr + offsetof(struct caam_ctx, key);
+						   sh_desc_dec) -
+					offsetof(struct caam_ctx,
+						 sh_desc_enc);
+	ctx->key_dma = dma_addr + offsetof(struct caam_ctx, key) -
+					offsetof(struct caam_ctx,
+						 sh_desc_enc);
 
 	/* copy descriptor header template value */
 	ctx->cdata.algtype = OP_TYPE_CLASS1_ALG | caam->class1_alg_type;
@@ -3261,6 +3319,11 @@ static int caam_cra_init(struct crypto_skcipher *tfm)
 	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
 	struct caam_skcipher_alg *caam_alg =
 		container_of(alg, typeof(*caam_alg), skcipher);
+	struct caam_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct caam_skcipher_req_ctx));
+
+	ctx->enginectx.op.do_one_request = skcipher_do_one_req;
 
 	return caam_init_common(crypto_skcipher_ctx(tfm), &caam_alg->caam,
 				false);
@@ -3279,7 +3342,8 @@ static int caam_aead_init(struct crypto_aead *tfm)
 static void caam_exit_common(struct caam_ctx *ctx)
 {
 	dma_unmap_single_attrs(ctx->jrdev, ctx->sh_desc_enc_dma,
-			       offsetof(struct caam_ctx, sh_desc_enc_dma),
+			       offsetof(struct caam_ctx, sh_desc_enc_dma) -
+			       offsetof(struct caam_ctx, sh_desc_enc),
 			       ctx->dir, DMA_ATTR_SKIP_CPU_SYNC);
 	caam_jr_free(ctx->jrdev);
 }
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index c7c10c9..230ea88 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -11,6 +11,7 @@
 #define INTERN_H
 
 #include "ctrl.h"
+#include <crypto/engine.h>
 
 /* Currently comes from Kconfig param as a ^2 (driver-required) */
 #define JOBR_DEPTH (1 << CONFIG_CRYPTO_DEV_FSL_CAAM_RINGSIZE)
@@ -60,6 +61,7 @@ struct caam_drv_private_jr {
 	int out_ring_read_index;	/* Output index "tail" */
 	int tail;			/* entinfo (s/w ring) tail index */
 	void *outring;			/* Base of output ring, DMA-safe */
+	struct crypto_engine *engine;
 };
 
 /*
diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index df2a050..962e66d 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -62,6 +62,15 @@ static void unregister_algs(void)
 	mutex_unlock(&algs_lock);
 }
 
+static void caam_jr_crypto_engine_exit(void *data)
+{
+	struct device *jrdev = data;
+	struct caam_drv_private_jr *jrpriv = dev_get_drvdata(jrdev);
+
+	/* Free the resources of crypto-engine */
+	crypto_engine_exit(jrpriv->engine);
+}
+
 static int caam_reset_hw_jr(struct device *dev)
 {
 	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
@@ -538,6 +547,26 @@ static int caam_jr_probe(struct platform_device *pdev)
 		return error;
 	}
 
+	/* Initialize crypto engine */
+	jrpriv->engine = crypto_engine_alloc_init(jrdev, false);
+	if (!jrpriv->engine) {
+		dev_err(jrdev, "Could not init crypto-engine\n");
+		return -ENOMEM;
+	}
+
+	/* Start crypto engine */
+	error = crypto_engine_start(jrpriv->engine);
+	if (error) {
+		dev_err(jrdev, "Could not start crypto-engine\n");
+		crypto_engine_exit(jrpriv->engine);
+		return error;
+	}
+
+	error = devm_add_action_or_reset(jrdev, caam_jr_crypto_engine_exit,
+					 jrdev);
+	if (error)
+		return error;
+
 	/* Identify the interrupt */
 	jrpriv->irq = irq_of_parse_and_map(nprop, 0);
 	if (!jrpriv->irq) {
-- 
2.1.0

