Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 927ED6278C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 19:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388538AbfGHRt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 13:49:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38699 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbfGHRt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:49:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id z75so8056453pgz.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wt1kXCBtZByQQmAOHwi3cUKiHnqax3ig6F/7t+ddFBU=;
        b=EheBuPGAw6X9Wwiw2M2g6o28kofUeuDfu3kjUgVruE6FAlanwFQdOktYlscUzcuidp
         SCP9+S0KTJEo6pNdfkAidi4FVN6QRRYe2kJa17re3yh2cYDcxG/3N2lcI7ESV0Lzm8i0
         MOi0/LisgUEGyGybvIpfIO8PaVRafQ8Amx4ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wt1kXCBtZByQQmAOHwi3cUKiHnqax3ig6F/7t+ddFBU=;
        b=Mldth8wouWFx3REmSU493dQsXzX2yxD+s2XzFAqZNxQQlDMPkM4mmchQvuHm0T+gdF
         I2iqVtx4PmpqH70MqPfWGCgf6Qs4sWvPy7sGKpkn3dgrdeDiQGCLHFFAzFbUIrW/gPt0
         GwUaFEMnjSP8WLg9uF1b7f4FHB7Es+E7rxO1fRviR148LjyW1fKPTrYnMRpbdXyN0ARx
         INJFVqxn3th6SqJ6Tot7Pp9XnnN4BUcyc8ZSDvbEw0xoDYJ4WlmHatBso920/fDDooGJ
         tjkaiRFHLZAaUZIIa90qgcQxzIAsEpcGFGy0cXFeN2fLqRJv/Gk1Pk14BPJgWtI3K/v6
         4QOw==
X-Gm-Message-State: APjAAAUEWgNj71cbHLp3dRLSVZtR/XtME1oi7lmaPEBzL8G1XT5GUv75
        MXlvRBZcUrysgqa/y87bLwQiPo6wJxg=
X-Google-Smtp-Source: APXvYqx0OXMsI//ose4Ptm0NIA34tYBAK3srkovVY+mMw2urWfCcUDw2RA3jjMHNlAIXG2BgnzLp1g==
X-Received: by 2002:a65:538d:: with SMTP id x13mr25310238pgq.190.1562608166118;
        Mon, 08 Jul 2019 10:49:26 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id j1sm20151686pfe.101.2019.07.08.10.49.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 10:49:25 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/11] x86/crypto: Adapt assembly for PIE support
Date:   Mon,  8 Jul 2019 10:48:54 -0700
Message-Id: <20190708174913.123308-2-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190708174913.123308-1-thgarnie@chromium.org>
References: <20190708174913.123308-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/crypto/aegis128-aesni-asm.S         |  6 +-
 arch/x86/crypto/aegis128l-aesni-asm.S        |  8 +-
 arch/x86/crypto/aegis256-aesni-asm.S         |  6 +-
 arch/x86/crypto/aes-x86_64-asm_64.S          | 45 +++++----
 arch/x86/crypto/aesni-intel_asm.S            |  8 +-
 arch/x86/crypto/aesni-intel_avx-x86_64.S     |  3 +-
 arch/x86/crypto/camellia-aesni-avx-asm_64.S  | 42 ++++-----
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S | 44 ++++-----
 arch/x86/crypto/camellia-x86_64-asm_64.S     |  8 +-
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S    | 50 +++++-----
 arch/x86/crypto/cast6-avx-x86_64-asm_64.S    | 44 +++++----
 arch/x86/crypto/des3_ede-asm_64.S            | 96 +++++++++++++-------
 arch/x86/crypto/ghash-clmulni-intel_asm.S    |  4 +-
 arch/x86/crypto/glue_helper-asm-avx.S        |  4 +-
 arch/x86/crypto/glue_helper-asm-avx2.S       |  6 +-
 arch/x86/crypto/morus1280-avx2-asm.S         |  4 +-
 arch/x86/crypto/morus1280-sse2-asm.S         |  8 +-
 arch/x86/crypto/morus640-sse2-asm.S          |  6 +-
 arch/x86/crypto/sha256-avx2-asm.S            | 18 ++--
 19 files changed, 236 insertions(+), 174 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis128-aesni-asm.S
index 4434607e366d..00aff3321c16 100644
--- a/arch/x86/crypto/aegis128-aesni-asm.S
+++ b/arch/x86/crypto/aegis128-aesni-asm.S
@@ -200,8 +200,8 @@ ENTRY(crypto_aegis128_aesni_init)
 	movdqa KEY, STATE4
 
 	/* load the constants: */
-	movdqa .Laegis128_const_0, STATE2
-	movdqa .Laegis128_const_1, STATE1
+	movdqa .Laegis128_const_0(%rip), STATE2
+	movdqa .Laegis128_const_1(%rip), STATE1
 	pxor STATE2, STATE3
 	pxor STATE1, STATE4
 
@@ -681,7 +681,7 @@ ENTRY(crypto_aegis128_aesni_dec_tail)
 	punpcklbw T0, T0
 	punpcklbw T0, T0
 	punpcklbw T0, T0
-	movdqa .Laegis128_counter, T1
+	movdqa .Laegis128_counter(%rip), T1
 	pcmpgtb T1, T0
 	pand T0, MSG
 
diff --git a/arch/x86/crypto/aegis128l-aesni-asm.S b/arch/x86/crypto/aegis128l-aesni-asm.S
index 1461ef00c0e8..e7d832984bf1 100644
--- a/arch/x86/crypto/aegis128l-aesni-asm.S
+++ b/arch/x86/crypto/aegis128l-aesni-asm.S
@@ -328,8 +328,8 @@ ENTRY(crypto_aegis128l_aesni_init)
 	pxor MSG0, STATE4
 
 	/* load the constants: */
-	movdqa .Laegis128l_const_0, STATE2
-	movdqa .Laegis128l_const_1, STATE1
+	movdqa .Laegis128l_const_0(%rip), STATE2
+	movdqa .Laegis128l_const_1(%rip), STATE1
 	movdqa STATE1, STATE3
 	pxor STATE2, STATE5
 	pxor STATE1, STATE6
@@ -762,8 +762,8 @@ ENTRY(crypto_aegis128l_aesni_dec_tail)
 	punpcklbw T0, T0
 	punpcklbw T0, T0
 	movdqa T0, T1
-	movdqa .Laegis128l_counter0, T2
-	movdqa .Laegis128l_counter1, T3
+	movdqa .Laegis128l_counter0(%rip), T2
+	movdqa .Laegis128l_counter1(%rip), T3
 	pcmpgtb T2, T0
 	pcmpgtb T3, T1
 	pand T0, MSG0
diff --git a/arch/x86/crypto/aegis256-aesni-asm.S b/arch/x86/crypto/aegis256-aesni-asm.S
index 37d9b13dfd85..5f26cd694661 100644
--- a/arch/x86/crypto/aegis256-aesni-asm.S
+++ b/arch/x86/crypto/aegis256-aesni-asm.S
@@ -270,8 +270,8 @@ ENTRY(crypto_aegis256_aesni_init)
 	movdqa T3, STATE1
 
 	/* load the constants: */
-	movdqa .Laegis256_const_0, STATE3
-	movdqa .Laegis256_const_1, STATE2
+	movdqa .Laegis256_const_0(%rip), STATE3
+	movdqa .Laegis256_const_1(%rip), STATE2
 	pxor STATE3, STATE4
 	pxor STATE2, STATE5
 
