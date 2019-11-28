Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D344110C0D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 00:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfK0XzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 18:55:09 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:47532 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfK0XzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 18:55:09 -0500
Received: by mail-pg1-f201.google.com with SMTP id c10so13621392pgm.14
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 15:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TBmrf+L6QyoicYDTtYwDm+MaGT0phAgPzIj9Fp85d8Q=;
        b=Ezzd8+6AaZLKjbmVTRKubZPJPKbyjtxF0x4XQzqUX2SaL1PHbUWRUyhsLfyf3T6gbv
         W1XYLnmBohxfYgd5qheShXKL82CCLUvF0BBOuIETYPHwXs4TGUjOVREJVWccwqgwxliE
         9B/9kJWIeCjaXFclnJCJmbPAfwVgRawqziKFsuG3JdM2TdUGMBRD5DEg1aT0cgMyPHa0
         ROMwQa631Vsxa/9eLCibqO6gqUqTkWe8MW3hd5siymxRBOlncpA/j/IVOrAsNol5jDJd
         In6GBYbA5p5Lc5VxsNKrXHM6rAa0b2U2b/KtI0wq7ddWGC7PSofYUt2OZYmHzs45Hp4J
         67Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TBmrf+L6QyoicYDTtYwDm+MaGT0phAgPzIj9Fp85d8Q=;
        b=GClz8xKwCWQo1BJaJ6OHf96J7u9VUw4l3WKI3YCmvBo1bMF83lbizYSLqQ6AURT9m4
         PLSUtNcAzuL2kxapKxvRh9np1LYNdga9yVhi//WRDKzfDDtdcbj6S/W8BKCcwDTjapwH
         +DO0ihIP+DSXu7F613+dn4wpyZE9Gp+z1xbTrJUHLfeRhLkVP3qWq/9tR+Ghn+3Ernox
         g3Leb64FqA+aB/OhfC36sSAWK21ePAwMDfIqYelNskeT87AAOkf2eHmRGQrtlnuCS7qO
         lloyoZiz7Xp3iqK4NUBUAfB2tTwGBLyrrMn0FFlS0IfxYWeDrtSb6nuUD7JPfXfqjAqW
         980g==
X-Gm-Message-State: APjAAAV5nfsVPI+pWkfCJ1fIqkNKJhEyBkXgYUkmGd5jwhnT8Gb5sk/U
        VNxvOOqKxOLIx7OZS69FYuVJCaT4npC1f+02saw=
X-Google-Smtp-Source: APXvYqxeytKpNwWTm1xri/Rry7b8uAqyjUjfI96BrYb7oUq0iRubW3zFIKONzQi1O3EwfBKJTN9To5kivGhSBsJwHZs=
X-Received: by 2002:a65:6118:: with SMTP id z24mr8212501pgu.203.1574898906237;
 Wed, 27 Nov 2019 15:55:06 -0800 (PST)
Date:   Wed, 27 Nov 2019 15:55:03 -0800
In-Reply-To: <20191112223046.176097-1-samitolvanen@google.com>
Message-Id: <20191127235503.93635-1-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191112223046.176097-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v4] crypto: arm64/sha: fix function types
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of casting pointers to callback functions, add C wrappers
to avoid type mismatch failures with Control-Flow Integrity (CFI)
checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
Changes in v4:
  - Removed unnecessary returns.

Changes in v3:
  - Removed unnecessary inline attributes.

Changes in v2:
  - Added wrapper functions instead of changing parameter types
    for the assembly functions.

---
 arch/arm64/crypto/sha1-ce-glue.c   | 17 +++++++++------
 arch/arm64/crypto/sha2-ce-glue.c   | 34 ++++++++++++++++++------------
 arch/arm64/crypto/sha256-glue.c    | 32 +++++++++++++++++-----------
 arch/arm64/crypto/sha512-ce-glue.c | 26 ++++++++++++-----------
 arch/arm64/crypto/sha512-glue.c    | 15 ++++++++-----
 5 files changed, 76 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/crypto/sha1-ce-glue.c b/arch/arm64/crypto/sha1-ce-glue.c
