Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B77D7AE688
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 11:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388789AbfIJJRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 05:17:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:35838 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730406AbfIJJRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:17:20 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46SKDY6S2gz9txVv;
        Tue, 10 Sep 2019 11:17:17 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=AC3fr2ag; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xmvf9NDOOVTe; Tue, 10 Sep 2019 11:17:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46SKDY5Q6Wz9txVx;
        Tue, 10 Sep 2019 11:17:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1568107037; bh=sPQkpfAXuHD4qRlIU4DOLkneuq2pFkJAZAVl214Hg7k=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=AC3fr2agaTwZz1bzV6/xYbSr8/zaoRY8R4z/R9A9f9MJ82BSDuK6dx+Pu2yMs6Ev2
         En+RVSREFoC3ngSIhPgNOUVkFpnMrntTfUG5LlYx+CDuBeFiopHetyN7YgZInmU01C
         qBDclOSirLXLRDacdnDvIkU9jtNTIkGjtQqPCo6M=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A6498B87F;
        Tue, 10 Sep 2019 11:17:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DH4HRl5Mrzx2; Tue, 10 Sep 2019 11:17:15 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BD6BB8B89C;
        Tue, 10 Sep 2019 11:16:33 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 66C596B739; Tue, 10 Sep 2019 09:16:33 +0000 (UTC)
Message-Id: <106a755225eabfcaa1ed3bed39f763c0a3292cce.1568106758.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1568106758.git.christophe.leroy@c-s.fr>
References: <cover.1568106758.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 14/15] powerpc/32s: reorganise DSI handler.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        dja@axtens.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Tue, 10 Sep 2019 09:16:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The part decidated to handling hash_page() is fully unneeded for
processors not having real hash pages like the 603.

Lets enlarge the content of the feature fixup, and provide
an alternative which jumps directly instead of getting NIPs.

Also, in preparation of VMAP stacks, the end of DSI handler has moved
to later in the code as it won't fit anymore once VMAP stacks
are there.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 449625b4ff03..5bda6a092673 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -295,24 +295,22 @@ __secondary_hold_acknowledge:
 	DO_KVM  0x300
 DataAccess:
 	EXCEPTION_PROLOG
-	mfspr	r10,SPRN_DSISR
-	stw	r10,_DSISR(r11)
+	get_and_save_dar_dsisr_on_stack	r4, r5, r11
+BEGIN_MMU_FTR_SECTION
 #ifdef CONFIG_PPC_KUAP
-	andis.	r0,r10,(DSISR_BAD_FAULT_32S | DSISR_DABRMATCH | DSISR_PROTFAULT)@h
+	andis.	r0, r5, (DSISR_BAD_FAULT_32S | DSISR_DABRMATCH | DSISR_PROTFAULT)@h
 #else
-	andis.	r0,r10,(DSISR_BAD_FAULT_32S|DSISR_DABRMATCH)@h
+	andis.	r0, r5, (DSISR_BAD_FAULT_32S | DSISR_DABRMATCH)@h
 #endif
-	bne	1f			/* if not, try to put a PTE */
-	mfspr	r4,SPRN_DAR		/* into the hash table */
-	rlwinm	r3,r10,32-15,21,21	/* DSISR_STORE -> _PAGE_RW */
-BEGIN_MMU_FTR_SECTION
+	bne	handle_page_fault_tramp	/* if not, try to put a PTE */
+	rlwinm	r3, r5, 32 - 15, 21, 21	/* DSISR_STORE -> _PAGE_RW */
 	bl	hash_page
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
-1:	lwz	r5,_DSISR(r11)		/* get DSISR value */
-	mfspr	r4,SPRN_DAR
-	stw	r4, _DAR(r11)
-	EXC_XFER_LITE(0x300, handle_page_fault)
-
+	lwz	r5, _DSISR(r11)		/* get DSISR value */
+	lwz	r4, _DAR(r11)
+	b	handle_page_fault_tramp
+FTR_SECTION_ELSE
+	b	handle_page_fault_tramp
+ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_HPTE_TABLE)
 
 /* Instruction access exception. */
 	. = 0x400
@@ -642,6 +640,9 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
 
 	. = 0x3000
 
+handle_page_fault_tramp:
+	EXC_XFER_LITE(0x300, handle_page_fault)
+
 AltiVecUnavailable:
 	EXCEPTION_PROLOG
 #ifdef CONFIG_ALTIVEC
-- 
2.13.3