@@ -644,7 +644,7 @@ ENTRY(crypto_aegis256_aesni_dec_tail)
 	punpcklbw T0, T0
 	punpcklbw T0, T0
 	punpcklbw T0, T0
-	movdqa .Laegis256_counter, T1
+	movdqa .Laegis256_counter(%rip), T1
 	pcmpgtb T1, T0
 	pand T0, MSG
 
diff --git a/arch/x86/crypto/aes-x86_64-asm_64.S b/arch/x86/crypto/aes-x86_64-asm_64.S
index 8739cf7795de..42eaacb589b3 100644
--- a/arch/x86/crypto/aes-x86_64-asm_64.S
+++ b/arch/x86/crypto/aes-x86_64-asm_64.S
@@ -48,8 +48,12 @@
 #define R10	%r10
 #define R11	%r11
 
+/* Hold global for PIE support */
+#define RBASE	%r12
+
 #define prologue(FUNC,KEY,B128,B192,r1,r2,r5,r6,r7,r8,r9,r10,r11) \
 	ENTRY(FUNC);			\
+	pushq	RBASE;			\
 	movq	r1,r2;			\
 	leaq	KEY+48(r8),r9;		\
 	movq	r10,r11;		\
@@ -74,54 +78,63 @@
 	movl	r6 ## E,4(r9);		\
 	movl	r7 ## E,8(r9);		\
 	movl	r8 ## E,12(r9);		\
+	popq	RBASE;			\
 	ret;				\
 	ENDPROC(FUNC);
 
+#define round_mov(tab_off, reg_i, reg_o) \
+	leaq	tab_off(%rip), RBASE; \
+	movl	(RBASE,reg_i,4), reg_o;
+
+#define round_xor(tab_off, reg_i, reg_o) \
+	leaq	tab_off(%rip), RBASE; \
+	xorl	(RBASE,reg_i,4), reg_o;
+
 #define round(TAB,OFFSET,r1,r2,r3,r4,r5,r6,r7,r8,ra,rb,rc,rd) \
 	movzbl	r2 ## H,r5 ## E;	\
 	movzbl	r2 ## L,r6 ## E;	\
