Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2697A9F0F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 18:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbfH0Q5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 12:57:35 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:39587 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729861AbfH0Q5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:57:32 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46Hw605Gqjz9txtP;
        Tue, 27 Aug 2019 18:57:28 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=wQmCwlqj; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8NKQJN2SRvVl; Tue, 27 Aug 2019 18:57:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46Hw604C6xz9txsv;
        Tue, 27 Aug 2019 18:57:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566925048; bh=PvXZzhxXa7Ew/PTb0WIWExhIvctSEcQMqLVe6+48jJI=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=wQmCwlqjT5o9SoPbO/35IWcuhh+wfUO6hQlYQbXQEA3aVtAfAseXwfRJ6AZk4Cpm0
         9p0gSAvQTNIA7PwoNo3JwINbY7jJDs18wvY2Vym+3x10GQ9u37zQNtxDDMyJGnNaW3
         SS3+jt/FIVqJqpI5lpud9YYDbim/sEmeqJIignRc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E16F8B847;
        Tue, 27 Aug 2019 18:57:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yq6dtAxUHZAM; Tue, 27 Aug 2019 18:57:30 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0D1B18B842;
        Tue, 27 Aug 2019 18:57:30 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DE510696EA; Tue, 27 Aug 2019 16:57:29 +0000 (UTC)
Message-Id: <1ed0de54ce6021fa0fdf50e938365546a4f5e316.1566925030.git.christophe.leroy@c-s.fr>
In-Reply-To: <b1142845c040b9702d1609d5ec473d97595dc0c3.1566925029.git.christophe.leroy@c-s.fr>
References: <b1142845c040b9702d1609d5ec473d97595dc0c3.1566925029.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/2] powerpc/hw_breakpoints: Rewrite 8xx breakpoints to allow
 any address range size.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        ravi.bangoria@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 27 Aug 2019 16:57:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike standard powerpc, Powerpc 8xx doesn't have SPRN_DABR, but
it has a breakpoint support based on a set of comparators which
allow more flexibility.

Commit 4ad8622dc548 ("powerpc/8xx: Implement hw_breakpoint")
implemented breakpoints by emulating the DABR behaviour. It did
this by setting one comparator the match 4 bytes at breakpoint address
and the other comparator to match 4 bytes at breakpoint address + 4.

Rewrite 8xx hw_breakpoint to make breakpoints match all addresses
defined by the breakpoint address and length by making full use of
comparators.

Now, comparator E is set to match any address greater than breakpoint
address minus one. Comparator F is set to match any address lower than
breakpoint address plus breakpoint length.

When the breakpoint range starts at address 0, the breakpoint is set
to match comparator F only. When the breakpoint range end at address
0xffffffff, the breakpoint is set to match comparator E only.
Otherwise the breakpoint is set to match comparator E and F.

At the same time, use registers bit names instead of hardcode values.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/reg_8xx.h  | 14 ++++++++++
 arch/powerpc/kernel/hw_breakpoint.c |  3 ++
 arch/powerpc/kernel/process.c       | 55 ++++++++++++++++++++++---------------
 3 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_8xx.h b/arch/powerpc/include/asm/reg_8xx.h
index abc663c0f1db..98e97c22df8b 100644
--- a/arch/powerpc/include/asm/reg_8xx.h
+++ b/arch/powerpc/include/asm/reg_8xx.h
@@ -37,7 +37,21 @@
 #define SPRN_CMPE	152
 #define SPRN_CMPF	153
 #define SPRN_LCTRL1	156
+#define   LCTRL1_CTE_GT		0xc0000000
+#define   LCTRL1_CTF_LT		0x14000000
+#define   LCTRL1_CRWE_RW	0x00000000
+#define   LCTRL1_CRWE_RO	0x00040000
+#define   LCTRL1_CRWE_WO	0x000c0000
+#define   LCTRL1_CRWF_RW	0x00000000
+#define   LCTRL1_CRWF_RO	0x00010000
+#define   LCTRL1_CRWF_WO	0x00030000
 #define SPRN_LCTRL2	157
+#define   LCTRL2_LW0EN		0x80000000
+#define   LCTRL2_LW0LA_E	0x00000000
+#define   LCTRL2_LW0LA_F	0x04000000
+#define   LCTRL2_LW0LA_EandF	0x08000000
+#define   LCTRL2_LW0LADC	0x02000000
+#define   LCTRL2_SLW0EN		0x00000002
 #ifdef CONFIG_PPC_8xx
 #define SPRN_ICTRL	158
 #endif
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 28ad3171bb82..d8bd4dbef561 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -163,6 +163,9 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 	 */
 	if (!ppc_breakpoint_available())
 		return -ENODEV;
