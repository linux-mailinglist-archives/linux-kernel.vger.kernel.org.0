Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62AA9105DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 02:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKVBDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 20:03:43 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38646 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfKVBDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 20:03:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id t3so2069506pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 17:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dzjZSlcJBlvJrGE4GEbxG/ekbnWvjTgmuGgB+BNJY3U=;
        b=XbwFfOd0jS79U7jC5O0uPHiQAUdkNWoyLXtX0W4dll+2ewG6cpu7Y5u8CCAdWUIys1
         XaIcM9ypba/MmSinmdgly19VT+eF+GykGmWn0WQuH9N+ZFwmwzeHfuIfcvNxayNBbgms
         tWSBwjmFqvCcnrQsuHLZrYVV6gOx7elyaz3f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzjZSlcJBlvJrGE4GEbxG/ekbnWvjTgmuGgB+BNJY3U=;
        b=GEWHHpIX+8DhX2raY07wukEVSC6PtLYrLSnagHf3TjQYQsLj9lkSmP4xVgiLCmDURX
         KzpmfPMdny6IZLANKjrEFO3h/RNbloFtv8t+FPGqFoYrIIl2YPkBTJUR+OU9I4vnPYZL
         HTag71xUavPd5h8eYG3qj4Mg2XcfXaEsns2owuqLTbR1v/4ZIp8GQOrH5mDAGWNibpkC
         Ih9HAPKlJkBBgRWS/6PfkssuMDY2Ln5Q773jcIzedZYIlhKQY00E//Ply7p0Nmm+s9mE
         wIqb5LXIVjKDtu2cVyYdy2Wqw/dOC/mmZ42HmwjPZWUQNmG89jJrgqvUtoX0gzImX5HS
         s3Yg==
X-Gm-Message-State: APjAAAWnxQBzrpLHr6ObxjdzsakAr++zqTPRpmRK/e1RE1Ms9dUEBRV1
        EX5d2FxO8s87zEGofet5b+boWQ==
X-Google-Smtp-Source: APXvYqzBhghsjiK2SMGClR1Qk5tD357ErmaL+pnPcCynr7zdl7Wtj3ujz56n8CdaqHIpohz51eC3YQ==
X-Received: by 2002:a62:1ac6:: with SMTP id a189mr14277130pfa.96.1574384619916;
        Thu, 21 Nov 2019 17:03:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o15sm4597915pgf.2.2019.11.21.17.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 17:03:38 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Jo=C3=A3o=20Moreira?= <joao.moreira@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stephan Mueller <smueller@chronox.de>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v6 4/8] crypto: x86/twofish: Remove glue function macro usage
Date:   Thu, 21 Nov 2019 17:03:30 -0800
Message-Id: <20191122010334.12081-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191122010334.12081-1-keescook@chromium.org>
References: <20191122010334.12081-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to remove the callsite function casts, regularize the function
prototypes for helpers to avoid triggering Control-Flow Integrity checks
during indirect function calls. Where needed, to avoid changes to
pointer math, u8 pointers are internally cast back to u128 pointers.

Co-developed-by: João Moreira <joao.moreira@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/crypto/twofish_avx_glue.c    | 75 ++++++++++++---------------
 arch/x86/crypto/twofish_glue_3way.c   | 37 +++++++------
 arch/x86/include/asm/crypto/twofish.h | 19 +++----
 3 files changed, 61 insertions(+), 70 deletions(-)

diff --git a/arch/x86/crypto/twofish_avx_glue.c b/arch/x86/crypto/twofish_avx_glue.c
index d561c821788b..3b36e97ec7ab 100644
--- a/arch/x86/crypto/twofish_avx_glue.c
+++ b/arch/x86/crypto/twofish_avx_glue.c
@@ -22,20 +22,17 @@
 #define TWOFISH_PARALLEL_BLOCKS 8
 
 /* 8-way parallel cipher functions */
