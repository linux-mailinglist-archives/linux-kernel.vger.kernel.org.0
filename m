Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCBDD113871
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 01:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfLEAKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 19:10:12 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38752 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfLEAKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:10:11 -0500
Received: by mail-pl1-f195.google.com with SMTP id o8so428202pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 16:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ifKYNdiEt5/5Ah/qzUz/7gUPOxalv86PxbaBtLSs0wk=;
        b=UeX8H4BKzkEDLpmq4lkBn0Q1BjgVg1ZNEGLBI+Rn8NOxsXhkrc/Q72cEBLAyexytgi
         mmbU5sSzXk5a41BuVAhms8Z+mqdXBKHQUVvWy/rPxFBhbcGm934CA4VRR2GkPR9P0PN1
         jrfzCcFPmvee6dSkVJLtoWCLCM0tQUmsZAh/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ifKYNdiEt5/5Ah/qzUz/7gUPOxalv86PxbaBtLSs0wk=;
        b=cE7ei4iojqLYs8MSlMTTxrsoVYy36UgsshQsTtw7qoRelKlOsrQv6z35CWwMaQQtpu
         lSywAAB2t/ekYV0jWtcOmxgpoKdQtjpL6s1GNsY8ZVs4pfbzi3D7QMgCdlLzv5FgxmKU
         Tck9IGCgiCBHdmNfoEXS4Olm6+cZuBUCkACxLvvsjwwNKb74PZw51IIP4k9UyEVrtykh
         fIVqYZoh5P51Tru6qK4OKKUevxHkuua+88kVs3uQ8E1Fcq0G0AMjGx0Kp31J84D3YkiI
         7pDaISu4TSKxQ8BEHHoQDVm+OoTjfLKtexPd/v76Rysm53Vct8dSyfqixUO1FiDWkl2D
         LHjg==
X-Gm-Message-State: APjAAAXKmhS9TciZnRp36JNMnEzuDV50/KIyDAB04qWyqRZMSa8kw1HB
        LromxuPU/KPlZYJjFI5DDGvYSg==
X-Google-Smtp-Source: APXvYqxt0OcjAnaSP8Ue8ck6KDHj3XMPMu/i7T9WuDiwrqFh+GtCVKRi8csOGWIsQb+Gueu5uWS59g==
X-Received: by 2002:a17:90a:4e5:: with SMTP id g92mr6175659pjg.94.1575504610326;
        Wed, 04 Dec 2019 16:10:10 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:d6ba:ac27:4f7b:28d7])
        by smtp.gmail.com with ESMTPSA id 73sm8422303pgc.13.2019.12.04.16.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 16:10:09 -0800 (PST)
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
Subject: [PATCH v10 01/11] x86/crypto: Adapt assembly for PIE support
Date:   Wed,  4 Dec 2019 16:09:38 -0800
Message-Id: <20191205000957.112719-2-thgarnie@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
In-Reply-To: <20191205000957.112719-1-thgarnie@chromium.org>
References: <20191205000957.112719-1-thgarnie@chromium.org>
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
 arch/x86/crypto/sha256-avx2-asm.S            | 18 ++--
 13 files changed, 191 insertions(+), 142 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis128-aesni-asm.S
index 51d46d93efbc..c4bd32d8ca43 100644
--- a/arch/x86/crypto/aegis128-aesni-asm.S
+++ b/arch/x86/crypto/aegis128-aesni-asm.S
@@ -200,8 +200,8 @@ SYM_FUNC_START(crypto_aegis128_aesni_init)
 	movdqa KEY, STATE4
 
 	/* load the constants: */
-	movdqa .Laegis128_const_0, STATE2
-	movdqa .Laegis128_const_1, STATE1
+	movdqa .Laegis128_const_0(%rip), STATE2
+	movdqa .Laegis128_const_1(%rip), STATE1
 	pxor STATE2, STATE3
 	pxor STATE1, STATE4
 
@@ -681,7 +681,7 @@ SYM_FUNC_START(crypto_aegis128_aesni_dec_tail)
 	punpcklbw T0, T0
 	punpcklbw T0, T0
 	punpcklbw T0, T0
