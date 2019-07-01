Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C46A1678A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 18:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfEGQNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 12:13:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36423 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfEGQNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:13:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so932420plr.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EzKHhVoz8ac5WrBJUOYPI48ana8bRIkhRTi7PVVgpfQ=;
        b=KS3gLbgNHZtVY2jdTyUeEPPPP1WbGcW/eiR/QF4P3Uaucmox7wXfYTJUnFpbgpTsfQ
         hw9ztmgKmDgsTnGvw1rlV57ARKRv7m6f1D2DJOnMw49h/5KUiE+yV7/LRiCjRjVAQBPd
         e4EocfVeor+V1AfwH5yXaMbsyIY1EoffJ5ek0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EzKHhVoz8ac5WrBJUOYPI48ana8bRIkhRTi7PVVgpfQ=;
        b=MxAQ77ASBGL1yBZToZEm9fCqnVG5JxfI7pOzdwTIWSbSwa2p9sZxgQMcnQigvhOeNY
         a6+40QWL+S0mwjs+2AjZm9xL2zHJ74LNiXOCtkgd92QtnCTdMJFVgOqdISVViuQtj+sm
         M2YSB7qaYVxojn6jeo0ZFEWzVjTSei3s/IEY/ZiOhwjOITKpkCIKTDs8lg1MpqL5aqeQ
         Z27xRWOfYVSlMmoXPqBAEVi1sqwOCsSO8k9arZ3MQRRDDT+L7E2amoFy7BN62JaZGwDZ
         EKOjN/rqKGfGbtyAAgg2JoeZZhbawKAvkpOpshMYMFAe3buZ31oIKX9b2DszUQi51vnY
         1Z/A==
X-Gm-Message-State: APjAAAVTKCyrh7ybh4t6xaaP5wCFjyNrn3cqRJ/M0/slnLd5hwvgngnm
        kGbN1+6weMoVfqmB7L/AH6fTeA==
X-Google-Smtp-Source: APXvYqyGSe2J5kp+fbpzmqO4DRburwBMLORv3hWRJlVcfNP+lmtRv5nKbU9VeJO1al5k21nBvJDiPA==
X-Received: by 2002:a17:902:d892:: with SMTP id b18mr25932914plz.209.1557245613269;
        Tue, 07 May 2019 09:13:33 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id m16sm22906342pfi.29.2019.05.07.09.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 09:13:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>, Joao Moreira <jmoreira@suse.de>,
        Eric Biggers <ebiggers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v3 1/7] crypto: x86/glue_helper: Add static inline function glue macros
Date:   Tue,  7 May 2019 09:13:15 -0700
Message-Id: <20190507161321.34611-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190507161321.34611-1-keescook@chromium.org>
References: <20190507161321.34611-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to indirectly invoke functions with prototypes that do
not match those of the respectively used function pointers by using void
types or casts. This feature is frequently used as a way of relaxing
function invocation, making it possible that different data structures
are passed to different functions through the same pointer.

Despite the benefits, this can lead to a situation where functions with a
given prototype are invoked by pointers with a different prototype. This
is undesirable as it may prevent the use of heuristics such as prototype
matching-based Control-Flow Integrity, which can be used to prevent
ROP-based attacks.

One way of fixing this situation is through the use of inline helper
functions with prototypes that match the one in the respective invoking
pointer.

Given the above, the current efforts to improve the Linux security,
and the upcoming kernel support to compilers with CFI features, this
creates macros to be used to build the needed function definitions,
to be used in later patches to camellia, cast6, serpent, twofish, and
aesni.

Co-developed-by: Joao Moreira <jmoreira@suse.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/crypto/glue_helper.h | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/include/asm/crypto/glue_helper.h b/arch/x86/include/asm/crypto/glue_helper.h
index d1818634ae7e..3b039d563809 100644
--- a/arch/x86/include/asm/crypto/glue_helper.h
+++ b/arch/x86/include/asm/crypto/glue_helper.h
@@ -23,6 +23,38 @@ typedef void (*common_glue_xts_func_t)(void *ctx, u128 *dst, const u128 *src,
 #define GLUE_CTR_FUNC_CAST(fn) ((common_glue_ctr_func_t)(fn))
 #define GLUE_XTS_FUNC_CAST(fn) ((common_glue_xts_func_t)(fn))
 
+
+#define GLUE_CAST(func, context)					\
+asmlinkage void func(struct context *ctx, u8 *dst, const u8 *src);	\
+asmlinkage static inline						\
+void func ## _glue(void *ctx, u8 *dst, const u8 *src)			\
+{ func((struct context *) ctx, dst, src); }
+
+#define GLUE_CAST_XOR(func, context)					\
+asmlinkage void __ ## func(struct context *ctx, u8 *dst, const u8 *src,	\
+			   bool y);					\
+asmlinkage static inline						\
+void func(void *ctx, u8 *dst, const u8 *src)				\
+{ __ ## func((struct context *) ctx, dst, src, false); }		\
+asmlinkage static inline						\
+void func ## _xor(void *ctx, u8 *dst, const u8 *src)			\
+{ __ ## func((struct context *) ctx, dst, src, true); }
+
+#define GLUE_CAST_CBC(func, context)					\
+asmlinkage void func(struct context *ctx, u8 *dst, const u8 *src);	\
+asmlinkage static inline						\
+void func ## _cbc_glue(void *ctx, u128 *dst, const u128 *src)		\
+{ func((struct context *) ctx, (u8 *) dst, (u8 *) src); }
+
+#define GLUE_CAST_CTR(func, context)					\
+asmlinkage void func(struct context *ctx, u128 *dst,			\
+		     const u128 *src, le128 *iv);			\
+asmlinkage static inline						\
+void func ## _glue(void *ctx, u128 *dst, const u128 *src, le128 *iv)	\
+{ func((struct context *) ctx, dst, src, iv); }
+
+#define GLUE_CAST_XTS(func, context) GLUE_CAST_CTR(func, context)
+
 struct common_glue_func_entry {
 	unsigned int num_blocks; /* number of blocks that @fn will process */
 	union {
-- 
2.17.1

