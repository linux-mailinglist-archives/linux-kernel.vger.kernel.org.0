Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99FBFF8270
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 22:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfKKVqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 16:46:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39790 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfKKVqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:46:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id x28so11617595pfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 13:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2WYPO+Cs160lWLgrFwHAXtycZesNOJ8Ah35tHvgpbQI=;
        b=nQAAN4TMzTMOwTTpLhRLBu60PTHJUR7cQ/Y17oJwAbsKJ7d2W5XN8Fqx6V0ZnbNnwX
         ruKgSpRuRRxG8RBcC+AkTTxQZdZXiqr4Y/AQAWydLWw0qW0huXDKxIn8pwCRFliGuP9P
         GlrWZwkbma/KLtl4UwKMmnuRSf/WZps4nWD64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2WYPO+Cs160lWLgrFwHAXtycZesNOJ8Ah35tHvgpbQI=;
        b=o3xZEf1DaSeL2ahTKLWiLEXnREDsS9CbbBotC2VugkxIVZMOTQcCdVvxmOj3OGx418
         abatcUhDJ4cUc2LZ5iwsOjhI5awHhb8P7VuozhKSiV3F5LNvRTjy6p3PAzBZhSKJRgfs
         AySRuaMCD6FbTqkh588HUSEELDDEZMEfceYEC8gzh9X1ZYvsi6Py2Iwb4jBWBgjZKQma
         wGgij8DdH0Sz56rU/hLaf6DWiX7Wcayq2jUrnqK4avys3CZl29b565AD7rzk5gSkikLj
         ZhQBhkL0V1ZA8rNxzBjEnvqKt3VjceJMOfTh1u7gFoXGJRz+b9JN6Aum3KbhsNLOBG5b
         XHBA==
X-Gm-Message-State: APjAAAV6JwjAjmi2T16L2RDWV+aAo/6FSIJ2qrosSX7YNEzM3mpshRZe
        YVmu0w7E42Pc3WPV1LFWXU7m3Q==
X-Google-Smtp-Source: APXvYqyyDwMPQYhs6q2UU3YEN3oqn4oWt9YMxPCJD6W8qjLSZJNsg+/JAgiqqjlfzDgYrzdwWlM30w==
X-Received: by 2002:a17:90a:35d0:: with SMTP id r74mr1614656pjb.47.1573508767878;
        Mon, 11 Nov 2019 13:46:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r20sm22895783pgo.74.2019.11.11.13.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 13:46:05 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Jo=C3=A3o=20Moreira?= <joao.moreira@lsc.ic.unicamp.br>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Stephan Mueller <smueller@chronox.de>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v4 8/8] crypto, x86/sha: Eliminate casts on asm implementations
Date:   Mon, 11 Nov 2019 13:45:52 -0800
Message-Id: <20191111214552.36717-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111214552.36717-1-keescook@chromium.org>
References: <20191111214552.36717-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid CFI function prototype mismatches, this removes the
casts on assembly implementations of sha1/256/512 accelerators. The
safety checks from BUILD_BUG_ON() remain.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/crypto/sha1_ssse3_glue.c   | 61 ++++++++++++-----------------
 arch/x86/crypto/sha256_ssse3_glue.c | 31 +++++++--------
 arch/x86/crypto/sha512_ssse3_glue.c | 28 ++++++-------
 3 files changed, 50 insertions(+), 70 deletions(-)

diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
index 639d4c2fd6a8..a151d899f37a 100644
--- a/arch/x86/crypto/sha1_ssse3_glue.c
+++ b/arch/x86/crypto/sha1_ssse3_glue.c
@@ -27,11 +27,8 @@
 #include <crypto/sha1_base.h>
 #include <asm/simd.h>
 
-typedef void (sha1_transform_fn)(u32 *digest, const char *data,
-				unsigned int rounds);
-
 static int sha1_update(struct shash_desc *desc, const u8 *data,
-			     unsigned int len, sha1_transform_fn *sha1_xform)
+			     unsigned int len, sha1_block_fn *sha1_xform)
 {
 	struct sha1_state *sctx = shash_desc_ctx(desc);
 
@@ -39,48 +36,44 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,
 	    (sctx->count % SHA1_BLOCK_SIZE) + len < SHA1_BLOCK_SIZE)
 		return crypto_sha1_update(desc, data, len);
 
