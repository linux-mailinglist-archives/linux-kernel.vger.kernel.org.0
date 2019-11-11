Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06677F8273
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 22:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfKKVqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 16:46:16 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33380 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbfKKVqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:46:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay6so8390009plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 13:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I/3dBlJyaxPRtFTis6wLSqQyStGQBcFjrF54ZE6N9ys=;
        b=kmWX6IjqUtRMt+wusjNIA2uL5H2sIAh/5FOt2aG6VjnnT6ztx6kDdaxbUvAX9TMRTy
         1J2LwAPQvXXt5zFk+ySCykBJoPhqC3OdlxvvrnCivG1qdIU0A5cslh1z9MZg5CbNkrFZ
         wgcO2qTsPS7Y+yU23hmLm27pp/92lo/gleDLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I/3dBlJyaxPRtFTis6wLSqQyStGQBcFjrF54ZE6N9ys=;
        b=qc884gWCnztqCig3/zndiN3Yh/x15YVn2G/rPbWs4kLwI3HXF24mkES49/q19bAcOy
         d3w8AYLnwRbECugNy7oDfIUrUojy8p1+BELcqq1hV1PHWQ+XY3yO7UkmljlYD4maxhEn
         XTGkAeCFskjowQaNBQOKDU+Ud1pb46WajlznyhS2DKbLYXbrgwdSu7jWwfU7ko8fEWCT
         FCc9Ev4X2lk2JzdSMu6DzNxVQQMToXABAAXTOtYU/N1Y2jhtvAWMH2+CJjzVlmexgPCK
         z5FkFjlQD3iUWQcEjF9oANaA8czOthQyrEtGgSOyOR2JzbzTzYHzVZizM7BuvsiJhp76
         SQAA==
X-Gm-Message-State: APjAAAX7v08OaV6aOZGsSF7OoYIwsgq1JgMDXzven0pDzuFm01GgRlYj
        mavM1GtrnvAf4CKD2qfj1FxblA==
X-Google-Smtp-Source: APXvYqztW9oWMklUPzVKJI3FAB8FKSIHkHfHiMvOVTc5Wn5vlQagD7druaWt2L6MWIHtHkHpx1wx3g==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6mr28110421plb.240.1573508767350;
        Mon, 11 Nov 2019 13:46:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v15sm13518755pfe.44.2019.11.11.13.46.02
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
Subject: [PATCH v4 6/8] crypto: x86/aesni: Use new glue function macros
Date:   Mon, 11 Nov 2019 13:45:50 -0800
Message-Id: <20191111214552.36717-7-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111214552.36717-1-keescook@chromium.org>
References: <20191111214552.36717-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to function declaration macros from function prototype casts to
avoid triggering Control-Flow Integrity checks during indirect function
calls.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/crypto/aesni-intel_glue.c | 31 ++++++++++--------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 3e707e81afdb..e1072ea0a4fa 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -33,9 +33,7 @@
 #include <crypto/internal/skcipher.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
-#ifdef CONFIG_X86_64
 #include <asm/crypto/glue_helper.h>
-#endif
 
 
 #define AESNI_ALIGN	16
@@ -83,10 +81,8 @@ struct gcm_context_data {
 
 asmlinkage int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
 			     unsigned int key_len);
-asmlinkage void aesni_enc(struct crypto_aes_ctx *ctx, u8 *out,
-			  const u8 *in);
-asmlinkage void aesni_dec(struct crypto_aes_ctx *ctx, u8 *out,
-			  const u8 *in);
+CRYPTO_FUNC(aesni_enc);
+CRYPTO_FUNC(aesni_dec);
 asmlinkage void aesni_ecb_enc(struct crypto_aes_ctx *ctx, u8 *out,
 			      const u8 *in, unsigned int len);
 asmlinkage void aesni_ecb_dec(struct crypto_aes_ctx *ctx, u8 *out,
@@ -550,19 +546,14 @@ static int xts_aesni_setkey(struct crypto_skcipher *tfm, const u8 *key,
 }
 
 
-static void aesni_xts_tweak(void *ctx, u8 *out, const u8 *in)
-{
-	aesni_enc(ctx, out, in);
-}
-
 static void aesni_xts_enc(void *ctx, u128 *dst, const u128 *src, le128 *iv)
 {
-	glue_xts_crypt_128bit_one(ctx, dst, src, iv, GLUE_FUNC_CAST(aesni_enc));
+	glue_xts_crypt_128bit_one(ctx, dst, src, iv, aesni_enc);
 }
 
 static void aesni_xts_dec(void *ctx, u128 *dst, const u128 *src, le128 *iv)
 {
-	glue_xts_crypt_128bit_one(ctx, dst, src, iv, GLUE_FUNC_CAST(aesni_dec));
+	glue_xts_crypt_128bit_one(ctx, dst, src, iv, aesni_dec);
 }
 
 static void aesni_xts_enc8(void *ctx, u128 *dst, const u128 *src, le128 *iv)
@@ -581,10 +572,10 @@ static const struct common_glue_ctx aesni_enc_xts = {
 
 	.funcs = { {
 		.num_blocks = 8,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(aesni_xts_enc8) }
+		.fn_u = { .xts = aesni_xts_enc8 }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(aesni_xts_enc) }
+		.fn_u = { .xts = aesni_xts_enc }
 	} }
 };
 
@@ -594,10 +585,10 @@ static const struct common_glue_ctx aesni_dec_xts = {
 
 	.funcs = { {
 		.num_blocks = 8,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(aesni_xts_dec8) }
+		.fn_u = { .xts = aesni_xts_dec8 }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(aesni_xts_dec) }
+		.fn_u = { .xts = aesni_xts_dec }
 	} }
 };
 
@@ -606,8 +597,7 @@ static int xts_encrypt(struct skcipher_request *req)
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	return glue_xts_req_128bit(&aesni_enc_xts, req,
-				   XTS_TWEAK_CAST(aesni_xts_tweak),
+	return glue_xts_req_128bit(&aesni_enc_xts, req, aesni_enc,
 				   aes_ctx(ctx->raw_tweak_ctx),
 				   aes_ctx(ctx->raw_crypt_ctx),
 				   false);
@@ -618,8 +608,7 @@ static int xts_decrypt(struct skcipher_request *req)
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	return glue_xts_req_128bit(&aesni_dec_xts, req,
-				   XTS_TWEAK_CAST(aesni_xts_tweak),
+	return glue_xts_req_128bit(&aesni_dec_xts, req, aesni_enc,
 				   aes_ctx(ctx->raw_tweak_ctx),
 				   aes_ctx(ctx->raw_crypt_ctx),
 				   true);
-- 
2.17.1

