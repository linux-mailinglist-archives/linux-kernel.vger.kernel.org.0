Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F8DEB82B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 20:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbfJaT5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 15:57:13 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:48094 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbfJaT5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 15:57:12 -0400
Received: by mail-pl1-f202.google.com with SMTP id v2so4616272plp.14
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 12:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jiLcFaiREafbQExvYdBwRYAI1ixaZpxsHtd/ZZptGeY=;
        b=kijaECMI63gpRijQOSaerU910bgJTTlqyus72YSKGAy+Qf3mrPCdL3zotP43w3cjvH
         Nu2F53zsePsFo7urk1Ltf7pn0KDEegPJo5LYSjOEJM4/Oj+kOfpyml6re5LpQWXnV08n
         5lcFRXE9ZOHo2mEpph27xcFkuDnJYj7q3ObbhpaDy+344zQ6ztiKz/C92NGGP8uYYq12
         oa420y3gTOMeW5RsxIP0HL93MAefnlv+y87M3PaKcYd7LZ8XmV3QGbeAS/DBnxnFwVPH
         e8E1NqkjLKLkujpzitCP3Qf47WJzsEP6yx81k+7MEzhp7GzfQMq6x4MG89jNnvg9mab9
         DHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jiLcFaiREafbQExvYdBwRYAI1ixaZpxsHtd/ZZptGeY=;
        b=VqA7cEkpO6OXb75T7DL2RgPpj+9ptBuSYZgLQvGNLAnjgMViOQb+yfKRX5RJu24LM9
         Cq5hkRqCwfwW1cXAWEcgSI9J2ExhKObSeGrgvP+831K5Bjf1Vm7w1ECm0vmy3Yh66Rdj
         7OvZURCcYe9uXsjd/svlIVZoz+rQdxMxBGP0FijmmbCVdUYHU2Xtozb4OOuOlLuow7Il
         Cze1oazYpDoy1H8kzn8BViVrJKYNHj/1TFILrCTZCg5e8upJc1qc/oNtucwcF76wn5+E
         TwbwCsySXqOtitwBOIGY+NUFJqj/UYQe3R5kdnZFDDkaoZThp7+joG7buL0ajn8DiGSh
         V0zQ==
X-Gm-Message-State: APjAAAXeYuOslZHjbOfjMSLZt6houBc/7H59hN1loD3OuXwveMNMwe70
        sTqVq7p/YaEP9miv74bXoWkYi6CZTbrmj21wI78=
X-Google-Smtp-Source: APXvYqwQJ+CpJKNtAyhMqOVP2ApilKpzEfeogKnVqPrfJ9Ygs1Oqhnpz5FtQTT0ac9RFgZ7Zd73ObTEs+NFdE0KOu5k=
X-Received: by 2002:a63:65c6:: with SMTP id z189mr8455542pgb.433.1572551829987;
 Thu, 31 Oct 2019 12:57:09 -0700 (PDT)
Date:   Thu, 31 Oct 2019 12:57:05 -0700
Message-Id: <20191031195705.36916-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [RESEND PATCH v2] arm64: lse: fix LSE atomics with LLVM's integrated assembler
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike gcc, clang considers each inline assembly block to be independent
and therefore, when using the integrated assembler for inline assembly,
any preambles that enable features must be repeated in each block.

This change defines __LSE_PREAMBLE and adds it to each inline assembly
block that has LSE instructions, which allows them to be compiled also
with clang's assembler.

Link: https://github.com/ClangBuiltLinux/linux/issues/671
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Andrew Murray <andrew.murray@arm.com>
Tested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
v2:
 - Add a preamble to inline assembly blocks that use LSE instead
   of allowing the compiler to emit LSE instructions everywhere.