-	/* make sure casting to sha1_block_fn() is safe */
+	/* make sure sha1_block_fn() use in generic routines is safe */
 	BUILD_BUG_ON(offsetof(struct sha1_state, state) != 0);
 
 	kernel_fpu_begin();
-	sha1_base_do_update(desc, data, len,
-			    (sha1_block_fn *)sha1_xform);
+	sha1_base_do_update(desc, data, len, sha1_xform);
 	kernel_fpu_end();
 
 	return 0;
 }
 
 static int sha1_finup(struct shash_desc *desc, const u8 *data,
-		      unsigned int len, u8 *out, sha1_transform_fn *sha1_xform)
+		      unsigned int len, u8 *out, sha1_block_fn *sha1_xform)
 {
 	if (!crypto_simd_usable())
 		return crypto_sha1_finup(desc, data, len, out);
 
 	kernel_fpu_begin();
 	if (len)
-		sha1_base_do_update(desc, data, len,
-				    (sha1_block_fn *)sha1_xform);
-	sha1_base_do_finalize(desc, (sha1_block_fn *)sha1_xform);
+		sha1_base_do_update(desc, data, len, sha1_xform);
+	sha1_base_do_finalize(desc, sha1_xform);
 	kernel_fpu_end();
 
 	return sha1_base_finish(desc, out);
 }
 
-asmlinkage void sha1_transform_ssse3(u32 *digest, const char *data,
-				     unsigned int rounds);
+asmlinkage void sha1_transform_ssse3(struct sha1_state *digest,
+				     u8 const *data, int rounds);
 
 static int sha1_ssse3_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len)
 {
-	return sha1_update(desc, data, len,
-			(sha1_transform_fn *) sha1_transform_ssse3);
+	return sha1_update(desc, data, len, sha1_transform_ssse3);
 }
 
 static int sha1_ssse3_finup(struct shash_desc *desc, const u8 *data,
 			      unsigned int len, u8 *out)
 {
-	return sha1_finup(desc, data, len, out,
-			(sha1_transform_fn *) sha1_transform_ssse3);
+	return sha1_finup(desc, data, len, out, sha1_transform_ssse3);
 }
 
 /* Add padding and return the message digest. */
@@ -119,21 +112,19 @@ static void unregister_sha1_ssse3(void)
 }
 
 #ifdef CONFIG_AS_AVX
-asmlinkage void sha1_transform_avx(u32 *digest, const char *data,
-				   unsigned int rounds);
+asmlinkage void sha1_transform_avx(struct sha1_state *digest,
+				   u8 const *data, int rounds);
 
 static int sha1_avx_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len)
 {
-	return sha1_update(desc, data, len,
-			(sha1_transform_fn *) sha1_transform_avx);
+	return sha1_update(desc, data, len, sha1_transform_avx);
 }
 
 static int sha1_avx_finup(struct shash_desc *desc, const u8 *data,
 			      unsigned int len, u8 *out)
 {
-	return sha1_finup(desc, data, len, out,
-			(sha1_transform_fn *) sha1_transform_avx);
+	return sha1_finup(desc, data, len, out, sha1_transform_avx);
 }
 
 static int sha1_avx_final(struct shash_desc *desc, u8 *out)
@@ -190,8 +181,8 @@ static inline void unregister_sha1_avx(void) { }
 #if defined(CONFIG_AS_AVX2) && (CONFIG_AS_AVX)
 #define SHA1_AVX2_BLOCK_OPTSIZE	4	/* optimal 4*64 bytes of SHA1 blocks */
 
-asmlinkage void sha1_transform_avx2(u32 *digest, const char *data,
-				    unsigned int rounds);
+asmlinkage void sha1_transform_avx2(struct sha1_state *digest,
+				    u8 const *data, int rounds);
 
 static bool avx2_usable(void)
 {
@@ -203,8 +194,8 @@ static bool avx2_usable(void)
 	return false;
 }
 
