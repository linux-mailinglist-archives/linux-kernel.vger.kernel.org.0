Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C62A6E84D1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 10:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbfJ2JxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 05:53:20 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43768 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733132AbfJ2JxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:53:08 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 472RjF6NJ7z9tyh4;
        Tue, 29 Oct 2019 10:53:05 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=o6bKkRdW; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id YsSxrvHZJzKT; Tue, 29 Oct 2019 10:53:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 472RjF50Xjz9tygy;
        Tue, 29 Oct 2019 10:53:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1572342785; bh=908ictPM0d9tdAvkWhNTctaYRgZOsXF5jkHRnAfr4Tk=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=o6bKkRdWC2f3BZfgPqKFQ72tp5AFMwo90bzpBHyN0WcUD2TZsSCelHf7bFCO5+8PR
         5FTSU2EfX8U/sPqoCbI0twKJ0Lsg48aA9e/hfHFdSkFwuLwm41YLdDFu9zgCnXgCJK
         VDwjAjEGscxE0O8sSnQFvdNZECNAiu/bcVfMgnXA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BD6FE8B84C;
        Tue, 29 Oct 2019 10:53:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DcDmVFPF9K4a; Tue, 29 Oct 2019 10:53:06 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 89DAB8B755;
        Tue, 29 Oct 2019 10:53:06 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 558646B6FD; Tue, 29 Oct 2019 09:53:06 +0000 (UTC)
Message-Id: <85cc56b1cd337e3d9673286a0b14c23ebdfbae7a.1572342582.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1572342582.git.christophe.leroy@c-s.fr>
References: <cover.1572342582.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 1/8] powerpc/32: Add VDSO version of getcpu on non SMP
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 29 Oct 2019 09:53:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 18ad51dd342a ("powerpc: Add VDSO version of getcpu") added
getcpu() for PPC64 only, by making use of a user readable general
purpose SPR.

PPC32 doesn't have any such SPR.

For non SMP, just return CPU id 0 from the VDSO directly.
PPC32 doesn't support CONFIG_NUMA so NUMA node is always 0.

Before the patch, vdsotest reported:
getcpu: syscall: 1572 nsec/call
getcpu:    libc: 1787 nsec/call
getcpu:    vdso: not tested

Now, vdsotest reports:
getcpu: syscall: 1582 nsec/call
getcpu:    libc: 502 nsec/call
getcpu:    vdso: 187 nsec/call

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
v2: fixed build error in getcpu.S
v3: dropped the fast system call, only support non SMP for now.
---
 arch/powerpc/kernel/vdso32/Makefile     |  4 +---
 arch/powerpc/kernel/vdso32/getcpu.S     | 17 +++++++++++++++++
 arch/powerpc/kernel/vdso32/vdso32.lds.S |  2 +-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
index 06f54d947057..e147bbdc12cd 100644
--- a/arch/powerpc/kernel/vdso32/Makefile
+++ b/arch/powerpc/kernel/vdso32/Makefile
@@ -2,9 +2,7 @@
 
 # List of files in the vdso, has to be asm only for now
 
-obj-vdso32-$(CONFIG_PPC64) = getcpu.o
-obj-vdso32 = sigtramp.o gettimeofday.o datapage.o cacheflush.o note.o \
-		$(obj-vdso32-y)
+obj-vdso32 = sigtramp.o gettimeofday.o datapage.o cacheflush.o note.o getcpu.o
 
 # Build rules
 
diff --git a/arch/powerpc/kernel/vdso32/getcpu.S b/arch/powerpc/kernel/vdso32/getcpu.S
index 63e914539e1a..90b39af14383 100644
--- a/arch/powerpc/kernel/vdso32/getcpu.S
+++ b/arch/powerpc/kernel/vdso32/getcpu.S
@@ -15,6 +15,7 @@
  * int __kernel_getcpu(unsigned *cpu, unsigned *node);
  *
  */
+#if defined(CONFIG_PPC64)
 V_FUNCTION_BEGIN(__kernel_getcpu)
   .cfi_startproc
 	mfspr	r5,SPRN_SPRG_VDSO_READ
@@ -31,3 +32,19 @@ V_FUNCTION_BEGIN(__kernel_getcpu)
 	blr
   .cfi_endproc
 V_FUNCTION_END(__kernel_getcpu)
+#elif !defined(CONFIG_SMP)
+V_FUNCTION_BEGIN(__kernel_getcpu)
+  .cfi_startproc
+	cmpwi	cr0, r3, 0
+	cmpwi	cr1, r4, 0
+	li	r5, 0
+	beq	cr0, 1f
+	stw	r5, 0(r3)
+1:	li	r3, 0			/* always success */
+	crclr	cr0*4+so
+	beqlr	cr1
+	stw	r5, 0(r4)
+	blr
+  .cfi_endproc
+V_FUNCTION_END(__kernel_getcpu)
+#endif
diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
index 00c025ba4a92..5206c2eb2a1d 100644
--- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
@@ -155,7 +155,7 @@ VERSION
 		__kernel_sync_dicache_p5;
 		__kernel_sigtramp32;
 		__kernel_sigtramp_rt32;
-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC64) || !defined(CONFIG_SMP)
 		__kernel_getcpu;
 #endif
 
-- 
2.13.3

