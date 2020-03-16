Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39BFB186E08
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 16:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbgCPPBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 11:01:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44226 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731724AbgCPPBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:01:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id 37so9893996pgm.11;
        Mon, 16 Mar 2020 08:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikmpOAjYjiZjMcu6wx7gyB/EupCQsqCMEG2y7EaS2d8=;
        b=cTozfcwaTF4ZkSWrBPgkGeQq3p3r4Ycn3F9Gd3PSy0eSWBdWFG0G3IqkkxdPQC07mg
         gcAxPiaaeuY6HKohRMmcMLbYI49gVKA/+JhKnCmtCGRybiGG2sb3cFMvQSkhoVQ6AQSb
         IrOKLVejc+M7rvXfFUbyEjD4ETpPo6sjgCVDjPCtQFZW3Uhc9T8pSreV/dd6RyhoXYuf
         524ufseNzBT1e9SxXrZsnu3YPk8CEwnnmQQo6hgYjNKp2qX4ry954oaZIW41JcEIj8Re
         T9f35i4ywxqSGlptB53jBWqs5Pbnjfi32WqtF6Ypf76FGyPHluN4vJzLiBBka/bthm7M
         FSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikmpOAjYjiZjMcu6wx7gyB/EupCQsqCMEG2y7EaS2d8=;
        b=onfxv77NIbO2cc1n61MITfzpN24elvyWiimtgIZWnpkkJV0VBrdFZwXANf98bwM2rL
         gdBJUqqr615x23IG9PA92lvjx9sLwrSr6PL/gbipOpQ1nL1uL6yp0fPHN8gehFYJvYEu
         ZMwNexqFVikG5cnNADVg0pT24N4RTW+EkeZW1kueLihXB1qW9Bf4kC+agKksvMXrgVNw
         rjyT1uwUNmakNErJVB++1p6W8g1hLEQ5ArzTb8S70tEno1jIPomkdJF8u9lZwvCegGXG
         jhhV+ZLwSQO8X0HVeGGs8dHy5wWE93/r41MGDzxRpou7eQ5RS10bGnhFURFvwFOlYpRP
         L/3g==
X-Gm-Message-State: ANhLgQ0XIJgfHbSpUfF5FaCNn7WD/HpYVvhYqOV6aagETtC+i5BzdEkZ
        YN2MhXgP3NgmOUoiKZMVIvqURXrK
X-Google-Smtp-Source: ADFU+vsslVETThCbA0Eaa6rZVZu1Tr80bh9xpmc+tZFo9Z7yWGQF6o0sX7CGMJTiQ6n8ciMxv1fLWw==
X-Received: by 2002:a63:350:: with SMTP id 77mr253250pgd.215.1584370866921;
        Mon, 16 Mar 2020 08:01:06 -0700 (PDT)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id o128sm256354pfg.5.2020.03.16.08.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:01:05 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v8 3/8] crypto: caam - drop global context pointer and init_done
Date:   Mon, 16 Mar 2020 08:00:42 -0700
Message-Id: <20200316150047.30828-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200316150047.30828-1-andrew.smirnov@gmail.com>
References: <20200316150047.30828-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leverage devres to get rid of code storing global context as well as
init_done flag.

