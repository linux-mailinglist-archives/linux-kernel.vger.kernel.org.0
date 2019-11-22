Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E290105DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 02:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfKVBEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 20:04:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45600 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfKVBDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 20:03:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id z4so2613232pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 17:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cQT6GuU33jOvglJE/bawLAVOZixqHoe9CCHmpk0+4Oo=;
        b=l0oCnAMU7y9E6tq6w1bd6foY2EW9RRN7Y/Hh797RQlw/vMy0YZxr0fzIfc22uXMmTK
         nGkqpb3qWi4gUD/b/TSIqSVzzUZwSxP7T9hRRKiQ30yeaJcjvYZxzy1tNAXx+1WdZeZe
         GBETX/hy2hY8dPSKin+UiIgRRR0ZpzkcZ2lAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cQT6GuU33jOvglJE/bawLAVOZixqHoe9CCHmpk0+4Oo=;
        b=jVy8wcrEDzu2xBj/30iGHkZws4LWoEK4olrtJDk4hP6W9SSxiE9F7y4Y1KhTD5DpXB
         cmoj9qduPbtJ5OVPCHor2JmUtkf5GTVKFFnETnb3o8z3RFmgJd1UABvKhK58cw/oyYud
         a3XErdG0E5JWHkVoaKobWsjCpuwoBN9QENQGfFXCMxDG9Hmt11hfc0vL8dqTMtRjLUGf
         3krKtI4eaR45lQBnkUpTi7Gq2OYaJVHknQQh2IljDdnGtzHV6FBFH5T9ECJM2N8hGc3i
         DJjwusoQivM3uJBV9Hx/PfiQiVCoEg5r7egF6Pr5ZpEV01Zf3gZiq+/Fya5O73/ommA5
         kOOw==
X-Gm-Message-State: APjAAAXxq7o51xMdMLgxl98wDr1FQRP1ftvzxpMh0R3F6kaca4pEChB9
        v8CNEF9/j3yNYNlcl5I3Bx5EvA==
X-Google-Smtp-Source: APXvYqyGZVGMWPAOL71ogujFqQbegoxD4/RSgmm7uH2igLqLymma3lG27WhEC9pn8+9xvri0kwqA1Q==
X-Received: by 2002:a62:2ccf:: with SMTP id s198mr14353661pfs.42.1574384624401;
        Thu, 21 Nov 2019 17:03:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w62sm5060839pfb.15.2019.11.21.17.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 17:03:43 -0800 (PST)
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
Subject: [PATCH v6 6/8] crypto: x86/aesni: Remove glue function macro usage
Date:   Thu, 21 Nov 2019 17:03:32 -0800
Message-Id: <20191122010334.12081-7-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191122010334.12081-1-keescook@chromium.org>
References: <20191122010334.12081-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to remove the callsite function casts, regularize the function
prototypes for helpers to avoid triggering Control-Flow Integrity checks
during indirect function calls. Where needed, to avoid changes to
pointer math, u8 pointers are internally cast back to u128 pointers.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/crypto/aesni-intel_asm.S  |  8 +++---
 arch/x86/crypto/aesni-intel_glue.c | 45 ++++++++++++------------------
 2 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index e40bdf024ba7..89e5e574dc95 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -1946,7 +1946,7 @@ ENTRY(aesni_set_key)
 ENDPROC(aesni_set_key)
 
 /*
- * void aesni_enc(struct crypto_aes_ctx *ctx, u8 *dst, const u8 *src)
+ * void aesni_enc(void *ctx, u8 *dst, const u8 *src)
  */
 ENTRY(aesni_enc)
 	FRAME_BEGIN
@@ -2137,7 +2137,7 @@ _aesni_enc4:
 ENDPROC(_aesni_enc4)
 
 /*
- * void aesni_dec (struct crypto_aes_ctx *ctx, u8 *dst, const u8 *src)
+ * void aesni_dec (void *ctx, u8 *dst, const u8 *src)
  */
 ENTRY(aesni_dec)
 	FRAME_BEGIN
@@ -2726,8 +2726,8 @@ ENDPROC(aesni_ctr_enc)
 	pxor CTR, IV;
 
 /*
- * void aesni_xts_crypt8(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
- *			 bool enc, u8 *iv)
+ * void aesni_xts_crypt8(void *ctx, u8 *dst, const u8 *src, bool enc,
+ *			 le128 *iv)
  */
 ENTRY(aesni_xts_crypt8)
 	FRAME_BEGIN
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 3e707e81afdb..670f8fcf2544 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -83,10 +83,8 @@ struct gcm_context_data {
 
 asmlinkage int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
 			     unsigned int key_len);
