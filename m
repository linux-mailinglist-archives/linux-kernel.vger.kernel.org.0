Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 910D97C2C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 15:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388078AbfGaNGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 09:06:10 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41214 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387730AbfGaNGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:06:07 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1A17A200A1F;
        Wed, 31 Jul 2019 15:06:05 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0E0EF2009FA;
        Wed, 31 Jul 2019 15:06:05 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C22B7205F3;
        Wed, 31 Jul 2019 15:06:04 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v3 2/2] crypto: aes - helper function to validate key length for AES algorithms
Date:   Wed, 31 Jul 2019 16:05:55 +0300
Message-Id: <1564578355-9639-3-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1564578355-9639-1-git-send-email-iuliana.prodan@nxp.com>
References: <1564578355-9639-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add inline helper function to check key length for AES algorithms.
The key can be 128, 192 or 256 bits size.
This function is used in the generic aes implementation.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 include/crypto/aes.h | 17 +++++++++++++++++
 lib/crypto/aes.c     |  8 ++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 8e0f4cf..2090729 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -31,6 +31,23 @@ struct crypto_aes_ctx {
 extern const u32 crypto_ft_tab[4][256] ____cacheline_aligned;
 extern const u32 crypto_it_tab[4][256] ____cacheline_aligned;
 
+/*
+ * validate key length for AES algorithms
+ */
+static inline int aes_check_keylen(unsigned int keylen)
+{
+	switch (keylen) {
+	case AES_KEYSIZE_128:
+	case AES_KEYSIZE_192:
+	case AES_KEYSIZE_256:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int crypto_aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
 		unsigned int key_len);
 
diff --git a/lib/crypto/aes.c b/lib/crypto/aes.c
index 4e100af..827fe89 100644
--- a/lib/crypto/aes.c
+++ b/lib/crypto/aes.c
@@ -187,11 +187,11 @@ int aes_expandkey(struct crypto_aes_ctx *ctx, const u8 *in_key,
 {
 	u32 kwords = key_len / sizeof(u32);
 	u32 rc, i, j;
+	int err;
 
-	if (key_len != AES_KEYSIZE_128 &&
-	    key_len != AES_KEYSIZE_192 &&
-	    key_len != AES_KEYSIZE_256)
-		return -EINVAL;
+	err = aes_check_keylen(key_len);
+	if (err)
+		return err;
 
 	ctx->key_length = key_len;
 
-- 
2.1.0

