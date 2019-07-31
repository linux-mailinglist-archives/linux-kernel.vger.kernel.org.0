Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1BE7C2DA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 15:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfGaNIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 09:08:40 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35274 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388167AbfGaNI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:08:28 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 050741A09DF;
        Wed, 31 Jul 2019 15:08:26 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ECFE11A09DE;
        Wed, 31 Jul 2019 15:08:25 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 99628205F3;
        Wed, 31 Jul 2019 15:08:25 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v5 13/14] crypto: caam - unregister algorithm only if the registration succeeded
Date:   Wed, 31 Jul 2019 16:08:14 +0300
Message-Id: <1564578495-9883-14-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1564578495-9883-1-git-send-email-iuliana.prodan@nxp.com>
References: <1564578495-9883-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To know if a registration succeeded added a new struct,
caam_akcipher_alg, that keeps, also, the registration status.
This status is updated in caam_pkc_init and verified in
caam_pkc_exit to unregister an algorithm.

Fixes: 1b46c90c8e00 ("crypto: caam - convert top level drivers to libraries")
Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
---
 drivers/crypto/caam/caampkc.c | 49 ++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index e00a470..5b12b23 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -35,6 +35,11 @@ static u8 *zero_buffer;
  */
 static bool init_done;
 
+struct caam_akcipher_alg {
+	struct akcipher_alg akcipher;
+	bool registered;
+};
+
 static void rsa_io_unmap(struct device *dev, struct rsa_edesc *edesc,
 			 struct akcipher_request *req)
 {
@@ -1058,22 +1063,24 @@ static void caam_rsa_exit_tfm(struct crypto_akcipher *tfm)
 	caam_jr_free(ctx->dev);
 }
 
-static struct akcipher_alg caam_rsa = {
-	.encrypt = caam_rsa_enc,
-	.decrypt = caam_rsa_dec,
-	.set_pub_key = caam_rsa_set_pub_key,
-	.set_priv_key = caam_rsa_set_priv_key,
-	.max_size = caam_rsa_max_size,
-	.init = caam_rsa_init_tfm,
-	.exit = caam_rsa_exit_tfm,
-	.reqsize = sizeof(struct caam_rsa_req_ctx),
-	.base = {
-		.cra_name = "rsa",
-		.cra_driver_name = "rsa-caam",
-		.cra_priority = 3000,
-		.cra_module = THIS_MODULE,
-		.cra_ctxsize = sizeof(struct caam_rsa_ctx),
-	},
+static struct caam_akcipher_alg caam_rsa = {
+	.akcipher = {
+		.encrypt = caam_rsa_enc,
+		.decrypt = caam_rsa_dec,
+		.set_pub_key = caam_rsa_set_pub_key,
+		.set_priv_key = caam_rsa_set_priv_key,
+		.max_size = caam_rsa_max_size,
+		.init = caam_rsa_init_tfm,
+		.exit = caam_rsa_exit_tfm,
+		.reqsize = sizeof(struct caam_rsa_req_ctx),
+		.base = {
+			.cra_name = "rsa",
+			.cra_driver_name = "rsa-caam",
+			.cra_priority = 3000,
+			.cra_module = THIS_MODULE,
+			.cra_ctxsize = sizeof(struct caam_rsa_ctx),
+		},
+	}
 };
 
 /* Public Key Cryptography module initialization handler */
@@ -1101,13 +1108,15 @@ int caam_pkc_init(struct device *ctrldev)
 	if (!zero_buffer)
 		return -ENOMEM;
 
-	err = crypto_register_akcipher(&caam_rsa);
+	err = crypto_register_akcipher(&caam_rsa.akcipher);
+
 	if (err) {
 		kfree(zero_buffer);
 		dev_warn(ctrldev, "%s alg registration failed\n",
-			 caam_rsa.base.cra_driver_name);
+			 caam_rsa.akcipher.base.cra_driver_name);
 	} else {
 		init_done = true;
+		caam_rsa.registered = true;
 		dev_info(ctrldev, "caam pkc algorithms registered in /proc/crypto\n");
 	}
 
@@ -1119,6 +1128,8 @@ void caam_pkc_exit(void)
 	if (!init_done)
 		return;
 
+	if (caam_rsa.registered)
+		crypto_unregister_akcipher(&caam_rsa.akcipher);
+
 	kfree(zero_buffer);
-	crypto_unregister_akcipher(&caam_rsa);
 }
-- 
2.1.0

