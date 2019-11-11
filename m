Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 693B7F826A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 22:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKKVqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 16:46:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43030 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfKKVqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:46:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id 3so11602054pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 13:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0GDZ66xG0SN3+0GVKFWNa8tU2gt2Sk1vjyHwyErKZKw=;
        b=G7eFpjypj1tb3wv2r/g+x0YFu/vEJYxWk3nA1Y4/z4ktmr3ZH0dtoOxWu4bOVYtcZf
         VIFkGXIn6pvTYEl5nFXcEOTeI/t4MCMj2+kLbPct5ELc3tHxc6eUGkUuRv4X4FHrR2JF
         QMb+otG+1O8jPD4D6fLIExnbUeH+QEWZMjS0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0GDZ66xG0SN3+0GVKFWNa8tU2gt2Sk1vjyHwyErKZKw=;
        b=ZiCcSz8pXqZIyOCZu6VFN4N5ewCCh6s2V5hQ+eTY17limjuAvowjOKyeYrDPAwvWoG
         AWDFlB+TqXONhXa8Xd0m7OFGurflyQkNvPQjwDCrbXlqmeKmWoh285ArMG5D53BCdJxJ
         OHxYPBBk/HJ5z258VjCPvuNKVRe1zfYGjHuHcOVv3fv2SgGLwZxm+KUMalYChe7tEC78
         sQiQtg7oGZl7d/4a8ys3CjgsrIfNpTqGA17zjyhhYwtVu2UZ/3pExawa6MPwcuXnSBeN
         14X+AoqPltGqDvfKQ6+NteVZVdHxHY/FYk4HLGGtLi6oebfgnDMiiX69MLtzHUQg4fg+
         0Zyg==
X-Gm-Message-State: APjAAAXBLkE58/TfxK09yQzUdl0KFv5FBnWpz4EShoQkvDI2zLCs/Qm2
        FaODvds7Hy647ByAAGSKMlycMw==
X-Google-Smtp-Source: APXvYqybN7sVLdmCufCaFMuuvsOaw0sm5AZb+5wtYmfYGl2vz2F3xKgt6/pSpWC+35WLEj62d+rWhw==
X-Received: by 2002:a63:6782:: with SMTP id b124mr32315938pgc.220.1573508761528;
        Mon, 11 Nov 2019 13:46:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a12sm15611188pfk.188.2019.11.11.13.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 13:46:00 -0800 (PST)
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
Subject: [PATCH v4 4/8] crypto: x86/twofish: Use new glue function macros
Date:   Mon, 11 Nov 2019 13:45:48 -0800
Message-Id: <20191111214552.36717-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111214552.36717-1-keescook@chromium.org>
References: <20191111214552.36717-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to function declaration macros from function prototype casts to
avoid triggering Control-Flow Integrity checks during indirect function
calls.

Co-developed-by: João Moreira <joao.moreira@lsc.ic.unicamp.br>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/crypto/twofish_avx_glue.c    | 74 ++++++++++-----------------
 arch/x86/crypto/twofish_glue.c        |  5 +-
 arch/x86/crypto/twofish_glue_3way.c   | 25 ++++-----
 arch/x86/include/asm/crypto/twofish.h | 17 +++---
 4 files changed, 44 insertions(+), 77 deletions(-)

diff --git a/arch/x86/crypto/twofish_avx_glue.c b/arch/x86/crypto/twofish_avx_glue.c
index d561c821788b..340b2676798d 100644
--- a/arch/x86/crypto/twofish_avx_glue.c
+++ b/arch/x86/crypto/twofish_avx_glue.c
@@ -16,26 +16,17 @@
 #include <crypto/internal/simd.h>
 #include <crypto/twofish.h>
 #include <crypto/xts.h>
-#include <asm/crypto/glue_helper.h>
 #include <asm/crypto/twofish.h>
 
 #define TWOFISH_PARALLEL_BLOCKS 8
 
 /* 8-way parallel cipher functions */
