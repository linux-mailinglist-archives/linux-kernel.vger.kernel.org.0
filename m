Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9BDD925A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 15:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfHSN6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 09:58:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:59515 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfHSN6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:58:15 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46BwVl4yKDz9txwR;
        Mon, 19 Aug 2019 15:58:07 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=b+qZijNH; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3LAFpjc5ZZEF; Mon, 19 Aug 2019 15:58:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46BwVl3dH2z9txvq;
        Mon, 19 Aug 2019 15:58:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566223087; bh=I3GscCUL+tagamYjLpeA1pHPoXl+L8tdwdhXghWn5l0=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=b+qZijNHwV2liAFXQ5G4UoQOQ4n6EJhBi5iFQe57jnHb9FKofxzxWI0l08oXemYoj
         a201+iYI7S8StDrVvP5HlhCKhQy1TNRbqJbJGSd2TMpHAHa40mSsQbzZNCPZJfvWcb
         3iuqSFGUglNaozE51hq20VgT+Dqyo+HQuiCihuvI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0E9B78B7B9;
        Mon, 19 Aug 2019 15:58:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jphAGcmKo54y; Mon, 19 Aug 2019 15:58:12 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CEF1D8B7B7;
        Mon, 19 Aug 2019 15:58:12 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id CDD536B70A; Mon, 19 Aug 2019 13:58:12 +0000 (UTC)
Message-Id: <92bf50b31f5f78cc76ed055b11a492e8e9e2c731.1566223054.git.christophe.leroy@c-s.fr>
In-Reply-To: <be2b971c89b1af30d680cedd14e99a83138ef40a.1566223054.git.christophe.leroy@c-s.fr>
References: <be2b971c89b1af30d680cedd14e99a83138ef40a.1566223054.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 3/3] powerpc/64: optimise LOAD_REG_IMMEDIATE_SYM()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 19 Aug 2019 13:58:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimise LOAD_REG_IMMEDIATE_SYM() using a temporary register to
parallelise operations.

It reduces the path from 5 to 3 instructions.

Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
v3: new
---
 arch/powerpc/include/asm/ppc_asm.h   | 12 ++++++------
 arch/powerpc/kernel/exceptions-64e.S | 22 +++++++++++++---------
 arch/powerpc/kernel/head_64.S        |  2 +-
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index aa8717c1571a..9d55bff9a73c 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -347,12 +347,12 @@ GLUE(.,name):
 
 #define LOAD_REG_IMMEDIATE(reg, expr) __LOAD_REG_IMMEDIATE reg, expr
 
-#define LOAD_REG_IMMEDIATE_SYM(reg,expr)	\
-	lis     reg,(expr)@highest;		\
-	ori     reg,reg,(expr)@higher;	\
-	rldicr  reg,reg,32,31;		\
-	oris    reg,reg,(expr)@__AS_ATHIGH;	\
-	ori     reg,reg,(expr)@l;
+#define LOAD_REG_IMMEDIATE_SYM(reg, tmp, expr)	\
+	lis	reg, (expr)@highest;		\
+	lis	tmp, (expr)@__AS_ATHIGH;	\
+	ori	reg, reg, (expr)@higher;	\
+	ori	tmp, reg, (expr)@l;		\
+	rldimi	reg, tmp, 32, 0
 
 #define LOAD_REG_ADDR(reg,name)			\
 	ld	reg,name@got(r2)
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 898aae6da167..829950b96d29 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -750,12 +750,14 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	ld	r15,PACATOC(r13)
 	ld	r14,interrupt_base_book3e@got(r15)
 	ld	r15,__end_interrupts@got(r15)
-#else
-	LOAD_REG_IMMEDIATE_SYM(r14,interrupt_base_book3e)
-	LOAD_REG_IMMEDIATE_SYM(r15,__end_interrupts)
-#endif
 	cmpld	cr0,r10,r14
 	cmpld	cr1,r10,r15
+#else
+	LOAD_REG_IMMEDIATE_SYM(r14, r15, interrupt_base_book3e)
+	cmpld	cr0, r10, r14
+	LOAD_REG_IMMEDIATE_SYM(r14, r15, __end_interrupts)
+	cmpld	cr1, r10, r14
+#endif
 	blt+	cr0,1f
 	bge+	cr1,1f
 
@@ -820,12 +822,14 @@ kernel_dbg_exc:
 	ld	r15,PACATOC(r13)
 	ld	r14,interrupt_base_book3e@got(r15)
 	ld	r15,__end_interrupts@got(r15)
-#else
-	LOAD_REG_IMMEDIATE_SYM(r14,interrupt_base_book3e)
-	LOAD_REG_IMMEDIATE_SYM(r15,__end_interrupts)
-#endif
 	cmpld	cr0,r10,r14
 	cmpld	cr1,r10,r15
+#else
+	LOAD_REG_IMMEDIATE_SYM(r14, r15, interrupt_base_book3e)
+	cmpld	cr0, r10, r14
+	LOAD_REG_IMMEDIATE_SYM(r14, r15,__end_interrupts)
+	cmpld	cr1, r10, r14
+#endif
 	blt+	cr0,1f
 	bge+	cr1,1f
 
@@ -1449,7 +1453,7 @@ a2_tlbinit_code_start:
 a2_tlbinit_after_linear_map:
 
 	/* Now we branch the new virtual address mapped by this entry */
-	LOAD_REG_IMMEDIATE_SYM(r3,1f)
+	LOAD_REG_IMMEDIATE_SYM(r3, r5, 1f)
 	mtctr	r3
 	bctr
 
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 1fd44761e997..0f2d61af47cc 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -635,7 +635,7 @@ __after_prom_start:
 	sub	r5,r5,r11
 #else
 	/* just copy interrupts */
-	LOAD_REG_IMMEDIATE_SYM(r5, FIXED_SYMBOL_ABS_ADDR(__end_interrupts))
+	LOAD_REG_IMMEDIATE_SYM(r5, r11, FIXED_SYMBOL_ABS_ADDR(__end_interrupts))
 #endif
 	b	5f
 3:
-- 
2.13.3