-static void sha1_apply_transform_avx2(u32 *digest, const char *data,
-				unsigned int rounds)
+static void sha1_apply_transform_avx2(struct sha1_state *digest,
+				      u8 const *data, int rounds)
 {
 	/* Select the optimal transform based on data block size */
 	if (rounds >= SHA1_AVX2_BLOCK_OPTSIZE)
@@ -216,15 +207,13 @@ static void sha1_apply_transform_avx2(u32 *digest, const char *data,
 static int sha1_avx2_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len)
 {
-	return sha1_update(desc, data, len,
-		(sha1_transform_fn *) sha1_apply_transform_avx2);
+	return sha1_update(desc, data, len, sha1_apply_transform_avx2);
 }
 
 static int sha1_avx2_finup(struct shash_desc *desc, const u8 *data,
 			      unsigned int len, u8 *out)
 {
-	return sha1_finup(desc, data, len, out,
-		(sha1_transform_fn *) sha1_apply_transform_avx2);
+	return sha1_finup(desc, data, len, out, sha1_apply_transform_avx2);
 }
 
 static int sha1_avx2_final(struct shash_desc *desc, u8 *out)
@@ -267,21 +256,19 @@ static inline void unregister_sha1_avx2(void) { }
 #endif
 
 #ifdef CONFIG_AS_SHA1_NI
-asmlinkage void sha1_ni_transform(u32 *digest, const char *data,
-				   unsigned int rounds);
+asmlinkage void sha1_ni_transform(struct sha1_state *digest, u8 const *data,
+				  int rounds);
 
 static int sha1_ni_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len)
 {
-	return sha1_update(desc, data, len,
-		(sha1_transform_fn *) sha1_ni_transform);
+	return sha1_update(desc, data, len, sha1_ni_transform);
 }
 
 static int sha1_ni_finup(struct shash_desc *desc, const u8 *data,
 			      unsigned int len, u8 *out)
 {
-	return sha1_finup(desc, data, len, out,
-		(sha1_transform_fn *) sha1_ni_transform);
+	return sha1_finup(desc, data, len, out, sha1_ni_transform);
 }
 
 static int sha1_ni_final(struct shash_desc *desc, u8 *out)
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index f9aff31fe59e..960f56100a6c 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -41,12 +41,11 @@
 #include <linux/string.h>
 #include <asm/simd.h>
 
-asmlinkage void sha256_transform_ssse3(u32 *digest, const char *data,
-				       u64 rounds);
-typedef void (sha256_transform_fn)(u32 *digest, const char *data, u64 rounds);
+asmlinkage void sha256_transform_ssse3(struct sha256_state *digest,
+				       u8 const *data, int rounds);
 
 static int _sha256_update(struct shash_desc *desc, const u8 *data,
-			  unsigned int len, sha256_transform_fn *sha256_xform)
+			  unsigned int len, sha256_block_fn *sha256_xform)
 {
 	struct sha256_state *sctx = shash_desc_ctx(desc);
 
@@ -54,28 +53,26 @@ static int _sha256_update(struct shash_desc *desc, const u8 *data,
 	    (sctx->count % SHA256_BLOCK_SIZE) + len < SHA256_BLOCK_SIZE)
 		return crypto_sha256_update(desc, data, len);
 
-	/* make sure casting to sha256_block_fn() is safe */
+	/* make sure sha256_block_fn() use in generic routines is safe */
 	BUILD_BUG_ON(offsetof(struct sha256_state, state) != 0);
 
 	kernel_fpu_begin();
-	sha256_base_do_update(desc, data, len,
-			      (sha256_block_fn *)sha256_xform);
+	sha256_base_do_update(desc, data, len, sha256_xform);
 	kernel_fpu_end();
 
 	return 0;
 }
 
 static int sha256_finup(struct shash_desc *desc, const u8 *data,
-	      unsigned int len, u8 *out, sha256_transform_fn *sha256_xform)
+	      unsigned int len, u8 *out, sha256_block_fn *sha256_xform)
 {
 	if (!crypto_simd_usable())
 		return crypto_sha256_finup(desc, data, len, out);
 
 	kernel_fpu_begin();
 	if (len)
-		sha256_base_do_update(desc, data, len,
-				      (sha256_block_fn *)sha256_xform);
-	sha256_base_do_finalize(desc, (sha256_block_fn *)sha256_xform);
+		sha256_base_do_update(desc, data, len, sha256_xform);
+	sha256_base_do_finalize(desc, sha256_xform);
 	kernel_fpu_end();
 
 	return sha256_base_finish(desc, out);
@@ -145,8 +142,8 @@ static void unregister_sha256_ssse3(void)
 }
 
 #ifdef CONFIG_AS_AVX
-asmlinkage void sha256_transform_avx(u32 *digest, const char *data,
-				     u64 rounds);
+asmlinkage void sha256_transform_avx(struct sha256_state *digest,
+				     u8 const *data, int blocks);
 
 static int sha256_avx_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
@@ -227,8 +224,8 @@ static inline void unregister_sha256_avx(void) { }
 #endif
 
 #if defined(CONFIG_AS_AVX2) && defined(CONFIG_AS_AVX)
