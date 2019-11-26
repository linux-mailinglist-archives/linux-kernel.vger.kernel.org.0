Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98DAA109E08
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 13:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfKZMgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 07:36:08 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:35677 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbfKZMgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 07:36:07 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47Mk0N5M1yz9v0G6;
        Tue, 26 Nov 2019 13:36:04 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=uT62KOph; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id nBKrcked7xLD; Tue, 26 Nov 2019 13:36:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47Mk0N4DSKz9v0G3;
        Tue, 26 Nov 2019 13:36:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574771764; bh=EO9Qxk0hjLo3ieTea7LgHM8klTAmnyp7SMifgH/BhW0=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=uT62KOphC1cFChUDxO/0b+WwwaJ8PP08fzNy8VCWMdVkhrjUUW09g2I+vnu7yLIBQ
         l6ZjAyDudCiNrlcyPmg3ZYXXAdKUKtSCBUwV+COkZq5Fmq9z5z+lcmbxiICqlSlW+k
         5YRUDx/3mUZdjmZttTKBwaDdTuXIh/QmkuJ1Ri9M=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E0FE88B7FF;
        Tue, 26 Nov 2019 13:36:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id C0VvUOgAJNpy; Tue, 26 Nov 2019 13:36:05 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E83C8B771;
        Tue, 26 Nov 2019 13:36:05 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6E11D6B76A; Tue, 26 Nov 2019 12:36:05 +0000 (UTC)
Message-Id: <7566798af7bb806fb113a6787eb30df1d143600c.1574771540.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1574771539.git.christophe.leroy@c-s.fr>
References: <cover.1574771539.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 02/16] powerpc/32: Add EXCEPTION_PROLOG_0 in head_32.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Tue, 26 Nov 2019 12:36:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates a macro for the very first part of
exception prolog, this will help when implementing
CONFIG_VMAP_STACK

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S  | 4 +---
 arch/powerpc/kernel/head_32.h  | 9 ++++++---
 arch/powerpc/kernel/head_8xx.S | 9 ++-------
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 4a24f8f026c7..9e868567b716 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -272,9 +272,7 @@ __secondary_hold_acknowledge:
  */
 	. = 0x200
 	DO_KVM  0x200
-	mtspr	SPRN_SPRG_SCRATCH0,r10
-	mtspr	SPRN_SPRG_SCRATCH1,r11
-	mfcr	r10
+	EXCEPTION_PROLOG_0
 #ifdef CONFIG_PPC_CHRP
 	mfspr	r11, SPRN_SPRG_THREAD
 	lwz	r11, RTAS_SP(r11)
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index b2ca8c9ffd8b..8e345f8d4b0e 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -10,13 +10,16 @@
  * We assume sprg3 has the physical address of the current
  * task's thread_struct.
  */
-
 .macro EXCEPTION_PROLOG
+	EXCEPTION_PROLOG_0
+	EXCEPTION_PROLOG_1
+	EXCEPTION_PROLOG_2
+.endm
+
+.macro EXCEPTION_PROLOG_0
 	mtspr	SPRN_SPRG_SCRATCH0,r10
 	mtspr	SPRN_SPRG_SCRATCH1,r11
 	mfcr	r10
-	EXCEPTION_PROLOG_1
-	EXCEPTION_PROLOG_2
 .endm
 
 .macro EXCEPTION_PROLOG_1
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 19f583e18402..dac7c0a34eea 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -494,10 +494,7 @@ InstructionTLBError:
  */
 	. = 0x1400
 DataTLBError:
-	mtspr	SPRN_SPRG_SCRATCH0, r10
-	mtspr	SPRN_SPRG_SCRATCH1, r11
-	mfcr	r10
-
+	EXCEPTION_PROLOG_0
 	mfspr	r11, SPRN_DAR
 	cmpwi	cr0, r11, RPN_PATTERN
 	beq-	FixupDAR	/* must be a buggy dcbX, icbi insn. */
@@ -530,9 +527,7 @@ DARFixed:/* Return from dcbx instruction bug workaround */
  */
 	. = 0x1c00
 DataBreakpoint:
-	mtspr	SPRN_SPRG_SCRATCH0, r10
-	mtspr	SPRN_SPRG_SCRATCH1, r11
-	mfcr	r10
+	EXCEPTION_PROLOG_0
 	mfspr	r11, SPRN_SRR0
 	cmplwi	cr0, r11, (.Ldtlbie - PAGE_OFFSET)@l
 	cmplwi	cr7, r11, (.Litlbie - PAGE_OFFSET)@l
-- 
2.13.3