-asmlinkage void twofish_ecb_enc_8way(struct twofish_ctx *ctx, u8 *dst,
-				     const u8 *src);
-asmlinkage void twofish_ecb_dec_8way(struct twofish_ctx *ctx, u8 *dst,
-				     const u8 *src);
+asmlinkage void twofish_ecb_enc_8way(const void *ctx, u8 *dst, const u8 *src);
+asmlinkage void twofish_ecb_dec_8way(const void *ctx, u8 *dst, const u8 *src);
 
-asmlinkage void twofish_cbc_dec_8way(struct twofish_ctx *ctx, u8 *dst,
-				     const u8 *src);
-asmlinkage void twofish_ctr_8way(struct twofish_ctx *ctx, u8 *dst,
-				 const u8 *src, le128 *iv);
+asmlinkage void twofish_cbc_dec_8way(const void *ctx, u8 *dst, const u8 *src);
+asmlinkage void twofish_ctr_8way(const void *ctx, u8 *dst, const u8 *src,
+				 le128 *iv);
 
-asmlinkage void twofish_xts_enc_8way(struct twofish_ctx *ctx, u8 *dst,
-				     const u8 *src, le128 *iv);
-asmlinkage void twofish_xts_dec_8way(struct twofish_ctx *ctx, u8 *dst,
-				     const u8 *src, le128 *iv);
+asmlinkage void twofish_xts_enc_8way(const void *ctx, u8 *dst, const u8 *src,
+				     le128 *iv);
+asmlinkage void twofish_xts_dec_8way(const void *ctx, u8 *dst, const u8 *src,
+				     le128 *iv);
 
 static int twofish_setkey_skcipher(struct crypto_skcipher *tfm,
 				   const u8 *key, unsigned int keylen)
@@ -43,22 +40,19 @@ static int twofish_setkey_skcipher(struct crypto_skcipher *tfm,
 	return twofish_setkey(&tfm->base, key, keylen);
 }
 
-static inline void twofish_enc_blk_3way(struct twofish_ctx *ctx, u8 *dst,
-					const u8 *src)
+static inline void twofish_enc_blk_3way(const void *ctx, u8 *dst, const u8 *src)
 {
 	__twofish_enc_blk_3way(ctx, dst, src, false);
 }
 
-static void twofish_xts_enc(void *ctx, u128 *dst, const u128 *src, le128 *iv)
+static void twofish_xts_enc(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
 {
-	glue_xts_crypt_128bit_one(ctx, dst, src, iv,
-				  GLUE_FUNC_CAST(twofish_enc_blk));
+	glue_xts_crypt_128bit_one(ctx, dst, src, iv, twofish_enc_blk);
 }
 
-static void twofish_xts_dec(void *ctx, u128 *dst, const u128 *src, le128 *iv)
+static void twofish_xts_dec(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
 {
-	glue_xts_crypt_128bit_one(ctx, dst, src, iv,
-				  GLUE_FUNC_CAST(twofish_dec_blk));
+	glue_xts_crypt_128bit_one(ctx, dst, src, iv, twofish_dec_blk);
 }
 
 struct twofish_xts_ctx {
@@ -93,13 +87,13 @@ static const struct common_glue_ctx twofish_enc = {
 
 	.funcs = { {
 		.num_blocks = TWOFISH_PARALLEL_BLOCKS,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(twofish_ecb_enc_8way) }
+		.fn_u = { .ecb = twofish_ecb_enc_8way }
 	}, {
 		.num_blocks = 3,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(twofish_enc_blk_3way) }
+		.fn_u = { .ecb = twofish_enc_blk_3way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(twofish_enc_blk) }
+		.fn_u = { .ecb = twofish_enc_blk }
 	} }
 };
 
@@ -109,13 +103,13 @@ static const struct common_glue_ctx twofish_ctr = {
 
 	.funcs = { {
 		.num_blocks = TWOFISH_PARALLEL_BLOCKS,
-		.fn_u = { .ctr = GLUE_CTR_FUNC_CAST(twofish_ctr_8way) }
+		.fn_u = { .ctr = twofish_ctr_8way }
 	}, {
 		.num_blocks = 3,
-		.fn_u = { .ctr = GLUE_CTR_FUNC_CAST(twofish_enc_blk_ctr_3way) }
+		.fn_u = { .ctr = twofish_enc_blk_ctr_3way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .ctr = GLUE_CTR_FUNC_CAST(twofish_enc_blk_ctr) }
+		.fn_u = { .ctr = twofish_enc_blk_ctr }
 	} }
 };
 
@@ -125,10 +119,10 @@ static const struct common_glue_ctx twofish_enc_xts = {
 
 	.funcs = { {
 		.num_blocks = TWOFISH_PARALLEL_BLOCKS,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(twofish_xts_enc_8way) }
+		.fn_u = { .xts = twofish_xts_enc_8way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(twofish_xts_enc) }
+		.fn_u = { .xts = twofish_xts_enc }
 	} }
 };
 