---
 arch/arm64/include/asm/atomic_lse.h | 19 +++++++++++++++++++
 arch/arm64/include/asm/lse.h        |  6 +++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index 574808b9df4c..da3280f639cd 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -14,6 +14,7 @@
 static inline void __lse_atomic_##op(int i, atomic_t *v)			\
 {									\
 	asm volatile(							\
+	__LSE_PREAMBLE							\
 "	" #asm_op "	%w[i], %[v]\n"					\
 	: [i] "+r" (i), [v] "+Q" (v->counter)				\
 	: "r" (v));							\
@@ -30,6 +31,7 @@ ATOMIC_OP(add, stadd)
 static inline int __lse_atomic_fetch_##op##name(int i, atomic_t *v)	\
 {									\
 	asm volatile(							\
+	__LSE_PREAMBLE							\
 "	" #asm_op #mb "	%w[i], %w[i], %[v]"				\
 	: [i] "+r" (i), [v] "+Q" (v->counter)				\
 	: "r" (v)							\
@@ -58,6 +60,7 @@ static inline int __lse_atomic_add_return##name(int i, atomic_t *v)	\
 	u32 tmp;							\
 									\
 	asm volatile(							\
+	__LSE_PREAMBLE							\
 	"	ldadd" #mb "	%w[i], %w[tmp], %[v]\n"			\
 	"	add	%w[i], %w[i], %w[tmp]"				\
 	: [i] "+r" (i), [v] "+Q" (v->counter), [tmp] "=&r" (tmp)	\
@@ -77,6 +80,7 @@ ATOMIC_OP_ADD_RETURN(        , al, "memory")
 static inline void __lse_atomic_and(int i, atomic_t *v)
 {
 	asm volatile(
+	__LSE_PREAMBLE
 	"	mvn	%w[i], %w[i]\n"
 	"	stclr	%w[i], %[v]"
 	: [i] "+&r" (i), [v] "+Q" (v->counter)
@@ -87,6 +91,7 @@ static inline void __lse_atomic_and(int i, atomic_t *v)
 static inline int __lse_atomic_fetch_and##name(int i, atomic_t *v)	\
 {									\
 	asm volatile(							\
+	__LSE_PREAMBLE							\
 	"	mvn	%w[i], %w[i]\n"					\
 	"	ldclr" #mb "	%w[i], %w[i], %[v]"			\
 	: [i] "+&r" (i), [v] "+Q" (v->counter)				\
@@ -106,6 +111,7 @@ ATOMIC_FETCH_OP_AND(        , al, "memory")
 static inline void __lse_atomic_sub(int i, atomic_t *v)
 {
 	asm volatile(
+	__LSE_PREAMBLE
 	"	neg	%w[i], %w[i]\n"
 	"	stadd	%w[i], %[v]"
 	: [i] "+&r" (i), [v] "+Q" (v->counter)
@@ -118,6 +124,7 @@ static inline int __lse_atomic_sub_return##name(int i, atomic_t *v)	\
 	u32 tmp;							\
 									\
 	asm volatile(							\
+	__LSE_PREAMBLE							\
 	"	neg	%w[i], %w[i]\n"					\
 	"	ldadd" #mb "	%w[i], %w[tmp], %[v]\n"			\
 	"	add	%w[i], %w[i], %w[tmp]"				\
@@ -139,6 +146,7 @@ ATOMIC_OP_SUB_RETURN(        , al, "memory")
 static inline int __lse_atomic_fetch_sub##name(int i, atomic_t *v)	\
 {									\
 	asm volatile(							\
+	__LSE_PREAMBLE							\
 	"	neg	%w[i], %w[i]\n"					\
 	"	ldadd" #mb "	%w[i], %w[i], %[v]"			\
 	: [i] "+&r" (i), [v] "+Q" (v->counter)				\
@@ -159,6 +167,7 @@ ATOMIC_FETCH_OP_SUB(        , al, "memory")
 static inline void __lse_atomic64_##op(s64 i, atomic64_t *v)		\
 {									\
 	asm volatile(							\
+	__LSE_PREAMBLE							\
 "	" #asm_op "	%[i], %[v]\n"					\
 	: [i] "+r" (i), [v] "+Q" (v->counter)				\
 	: "r" (v));							\
@@ -175,6 +184,7 @@ ATOMIC64_OP(add, stadd)
 static inline long __lse_atomic64_fetch_##op##name(s64 i, atomic64_t *v)\
 {									\
 	asm volatile(							\
+	__LSE_PREAMBLE							\
 "	" #asm_op #mb "	%[i], %[i], %[v]"				\
 	: [i] "+r" (i), [v] "+Q" (v->counter)				\
 	: "r" (v)							\
@@ -203,6 +213,7 @@ static inline long __lse_atomic64_add_return##name(s64 i, atomic64_t *v)\
 	unsigned long tmp;						\
 									\
 	asm volatile(							\
+	__LSE_PREAMBLE							\
 	"	ldadd" #mb "	%[i], %x[tmp], %[v]\n"			\
 	"	add	%[i], %[i], %x[tmp]"				\
 	: [i] "+r" (i), [v] "+Q" (v->counter), [tmp] "=&r" (tmp)	\
@@ -222,6 +233,7 @@ ATOMIC64_OP_ADD_RETURN(        , al, "memory")
 static inline void __lse_atomic64_and(s64 i, atomic64_t *v)
 {
 	asm volatile(
+	__LSE_PREAMBLE
 	"	mvn	%[i], %[i]\n"
 	"	stclr	%[i], %[v]"
 	: [i] "+&r" (i), [v] "+Q" (v->counter)
@@ -232,6 +244,7 @@ static inline void __lse_atomic64_and(s64 i, atomic64_t *v)
 static inline long __lse_atomic64_fetch_and##name(s64 i, atomic64_t *v)	\
 {									\
 	asm volatile(							\
+	__LSE_PREAMBLE							\
 	"	mvn	%[i], %[i]\n"					\
 	"	ldclr" #mb "	%[i], %[i], %[v]"			\
 	: [i] "+&r" (i), [v] "+Q" (v->counter)				\
@@ -251,6 +264,7 @@ ATOMIC64_FETCH_OP_AND(        , al, "memory")
 static inline void __lse_atomic64_sub(s64 i, atomic64_t *v)
 {
 	asm volatile(
+	__LSE_PREAMBLE
 	"	neg	%[i], %[i]\n"
 	"	stadd	%[i], %[v]"
 	: [i] "+&r" (i), [v] "+Q" (v->counter)
@@ -263,6 +277,7 @@ static inline long __lse_atomic64_sub_return##name(s64 i, atomic64_t *v)	\
 	unsigned long tmp;						\
 									\
 	asm volatile(							\
+	__LSE_PREAMBLE							\
 	"	neg	%[i], %[i]\n"					\
 	"	ldadd" #mb "	%[i], %x[tmp], %[v]\n"			\
 	"	add	%[i], %[i], %x[tmp]"				\
@@ -284,6 +299,7 @@ ATOMIC64_OP_SUB_RETURN(        , al, "memory")
 static inline long __lse_atomic64_fetch_sub##name(s64 i, atomic64_t *v)	\
 {									\
 	asm volatile(							\
+	__LSE_PREAMBLE							\
 	"	neg	%[i], %[i]\n"					\
 	"	ldadd" #mb "	%[i], %[i], %[v]"			\
 	: [i] "+&r" (i), [v] "+Q" (v->counter)				\
@@ -305,6 +321,7 @@ static inline s64 __lse_atomic64_dec_if_positive(atomic64_t *v)
 	unsigned long tmp;
 
 	asm volatile(
+	__LSE_PREAMBLE
 	"1:	ldr	%x[tmp], %[v]\n"
 	"	subs	%[ret], %x[tmp], #1\n"
 	"	b.lt	2f\n"
@@ -332,6 +349,7 @@ __lse__cmpxchg_case_##name##sz(volatile void *ptr,			\
 	unsigned long tmp;						\
 									\
 	asm volatile(							\
+	__LSE_PREAMBLE							\
 	"	mov	%" #w "[tmp], %" #w "[old]\n"			\
 	"	cas" #mb #sfx "\t%" #w "[tmp], %" #w "[new], %[v]\n"	\
 	"	mov	%" #w "[ret], %" #w "[tmp]"			\
@@ -379,6 +397,7 @@ __lse__cmpxchg_double##name(unsigned long old1,				\
 	register unsigned long x4 asm ("x4") = (unsigned long)ptr;	\
 									\
 	asm volatile(							\
+	__LSE_PREAMBLE							\
 	"	casp" #mb "\t%[old1], %[old2], %[new1], %[new2], %[v]\n"\
 	"	eor	%[old1], %[old1], %[oldval1]\n"			\
 	"	eor	%[old2], %[old2], %[oldval2]\n"			\
diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
index 80b388278149..73834996c4b6 100644
--- a/arch/arm64/include/asm/lse.h
+++ b/arch/arm64/include/asm/lse.h
@@ -6,6 +6,8 @@
 
 #if defined(CONFIG_AS_LSE) && defined(CONFIG_ARM64_LSE_ATOMICS)
 
+#define __LSE_PREAMBLE	".arch armv8-a+lse\n"
+
 #include <linux/compiler_types.h>
 #include <linux/export.h>
 #include <linux/jump_label.h>
@@ -14,8 +16,6 @@
 #include <asm/atomic_lse.h>
 #include <asm/cpucaps.h>
 
-__asm__(".arch_extension	lse");
-
 extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
 extern struct static_key_false arm64_const_caps_ready;
 
@@ -34,7 +34,7 @@ static inline bool system_uses_lse_atomics(void)
 
 /* In-line patching at runtime */
 #define ARM64_LSE_ATOMIC_INSN(llsc, lse)				\
-	ALTERNATIVE(llsc, lse, ARM64_HAS_LSE_ATOMICS)
+	ALTERNATIVE(llsc, __LSE_PREAMBLE lse, ARM64_HAS_LSE_ATOMICS)
 
 #else	/* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
 
-- 
2.24.0.rc0.303.g954a862665-goog

