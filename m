Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 988856D020
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 16:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390780AbfGROpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 10:45:50 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49480 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbfGROpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:45:43 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 562501A035E;
        Thu, 18 Jul 2019 16:45:41 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A3F21A035C;
        Thu, 18 Jul 2019 16:45:41 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id EC115205C7;
        Thu, 18 Jul 2019 16:45:40 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH 12/14] crypto: caam - execute module exit point only if necessary
Date:   Thu, 18 Jul 2019 17:45:22 +0300
Message-Id: <1563461124-24641-13-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1563461124-24641-1-git-send-email-iuliana.prodan@nxp.com>
References: <1563461124-24641-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1b46c90c8e00 ("crypto: caam - convert top level drivers to libraries")
changed entry and exit points behavior for caamalg,
caamalg_qi, caamalg_qi2, caamhash, caampkc, caamrng.

For example, previously caam_pkc_init() and caam_pkc_exit() were
module entry/exit points. This means that if an error would happen
in caam_pkc_init(), then caam_pkc_exit() wouldn't have been called.
After the mentioned commit, caam_pkc_init() and caam_pkc_exit()
are manually called - from jr.c. caam_pkc_exit() is called
unconditionally, even if caam_pkc_init() failed.

Added a global variable to keep the status of the algorithm
registration and free of resources.
The exit point of caampkc/caamrng module is executed only if the
registration was successful. Therefore we avoid double free of
resources in case the algorithm registration failed.

Fixes: 1b46c90c8e00 ("crypto: caam - convert top level drivers to libraries")
Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/crypto/caam/caampkc.c | 11 +++++++++++
 drivers/crypto/caam/caamrng.c | 14 +++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index 574428c7..cfdf7a2 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -29,6 +29,12 @@
 /* buffer filled with zeros, used for padding */
 static u8 *zero_buffer;
 
+/*
+ * variable used to avoid double free of resources in case
+ * algorithm registration was unsuccessful
+ */
+static bool init_done;
+
 static void rsa_io_unmap(struct device *dev, struct rsa_edesc *edesc,
 			 struct akcipher_request *req)
 {
@@ -1081,6 +1087,7 @@ int caam_pkc_init(struct device *ctrldev)
 	struct caam_drv_private *priv = dev_get_drvdata(ctrldev);
 	u32 pk_inst;
 	int err;
+	init_done = false;
 
 	/* Determine public key hardware accelerator presence. */
 	if (priv->era < 10)
@@ -1105,6 +1112,7 @@ int caam_pkc_init(struct device *ctrldev)
 		dev_warn(ctrldev, "%s alg registration failed\n",
 			 caam_rsa.base.cra_driver_name);
 	} else {
+		init_done = true;
 		dev_info(ctrldev, "caam pkc algorithms registered in /proc/crypto\n");
 	}
 
@@ -1113,6 +1121,9 @@ int caam_pkc_init(struct device *ctrldev)
 
 void caam_pkc_exit(void)
 {
+	if (!init_done)
+		return;
+
 	kfree(zero_buffer);
 	crypto_unregister_akcipher(&caam_rsa);
 }
diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index 54c32d5..7fbda1b 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -80,6 +80,12 @@ struct caam_rng_ctx {
 
 static struct caam_rng_ctx *rng_ctx;
 
+/*
+ * Variable used to avoid double free of resources in case
+ * algorithm registration was unsuccessful
+ */
+static bool init_done;
+
 static inline void rng_unmap_buf(struct device *jrdev, struct buf_data *bd)
 {
 	if (bd->addr)
@@ -296,6 +302,9 @@ static struct hwrng caam_rng = {
 
 void caam_rng_exit(void)
 {
+	if (!init_done)
+		return;
+
 	caam_jr_free(rng_ctx->jrdev);
 	hwrng_unregister(&caam_rng);
 	kfree(rng_ctx);
@@ -307,6 +316,7 @@ int caam_rng_init(struct device *ctrldev)
 	u32 rng_inst;
 	struct caam_drv_private *priv = dev_get_drvdata(ctrldev);
 	int err;
+	init_done = false;
 
 	/* Check for an instantiated RNG before registration */
 	if (priv->era < 10)
@@ -335,8 +345,10 @@ int caam_rng_init(struct device *ctrldev)
 	dev_info(dev, "registering rng-caam\n");
 
 	err = hwrng_register(&caam_rng);
-	if (!err)
+	if (!err) {
+		init_done = true;
 		return err;
+	}
 
 free_rng_ctx:
 	kfree(rng_ctx);
-- 
2.1.0