@@ -138,13 +132,13 @@ static const struct common_glue_ctx twofish_dec = {
 
 	.funcs = { {
 		.num_blocks = TWOFISH_PARALLEL_BLOCKS,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(twofish_ecb_dec_8way) }
+		.fn_u = { .ecb = twofish_ecb_dec_8way }
 	}, {
 		.num_blocks = 3,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(twofish_dec_blk_3way) }
+		.fn_u = { .ecb = twofish_dec_blk_3way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(twofish_dec_blk) }
+		.fn_u = { .ecb = twofish_dec_blk }
 	} }
 };
 
@@ -154,13 +148,13 @@ static const struct common_glue_ctx twofish_dec_cbc = {
 
 	.funcs = { {
 		.num_blocks = TWOFISH_PARALLEL_BLOCKS,
-		.fn_u = { .cbc = GLUE_CBC_FUNC_CAST(twofish_cbc_dec_8way) }
+		.fn_u = { .cbc = twofish_cbc_dec_8way }
 	}, {
 		.num_blocks = 3,
-		.fn_u = { .cbc = GLUE_CBC_FUNC_CAST(twofish_dec_blk_cbc_3way) }
+		.fn_u = { .cbc = twofish_dec_blk_cbc_3way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .cbc = GLUE_CBC_FUNC_CAST(twofish_dec_blk) }
+		.fn_u = { .cbc = twofish_dec_blk }
 	} }
 };
 
@@ -170,10 +164,10 @@ static const struct common_glue_ctx twofish_dec_xts = {
 
 	.funcs = { {
 		.num_blocks = TWOFISH_PARALLEL_BLOCKS,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(twofish_xts_dec_8way) }
+		.fn_u = { .xts = twofish_xts_dec_8way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(twofish_xts_dec) }
+		.fn_u = { .xts = twofish_xts_dec }
 	} }
 };
 
@@ -189,8 +183,7 @@ static int ecb_decrypt(struct skcipher_request *req)
 
 static int cbc_encrypt(struct skcipher_request *req)
 {
-	return glue_cbc_encrypt_req_128bit(GLUE_FUNC_CAST(twofish_enc_blk),
-					   req);
+	return glue_cbc_encrypt_req_128bit(twofish_enc_blk, req);
 }
 
 static int cbc_decrypt(struct skcipher_request *req)
@@ -208,8 +201,7 @@ static int xts_encrypt(struct skcipher_request *req)
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct twofish_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	return glue_xts_req_128bit(&twofish_enc_xts, req,
-				   XTS_TWEAK_CAST(twofish_enc_blk),
+	return glue_xts_req_128bit(&twofish_enc_xts, req, twofish_enc_blk,
 				   &ctx->tweak_ctx, &ctx->crypt_ctx, false);
 }
 
