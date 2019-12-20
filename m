Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B94127E56
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 15:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfLTOoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 09:44:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33688 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfLTOoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:44:21 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iiJVp-0004x5-DU; Fri, 20 Dec 2019 15:44:17 +0100
Date:   Fri, 20 Dec 2019 15:44:17 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RT] Revert "arm*: disable NEON in kernel mode"
Message-ID: <20191220144417.urjlgqbkm54lbuga@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NEON code was disabled due to preempt_disable() / local_bh_disable()
assumptions and possible memory allocations during a "cipher_walk" in
the atomic sections.
The has been reworked in the meantime and atomic sections is only around
the encryption code. I haven't seen a failure/warning while testing with
the tcrypt module.

Allow NEON in kernel mode again.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/Kconfig          |  2 +-
 arch/arm64/crypto/Kconfig | 30 +++++++++++++++---------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f42f0316aec0b..0e95b6d0bd74c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2063,7 +2063,7 @@ config NEON
 
 config KERNEL_MODE_NEON
 	bool "Support for NEON in kernel mode"
-	depends on NEON && AEABI && !PREEMPT_RT
+	depends on NEON && AEABI
 	help
 	  Say Y to include support for NEON in kernel mode.
 
diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 79c804a5e02c4..4922c4451e7c3 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -19,50 +19,50 @@ config CRYPTO_SHA512_ARM64
 
 config CRYPTO_SHA1_ARM64_CE
 	tristate "SHA-1 digest algorithm (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON && PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SHA1
 
 config CRYPTO_SHA2_ARM64_CE
 	tristate "SHA-224/SHA-256 digest algorithm (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON && PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SHA256_ARM64
 
 config CRYPTO_SHA512_ARM64_CE
 	tristate "SHA-384/SHA-512 digest algorithm (ARMv8 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON && PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SHA512_ARM64
 
 config CRYPTO_SHA3_ARM64
 	tristate "SHA3 digest algorithm (ARMv8.2 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON && PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SHA3
 
 config CRYPTO_SM3_ARM64_CE
 	tristate "SM3 digest algorithm (ARMv8.2 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON && PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SM3
 
 config CRYPTO_SM4_ARM64_CE
 	tristate "SM4 symmetric cipher (ARMv8.2 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON && PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_ALGAPI
 	select CRYPTO_SM4
 
 config CRYPTO_GHASH_ARM64_CE
 	tristate "GHASH/AES-GCM using ARMv8 Crypto Extensions"
-	depends on KERNEL_MODE_NEON && PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_GF128MUL
 	select CRYPTO_LIB_AES
 
 config CRYPTO_CRCT10DIF_ARM64_CE
 	tristate "CRCT10DIF digest algorithm using PMULL instructions"
-	depends on KERNEL_MODE_NEON && CRC_T10DIF && !PREEMPT_RT
+	depends on KERNEL_MODE_NEON && CRC_T10DIF
 	select CRYPTO_HASH
 
 config CRYPTO_AES_ARM64
@@ -71,13 +71,13 @@ config CRYPTO_AES_ARM64
 
 config CRYPTO_AES_ARM64_CE
 	tristate "AES core cipher using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON && PREEMPT_RT
+	depends on ARM64 && KERNEL_MODE_NEON
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_AES
 
 config CRYPTO_AES_ARM64_CE_CCM
 	tristate "AES in CCM mode using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON && PREEMPT_RT
+	depends on ARM64 && KERNEL_MODE_NEON
 	select CRYPTO_ALGAPI
 	select CRYPTO_AES_ARM64_CE
 	select CRYPTO_AEAD
@@ -85,7 +85,7 @@ config CRYPTO_AES_ARM64_CE_CCM
 
 config CRYPTO_AES_ARM64_CE_BLK
 	tristate "AES in ECB/CBC/CTR/XTS modes using ARMv8 Crypto Extensions"
-	depends on KERNEL_MODE_NEON && !PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES_ARM64_CE
 	select CRYPTO_AES_ARM64
@@ -93,7 +93,7 @@ config CRYPTO_AES_ARM64_CE_BLK
 
 config CRYPTO_AES_ARM64_NEON_BLK
 	tristate "AES in ECB/CBC/CTR/XTS modes using NEON instructions"
-	depends on KERNEL_MODE_NEON && PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES_ARM64
 	select CRYPTO_LIB_AES
@@ -101,18 +101,18 @@ config CRYPTO_AES_ARM64_NEON_BLK
 
 config CRYPTO_CHACHA20_NEON
 	tristate "ChaCha20, XChaCha20, and XChaCha12 stream ciphers using NEON instructions"
-	depends on KERNEL_MODE_NEON && !PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_CHACHA20
 
 config CRYPTO_NHPOLY1305_NEON
 	tristate "NHPoly1305 hash function using NEON instructions (for Adiantum)"
-	depends on KERNEL_MODE_NEON && !PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_NHPOLY1305
 
 config CRYPTO_AES_ARM64_BS
 	tristate "AES in ECB/CBC/CTR/XTS modes using bit-sliced NEON algorithm"
-	depends on KERNEL_MODE_NEON && !PREEMPT_RT
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES_ARM64_NEON_BLK
 	select CRYPTO_AES_ARM64
-- 
2.24.1