-asmlinkage void twofish_ecb_enc_8way(struct twofish_ctx *ctx, u8 *dst,
-				     const u8 *src);
-asmlinkage void twofish_ecb_dec_8way(struct twofish_ctx *ctx, u8 *dst,
-				     const u8 *src);
-
-asmlinkage void twofish_cbc_dec_8way(struct twofish_ctx *ctx, u8 *dst,
-				     const u8 *src);
-asmlinkage void twofish_ctr_8way(struct twofish_ctx *ctx, u8 *dst,
-				 const u8 *src, le128 *iv);
-
-asmlinkage void twofish_xts_enc_8way(struct twofish_ctx *ctx, u8 *dst,
-				     const u8 *src, le128 *iv);
-asmlinkage void twofish_xts_dec_8way(struct twofish_ctx *ctx, u8 *dst,
-				     const u8 *src, le128 *iv);
+CRYPTO_FUNC(twofish_ecb_enc_8way);
+CRYPTO_FUNC(twofish_ecb_dec_8way);
+CRYPTO_FUNC_CBC(twofish_cbc_dec_8way);
+CRYPTO_FUNC_CTR(twofish_ctr_8way);
+CRYPTO_FUNC_XTS(twofish_xts_enc_8way);
+CRYPTO_FUNC_XTS(twofish_xts_dec_8way);
 
 static int twofish_setkey_skcipher(struct crypto_skcipher *tfm,
 				   const u8 *key, unsigned int keylen)
@@ -43,22 +34,14 @@ static int twofish_setkey_skcipher(struct crypto_skcipher *tfm,
 	return twofish_setkey(&tfm->base, key, keylen);
 }
 
