Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 426596D770
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 01:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfGRX6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 19:58:25 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54500 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfGRX6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 19:58:18 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0BA621A0361;
        Fri, 19 Jul 2019 01:58:13 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F0CC91A0135;
        Fri, 19 Jul 2019 01:58:12 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9CB23205D1;
        Fri, 19 Jul 2019 01:58:12 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v2 02/14] crypto: caam - fix return code in completion callbacks
Date:   Fri, 19 Jul 2019 02:57:44 +0300
Message-Id: <1563494276-3993-3-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1563494276-3993-1-git-send-email-iuliana.prodan@nxp.com>
References: <1563494276-3993-1-git-send-email-iuliana.prodan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia Geantă <horia.geanta@nxp.com>

Modify drive to provide a valid errno (and not the HW error ID)
to the user, via completion callbacks.

A "valid errno" is currently not explicitly mentioned in the docs,
however the error code is expected to match the one returned by the
generic SW implementation.

Note: in most error cases caam/qi and caam/qi2 returned -EIO; align all
caam drivers to return -EINVAL.

While here, ratelimit prints triggered by fuzz testing, such that
console is not flooded.

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/crypto/caam/caamalg.c     | 26 ++++++++--------
 drivers/crypto/caam/caamalg_qi.c  | 21 ++++---------
 drivers/crypto/caam/caamalg_qi2.c | 62 ++++++++++++---------------------------
 drivers/crypto/caam/caamhash.c    | 20 ++++++++-----
 drivers/crypto/caam/caampkc.c     | 20 ++++++++-----
 drivers/crypto/caam/error.c       | 60 +++++++++++++++++++++++--------------
 drivers/crypto/caam/error.h       |  2 +-
 drivers/crypto/caam/key_gen.c     |  5 ++--
 drivers/crypto/caam/qi.c          |  5 ++--
 9 files changed, 104 insertions(+), 117 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index 43f1825..06b4f2d 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -930,19 +930,20 @@ static void aead_encrypt_done(struct device *jrdev, u32 *desc, u32 err,
 {
 	struct aead_request *req = context;
 	struct aead_edesc *edesc;
+	int ecode = 0;
 
 	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = container_of(desc, struct aead_edesc, hw_desc[0]);
 
 	if (err)
-		caam_jr_strstatus(jrdev, err);
+		ecode = caam_jr_strstatus(jrdev, err);
 
 	aead_unmap(jrdev, edesc, req);
 
 	kfree(edesc);
 
-	aead_request_complete(req, err);
+	aead_request_complete(req, ecode);
 }
 
 static void aead_decrypt_done(struct device *jrdev, u32 *desc, u32 err,
@@ -950,25 +951,20 @@ static void aead_decrypt_done(struct device *jrdev, u32 *desc, u32 err,
 {
 	struct aead_request *req = context;
 	struct aead_edesc *edesc;
+	int ecode = 0;
 
 	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = container_of(desc, struct aead_edesc, hw_desc[0]);
 
 	if (err)
-		caam_jr_strstatus(jrdev, err);
+		ecode = caam_jr_strstatus(jrdev, err);
 
 	aead_unmap(jrdev, edesc, req);
 
-	/*
-	 * verify hw auth check passed else return -EBADMSG
-	 */
-	if ((err & JRSTA_CCBERR_ERRID_MASK) == JRSTA_CCBERR_ERRID_ICVCHK)
-		err = -EBADMSG;
-
 	kfree(edesc);
 
-	aead_request_complete(req, err);
+	aead_request_complete(req, ecode);
 }
 
 static void skcipher_encrypt_done(struct device *jrdev, u32 *desc, u32 err,
@@ -978,13 +974,14 @@ static void skcipher_encrypt_done(struct device *jrdev, u32 *desc, u32 err,
 	struct skcipher_edesc *edesc;
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
 	int ivsize = crypto_skcipher_ivsize(skcipher);
+	int ecode = 0;
 
 	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = container_of(desc, struct skcipher_edesc, hw_desc[0]);
 
 	if (err)
-		caam_jr_strstatus(jrdev, err);
+		ecode = caam_jr_strstatus(jrdev, err);
 
 	skcipher_unmap(jrdev, edesc, req);
 
@@ -1008,7 +1005,7 @@ static void skcipher_encrypt_done(struct device *jrdev, u32 *desc, u32 err,
 
 	kfree(edesc);
 
-	skcipher_request_complete(req, err);
+	skcipher_request_complete(req, ecode);
 }
 
 static void skcipher_decrypt_done(struct device *jrdev, u32 *desc, u32 err,
@@ -1018,12 +1015,13 @@ static void skcipher_decrypt_done(struct device *jrdev, u32 *desc, u32 err,
 	struct skcipher_edesc *edesc;
 	struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
 	int ivsize = crypto_skcipher_ivsize(skcipher);
+	int ecode = 0;
 
 	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = container_of(desc, struct skcipher_edesc, hw_desc[0]);
 	if (err)
-		caam_jr_strstatus(jrdev, err);
+		ecode = caam_jr_strstatus(jrdev, err);
 
 	skcipher_unmap(jrdev, edesc, req);
 
@@ -1047,7 +1045,7 @@ static void skcipher_decrypt_done(struct device *jrdev, u32 *desc, u32 err,
 
 	kfree(edesc);
 
-	skcipher_request_complete(req, err);
+	skcipher_request_complete(req, ecode);
 }
 
 /*
diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index 32f0f8a..ab263b1 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -884,20 +884,8 @@ static void aead_done(struct caam_drv_req *drv_req, u32 status)
 
 	qidev = caam_ctx->qidev;
 
-	if (unlikely(status)) {
-		u32 ssrc = status & JRSTA_SSRC_MASK;
-		u8 err_id = status & JRSTA_CCBERR_ERRID_MASK;
-
-		caam_jr_strstatus(qidev, status);
-		/*
-		 * verify hw auth check passed else return -EBADMSG
-		 */
-		if (ssrc == JRSTA_SSRC_CCB_ERROR &&
-		    err_id == JRSTA_CCBERR_ERRID_ICVCHK)
-			ecode = -EBADMSG;
-		else
-			ecode = -EIO;
-	}
+	if (unlikely(status))
+		ecode = caam_jr_strstatus(qidev, status);
 
 	edesc = container_of(drv_req, typeof(*edesc), drv_req);
 	aead_unmap(qidev, edesc, aead_req);
@@ -1190,13 +1178,14 @@ static void skcipher_done(struct caam_drv_req *drv_req, u32 status)
 	struct caam_ctx *caam_ctx = crypto_skcipher_ctx(skcipher);
 	struct device *qidev = caam_ctx->qidev;
 	int ivsize = crypto_skcipher_ivsize(skcipher);
+	int ecode = 0;
 
 	dev_dbg(qidev, "%s %d: status 0x%x\n", __func__, __LINE__, status);
 
 	edesc = container_of(drv_req, typeof(*edesc), drv_req);
 
 	if (status)
-		caam_jr_strstatus(qidev, status);
+		ecode = caam_jr_strstatus(qidev, status);
 
 	print_hex_dump_debug("dstiv  @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, req->iv,
@@ -1215,7 +1204,7 @@ static void skcipher_done(struct caam_drv_req *drv_req, u32 status)
 	memcpy(req->iv, (u8 *)&edesc->sgt[0] + edesc->qm_sg_bytes, ivsize);
 
 	qi_cache_free(edesc);
-	skcipher_request_complete(req, status);
+	skcipher_request_complete(req, ecode);
 }
 
 static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 06bf32c..2681581 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -1227,10 +1227,8 @@ static void aead_encrypt_done(void *cbk_ctx, u32 status)
 
 	dev_dbg(ctx->dev, "%s %d: err 0x%x\n", __func__, __LINE__, status);
 
-	if (unlikely(status)) {
-		caam_qi2_strstatus(ctx->dev, status);
-		ecode = -EIO;
-	}
+	if (unlikely(status))
+		ecode = caam_qi2_strstatus(ctx->dev, status);
 
 	aead_unmap(ctx->dev, edesc, req);
 	qi_cache_free(edesc);
@@ -1250,17 +1248,8 @@ static void aead_decrypt_done(void *cbk_ctx, u32 status)
 
 	dev_dbg(ctx->dev, "%s %d: err 0x%x\n", __func__, __LINE__, status);
 
-	if (unlikely(status)) {
-		caam_qi2_strstatus(ctx->dev, status);
-		/*
-		 * verify hw auth check passed else return -EBADMSG
-		 */
-		if ((status & JRSTA_CCBERR_ERRID_MASK) ==
-		     JRSTA_CCBERR_ERRID_ICVCHK)
-			ecode = -EBADMSG;
-		else
-			ecode = -EIO;
-	}
+	if (unlikely(status))
+		ecode = caam_qi2_strstatus(ctx->dev, status);
 
 	aead_unmap(ctx->dev, edesc, req);
 	qi_cache_free(edesc);
@@ -1352,10 +1341,8 @@ static void skcipher_encrypt_done(void *cbk_ctx, u32 status)
 
 	dev_dbg(ctx->dev, "%s %d: err 0x%x\n", __func__, __LINE__, status);
 
-	if (unlikely(status)) {
-		caam_qi2_strstatus(ctx->dev, status);
-		ecode = -EIO;
-	}
+	if (unlikely(status))
+		ecode = caam_qi2_strstatus(ctx->dev, status);
 
 	print_hex_dump_debug("dstiv  @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, req->iv,
@@ -1390,10 +1377,8 @@ static void skcipher_decrypt_done(void *cbk_ctx, u32 status)
 
 	dev_dbg(ctx->dev, "%s %d: err 0x%x\n", __func__, __LINE__, status);
 
-	if (unlikely(status)) {
-		caam_qi2_strstatus(ctx->dev, status);
-		ecode = -EIO;
-	}
+	if (unlikely(status))
+		ecode = caam_qi2_strstatus(ctx->dev, status);
 
 	print_hex_dump_debug("dstiv  @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, req->iv,
@@ -3094,10 +3079,7 @@ static void split_key_sh_done(void *cbk_ctx, u32 err)
 
 	dev_dbg(res->dev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
-	if (err)
-		caam_qi2_strstatus(res->dev, err);
-
-	res->err = err;
+	res->err = err ? caam_qi2_strstatus(res->dev, err) : 0;
 	complete(&res->completion);
 }
 
@@ -3282,10 +3264,8 @@ static void ahash_done(void *cbk_ctx, u32 status)
 
 	dev_dbg(ctx->dev, "%s %d: err 0x%x\n", __func__, __LINE__, status);
 
-	if (unlikely(status)) {
-		caam_qi2_strstatus(ctx->dev, status);
-		ecode = -EIO;
-	}
+	if (unlikely(status))
+		ecode = caam_qi2_strstatus(ctx->dev, status);
 
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_FROM_DEVICE);
 	memcpy(req->result, state->caam_ctx, digestsize);
@@ -3310,10 +3290,8 @@ static void ahash_done_bi(void *cbk_ctx, u32 status)
 
 	dev_dbg(ctx->dev, "%s %d: err 0x%x\n", __func__, __LINE__, status);
 
-	if (unlikely(status)) {
-		caam_qi2_strstatus(ctx->dev, status);
-		ecode = -EIO;
-	}
+	if (unlikely(status))
+		ecode = caam_qi2_strstatus(ctx->dev, status);
 
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_BIDIRECTIONAL);
 	switch_buf(state);
@@ -3343,10 +3321,8 @@ static void ahash_done_ctx_src(void *cbk_ctx, u32 status)
 
 	dev_dbg(ctx->dev, "%s %d: err 0x%x\n", __func__, __LINE__, status);
 
-	if (unlikely(status)) {
-		caam_qi2_strstatus(ctx->dev, status);
-		ecode = -EIO;
-	}
+	if (unlikely(status))
+		ecode = caam_qi2_strstatus(ctx->dev, status);
 
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_BIDIRECTIONAL);
 	memcpy(req->result, state->caam_ctx, digestsize);
@@ -3371,10 +3347,8 @@ static void ahash_done_ctx_dst(void *cbk_ctx, u32 status)
 
 	dev_dbg(ctx->dev, "%s %d: err 0x%x\n", __func__, __LINE__, status);
 
-	if (unlikely(status)) {
-		caam_qi2_strstatus(ctx->dev, status);
-		ecode = -EIO;
-	}
+	if (unlikely(status))
+		ecode = caam_qi2_strstatus(ctx->dev, status);
 
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_FROM_DEVICE);
 	switch_buf(state);
@@ -4700,7 +4674,7 @@ static void dpaa2_caam_process_fd(struct dpaa2_caam_priv *priv,
 
 	fd_err = dpaa2_fd_get_ctrl(fd) & FD_CTRL_ERR_MASK;
 	if (unlikely(fd_err))
-		dev_err(priv->dev, "FD error: %08x\n", fd_err);
+		dev_err_ratelimited(priv->dev, "FD error: %08x\n", fd_err);
 
 	/*
 	 * FD[ADDR] is guaranteed to be valid, irrespective of errors reported
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index e4ac5d5..73abefa 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -584,12 +584,13 @@ static void ahash_done(struct device *jrdev, u32 *desc, u32 err,
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct caam_hash_state *state = ahash_request_ctx(req);
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	int ecode = 0;
 
 	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = container_of(desc, struct ahash_edesc, hw_desc[0]);
 	if (err)
-		caam_jr_strstatus(jrdev, err);
+		ecode = caam_jr_strstatus(jrdev, err);
 
 	ahash_unmap_ctx(jrdev, edesc, req, digestsize, DMA_FROM_DEVICE);
 	memcpy(req->result, state->caam_ctx, digestsize);
@@ -599,7 +600,7 @@ static void ahash_done(struct device *jrdev, u32 *desc, u32 err,
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
 			     ctx->ctx_len, 1);
 
-	req->base.complete(&req->base, err);
+	req->base.complete(&req->base, ecode);
 }
 
 static void ahash_done_bi(struct device *jrdev, u32 *desc, u32 err,
@@ -611,12 +612,13 @@ static void ahash_done_bi(struct device *jrdev, u32 *desc, u32 err,
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
 	struct caam_hash_state *state = ahash_request_ctx(req);
 	int digestsize = crypto_ahash_digestsize(ahash);
+	int ecode = 0;
 
 	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = container_of(desc, struct ahash_edesc, hw_desc[0]);
 	if (err)
-		caam_jr_strstatus(jrdev, err);
+		ecode = caam_jr_strstatus(jrdev, err);
 
 	ahash_unmap_ctx(jrdev, edesc, req, ctx->ctx_len, DMA_BIDIRECTIONAL);
 	switch_buf(state);
@@ -630,7 +632,7 @@ static void ahash_done_bi(struct device *jrdev, u32 *desc, u32 err,
 				     DUMP_PREFIX_ADDRESS, 16, 4, req->result,
 				     digestsize, 1);
 
-	req->base.complete(&req->base, err);
+	req->base.complete(&req->base, ecode);
 }
 
 static void ahash_done_ctx_src(struct device *jrdev, u32 *desc, u32 err,
@@ -642,12 +644,13 @@ static void ahash_done_ctx_src(struct device *jrdev, u32 *desc, u32 err,
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct caam_hash_state *state = ahash_request_ctx(req);
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	int ecode = 0;
 
 	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = container_of(desc, struct ahash_edesc, hw_desc[0]);
 	if (err)
-		caam_jr_strstatus(jrdev, err);
+		ecode = caam_jr_strstatus(jrdev, err);
 
 	ahash_unmap_ctx(jrdev, edesc, req, digestsize, DMA_BIDIRECTIONAL);
 	memcpy(req->result, state->caam_ctx, digestsize);
@@ -657,7 +660,7 @@ static void ahash_done_ctx_src(struct device *jrdev, u32 *desc, u32 err,
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
 			     ctx->ctx_len, 1);
 
-	req->base.complete(&req->base, err);
+	req->base.complete(&req->base, ecode);
 }
 
 static void ahash_done_ctx_dst(struct device *jrdev, u32 *desc, u32 err,
@@ -669,12 +672,13 @@ static void ahash_done_ctx_dst(struct device *jrdev, u32 *desc, u32 err,
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
 	struct caam_hash_state *state = ahash_request_ctx(req);
 	int digestsize = crypto_ahash_digestsize(ahash);
+	int ecode = 0;
 
 	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = container_of(desc, struct ahash_edesc, hw_desc[0]);
 	if (err)
-		caam_jr_strstatus(jrdev, err);
+		ecode = caam_jr_strstatus(jrdev, err);
 
 	ahash_unmap_ctx(jrdev, edesc, req, ctx->ctx_len, DMA_FROM_DEVICE);
 	switch_buf(state);
@@ -688,7 +692,7 @@ static void ahash_done_ctx_dst(struct device *jrdev, u32 *desc, u32 err,
 				     DUMP_PREFIX_ADDRESS, 16, 4, req->result,
 				     digestsize, 1);
 
-	req->base.complete(&req->base, err);
+	req->base.complete(&req->base, ecode);
 }
 
 /*
diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index 8057410..574428c7 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -107,9 +107,10 @@ static void rsa_pub_done(struct device *dev, u32 *desc, u32 err, void *context)
 {
 	struct akcipher_request *req = context;
 	struct rsa_edesc *edesc;
+	int ecode = 0;
 
 	if (err)
-		caam_jr_strstatus(dev, err);
+		ecode = caam_jr_strstatus(dev, err);
 
 	edesc = container_of(desc, struct rsa_edesc, hw_desc[0]);
 
@@ -117,7 +118,7 @@ static void rsa_pub_done(struct device *dev, u32 *desc, u32 err, void *context)
 	rsa_io_unmap(dev, edesc, req);
 	kfree(edesc);
 
-	akcipher_request_complete(req, err);
+	akcipher_request_complete(req, ecode);
 }
 
 static void rsa_priv_f1_done(struct device *dev, u32 *desc, u32 err,
@@ -125,9 +126,10 @@ static void rsa_priv_f1_done(struct device *dev, u32 *desc, u32 err,
 {
 	struct akcipher_request *req = context;
 	struct rsa_edesc *edesc;
+	int ecode = 0;
 
 	if (err)
-		caam_jr_strstatus(dev, err);
+		ecode = caam_jr_strstatus(dev, err);
 
 	edesc = container_of(desc, struct rsa_edesc, hw_desc[0]);
 
@@ -135,7 +137,7 @@ static void rsa_priv_f1_done(struct device *dev, u32 *desc, u32 err,
 	rsa_io_unmap(dev, edesc, req);
 	kfree(edesc);
 
-	akcipher_request_complete(req, err);
+	akcipher_request_complete(req, ecode);
 }
 
 static void rsa_priv_f2_done(struct device *dev, u32 *desc, u32 err,
@@ -143,9 +145,10 @@ static void rsa_priv_f2_done(struct device *dev, u32 *desc, u32 err,
 {
 	struct akcipher_request *req = context;
 	struct rsa_edesc *edesc;
+	int ecode = 0;
 
 	if (err)
-		caam_jr_strstatus(dev, err);
+		ecode = caam_jr_strstatus(dev, err);
 
 	edesc = container_of(desc, struct rsa_edesc, hw_desc[0]);
 
@@ -153,7 +156,7 @@ static void rsa_priv_f2_done(struct device *dev, u32 *desc, u32 err,
 	rsa_io_unmap(dev, edesc, req);
 	kfree(edesc);
 
-	akcipher_request_complete(req, err);
+	akcipher_request_complete(req, ecode);
 }
 
 static void rsa_priv_f3_done(struct device *dev, u32 *desc, u32 err,
@@ -161,9 +164,10 @@ static void rsa_priv_f3_done(struct device *dev, u32 *desc, u32 err,
 {
 	struct akcipher_request *req = context;
 	struct rsa_edesc *edesc;
+	int ecode = 0;
 
 	if (err)
-		caam_jr_strstatus(dev, err);
+		ecode = caam_jr_strstatus(dev, err);
 
 	edesc = container_of(desc, struct rsa_edesc, hw_desc[0]);
 
@@ -171,7 +175,7 @@ static void rsa_priv_f3_done(struct device *dev, u32 *desc, u32 err,
 	rsa_io_unmap(dev, edesc, req);
 	kfree(edesc);
 
-	akcipher_request_complete(req, err);
+	akcipher_request_complete(req, ecode);
 }
 
 /**
diff --git a/drivers/crypto/caam/error.c b/drivers/crypto/caam/error.c
index 95da6ae..b7fbf1b 100644
--- a/drivers/crypto/caam/error.c
+++ b/drivers/crypto/caam/error.c
@@ -211,8 +211,8 @@ static const char * const rng_err_id_list[] = {
 	"Secure key generation",
 };
 
-static void report_ccb_status(struct device *jrdev, const u32 status,
-			      const char *error)
+static int report_ccb_status(struct device *jrdev, const u32 status,
+			     const char *error)
 {
 	u8 cha_id = (status & JRSTA_CCBERR_CHAID_MASK) >>
 		    JRSTA_CCBERR_CHAID_SHIFT;
@@ -248,22 +248,27 @@ static void report_ccb_status(struct device *jrdev, const u32 status,
 	 * CCB ICV check failures are part of normal operation life;
 	 * we leave the upper layers to do what they want with them.
 	 */
-	if (err_id != JRSTA_CCBERR_ERRID_ICVCHK)
-		dev_err(jrdev, "%08x: %s: %s %d: %s%s: %s%s\n",
-			status, error, idx_str, idx,
-			cha_str, cha_err_code,
-			err_str, err_err_code);
+	if (err_id == JRSTA_CCBERR_ERRID_ICVCHK)
+		return -EBADMSG;
+
+	dev_err_ratelimited(jrdev, "%08x: %s: %s %d: %s%s: %s%s\n", status,
+			    error, idx_str, idx, cha_str, cha_err_code,
+			    err_str, err_err_code);
+
+	return -EINVAL;
 }
 
-static void report_jump_status(struct device *jrdev, const u32 status,
-			       const char *error)
+static int report_jump_status(struct device *jrdev, const u32 status,
+			      const char *error)
 {
 	dev_err(jrdev, "%08x: %s: %s() not implemented\n",
 		status, error, __func__);
+
+	return -EINVAL;
 }
 
-static void report_deco_status(struct device *jrdev, const u32 status,
-			       const char *error)
+static int report_deco_status(struct device *jrdev, const u32 status,
+			      const char *error)
 {
 	u8 err_id = status & JRSTA_DECOERR_ERROR_MASK;
 	u8 idx = (status & JRSTA_DECOERR_INDEX_MASK) >>
@@ -289,10 +294,12 @@ static void report_deco_status(struct device *jrdev, const u32 status,
 
 	dev_err(jrdev, "%08x: %s: %s %d: %s%s\n",
 		status, error, idx_str, idx, err_str, err_err_code);
+
+	return -EINVAL;
 }
 
-static void report_qi_status(struct device *qidev, const u32 status,
-			     const char *error)
+static int report_qi_status(struct device *qidev, const u32 status,
+			    const char *error)
 {
 	u8 err_id = status & JRSTA_QIERR_ERROR_MASK;
 	const char *err_str = "unidentified error value 0x";
@@ -310,27 +317,33 @@ static void report_qi_status(struct device *qidev, const u32 status,
 
 	dev_err(qidev, "%08x: %s: %s%s\n",
 		status, error, err_str, err_err_code);
+
+	return -EINVAL;
 }
 
-static void report_jr_status(struct device *jrdev, const u32 status,
-			     const char *error)
+static int report_jr_status(struct device *jrdev, const u32 status,
+			    const char *error)
 {
 	dev_err(jrdev, "%08x: %s: %s() not implemented\n",
 		status, error, __func__);
+
+	return -EINVAL;
 }
 
-static void report_cond_code_status(struct device *jrdev, const u32 status,
-				    const char *error)
+static int report_cond_code_status(struct device *jrdev, const u32 status,
+				   const char *error)
 {
 	dev_err(jrdev, "%08x: %s: %s() not implemented\n",
 		status, error, __func__);
+
+	return -EINVAL;
 }
 
-void caam_strstatus(struct device *jrdev, u32 status, bool qi_v2)
+int caam_strstatus(struct device *jrdev, u32 status, bool qi_v2)
 {
 	static const struct stat_src {
-		void (*report_ssed)(struct device *jrdev, const u32 status,
-				    const char *error);
+		int (*report_ssed)(struct device *jrdev, const u32 status,
+				   const char *error);
 		const char *error;
 	} status_src[16] = {
 		{ NULL, "No error" },
@@ -358,11 +371,14 @@ void caam_strstatus(struct device *jrdev, u32 status, bool qi_v2)
 	 * Otherwise print the error source name.
 	 */
 	if (status_src[ssrc].report_ssed)
-		status_src[ssrc].report_ssed(jrdev, status, error);
-	else if (error)
+		return status_src[ssrc].report_ssed(jrdev, status, error);
+
+	if (error)
 		dev_err(jrdev, "%d: %s\n", ssrc, error);
 	else
 		dev_err(jrdev, "%d: unknown error source\n", ssrc);
+
+	return -EINVAL;
 }
 EXPORT_SYMBOL(caam_strstatus);
 
diff --git a/drivers/crypto/caam/error.h b/drivers/crypto/caam/error.h
index d9726e6..16809fa 100644
--- a/drivers/crypto/caam/error.h
+++ b/drivers/crypto/caam/error.h
@@ -12,7 +12,7 @@
 
 #define CAAM_ERROR_STR_MAX 302
 
-void caam_strstatus(struct device *dev, u32 status, bool qi_v2);
+int caam_strstatus(struct device *dev, u32 status, bool qi_v2);
 
 #define caam_jr_strstatus(jrdev, status) caam_strstatus(jrdev, status, false)
 #define caam_qi2_strstatus(qidev, status) caam_strstatus(qidev, status, true)
diff --git a/drivers/crypto/caam/key_gen.c b/drivers/crypto/caam/key_gen.c
index 48dd353..c6f8375 100644
--- a/drivers/crypto/caam/key_gen.c
+++ b/drivers/crypto/caam/key_gen.c
@@ -15,13 +15,14 @@ void split_key_done(struct device *dev, u32 *desc, u32 err,
 			   void *context)
 {
 	struct split_key_result *res = context;
+	int ecode = 0;
 
 	dev_dbg(dev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	if (err)
-		caam_jr_strstatus(dev, err);
+		ecode = caam_jr_strstatus(dev, err);
 
-	res->err = err;
+	res->err = ecode;
 
 	complete(&res->completion);
 }
diff --git a/drivers/crypto/caam/qi.c b/drivers/crypto/caam/qi.c
index 19a378b..378f627 100644
--- a/drivers/crypto/caam/qi.c
+++ b/drivers/crypto/caam/qi.c
@@ -577,8 +577,9 @@ static enum qman_cb_dqrr_result caam_rsp_fq_dqrr_cb(struct qman_portal *p,
 
 		if (ssrc != JRSTA_SSRC_CCB_ERROR ||
 		    err_id != JRSTA_CCBERR_ERRID_ICVCHK)
-			dev_err(qidev, "Error: %#x in CAAM response FD\n",
-				status);
+			dev_err_ratelimited(qidev,
+					    "Error: %#x in CAAM response FD\n",
+					    status);
 	}
 
 	if (unlikely(qm_fd_get_format(fd) != qm_fd_compound)) {
-- 
2.1.0

