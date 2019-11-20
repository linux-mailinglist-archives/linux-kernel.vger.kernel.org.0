Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19E6410418E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 17:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbfKTQzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 11:55:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37733 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfKTQzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:55:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id p24so19011pfn.4;
        Wed, 20 Nov 2019 08:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uSLraInS1r3YwZFWfegNCWVZgx0ELLwvmUgepfaRIw=;
        b=eFg6Yv12pCRmvGYmcANdrqOfJQLD0YbICyrsE1rnRpEw03KpRL6KG5kjziWtRfFuDJ
         lDICgoUoOXCGp3ap1q1EWk0TodLFX9iWMl33+rRHBNobw1u65LNjszlRMfzHKx4Xde/q
         Il7jgi+S27lJksVRePojBbBH9SCNGoNhTPTySlaBeAPAzfCrxA9+XqmXjIgYCAEa55Uv
         3fT7uPIXhN51qOgDGJUmrIDBTf/JFjRy6nElph3s6U66e6Rj5JOpQ5G3gaLMysrWIBcX
         eT4NNe0su/4Ft+K4Ttbn0R4fEmwlggJvCHE4oaofL8EpXqeO/z2ArPKp/gJX3O15iOEo
         w6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uSLraInS1r3YwZFWfegNCWVZgx0ELLwvmUgepfaRIw=;
        b=kFUOzhx236spdd/B4nIptzzyNcDsSRe8gHiXJPDKYes1XyEMkN2o7es2gZlo6l10jz
         HUA1j2EexIh3tlB27icWf1hNUCXwblM8iPYs/Ry+vj6QFegW38zUBpFsEEKBeOPRxFPp
         Til7rb39R8PBSkqFVP+FN7H70UplBAfpypkHWqI02WN37waH6wi5b/DvLqph7CsqUz0P
         yIpfUvhZUI22FGhc0UlM+YTZBZrQmc9EXkYO+DE4rnWH3YU0z6BwLHd5bpZbjhkn2tOT
         2hSGZLOrKwL51dyo2y/ln9yjeEKgDvW39YUv3gQrsytNyq41UXOkKfdK/ugkwGp3QU6o
         rGkw==
X-Gm-Message-State: APjAAAW/HrlYSz5yvbxvZkx02Djl217k5vYStuuOE+FEpGkzKdpEz3Br
        qJbkbhG7XygDwdAIuGU7OK/OSqMg
X-Google-Smtp-Source: APXvYqwFGhm3D7UXTv4FznzsbOQqo6h55hHwvw8eIQ1ofov9eCeMxrWL2Ezkn7VQcsoZPu6EYKQqHw==
X-Received: by 2002:a62:8495:: with SMTP id k143mr5034918pfd.47.1574268903572;
        Wed, 20 Nov 2019 08:55:03 -0800 (PST)
Received: from localhost.hsd1.wa.comcast.net ([2601:602:847f:811f:babe:8e8d:b27e:e6d7])
        by smtp.gmail.com with ESMTPSA id e11sm29841483pff.104.2019.11.20.08.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 08:55:02 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iuliana Prodan <iuliana.prodan@nxp.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] crypto: caam - replace DRNG with TRNG for use with hw_random
Date:   Wed, 20 Nov 2019 08:53:40 -0800
Message-Id: <20191120165341.32669-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191120165341.32669-1-andrew.smirnov@gmail.com>
References: <20191120165341.32669-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to give CAAM-generated random data highest quarlity
raiting (999), replace current code that uses DRNG with code that
fetches data straight out of TRNG used to seed aforementioned DRNG.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/Kconfig   |  17 +-
 drivers/crypto/caam/Makefile  |   2 +-
 drivers/crypto/caam/caamrng.c | 351 ----------------------------------
 drivers/crypto/caam/ctrl.c    |   6 +
 drivers/crypto/caam/intern.h  |   9 +-
 drivers/crypto/caam/jr.c      |   2 -
 drivers/crypto/caam/regs.h    |   7 +-
 drivers/crypto/caam/trng.c    |  89 +++++++++
 8 files changed, 111 insertions(+), 372 deletions(-)
 delete mode 100644 drivers/crypto/caam/caamrng.c
 create mode 100644 drivers/crypto/caam/trng.c