index bdc1b6d7aff7..63c875d3314b 100644
--- a/arch/arm64/crypto/sha1-ce-glue.c
+++ b/arch/arm64/crypto/sha1-ce-glue.c
@@ -28,6 +28,13 @@ struct sha1_ce_state {
 asmlinkage void sha1_ce_transform(struct sha1_ce_state *sst, u8 const *src,
 				  int blocks);
 
+static void __sha1_ce_transform(struct sha1_state *sst, u8 const *src,
+				int blocks)
+{
+	sha1_ce_transform(container_of(sst, struct sha1_ce_state, sst), src,
+			  blocks);
+}
+
 const u32 sha1_ce_offsetof_count = offsetof(struct sha1_ce_state, sst.count);
 const u32 sha1_ce_offsetof_finalize = offsetof(struct sha1_ce_state, finalize);
 
@@ -41,8 +48,7 @@ static int sha1_ce_update(struct shash_desc *desc, const u8 *data,
 
 	sctx->finalize = 0;
 	kernel_neon_begin();
-	sha1_base_do_update(desc, data, len,
-			    (sha1_block_fn *)sha1_ce_transform);
+	sha1_base_do_update(desc, data, len, __sha1_ce_transform);
 	kernel_neon_end();
 
 	return 0;
@@ -64,10 +70,9 @@ static int sha1_ce_finup(struct shash_desc *desc, const u8 *data,
 	sctx->finalize = finalize;
 
 	kernel_neon_begin();
-	sha1_base_do_update(desc, data, len,
-			    (sha1_block_fn *)sha1_ce_transform);
+	sha1_base_do_update(desc, data, len, __sha1_ce_transform);
 	if (!finalize)
-		sha1_base_do_finalize(desc, (sha1_block_fn *)sha1_ce_transform);
+		sha1_base_do_finalize(desc, __sha1_ce_transform);
 	kernel_neon_end();
 	return sha1_base_finish(desc, out);
 }
@@ -81,7 +86,7 @@ static int sha1_ce_final(struct shash_desc *desc, u8 *out)
 
 	sctx->finalize = 0;
 	kernel_neon_begin();
-	sha1_base_do_finalize(desc, (sha1_block_fn *)sha1_ce_transform);
+	sha1_base_do_finalize(desc, __sha1_ce_transform);
 	kernel_neon_end();
 	return sha1_base_finish(desc, out);
 }
diff --git a/arch/arm64/crypto/sha2-ce-glue.c b/arch/arm64/crypto/sha2-ce-glue.c
index 604a01a4ede6..a8e67bafba3d 100644
--- a/arch/arm64/crypto/sha2-ce-glue.c
+++ b/arch/arm64/crypto/sha2-ce-glue.c
@@ -28,6 +28,13 @@ struct sha256_ce_state {
 asmlinkage void sha2_ce_transform(struct sha256_ce_state *sst, u8 const *src,
 				  int blocks);
 
+static void __sha2_ce_transform(struct sha256_state *sst, u8 const *src,
+				int blocks)
+{
+	sha2_ce_transform(container_of(sst, struct sha256_ce_state, sst), src,
+			  blocks);
+}
+
 const u32 sha256_ce_offsetof_count = offsetof(struct sha256_ce_state,
 					      sst.count);
 const u32 sha256_ce_offsetof_finalize = offsetof(struct sha256_ce_state,
@@ -35,6 +42,12 @@ const u32 sha256_ce_offsetof_finalize = offsetof(struct sha256_ce_state,
 
 asmlinkage void sha256_block_data_order(u32 *digest, u8 const *src, int blocks);
 
+static void __sha256_block_data_order(struct sha256_state *sst, u8 const *src,
+				      int blocks)
+{
+	sha256_block_data_order(sst->state, src, blocks);
+}
+
 static int sha256_ce_update(struct shash_desc *desc, const u8 *data,
 			    unsigned int len)
 {
@@ -42,12 +55,11 @@ static int sha256_ce_update(struct shash_desc *desc, const u8 *data,
 
 	if (!crypto_simd_usable())
 		return sha256_base_do_update(desc, data, len,
-				(sha256_block_fn *)sha256_block_data_order);
+				__sha256_block_data_order);
 
 	sctx->finalize = 0;
 	kernel_neon_begin();
-	sha256_base_do_update(desc, data, len,
-			      (sha256_block_fn *)sha2_ce_transform);
+	sha256_base_do_update(desc, data, len, __sha2_ce_transform);
 	kernel_neon_end();
 
 	return 0;
@@ -62,9 +74,8 @@ static int sha256_ce_finup(struct shash_desc *desc, const u8 *data,
 	if (!crypto_simd_usable()) {
 		if (len)
 			sha256_base_do_update(desc, data, len,
-				(sha256_block_fn *)sha256_block_data_order);
-		sha256_base_do_finalize(desc,
-				(sha256_block_fn *)sha256_block_data_order);
+				__sha256_block_data_order);
+		sha256_base_do_finalize(desc, __sha256_block_data_order);
 		return sha256_base_finish(desc, out);
 	}
 
@@ -75,11 +86,9 @@ static int sha256_ce_finup(struct shash_desc *desc, const u8 *data,
 	sctx->finalize = finalize;
 
 	kernel_neon_begin();
-	sha256_base_do_update(desc, data, len,
-			      (sha256_block_fn *)sha2_ce_transform);
+	sha256_base_do_update(desc, data, len, __sha2_ce_transform);
 	if (!finalize)
-		sha256_base_do_finalize(desc,
-					(sha256_block_fn *)sha2_ce_transform);
+		sha256_base_do_finalize(desc, __sha2_ce_transform);
 	kernel_neon_end();
 	return sha256_base_finish(desc, out);
 }
@@ -89,14 +98,13 @@ static int sha256_ce_final(struct shash_desc *desc, u8 *out)
 	struct sha256_ce_state *sctx = shash_desc_ctx(desc);
 
 	if (!crypto_simd_usable()) {
-		sha256_base_do_finalize(desc,
-				(sha256_block_fn *)sha256_block_data_order);
+		sha256_base_do_finalize(desc, __sha256_block_data_order);
 		return sha256_base_finish(desc, out);
 	}
 
 	sctx->finalize = 0;
 	kernel_neon_begin();
-	sha256_base_do_finalize(desc, (sha256_block_fn *)sha2_ce_transform);
+	sha256_base_do_finalize(desc, __sha2_ce_transform);
 	kernel_neon_end();
 	return sha256_base_finish(desc, out);
 }
diff --git a/arch/arm64/crypto/sha256-glue.c b/arch/arm64/crypto/sha256-glue.c
index e273faca924f..01e0ab36d135 100644
--- a/arch/arm64/crypto/sha256-glue.c
+++ b/arch/arm64/crypto/sha256-glue.c
@@ -27,14 +27,26 @@ asmlinkage void sha256_block_data_order(u32 *digest, const void *data,
 					unsigned int num_blks);
 EXPORT_SYMBOL(sha256_block_data_order);
 
+static void __sha256_block_data_order(struct sha256_state *sst, u8 const *src,
+				      int blocks)
+{
+	sha256_block_data_order(sst->state, src, blocks);
+}
+
 asmlinkage void sha256_block_neon(u32 *digest, const void *data,
 				  unsigned int num_blks);
 
+static void __sha256_block_neon(struct sha256_state *sst, u8 const *src,
+				int blocks)
+{
+	sha256_block_neon(sst->state, src, blocks);
+}
+
 static int crypto_sha256_arm64_update(struct shash_desc *desc, const u8 *data,
 				      unsigned int len)
 {
 	return sha256_base_do_update(desc, data, len,
-				(sha256_block_fn *)sha256_block_data_order);
+				     __sha256_block_data_order);
 }
 
 static int crypto_sha256_arm64_finup(struct shash_desc *desc, const u8 *data,
@@ -42,9 +54,8 @@ static int crypto_sha256_arm64_finup(struct shash_desc *desc, const u8 *data,
 {
 	if (len)
 		sha256_base_do_update(desc, data, len,
-				(sha256_block_fn *)sha256_block_data_order);
-	sha256_base_do_finalize(desc,
-				(sha256_block_fn *)sha256_block_data_order);
+				      __sha256_block_data_order);
+	sha256_base_do_finalize(desc, __sha256_block_data_order);
 
 	return sha256_base_finish(desc, out);
 }
@@ -87,7 +98,7 @@ static int sha256_update_neon(struct shash_desc *desc, const u8 *data,
 
 	if (!crypto_simd_usable())
 		return sha256_base_do_update(desc, data, len,
-				(sha256_block_fn *)sha256_block_data_order);
+				__sha256_block_data_order);
 
 	while (len > 0) {
 		unsigned int chunk = len;
@@ -103,8 +114,7 @@ static int sha256_update_neon(struct shash_desc *desc, const u8 *data,
 				sctx->count % SHA256_BLOCK_SIZE;
 
 		kernel_neon_begin();
-		sha256_base_do_update(desc, data, chunk,
-				      (sha256_block_fn *)sha256_block_neon);
+		sha256_base_do_update(desc, data, chunk, __sha256_block_neon);
 		kernel_neon_end();
 		data += chunk;
 		len -= chunk;
@@ -118,15 +128,13 @@ static int sha256_finup_neon(struct shash_desc *desc, const u8 *data,
 	if (!crypto_simd_usable()) {
 		if (len)
 			sha256_base_do_update(desc, data, len,
-				(sha256_block_fn *)sha256_block_data_order);
-		sha256_base_do_finalize(desc,
-				(sha256_block_fn *)sha256_block_data_order);
+				__sha256_block_data_order);
+		sha256_base_do_finalize(desc, __sha256_block_data_order);
 	} else {
 		if (len)
 			sha256_update_neon(desc, data, len);
 		kernel_neon_begin();
-		sha256_base_do_finalize(desc,
-				(sha256_block_fn *)sha256_block_neon);
+		sha256_base_do_finalize(desc, __sha256_block_neon);
 		kernel_neon_end();
 	}
 	return sha256_base_finish(desc, out);
diff --git a/arch/arm64/crypto/sha512-ce-glue.c b/arch/arm64/crypto/sha512-ce-glue.c
index 2369540040aa..dc890a719f54 100644
--- a/arch/arm64/crypto/sha512-ce-glue.c
+++ b/arch/arm64/crypto/sha512-ce-glue.c
@@ -29,16 +29,21 @@ asmlinkage void sha512_ce_transform(struct sha512_state *sst, u8 const *src,
 
 asmlinkage void sha512_block_data_order(u64 *digest, u8 const *src, int blocks);
 
+static void __sha512_block_data_order(struct sha512_state *sst, u8 const *src,
+				      int blocks)
+{
+	sha512_block_data_order(sst->state, src, blocks);
+}
+
 static int sha512_ce_update(struct shash_desc *desc, const u8 *data,
 			    unsigned int len)
 {
 	if (!crypto_simd_usable())
 		return sha512_base_do_update(desc, data, len,
-				(sha512_block_fn *)sha512_block_data_order);
+					     __sha512_block_data_order);
 
 	kernel_neon_begin();
-	sha512_base_do_update(desc, data, len,
-			      (sha512_block_fn *)sha512_ce_transform);
+	sha512_base_do_update(desc, data, len, sha512_ce_transform);
 	kernel_neon_end();
 
 	return 0;
@@ -50,16 +55,14 @@ static int sha512_ce_finup(struct shash_desc *desc, const u8 *data,
 	if (!crypto_simd_usable()) {
 		if (len)
 			sha512_base_do_update(desc, data, len,
-				(sha512_block_fn *)sha512_block_data_order);
-		sha512_base_do_finalize(desc,
-				(sha512_block_fn *)sha512_block_data_order);
+					      __sha512_block_data_order);
+		sha512_base_do_finalize(desc, __sha512_block_data_order);
 		return sha512_base_finish(desc, out);
 	}
 
 	kernel_neon_begin();
-	sha512_base_do_update(desc, data, len,
-			      (sha512_block_fn *)sha512_ce_transform);
-	sha512_base_do_finalize(desc, (sha512_block_fn *)sha512_ce_transform);
+	sha512_base_do_update(desc, data, len, sha512_ce_transform);
+	sha512_base_do_finalize(desc, sha512_ce_transform);
 	kernel_neon_end();
 	return sha512_base_finish(desc, out);
 }
@@ -67,13 +70,12 @@ static int sha512_ce_finup(struct shash_desc *desc, const u8 *data,
 static int sha512_ce_final(struct shash_desc *desc, u8 *out)
 {
 	if (!crypto_simd_usable()) {
-		sha512_base_do_finalize(desc,
-				(sha512_block_fn *)sha512_block_data_order);
+		sha512_base_do_finalize(desc, __sha512_block_data_order);
 		return sha512_base_finish(desc, out);
 	}
 
 	kernel_neon_begin();
-	sha512_base_do_finalize(desc, (sha512_block_fn *)sha512_ce_transform);
+	sha512_base_do_finalize(desc, sha512_ce_transform);
 	kernel_neon_end();
 	return sha512_base_finish(desc, out);
 }
diff --git a/arch/arm64/crypto/sha512-glue.c b/arch/arm64/crypto/sha512-glue.c
index d915c656e5fe..78d3083de6b7 100644
--- a/arch/arm64/crypto/sha512-glue.c
+++ b/arch/arm64/crypto/sha512-glue.c
@@ -20,15 +20,21 @@ MODULE_LICENSE("GPL v2");
 MODULE_ALIAS_CRYPTO("sha384");
 MODULE_ALIAS_CRYPTO("sha512");
 
-asmlinkage void sha512_block_data_order(u32 *digest, const void *data,
+asmlinkage void sha512_block_data_order(u64 *digest, const void *data,
 					unsigned int num_blks);
 EXPORT_SYMBOL(sha512_block_data_order);
 
+static void __sha512_block_data_order(struct sha512_state *sst, u8 const *src,
+				      int blocks)
+{
+	sha512_block_data_order(sst->state, src, blocks);
+}
+
 static int sha512_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
 	return sha512_base_do_update(desc, data, len,
-			(sha512_block_fn *)sha512_block_data_order);
+				     __sha512_block_data_order);
 }
 
 static int sha512_finup(struct shash_desc *desc, const u8 *data,
@@ -36,9 +42,8 @@ static int sha512_finup(struct shash_desc *desc, const u8 *data,
 {
 	if (len)
 		sha512_base_do_update(desc, data, len,
-			(sha512_block_fn *)sha512_block_data_order);
-	sha512_base_do_finalize(desc,
-			(sha512_block_fn *)sha512_block_data_order);
+				      __sha512_block_data_order);
+	sha512_base_do_finalize(desc, __sha512_block_data_order);
 
 	return sha512_base_finish(desc, out);
 }

base-commit: 95f1fa9e3418d50ce099e67280b5497b9c93843b
-- 
2.24.0.432.g9d3f5f5b63-goog

