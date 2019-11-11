Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C53DF826B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 22:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKKVqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 16:46:03 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41167 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfKKVqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:46:03 -0500
Received: by mail-pl1-f194.google.com with SMTP id d29so8359183plj.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 13:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/2ts2yi9jWkjKaKxvacsom8Ft/BzDMBRs9kw3QHoanA=;
        b=ZCU2lQimgkn4yiJdfjXQDw7y3EYBIPHuPhqwx7cz/vDHVadjbEaTrJVFnvDETBaneN
         XCORHPQie4F4u7ij1HD1c6L5g0iKsG2zJ40ilFswHFPHxmubuYD97ah6jGn92j1kKFIn
         yI0HqTMBxNBEFrJ5qADZ9fy3xW9MwOMif5Pc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/2ts2yi9jWkjKaKxvacsom8Ft/BzDMBRs9kw3QHoanA=;
        b=VwQTM/28fJ/z0kzE1K7mlh7BRwiVslJ/2XjvYlpfxadIci6l6pI0kUCBmzGvF2ztP6
         CkXXesnbWjoNIjNvurib8iy6sXdWn4ad+LA3r4MOyKx12vu2lHQMMF6Zhx8rbwyHarwj
         VeE/TZ6qS8WdRxMqntp8fC3WS7M2hj0xR2UUeh2ka/+2HD7DgGTpmrFIZg9NDeQjIwf9
         9ECJS9iuMjwZl85g/kHVBRbtJ5hMExSfW32NTaq5SWW2s8pj97BPTouLk5wfBgodCwWF
         mAkhvKYwZBJXwVyYLTQEkeCMtt8sRtxVizUU4acW1Ep1JBu0bVOLaSlgMtXyOGs0xCJU
         VIDQ==
X-Gm-Message-State: APjAAAUSoCWRJg9flipYwCw/8XJfaRJO3Uvup3PudAfh70qggoezXge9
        YpsPpaKQjpMX6o5hZFQDmGH6nQ==
X-Google-Smtp-Source: APXvYqzHNMoMXSbseRk1G9UWTNMTRd52nN0ECpk1UXL9PEb2HrB3ew5F+6zlSPjxaxkCqFpHmiR+Kw==
X-Received: by 2002:a17:902:7e45:: with SMTP id a5mr27579393pln.315.1573508762036;
        Mon, 11 Nov 2019 13:46:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m13sm12898797pga.70.2019.11.11.13.46.00
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
Subject: [PATCH v4 3/8] crypto: x86/camellia: Use new glue function macros
Date:   Mon, 11 Nov 2019 13:45:47 -0800
Message-Id: <20191111214552.36717-4-keescook@chromium.org>
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

Convert to function declaration macros from function prototype casts
to avoid triggering Control-Flow Integrity checks during indirect function
calls.

Co-developed-by: João Moreira <joao.moreira@lsc.ic.unicamp.br>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/crypto/camellia_aesni_avx2_glue.c | 73 +++++++++-------------
 arch/x86/crypto/camellia_aesni_avx_glue.c  | 63 +++++++------------
 arch/x86/crypto/camellia_glue.c            | 29 +++------
 arch/x86/include/asm/crypto/camellia.h     | 58 ++++-------------
 4 files changed, 74 insertions(+), 149 deletions(-)

diff --git a/arch/x86/crypto/camellia_aesni_avx2_glue.c b/arch/x86/crypto/camellia_aesni_avx2_glue.c
index a4f00128ea55..e32b4ded3b4e 100644
--- a/arch/x86/crypto/camellia_aesni_avx2_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx2_glue.c
@@ -19,20 +19,12 @@
 #define CAMELLIA_AESNI_AVX2_PARALLEL_BLOCKS 32
 
 /* 32-way AVX2/AES-NI parallel cipher functions */