diff --git a/drivers/crypto/caam/Kconfig b/drivers/crypto/caam/Kconfig
index 137ed3df0c74..22116a8e2ff3 100644
--- a/drivers/crypto/caam/Kconfig
+++ b/drivers/crypto/caam/Kconfig
@@ -31,6 +31,14 @@ config CRYPTO_DEV_FSL_CAAM_DEBUG
 	  Selecting this will enable printing of various debug
 	  information in the CAAM driver.
 
+config CRYPTO_DEV_FSL_CAAM_RNG_API
+	bool "Register caam device for hwrng API"
+	default y
+	select HW_RANDOM
+	help
+	  Selecting this will register the hardware TRNG to
+	  the hw_random API for suppying the kernel entropy pool.
+
 menuconfig CRYPTO_DEV_FSL_CAAM_JR
 	tristate "Freescale CAAM Job Ring driver backend"
 	default y
@@ -138,15 +146,6 @@ config CRYPTO_DEV_FSL_CAAM_PKC_API
           Supported cryptographic primitives: encryption, decryption,
           signature and verification.
 
-config CRYPTO_DEV_FSL_CAAM_RNG_API
-	bool "Register caam device for hwrng API"
-	default y
-	select CRYPTO_RNG
-	select HW_RANDOM
-	help
-	  Selecting this will register the SEC4 hardware rng to
-	  the hw_random API for suppying the kernel entropy pool.
-
 endif # CRYPTO_DEV_FSL_CAAM_JR
 
 endif # CRYPTO_DEV_FSL_CAAM
diff --git a/drivers/crypto/caam/Makefile b/drivers/crypto/caam/Makefile
index 68d5cc0f28e2..04884fc087f9 100644
--- a/drivers/crypto/caam/Makefile
+++ b/drivers/crypto/caam/Makefile
@@ -15,11 +15,11 @@ obj-$(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_DESC) += caamalg_desc.o
 obj-$(CONFIG_CRYPTO_DEV_FSL_CAAM_AHASH_API_DESC) += caamhash_desc.o
 
 caam-y := ctrl.o
+caam-$(CONFIG_CRYPTO_DEV_FSL_CAAM_RNG_API) += trng.o
 caam_jr-y := jr.o key_gen.o
 caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API) += caamalg.o
 caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI) += caamalg_qi.o
 caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_AHASH_API) += caamhash.o
-caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_RNG_API) += caamrng.o
 caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_PKC_API) += caampkc.o pkc_desc.o
 
 caam-$(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI) += qi.o
diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
deleted file mode 100644
index 70ddfbf90ac7..000000000000
--- a/drivers/crypto/caam/caamrng.c
+++ /dev/null
@@ -1,351 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * caam - Freescale FSL CAAM support for hw_random
- *
- * Copyright 2011 Freescale Semiconductor, Inc.
- * Copyright 2018-2019 NXP
- *
- * Based on caamalg.c crypto API driver.
- *
- * relationship between job descriptors to shared descriptors:
- *
- * ---------------                     --------------
- * | JobDesc #0  |-------------------->| ShareDesc  |
- * | *(buffer 0) |      |------------->| (generate) |
- * ---------------      |              | (move)     |
- *                      |              | (store)    |
- * ---------------      |              --------------
- * | JobDesc #1  |------|
- * | *(buffer 1) |
- * ---------------
- *
- * A job desc looks like this:
- *
- * ---------------------
- * | Header            |
- * | ShareDesc Pointer |
- * | SEQ_OUT_PTR       |
- * | (output buffer)   |
- * ---------------------
- *
- * The SharedDesc never changes, and each job descriptor points to one of two
- * buffers for each device, from which the data will be copied into the
- * requested destination
- */
-
-#include <linux/hw_random.h>
-#include <linux/completion.h>
-#include <linux/atomic.h>
-
-#include "compat.h"
-
-#include "regs.h"
-#include "intern.h"
-#include "desc_constr.h"
-#include "jr.h"
-#include "error.h"
-
-/*
- * Maximum buffer size: maximum number of random, cache-aligned bytes that
- * will be generated and moved to seq out ptr (extlen not allowed)
- */
-#define RN_BUF_SIZE			(0xffff / L1_CACHE_BYTES * \
-					 L1_CACHE_BYTES)
-
-/* length of descriptors */
-#define DESC_JOB_O_LEN			(CAAM_CMD_SZ * 2 + CAAM_PTR_SZ_MAX * 2)
-#define DESC_RNG_LEN			(3 * CAAM_CMD_SZ)
-
-/* Buffer, its dma address and lock */
-struct buf_data {
-	u8 buf[RN_BUF_SIZE] ____cacheline_aligned;
-	dma_addr_t addr;
-	struct completion filled;
-	u32 hw_desc[DESC_JOB_O_LEN];
-#define BUF_NOT_EMPTY 0
-#define BUF_EMPTY 1
-#define BUF_PENDING 2  /* Empty, but with job pending --don't submit another */
-	atomic_t empty;
-};
-
-/* rng per-device context */
-struct caam_rng_ctx {
-	struct device *jrdev;
-	dma_addr_t sh_desc_dma;
-	u32 sh_desc[DESC_RNG_LEN];
-	unsigned int cur_buf_idx;
-	int current_buf;
-	struct buf_data bufs[2];
-};
-
-static struct caam_rng_ctx *rng_ctx;
-
-/*
- * Variable used to avoid double free of resources in case
- * algorithm registration was unsuccessful
- */
-static bool init_done;
-
-static inline void rng_unmap_buf(struct device *jrdev, struct buf_data *bd)
-{
-	if (bd->addr)
-		dma_unmap_single(jrdev, bd->addr, RN_BUF_SIZE,
-				 DMA_FROM_DEVICE);
-}
-
-static inline void rng_unmap_ctx(struct caam_rng_ctx *ctx)
-{
-	struct device *jrdev = ctx->jrdev;
-
-	if (ctx->sh_desc_dma)
-		dma_unmap_single(jrdev, ctx->sh_desc_dma,
-				 desc_bytes(ctx->sh_desc), DMA_TO_DEVICE);
-	rng_unmap_buf(jrdev, &ctx->bufs[0]);
-	rng_unmap_buf(jrdev, &ctx->bufs[1]);
-}
-
-static void rng_done(struct device *jrdev, u32 *desc, u32 err, void *context)
-{
-	struct buf_data *bd;
-
-	bd = container_of(desc, struct buf_data, hw_desc[0]);
-
-	if (err)
-		caam_jr_strstatus(jrdev, err);
-
-	atomic_set(&bd->empty, BUF_NOT_EMPTY);
-	complete(&bd->filled);
-
-	/* Buffer refilled, invalidate cache */
-	dma_sync_single_for_cpu(jrdev, bd->addr, RN_BUF_SIZE, DMA_FROM_DEVICE);
-
-	print_hex_dump_debug("rng refreshed buf@: ", DUMP_PREFIX_ADDRESS, 16, 4,
-			     bd->buf, RN_BUF_SIZE, 1);
-}
-
-static inline int submit_job(struct caam_rng_ctx *ctx, int to_current)
-{
-	struct buf_data *bd = &ctx->bufs[!(to_current ^ ctx->current_buf)];
-	struct device *jrdev = ctx->jrdev;
-	u32 *desc = bd->hw_desc;
-	int err;
-
-	dev_dbg(jrdev, "submitting job %d\n", !(to_current ^ ctx->current_buf));
-	init_completion(&bd->filled);
-	err = caam_jr_enqueue(jrdev, desc, rng_done, ctx);
-	if (err)
-		complete(&bd->filled); /* don't wait on failed job*/
-	else
-		atomic_inc(&bd->empty); /* note if pending */
-
-	return err;
-}
-
-static int caam_read(struct hwrng *rng, void *data, size_t max, bool wait)
-{
-	struct caam_rng_ctx *ctx = rng_ctx;
-	struct buf_data *bd = &ctx->bufs[ctx->current_buf];
-	int next_buf_idx, copied_idx;
-	int err;
-
-	if (atomic_read(&bd->empty)) {
-		/* try to submit job if there wasn't one */
-		if (atomic_read(&bd->empty) == BUF_EMPTY) {
-			err = submit_job(ctx, 1);
-			/* if can't submit job, can't even wait */
-			if (err)
-				return 0;
-		}
-		/* no immediate data, so exit if not waiting */
-		if (!wait)
-			return 0;
-
-		/* waiting for pending job */
-		if (atomic_read(&bd->empty))
-			wait_for_completion(&bd->filled);
-	}
-
-	next_buf_idx = ctx->cur_buf_idx + max;
-	dev_dbg(ctx->jrdev, "%s: start reading at buffer %d, idx %d\n",
-		 __func__, ctx->current_buf, ctx->cur_buf_idx);
-
-	/* if enough data in current buffer */
-	if (next_buf_idx < RN_BUF_SIZE) {
-		memcpy(data, bd->buf + ctx->cur_buf_idx, max);
-		ctx->cur_buf_idx = next_buf_idx;
-		return max;
-	}
-
-	/* else, copy what's left... */
-	copied_idx = RN_BUF_SIZE - ctx->cur_buf_idx;
-	memcpy(data, bd->buf + ctx->cur_buf_idx, copied_idx);
-	ctx->cur_buf_idx = 0;
-	atomic_set(&bd->empty, BUF_EMPTY);
-
-	/* ...refill... */
-	submit_job(ctx, 1);
-
-	/* and use next buffer */
-	ctx->current_buf = !ctx->current_buf;
-	dev_dbg(ctx->jrdev, "switched to buffer %d\n", ctx->current_buf);
-
-	/* since there already is some data read, don't wait */
-	return copied_idx + caam_read(rng, data + copied_idx,
-				      max - copied_idx, false);
-}
-
-static inline int rng_create_sh_desc(struct caam_rng_ctx *ctx)
-{
-	struct device *jrdev = ctx->jrdev;
-	u32 *desc = ctx->sh_desc;
-
-	init_sh_desc(desc, HDR_SHARE_SERIAL);
-
-	/* Generate random bytes */
-	append_operation(desc, OP_ALG_ALGSEL_RNG | OP_TYPE_CLASS1_ALG |
-			 OP_ALG_PR_ON);
-
-	/* Store bytes */
-	append_seq_fifo_store(desc, RN_BUF_SIZE, FIFOST_TYPE_RNGSTORE);
-
-	ctx->sh_desc_dma = dma_map_single(jrdev, desc, desc_bytes(desc),
-					  DMA_TO_DEVICE);
-	if (dma_mapping_error(jrdev, ctx->sh_desc_dma)) {
-		dev_err(jrdev, "unable to map shared descriptor\n");
-		return -ENOMEM;
-	}
-
-	print_hex_dump_debug("rng shdesc@: ", DUMP_PREFIX_ADDRESS, 16, 4,
-			     desc, desc_bytes(desc), 1);
-
-	return 0;
-}
-
-static inline int rng_create_job_desc(struct caam_rng_ctx *ctx, int buf_id)
-{
-	struct device *jrdev = ctx->jrdev;
-	struct buf_data *bd = &ctx->bufs[buf_id];
-	u32 *desc = bd->hw_desc;
-	int sh_len = desc_len(ctx->sh_desc);
-
-	init_job_desc_shared(desc, ctx->sh_desc_dma, sh_len, HDR_SHARE_DEFER |
-			     HDR_REVERSE);
-
-	bd->addr = dma_map_single(jrdev, bd->buf, RN_BUF_SIZE, DMA_FROM_DEVICE);
-	if (dma_mapping_error(jrdev, bd->addr)) {
-		dev_err(jrdev, "unable to map dst\n");
-		return -ENOMEM;
-	}
-
-	append_seq_out_ptr_intlen(desc, bd->addr, RN_BUF_SIZE, 0);
-
-	print_hex_dump_debug("rng job desc@: ", DUMP_PREFIX_ADDRESS, 16, 4,
-			     desc, desc_bytes(desc), 1);
-
-	return 0;
-}
-
-static void caam_cleanup(struct hwrng *rng)
-{
-	int i;
-	struct buf_data *bd;
-
-	for (i = 0; i < 2; i++) {
-		bd = &rng_ctx->bufs[i];
-		if (atomic_read(&bd->empty) == BUF_PENDING)
-			wait_for_completion(&bd->filled);
-	}
-
-	rng_unmap_ctx(rng_ctx);
-}
-
-static int caam_init_buf(struct caam_rng_ctx *ctx, int buf_id)
-{
-	struct buf_data *bd = &ctx->bufs[buf_id];
-	int err;
-
-	err = rng_create_job_desc(ctx, buf_id);
-	if (err)
-		return err;
-
-	atomic_set(&bd->empty, BUF_EMPTY);
-	submit_job(ctx, buf_id == ctx->current_buf);
-	wait_for_completion(&bd->filled);
-
-	return 0;
-}
-
-static int caam_init_rng(struct caam_rng_ctx *ctx, struct device *jrdev)
-{
-	int err;
-
-	ctx->jrdev = jrdev;
-
-	err = rng_create_sh_desc(ctx);
-	if (err)
-		return err;
-
-	ctx->current_buf = 0;
-	ctx->cur_buf_idx = 0;
-
-	err = caam_init_buf(ctx, 0);
-	if (err)
-		return err;
-
-	return caam_init_buf(ctx, 1);
-}
-
-static struct hwrng caam_rng = {
-	.name		= "rng-caam",
-	.cleanup	= caam_cleanup,
-	.read		= caam_read,
-};
-
-void caam_rng_exit(void)
-{
-	if (!init_done)
-		return;
-
-	caam_jr_free(rng_ctx->jrdev);
-	hwrng_unregister(&caam_rng);
-	kfree(rng_ctx);
-}
-
-int caam_rng_init(struct device *ctrldev)
-{
-	struct device *dev;
-	struct caam_drv_private *priv = dev_get_drvdata(ctrldev);
-	int err;
-	init_done = false;
-
-	if (!caam_has_rng(priv))
-		return 0;
-
-	dev = caam_jr_alloc();
-	if (IS_ERR(dev)) {
-		pr_err("Job Ring Device allocation for transform failed\n");
-		return PTR_ERR(dev);
-	}
-	rng_ctx = kmalloc(sizeof(*rng_ctx), GFP_DMA | GFP_KERNEL);
-	if (!rng_ctx) {
-		err = -ENOMEM;
-		goto free_caam_alloc;
-	}
-	err = caam_init_rng(rng_ctx, dev);
-	if (err)
-		goto free_rng_ctx;
-
-	dev_info(dev, "registering rng-caam\n");
-
-	err = hwrng_register(&caam_rng);
-	if (!err) {
-		init_done = true;
-		return err;
-	}
-
-free_rng_ctx:
-	kfree(rng_ctx);
-free_caam_alloc:
-	caam_jr_free(dev);
-	return err;
-}
diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 8054ec29d35a..adbdef06bcf9 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -907,6 +907,12 @@ static int caam_probe(struct platform_device *pdev)
 			    &ctrlpriv->ctl_tdsk_wrap);
 #endif
 