-asmlinkage void aesni_enc(struct crypto_aes_ctx *ctx, u8 *out,
-			  const u8 *in);
-asmlinkage void aesni_dec(struct crypto_aes_ctx *ctx, u8 *out,
-			  const u8 *in);
+asmlinkage void aesni_enc(const void *ctx, u8 *out, const u8 *in);
+asmlinkage void aesni_dec(const void *ctx, u8 *out, const u8 *in);
 asmlinkage void aesni_ecb_enc(struct crypto_aes_ctx *ctx, u8 *out,
 			      const u8 *in, unsigned int len);
 asmlinkage void aesni_ecb_dec(struct crypto_aes_ctx *ctx, u8 *out,
@@ -106,8 +104,8 @@ static void (*aesni_ctr_enc_tfm)(struct crypto_aes_ctx *ctx, u8 *out,
 asmlinkage void aesni_ctr_enc(struct crypto_aes_ctx *ctx, u8 *out,
 			      const u8 *in, unsigned int len, u8 *iv);
 
-asmlinkage void aesni_xts_crypt8(struct crypto_aes_ctx *ctx, u8 *out,
-				 const u8 *in, bool enc, u8 *iv);
+asmlinkage void aesni_xts_crypt8(const struct crypto_aes_ctx *ctx, u8 *out,
+				 const u8 *in, bool enc, le128 *iv);
 
 /* asmlinkage void aesni_gcm_enc()
  * void *ctx,  AES Key schedule. Starts on a 16 byte boundary.
@@ -550,29 +548,24 @@ static int xts_aesni_setkey(struct crypto_skcipher *tfm, const u8 *key,
 }
 
 
-static void aesni_xts_tweak(void *ctx, u8 *out, const u8 *in)
+static void aesni_xts_enc(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
 {
-	aesni_enc(ctx, out, in);
+	glue_xts_crypt_128bit_one(ctx, dst, src, iv, aesni_enc);
 }
 
-static void aesni_xts_enc(void *ctx, u128 *dst, const u128 *src, le128 *iv)
+static void aesni_xts_dec(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
 {
-	glue_xts_crypt_128bit_one(ctx, dst, src, iv, GLUE_FUNC_CAST(aesni_enc));
+	glue_xts_crypt_128bit_one(ctx, dst, src, iv, aesni_dec);
 }
 
-static void aesni_xts_dec(void *ctx, u128 *dst, const u128 *src, le128 *iv)
+static void aesni_xts_enc8(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
 {
-	glue_xts_crypt_128bit_one(ctx, dst, src, iv, GLUE_FUNC_CAST(aesni_dec));
+	aesni_xts_crypt8(ctx, dst, src, true, iv);
 }
 
-static void aesni_xts_enc8(void *ctx, u128 *dst, const u128 *src, le128 *iv)
+static void aesni_xts_dec8(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
 {
-	aesni_xts_crypt8(ctx, (u8 *)dst, (const u8 *)src, true, (u8 *)iv);
-}
-
-static void aesni_xts_dec8(void *ctx, u128 *dst, const u128 *src, le128 *iv)
-{
-	aesni_xts_crypt8(ctx, (u8 *)dst, (const u8 *)src, false, (u8 *)iv);
+	aesni_xts_crypt8(ctx, dst, src, false, iv);
 }
 
 static const struct common_glue_ctx aesni_enc_xts = {
@@ -581,10 +574,10 @@ static const struct common_glue_ctx aesni_enc_xts = {
 
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
 
@@ -594,10 +587,10 @@ static const struct common_glue_ctx aesni_dec_xts = {
 
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
 
@@ -606,8 +599,7 @@ static int xts_encrypt(struct skcipher_request *req)
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct aesni_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	return glue_xts_req_128bit(&aesni_enc_xts, req,
-				   XTS_TWEAK_CAST(aesni_xts_tweak),
+	return glue_xts_req_128bit(&aesni_enc_xts, req, aesni_enc,
 				   aes_ctx(ctx->raw_tweak_ctx),
 				   aes_ctx(ctx->raw_crypt_ctx),
 				   false);
@@ -618,8 +610,7 @@ static int xts_decrypt(struct skcipher_request *req)
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