-asmlinkage void camellia_ecb_enc_32way(struct camellia_ctx *ctx, u8 *dst,
-				       const u8 *src);
-asmlinkage void camellia_ecb_dec_32way(struct camellia_ctx *ctx, u8 *dst,
-				       const u8 *src);
-
-asmlinkage void camellia_cbc_dec_32way(struct camellia_ctx *ctx, u8 *dst,
-				       const u8 *src);
-asmlinkage void camellia_ctr_32way(struct camellia_ctx *ctx, u8 *dst,
-				   const u8 *src, le128 *iv);
-
-asmlinkage void camellia_xts_enc_32way(struct camellia_ctx *ctx, u8 *dst,
-				       const u8 *src, le128 *iv);
-asmlinkage void camellia_xts_dec_32way(struct camellia_ctx *ctx, u8 *dst,
-				       const u8 *src, le128 *iv);
+CRYPTO_FUNC(camellia_ecb_enc_32way);
+CRYPTO_FUNC(camellia_ecb_dec_32way);
+CRYPTO_FUNC_CBC(camellia_cbc_dec_32way);
+CRYPTO_FUNC_CTR(camellia_ctr_32way);
+CRYPTO_FUNC_XTS(camellia_xts_enc_32way);
+CRYPTO_FUNC_XTS(camellia_xts_dec_32way);
 
 static const struct common_glue_ctx camellia_enc = {
 	.num_funcs = 4,
@@ -40,16 +32,16 @@ static const struct common_glue_ctx camellia_enc = {
 
 	.funcs = { {
 		.num_blocks = CAMELLIA_AESNI_AVX2_PARALLEL_BLOCKS,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(camellia_ecb_enc_32way) }
+		.fn_u = { .ecb = camellia_ecb_enc_32way }
 	}, {
 		.num_blocks = CAMELLIA_AESNI_PARALLEL_BLOCKS,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(camellia_ecb_enc_16way) }
+		.fn_u = { .ecb = camellia_ecb_enc_16way }
 	}, {
 		.num_blocks = 2,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(camellia_enc_blk_2way) }
+		.fn_u = { .ecb = camellia_enc_blk_2way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(camellia_enc_blk) }
+		.fn_u = { .ecb = camellia_enc_blk }
 	} }
 };
 
@@ -59,16 +51,16 @@ static const struct common_glue_ctx camellia_ctr = {
 
 	.funcs = { {
 		.num_blocks = CAMELLIA_AESNI_AVX2_PARALLEL_BLOCKS,
-		.fn_u = { .ctr = GLUE_CTR_FUNC_CAST(camellia_ctr_32way) }
+		.fn_u = { .ctr = camellia_ctr_32way }
 	}, {
 		.num_blocks = CAMELLIA_AESNI_PARALLEL_BLOCKS,
-		.fn_u = { .ctr = GLUE_CTR_FUNC_CAST(camellia_ctr_16way) }
+		.fn_u = { .ctr = camellia_ctr_16way }
 	}, {
 		.num_blocks = 2,
-		.fn_u = { .ctr = GLUE_CTR_FUNC_CAST(camellia_crypt_ctr_2way) }
+		.fn_u = { .ctr = camellia_crypt_ctr_2way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .ctr = GLUE_CTR_FUNC_CAST(camellia_crypt_ctr) }
+		.fn_u = { .ctr = camellia_crypt_ctr }
 	} }
 };
 
@@ -78,13 +70,13 @@ static const struct common_glue_ctx camellia_enc_xts = {
 
 	.funcs = { {
 		.num_blocks = CAMELLIA_AESNI_AVX2_PARALLEL_BLOCKS,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(camellia_xts_enc_32way) }
+		.fn_u = { .xts = camellia_xts_enc_32way }
 	}, {
 		.num_blocks = CAMELLIA_AESNI_PARALLEL_BLOCKS,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(camellia_xts_enc_16way) }
+		.fn_u = { .xts = camellia_xts_enc_16way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(camellia_xts_enc) }
+		.fn_u = { .xts = camellia_xts_enc }
 	} }
 };
 
