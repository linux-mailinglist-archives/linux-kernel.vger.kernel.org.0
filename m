Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F0D109E07
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 13:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfKZMgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 07:36:07 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:59652 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbfKZMgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 07:36:06 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47Mk0M5Y45z9v0G5;
        Tue, 26 Nov 2019 13:36:03 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=TXiLarQt; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id j-2MRhOvabry; Tue, 26 Nov 2019 13:36:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47Mk0M4S95z9v0G3;
        Tue, 26 Nov 2019 13:36:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574771763; bh=kGon0ub1xJnz0O6Eae+CiFjeXTbJxumDVRZ8IyCl084=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=TXiLarQtwwsuDUFnQ/2He8z8eq9/ScCVuhm8PZFRyPSUAPZp+h++x8+KMEQfD5F2y
         R0cKF2qTgiZUTj99HKUNyWeMG3mWsGjc4TAxMNt/b4NMCsU4D/8XPU0bLKRly2KiLf
         A2qZF7AVTA7wsI0CYz70yEW0+ztLPmJkKp8e6HdQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E22558B7FC;
        Tue, 26 Nov 2019 13:36:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ajlPJvqQ4zud; Tue, 26 Nov 2019 13:36:04 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 994A38B771;
        Tue, 26 Nov 2019 13:36:04 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 67A0D6B76A; Tue, 26 Nov 2019 12:36:04 +0000 (UTC)
Message-Id: <a64d10332ed40893c1c7ea8b62f63c9272a9a3e1.1574771539.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1574771539.git.christophe.leroy@c-s.fr>
References: <cover.1574771539.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 01/16] powerpc/32: replace MTMSRD() by mtmsr
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Tue, 26 Nov 2019 12:36:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PPC32, MTMSRD() is simply defined as mtmsr.

Replace MTMSRD(reg) by mtmsr reg in files dedicated to PPC32,
this makes the code less obscure.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_32.S | 18 +++++++++---------
 arch/powerpc/kernel/head_32.h  |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index d60908ea37fb..6273b4862482 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -397,7 +397,7 @@ ret_from_syscall:
 	LOAD_REG_IMMEDIATE(r10,MSR_KERNEL)	/* doesn't include MSR_EE */
 	/* Note: We don't bother telling lockdep about it */
 	SYNC
-	MTMSRD(r10)
+	mtmsr	r10
 	lwz	r9,TI_FLAGS(r2)
 	li	r8,-MAX_ERRNO
 	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
@@ -554,7 +554,7 @@ syscall_exit_work:
 	 */
 	ori	r10,r10,MSR_EE
 	SYNC
-	MTMSRD(r10)
+	mtmsr	r10
 
 	/* Save NVGPRS if they're not saved already */
 	lwz	r4,_TRAP(r1)
@@ -697,7 +697,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_SPE)
 	and.	r0,r0,r11	/* FP or altivec or SPE enabled? */
 	beq+	1f
 	andc	r11,r11,r0
-	MTMSRD(r11)
+	mtmsr	r11
 	isync
 1:	stw	r11,_MSR(r1)
 	mfcr	r10
@@ -831,7 +831,7 @@ ret_from_except:
 	/* Note: We don't bother telling lockdep about it */
 	LOAD_REG_IMMEDIATE(r10,MSR_KERNEL)
 	SYNC			/* Some chip revs have problems here... */
-	MTMSRD(r10)		/* disable interrupts */
+	mtmsr	r10		/* disable interrupts */
 
 	lwz	r3,_MSR(r1)	/* Returning to user mode? */
 	andi.	r0,r3,MSR_PR
@@ -998,7 +998,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	 */
 	LOAD_REG_IMMEDIATE(r10,MSR_KERNEL & ~MSR_RI)
 	SYNC
-	MTMSRD(r10)		/* clear the RI bit */
+	mtmsr	r10		/* clear the RI bit */
 	.globl exc_exit_restart
 exc_exit_restart:
 	lwz	r12,_NIP(r1)
@@ -1234,7 +1234,7 @@ do_resched:			/* r10 contains MSR_KERNEL here */
 #endif
 	ori	r10,r10,MSR_EE
 	SYNC
-	MTMSRD(r10)		/* hard-enable interrupts */
+	mtmsr	r10		/* hard-enable interrupts */
 	bl	schedule
 recheck:
 	/* Note: And we don't tell it we are disabling them again
@@ -1243,7 +1243,7 @@ recheck:
 	 */
 	LOAD_REG_IMMEDIATE(r10,MSR_KERNEL)
 	SYNC
-	MTMSRD(r10)		/* disable interrupts */
+	mtmsr	r10		/* disable interrupts */
 	lwz	r9,TI_FLAGS(r2)
 	andi.	r0,r9,_TIF_NEED_RESCHED
 	bne-	do_resched
@@ -1252,7 +1252,7 @@ recheck:
 do_user_signal:			/* r10 contains MSR_KERNEL here */
 	ori	r10,r10,MSR_EE
 	SYNC
-	MTMSRD(r10)		/* hard-enable interrupts */
+	mtmsr	r10		/* hard-enable interrupts */
 	/* save r13-r31 in the exception frame, if not already done */
 	lwz	r3,_TRAP(r1)
 	andi.	r0,r3,1
@@ -1341,7 +1341,7 @@ _GLOBAL(enter_rtas)
 	stw	r9,8(r1)
 	LOAD_REG_IMMEDIATE(r0,MSR_KERNEL)
 	SYNC			/* disable interrupts so SRR0/1 */
-	MTMSRD(r0)		/* don't get trashed */
+	mtmsr	r0		/* don't get trashed */
 	li	r9,MSR_KERNEL & ~(MSR_IR|MSR_DR)
 	mtlr	r6
 	stw	r7, THREAD + RTAS_SP(r2)
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 8abc7783dbe5..b2ca8c9ffd8b 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -50,7 +50,7 @@
 	rlwinm	r9,r9,0,14,12		/* clear MSR_WE (necessary?) */
 #else
 	li	r10,MSR_KERNEL & ~(MSR_IR|MSR_DR) /* can take exceptions */
-	MTMSRD(r10)			/* (except for mach check in rtas) */
+	mtmsr	r10			/* (except for mach check in rtas) */
 #endif
 	stw	r0,GPR0(r11)
 	lis	r10,STACK_FRAME_REGS_MARKER@ha /* exception frame marker */
@@ -80,7 +80,7 @@
 	rlwinm	r9,r9,0,14,12		/* clear MSR_WE (necessary?) */
 #else
 	LOAD_REG_IMMEDIATE(r10, MSR_KERNEL & ~(MSR_IR|MSR_DR)) /* can take exceptions */
-	MTMSRD(r10)			/* (except for mach check in rtas) */
+	mtmsr	r10			/* (except for mach check in rtas) */
 #endif
 	lis	r10,STACK_FRAME_REGS_MARKER@ha /* exception frame marker */
 	stw	r2,GPR2(r11)
-- 
2.13.3

