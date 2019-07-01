Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037122441E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 01:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfETXUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 19:20:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38057 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfETXUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:20:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so7517384pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wXGMNHI6fdEuu7cAnb4kzfrK+voADzn8tnraXP22HXQ=;
        b=X3/pe1npbs1dxP4M4KB36cV1pymjFraKcnQcHnBBg/20h81LmuifbZS5L7oC0E7uyZ
         giJsmZ5N/dKsCpt0wv/t4PmReRPgrNzPtVr3Z2nyUITAw90sNcPWg0YjpD5JKQ4oFbbl
         NIWOtwAqMAHjfmWb7/39PTKST+KSZxybPNRhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wXGMNHI6fdEuu7cAnb4kzfrK+voADzn8tnraXP22HXQ=;
        b=Mx5JmiZXgCGZ3KGc2roCjLEKNefrL61pRfxVmAvxtxfiOA5NxK9+sLrlJNHkybfAaY
         spj0oX1GyoRGqQxe0dDVjRRtGwVZZ1ETM396v158yCebEkNguBAcWXX2A2Ab526zl+lR
         rz4BXhQTLGnMkLEJx5hAtL5iL0EjLsbR12ON5iTvbMPj6JUx+yqjPaH+gW+vO5akVR7n
         aUhgSuaT40pwGNiOIX+yRpjl9ont/83AkqKlgq1zk4OLw1H6t6pzBXstoQBUqntefWtE
         XM3Sykk1hVNMQtD1GR2gnMlVFUGfSM4lcydLvGDWW9EPQjZnePm3lQdHli4nu1k3Z3Py
         rgVA==
X-Gm-Message-State: APjAAAV9/5kK7C6Sh6DvrBvy1Yzu7H67Dy0Pe7OrvVErr00GsSSnjII6
        Zy7f06iOJIPKuHsxkOBgiMIhig==
X-Google-Smtp-Source: APXvYqxKzawUECI2ObsaSrMe2Sa0YOvv6LdLd5va1ukCNk/Pui37iggy6tAcl598PtMBUfL7SWos3g==
X-Received: by 2002:a62:1a0f:: with SMTP id a15mr63208232pfa.111.1558394402924;
        Mon, 20 May 2019 16:20:02 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id h13sm19350861pgk.55.2019.05.20.16.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 16:20:02 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 01/12] x86/crypto: Adapt assembly for PIE support
Date:   Mon, 20 May 2019 16:19:26 -0700
Message-Id: <20190520231948.49693-2-thgarnie@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190520231948.49693-1-thgarnie@chromium.org>
References: <20190520231948.49693-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Garnier <thgarnie@google.com>

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/crypto/aegis128-aesni-asm.S         |  6 +-
 arch/x86/crypto/aegis128l-aesni-asm.S        |  8 +-
 arch/x86/crypto/aegis256-aesni-asm.S         |  6 +-
 arch/x86/crypto/aes-x86_64-asm_64.S          | 45 +++++----
 arch/x86/crypto/aesni-intel_asm.S            |  8 +-
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
 arch/x86/crypto/sha256-avx2-asm.S            | 23 +++--
 18 files changed, 236 insertions(+), 176 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis128-aesni-asm.S
index 5f7e43d4f64a..a48f790954f8 100644
--- a/arch/x86/crypto/aegis128-aesni-asm.S
+++ b/arch/x86/crypto/aegis128-aesni-asm.S
@@ -203,8 +203,8 @@ ENTRY(crypto_aegis128_aesni_init)
 	movdqa KEY, STATE4
 
 	/* load the constants: */
-	movdqa .Laegis128_const_0, STATE2
-	movdqa .Laegis128_const_1, STATE1
+	movdqa .Laegis128_const_0(%rip), STATE2
+	movdqa .Laegis128_const_1(%rip), STATE1
 	pxor STATE2, STATE3
 	pxor STATE1, STATE4
 
@@ -684,7 +684,7 @@ ENTRY(crypto_aegis128_aesni_dec_tail)
 	punpcklbw T0, T0
 	punpcklbw T0, T0
 	punpcklbw T0, T0
-	movdqa .Laegis128_counter, T1
+	movdqa .Laegis128_counter(%rip), T1
 	pcmpgtb T1, T0
 	pand T0, MSG
 