@@ -94,16 +86,16 @@ static const struct common_glue_ctx camellia_dec = {
 
 	.funcs = { {
 		.num_blocks = CAMELLIA_AESNI_AVX2_PARALLEL_BLOCKS,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(camellia_ecb_dec_32way) }
+		.fn_u = { .ecb = camellia_ecb_dec_32way }
 	}, {
 		.num_blocks = CAMELLIA_AESNI_PARALLEL_BLOCKS,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(camellia_ecb_dec_16way) }
+		.fn_u = { .ecb = camellia_ecb_dec_16way }
 	}, {
 		.num_blocks = 2,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(camellia_dec_blk_2way) }
+		.fn_u = { .ecb = camellia_dec_blk_2way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(camellia_dec_blk) }
+		.fn_u = { .ecb = camellia_dec_blk }
 	} }
 };
 
@@ -113,16 +105,16 @@ static const struct common_glue_ctx camellia_dec_cbc = {
 
 	.funcs = { {
 		.num_blocks = CAMELLIA_AESNI_AVX2_PARALLEL_BLOCKS,
-		.fn_u = { .cbc = GLUE_CBC_FUNC_CAST(camellia_cbc_dec_32way) }
+		.fn_u = { .cbc = camellia_cbc_dec_32way }
 	}, {
 		.num_blocks = CAMELLIA_AESNI_PARALLEL_BLOCKS,
-		.fn_u = { .cbc = GLUE_CBC_FUNC_CAST(camellia_cbc_dec_16way) }
+		.fn_u = { .cbc = camellia_cbc_dec_16way }
 	}, {
 		.num_blocks = 2,
-		.fn_u = { .cbc = GLUE_CBC_FUNC_CAST(camellia_decrypt_cbc_2way) }
+		.fn_u = { .cbc = camellia_decrypt_cbc_2way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .cbc = GLUE_CBC_FUNC_CAST(camellia_dec_blk) }
+		.fn_u = { .cbc = camellia_dec_blk_cbc }
 	} }
 };
 
@@ -132,13 +124,13 @@ static const struct common_glue_ctx camellia_dec_xts = {
 
 	.funcs = { {
 		.num_blocks = CAMELLIA_AESNI_AVX2_PARALLEL_BLOCKS,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(camellia_xts_dec_32way) }
+		.fn_u = { .xts = camellia_xts_dec_32way }
 	}, {
 		.num_blocks = CAMELLIA_AESNI_PARALLEL_BLOCKS,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(camellia_xts_dec_16way) }
+		.fn_u = { .xts = camellia_xts_dec_16way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(camellia_xts_dec) }
+		.fn_u = { .xts = camellia_xts_dec }
 	} }
 };
 
@@ -161,8 +153,7 @@ static int ecb_decrypt(struct skcipher_request *req)
 
 static int cbc_encrypt(struct skcipher_request *req)
 {
-	return glue_cbc_encrypt_req_128bit(GLUE_FUNC_CAST(camellia_enc_blk),
-					   req);
+	return glue_cbc_encrypt_req_128bit(camellia_enc_blk, req);
 }
 
 static int cbc_decrypt(struct skcipher_request *req)
@@ -180,8 +171,7 @@ static int xts_encrypt(struct skcipher_request *req)
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct camellia_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	return glue_xts_req_128bit(&camellia_enc_xts, req,
-				   XTS_TWEAK_CAST(camellia_enc_blk),
+	return glue_xts_req_128bit(&camellia_enc_xts, req, camellia_enc_blk,
 				   &ctx->tweak_ctx, &ctx->crypt_ctx, false);
 }
 
@@ -190,8 +180,7 @@ static int xts_decrypt(struct skcipher_request *req)
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct camellia_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	return glue_xts_req_128bit(&camellia_dec_xts, req,
-				   XTS_TWEAK_CAST(camellia_enc_blk),
+	return glue_xts_req_128bit(&camellia_dec_xts, req, camellia_enc_blk,
 				   &ctx->tweak_ctx, &ctx->crypt_ctx, true);
 }
 
diff --git a/arch/x86/crypto/camellia_aesni_avx_glue.c b/arch/x86/crypto/camellia_aesni_avx_glue.c
index f28d282779b8..70445c8d8540 100644
--- a/arch/x86/crypto/camellia_aesni_avx_glue.c
+++ b/arch/x86/crypto/camellia_aesni_avx_glue.c
@@ -6,7 +6,6 @@
  */
 
 #include <asm/crypto/camellia.h>
