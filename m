Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88F2EAE68C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 11:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389041AbfIJJR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 05:17:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:37455 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbfIJJRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:17:17 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46SKDV11y6z9txW8;
        Tue, 10 Sep 2019 11:17:14 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=idHyv23X; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8aeNip4PjRe5; Tue, 10 Sep 2019 11:17:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46SKDT6sgbz9txW2;
        Tue, 10 Sep 2019 11:17:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1568107034; bh=8ftmeyPqqlcOQZKXXYr2+SgDzTYbbqznzk6320BOCv8=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=idHyv23XV6f0UvTXYGLdedeji+3J0TmcwN9NaKLNFPC+eecfaieHRusltrGx1QCyR
         Q8h/W1qnkLG0oGVTXcENS4RwPGRkbwMH7zB/aMtm0wqn3ZBOMwAv587Gf2Fb8vKFiG
         3ArjbCl1mr0yJP24mpGFE+KNs727Dwf6AX4N8E68=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8BF278B87A;
        Tue, 10 Sep 2019 11:17:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 93QokzmLfQal; Tue, 10 Sep 2019 11:17:13 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6F2048B88B;
        Tue, 10 Sep 2019 11:16:24 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 21A026B739; Tue, 10 Sep 2019 09:16:24 +0000 (UTC)
Message-Id: <2fee4de4e85fd7fa1afd07d83b2963320795305f.1568106758.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1568106758.git.christophe.leroy@c-s.fr>
References: <cover.1568106758.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 05/15] powerpc/32: add a macro to get and/or save DAR and
 DSISR on stack.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Tue, 10 Sep 2019 09:16:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor reading and saving of DAR and DSISR in exception vectors.

This will ease the implementation of VMAP stack.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S  |  5 +----
 arch/powerpc/kernel/head_32.h  | 11 +++++++++++
 arch/powerpc/kernel/head_8xx.S | 23 +++++++----------------
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index bebb49d877f2..449625b4ff03 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -339,10 +339,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
 	DO_KVM  0x600
 Alignment:
 	EXCEPTION_PROLOG
-	mfspr	r4,SPRN_DAR
-	stw	r4,_DAR(r11)
-	mfspr	r5,SPRN_DSISR
-	stw	r5,_DSISR(r11)
+	save_dar_dsisr_on_stack r4, r5, r11
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_STD(0x600, alignment_exception)
 
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 436ffd862d2a..f19a1ab91fb5 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -144,6 +144,17 @@
 	RFI				/* jump to handler, enable MMU */
 .endm
 
+.macro save_dar_dsisr_on_stack reg1, reg2, sp
+	mfspr	\reg1, SPRN_DAR
+	mfspr	\reg2, SPRN_DSISR
+	stw	\reg1, _DAR(\sp)
+	stw	\reg2, _DSISR(\sp)
+.endm
+
+.macro get_and_save_dar_dsisr_on_stack reg1, reg2, sp
+	save_dar_dsisr_on_stack \reg1, \reg2, \sp
+.endm
+
 /*
  * Note: code which follows this uses cr0.eq (set if from kernel),
  * r11, r12 (SRR0), and r9 (SRR1).
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 175c3cfc8014..25e19af49705 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -128,12 +128,9 @@ instruction_counter:
 	. = 0x200
 MachineCheck:
 	EXCEPTION_PROLOG
-	mfspr r4,SPRN_DAR
-	stw r4,_DAR(r11)
-	li r5,RPN_PATTERN
-	mtspr SPRN_DAR,r5	/* Tag DAR, to be used in DTLB Error */
-	mfspr r5,SPRN_DSISR
-	stw r5,_DSISR(r11)
+	save_dar_dsisr_on_stack r4, r5, r11
+	li	r6, RPN_PATTERN
+	mtspr	SPRN_DAR, r6	/* Tag DAR, to be used in DTLB Error */
 	addi r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_STD(0x200, machine_check_exception)
 
@@ -156,12 +153,9 @@ InstructionAccess:
 	. = 0x600
 Alignment:
 	EXCEPTION_PROLOG
-	mfspr	r4,SPRN_DAR
-	stw	r4,_DAR(r11)
-	li	r5,RPN_PATTERN
-	mtspr	SPRN_DAR,r5	/* Tag DAR, to be used in DTLB Error */
-	mfspr	r5,SPRN_DSISR
-	stw	r5,_DSISR(r11)
+	save_dar_dsisr_on_stack r4, r5, r11
+	li	r6, RPN_PATTERN
+	mtspr	SPRN_DAR, r6	/* Tag DAR, to be used in DTLB Error */
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_STD(0x600, alignment_exception)
 
@@ -502,10 +496,7 @@ DataTLBError:
 DARFixed:/* Return from dcbx instruction bug workaround */
 	EXCEPTION_PROLOG_1
 	EXCEPTION_PROLOG_2
-	mfspr	r5,SPRN_DSISR
-	stw	r5,_DSISR(r11)
-	mfspr	r4,SPRN_DAR
-	stw	r4, _DAR(r11)
+	get_and_save_dar_dsisr_on_stack r4, r5, r11
 	andis.	r10,r5,DSISR_NOHPTE@h
 	beq+	.Ldtlbie
 	tlbie	r4
-- 
2.13.3