diff --git a/arch/x86/crypto/aegis128l-aesni-asm.S b/arch/x86/crypto/aegis128l-aesni-asm.S
index 491dd61c845c..a097b8956af8 100644
--- a/arch/x86/crypto/aegis128l-aesni-asm.S
+++ b/arch/x86/crypto/aegis128l-aesni-asm.S
@@ -331,8 +331,8 @@ ENTRY(crypto_aegis128l_aesni_init)
 	pxor MSG0, STATE4
 
 	/* load the constants: */
-	movdqa .Laegis128l_const_0, STATE2
-	movdqa .Laegis128l_const_1, STATE1
+	movdqa .Laegis128l_const_0(%rip), STATE2
+	movdqa .Laegis128l_const_1(%rip), STATE1
 	movdqa STATE1, STATE3
 	pxor STATE2, STATE5
 	pxor STATE1, STATE6
@@ -765,8 +765,8 @@ ENTRY(crypto_aegis128l_aesni_dec_tail)
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
index 8870c7c5d9a4..195648b93fd1 100644
--- a/arch/x86/crypto/aegis256-aesni-asm.S
+++ b/arch/x86/crypto/aegis256-aesni-asm.S
@@ -273,8 +273,8 @@ ENTRY(crypto_aegis256_aesni_init)
 	movdqa T3, STATE1
 
 	/* load the constants: */
-	movdqa .Laegis256_const_0, STATE3
-	movdqa .Laegis256_const_1, STATE2
+	movdqa .Laegis256_const_0(%rip), STATE3
+	movdqa .Laegis256_const_1(%rip), STATE2
 	pxor STATE3, STATE4
 	pxor STATE2, STATE5
 
@@ -647,7 +647,7 @@ ENTRY(crypto_aegis256_aesni_dec_tail)
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
index cb2deb61c5d9..8be8cef8263a 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -2610,7 +2610,7 @@ ENDPROC(aesni_cbc_dec)
  */
 .align 4
 _aesni_inc_init:
-	movaps .Lbswap_mask, BSWAP_MASK
+	movaps .Lbswap_mask(%rip), BSWAP_MASK
 	movaps IV, CTR
 	PSHUFB_XMM BSWAP_MASK CTR
 	mov $1, TCTR_LOW