+	ret = caam_trng_register(dev);
+	if (ret) {
+		dev_err(dev, "Failed to register HWRNG interface\n");
+		return ret;
+	}
+
 	ret = devm_of_platform_populate(dev);
 	if (ret)
 		dev_err(dev, "JR platform devices creation error\n");
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index f815e1ad4608..54bb04aa86bd 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -174,20 +174,15 @@ static inline void caam_pkc_exit(void)
 
 #ifdef CONFIG_CRYPTO_DEV_FSL_CAAM_RNG_API
 
-int caam_rng_init(struct device *dev);
-void caam_rng_exit(void);
+int caam_trng_register(struct device *dev);
 
 #else
 
-static inline int caam_rng_init(struct device *dev)
+static inline int caam_trng_register(struct device *dev)
 {
 	return 0;
 }
 
-static inline void caam_rng_exit(void)
-{
-}
-
 #endif /* CONFIG_CRYPTO_DEV_FSL_CAAM_RNG_API */
 
 #ifdef CONFIG_CAAM_QI
diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index fc97cde27059..c745b7044fe6 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -37,7 +37,6 @@ static void register_algs(struct device *dev)
 	caam_algapi_init(dev);
 	caam_algapi_hash_init(dev);
 	caam_pkc_init(dev);
-	caam_rng_init(dev);
 	caam_qi_algapi_init(dev);
 
 algs_unlock:
@@ -53,7 +52,6 @@ static void unregister_algs(void)
 
 	caam_qi_algapi_exit();
 
-	caam_rng_exit();
 	caam_pkc_exit();
 	caam_algapi_hash_exit();
 	caam_algapi_exit();
diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index fe1f8c1409fd..262399387e27 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -488,6 +488,7 @@ struct rngtst {
 /* RNG4 TRNG test registers */
 struct rng4tst {
 #define RTMCTL_ACC  BIT(5)  /* TRNG access mode */
+#define RTMCTL_ENT_VAL BIT(10)
 #define RTMCTL_PRGM BIT(16) /* 1 -> program mode, 0 -> run mode */
 #define RTMCTL_SAMP_MODE_VON_NEUMANN_ES_SC	0 /* use von Neumann data in
 						     both entropy shifter and
@@ -521,7 +522,9 @@ struct rng4tst {
 		u32 rtfrqmax;	/* PRGM=1: freq. count max. limit register */
 		u32 rtfrqcnt;	/* PRGM=0: freq. count register */
 	};
-	u32 rsvd1[40];
+	u32 rsvd1[8];
+	u32 rtent[16];		/* RTENT0 - RTENT15 */
+	u32 rsvd2[16];		/* RTPKRCNTn */
 #define RDSTA_SKVT 0x80000000
 #define RDSTA_SKVN 0x40000000
 #define RDSTA_PR0 BIT(4)
@@ -530,7 +533,7 @@ struct rng4tst {
 #define RDSTA_IF1 0x00000002
 #define RDSTA_IFMASK (RDSTA_PR1 | RDSTA_PR0 | RDSTA_IF1 | RDSTA_IF0)
 	u32 rdsta;
-	u32 rsvd2[15];
+	u32 rsvd3[15];
 };
 
 /*
diff --git a/drivers/crypto/caam/trng.c b/drivers/crypto/caam/trng.c
new file mode 100644
index 000000000000..881fe588a229
--- /dev/null
+++ b/drivers/crypto/caam/trng.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * hw_random interface for TRNG generator in CAAM RNG block
+ *
+ * Copyright 2019 Zodiac Inflight Innovations
+ *
+ */
+
+#include <linux/hw_random.h>
+
+#include "compat.h"
+#include "regs.h"
+#include "intern.h"
+
+struct caam_trng_ctx {
+	struct rng4tst __iomem *r4tst;
+	struct hwrng rng;
+};
+
+static bool caam_trng_busy(struct caam_trng_ctx *ctx)
+{
+	return !(rd_reg32(&ctx->r4tst->rtmctl) & RTMCTL_ENT_VAL);
+}
+
+static int caam_trng_read(struct hwrng *rng, void *data, size_t max, bool wait)
+{
+	struct caam_trng_ctx *ctx = (void *)rng->priv;
+	u32 rtent[ARRAY_SIZE(ctx->r4tst->rtent)];
+	size_t residue = max;
+
+	if (!wait)
+		return 0;
+
+	clrsetbits_32(&ctx->r4tst->rtmctl, 0, RTMCTL_ACC);
+
+	do {
+		const size_t chunk = min(residue, sizeof(rtent));
+		unsigned int i;
+
+		do {
+			/*
+			 * It takes about 70 ms to finish on i.MX6 and
+			 * i.MX8MQ
+			 */
+			msleep(70);
+		} while (caam_trng_busy(ctx));
+
+		for (i = 0; i < DIV_ROUND_UP(chunk, sizeof(u32)); i++)
+			rtent[i] = rd_reg32(&ctx->r4tst->rtent[i]);
+
+		memcpy(data, rtent, chunk);
+
+		residue -= chunk;
+		data    += chunk;
+	} while (residue);
+
+	clrsetbits_32(&ctx->r4tst->rtmctl, RTMCTL_ACC, 0);
+
+	return max;
+}
+
+int caam_trng_register(struct device *ctrldev)
+{
+	struct caam_drv_private *priv = dev_get_drvdata(ctrldev);
+
+	if (caam_has_rng(priv)) {
+		struct caam_trng_ctx *ctx;
+		int err;
+
+		ctx = devm_kzalloc(ctrldev, sizeof(*ctx), GFP_KERNEL);
+		if (!ctx)
+			return -ENOMEM;
+
+		ctx->r4tst = &priv->ctrl->r4tst[0];
+
+		ctx->rng.name = "trng-caam";
+		ctx->rng.read = caam_trng_read;
+		ctx->rng.priv = (unsigned long)ctx;
+		ctx->rng.quality = 999;
+
+		dev_info(ctrldev, "registering %s\n", ctx->rng.name);
+
+		err = devm_hwrng_register(ctrldev, &ctx->rng);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
-- 
2.21.0