-#include <asm/crypto/glue_helper.h>
 #include <crypto/algapi.h>
 #include <crypto/internal/simd.h>
 #include <crypto/xts.h>
@@ -18,41 +17,22 @@
 #define CAMELLIA_AESNI_PARALLEL_BLOCKS 16
 
 /* 16-way parallel cipher functions (avx/aes-ni) */
-asmlinkage void camellia_ecb_enc_16way(struct camellia_ctx *ctx, u8 *dst,
-				       const u8 *src);
 EXPORT_SYMBOL_GPL(camellia_ecb_enc_16way);
-
-asmlinkage void camellia_ecb_dec_16way(struct camellia_ctx *ctx, u8 *dst,
-				       const u8 *src);
 EXPORT_SYMBOL_GPL(camellia_ecb_dec_16way);
-
-asmlinkage void camellia_cbc_dec_16way(struct camellia_ctx *ctx, u8 *dst,
-				       const u8 *src);
 EXPORT_SYMBOL_GPL(camellia_cbc_dec_16way);
-
-asmlinkage void camellia_ctr_16way(struct camellia_ctx *ctx, u8 *dst,
-				   const u8 *src, le128 *iv);
 EXPORT_SYMBOL_GPL(camellia_ctr_16way);
-
-asmlinkage void camellia_xts_enc_16way(struct camellia_ctx *ctx, u8 *dst,
-				       const u8 *src, le128 *iv);
 EXPORT_SYMBOL_GPL(camellia_xts_enc_16way);
-
-asmlinkage void camellia_xts_dec_16way(struct camellia_ctx *ctx, u8 *dst,
-				       const u8 *src, le128 *iv);
 EXPORT_SYMBOL_GPL(camellia_xts_dec_16way);
 
 void camellia_xts_enc(void *ctx, u128 *dst, const u128 *src, le128 *iv)
 {
-	glue_xts_crypt_128bit_one(ctx, dst, src, iv,
-				  GLUE_FUNC_CAST(camellia_enc_blk));
+	glue_xts_crypt_128bit_one(ctx, dst, src, iv, camellia_enc_blk);
 }
 EXPORT_SYMBOL_GPL(camellia_xts_enc);
 
 void camellia_xts_dec(void *ctx, u128 *dst, const u128 *src, le128 *iv)
 {
-	glue_xts_crypt_128bit_one(ctx, dst, src, iv,
-				  GLUE_FUNC_CAST(camellia_dec_blk));
+	glue_xts_crypt_128bit_one(ctx, dst, src, iv, camellia_dec_blk);
 }
 EXPORT_SYMBOL_GPL(camellia_xts_dec);
 
@@ -62,13 +42,13 @@ static const struct common_glue_ctx camellia_enc = {
 
 	.funcs = { {
 		.num_blocks = CAMELLIA_AESNI_PARALLEL_BLOCKS,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(camellia_ecb_enc_16way) }
+		.fn_u = { .ecb = camellia_ecb_enc_16way }
 	}, {
 		.num_blocks = 2,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(camellia_enc_blk_2way) }
+		.fn_u = { .ecb = camellia_enc_blk_2way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(camellia_enc_blk) }
+		.fn_u = { .ecb = camellia_enc_blk }
 	} }
 };
 
@@ -78,13 +58,13 @@ static const struct common_glue_ctx camellia_ctr = {
 
 	.funcs = { {
 		.num_blocks = CAMELLIA_AESNI_PARALLEL_BLOCKS,
-		.fn_u = { .ctr = GLUE_CTR_FUNC_CAST(camellia_ctr_16way) }
+		.fn_u = { .ctr = camellia_ctr_16way }
 	}, {
 		.num_blocks = 2,
-		.fn_u = { .ctr = GLUE_CTR_FUNC_CAST(camellia_crypt_ctr_2way) }
+		.fn_u = { .ctr = camellia_crypt_ctr_2way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .ctr = GLUE_CTR_FUNC_CAST(camellia_crypt_ctr) }
+		.fn_u = { .ctr = camellia_crypt_ctr }
 	} }
 };
 
