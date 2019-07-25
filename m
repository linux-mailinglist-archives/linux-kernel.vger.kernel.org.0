Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD0E75061
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 15:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404368AbfGYN6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 09:58:55 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58308 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404178AbfGYN6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:58:43 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 14AD3200720;
        Thu, 25 Jul 2019 15:58:38 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 050BA20071D;
        Thu, 25 Jul 2019 15:58:38 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id AC3DA205E8;
        Thu, 25 Jul 2019 15:58:37 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v3 04/14] crypto: caam - check key length
Date:   Thu, 25 Jul 2019 16:58:16 +0300
Message-Id: <1564063106-9552-5-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1564063106-9552-1-git-send-email-iuliana.prodan@nxp.com>
References: <1564063106-9552-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check key length to solve the extra tests that expect -EINVAL to be
returned when the key size is not valid.

Validated AES keylen for skcipher, ahash and aead.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
Changes since v2:
- remove check for keylen < 4, since is included in check_aes_keylen;
- update commit description to include aead.
---
 drivers/crypto/caam/Kconfig       |   2 +
 drivers/crypto/caam/caamalg.c     | 125 ++++++++++++++++++++++--------
 drivers/crypto/caam/caamalg_qi.c  | 130 ++++++++++++++++++++++++--------
 drivers/crypto/caam/caamalg_qi2.c | 155 ++++++++++++++++++++++++++++----------
 drivers/crypto/caam/caamhash.c    |  12 +++
 5 files changed, 324 insertions(+), 100 deletions(-)

diff --git a/drivers/crypto/caam/Kconfig b/drivers/crypto/caam/Kconfig
index 3720ddab..e4fdf54 100644
--- a/drivers/crypto/caam/Kconfig
+++ b/drivers/crypto/caam/Kconfig
@@ -111,6 +111,7 @@ config CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI
 	select CRYPTO_DEV_FSL_CAAM_CRYPTO_API_DESC
 	select CRYPTO_AUTHENC
 	select CRYPTO_BLKCIPHER
+	select CRYPTO_DES
 	help
 	  Selecting this will use CAAM Queue Interface (QI) for sending
 	  & receiving crypto jobs to/from CAAM. This gives better performance
@@ -161,6 +162,7 @@ config CRYPTO_DEV_FSL_DPAA2_CAAM
 	select CRYPTO_AUTHENC
 	select CRYPTO_AEAD
 	select CRYPTO_HASH
+	select CRYPTO_DES
 	help
 	  CAAM driver for QorIQ Data Path Acceleration Architecture 2.
 	  It handles DPSECI DPAA2 objects that sit on the Management Complex
diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index 28d55a0..d379ea6 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -667,6 +667,13 @@ static int gcm_setkey(struct crypto_aead *aead,
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(aead);
 	struct device *jrdev = ctx->jrdev;
+	int err;
+
+	err = check_aes_keylen(keylen);
+	if (err) {
+		crypto_aead_set_flags(aead, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return err;
+	}
 
 	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
@@ -683,9 +690,13 @@ static int rfc4106_setkey(struct crypto_aead *aead,
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(aead);
 	struct device *jrdev = ctx->jrdev;
+	int err;
 
-	if (keylen < 4)
-		return -EINVAL;
+	err = check_aes_keylen(keylen - 4);
+	if (err) {
+		crypto_aead_set_flags(aead, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return err;
+	}
 
 	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
@@ -707,9 +718,13 @@ static int rfc4543_setkey(struct crypto_aead *aead,
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(aead);
 	struct device *jrdev = ctx->jrdev;
+	int err;
 
-	if (keylen < 4)
-		return -EINVAL;
+	err = check_aes_keylen(keylen - 4);
+	if (err) {
+		crypto_aead_set_flags(aead, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return err;
+	}
 
 	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
@@ -727,7 +742,7 @@ static int rfc4543_setkey(struct crypto_aead *aead,
 }
 
 static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
-			   unsigned int keylen)
+			   unsigned int keylen, const u32 ctx1_iv_off)
 {
 	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
 	struct caam_skcipher_alg *alg =
@@ -736,30 +751,10 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	struct device *jrdev = ctx->jrdev;
 	unsigned int ivsize = crypto_skcipher_ivsize(skcipher);
 	u32 *desc;
-	u32 ctx1_iv_off = 0;
-	const bool ctr_mode = ((ctx->cdata.algtype & OP_ALG_AAI_MASK) ==
-			       OP_ALG_AAI_CTR_MOD128);
 	const bool is_rfc3686 = alg->caam.rfc3686;
 
 	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
-	/*
-	 * AES-CTR needs to load IV in CONTEXT1 reg
-	 * at an offset of 128bits (16bytes)
-	 * CONTEXT1[255:128] = IV
-	 */
-	if (ctr_mode)
-		ctx1_iv_off = 16;
-
-	/*
-	 * RFC3686 specific:
-	 *	| CONTEXT1[255:128] = {NONCE, IV, COUNTER}
-	 *	| *key = {KEY, NONCE}
-	 */
-	if (is_rfc3686) {
-		ctx1_iv_off = 16 + CTR_RFC3686_NONCE_SIZE;
-		keylen -= CTR_RFC3686_NONCE_SIZE;
-	}
 
 	ctx->cdata.keylen = keylen;
 	ctx->cdata.key_virt = key;
@@ -782,6 +777,74 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	return 0;
 }
 
+static int aes_skcipher_setkey(struct crypto_skcipher *skcipher,
+			       const u8 *key, unsigned int keylen)
+{
+	int err;
+
+	err = check_aes_keylen(keylen);
+	if (err) {
+		crypto_skcipher_set_flags(skcipher,
+					  CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return err;
+	}
+
+	return skcipher_setkey(skcipher, key, keylen, 0);
+}
+
+static int rfc3686_skcipher_setkey(struct crypto_skcipher *skcipher,
+				   const u8 *key, unsigned int keylen)
+{
+	u32 ctx1_iv_off;
+	int err;
+
+	/*
+	 * RFC3686 specific:
+	 *	| CONTEXT1[255:128] = {NONCE, IV, COUNTER}
+	 *	| *key = {KEY, NONCE}
+	 */
+	ctx1_iv_off = 16 + CTR_RFC3686_NONCE_SIZE;
+	keylen -= CTR_RFC3686_NONCE_SIZE;
+
+	err = check_aes_keylen(keylen);
+	if (err) {
+		crypto_skcipher_set_flags(skcipher,
+					  CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return err;
+	}
+
+	return skcipher_setkey(skcipher, key, keylen, ctx1_iv_off);
+}
+
+static int ctr_skcipher_setkey(struct crypto_skcipher *skcipher,
+			       const u8 *key, unsigned int keylen)
+{
+	u32 ctx1_iv_off;
+	int err;
+
+	/*
+	 * AES-CTR needs to load IV in CONTEXT1 reg
+	 * at an offset of 128bits (16bytes)
+	 * CONTEXT1[255:128] = IV
+	 */
+	ctx1_iv_off = 16;
+
+	err = check_aes_keylen(keylen);
+	if (err) {
+		crypto_skcipher_set_flags(skcipher,
+					  CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return err;
+	}
+
+	return skcipher_setkey(skcipher, key, keylen, ctx1_iv_off);
+}
+
+static int arc4_skcipher_setkey(struct crypto_skcipher *skcipher,
+				const u8 *key, unsigned int keylen)
+{
+	return skcipher_setkey(skcipher, key, keylen, 0);
+}
+
 static int des_skcipher_setkey(struct crypto_skcipher *skcipher,
 			       const u8 *key, unsigned int keylen)
 {
@@ -800,7 +863,7 @@ static int des_skcipher_setkey(struct crypto_skcipher *skcipher,
 		return -EINVAL;
 	}
 
-	return skcipher_setkey(skcipher, key, keylen);
+	return skcipher_setkey(skcipher, key, keylen, 0);
 }
 
 static int xts_skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
@@ -1880,7 +1943,7 @@ static struct caam_skcipher_alg driver_algs[] = {
 				.cra_driver_name = "cbc-aes-caam",
 				.cra_blocksize = AES_BLOCK_SIZE,
 			},
-			.setkey = skcipher_setkey,
+			.setkey = aes_skcipher_setkey,
 			.encrypt = skcipher_encrypt,
 			.decrypt = skcipher_decrypt,
 			.min_keysize = AES_MIN_KEY_SIZE,
@@ -1928,7 +1991,7 @@ static struct caam_skcipher_alg driver_algs[] = {
 				.cra_driver_name = "ctr-aes-caam",
 				.cra_blocksize = 1,
 			},
-			.setkey = skcipher_setkey,
+			.setkey = ctr_skcipher_setkey,
 			.encrypt = skcipher_encrypt,
 			.decrypt = skcipher_decrypt,
 			.min_keysize = AES_MIN_KEY_SIZE,
@@ -1946,7 +2009,7 @@ static struct caam_skcipher_alg driver_algs[] = {
 				.cra_driver_name = "rfc3686-ctr-aes-caam",
 				.cra_blocksize = 1,
 			},
-			.setkey = skcipher_setkey,
+			.setkey = rfc3686_skcipher_setkey,
 			.encrypt = skcipher_encrypt,
 			.decrypt = skcipher_decrypt,
 			.min_keysize = AES_MIN_KEY_SIZE +
@@ -2000,7 +2063,7 @@ static struct caam_skcipher_alg driver_algs[] = {
 				.cra_driver_name = "ecb-aes-caam",
 				.cra_blocksize = AES_BLOCK_SIZE,
 			},
-			.setkey = skcipher_setkey,
+			.setkey = aes_skcipher_setkey,
 			.encrypt = skcipher_encrypt,
 			.decrypt = skcipher_decrypt,
 			.min_keysize = AES_MIN_KEY_SIZE,
@@ -2030,7 +2093,7 @@ static struct caam_skcipher_alg driver_algs[] = {
 				.cra_driver_name = "ecb-arc4-caam",
 				.cra_blocksize = ARC4_BLOCK_SIZE,
 			},
-			.setkey = skcipher_setkey,
+			.setkey = arc4_skcipher_setkey,
 			.encrypt = skcipher_encrypt,
 			.decrypt = skcipher_decrypt,
 			.min_keysize = ARC4_MIN_KEY_SIZE,
diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index 66531d6..6d8cdba 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -385,6 +385,12 @@ static int gcm_setkey(struct crypto_aead *aead,
 	struct device *jrdev = ctx->jrdev;
 	int ret;
 
+	ret = check_aes_keylen(keylen);
+	if (ret) {
+		crypto_aead_set_flags(aead, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return ret;
+	}
+
 	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
@@ -480,8 +486,11 @@ static int rfc4106_setkey(struct crypto_aead *aead,
 	struct device *jrdev = ctx->jrdev;
 	int ret;
 
-	if (keylen < 4)
-		return -EINVAL;
+	ret = check_aes_keylen(keylen - 4);
+	if (ret) {
+		crypto_aead_set_flags(aead, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return ret;
+	}
 
 	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
@@ -582,8 +591,11 @@ static int rfc4543_setkey(struct crypto_aead *aead,
 	struct device *jrdev = ctx->jrdev;
 	int ret;
 
-	if (keylen < 4)
-		return -EINVAL;
+	ret = check_aes_keylen(keylen - 4);
+	if (ret) {
+		crypto_aead_set_flags(aead, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return ret;
+	}
 
 	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
@@ -624,7 +636,7 @@ static int rfc4543_setkey(struct crypto_aead *aead,
 }
 
 static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
-			   unsigned int keylen)
+			   unsigned int keylen, const u32 ctx1_iv_off)
 {
 	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
 	struct caam_skcipher_alg *alg =
@@ -632,33 +644,12 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 			     skcipher);
 	struct device *jrdev = ctx->jrdev;
 	unsigned int ivsize = crypto_skcipher_ivsize(skcipher);
-	u32 ctx1_iv_off = 0;
-	const bool ctr_mode = ((ctx->cdata.algtype & OP_ALG_AAI_MASK) ==
-			       OP_ALG_AAI_CTR_MOD128);
 	const bool is_rfc3686 = alg->caam.rfc3686;
 	int ret = 0;
 
 	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
-	/*
-	 * AES-CTR needs to load IV in CONTEXT1 reg
-	 * at an offset of 128bits (16bytes)
-	 * CONTEXT1[255:128] = IV
-	 */
-	if (ctr_mode)
-		ctx1_iv_off = 16;
-
-	/*
-	 * RFC3686 specific:
-	 *	| CONTEXT1[255:128] = {NONCE, IV, COUNTER}
-	 *	| *key = {KEY, NONCE}
-	 */
-	if (is_rfc3686) {
-		ctx1_iv_off = 16 + CTR_RFC3686_NONCE_SIZE;
-		keylen -= CTR_RFC3686_NONCE_SIZE;
-	}
-
 	ctx->cdata.keylen = keylen;
 	ctx->cdata.key_virt = key;
 	ctx->cdata.key_inline = true;
@@ -694,11 +685,88 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	return -EINVAL;
 }
 
+static int aes_skcipher_setkey(struct crypto_skcipher *skcipher,
+			       const u8 *key, unsigned int keylen)
+{
+	int err;
+
+	err = check_aes_keylen(keylen);
+	if (err) {
+		crypto_skcipher_set_flags(skcipher,
+					  CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return err;
+	}
+
+	return skcipher_setkey(skcipher, key, keylen, 0);
+}
+
+static int rfc3686_skcipher_setkey(struct crypto_skcipher *skcipher,
+				   const u8 *key, unsigned int keylen)
+{
+	u32 ctx1_iv_off;
+	int err;
+
+	/*
+	 * RFC3686 specific:
+	 *	| CONTEXT1[255:128] = {NONCE, IV, COUNTER}
+	 *	| *key = {KEY, NONCE}
+	 */
+	ctx1_iv_off = 16 + CTR_RFC3686_NONCE_SIZE;
+	keylen -= CTR_RFC3686_NONCE_SIZE;
+
+	err = check_aes_keylen(keylen);
+	if (err) {
+		crypto_skcipher_set_flags(skcipher,
+					  CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return err;
+	}
+
+	return skcipher_setkey(skcipher, key, keylen, ctx1_iv_off);
+}
+
+static int ctr_skcipher_setkey(struct crypto_skcipher *skcipher,
+			       const u8 *key, unsigned int keylen)
+{
+	u32 ctx1_iv_off;
+	int err;
+
+	/*
+	 * AES-CTR needs to load IV in CONTEXT1 reg
+	 * at an offset of 128bits (16bytes)
+	 * CONTEXT1[255:128] = IV
+	 */
+	ctx1_iv_off = 16;
+
+	err = check_aes_keylen(keylen);
+	if (err) {
+		crypto_skcipher_set_flags(skcipher,
+					  CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return err;
+	}
+
+	return skcipher_setkey(skcipher, key, keylen, ctx1_iv_off);
+}
+
 static int des3_skcipher_setkey(struct crypto_skcipher *skcipher,
 				const u8 *key, unsigned int keylen)
 {
 	return unlikely(des3_verify_key(skcipher, key)) ?:
-	       skcipher_setkey(skcipher, key, keylen);
+	       skcipher_setkey(skcipher, key, keylen, 0);
+}
+
+static int des_skcipher_setkey(struct crypto_skcipher *skcipher,
+			       const u8 *key, unsigned int keylen)
+{
+	u32 tmp[DES_EXPKEY_WORDS];
+
+	if (!des_ekey(tmp, key) && (crypto_skcipher_get_flags(skcipher) &
+	    CRYPTO_TFM_REQ_FORBID_WEAK_KEYS)) {
+		crypto_skcipher_set_flags(skcipher,
+					  CRYPTO_TFM_RES_WEAK_KEY);
+		return -EINVAL;
+	}
+
+	return skcipher_setkey(skcipher, key, keylen, 0);
 }
 
 static int xts_skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
@@ -1405,7 +1473,7 @@ static struct caam_skcipher_alg driver_algs[] = {
 				.cra_driver_name = "cbc-aes-caam-qi",
 				.cra_blocksize = AES_BLOCK_SIZE,
 			},
-			.setkey = skcipher_setkey,
+			.setkey = aes_skcipher_setkey,
 			.encrypt = skcipher_encrypt,
 			.decrypt = skcipher_decrypt,
 			.min_keysize = AES_MIN_KEY_SIZE,
@@ -1437,7 +1505,7 @@ static struct caam_skcipher_alg driver_algs[] = {
 				.cra_driver_name = "cbc-des-caam-qi",
 				.cra_blocksize = DES_BLOCK_SIZE,
 			},
-			.setkey = skcipher_setkey,
+			.setkey = des_skcipher_setkey,
 			.encrypt = skcipher_encrypt,
 			.decrypt = skcipher_decrypt,
 			.min_keysize = DES_KEY_SIZE,
@@ -1453,7 +1521,7 @@ static struct caam_skcipher_alg driver_algs[] = {
 				.cra_driver_name = "ctr-aes-caam-qi",
 				.cra_blocksize = 1,
 			},
-			.setkey = skcipher_setkey,
+			.setkey = ctr_skcipher_setkey,
 			.encrypt = skcipher_encrypt,
 			.decrypt = skcipher_decrypt,
 			.min_keysize = AES_MIN_KEY_SIZE,
@@ -1471,7 +1539,7 @@ static struct caam_skcipher_alg driver_algs[] = {
 				.cra_driver_name = "rfc3686-ctr-aes-caam-qi",
 				.cra_blocksize = 1,
 			},
-			.setkey = skcipher_setkey,
+			.setkey = rfc3686_skcipher_setkey,
 			.encrypt = skcipher_encrypt,
 			.decrypt = skcipher_decrypt,
 			.min_keysize = AES_MIN_KEY_SIZE +
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index bc370af..a13d05e 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -731,7 +731,13 @@ static int gcm_setkey(struct crypto_aead *aead,
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(aead);
 	struct device *dev = ctx->dev;
+	int ret;
 
+	ret = check_aes_keylen(keylen);
+	if (ret) {
+		crypto_aead_set_flags(aead, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return ret;
+	}
 	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
@@ -817,9 +823,13 @@ static int rfc4106_setkey(struct crypto_aead *aead,
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(aead);
 	struct device *dev = ctx->dev;
+	int ret;
 
-	if (keylen < 4)
-		return -EINVAL;
+	ret = check_aes_keylen(keylen - 4);
+	if (ret) {
+		crypto_aead_set_flags(aead, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return ret;
+	}
 
 	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
@@ -911,9 +921,13 @@ static int rfc4543_setkey(struct crypto_aead *aead,
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(aead);
 	struct device *dev = ctx->dev;
+	int ret;
 
-	if (keylen < 4)
-		return -EINVAL;
+	ret = check_aes_keylen(keylen - 4);
+	if (ret) {
+		crypto_aead_set_flags(aead, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return ret;
+	}
 
 	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
@@ -931,7 +945,7 @@ static int rfc4543_setkey(struct crypto_aead *aead,
 }
 
 static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
-			   unsigned int keylen)
+			   unsigned int keylen, const u32 ctx1_iv_off)
 {
 	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
 	struct caam_skcipher_alg *alg =
@@ -941,34 +955,11 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	struct caam_flc *flc;
 	unsigned int ivsize = crypto_skcipher_ivsize(skcipher);
 	u32 *desc;
-	u32 ctx1_iv_off = 0;
-	const bool ctr_mode = ((ctx->cdata.algtype & OP_ALG_AAI_MASK) ==
-			       OP_ALG_AAI_CTR_MOD128) &&
-			       ((ctx->cdata.algtype & OP_ALG_ALGSEL_MASK) !=
-			       OP_ALG_ALGSEL_CHACHA20);
 	const bool is_rfc3686 = alg->caam.rfc3686;
 
 	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
 
-	/*
-	 * AES-CTR needs to load IV in CONTEXT1 reg
-	 * at an offset of 128bits (16bytes)
-	 * CONTEXT1[255:128] = IV
-	 */
-	if (ctr_mode)
-		ctx1_iv_off = 16;
-
-	/*
-	 * RFC3686 specific:
-	 *	| CONTEXT1[255:128] = {NONCE, IV, COUNTER}
-	 *	| *key = {KEY, NONCE}
-	 */
-	if (is_rfc3686) {
-		ctx1_iv_off = 16 + CTR_RFC3686_NONCE_SIZE;
-		keylen -= CTR_RFC3686_NONCE_SIZE;
-	}
-
 	ctx->cdata.keylen = keylen;
 	ctx->cdata.key_virt = key;
 	ctx->cdata.key_inline = true;
@@ -996,11 +987,99 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	return 0;
 }
 
-static int des3_skcipher_setkey(struct crypto_skcipher *skcipher,
-				const u8 *key, unsigned int keylen)
+static int aes_skcipher_setkey(struct crypto_skcipher *skcipher,
+			       const u8 *key, unsigned int keylen)
 {
-	return unlikely(des3_verify_key(skcipher, key)) ?:
-	       skcipher_setkey(skcipher, key, keylen);
+	int err;
+
+	err = check_aes_keylen(keylen);
+	if (err) {
+		crypto_skcipher_set_flags(skcipher,
+					  CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return err;
+	}
+
+	return skcipher_setkey(skcipher, key, keylen, 0);
+}
+
+static int rfc3686_skcipher_setkey(struct crypto_skcipher *skcipher,
+				   const u8 *key, unsigned int keylen)
+{
+	u32 ctx1_iv_off;
+	int err;
+
+	/*
+	 * RFC3686 specific:
+	 *	| CONTEXT1[255:128] = {NONCE, IV, COUNTER}
+	 *	| *key = {KEY, NONCE}
+	 */
+	ctx1_iv_off = 16 + CTR_RFC3686_NONCE_SIZE;
+	keylen -= CTR_RFC3686_NONCE_SIZE;
+
+	err = check_aes_keylen(keylen);
+	if (err) {
+		crypto_skcipher_set_flags(skcipher,
+					  CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return err;
+	}
+
+	return skcipher_setkey(skcipher, key, keylen, ctx1_iv_off);
+}
+
+static int ctr_skcipher_setkey(struct crypto_skcipher *skcipher,
+			       const u8 *key, unsigned int keylen)
+{
+	u32 ctx1_iv_off;
+	int err;
+
+	/*
+	 * AES-CTR needs to load IV in CONTEXT1 reg
+	 * at an offset of 128bits (16bytes)
+	 * CONTEXT1[255:128] = IV
+	 */
+	ctx1_iv_off = 16;
+
+	err = check_aes_keylen(keylen);
+	if (err) {
+		crypto_skcipher_set_flags(skcipher,
+					  CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return err;
+	}
+
+	return skcipher_setkey(skcipher, key, keylen, ctx1_iv_off);
+}
+
+static int chacha20_skcipher_setkey(struct crypto_skcipher *skcipher,
+				    const u8 *key, unsigned int keylen)
+{
+	if (keylen != CHACHA_KEY_SIZE) {
+		crypto_skcipher_set_flags(skcipher,
+					  CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return -EINVAL;
+	}
+
+	return skcipher_setkey(skcipher, key, keylen, 0);
+}
+
+static int des_skcipher_setkey(struct crypto_skcipher *skcipher,
+			       const u8 *key, unsigned int keylen)
+{
+	u32 tmp[DES3_EDE_EXPKEY_WORDS];
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(skcipher);
+
+	if (keylen == DES3_EDE_KEY_SIZE &&
+	    __des3_ede_setkey(tmp, &tfm->crt_flags, key, DES3_EDE_KEY_SIZE)) {
+		return -EINVAL;
+	}
+
+	if (!des_ekey(tmp, key) && (crypto_skcipher_get_flags(skcipher) &
+	    CRYPTO_TFM_REQ_FORBID_WEAK_KEYS)) {
+		crypto_skcipher_set_flags(skcipher,
+					  CRYPTO_TFM_RES_WEAK_KEY);
+		return -EINVAL;
+	}
+
+	return skcipher_setkey(skcipher, key, keylen, 0);
 }
 
 static int xts_skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
@@ -1534,7 +1613,7 @@ static struct caam_skcipher_alg driver_algs[] = {
 				.cra_driver_name = "cbc-aes-caam-qi2",
 				.cra_blocksize = AES_BLOCK_SIZE,
 			},
-			.setkey = skcipher_setkey,
+			.setkey = aes_skcipher_setkey,
 			.encrypt = skcipher_encrypt,
 			.decrypt = skcipher_decrypt,
 			.min_keysize = AES_MIN_KEY_SIZE,
@@ -1550,7 +1629,7 @@ static struct caam_skcipher_alg driver_algs[] = {
 				.cra_driver_name = "cbc-3des-caam-qi2",
 				.cra_blocksize = DES3_EDE_BLOCK_SIZE,
 			},
-			.setkey = des3_skcipher_setkey,
+			.setkey = des_skcipher_setkey,
 			.encrypt = skcipher_encrypt,
 			.decrypt = skcipher_decrypt,
 			.min_keysize = DES3_EDE_KEY_SIZE,
@@ -1566,7 +1645,7 @@ static struct caam_skcipher_alg driver_algs[] = {
 				.cra_driver_name = "cbc-des-caam-qi2",
 				.cra_blocksize = DES_BLOCK_SIZE,
 			},
-			.setkey = skcipher_setkey,
+			.setkey = des_skcipher_setkey,
 			.encrypt = skcipher_encrypt,
 			.decrypt = skcipher_decrypt,
 			.min_keysize = DES_KEY_SIZE,
@@ -1582,7 +1661,7 @@ static struct caam_skcipher_alg driver_algs[] = {
 				.cra_driver_name = "ctr-aes-caam-qi2",
 				.cra_blocksize = 1,
 			},
-			.setkey = skcipher_setkey,
+			.setkey = ctr_skcipher_setkey,
 			.encrypt = skcipher_encrypt,
 			.decrypt = skcipher_decrypt,
 			.min_keysize = AES_MIN_KEY_SIZE,
@@ -1600,7 +1679,7 @@ static struct caam_skcipher_alg driver_algs[] = {
 				.cra_driver_name = "rfc3686-ctr-aes-caam-qi2",
 				.cra_blocksize = 1,
 			},
-			.setkey = skcipher_setkey,
+			.setkey = rfc3686_skcipher_setkey,
 			.encrypt = skcipher_encrypt,
 			.decrypt = skcipher_decrypt,
 			.min_keysize = AES_MIN_KEY_SIZE +
@@ -1639,7 +1718,7 @@ static struct caam_skcipher_alg driver_algs[] = {
 				.cra_driver_name = "chacha20-caam-qi2",
 				.cra_blocksize = 1,
 			},
-			.setkey = skcipher_setkey,
+			.setkey = chacha20_skcipher_setkey,
 			.encrypt = skcipher_encrypt,
 			.decrypt = skcipher_decrypt,
 			.min_keysize = CHACHA_KEY_SIZE,
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 73abefa..60163d1 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -501,6 +501,11 @@ static int axcbc_setkey(struct crypto_ahash *ahash, const u8 *key,
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
 	struct device *jrdev = ctx->jrdev;
 
+	if (keylen != AES_KEYSIZE_128) {
+		crypto_ahash_set_flags(ahash, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return -EINVAL;
+	}
+
 	memcpy(ctx->key, key, keylen);
 	dma_sync_single_for_device(jrdev, ctx->key_dma, keylen, DMA_TO_DEVICE);
 	ctx->adata.keylen = keylen;
@@ -515,6 +520,13 @@ static int acmac_setkey(struct crypto_ahash *ahash, const u8 *key,
 			unsigned int keylen)
 {
 	struct caam_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	int err;
+
+	err = check_aes_keylen(keylen);
+	if (err) {
+		crypto_ahash_set_flags(ahash, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return err;
+	}
 
 	/* key is immediate data for all cmac shared descriptors */
 	ctx->adata.key_virt = key;
-- 
2.1.0