-static inline void twofish_enc_blk_3way(struct twofish_ctx *ctx, u8 *dst,
-					const u8 *src)
-{
-	__twofish_enc_blk_3way(ctx, dst, src, false);
-}
-
 static void twofish_xts_enc(void *ctx, u128 *dst, const u128 *src, le128 *iv)
 {
-	glue_xts_crypt_128bit_one(ctx, dst, src, iv,
-				  GLUE_FUNC_CAST(twofish_enc_blk));
+	glue_xts_crypt_128bit_one(ctx, dst, src, iv, twofish_enc_blk);
 }
 
 static void twofish_xts_dec(void *ctx, u128 *dst, const u128 *src, le128 *iv)
 {
-	glue_xts_crypt_128bit_one(ctx, dst, src, iv,
-				  GLUE_FUNC_CAST(twofish_dec_blk));
+	glue_xts_crypt_128bit_one(ctx, dst, src, iv, twofish_dec_blk);
 }
 
 struct twofish_xts_ctx {
@@ -93,13 +76,13 @@ static const struct common_glue_ctx twofish_enc = {
 
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
 
@@ -109,13 +92,13 @@ static const struct common_glue_ctx twofish_ctr = {
 
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
 
@@ -125,10 +108,10 @@ static const struct common_glue_ctx twofish_enc_xts = {
 
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
 
@@ -138,13 +121,13 @@ static const struct common_glue_ctx twofish_dec = {
 
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
 
@@ -154,13 +137,13 @@ static const struct common_glue_ctx twofish_dec_cbc = {
 
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
+		.fn_u = { .cbc = twofish_dec_blk_cbc }
 	} }
 };
 
@@ -170,10 +153,10 @@ static const struct common_glue_ctx twofish_dec_xts = {
 
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
 
@@ -189,8 +172,7 @@ static int ecb_decrypt(struct skcipher_request *req)
 
 static int cbc_encrypt(struct skcipher_request *req)
 {
-	return glue_cbc_encrypt_req_128bit(GLUE_FUNC_CAST(twofish_enc_blk),
-					   req);
+	return glue_cbc_encrypt_req_128bit(twofish_enc_blk, req);
 }
 
 static int cbc_decrypt(struct skcipher_request *req)
@@ -208,8 +190,7 @@ static int xts_encrypt(struct skcipher_request *req)
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct twofish_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	return glue_xts_req_128bit(&twofish_enc_xts, req,
-				   XTS_TWEAK_CAST(twofish_enc_blk),
+	return glue_xts_req_128bit(&twofish_enc_xts, req, twofish_enc_blk,
 				   &ctx->tweak_ctx, &ctx->crypt_ctx, false);
 }
 
@@ -218,8 +199,7 @@ static int xts_decrypt(struct skcipher_request *req)
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct twofish_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	return glue_xts_req_128bit(&twofish_dec_xts, req,
-				   XTS_TWEAK_CAST(twofish_enc_blk),
+	return glue_xts_req_128bit(&twofish_dec_xts, req, twofish_enc_blk,
 				   &ctx->tweak_ctx, &ctx->crypt_ctx, true);
 }
 
diff --git a/arch/x86/crypto/twofish_glue.c b/arch/x86/crypto/twofish_glue.c
index 77e06c2da83d..4b47ad326bb6 100644
--- a/arch/x86/crypto/twofish_glue.c
+++ b/arch/x86/crypto/twofish_glue.c
@@ -43,12 +43,9 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <asm/crypto/twofish.h>
 
-asmlinkage void twofish_enc_blk(struct twofish_ctx *ctx, u8 *dst,
-				const u8 *src);
 EXPORT_SYMBOL_GPL(twofish_enc_blk);
-asmlinkage void twofish_dec_blk(struct twofish_ctx *ctx, u8 *dst,
-				const u8 *src);
 EXPORT_SYMBOL_GPL(twofish_dec_blk);
 
 static void twofish_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
diff --git a/arch/x86/crypto/twofish_glue_3way.c b/arch/x86/crypto/twofish_glue_3way.c
index 1dc9e29f221e..dd0b563483ff 100644
--- a/arch/x86/crypto/twofish_glue_3way.c
+++ b/arch/x86/crypto/twofish_glue_3way.c
@@ -25,12 +25,6 @@ static int twofish_setkey_skcipher(struct crypto_skcipher *tfm,
 	return twofish_setkey(&tfm->base, key, keylen);
 }
 
-static inline void twofish_enc_blk_3way(struct twofish_ctx *ctx, u8 *dst,
-					const u8 *src)
-{
-	__twofish_enc_blk_3way(ctx, dst, src, false);
-}
-
 static inline void twofish_enc_blk_xor_3way(struct twofish_ctx *ctx, u8 *dst,
 					    const u8 *src)
 {
@@ -94,10 +88,10 @@ static const struct common_glue_ctx twofish_enc = {
 
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
 
@@ -107,10 +101,10 @@ static const struct common_glue_ctx twofish_ctr = {
 
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
 
@@ -120,10 +114,10 @@ static const struct common_glue_ctx twofish_dec = {
 
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
 
@@ -133,10 +127,10 @@ static const struct common_glue_ctx twofish_dec_cbc = {
 
 	.funcs = { {
 		.num_blocks = 3,
-		.fn_u = { .cbc = GLUE_CBC_FUNC_CAST(twofish_dec_blk_cbc_3way) }
+		.fn_u = { .cbc = twofish_dec_blk_cbc_3way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .cbc = GLUE_CBC_FUNC_CAST(twofish_dec_blk) }
+		.fn_u = { .cbc = twofish_dec_blk_cbc }
 	} }
 };
 
@@ -152,8 +146,7 @@ static int ecb_decrypt(struct skcipher_request *req)
 
 static int cbc_encrypt(struct skcipher_request *req)
 {
-	return glue_cbc_encrypt_req_128bit(GLUE_FUNC_CAST(twofish_enc_blk),
-					   req);
+	return glue_cbc_encrypt_req_128bit(twofish_enc_blk, req);
 }
 
 static int cbc_decrypt(struct skcipher_request *req)
diff --git a/arch/x86/include/asm/crypto/twofish.h b/arch/x86/include/asm/crypto/twofish.h
index f618bf272b90..ad54b456577c 100644
--- a/arch/x86/include/asm/crypto/twofish.h
+++ b/arch/x86/include/asm/crypto/twofish.h
@@ -5,23 +5,20 @@
 #include <linux/crypto.h>
 #include <crypto/twofish.h>
 #include <crypto/b128ops.h>
+#include <asm/crypto/glue_helper.h>
 
 /* regular block cipher functions from twofish_x86_64 module */
-asmlinkage void twofish_enc_blk(struct twofish_ctx *ctx, u8 *dst,
-				const u8 *src);
-asmlinkage void twofish_dec_blk(struct twofish_ctx *ctx, u8 *dst,
-				const u8 *src);
+CRYPTO_FUNC(twofish_enc_blk);
+CRYPTO_FUNC(twofish_dec_blk);
+CRYPTO_FUNC_WRAP_CBC(twofish_dec_blk);
 
 /* 3-way parallel cipher functions */
-asmlinkage void __twofish_enc_blk_3way(struct twofish_ctx *ctx, u8 *dst,
-				       const u8 *src, bool xor);
-asmlinkage void twofish_dec_blk_3way(struct twofish_ctx *ctx, u8 *dst,
-				     const u8 *src);
+CRYPTO_FUNC_XOR(twofish_enc_blk_3way);
+CRYPTO_FUNC(twofish_dec_blk_3way);
 
 /* helpers from twofish_x86_64-3way module */
 extern void twofish_dec_blk_cbc_3way(void *ctx, u128 *dst, const u128 *src);
-extern void twofish_enc_blk_ctr(void *ctx, u128 *dst, const u128 *src,
-				le128 *iv);
+CRYPTO_FUNC_CTR(twofish_enc_blk_ctr);
 extern void twofish_enc_blk_ctr_3way(void *ctx, u128 *dst, const u128 *src,
 				     le128 *iv);
 
-- 
2.17.1