@@ -94,10 +74,10 @@ static const struct common_glue_ctx camellia_enc_xts = {
 
 	.funcs = { {
 		.num_blocks = CAMELLIA_AESNI_PARALLEL_BLOCKS,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(camellia_xts_enc_16way) }
+		.fn_u = { .xts = camellia_xts_enc_16way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(camellia_xts_enc) }
+		.fn_u = { .xts = camellia_xts_enc }
 	} }
 };
 
@@ -107,13 +87,13 @@ static const struct common_glue_ctx camellia_dec = {
 
 	.funcs = { {
 		.num_blocks = CAMELLIA_AESNI_PARALLEL_BLOCKS,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(camellia_ecb_dec_16way) }
+		.fn_u = { .ecb = camellia_ecb_dec_16way }
 	}, {
 		.num_blocks = 2,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(camellia_dec_blk_2way) }
+		.fn_u = { .ecb = camellia_dec_blk_2way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(camellia_dec_blk) }
+		.fn_u = { .ecb = camellia_dec_blk }
 	} }
 };
 
@@ -123,13 +103,13 @@ static const struct common_glue_ctx camellia_dec_cbc = {
 
 	.funcs = { {
 		.num_blocks = CAMELLIA_AESNI_PARALLEL_BLOCKS,
-		.fn_u = { .cbc = GLUE_CBC_FUNC_CAST(camellia_cbc_dec_16way) }
+		.fn_u = { .cbc = camellia_cbc_dec_16way }
 	}, {
 		.num_blocks = 2,
-		.fn_u = { .cbc = GLUE_CBC_FUNC_CAST(camellia_decrypt_cbc_2way) }
+		.fn_u = { .cbc = camellia_decrypt_cbc_2way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .cbc = GLUE_CBC_FUNC_CAST(camellia_dec_blk) }
+		.fn_u = { .cbc = camellia_dec_blk_cbc }
 	} }
 };
 
@@ -139,10 +119,10 @@ static const struct common_glue_ctx camellia_dec_xts = {
 
 	.funcs = { {
 		.num_blocks = CAMELLIA_AESNI_PARALLEL_BLOCKS,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(camellia_xts_dec_16way) }
+		.fn_u = { .xts = camellia_xts_dec_16way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(camellia_xts_dec) }
+		.fn_u = { .xts = camellia_xts_dec }
 	} }
 };
 
@@ -165,8 +145,7 @@ static int ecb_decrypt(struct skcipher_request *req)
 
 static int cbc_encrypt(struct skcipher_request *req)
 {
-	return glue_cbc_encrypt_req_128bit(GLUE_FUNC_CAST(camellia_enc_blk),
-					   req);
+	return glue_cbc_encrypt_req_128bit(camellia_enc_blk, req);
 }
 
 static int cbc_decrypt(struct skcipher_request *req)
@@ -207,7 +186,7 @@ static int xts_encrypt(struct skcipher_request *req)
 	struct camellia_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
 
 	return glue_xts_req_128bit(&camellia_enc_xts, req,
-				   XTS_TWEAK_CAST(camellia_enc_blk),
+				   camellia_enc_blk,
 				   &ctx->tweak_ctx, &ctx->crypt_ctx, false);
 }
 
@@ -217,7 +196,7 @@ static int xts_decrypt(struct skcipher_request *req)
 	struct camellia_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
 
 	return glue_xts_req_128bit(&camellia_dec_xts, req,
-				   XTS_TWEAK_CAST(camellia_enc_blk),
+				   camellia_enc_blk,
 				   &ctx->tweak_ctx, &ctx->crypt_ctx, true);
 }
 
diff --git a/arch/x86/crypto/camellia_glue.c b/arch/x86/crypto/camellia_glue.c
index 7c62db56ffe1..98d459e322e6 100644
--- a/arch/x86/crypto/camellia_glue.c
+++ b/arch/x86/crypto/camellia_glue.c
@@ -18,19 +18,11 @@
 #include <asm/crypto/glue_helper.h>
 
 /* regular block cipher functions */
