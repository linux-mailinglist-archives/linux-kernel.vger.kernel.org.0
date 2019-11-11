Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7768F8281
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 22:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfKKVqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 16:46:32 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:45558 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbfKKVqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:46:07 -0500
Received: by mail-pl1-f173.google.com with SMTP id y24so8353548plr.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 13:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q2lZ7Dm1L5aRXMm9XxNsm9WxcGVGFqTOrxf2vwq2v/c=;
        b=X6cJO6j+LuNeFzoMBlJXSpwENsy0YOCb5jmcJTGxZvPS1RV2nWRXEkpU9UtVC0gzU3
         +Skr+AL2+vJk7GunbZi7TcgodFA6q2V5iT3hVRsf4ee2IKQkEKCEGk0zUGnZWZV6us3x
         dsdp/HxQ5DvQXnLDmGpXnTwQRiGC4YdyBTjDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q2lZ7Dm1L5aRXMm9XxNsm9WxcGVGFqTOrxf2vwq2v/c=;
        b=hYUsLzxlalX/eoGzkf5CditLzXTPyeRY4YTIAtfN9HEIQPQIhNH3fimJiXDRQYYMxK
         vXajskD+WENZpcJTTGkpnLwOv5VhRfx4X7P8Fjoa7EYzhK+5LuQ1OXsAqd8d3ueud8wk
         LUJYPn3zqlvGBPqC7uC4qzeooJp90P/tTCW8qCinjEIJT3wrEoANs99JogXZfkLFWnUo
         evsZNb7wk5yaMWldrm904I3yBH6ildvDG0cBoJaplzThAIf5jOGZFjyh8Te+dHT2sFen
         YIXDnzHIpiGiZQl/GxsJ05WSZU96Aq7tSNqqbVXJ4Qjr198gRwZQIMxZ2PlRhtRxUEZX
         8w+g==
X-Gm-Message-State: APjAAAVRW0AFTAdRECAe/+0gK8l+SxYEfPIV/s1WKfZRvK8tgpas1abo
        hctHe9n5UGmkdxUzBmXcoSFb7g==
X-Google-Smtp-Source: APXvYqyte6oJuiojDpH+7VVh1GlXynL4x0mJaAVAGIUiJyoki2Cy/SuhjS+ya0YYXVwQoQZshdRvoA==
X-Received: by 2002:a17:902:b948:: with SMTP id h8mr27221875pls.139.1573508766383;
        Mon, 11 Nov 2019 13:46:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w138sm12427189pfc.68.2019.11.11.13.46.02
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
Subject: [PATCH v4 7/8] crypto: x86/glue_helper: Remove function prototype cast helpers
Date:   Mon, 11 Nov 2019 13:45:51 -0800
Message-Id: <20191111214552.36717-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111214552.36717-1-keescook@chromium.org>
References: <20191111214552.36717-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all users of the function prototype casting helpers have been
removed, delete the unused macros.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/crypto/glue_helper.h | 5 -----
 include/crypto/xts.h                      | 2 --
 2 files changed, 7 deletions(-)

diff --git a/arch/x86/include/asm/crypto/glue_helper.h b/arch/x86/include/asm/crypto/glue_helper.h
index 2fa4968ab8e2..a9935bbb3eb9 100644
--- a/arch/x86/include/asm/crypto/glue_helper.h
+++ b/arch/x86/include/asm/crypto/glue_helper.h
@@ -18,11 +18,6 @@ typedef void (*common_glue_ctr_func_t)(void *ctx, u128 *dst, const u128 *src,
 typedef void (*common_glue_xts_func_t)(void *ctx, u128 *dst, const u128 *src,
 				       le128 *iv);
 
-#define GLUE_FUNC_CAST(fn) ((common_glue_func_t)(fn))
-#define GLUE_CBC_FUNC_CAST(fn) ((common_glue_cbc_func_t)(fn))
-#define GLUE_CTR_FUNC_CAST(fn) ((common_glue_ctr_func_t)(fn))
-#define GLUE_XTS_FUNC_CAST(fn) ((common_glue_xts_func_t)(fn))
-
 #define CRYPTO_FUNC(func)						\
 asmlinkage void func(void *ctx, u8 *dst, const u8 *src)
 
diff --git a/include/crypto/xts.h b/include/crypto/xts.h
index 75fd96ff976b..15ae7fdc0478 100644
--- a/include/crypto/xts.h
+++ b/include/crypto/xts.h
@@ -8,8 +8,6 @@
 
 #define XTS_BLOCK_SIZE 16
 
-#define XTS_TWEAK_CAST(x) ((void (*)(void *, u8*, const u8*))(x))
-
 static inline int xts_check_key(struct crypto_tfm *tfm,
 				const u8 *key, unsigned int keylen)
 {
-- 
2.17.1