@@ -2738,12 +2738,12 @@ ENTRY(aesni_xts_crypt8)
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
index b66bbfa62f50..11bbaa1cd4a7 100644
--- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
@@ -70,12 +70,12 @@
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
@@ -121,8 +121,8 @@
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
@@ -137,16 +137,16 @@
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
@@ -483,7 +483,7 @@ ENDPROC(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	transpose_4x4(c0, c1, c2, c3, a0, a1); \
 	transpose_4x4(d0, d1, d2, d3, a0, a1); \
 	\
-	vbroadcasti128 .Lshufb_16x16b, a0; \
+	vbroadcasti128 .Lshufb_16x16b(%rip), a0; \
 	vmovdqu st1, a1; \
 	vpshufb a0, a2, a2; \
 	vpshufb a0, a3, a3; \
@@ -522,7 +522,7 @@ ENDPROC(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 #define inpack32_pre(x0, x1, x2, x3, x4, x5, x6, x7, y0, y1, y2, y3, y4, y5, \
 		     y6, y7, rio, key) \
 	vpbroadcastq key, x0; \
-	vpshufb .Lpack_bswap, x0, x0; \
+	vpshufb .Lpack_bswap(%rip), x0, x0; \
 	\
 	vpxor 0 * 32(rio), x0, y7; \
 	vpxor 1 * 32(rio), x0, y6; \
@@ -573,7 +573,7 @@ ENDPROC(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	vmovdqu x0, stack_tmp0; \
 	\
 	vpbroadcastq key, x0; \
-	vpshufb .Lpack_bswap, x0, x0; \
+	vpshufb .Lpack_bswap(%rip), x0, x0; \
 	\
 	vpxor x0, y7, y7; \
 	vpxor x0, y6, y6; \
@@ -1113,7 +1113,7 @@ ENTRY(camellia_ctr_32way)
 	vmovdqu (%rcx), %xmm0;
 	vmovdqa %xmm0, %xmm1;
 	inc_le128(%xmm0, %xmm15, %xmm14);
-	vbroadcasti128 .Lbswap128_mask, %ymm14;
+	vbroadcasti128 .Lbswap128_mask(%rip), %ymm14;
 	vinserti128 $1, %xmm0, %ymm1, %ymm0;
 	vpshufb %ymm14, %ymm0, %ymm13;
 	vmovdqu %ymm13, 15 * 32(%rax);
@@ -1159,7 +1159,7 @@ ENTRY(camellia_ctr_32way)
 
 	/* inpack32_pre: */
 	vpbroadcastq (key_table)(CTX), %ymm15;
-	vpshufb .Lpack_bswap, %ymm15, %ymm15;
+	vpshufb .Lpack_bswap(%rip), %ymm15, %ymm15;
 	vpxor %ymm0, %ymm15, %ymm0;
 	vpxor %ymm1, %ymm15, %ymm1;
 	vpxor %ymm2, %ymm15, %ymm2;
@@ -1243,13 +1243,13 @@ camellia_xts_crypt_32way:
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
@@ -1326,7 +1326,7 @@ camellia_xts_crypt_32way:
 
 	/* inpack32_pre: */
 	vpbroadcastq (key_table)(CTX, %r8, 8), %ymm15;
-	vpshufb .Lpack_bswap, %ymm15, %ymm15;
+	vpshufb .Lpack_bswap(%rip), %ymm15, %ymm15;
 	vpxor 0 * 32(%rax), %ymm15, %ymm0;
 	vpxor %ymm1, %ymm15, %ymm1;
 	vpxor %ymm2, %ymm15, %ymm2;
@@ -1384,7 +1384,7 @@ ENTRY(camellia_xts_enc_32way)
 
 	xorl %r8d, %r8d; /* input whitening key, 0 for enc */
 
-	leaq __camellia_enc_blk32, %r9;
+	leaq __camellia_enc_blk32(%rip), %r9;
 
 	jmp camellia_xts_crypt_32way;
 ENDPROC(camellia_xts_enc_32way)
@@ -1402,7 +1402,7 @@ ENTRY(camellia_xts_dec_32way)
 	movl $24, %eax;
 	cmovel %eax, %r8d;  /* input whitening key, last for dec */
 
-	leaq __camellia_dec_blk32, %r9;
+	leaq __camellia_dec_blk32(%rip), %r9;
 
 	jmp camellia_xts_crypt_32way;
 ENDPROC(camellia_xts_dec_32way)
diff --git a/arch/x86/crypto/camellia-x86_64-asm_64.S b/arch/x86/crypto/camellia-x86_64-asm_64.S
index 95ba6956a7f6..ef1137406959 100644
--- a/arch/x86/crypto/camellia-x86_64-asm_64.S
+++ b/arch/x86/crypto/camellia-x86_64-asm_64.S
@@ -92,11 +92,13 @@
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
index 86107c961bb4..64eb5c87d04a 100644
--- a/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
@@ -98,16 +98,20 @@
 
 
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
 
@@ -166,15 +170,15 @@
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
@@ -251,9 +255,9 @@ __cast5_enc_blk16:
 
 	movq %rdi, CTX;
 
-	vmovdqa .Lbswap_mask, RKM;
-	vmovd .Lfirst_mask, R1ST;
-	vmovd .L32_mask, R32;
+	vmovdqa .Lbswap_mask(%rip), RKM;
+	vmovd .Lfirst_mask(%rip), R1ST;
+	vmovd .L32_mask(%rip), R32;
 	enc_preload_rkr();
 
 	inpack_blocks(RL1, RR1, RTMP, RX, RKM);
@@ -287,7 +291,7 @@ __cast5_enc_blk16:
 	popq %rbx;
 	popq %r15;
 
-	vmovdqa .Lbswap_mask, RKM;
+	vmovdqa .Lbswap_mask(%rip), RKM;
 
 	outunpack_blocks(RR1, RL1, RTMP, RX, RKM);
 	outunpack_blocks(RR2, RL2, RTMP, RX, RKM);
@@ -325,9 +329,9 @@ __cast5_dec_blk16:
 
 	movq %rdi, CTX;
 
-	vmovdqa .Lbswap_mask, RKM;
-	vmovd .Lfirst_mask, R1ST;
-	vmovd .L32_mask, R32;
+	vmovdqa .Lbswap_mask(%rip), RKM;
+	vmovd .Lfirst_mask(%rip), R1ST;
+	vmovd .L32_mask(%rip), R32;
 	dec_preload_rkr();
 
 	inpack_blocks(RL1, RR1, RTMP, RX, RKM);
@@ -358,7 +362,7 @@ __cast5_dec_blk16:
 	round(RL, RR, 1, 2);
 	round(RR, RL, 0, 1);
 
-	vmovdqa .Lbswap_mask, RKM;
+	vmovdqa .Lbswap_mask(%rip), RKM;
 	popq %rbx;
 	popq %r15;
 
@@ -521,8 +525,8 @@ ENTRY(cast5_ctr_16way)
 
 	vpcmpeqd RKR, RKR, RKR;
 	vpaddq RKR, RKR, RKR; /* low: -2, high: -2 */
-	vmovdqa .Lbswap_iv_mask, R1ST;
-	vmovdqa .Lbswap128_mask, RKM;
+	vmovdqa .Lbswap_iv_mask(%rip), R1ST;
+	vmovdqa .Lbswap128_mask(%rip), RKM;
 
 	/* load IV and byteswap */
 	vmovq (%rcx), RX;
diff --git a/arch/x86/crypto/cast6-avx-x86_64-asm_64.S b/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
index 7f30b6f0d72c..da1b7e4a23e4 100644
--- a/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
@@ -98,16 +98,20 @@
 
 
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
 
@@ -190,10 +194,10 @@
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
@@ -275,9 +279,9 @@ __cast6_enc_blk8:
 
 	movq %rdi, CTX;
 
-	vmovdqa .Lbswap_mask, RKM;
-	vmovd .Lfirst_mask, R1ST;
-	vmovd .L32_mask, R32;
+	vmovdqa .Lbswap_mask(%rip), RKM;
+	vmovd .Lfirst_mask(%rip), R1ST;
+	vmovd .L32_mask(%rip), R32;
 
 	inpack_blocks(RA1, RB1, RC1, RD1, RTMP, RX, RKRF, RKM);
 	inpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
@@ -301,7 +305,7 @@ __cast6_enc_blk8:
 	popq %rbx;
 	popq %r15;
 
-	vmovdqa .Lbswap_mask, RKM;
+	vmovdqa .Lbswap_mask(%rip), RKM;
 
 	outunpack_blocks(RA1, RB1, RC1, RD1, RTMP, RX, RKRF, RKM);
 	outunpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
@@ -323,9 +327,9 @@ __cast6_dec_blk8:
 
 	movq %rdi, CTX;
 
-	vmovdqa .Lbswap_mask, RKM;
-	vmovd .Lfirst_mask, R1ST;
-	vmovd .L32_mask, R32;
+	vmovdqa .Lbswap_mask(%rip), RKM;
+	vmovd .Lfirst_mask(%rip), R1ST;
+	vmovd .L32_mask(%rip), R32;
 
 	inpack_blocks(RA1, RB1, RC1, RD1, RTMP, RX, RKRF, RKM);
 	inpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
@@ -349,7 +353,7 @@ __cast6_dec_blk8:
 	popq %rbx;
 	popq %r15;
 
-	vmovdqa .Lbswap_mask, RKM;
+	vmovdqa .Lbswap_mask(%rip), RKM;
 	outunpack_blocks(RA1, RB1, RC1, RD1, RTMP, RX, RKRF, RKM);
 	outunpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
 
diff --git a/arch/x86/crypto/des3_ede-asm_64.S b/arch/x86/crypto/des3_ede-asm_64.S
index 8e49ce117494..4bbd3ec78df5 100644
--- a/arch/x86/crypto/des3_ede-asm_64.S
+++ b/arch/x86/crypto/des3_ede-asm_64.S
@@ -138,21 +138,29 @@
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
@@ -364,65 +372,89 @@ ENDPROC(des3_ede_x86_64_crypt_blk)
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
index f94375a8dcd1..d56a281221fb 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_asm.S
+++ b/arch/x86/crypto/ghash-clmulni-intel_asm.S
@@ -97,7 +97,7 @@ ENTRY(clmul_ghash_mul)
 	FRAME_BEGIN
 	movups (%rdi), DATA
 	movups (%rsi), SHASH
-	movaps .Lbswap_mask, BSWAP
+	movaps .Lbswap_mask(%rip), BSWAP
 	PSHUFB_XMM BSWAP DATA
 	call __clmul_gf128mul_ble
 	PSHUFB_XMM BSWAP DATA
@@ -114,7 +114,7 @@ ENTRY(clmul_ghash_update)
 	FRAME_BEGIN
 	cmp $16, %rdx
 	jb .Lupdate_just_ret	# check length
-	movaps .Lbswap_mask, BSWAP
+	movaps .Lbswap_mask(%rip), BSWAP
 	movups (%rdi), DATA
 	movups (%rcx), SHASH
 	PSHUFB_XMM BSWAP DATA
diff --git a/arch/x86/crypto/glue_helper-asm-avx.S b/arch/x86/crypto/glue_helper-asm-avx.S
index 02ee2308fb38..8a49ab1699ef 100644
--- a/arch/x86/crypto/glue_helper-asm-avx.S
+++ b/arch/x86/crypto/glue_helper-asm-avx.S
@@ -54,7 +54,7 @@
 #define load_ctr_8way(iv, bswap, x0, x1, x2, x3, x4, x5, x6, x7, t0, t1, t2) \
 	vpcmpeqd t0, t0, t0; \
 	vpsrldq $8, t0, t0; /* low: -1, high: 0 */ \
-	vmovdqa bswap, t1; \
+	vmovdqa bswap(%rip), t1; \
 	\
 	/* load IV and byteswap */ \
 	vmovdqu (iv), x7; \
@@ -99,7 +99,7 @@
 
 #define load_xts_8way(iv, src, dst, x0, x1, x2, x3, x4, x5, x6, x7, tiv, t0, \
 		      t1, xts_gf128mul_and_shl1_mask) \
-	vmovdqa xts_gf128mul_and_shl1_mask, t0; \
+	vmovdqa xts_gf128mul_and_shl1_mask(%rip), t0; \
 	\
 	/* load IV */ \
 	vmovdqu (iv), tiv; \
diff --git a/arch/x86/crypto/glue_helper-asm-avx2.S b/arch/x86/crypto/glue_helper-asm-avx2.S
index a53ac11dd385..e04c80467bd2 100644
--- a/arch/x86/crypto/glue_helper-asm-avx2.S
+++ b/arch/x86/crypto/glue_helper-asm-avx2.S
@@ -67,7 +67,7 @@
 	vmovdqu (iv), t2x; \
 	vmovdqa t2x, t3x; \
 	inc_le128(t2x, t0x, t1x); \
-	vbroadcasti128 bswap, t1; \
+	vbroadcasti128 bswap(%rip), t1; \
 	vinserti128 $1, t2x, t3, t2; /* ab: le0 ; cd: le1 */ \
 	vpshufb t1, t2, x0; \
 	\
@@ -124,13 +124,13 @@
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
index de182c460f82..8d38df563b10 100644
--- a/arch/x86/crypto/morus1280-avx2-asm.S
+++ b/arch/x86/crypto/morus1280-avx2-asm.S
@@ -258,7 +258,7 @@ ENTRY(crypto_morus1280_avx2_init)
 	/* load all zeros: */
 	vpxor STATE3, STATE3, STATE3
 	/* load the constant: */
-	vmovdqa .Lmorus1280_const, STATE4
+	vmovdqa .Lmorus1280_const(%rip), STATE4
 
 	/* update 16 times with zero: */
 	call __morus1280_update_zero
@@ -555,7 +555,7 @@ ENTRY(crypto_morus1280_avx2_dec_tail)
 	/* mask with byte count: */
 	movq %rcx, T0_LOW
 	vpbroadcastb T0_LOW, T0
-	vmovdqa .Lmorus1280_counter, T1
+	vmovdqa .Lmorus1280_counter(%rip), T1
 	vpcmpgtb T1, T0, T0
 	vpand T0, MSG, MSG
 
diff --git a/arch/x86/crypto/morus1280-sse2-asm.S b/arch/x86/crypto/morus1280-sse2-asm.S
index da5d2905db60..ba77b6c0980e 100644
--- a/arch/x86/crypto/morus1280-sse2-asm.S
+++ b/arch/x86/crypto/morus1280-sse2-asm.S
@@ -387,8 +387,8 @@ ENTRY(crypto_morus1280_sse2_init)
 	pxor STATE3_LO, STATE3_LO
 	pxor STATE3_HI, STATE3_HI
 	/* load the constant: */
-	movdqa .Lmorus640_const_0, STATE4_LO
-	movdqa .Lmorus640_const_1, STATE4_HI
+	movdqa .Lmorus640_const_0(%rip), STATE4_LO
+	movdqa .Lmorus640_const_1(%rip), STATE4_HI
 
 	/* update 16 times with zero: */
 	call __morus1280_update_zero
@@ -802,8 +802,8 @@ ENTRY(crypto_morus1280_sse2_dec_tail)
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
index 414db480250e..09155d58a28f 100644
--- a/arch/x86/crypto/morus640-sse2-asm.S
+++ b/arch/x86/crypto/morus640-sse2-asm.S
@@ -238,8 +238,8 @@ ENTRY(crypto_morus640_sse2_init)
 	/* load all ones: */
 	pcmpeqd STATE2, STATE2
 	/* load the constants: */
-	movdqa .Lmorus640_const_0, STATE3
-	movdqa .Lmorus640_const_1, STATE4
+	movdqa .Lmorus640_const_0(%rip), STATE3
+	movdqa .Lmorus640_const_1(%rip), STATE4
 
 	/* update 16 times with zero: */
 	call __morus640_update_zero
@@ -545,7 +545,7 @@ ENTRY(crypto_morus640_sse2_dec_tail)
 	punpcklbw T0, T0
 	punpcklbw T0, T0
 	punpcklbw T0, T0
-	movdqa .Lmorus640_counter, T1
+	movdqa .Lmorus640_counter(%rip), T1
 	pcmpgtb T1, T0
 	pand T0, MSG
 
diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
index 1420db15dcdd..2ced4b2f6c76 100644
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/crypto/sha256-avx2-asm.S
@@ -588,37 +588,42 @@ last_block_enter:
 	mov	INP, _INP(%rsp)
 
 	## schedule 48 input dwords, by doing 3 rounds of 12 each
-	xor	SRND, SRND
+	leaq	K256(%rip), SRND
+	## loop1 upper bound
+	leaq	K256+3*4*32(%rip), INP
 
 .align 16
 loop1:
-	vpaddd	K256+0*32(SRND), X0, XFER
+	vpaddd	0*32(SRND), X0, XFER
 	vmovdqa XFER, 0*32+_XFER(%rsp, SRND)
 	FOUR_ROUNDS_AND_SCHED	_XFER + 0*32
 
-	vpaddd	K256+1*32(SRND), X0, XFER
+	vpaddd	1*32(SRND), X0, XFER
 	vmovdqa XFER, 1*32+_XFER(%rsp, SRND)
 	FOUR_ROUNDS_AND_SCHED	_XFER + 1*32
 
-	vpaddd	K256+2*32(SRND), X0, XFER
+	vpaddd	2*32(SRND), X0, XFER
 	vmovdqa XFER, 2*32+_XFER(%rsp, SRND)
 	FOUR_ROUNDS_AND_SCHED	_XFER + 2*32
 
-	vpaddd	K256+3*32(SRND), X0, XFER
+	vpaddd	3*32(SRND), X0, XFER
 	vmovdqa XFER, 3*32+_XFER(%rsp, SRND)
 	FOUR_ROUNDS_AND_SCHED	_XFER + 3*32
 
 	add	$4*32, SRND
-	cmp	$3*4*32, SRND
+	cmp	INP, SRND
 	jb	loop1
 
+	## loop2 upper bound
+	leaq	K256+4*4*32(%rip), INP
+
 loop2:
 	## Do last 16 rounds with no scheduling
-	vpaddd	K256+0*32(SRND), X0, XFER
+	vpaddd	0*32(SRND), X0, XFER
 	vmovdqa XFER, 0*32+_XFER(%rsp, SRND)
 	DO_4ROUNDS	_XFER + 0*32
 
-	vpaddd	K256+1*32(SRND), X1, XFER
+	vpaddd	1*32(SRND), X1, XFER
 	vmovdqa XFER, 1*32+_XFER(%rsp, SRND)
 	DO_4ROUNDS	_XFER + 1*32
 	add	$2*32, SRND
@@ -626,7 +631,7 @@ loop2:
 	vmovdqa	X2, X0
 	vmovdqa	X3, X1
 
-	cmp	$4*4*32, SRND
+	cmp	INP, SRND
 	jb	loop2
 
 	mov	_CTX(%rsp), CTX
-- 
2.21.0.1020.gf2820cf01a-goog