-asmlinkage void __camellia_enc_blk(struct camellia_ctx *ctx, u8 *dst,
-				   const u8 *src, bool xor);
 EXPORT_SYMBOL_GPL(__camellia_enc_blk);
-asmlinkage void camellia_dec_blk(struct camellia_ctx *ctx, u8 *dst,
-				 const u8 *src);
 EXPORT_SYMBOL_GPL(camellia_dec_blk);
 
 /* 2-way parallel cipher functions */
-asmlinkage void __camellia_enc_blk_2way(struct camellia_ctx *ctx, u8 *dst,
-					const u8 *src, bool xor);
 EXPORT_SYMBOL_GPL(__camellia_enc_blk_2way);
-asmlinkage void camellia_dec_blk_2way(struct camellia_ctx *ctx, u8 *dst,
-				      const u8 *src);
 EXPORT_SYMBOL_GPL(camellia_dec_blk_2way);
 
 static void camellia_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
@@ -1305,7 +1297,7 @@ void camellia_crypt_ctr_2way(void *ctx, u128 *dst, const u128 *src, le128 *iv)
 	le128_to_be128(&ctrblks[1], iv);
 	le128_inc(iv);
 
-	camellia_enc_blk_xor_2way(ctx, (u8 *)dst, (u8 *)ctrblks);
+	camellia_enc_blk_2way_xor(ctx, (u8 *)dst, (u8 *)ctrblks);
 }
 EXPORT_SYMBOL_GPL(camellia_crypt_ctr_2way);
 
@@ -1315,10 +1307,10 @@ static const struct common_glue_ctx camellia_enc = {
 
 	.funcs = { {
 		.num_blocks = 2,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(camellia_enc_blk_2way) }
+		.fn_u = { .ecb = camellia_enc_blk_2way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(camellia_enc_blk) }
+		.fn_u = { .ecb = camellia_enc_blk }
 	} }
 };
 
@@ -1328,10 +1320,10 @@ static const struct common_glue_ctx camellia_ctr = {
 
 	.funcs = { {
 		.num_blocks = 2,
-		.fn_u = { .ctr = GLUE_CTR_FUNC_CAST(camellia_crypt_ctr_2way) }
+		.fn_u = { .ctr = camellia_crypt_ctr_2way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .ctr = GLUE_CTR_FUNC_CAST(camellia_crypt_ctr) }
+		.fn_u = { .ctr = camellia_crypt_ctr }
 	} }
 };
 
@@ -1341,10 +1333,10 @@ static const struct common_glue_ctx camellia_dec = {
 
 	.funcs = { {
 		.num_blocks = 2,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(camellia_dec_blk_2way) }
+		.fn_u = { .ecb = camellia_dec_blk_2way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(camellia_dec_blk) }
+		.fn_u = { .ecb = camellia_dec_blk }
 	} }
 };
 
@@ -1354,10 +1346,10 @@ static const struct common_glue_ctx camellia_dec_cbc = {
 
 	.funcs = { {
 		.num_blocks = 2,
-		.fn_u = { .cbc = GLUE_CBC_FUNC_CAST(camellia_decrypt_cbc_2way) }
+		.fn_u = { .cbc = camellia_decrypt_cbc_2way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .cbc = GLUE_CBC_FUNC_CAST(camellia_dec_blk) }
+		.fn_u = { .cbc = camellia_dec_blk_cbc }
 	} }
 };
 
@@ -1373,8 +1365,7 @@ static int ecb_decrypt(struct skcipher_request *req)
 
 static int cbc_encrypt(struct skcipher_request *req)
 {
-	return glue_cbc_encrypt_req_128bit(GLUE_FUNC_CAST(camellia_enc_blk),
-					   req);
+	return glue_cbc_encrypt_req_128bit(camellia_enc_blk, req);
 }
 
 static int cbc_decrypt(struct skcipher_request *req)
