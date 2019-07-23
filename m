Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A29C71330
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 09:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbfGWHpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 03:45:38 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:42702 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbfGWHph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:45:37 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x6N7iKrX025153;
        Tue, 23 Jul 2019 16:44:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x6N7iKrX025153
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563867861;
        bh=wwv9Z4pZlsh4ouUjX2bu7iJJkEhowNuVCO6yDuN4jeI=;
        h=From:To:Cc:Subject:Date:From;
        b=BhHsw2xNxb2pM2O70xKTlcZzAINovN12204RlfSQTdJTCYPWJGlu1UDXPnR7IdUpT
         p5k6mccVpfiq7h+oFeuiA60ael6+5nifdZPsCIzAyIZijccu9FQGBj4uvJR5GdNKd/
         4TNeZS2U4Lc7JmmECIvgOPCM63Jj+0Sq+GMmykmxJiW9LqrePde1mmKHlLqFt9VUrg
         wb8vagV/CQCk0xgtgXLrIy9znauqxm5XJERORZMCKUkERo/DvqNsP/l8ILakvykm66
         kVAfV8VuGm/ig6Be6SY9Vvcn8Hr/aiDYl/1Z02hRVPbHUL2A2j/4UZKk62291x1UVB
         pnr5X3oE64wEg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: use __builtin_constant_p() directly instead of IS_IMMEDIATE()
Date:   Tue, 23 Jul 2019 16:44:15 +0900
Message-Id: <20190723074415.26811-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__builtin_constant_p(nr) is used everywhere now. It does not make
much sense to define IS_IMMEDIATE() as its alias.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/include/asm/bitops.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index ba15d53c1ca7..7d1f6a49bfae 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -45,14 +45,13 @@
  * We do the locked ops that don't return the old value as
  * a mask operation on a byte.
  */
-#define IS_IMMEDIATE(nr)		(__builtin_constant_p(nr))
 #define CONST_MASK_ADDR(nr, addr)	WBYTE_ADDR((void *)(addr) + ((nr)>>3))
 #define CONST_MASK(nr)			(1 << ((nr) & 7))
 
 static __always_inline void
 arch_set_bit(long nr, volatile unsigned long *addr)
 {
-	if (IS_IMMEDIATE(nr)) {
+	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "orb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" ((u8)CONST_MASK(nr))
@@ -72,7 +71,7 @@ arch___set_bit(long nr, volatile unsigned long *addr)
 static __always_inline void
 arch_clear_bit(long nr, volatile unsigned long *addr)
 {
-	if (IS_IMMEDIATE(nr)) {
+	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "andb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" ((u8)~CONST_MASK(nr)));
@@ -123,7 +122,7 @@ arch___change_bit(long nr, volatile unsigned long *addr)
 static __always_inline void
 arch_change_bit(long nr, volatile unsigned long *addr)
 {
-	if (IS_IMMEDIATE(nr)) {
+	if (__builtin_constant_p(nr)) {
 		asm volatile(LOCK_PREFIX "xorb %1,%0"
 			: CONST_MASK_ADDR(nr, addr)
 			: "iq" ((u8)CONST_MASK(nr)));
-- 
2.17.1