+	/* 8xx can setup a range without limitation */
+	if (IS_ENABLED(CONFIG_PPC_8xx))
+		return 0;
 	length_max = 8; /* DABR */
 	if (dawr_enabled()) {
 		length_max = 512 ; /* 64 doublewords */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 8fc4de0d22b4..79e4f072a746 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -751,28 +751,6 @@ static inline int __set_dabr(unsigned long dabr, unsigned long dabrx)
 		mtspr(SPRN_DABRX, dabrx);
 	return 0;
 }
-#elif defined(CONFIG_PPC_8xx)
-static inline int __set_dabr(unsigned long dabr, unsigned long dabrx)
-{
-	unsigned long addr = dabr & ~HW_BRK_TYPE_DABR;
-	unsigned long lctrl1 = 0x90000000; /* compare type: equal on E & F */
-	unsigned long lctrl2 = 0x8e000002; /* watchpoint 1 on cmp E | F */
-
-	if ((dabr & HW_BRK_TYPE_RDWR) == HW_BRK_TYPE_READ)
-		lctrl1 |= 0xa0000;
-	else if ((dabr & HW_BRK_TYPE_RDWR) == HW_BRK_TYPE_WRITE)
-		lctrl1 |= 0xf0000;
-	else if ((dabr & HW_BRK_TYPE_RDWR) == 0)
-		lctrl2 = 0;
-
-	mtspr(SPRN_LCTRL2, 0);
-	mtspr(SPRN_CMPE, addr);
-	mtspr(SPRN_CMPF, addr + 4);
-	mtspr(SPRN_LCTRL1, lctrl1);
-	mtspr(SPRN_LCTRL2, lctrl2);
-
-	return 0;
-}
 #else
 static inline int __set_dabr(unsigned long dabr, unsigned long dabrx)
 {
@@ -793,6 +771,37 @@ static inline int set_dabr(struct arch_hw_breakpoint *brk)
 	return __set_dabr(dabr, dabrx);
 }
 
+static inline int set_breakpoint_8xx(struct arch_hw_breakpoint *brk)
+{
+	unsigned long lctrl1 = LCTRL1_CTE_GT | LCTRL1_CTF_LT | LCTRL1_CRWE_RW |
+			       LCTRL1_CRWF_RW;
+	unsigned long lctrl2 = LCTRL2_LW0EN | LCTRL2_LW0LADC | LCTRL2_SLW0EN;
+
+	if (brk->address == 0)
+		lctrl2 |= LCTRL2_LW0LA_F;
+	else if (brk->address + brk->len == 0)
+		lctrl2 |= LCTRL2_LW0LA_E;
+	else
+		lctrl2 |= LCTRL2_LW0LA_EandF;
+
+	mtspr(SPRN_LCTRL2, 0);
+
+	if ((brk->type & HW_BRK_TYPE_RDWR) == 0)
+		return 0;
+
+	if ((brk->type & HW_BRK_TYPE_RDWR) == HW_BRK_TYPE_READ)
+		lctrl1 |= LCTRL1_CRWE_RO | LCTRL1_CRWF_RO;
+	if ((brk->type & HW_BRK_TYPE_RDWR) == HW_BRK_TYPE_WRITE)
+		lctrl1 |= LCTRL1_CRWE_WO | LCTRL1_CRWF_WO;
+
+	mtspr(SPRN_CMPE, brk->address - 1);
+	mtspr(SPRN_CMPF, brk->address + brk->len);
+	mtspr(SPRN_LCTRL1, lctrl1);
+	mtspr(SPRN_LCTRL2, lctrl2);
+
+	return 0;
+}
+
 void __set_breakpoint(struct arch_hw_breakpoint *brk)
 {
 	memcpy(this_cpu_ptr(&current_brk), brk, sizeof(*brk));
@@ -800,6 +809,8 @@ void __set_breakpoint(struct arch_hw_breakpoint *brk)
 	if (dawr_enabled())
 		// Power8 or later
 		set_dawr(brk);
+	else if (IS_ENABLED(CONFIG_PPC_8xx))
+		set_breakpoint_8xx(brk);
 	else if (!cpu_has_feature(CPU_FTR_ARCH_207S))
 		// Power7 or earlier
 		set_dabr(brk);
-- 
2.13.3