diff --git a/arch/x86/include/asm/crypto/camellia.h b/arch/x86/include/asm/crypto/camellia.h
index a5d86fc0593f..8053b01f8418 100644
--- a/arch/x86/include/asm/crypto/camellia.h
+++ b/arch/x86/include/asm/crypto/camellia.h
@@ -2,6 +2,7 @@
 #ifndef ASM_X86_CAMELLIA_H
 #define ASM_X86_CAMELLIA_H
 
+#include <asm/crypto/glue_helper.h>
 #include <crypto/b128ops.h>
 #include <linux/crypto.h>
 #include <linux/kernel.h>
@@ -32,56 +33,21 @@ extern int xts_camellia_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			       unsigned int keylen);
 
 /* regular block cipher functions */
-asmlinkage void __camellia_enc_blk(struct camellia_ctx *ctx, u8 *dst,
-				   const u8 *src, bool xor);
-asmlinkage void camellia_dec_blk(struct camellia_ctx *ctx, u8 *dst,
-				 const u8 *src);
+CRYPTO_FUNC_XOR(camellia_enc_blk);
+CRYPTO_FUNC(camellia_dec_blk);
+CRYPTO_FUNC_WRAP_CBC(camellia_dec_blk);
 
 /* 2-way parallel cipher functions */
-asmlinkage void __camellia_enc_blk_2way(struct camellia_ctx *ctx, u8 *dst,
-					const u8 *src, bool xor);
-asmlinkage void camellia_dec_blk_2way(struct camellia_ctx *ctx, u8 *dst,
-				      const u8 *src);
+CRYPTO_FUNC_XOR(camellia_enc_blk_2way);
+CRYPTO_FUNC(camellia_dec_blk_2way);
 
 /* 16-way parallel cipher functions (avx/aes-ni) */
-asmlinkage void camellia_ecb_enc_16way(struct camellia_ctx *ctx, u8 *dst,
-				       const u8 *src);
-asmlinkage void camellia_ecb_dec_16way(struct camellia_ctx *ctx, u8 *dst,
-				       const u8 *src);
-
-asmlinkage void camellia_cbc_dec_16way(struct camellia_ctx *ctx, u8 *dst,
-				       const u8 *src);
-asmlinkage void camellia_ctr_16way(struct camellia_ctx *ctx, u8 *dst,
-				   const u8 *src, le128 *iv);
-
-asmlinkage void camellia_xts_enc_16way(struct camellia_ctx *ctx, u8 *dst,
-				       const u8 *src, le128 *iv);
-asmlinkage void camellia_xts_dec_16way(struct camellia_ctx *ctx, u8 *dst,
-				       const u8 *src, le128 *iv);
-
-static inline void camellia_enc_blk(struct camellia_ctx *ctx, u8 *dst,
-				    const u8 *src)
-{
-	__camellia_enc_blk(ctx, dst, src, false);
-}
-
-static inline void camellia_enc_blk_xor(struct camellia_ctx *ctx, u8 *dst,
-					const u8 *src)
-{
-	__camellia_enc_blk(ctx, dst, src, true);
-}
-
-static inline void camellia_enc_blk_2way(struct camellia_ctx *ctx, u8 *dst,
-					 const u8 *src)
-{
-	__camellia_enc_blk_2way(ctx, dst, src, false);
-}
-
-static inline void camellia_enc_blk_xor_2way(struct camellia_ctx *ctx, u8 *dst,
-					     const u8 *src)
-{
-	__camellia_enc_blk_2way(ctx, dst, src, true);
-}
+CRYPTO_FUNC(camellia_ecb_enc_16way);
+CRYPTO_FUNC(camellia_ecb_dec_16way);
+CRYPTO_FUNC_CBC(camellia_cbc_dec_16way);
+CRYPTO_FUNC_CTR(camellia_ctr_16way);
+CRYPTO_FUNC_XTS(camellia_xts_enc_16way);
+CRYPTO_FUNC_XTS(camellia_xts_dec_16way);
 
 /* glue helpers */
 extern void camellia_decrypt_cbc_2way(void *ctx, u128 *dst, const u128 *src);
-- 
2.17.1