@@ -218,8 +210,7 @@ static int xts_decrypt(struct skcipher_request *req)
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct twofish_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	return glue_xts_req_128bit(&twofish_dec_xts, req,
-				   XTS_TWEAK_CAST(twofish_enc_blk),
+	return glue_xts_req_128bit(&twofish_dec_xts, req, twofish_enc_blk,
 				   &ctx->tweak_ctx, &ctx->crypt_ctx, true);
 }
 
diff --git a/arch/x86/crypto/twofish_glue_3way.c b/arch/x86/crypto/twofish_glue_3way.c
index 1dc9e29f221e..768af6075479 100644
--- a/arch/x86/crypto/twofish_glue_3way.c
+++ b/arch/x86/crypto/twofish_glue_3way.c
@@ -25,21 +25,22 @@ static int twofish_setkey_skcipher(struct crypto_skcipher *tfm,
 	return twofish_setkey(&tfm->base, key, keylen);
 }
 
-static inline void twofish_enc_blk_3way(struct twofish_ctx *ctx, u8 *dst,
-					const u8 *src)
+static inline void twofish_enc_blk_3way(const void *ctx, u8 *dst, const u8 *src)
 {
 	__twofish_enc_blk_3way(ctx, dst, src, false);
 }
 
-static inline void twofish_enc_blk_xor_3way(struct twofish_ctx *ctx, u8 *dst,
+static inline void twofish_enc_blk_xor_3way(const void *ctx, u8 *dst,
 					    const u8 *src)
 {
 	__twofish_enc_blk_3way(ctx, dst, src, true);
 }
 
-void twofish_dec_blk_cbc_3way(void *ctx, u128 *dst, const u128 *src)
+void twofish_dec_blk_cbc_3way(const void *ctx, u8 *d, const u8 *s)
 {
 	u128 ivs[2];
+	u128 *dst = (u128 *)d;
+	const u128 *src = (const u128 *)s;
 
 	ivs[0] = src[0];
 	ivs[1] = src[1];
@@ -51,9 +52,11 @@ void twofish_dec_blk_cbc_3way(void *ctx, u128 *dst, const u128 *src)
 }
 EXPORT_SYMBOL_GPL(twofish_dec_blk_cbc_3way);
 
-void twofish_enc_blk_ctr(void *ctx, u128 *dst, const u128 *src, le128 *iv)
+void twofish_enc_blk_ctr(const void *ctx, u8 *d, const u8 *s, le128 *iv)
 {
 	be128 ctrblk;
+	u128 *dst = (u128 *)d;
+	const u128 *src = (const u128 *)s;
 
 	if (dst != src)
 		*dst = *src;
@@ -66,10 +69,11 @@ void twofish_enc_blk_ctr(void *ctx, u128 *dst, const u128 *src, le128 *iv)
 }
 EXPORT_SYMBOL_GPL(twofish_enc_blk_ctr);
 
-void twofish_enc_blk_ctr_3way(void *ctx, u128 *dst, const u128 *src,
-			      le128 *iv)
+void twofish_enc_blk_ctr_3way(const void *ctx, u8 *d, const u8 *s, le128 *iv)
 {
 	be128 ctrblks[3];
+	u128 *dst = (u128 *)d;
+	const u128 *src = (const u128 *)s;
 
 	if (dst != src) {
 		dst[0] = src[0];
@@ -94,10 +98,10 @@ static const struct common_glue_ctx twofish_enc = {
 
 	.funcs = { {
 		.num_blocks = 3,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(twofish_enc_blk_3way) }
+		.fn_u = { .ecb = twofish_enc_blk_3way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(twofish_enc_blk) }
+		.fn_u = { .ecb = twofish_enc_blk }
 	} }
 };
 
@@ -107,10 +111,10 @@ static const struct common_glue_ctx twofish_ctr = {
 
 	.funcs = { {
 		.num_blocks = 3,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(twofish_enc_blk_ctr_3way) }
+		.fn_u = { .ctr = twofish_enc_blk_ctr_3way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(twofish_enc_blk_ctr) }
+		.fn_u = { .ctr = twofish_enc_blk_ctr }
 	} }
 };
 
@@ -120,10 +124,10 @@ static const struct common_glue_ctx twofish_dec = {
 
 	.funcs = { {
 		.num_blocks = 3,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(twofish_dec_blk_3way) }
+		.fn_u = { .ecb = twofish_dec_blk_3way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(twofish_dec_blk) }
+		.fn_u = { .ecb = twofish_dec_blk }
 	} }
 };
 