-asmlinkage void sha256_transform_rorx(u32 *digest, const char *data,
-				      u64 rounds);
+asmlinkage void sha256_transform_rorx(struct sha256_state *digest,
+				      u8 const *data, int rounds);
 
 static int sha256_avx2_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
@@ -307,8 +304,8 @@ static inline void unregister_sha256_avx2(void) { }
 #endif
 
 #ifdef CONFIG_AS_SHA256_NI
-asmlinkage void sha256_ni_transform(u32 *digest, const char *data,
-				   u64 rounds); /*unsigned int rounds);*/
+asmlinkage void sha256_ni_transform(struct sha256_state *digest,
+				    u8 const *data, int rounds);
 
 static int sha256_ni_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
diff --git a/arch/x86/crypto/sha512_ssse3_glue.c b/arch/x86/crypto/sha512_ssse3_glue.c
index 458356a3f124..09349d93f562 100644
--- a/arch/x86/crypto/sha512_ssse3_glue.c
+++ b/arch/x86/crypto/sha512_ssse3_glue.c
@@ -39,13 +39,11 @@
 #include <crypto/sha512_base.h>
 #include <asm/simd.h>
 
-asmlinkage void sha512_transform_ssse3(u64 *digest, const char *data,
-				       u64 rounds);
-
-typedef void (sha512_transform_fn)(u64 *digest, const char *data, u64 rounds);
+asmlinkage void sha512_transform_ssse3(struct sha512_state *digest,
+				       u8 const *data, int rounds);
 
 static int sha512_update(struct shash_desc *desc, const u8 *data,
-		       unsigned int len, sha512_transform_fn *sha512_xform)
+		       unsigned int len, sha512_block_fn *sha512_xform)
 {
 	struct sha512_state *sctx = shash_desc_ctx(desc);
 
@@ -53,28 +51,26 @@ static int sha512_update(struct shash_desc *desc, const u8 *data,
 	    (sctx->count[0] % SHA512_BLOCK_SIZE) + len < SHA512_BLOCK_SIZE)
 		return crypto_sha512_update(desc, data, len);
 
-	/* make sure casting to sha512_block_fn() is safe */
+	/* make sure sha512_block_fn() use in generic routines is safe */
 	BUILD_BUG_ON(offsetof(struct sha512_state, state) != 0);
 
 	kernel_fpu_begin();
-	sha512_base_do_update(desc, data, len,
-			      (sha512_block_fn *)sha512_xform);
+	sha512_base_do_update(desc, data, len, sha512_xform);
 	kernel_fpu_end();
 
 	return 0;
 }
 
 static int sha512_finup(struct shash_desc *desc, const u8 *data,
-	      unsigned int len, u8 *out, sha512_transform_fn *sha512_xform)
+	      unsigned int len, u8 *out, sha512_block_fn *sha512_xform)
 {
 	if (!crypto_simd_usable())
 		return crypto_sha512_finup(desc, data, len, out);
 
 	kernel_fpu_begin();
 	if (len)
-		sha512_base_do_update(desc, data, len,
-				      (sha512_block_fn *)sha512_xform);
-	sha512_base_do_finalize(desc, (sha512_block_fn *)sha512_xform);
+		sha512_base_do_update(desc, data, len, sha512_xform);
+	sha512_base_do_finalize(desc, sha512_xform);
 	kernel_fpu_end();
 
 	return sha512_base_finish(desc, out);
@@ -144,8 +140,8 @@ static void unregister_sha512_ssse3(void)
 }
 
 #ifdef CONFIG_AS_AVX
-asmlinkage void sha512_transform_avx(u64 *digest, const char *data,
-				     u64 rounds);
+asmlinkage void sha512_transform_avx(struct sha512_state *digest,
+				     u8 const *data, int rounds);
 static bool avx_usable(void)
 {
 	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
@@ -225,8 +221,8 @@ static inline void unregister_sha512_avx(void) { }
 #endif
 
 #if defined(CONFIG_AS_AVX2) && defined(CONFIG_AS_AVX)
-asmlinkage void sha512_transform_rorx(u64 *digest, const char *data,
-				      u64 rounds);
+asmlinkage void sha512_transform_rorx(struct sha512_state *digest,
+				      u8 const *data, int rounds);
 
 static int sha512_avx2_update(struct shash_desc *desc, const u8 *data,
 		       unsigned int len)
-- 
2.17.1