-	movdqa .Laegis128_counter, T1
+	movdqa .Laegis128_counter(%rip), T1
 	pcmpgtb T1, T0
 	pand T0, MSG
 
diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index d28503f99f58..2b8d501493c2 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -2597,7 +2597,7 @@ SYM_FUNC_END(aesni_cbc_dec)
  *	BSWAP_MASK == endian swapping mask
  */
 SYM_FUNC_START_LOCAL(_aesni_inc_init)
-	movaps .Lbswap_mask, BSWAP_MASK
+	movaps .Lbswap_mask(%rip), BSWAP_MASK
 	movaps IV, CTR
 	PSHUFB_XMM BSWAP_MASK CTR
 	mov $1, TCTR_LOW
@@ -2724,12 +2724,12 @@ SYM_FUNC_START(aesni_xts_crypt8)
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
index bfa1c0b3e5b4..838221507976 100644
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
index d01ddd73de65..8a203c507f81 100644
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
@@ -444,7 +444,7 @@ SYM_FUNC_END(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	transpose_4x4(c0, c1, c2, c3, a0, a1); \
 	transpose_4x4(d0, d1, d2, d3, a0, a1); \
 	\
-	vmovdqu .Lshufb_16x16b, a0; \
+	vmovdqu .Lshufb_16x16b(%rip), a0; \
 	vmovdqu st1, a1; \
 	vpshufb a0, a2, a2; \
 	vpshufb a0, a3, a3; \
@@ -483,7 +483,7 @@ SYM_FUNC_END(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 #define inpack16_pre(x0, x1, x2, x3, x4, x5, x6, x7, y0, y1, y2, y3, y4, y5, \
 		     y6, y7, rio, key) \
 	vmovq key, x0; \
-	vpshufb .Lpack_bswap, x0, x0; \
+	vpshufb .Lpack_bswap(%rip), x0, x0; \
 	\
 	vpxor 0 * 16(rio), x0, y7; \
 	vpxor 1 * 16(rio), x0, y6; \
@@ -534,7 +534,7 @@ SYM_FUNC_END(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	vmovdqu x0, stack_tmp0; \
 	\
 	vmovq key, x0; \
-	vpshufb .Lpack_bswap, x0, x0; \
+	vpshufb .Lpack_bswap(%rip), x0, x0; \
 	\
 	vpxor x0, y7, y7; \
 	vpxor x0, y6, y6; \
@@ -1017,7 +1017,7 @@ SYM_FUNC_START(camellia_ctr_16way)
 	subq $(16 * 16), %rsp;
 	movq %rsp, %rax;
 
-	vmovdqa .Lbswap128_mask, %xmm14;
+	vmovdqa .Lbswap128_mask(%rip), %xmm14;
 
 	/* load IV and byteswap */
 	vmovdqu (%rcx), %xmm0;
@@ -1066,7 +1066,7 @@ SYM_FUNC_START(camellia_ctr_16way)
 
 	/* inpack16_pre: */
 	vmovq (key_table)(CTX), %xmm15;
-	vpshufb .Lpack_bswap, %xmm15, %xmm15;
+	vpshufb .Lpack_bswap(%rip), %xmm15, %xmm15;
 	vpxor %xmm0, %xmm15, %xmm0;
 	vpxor %xmm1, %xmm15, %xmm1;
 	vpxor %xmm2, %xmm15, %xmm2;
@@ -1134,7 +1134,7 @@ SYM_FUNC_START_LOCAL(camellia_xts_crypt_16way)
 	subq $(16 * 16), %rsp;
 	movq %rsp, %rax;
 
-	vmovdqa .Lxts_gf128mul_and_shl1_mask, %xmm14;
+	vmovdqa .Lxts_gf128mul_and_shl1_mask(%rip), %xmm14;
 
 	/* load IV */
 	vmovdqu (%rcx), %xmm0;
@@ -1210,7 +1210,7 @@ SYM_FUNC_START_LOCAL(camellia_xts_crypt_16way)
 
 	/* inpack16_pre: */
 	vmovq (key_table)(CTX, %r8, 8), %xmm15;
-	vpshufb .Lpack_bswap, %xmm15, %xmm15;
+	vpshufb .Lpack_bswap(%rip), %xmm15, %xmm15;
 	vpxor 0 * 16(%rax), %xmm15, %xmm0;
 	vpxor %xmm1, %xmm15, %xmm1;
 	vpxor %xmm2, %xmm15, %xmm2;
@@ -1265,7 +1265,7 @@ SYM_FUNC_START(camellia_xts_enc_16way)
 	 */
 	xorl %r8d, %r8d; /* input whitening key, 0 for enc */
 
-	leaq __camellia_enc_blk16, %r9;
+	leaq __camellia_enc_blk16(%rip), %r9;
 
 	jmp camellia_xts_crypt_16way;
 SYM_FUNC_END(camellia_xts_enc_16way)
@@ -1283,7 +1283,7 @@ SYM_FUNC_START(camellia_xts_dec_16way)
 	movl $24, %eax;
 	cmovel %eax, %r8d;  /* input whitening key, last for dec */
 
-	leaq __camellia_dec_blk16, %r9;
+	leaq __camellia_dec_blk16(%rip), %r9;
 
 	jmp camellia_xts_crypt_16way;
 SYM_FUNC_END(camellia_xts_dec_16way)
diff --git a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
index 563ef6e83cdd..d7f4cd4b1702 100644
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
@@ -478,7 +478,7 @@ SYM_FUNC_END(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	transpose_4x4(c0, c1, c2, c3, a0, a1); \
 	transpose_4x4(d0, d1, d2, d3, a0, a1); \
 	\
-	vbroadcasti128 .Lshufb_16x16b, a0; \
+	vbroadcasti128 .Lshufb_16x16b(%rip), a0; \
 	vmovdqu st1, a1; \
 	vpshufb a0, a2, a2; \
 	vpshufb a0, a3, a3; \
@@ -517,7 +517,7 @@ SYM_FUNC_END(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 #define inpack32_pre(x0, x1, x2, x3, x4, x5, x6, x7, y0, y1, y2, y3, y4, y5, \
 		     y6, y7, rio, key) \
 	vpbroadcastq key, x0; \
-	vpshufb .Lpack_bswap, x0, x0; \
+	vpshufb .Lpack_bswap(%rip), x0, x0; \
 	\
 	vpxor 0 * 32(rio), x0, y7; \
 	vpxor 1 * 32(rio), x0, y6; \
@@ -568,7 +568,7 @@ SYM_FUNC_END(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	vmovdqu x0, stack_tmp0; \
 	\
 	vpbroadcastq key, x0; \
-	vpshufb .Lpack_bswap, x0, x0; \
+	vpshufb .Lpack_bswap(%rip), x0, x0; \
 	\
 	vpxor x0, y7, y7; \
 	vpxor x0, y6, y6; \
@@ -1108,7 +1108,7 @@ SYM_FUNC_START(camellia_ctr_32way)
 	vmovdqu (%rcx), %xmm0;
 	vmovdqa %xmm0, %xmm1;
 	inc_le128(%xmm0, %xmm15, %xmm14);
-	vbroadcasti128 .Lbswap128_mask, %ymm14;
+	vbroadcasti128 .Lbswap128_mask(%rip), %ymm14;
 	vinserti128 $1, %xmm0, %ymm1, %ymm0;
 	vpshufb %ymm14, %ymm0, %ymm13;
 	vmovdqu %ymm13, 15 * 32(%rax);
@@ -1154,7 +1154,7 @@ SYM_FUNC_START(camellia_ctr_32way)
 
 	/* inpack32_pre: */
 	vpbroadcastq (key_table)(CTX), %ymm15;
-	vpshufb .Lpack_bswap, %ymm15, %ymm15;
+	vpshufb .Lpack_bswap(%rip), %ymm15, %ymm15;
 	vpxor %ymm0, %ymm15, %ymm0;
 	vpxor %ymm1, %ymm15, %ymm1;
 	vpxor %ymm2, %ymm15, %ymm2;
@@ -1238,13 +1238,13 @@ SYM_FUNC_START_LOCAL(camellia_xts_crypt_32way)
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
@@ -1321,7 +1321,7 @@ SYM_FUNC_START_LOCAL(camellia_xts_crypt_32way)
 
 	/* inpack32_pre: */
 	vpbroadcastq (key_table)(CTX, %r8, 8), %ymm15;
-	vpshufb .Lpack_bswap, %ymm15, %ymm15;
+	vpshufb .Lpack_bswap(%rip), %ymm15, %ymm15;
 	vpxor 0 * 32(%rax), %ymm15, %ymm0;
 	vpxor %ymm1, %ymm15, %ymm1;
 	vpxor %ymm2, %ymm15, %ymm2;
@@ -1379,7 +1379,7 @@ SYM_FUNC_START(camellia_xts_enc_32way)
 
 	xorl %r8d, %r8d; /* input whitening key, 0 for enc */
 
-	leaq __camellia_enc_blk32, %r9;
+	leaq __camellia_enc_blk32(%rip), %r9;
 
 	jmp camellia_xts_crypt_32way;
 SYM_FUNC_END(camellia_xts_enc_32way)
@@ -1397,7 +1397,7 @@ SYM_FUNC_START(camellia_xts_dec_32way)
 	movl $24, %eax;
 	cmovel %eax, %r8d;  /* input whitening key, last for dec */
 
-	leaq __camellia_dec_blk32, %r9;
+	leaq __camellia_dec_blk32(%rip), %r9;
 
 	jmp camellia_xts_crypt_32way;
 SYM_FUNC_END(camellia_xts_dec_32way)
diff --git a/arch/x86/crypto/camellia-x86_64-asm_64.S b/arch/x86/crypto/camellia-x86_64-asm_64.S
index 1372e6408850..3a4e5cca583a 100644
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
index 8a6181b08b59..ffa9ed5f096b 100644
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
@@ -236,9 +240,9 @@ SYM_FUNC_START_LOCAL(__cast5_enc_blk16)
 
 	movq %rdi, CTX;
 
-	vmovdqa .Lbswap_mask, RKM;
-	vmovd .Lfirst_mask, R1ST;
-	vmovd .L32_mask, R32;
+	vmovdqa .Lbswap_mask(%rip), RKM;
+	vmovd .Lfirst_mask(%rip), R1ST;
+	vmovd .L32_mask(%rip), R32;
 	enc_preload_rkr();
 
 	inpack_blocks(RL1, RR1, RTMP, RX, RKM);
@@ -272,7 +276,7 @@ SYM_FUNC_START_LOCAL(__cast5_enc_blk16)
 	popq %rbx;
 	popq %r15;
 
-	vmovdqa .Lbswap_mask, RKM;
+	vmovdqa .Lbswap_mask(%rip), RKM;
 
 	outunpack_blocks(RR1, RL1, RTMP, RX, RKM);
 	outunpack_blocks(RR2, RL2, RTMP, RX, RKM);
@@ -310,9 +314,9 @@ SYM_FUNC_START_LOCAL(__cast5_dec_blk16)
 
 	movq %rdi, CTX;
 
-	vmovdqa .Lbswap_mask, RKM;
-	vmovd .Lfirst_mask, R1ST;
-	vmovd .L32_mask, R32;
+	vmovdqa .Lbswap_mask(%rip), RKM;
+	vmovd .Lfirst_mask(%rip), R1ST;
+	vmovd .L32_mask(%rip), R32;
 	dec_preload_rkr();
 
 	inpack_blocks(RL1, RR1, RTMP, RX, RKM);
@@ -343,7 +347,7 @@ SYM_FUNC_START_LOCAL(__cast5_dec_blk16)
 	round(RL, RR, 1, 2);
 	round(RR, RL, 0, 1);
 
-	vmovdqa .Lbswap_mask, RKM;
+	vmovdqa .Lbswap_mask(%rip), RKM;
 	popq %rbx;
 	popq %r15;
 
@@ -506,8 +510,8 @@ SYM_FUNC_START(cast5_ctr_16way)
 
 	vpcmpeqd RKR, RKR, RKR;
 	vpaddq RKR, RKR, RKR; /* low: -2, high: -2 */
-	vmovdqa .Lbswap_iv_mask, R1ST;
-	vmovdqa .Lbswap128_mask, RKM;
+	vmovdqa .Lbswap_iv_mask(%rip), R1ST;
+	vmovdqa .Lbswap128_mask(%rip), RKM;
 
 	/* load IV and byteswap */
 	vmovq (%rcx), RX;
diff --git a/arch/x86/crypto/cast6-avx-x86_64-asm_64.S b/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
index 932a3ce32a88..c46a61411f98 100644
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
@@ -260,9 +264,9 @@ SYM_FUNC_START_LOCAL(__cast6_enc_blk8)
 
 	movq %rdi, CTX;
 
-	vmovdqa .Lbswap_mask, RKM;
-	vmovd .Lfirst_mask, R1ST;
-	vmovd .L32_mask, R32;
+	vmovdqa .Lbswap_mask(%rip), RKM;
+	vmovd .Lfirst_mask(%rip), R1ST;
+	vmovd .L32_mask(%rip), R32;
 
 	inpack_blocks(RA1, RB1, RC1, RD1, RTMP, RX, RKRF, RKM);
 	inpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
@@ -286,7 +290,7 @@ SYM_FUNC_START_LOCAL(__cast6_enc_blk8)
 	popq %rbx;
 	popq %r15;
 
-	vmovdqa .Lbswap_mask, RKM;
+	vmovdqa .Lbswap_mask(%rip), RKM;
 
 	outunpack_blocks(RA1, RB1, RC1, RD1, RTMP, RX, RKRF, RKM);
 	outunpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
@@ -308,9 +312,9 @@ SYM_FUNC_START_LOCAL(__cast6_dec_blk8)
 
 	movq %rdi, CTX;
 
-	vmovdqa .Lbswap_mask, RKM;
-	vmovd .Lfirst_mask, R1ST;
-	vmovd .L32_mask, R32;
+	vmovdqa .Lbswap_mask(%rip), RKM;
+	vmovd .Lfirst_mask(%rip), R1ST;
+	vmovd .L32_mask(%rip), R32;
 
 	inpack_blocks(RA1, RB1, RC1, RD1, RTMP, RX, RKRF, RKM);
 	inpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
@@ -334,7 +338,7 @@ SYM_FUNC_START_LOCAL(__cast6_dec_blk8)
 	popq %rbx;
 	popq %r15;
 
-	vmovdqa .Lbswap_mask, RKM;
+	vmovdqa .Lbswap_mask(%rip), RKM;
 	outunpack_blocks(RA1, RB1, RC1, RD1, RTMP, RX, RKRF, RKM);
 	outunpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
 
diff --git a/arch/x86/crypto/des3_ede-asm_64.S b/arch/x86/crypto/des3_ede-asm_64.S
index fac0fdc3f25d..c841de5fe065 100644
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
@@ -355,65 +363,89 @@ SYM_FUNC_END(des3_ede_x86_64_crypt_blk)
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
index bb9735fbb865..59717ade66d7 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_asm.S
+++ b/arch/x86/crypto/ghash-clmulni-intel_asm.S
@@ -94,7 +94,7 @@ SYM_FUNC_START(clmul_ghash_mul)
 	FRAME_BEGIN
 	movups (%rdi), DATA
 	movups (%rsi), SHASH
-	movaps .Lbswap_mask, BSWAP
+	movaps .Lbswap_mask(%rip), BSWAP
 	PSHUFB_XMM BSWAP DATA
 	call __clmul_gf128mul_ble
 	PSHUFB_XMM BSWAP DATA
@@ -111,7 +111,7 @@ SYM_FUNC_START(clmul_ghash_update)
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
diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
index 519b551ad576..c516f61bb8d9 100644
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
2.24.0.393.g34dc348eaf-goog