@@ -133,10 +137,10 @@ static const struct common_glue_ctx twofish_dec_cbc = {
 
 	.funcs = { {
 		.num_blocks = 3,
-		.fn_u = { .cbc = GLUE_CBC_FUNC_CAST(twofish_dec_blk_cbc_3way) }
+		.fn_u = { .cbc = twofish_dec_blk_cbc_3way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .cbc = GLUE_CBC_FUNC_CAST(twofish_dec_blk) }
+		.fn_u = { .cbc = twofish_dec_blk }
 	} }
 };
 
@@ -152,8 +156,7 @@ static int ecb_decrypt(struct skcipher_request *req)
 
 static int cbc_encrypt(struct skcipher_request *req)
 {
-	return glue_cbc_encrypt_req_128bit(GLUE_FUNC_CAST(twofish_enc_blk),
-					   req);
+	return glue_cbc_encrypt_req_128bit(twofish_enc_blk, req);
 }
 
 static int cbc_decrypt(struct skcipher_request *req)
diff --git a/arch/x86/include/asm/crypto/twofish.h b/arch/x86/include/asm/crypto/twofish.h
index f618bf272b90..2c377a8042e1 100644
--- a/arch/x86/include/asm/crypto/twofish.h
+++ b/arch/x86/include/asm/crypto/twofish.h
@@ -7,22 +7,19 @@
 #include <crypto/b128ops.h>
 
 /* regular block cipher functions from twofish_x86_64 module */
-asmlinkage void twofish_enc_blk(struct twofish_ctx *ctx, u8 *dst,
-				const u8 *src);
-asmlinkage void twofish_dec_blk(struct twofish_ctx *ctx, u8 *dst,
-				const u8 *src);
+asmlinkage void twofish_enc_blk(const void *ctx, u8 *dst, const u8 *src);
+asmlinkage void twofish_dec_blk(const void *ctx, u8 *dst, const u8 *src);
 
 /* 3-way parallel cipher functions */
-asmlinkage void __twofish_enc_blk_3way(struct twofish_ctx *ctx, u8 *dst,
-				       const u8 *src, bool xor);
-asmlinkage void twofish_dec_blk_3way(struct twofish_ctx *ctx, u8 *dst,
-				     const u8 *src);
+asmlinkage void __twofish_enc_blk_3way(const void *ctx, u8 *dst, const u8 *src,
+				       bool xor);
+asmlinkage void twofish_dec_blk_3way(const void *ctx, u8 *dst, const u8 *src);
 
 /* helpers from twofish_x86_64-3way module */
-extern void twofish_dec_blk_cbc_3way(void *ctx, u128 *dst, const u128 *src);
-extern void twofish_enc_blk_ctr(void *ctx, u128 *dst, const u128 *src,
+extern void twofish_dec_blk_cbc_3way(const void *ctx, u8 *dst, const u8 *src);
+extern void twofish_enc_blk_ctr(const void *ctx, u8 *dst, const u8 *src,
 				le128 *iv);
-extern void twofish_enc_blk_ctr_3way(void *ctx, u128 *dst, const u128 *src,
+extern void twofish_enc_blk_ctr_3way(const void *ctx, u8 *dst, const u8 *src,
 				     le128 *iv);
 
 #endif /* ASM_X86_TWOFISH_H */
-- 
2.17.1