Original code also has a circular deallocation dependency where
unregister_algs() -> caam_rng_exit() -> caam_jr_free() chain would
only happen if all of JRs were freed. Fix this by moving
caam_rng_exit() outside of unregister_algs() and doing it specifically
for JR that instantiated HWRNG.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-imx@nxp.com
---
 drivers/crypto/caam/caamrng.c | 67 +++++++++++++++++------------------
 drivers/crypto/caam/intern.h  |  7 ++--
 drivers/crypto/caam/jr.c      | 13 ++++---
 3 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index 69a02ac5de54..753625f2b2c0 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -70,6 +70,7 @@ struct buf_data {
 
 /* rng per-device context */
 struct caam_rng_ctx {
+	struct hwrng rng;
 	struct device *jrdev;
 	dma_addr_t sh_desc_dma;
 	u32 sh_desc[DESC_RNG_LEN];
@@ -78,13 +79,10 @@ struct caam_rng_ctx {
 	struct buf_data bufs[2];
 };
 
-static struct caam_rng_ctx *rng_ctx;
-
-/*
- * Variable used to avoid double free of resources in case
- * algorithm registration was unsuccessful
- */
-static bool init_done;
+static struct caam_rng_ctx *to_caam_rng_ctx(struct hwrng *r)
+{
+	return (struct caam_rng_ctx *)r->priv;
+}
 
 static inline void rng_unmap_buf(struct device *jrdev, struct buf_data *bd)
 {
@@ -143,7 +141,7 @@ static inline int submit_job(struct caam_rng_ctx *ctx, int to_current)
 
 static int caam_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
-	struct caam_rng_ctx *ctx = rng_ctx;
+	struct caam_rng_ctx *ctx = to_caam_rng_ctx(rng);
 	struct buf_data *bd = &ctx->bufs[ctx->current_buf];
 	int next_buf_idx, copied_idx;
 	int err;
@@ -246,17 +244,18 @@ static inline int rng_create_job_desc(struct caam_rng_ctx *ctx, int buf_id)
 
 static void caam_cleanup(struct hwrng *rng)
 {
+	struct caam_rng_ctx *ctx = to_caam_rng_ctx(rng);
 	int i;
 	struct buf_data *bd;
 
 	for (i = 0; i < 2; i++) {
-		bd = &rng_ctx->bufs[i];
+		bd = &ctx->bufs[i];
 		if (atomic_read(&bd->empty) == BUF_PENDING)
 			wait_for_completion(&bd->filled);
 	}
 
-	rng_unmap_ctx(rng_ctx);
-	caam_jr_free(rng_ctx->jrdev);
+	rng_unmap_ctx(ctx);
+	caam_jr_free(ctx->jrdev);
 }
 
 static int caam_init_buf(struct caam_rng_ctx *ctx, int buf_id)
@@ -277,7 +276,7 @@ static int caam_init_buf(struct caam_rng_ctx *ctx, int buf_id)
 
 static int caam_init(struct hwrng *rng)
 {
-	struct caam_rng_ctx *ctx = rng_ctx;
+	struct caam_rng_ctx *ctx = to_caam_rng_ctx(rng);
 	int err;
 
 	ctx->jrdev = caam_jr_alloc();
@@ -309,28 +308,19 @@ static int caam_init(struct hwrng *rng)
 	return err;
 }
 
-static struct hwrng caam_rng = {
-	.name		= "rng-caam",
-	.init           = caam_init,
-	.cleanup	= caam_cleanup,
-	.read		= caam_read,
-};
+int caam_rng_init(struct device *ctrldev);
 
-void caam_rng_exit(void)
+void caam_rng_exit(struct device *ctrldev)
 {
-	if (!init_done)
-		return;
-
-	hwrng_unregister(&caam_rng);
-	kfree(rng_ctx);
+	devres_release_group(ctrldev, caam_rng_init);
 }
 
 int caam_rng_init(struct device *ctrldev)
 {
+	struct caam_rng_ctx *ctx;
 	u32 rng_inst;
 	struct caam_drv_private *priv = dev_get_drvdata(ctrldev);
-	int err;
-	init_done = false;
+	int ret;
 
 	/* Check for an instantiated RNG before registration */
 	if (priv->era < 10)
@@ -342,18 +332,27 @@ int caam_rng_init(struct device *ctrldev)
 	if (!rng_inst)
 		return 0;
 
-	rng_ctx = kmalloc(sizeof(*rng_ctx), GFP_DMA | GFP_KERNEL);
-	if (!rng_ctx)
+	if (!devres_open_group(ctrldev, caam_rng_init, GFP_KERNEL))
+		return -ENOMEM;
+
+	ctx = devm_kzalloc(ctrldev, sizeof(*ctx), GFP_DMA | GFP_KERNEL);
+	if (!ctx)
 		return -ENOMEM;
 
+	ctx->rng.name    = "rng-caam";
+	ctx->rng.init    = caam_init;
+	ctx->rng.cleanup = caam_cleanup;
+	ctx->rng.read    = caam_read;
+	ctx->rng.priv    = (unsigned long)ctx;
+
 	dev_info(ctrldev, "registering rng-caam\n");
 
-	err = hwrng_register(&caam_rng);
-	if (!err) {
-		init_done = true;
-		return err;
+	ret = devm_hwrng_register(ctrldev, &ctx->rng);
+	if (ret) {
+		caam_rng_exit(ctrldev);
+		return ret;
 	}
 
-	kfree(rng_ctx);
-	return err;
+	devres_close_group(ctrldev, caam_rng_init);
+	return 0;
 }
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index 230ea88184f5..402d6a362e8c 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -47,6 +47,7 @@ struct caam_drv_private_jr {
 	struct caam_job_ring __iomem *rregs;	/* JobR's register space */
 	struct tasklet_struct irqtask;
 	int irq;			/* One per queue */
+	bool hwrng;
 
 	/* Number of scatterlist crypt transforms active on the JobR */
 	atomic_t tfm_count ____cacheline_aligned;
@@ -163,7 +164,7 @@ static inline void caam_pkc_exit(void)
 #ifdef CONFIG_CRYPTO_DEV_FSL_CAAM_RNG_API
 
 int caam_rng_init(struct device *dev);
-void caam_rng_exit(void);
+void caam_rng_exit(struct device *dev);
 
 #else
 
@@ -172,9 +173,7 @@ static inline int caam_rng_init(struct device *dev)
 	return 0;
 }
 
-static inline void caam_rng_exit(void)
-{
-}
+static inline void caam_rng_exit(struct device *dev) {}
 
 #endif /* CONFIG_CRYPTO_DEV_FSL_CAAM_RNG_API */
 
diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 88aff2aefd5d..4af22e7ceb4f 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -27,7 +27,8 @@ static struct jr_driver_data driver_data;
 static DEFINE_MUTEX(algs_lock);
 static unsigned int active_devs;
 
-static void register_algs(struct device *dev)
+static void register_algs(struct caam_drv_private_jr *jrpriv,
+			  struct device *dev)
 {
 	mutex_lock(&algs_lock);
 
@@ -37,7 +38,7 @@ static void register_algs(struct device *dev)
 	caam_algapi_init(dev);
 	caam_algapi_hash_init(dev);
 	caam_pkc_init(dev);
-	caam_rng_init(dev);
+	jrpriv->hwrng = !caam_rng_init(dev);
 	caam_qi_algapi_init(dev);
 
 algs_unlock:
@@ -53,7 +54,6 @@ static void unregister_algs(void)
 
 	caam_qi_algapi_exit();
 
-	caam_rng_exit();
 	caam_pkc_exit();
 	caam_algapi_hash_exit();
 	caam_algapi_exit();
@@ -135,6 +135,9 @@ static int caam_jr_remove(struct platform_device *pdev)
 	jrdev = &pdev->dev;
 	jrpriv = dev_get_drvdata(jrdev);
 
+	if (jrpriv->hwrng)
+		caam_rng_exit(jrdev->parent);
+
 	/*
 	 * Return EBUSY if job ring already allocated.
 	 */
@@ -514,7 +517,7 @@ static int caam_jr_probe(struct platform_device *pdev)
 	int error;
 
 	jrdev = &pdev->dev;
-	jrpriv = devm_kmalloc(jrdev, sizeof(*jrpriv), GFP_KERNEL);
+	jrpriv = devm_kzalloc(jrdev, sizeof(*jrpriv), GFP_KERNEL);
 	if (!jrpriv)
 		return -ENOMEM;
 
@@ -590,7 +593,7 @@ static int caam_jr_probe(struct platform_device *pdev)
 
 	atomic_set(&jrpriv->tfm_count, 0);
 
-	register_algs(jrdev->parent);
+	register_algs(jrpriv, jrdev->parent);
 
 	return 0;
 }
-- 
2.21.0