-	movl	TAB+1024(,r5,4),r5 ## E;\
+	round_mov(TAB+1024, r5, r5 ## E)\
 	movw	r4 ## X,r2 ## X;	\
-	movl	TAB(,r6,4),r6 ## E;	\
+	round_mov(TAB, r6, r6 ## E)	\
 	roll	$16,r2 ## E;		\
 	shrl	$16,r4 ## E;		\
 	movzbl	r4 ## L,r7 ## E;	\
 	movzbl	r4 ## H,r4 ## E;	\
 	xorl	OFFSET(r8),ra ## E;	\
 	xorl	OFFSET+4(r8),rb ## E;	\
-	xorl	TAB+3072(,r4,4),r5 ## E;\
-	xorl	TAB+2048(,r7,4),r6 ## E;\
+	round_xor(TAB+3072, r4, r5 ## E)\
+	round_xor(TAB+2048, r7, r6 ## E)\
 	movzbl	r1 ## L,r7 ## E;	\
 	movzbl	r1 ## H,r4 ## E;	\
-	movl	TAB+1024(,r4,4),r4 ## E;\
+	round_mov(TAB+1024, r4, r4 ## E)\
 	movw	r3 ## X,r1 ## X;	\
 	roll	$16,r1 ## E;		\
 	shrl	$16,r3 ## E;		\
-	xorl	TAB(,r7,4),r5 ## E;	\
+	round_xor(TAB, r7, r5 ## E)	\
 	movzbl	r3 ## L,r7 ## E;	\
 	movzbl	r3 ## H,r3 ## E;	\
-	xorl	TAB+3072(,r3,4),r4 ## E;\
-	xorl	TAB+2048(,r7,4),r5 ## E;\
+	round_xor(TAB+3072, r3, r4 ## E)\
+	round_xor(TAB+2048, r7, r5 ## E)\
 	movzbl	r1 ## L,r7 ## E;	\
 	movzbl	r1 ## H,r3 ## E;	\
 	shrl	$16,r1 ## E;		\
-	xorl	TAB+3072(,r3,4),r6 ## E;\
-	movl	TAB+2048(,r7,4),r3 ## E;\
+	round_xor(TAB+3072, r3, r6 ## E)\
+	round_mov(TAB+2048, r7, r3 ## E)\
 	movzbl	r1 ## L,r7 ## E;	\
 	movzbl	r1 ## H,r1 ## E;	\
-	xorl	TAB+1024(,r1,4),r6 ## E;\
-	xorl	TAB(,r7,4),r3 ## E;	\
+	round_xor(TAB+1024, r1, r6 ## E)\
+	round_xor(TAB, r7, r3 ## E)	\
 	movzbl	r2 ## H,r1 ## E;	\
 	movzbl	r2 ## L,r7 ## E;	\
 	shrl	$16,r2 ## E;		\
-	xorl	TAB+3072(,r1,4),r3 ## E;\
-	xorl	TAB+2048(,r7,4),r4 ## E;\
+	round_xor(TAB+3072, r1, r3 ## E)\
+	round_xor(TAB+2048, r7, r4 ## E)\
 	movzbl	r2 ## H,r1 ## E;	\
 	movzbl	r2 ## L,r2 ## E;	\
 	xorl	OFFSET+8(r8),rc ## E;	\
 	xorl	OFFSET+12(r8),rd ## E;	\
-	xorl	TAB+1024(,r1,4),r3 ## E;\
-	xorl	TAB(,r2,4),r4 ## E;
+	round_xor(TAB+1024, r1, r3 ## E)\
+	round_xor(TAB, r2, r4 ## E)
 
 #define move_regs(r1,r2,r3,r4) \
 	movl	r3 ## E,r1 ## E;	\
diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index e40bdf024ba7..36e2cff7fb19 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -2606,7 +2606,7 @@ ENDPROC(aesni_cbc_dec)
  */
 .align 4
 _aesni_inc_init:
-	movaps .Lbswap_mask, BSWAP_MASK
+	movaps .Lbswap_mask(%rip), BSWAP_MASK
 	movaps IV, CTR
 	PSHUFB_XMM BSWAP_MASK CTR
 	mov $1, TCTR_LOW
@@ -2734,12 +2734,12 @@ ENTRY(aesni_xts_crypt8)
 	cmpb $0, %cl
 	movl $0, %ecx
 	movl $240, %r10d
-	leaq _aesni_enc4, %r11
-	leaq _aesni_dec4, %rax
+	leaq _aesni_enc4(%rip), %r11
+	leaq _aesni_dec4(%rip), %rax
 	cmovel %r10d, %ecx
 	cmoveq %rax, %r11
 
-	movdqa .Lgf128mul_x_ble_mask, GF128MUL_MASK
+	movdqa .Lgf128mul_x_ble_mask(%rip), GF128MUL_MASK
 	movups (IVP), IV
 
 	mov 480(KEYP), KLEN
diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aesni-intel_avx-x86_64.S
index 91c039ab5699..210ac0e61eaf 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -660,7 +660,8 @@ _get_AAD_rest0\@:
 	vpshufb and an array of shuffle masks */
 	movq    %r12, %r11
 	salq    $4, %r11
-	vmovdqu  aad_shift_arr(%r11), \T1
+	leaq    aad_shift_arr(%rip), %rax
+	vmovdqu  (%rax,%r11,), \T1
 	vpshufb \T1, \T7, \T7
 _get_AAD_rest_final\@:
 	vpshufb SHUF_MASK(%rip), \T7, \T7
diff --git a/arch/x86/crypto/camellia-aesni-avx-asm_64.S b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
index a14af6eb09cb..f94ec9a5552b 100644
--- a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
@@ -53,10 +53,10 @@
 	/* \
 	 * S-function with AES subbytes \
 	 */ \
-	vmovdqa .Linv_shift_row, t4; \
-	vbroadcastss .L0f0f0f0f, t7; \
-	vmovdqa .Lpre_tf_lo_s1, t0; \
-	vmovdqa .Lpre_tf_hi_s1, t1; \
+	vmovdqa .Linv_shift_row(%rip), t4; \
+	vbroadcastss .L0f0f0f0f(%rip), t7; \
+	vmovdqa .Lpre_tf_lo_s1(%rip), t0; \
+	vmovdqa .Lpre_tf_hi_s1(%rip), t1; \
 	\
 	/* AES inverse shift rows */ \
 	vpshufb t4, x0, x0; \
@@ -69,8 +69,8 @@
 	vpshufb t4, x6, x6; \
 	\
 	/* prefilter sboxes 1, 2 and 3 */ \
-	vmovdqa .Lpre_tf_lo_s4, t2; \
-	vmovdqa .Lpre_tf_hi_s4, t3; \
+	vmovdqa .Lpre_tf_lo_s4(%rip), t2; \
+	vmovdqa .Lpre_tf_hi_s4(%rip), t3; \
 	filter_8bit(x0, t0, t1, t7, t6); \
 	filter_8bit(x7, t0, t1, t7, t6); \
 	filter_8bit(x1, t0, t1, t7, t6); \
@@ -84,8 +84,8 @@
 	filter_8bit(x6, t2, t3, t7, t6); \
 	\
 	/* AES subbytes + AES shift rows */ \
-	vmovdqa .Lpost_tf_lo_s1, t0; \
-	vmovdqa .Lpost_tf_hi_s1, t1; \
+	vmovdqa .Lpost_tf_lo_s1(%rip), t0; \
+	vmovdqa .Lpost_tf_hi_s1(%rip), t1; \
 	vaesenclast t4, x0, x0; \
 	vaesenclast t4, x7, x7; \
 	vaesenclast t4, x1, x1; \
@@ -96,16 +96,16 @@
 	vaesenclast t4, x6, x6; \
 	\
 	/* postfilter sboxes 1 and 4 */ \
-	vmovdqa .Lpost_tf_lo_s3, t2; \
-	vmovdqa .Lpost_tf_hi_s3, t3; \
+	vmovdqa .Lpost_tf_lo_s3(%rip), t2; \
+	vmovdqa .Lpost_tf_hi_s3(%rip), t3; \
 	filter_8bit(x0, t0, t1, t7, t6); \
 	filter_8bit(x7, t0, t1, t7, t6); \
 	filter_8bit(x3, t0, t1, t7, t6); \
 	filter_8bit(x6, t0, t1, t7, t6); \
 	\
 	/* postfilter sbox 3 */ \
-	vmovdqa .Lpost_tf_lo_s2, t4; \
-	vmovdqa .Lpost_tf_hi_s2, t5; \
+	vmovdqa .Lpost_tf_lo_s2(%rip), t4; \
+	vmovdqa .Lpost_tf_hi_s2(%rip), t5; \
 	filter_8bit(x2, t2, t3, t7, t6); \
 	filter_8bit(x5, t2, t3, t7, t6); \
 	\
@@ -444,7 +444,7 @@ ENDPROC(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	transpose_4x4(c0, c1, c2, c3, a0, a1); \
 	transpose_4x4(d0, d1, d2, d3, a0, a1); \
 	\
-	vmovdqu .Lshufb_16x16b, a0; \
+	vmovdqu .Lshufb_16x16b(%rip), a0; \
 	vmovdqu st1, a1; \
 	vpshufb a0, a2, a2; \
 	vpshufb a0, a3, a3; \
@@ -483,7 +483,7 @@ ENDPROC(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 #define inpack16_pre(x0, x1, x2, x3, x4, x5, x6, x7, y0, y1, y2, y3, y4, y5, \
 		     y6, y7, rio, key) \
 	vmovq key, x0; \
-	vpshufb .Lpack_bswap, x0, x0; \
+	vpshufb .Lpack_bswap(%rip), x0, x0; \
 	\
 	vpxor 0 * 16(rio), x0, y7; \
 	vpxor 1 * 16(rio), x0, y6; \
@@ -534,7 +534,7 @@ ENDPROC(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	vmovdqu x0, stack_tmp0; \
 	\
 	vmovq key, x0; \
-	vpshufb .Lpack_bswap, x0, x0; \
+	vpshufb .Lpack_bswap(%rip), x0, x0; \
 	\
 	vpxor x0, y7, y7; \
 	vpxor x0, y6, y6; \
@@ -1017,7 +1017,7 @@ ENTRY(camellia_ctr_16way)
 	subq $(16 * 16), %rsp;
 	movq %rsp, %rax;
 
-	vmovdqa .Lbswap128_mask, %xmm14;
+	vmovdqa .Lbswap128_mask(%rip), %xmm14;
 
 	/* load IV and byteswap */
 	vmovdqu (%rcx), %xmm0;
@@ -1066,7 +1066,7 @@ ENTRY(camellia_ctr_16way)
 
 	/* inpack16_pre: */
 	vmovq (key_table)(CTX), %xmm15;
-	vpshufb .Lpack_bswap, %xmm15, %xmm15;
+	vpshufb .Lpack_bswap(%rip), %xmm15, %xmm15;
 	vpxor %xmm0, %xmm15, %xmm0;
 	vpxor %xmm1, %xmm15, %xmm1;
 	vpxor %xmm2, %xmm15, %xmm2;
@@ -1134,7 +1134,7 @@ camellia_xts_crypt_16way:
 	subq $(16 * 16), %rsp;
 	movq %rsp, %rax;
 
-	vmovdqa .Lxts_gf128mul_and_shl1_mask, %xmm14;
+	vmovdqa .Lxts_gf128mul_and_shl1_mask(%rip), %xmm14;
 
 	/* load IV */
 	vmovdqu (%rcx), %xmm0;
@@ -1210,7 +1210,7 @@ camellia_xts_crypt_16way:
 
 	/* inpack16_pre: */
 	vmovq (key_table)(CTX, %r8, 8), %xmm15;
-	vpshufb .Lpack_bswap, %xmm15, %xmm15;
+	vpshufb .Lpack_bswap(%rip), %xmm15, %xmm15;
 	vpxor 0 * 16(%rax), %xmm15, %xmm0;
 	vpxor %xmm1, %xmm15, %xmm1;
 	vpxor %xmm2, %xmm15, %xmm2;
@@ -1265,7 +1265,7 @@ ENTRY(camellia_xts_enc_16way)
 	 */
 	xorl %r8d, %r8d; /* input whitening key, 0 for enc */
 
-	leaq __camellia_enc_blk16, %r9;
+	leaq __camellia_enc_blk16(%rip), %r9;
 
 	jmp camellia_xts_crypt_16way;
 ENDPROC(camellia_xts_enc_16way)
@@ -1283,7 +1283,7 @@ ENTRY(camellia_xts_dec_16way)
 	movl $24, %eax;
 	cmovel %eax, %r8d;  /* input whitening key, last for dec */
 
-	leaq __camellia_dec_blk16, %r9;
+	leaq __camellia_dec_blk16(%rip), %r9;
 
 	jmp camellia_xts_crypt_16way;
 ENDPROC(camellia_xts_dec_16way)
diff --git a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
index 4be4c7c3ba27..545ff16a196b 100644
--- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
@@ -65,12 +65,12 @@
 	/* \
 	 * S-function with AES subbytes \
 	 */ \
-	vbroadcasti128 .Linv_shift_row, t4; \
-	vpbroadcastd .L0f0f0f0f, t7; \
-	vbroadcasti128 .Lpre_tf_lo_s1, t5; \
-	vbroadcasti128 .Lpre_tf_hi_s1, t6; \
-	vbroadcasti128 .Lpre_tf_lo_s4, t2; \
-	vbroadcasti128 .Lpre_tf_hi_s4, t3; \
+	vbroadcasti128 .Linv_shift_row(%rip), t4; \
+	vpbroadcastd .L0f0f0f0f(%rip), t7; \
+	vbroadcasti128 .Lpre_tf_lo_s1(%rip), t5; \
+	vbroadcasti128 .Lpre_tf_hi_s1(%rip), t6; \
+	vbroadcasti128 .Lpre_tf_lo_s4(%rip), t2; \
+	vbroadcasti128 .Lpre_tf_hi_s4(%rip), t3; \
 	\
 	/* AES inverse shift rows */ \
 	vpshufb t4, x0, x0; \
@@ -116,8 +116,8 @@
 	vinserti128 $1, t2##_x, x6, x6; \
 	vextracti128 $1, x1, t3##_x; \
 	vextracti128 $1, x4, t2##_x; \
-	vbroadcasti128 .Lpost_tf_lo_s1, t0; \
-	vbroadcasti128 .Lpost_tf_hi_s1, t1; \
+	vbroadcasti128 .Lpost_tf_lo_s1(%rip), t0; \
+	vbroadcasti128 .Lpost_tf_hi_s1(%rip), t1; \
 	vaesenclast t4##_x, x2##_x, x2##_x; \
 	vaesenclast t4##_x, t6##_x, t6##_x; \
 	vinserti128 $1, t6##_x, x2, x2; \
@@ -132,16 +132,16 @@
 	vinserti128 $1, t2##_x, x4, x4; \
 	\
 	/* postfilter sboxes 1 and 4 */ \
-	vbroadcasti128 .Lpost_tf_lo_s3, t2; \
-	vbroadcasti128 .Lpost_tf_hi_s3, t3; \
+	vbroadcasti128 .Lpost_tf_lo_s3(%rip), t2; \
+	vbroadcasti128 .Lpost_tf_hi_s3(%rip), t3; \
 	filter_8bit(x0, t0, t1, t7, t6); \
 	filter_8bit(x7, t0, t1, t7, t6); \
 	filter_8bit(x3, t0, t1, t7, t6); \
 	filter_8bit(x6, t0, t1, t7, t6); \
 	\
 	/* postfilter sbox 3 */ \
-	vbroadcasti128 .Lpost_tf_lo_s2, t4; \
-	vbroadcasti128 .Lpost_tf_hi_s2, t5; \
+	vbroadcasti128 .Lpost_tf_lo_s2(%rip), t4; \
+	vbroadcasti128 .Lpost_tf_hi_s2(%rip), t5; \
 	filter_8bit(x2, t2, t3, t7, t6); \
 	filter_8bit(x5, t2, t3, t7, t6); \
 	\
@@ -478,7 +478,7 @@ ENDPROC(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	transpose_4x4(c0, c1, c2, c3, a0, a1); \
 	transpose_4x4(d0, d1, d2, d3, a0, a1); \
 	\
-	vbroadcasti128 .Lshufb_16x16b, a0; \
+	vbroadcasti128 .Lshufb_16x16b(%rip), a0; \
 	vmovdqu st1, a1; \
 	vpshufb a0, a2, a2; \
 	vpshufb a0, a3, a3; \
@@ -517,7 +517,7 @@ ENDPROC(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 #define inpack32_pre(x0, x1, x2, x3, x4, x5, x6, x7, y0, y1, y2, y3, y4, y5, \
 		     y6, y7, rio, key) \
 	vpbroadcastq key, x0; \
-	vpshufb .Lpack_bswap, x0, x0; \
+	vpshufb .Lpack_bswap(%rip), x0, x0; \
 	\
 	vpxor 0 * 32(rio), x0, y7; \
 	vpxor 1 * 32(rio), x0, y6; \
@@ -568,7 +568,7 @@ ENDPROC(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	vmovdqu x0, stack_tmp0; \
 	\
 	vpbroadcastq key, x0; \
-	vpshufb .Lpack_bswap, x0, x0; \
+	vpshufb .Lpack_bswap(%rip), x0, x0; \
 	\
 	vpxor x0, y7, y7; \
 	vpxor x0, y6, y6; \
@@ -1108,7 +1108,7 @@ ENTRY(camellia_ctr_32way)
 	vmovdqu (%rcx), %xmm0;
 	vmovdqa %xmm0, %xmm1;
 	inc_le128(%xmm0, %xmm15, %xmm14);
-	vbroadcasti128 .Lbswap128_mask, %ymm14;
+	vbroadcasti128 .Lbswap128_mask(%rip), %ymm14;
 	vinserti128 $1, %xmm0, %ymm1, %ymm0;
 	vpshufb %ymm14, %ymm0, %ymm13;
 	vmovdqu %ymm13, 15 * 32(%rax);
@@ -1154,7 +1154,7 @@ ENTRY(camellia_ctr_32way)
 
 	/* inpack32_pre: */
 	vpbroadcastq (key_table)(CTX), %ymm15;
-	vpshufb .Lpack_bswap, %ymm15, %ymm15;
+	vpshufb .Lpack_bswap(%rip), %ymm15, %ymm15;
 	vpxor %ymm0, %ymm15, %ymm0;
 	vpxor %ymm1, %ymm15, %ymm1;
 	vpxor %ymm2, %ymm15, %ymm2;
@@ -1238,13 +1238,13 @@ camellia_xts_crypt_32way:
 	subq $(16 * 32), %rsp;
 	movq %rsp, %rax;
 
-	vbroadcasti128 .Lxts_gf128mul_and_shl1_mask_0, %ymm12;
+	vbroadcasti128 .Lxts_gf128mul_and_shl1_mask_0(%rip), %ymm12;
 
 	/* load IV and construct second IV */
 	vmovdqu (%rcx), %xmm0;
 	vmovdqa %xmm0, %xmm15;
 	gf128mul_x_ble(%xmm0, %xmm12, %xmm13);
-	vbroadcasti128 .Lxts_gf128mul_and_shl1_mask_1, %ymm13;
+	vbroadcasti128 .Lxts_gf128mul_and_shl1_mask_1(%rip), %ymm13;
 	vinserti128 $1, %xmm0, %ymm15, %ymm0;
 	vpxor 0 * 32(%rdx), %ymm0, %ymm15;
 	vmovdqu %ymm15, 15 * 32(%rax);
@@ -1321,7 +1321,7 @@ camellia_xts_crypt_32way:
 
 	/* inpack32_pre: */
 	vpbroadcastq (key_table)(CTX, %r8, 8), %ymm15;
-	vpshufb .Lpack_bswap, %ymm15, %ymm15;
+	vpshufb .Lpack_bswap(%rip), %ymm15, %ymm15;
 	vpxor 0 * 32(%rax), %ymm15, %ymm0;
 	vpxor %ymm1, %ymm15, %ymm1;
 	vpxor %ymm2, %ymm15, %ymm2;
@@ -1379,7 +1379,7 @@ ENTRY(camellia_xts_enc_32way)
 
 	xorl %r8d, %r8d; /* input whitening key, 0 for enc */
 
-	leaq __camellia_enc_blk32, %r9;
+	leaq __camellia_enc_blk32(%rip), %r9;
 
 	jmp camellia_xts_crypt_32way;
 ENDPROC(camellia_xts_enc_32way)
@@ -1397,7 +1397,7 @@ ENTRY(camellia_xts_dec_32way)
 	movl $24, %eax;
 	cmovel %eax, %r8d;  /* input whitening key, last for dec */
 
-	leaq __camellia_dec_blk32, %r9;
+	leaq __camellia_dec_blk32(%rip), %r9;
 
 	jmp camellia_xts_crypt_32way;
 ENDPROC(camellia_xts_dec_32way)
diff --git a/arch/x86/crypto/camellia-x86_64-asm_64.S b/arch/x86/crypto/camellia-x86_64-asm_64.S
index 23528bc18fc6..021b0f0090f4 100644
--- a/arch/x86/crypto/camellia-x86_64-asm_64.S
+++ b/arch/x86/crypto/camellia-x86_64-asm_64.S
@@ -77,11 +77,13 @@
 #define RXORbl %r9b
 
 #define xor2ror16(T0, T1, tmp1, tmp2, ab, dst) \
+	leaq T0(%rip), 			tmp1; \
 	movzbl ab ## bl,		tmp2 ## d; \
+	xorq (tmp1, tmp2, 8),		dst; \
+	leaq T1(%rip), 			tmp2; \
 	movzbl ab ## bh,		tmp1 ## d; \
-	rorq $16,			ab; \
-	xorq T0(, tmp2, 8),		dst; \
-	xorq T1(, tmp1, 8),		dst;
+	xorq (tmp2, tmp1, 8),		dst; \
+	rorq $16,			ab;
 
 /**********************************************************************
   1-way camellia
diff --git a/arch/x86/crypto/cast5-avx-x86_64-asm_64.S b/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
index dc55c3332fcc..213b5d8a9d08 100644
--- a/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
@@ -83,16 +83,20 @@
 
 
 #define lookup_32bit(src, dst, op1, op2, op3, interleave_op, il_reg) \
-	movzbl		src ## bh,     RID1d;    \
-	movzbl		src ## bl,     RID2d;    \
-	shrq $16,	src;                     \
-	movl		s1(, RID1, 4), dst ## d; \
-	op1		s2(, RID2, 4), dst ## d; \
-	movzbl		src ## bh,     RID1d;    \
-	movzbl		src ## bl,     RID2d;    \
-	interleave_op(il_reg);			 \
-	op2		s3(, RID1, 4), dst ## d; \
-	op3		s4(, RID2, 4), dst ## d;
+	movzbl		src ## bh,       RID1d;    \
+	leaq		s1(%rip),        RID2;     \
+	movl		(RID2, RID1, 4), dst ## d; \
+	movzbl		src ## bl,       RID2d;    \
+	leaq		s2(%rip),        RID1;     \
+	op1		(RID1, RID2, 4), dst ## d; \
+	shrq $16,	src;                       \
+	movzbl		src ## bh,     RID1d;      \
+	leaq		s3(%rip),        RID2;     \
+	op2		(RID2, RID1, 4), dst ## d; \
+	movzbl		src ## bl,     RID2d;      \
+	leaq		s4(%rip),        RID1;     \
+	op3		(RID1, RID2, 4), dst ## d; \
+	interleave_op(il_reg);
 
 #define dummy(d) /* do nothing */
 
@@ -151,15 +155,15 @@
 	subround(l ## 3, r ## 3, l ## 4, r ## 4, f);
 
 #define enc_preload_rkr() \
-	vbroadcastss	.L16_mask,                RKR;      \
+	vbroadcastss	.L16_mask(%rip),          RKR;      \
 	/* add 16-bit rotation to key rotations (mod 32) */ \
 	vpxor		kr(CTX),                  RKR, RKR;
 
 #define dec_preload_rkr() \
-	vbroadcastss	.L16_mask,                RKR;      \
+	vbroadcastss	.L16_mask(%rip),          RKR;      \
 	/* add 16-bit rotation to key rotations (mod 32) */ \
 	vpxor		kr(CTX),                  RKR, RKR; \
-	vpshufb		.Lbswap128_mask,          RKR, RKR;
+	vpshufb		.Lbswap128_mask(%rip),    RKR, RKR;
 
 #define transpose_2x4(x0, x1, t0, t1) \
 	vpunpckldq		x1, x0, t0; \
@@ -236,9 +240,9 @@ __cast5_enc_blk16:
 
 	movq %rdi, CTX;
 
-	vmovdqa .Lbswap_mask, RKM;
-	vmovd .Lfirst_mask, R1ST;
-	vmovd .L32_mask, R32;
+	vmovdqa .Lbswap_mask(%rip), RKM;
+	vmovd .Lfirst_mask(%rip), R1ST;
+	vmovd .L32_mask(%rip), R32;
 	enc_preload_rkr();
 
 	inpack_blocks(RL1, RR1, RTMP, RX, RKM);
@@ -272,7 +276,7 @@ __cast5_enc_blk16:
 	popq %rbx;
 	popq %r15;
 
-	vmovdqa .Lbswap_mask, RKM;
+	vmovdqa .Lbswap_mask(%rip), RKM;
 
 	outunpack_blocks(RR1, RL1, RTMP, RX, RKM);
 	outunpack_blocks(RR2, RL2, RTMP, RX, RKM);
@@ -310,9 +314,9 @@ __cast5_dec_blk16:
 
 	movq %rdi, CTX;
 
-	vmovdqa .Lbswap_mask, RKM;
-	vmovd .Lfirst_mask, R1ST;
-	vmovd .L32_mask, R32;
+	vmovdqa .Lbswap_mask(%rip), RKM;
+	vmovd .Lfirst_mask(%rip), R1ST;
+	vmovd .L32_mask(%rip), R32;
 	dec_preload_rkr();
 
 	inpack_blocks(RL1, RR1, RTMP, RX, RKM);
@@ -343,7 +347,7 @@ __cast5_dec_blk16:
 	round(RL, RR, 1, 2);
 	round(RR, RL, 0, 1);
 
-	vmovdqa .Lbswap_mask, RKM;
+	vmovdqa .Lbswap_mask(%rip), RKM;
 	popq %rbx;
 	popq %r15;
 
@@ -506,8 +510,8 @@ ENTRY(cast5_ctr_16way)
 
 	vpcmpeqd RKR, RKR, RKR;
 	vpaddq RKR, RKR, RKR; /* low: -2, high: -2 */
-	vmovdqa .Lbswap_iv_mask, R1ST;
-	vmovdqa .Lbswap128_mask, RKM;
+	vmovdqa .Lbswap_iv_mask(%rip), R1ST;
+	vmovdqa .Lbswap128_mask(%rip), RKM;
 
 	/* load IV and byteswap */
 	vmovq (%rcx), RX;
diff --git a/arch/x86/crypto/cast6-avx-x86_64-asm_64.S b/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
index 4f0a7cdb94d9..9879a12c243a 100644
--- a/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
@@ -83,16 +83,20 @@
 
 
 #define lookup_32bit(src, dst, op1, op2, op3, interleave_op, il_reg) \
-	movzbl		src ## bh,     RID1d;    \
-	movzbl		src ## bl,     RID2d;    \
-	shrq $16,	src;                     \
-	movl		s1(, RID1, 4), dst ## d; \
-	op1		s2(, RID2, 4), dst ## d; \
-	movzbl		src ## bh,     RID1d;    \
-	movzbl		src ## bl,     RID2d;    \
-	interleave_op(il_reg);			 \
-	op2		s3(, RID1, 4), dst ## d; \
-	op3		s4(, RID2, 4), dst ## d;
+	movzbl		src ## bh,       RID1d;    \
+	leaq		s1(%rip),        RID2;     \
+	movl		(RID2, RID1, 4), dst ## d; \
+	movzbl		src ## bl,       RID2d;    \
+	leaq		s2(%rip),        RID1;     \
+	op1		(RID1, RID2, 4), dst ## d; \
+	shrq $16,	src;                       \
+	movzbl		src ## bh,     RID1d;      \
+	leaq		s3(%rip),        RID2;     \
+	op2		(RID2, RID1, 4), dst ## d; \
+	movzbl		src ## bl,     RID2d;      \
+	leaq		s4(%rip),        RID1;     \
+	op3		(RID1, RID2, 4), dst ## d; \
+	interleave_op(il_reg);
 
 #define dummy(d) /* do nothing */
 
@@ -175,10 +179,10 @@
 	qop(RD, RC, 1);
 
 #define shuffle(mask) \
-	vpshufb		mask,            RKR, RKR;
+	vpshufb		mask(%rip),            RKR, RKR;
 
 #define preload_rkr(n, do_mask, mask) \
-	vbroadcastss	.L16_mask,                RKR;      \
+	vbroadcastss	.L16_mask(%rip),          RKR;      \
 	/* add 16-bit rotation to key rotations (mod 32) */ \
 	vpxor		(kr+n*16)(CTX),           RKR, RKR; \
 	do_mask(mask);
@@ -260,9 +264,9 @@ __cast6_enc_blk8:
 
 	movq %rdi, CTX;
 
-	vmovdqa .Lbswap_mask, RKM;
-	vmovd .Lfirst_mask, R1ST;
-	vmovd .L32_mask, R32;
+	vmovdqa .Lbswap_mask(%rip), RKM;
+	vmovd .Lfirst_mask(%rip), R1ST;
+	vmovd .L32_mask(%rip), R32;
 
 	inpack_blocks(RA1, RB1, RC1, RD1, RTMP, RX, RKRF, RKM);
 	inpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
@@ -286,7 +290,7 @@ __cast6_enc_blk8:
 	popq %rbx;
 	popq %r15;
 
-	vmovdqa .Lbswap_mask, RKM;
+	vmovdqa .Lbswap_mask(%rip), RKM;
 
 	outunpack_blocks(RA1, RB1, RC1, RD1, RTMP, RX, RKRF, RKM);
 	outunpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
@@ -308,9 +312,9 @@ __cast6_dec_blk8:
 
 	movq %rdi, CTX;
 
-	vmovdqa .Lbswap_mask, RKM;
-	vmovd .Lfirst_mask, R1ST;
-	vmovd .L32_mask, R32;
+	vmovdqa .Lbswap_mask(%rip), RKM;
+	vmovd .Lfirst_mask(%rip), R1ST;
+	vmovd .L32_mask(%rip), R32;
 
 	inpack_blocks(RA1, RB1, RC1, RD1, RTMP, RX, RKRF, RKM);
 	inpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
@@ -334,7 +338,7 @@ __cast6_dec_blk8:
 	popq %rbx;
 	popq %r15;
 
-	vmovdqa .Lbswap_mask, RKM;
+	vmovdqa .Lbswap_mask(%rip), RKM;
 	outunpack_blocks(RA1, RB1, RC1, RD1, RTMP, RX, RKRF, RKM);
 	outunpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
 
diff --git a/arch/x86/crypto/des3_ede-asm_64.S b/arch/x86/crypto/des3_ede-asm_64.S
index 7fca43099a5f..e51dcf8c7eb7 100644
--- a/arch/x86/crypto/des3_ede-asm_64.S
+++ b/arch/x86/crypto/des3_ede-asm_64.S
@@ -129,21 +129,29 @@
 	movzbl RW0bl, RT2d; \
 	movzbl RW0bh, RT3d; \
 	shrq $16, RW0; \
-	movq s8(, RT0, 8), RT0; \
-	xorq s6(, RT1, 8), to; \
+	leaq s8(%rip), RW1; \
+	movq (RW1, RT0, 8), RT0; \
+	leaq s6(%rip), RW1; \
+	xorq (RW1, RT1, 8), to; \
 	movzbl RW0bl, RL1d; \
 	movzbl RW0bh, RT1d; \
 	shrl $16, RW0d; \
-	xorq s4(, RT2, 8), RT0; \
-	xorq s2(, RT3, 8), to; \
+	leaq s4(%rip), RW1; \
+	xorq (RW1, RT2, 8), RT0; \
+	leaq s2(%rip), RW1; \
+	xorq (RW1, RT3, 8), to; \
 	movzbl RW0bl, RT2d; \
 	movzbl RW0bh, RT3d; \
-	xorq s7(, RL1, 8), RT0; \
-	xorq s5(, RT1, 8), to; \
-	xorq s3(, RT2, 8), RT0; \
+	leaq s7(%rip), RW1; \
+	xorq (RW1, RL1, 8), RT0; \
+	leaq s5(%rip), RW1; \
+	xorq (RW1, RT1, 8), to; \
+	leaq s3(%rip), RW1; \
+	xorq (RW1, RT2, 8), RT0; \
 	load_next_key(n, RW0); \
 	xorq RT0, to; \
-	xorq s1(, RT3, 8), to; \
+	leaq s1(%rip), RW1; \
+	xorq (RW1, RT3, 8), to; \
 
 #define load_next_key(n, RWx) \
 	movq (((n) + 1) * 8)(CTX), RWx;
@@ -355,65 +363,89 @@ ENDPROC(des3_ede_x86_64_crypt_blk)
 	movzbl RW0bl, RT3d; \
 	movzbl RW0bh, RT1d; \
 	shrq $16, RW0; \
-	xorq s8(, RT3, 8), to##0; \
-	xorq s6(, RT1, 8), to##0; \
+	leaq s8(%rip), RT2; \
+	xorq (RT2, RT3, 8), to##0; \
+	leaq s6(%rip), RT2; \
+	xorq (RT2, RT1, 8), to##0; \
 	movzbl RW0bl, RT3d; \
 	movzbl RW0bh, RT1d; \
 	shrq $16, RW0; \
-	xorq s4(, RT3, 8), to##0; \
-	xorq s2(, RT1, 8), to##0; \
+	leaq s4(%rip), RT2; \
+	xorq (RT2, RT3, 8), to##0; \
+	leaq s2(%rip), RT2; \
+	xorq (RT2, RT1, 8), to##0; \
 	movzbl RW0bl, RT3d; \
 	movzbl RW0bh, RT1d; \
 	shrl $16, RW0d; \
-	xorq s7(, RT3, 8), to##0; \
-	xorq s5(, RT1, 8), to##0; \
+	leaq s7(%rip), RT2; \
+	xorq (RT2, RT3, 8), to##0; \
+	leaq s5(%rip), RT2; \
+	xorq (RT2, RT1, 8), to##0; \
 	movzbl RW0bl, RT3d; \
 	movzbl RW0bh, RT1d; \
 	load_next_key(n, RW0); \
-	xorq s3(, RT3, 8), to##0; \
-	xorq s1(, RT1, 8), to##0; \
+	leaq s3(%rip), RT2; \
+	xorq (RT2, RT3, 8), to##0; \
+	leaq s1(%rip), RT2; \
+	xorq (RT2, RT1, 8), to##0; \
 		xorq from##1, RW1; \
 		movzbl RW1bl, RT3d; \
 		movzbl RW1bh, RT1d; \
 		shrq $16, RW1; \
-		xorq s8(, RT3, 8), to##1; \
-		xorq s6(, RT1, 8), to##1; \
+		leaq s8(%rip), RT2; \
+		xorq (RT2, RT3, 8), to##1; \
+		leaq s6(%rip), RT2; \
+		xorq (RT2, RT1, 8), to##1; \
 		movzbl RW1bl, RT3d; \
 		movzbl RW1bh, RT1d; \
 		shrq $16, RW1; \
-		xorq s4(, RT3, 8), to##1; \
-		xorq s2(, RT1, 8), to##1; \
+		leaq s4(%rip), RT2; \
+		xorq (RT2, RT3, 8), to##1; \
+		leaq s2(%rip), RT2; \
+		xorq (RT2, RT1, 8), to##1; \
 		movzbl RW1bl, RT3d; \
 		movzbl RW1bh, RT1d; \
 		shrl $16, RW1d; \
-		xorq s7(, RT3, 8), to##1; \
-		xorq s5(, RT1, 8), to##1; \
+		leaq s7(%rip), RT2; \
+		xorq (RT2, RT3, 8), to##1; \
+		leaq s5(%rip), RT2; \
+		xorq (RT2, RT1, 8), to##1; \
 		movzbl RW1bl, RT3d; \
 		movzbl RW1bh, RT1d; \
 		do_movq(RW0, RW1); \
-		xorq s3(, RT3, 8), to##1; \
-		xorq s1(, RT1, 8), to##1; \
+		leaq s3(%rip), RT2; \
+		xorq (RT2, RT3, 8), to##1; \
+		leaq s1(%rip), RT2; \
+		xorq (RT2, RT1, 8), to##1; \
 			xorq from##2, RW2; \
 			movzbl RW2bl, RT3d; \
 			movzbl RW2bh, RT1d; \
 			shrq $16, RW2; \
-			xorq s8(, RT3, 8), to##2; \
-			xorq s6(, RT1, 8), to##2; \
+			leaq s8(%rip), RT2; \
+			xorq (RT2, RT3, 8), to##2; \
+			leaq s6(%rip), RT2; \
+			xorq (RT2, RT1, 8), to##2; \
 			movzbl RW2bl, RT3d; \
 			movzbl RW2bh, RT1d; \
 			shrq $16, RW2; \
-			xorq s4(, RT3, 8), to##2; \
-			xorq s2(, RT1, 8), to##2; \
+			leaq s4(%rip), RT2; \
+			xorq (RT2, RT3, 8), to##2; \
+			leaq s2(%rip), RT2; \
+			xorq (RT2, RT1, 8), to##2; \
 			movzbl RW2bl, RT3d; \
 			movzbl RW2bh, RT1d; \
 			shrl $16, RW2d; \
-			xorq s7(, RT3, 8), to##2; \
-			xorq s5(, RT1, 8), to##2; \
+			leaq s7(%rip), RT2; \
+			xorq (RT2, RT3, 8), to##2; \
+			leaq s5(%rip), RT2; \
+			xorq (RT2, RT1, 8), to##2; \
 			movzbl RW2bl, RT3d; \
 			movzbl RW2bh, RT1d; \
 			do_movq(RW0, RW2); \
-			xorq s3(, RT3, 8), to##2; \
-			xorq s1(, RT1, 8), to##2;
+			leaq s3(%rip), RT2; \
+			xorq (RT2, RT3, 8), to##2; \
+			leaq s1(%rip), RT2; \
+			xorq (RT2, RT1, 8), to##2;
 
 #define __movq(src, dst) \
 	movq src, dst;
diff --git a/arch/x86/crypto/ghash-clmulni-intel_asm.S b/arch/x86/crypto/ghash-clmulni-intel_asm.S
index 5d53effe8abe..f8029074a99e 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_asm.S
+++ b/arch/x86/crypto/ghash-clmulni-intel_asm.S
@@ -94,7 +94,7 @@ ENTRY(clmul_ghash_mul)
 	FRAME_BEGIN
 	movups (%rdi), DATA
 	movups (%rsi), SHASH
-	movaps .Lbswap_mask, BSWAP
+	movaps .Lbswap_mask(%rip), BSWAP
 	PSHUFB_XMM BSWAP DATA
 	call __clmul_gf128mul_ble
 	PSHUFB_XMM BSWAP DATA
@@ -111,7 +111,7 @@ ENTRY(clmul_ghash_update)
 	FRAME_BEGIN
 	cmp $16, %rdx
 	jb .Lupdate_just_ret	# check length
-	movaps .Lbswap_mask, BSWAP
+	movaps .Lbswap_mask(%rip), BSWAP
 	movups (%rdi), DATA
 	movups (%rcx), SHASH
 	PSHUFB_XMM BSWAP DATA
diff --git a/arch/x86/crypto/glue_helper-asm-avx.S b/arch/x86/crypto/glue_helper-asm-avx.S
index d08fc575ef7f..a9736f85fef0 100644
--- a/arch/x86/crypto/glue_helper-asm-avx.S
+++ b/arch/x86/crypto/glue_helper-asm-avx.S
@@ -44,7 +44,7 @@
 #define load_ctr_8way(iv, bswap, x0, x1, x2, x3, x4, x5, x6, x7, t0, t1, t2) \
 	vpcmpeqd t0, t0, t0; \
 	vpsrldq $8, t0, t0; /* low: -1, high: 0 */ \
-	vmovdqa bswap, t1; \
+	vmovdqa bswap(%rip), t1; \
 	\
 	/* load IV and byteswap */ \
 	vmovdqu (iv), x7; \
@@ -89,7 +89,7 @@
 
 #define load_xts_8way(iv, src, dst, x0, x1, x2, x3, x4, x5, x6, x7, tiv, t0, \
 		      t1, xts_gf128mul_and_shl1_mask) \
-	vmovdqa xts_gf128mul_and_shl1_mask, t0; \
+	vmovdqa xts_gf128mul_and_shl1_mask(%rip), t0; \
 	\
 	/* load IV */ \
 	vmovdqu (iv), tiv; \
diff --git a/arch/x86/crypto/glue_helper-asm-avx2.S b/arch/x86/crypto/glue_helper-asm-avx2.S
index d84508c85c13..efbf4953707e 100644
--- a/arch/x86/crypto/glue_helper-asm-avx2.S
+++ b/arch/x86/crypto/glue_helper-asm-avx2.S
@@ -62,7 +62,7 @@
 	vmovdqu (iv), t2x; \
 	vmovdqa t2x, t3x; \
 	inc_le128(t2x, t0x, t1x); \
-	vbroadcasti128 bswap, t1; \
+	vbroadcasti128 bswap(%rip), t1; \
 	vinserti128 $1, t2x, t3, t2; /* ab: le0 ; cd: le1 */ \
 	vpshufb t1, t2, x0; \
 	\
@@ -119,13 +119,13 @@
 		       tivx, t0, t0x, t1, t1x, t2, t2x, t3, \
 		       xts_gf128mul_and_shl1_mask_0, \
 		       xts_gf128mul_and_shl1_mask_1) \
-	vbroadcasti128 xts_gf128mul_and_shl1_mask_0, t1; \
+	vbroadcasti128 xts_gf128mul_and_shl1_mask_0(%rip), t1; \
 	\
 	/* load IV and construct second IV */ \
 	vmovdqu (iv), tivx; \
 	vmovdqa tivx, t0x; \
 	gf128mul_x_ble(tivx, t1x, t2x); \
-	vbroadcasti128 xts_gf128mul_and_shl1_mask_1, t2; \
+	vbroadcasti128 xts_gf128mul_and_shl1_mask_1(%rip), t2; \
 	vinserti128 $1, tivx, t0, tiv; \
 	vpxor (0*32)(src), tiv, x0; \
 	vmovdqu tiv, (0*32)(dst); \
diff --git a/arch/x86/crypto/morus1280-avx2-asm.S b/arch/x86/crypto/morus1280-avx2-asm.S
index 5413fee33481..343889de1736 100644
--- a/arch/x86/crypto/morus1280-avx2-asm.S
+++ b/arch/x86/crypto/morus1280-avx2-asm.S
@@ -255,7 +255,7 @@ ENTRY(crypto_morus1280_avx2_init)
 	/* load all zeros: */
 	vpxor STATE3, STATE3, STATE3
 	/* load the constant: */
-	vmovdqa .Lmorus1280_const, STATE4
+	vmovdqa .Lmorus1280_const(%rip), STATE4
 
 	/* update 16 times with zero: */
 	call __morus1280_update_zero
@@ -552,7 +552,7 @@ ENTRY(crypto_morus1280_avx2_dec_tail)
 	/* mask with byte count: */
 	movq %rcx, T0_LOW
 	vpbroadcastb T0_LOW, T0
-	vmovdqa .Lmorus1280_counter, T1
+	vmovdqa .Lmorus1280_counter(%rip), T1
 	vpcmpgtb T1, T0, T0
 	vpand T0, MSG, MSG
 
diff --git a/arch/x86/crypto/morus1280-sse2-asm.S b/arch/x86/crypto/morus1280-sse2-asm.S
index 0eece772866b..691da9fcfbea 100644
--- a/arch/x86/crypto/morus1280-sse2-asm.S
+++ b/arch/x86/crypto/morus1280-sse2-asm.S
@@ -384,8 +384,8 @@ ENTRY(crypto_morus1280_sse2_init)
 	pxor STATE3_LO, STATE3_LO
 	pxor STATE3_HI, STATE3_HI
 	/* load the constant: */
-	movdqa .Lmorus640_const_0, STATE4_LO
-	movdqa .Lmorus640_const_1, STATE4_HI
+	movdqa .Lmorus640_const_0(%rip), STATE4_LO
+	movdqa .Lmorus640_const_1(%rip), STATE4_HI
 
 	/* update 16 times with zero: */
 	call __morus1280_update_zero
@@ -799,8 +799,8 @@ ENTRY(crypto_morus1280_sse2_dec_tail)
 	punpcklbw T0_LO, T0_LO
 	punpcklbw T0_LO, T0_LO
 	movdqa T0_LO, T0_HI
-	movdqa .Lmorus640_counter_0, T1_LO
-	movdqa .Lmorus640_counter_1, T1_HI
+	movdqa .Lmorus640_counter_0(%rip), T1_LO
+	movdqa .Lmorus640_counter_1(%rip), T1_HI
 	pcmpgtb T1_LO, T0_LO
 	pcmpgtb T1_HI, T0_HI
 	pand T0_LO, MSG_LO
diff --git a/arch/x86/crypto/morus640-sse2-asm.S b/arch/x86/crypto/morus640-sse2-asm.S
index a60891101bbd..937f02f92a10 100644
--- a/arch/x86/crypto/morus640-sse2-asm.S
+++ b/arch/x86/crypto/morus640-sse2-asm.S
@@ -235,8 +235,8 @@ ENTRY(crypto_morus640_sse2_init)
 	/* load all ones: */
 	pcmpeqd STATE2, STATE2
 	/* load the constants: */
-	movdqa .Lmorus640_const_0, STATE3
-	movdqa .Lmorus640_const_1, STATE4
+	movdqa .Lmorus640_const_0(%rip), STATE3
+	movdqa .Lmorus640_const_1(%rip), STATE4
 
 	/* update 16 times with zero: */
 	call __morus640_update_zero
@@ -542,7 +542,7 @@ ENTRY(crypto_morus640_sse2_dec_tail)
 	punpcklbw T0, T0
 	punpcklbw T0, T0
 	punpcklbw T0, T0
-	movdqa .Lmorus640_counter, T1
+	movdqa .Lmorus640_counter(%rip), T1
 	pcmpgtb T1, T0
 	pand T0, MSG
 
diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
index 1420db15dcdd..e7730d93cceb 100644
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/crypto/sha256-avx2-asm.S
@@ -592,19 +592,23 @@ last_block_enter:
 
 .align 16
 loop1:
-	vpaddd	K256+0*32(SRND), X0, XFER
+	leaq	K256(%rip), INP
+	vpaddd	0*32(INP, SRND), X0, XFER
 	vmovdqa XFER, 0*32+_XFER(%rsp, SRND)
 	FOUR_ROUNDS_AND_SCHED	_XFER + 0*32
 
-	vpaddd	K256+1*32(SRND), X0, XFER
+	leaq	K256(%rip), INP
+	vpaddd	1*32(INP, SRND), X0, XFER
 	vmovdqa XFER, 1*32+_XFER(%rsp, SRND)
 	FOUR_ROUNDS_AND_SCHED	_XFER + 1*32
 
-	vpaddd	K256+2*32(SRND), X0, XFER
+	leaq	K256(%rip), INP
+	vpaddd	2*32(INP, SRND), X0, XFER
 	vmovdqa XFER, 2*32+_XFER(%rsp, SRND)
 	FOUR_ROUNDS_AND_SCHED	_XFER + 2*32
 
-	vpaddd	K256+3*32(SRND), X0, XFER
+	leaq	K256(%rip), INP
+	vpaddd	3*32(INP, SRND), X0, XFER
 	vmovdqa XFER, 3*32+_XFER(%rsp, SRND)
 	FOUR_ROUNDS_AND_SCHED	_XFER + 3*32
 
@@ -614,11 +618,13 @@ loop1:
 
 loop2:
 	## Do last 16 rounds with no scheduling
-	vpaddd	K256+0*32(SRND), X0, XFER
+	leaq	K256(%rip), INP
+	vpaddd	0*32(INP, SRND), X0, XFER
 	vmovdqa XFER, 0*32+_XFER(%rsp, SRND)
 	DO_4ROUNDS	_XFER + 0*32
 
-	vpaddd	K256+1*32(SRND), X1, XFER
+	leaq	K256(%rip), INP
+	vpaddd	1*32(INP, SRND), X1, XFER
 	vmovdqa XFER, 1*32+_XFER(%rsp, SRND)
 	DO_4ROUNDS	_XFER + 1*32
 	add	$2*32, SRND
-- 
2.22.0.410.gd8fdbe21b5-goog

