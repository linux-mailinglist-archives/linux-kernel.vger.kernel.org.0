Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C413876AA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 11:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405990AbfHIJwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 05:52:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726164AbfHIJv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:51:59 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0EB28268C8A2CAD4D479;
        Fri,  9 Aug 2019 17:51:58 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 9 Aug 2019
 17:51:50 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <diana.craciun@nxp.com>, <christophe.leroy@c-s.fr>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>
CC:     <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <yebin10@huawei.com>, <thunder.leizhen@huawei.com>,
        <jingxiangfeng@huawei.com>, <fanchengyang@huawei.com>,
        <zhaohongjiang@huawei.com>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v6 01/12] powerpc: unify definition of M_IF_NEEDED
Date:   Fri, 9 Aug 2019 18:07:49 +0800
Message-ID: <20190809100800.5426-2-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190809100800.5426-1-yanaijie@huawei.com>
References: <20190809100800.5426-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

M_IF_NEEDED is defined too many times. Move it to a common place and
rename it to MAS2_M_IF_NEEDED which is much readable.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Cc: Diana Craciun <diana.craciun@nxp.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Diana Craciun <diana.craciun@nxp.com>
Tested-by: Diana Craciun <diana.craciun@nxp.com>
---
 arch/powerpc/include/asm/nohash/mmu-book3e.h  | 10 ++++++++++
 arch/powerpc/kernel/exceptions-64e.S          | 12 +-----------
 arch/powerpc/kernel/fsl_booke_entry_mapping.S | 14 ++------------
 arch/powerpc/kernel/misc_64.S                 |  7 +------
 4 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/mmu-book3e.h b/arch/powerpc/include/asm/nohash/mmu-book3e.h
index 4c9777d256fb..fa3efc2d310f 100644
--- a/arch/powerpc/include/asm/nohash/mmu-book3e.h
+++ b/arch/powerpc/include/asm/nohash/mmu-book3e.h
@@ -221,6 +221,16 @@
 #define TLBILX_T_CLASS2			6
 #define TLBILX_T_CLASS3			7
 
+/*
+ * The mapping only needs to be cache-coherent on SMP, except on
+ * Freescale e500mc derivatives where it's also needed for coherent DMA.
+ */
+#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
+#define MAS2_M_IF_NEEDED	MAS2_M
+#else
+#define MAS2_M_IF_NEEDED	0
+#endif
+
 #ifndef __ASSEMBLY__
 #include <asm/bug.h>
 
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 1cfb3da4a84a..c5bc09b5e281 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -1342,16 +1342,6 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	sync
 	isync
 
-/*
- * The mapping only needs to be cache-coherent on SMP, except on
- * Freescale e500mc derivatives where it's also needed for coherent DMA.
- */
-#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
-#define M_IF_NEEDED	MAS2_M
-#else
-#define M_IF_NEEDED	0
-#endif
-
 /* 6. Setup KERNELBASE mapping in TLB[0]
  *
  * r3 = MAS0 w/TLBSEL & ESEL for the entry we started in
@@ -1364,7 +1354,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	ori	r6,r6,(MAS1_TSIZE(BOOK3E_PAGESZ_1GB))@l
 	mtspr	SPRN_MAS1,r6
 
-	LOAD_REG_IMMEDIATE(r6, PAGE_OFFSET | M_IF_NEEDED)
+	LOAD_REG_IMMEDIATE(r6, PAGE_OFFSET | MAS2_M_IF_NEEDED)
 	mtspr	SPRN_MAS2,r6
 
 	rlwinm	r5,r5,0,0,25
diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
index ea065282b303..f4d3eaae54a9 100644
--- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
+++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
@@ -153,16 +153,6 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	tlbivax 0,r9
 	TLBSYNC
 
-/*
- * The mapping only needs to be cache-coherent on SMP, except on
- * Freescale e500mc derivatives where it's also needed for coherent DMA.
- */
-#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
-#define M_IF_NEEDED	MAS2_M
-#else
-#define M_IF_NEEDED	0
-#endif
-
 #if defined(ENTRY_MAPPING_BOOT_SETUP)
 
 /* 6. Setup KERNELBASE mapping in TLB1[0] */
@@ -171,8 +161,8 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	lis	r6,(MAS1_VALID|MAS1_IPROT)@h
 	ori	r6,r6,(MAS1_TSIZE(BOOK3E_PAGESZ_64M))@l
 	mtspr	SPRN_MAS1,r6
-	lis	r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_NEEDED)@h
-	ori	r6,r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_NEEDED)@l
+	lis	r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, MAS2_M_IF_NEEDED)@h
+	ori	r6,r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, MAS2_M_IF_NEEDED)@l
 	mtspr	SPRN_MAS2,r6
 	mtspr	SPRN_MAS3,r8
 	tlbwe
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index b55a7b4cb543..2062a299a22d 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -432,18 +432,13 @@ kexec_create_tlb:
 	rlwimi	r9,r10,16,4,15		/* Setup MAS0 = TLBSEL | ESEL(r9) */
 
 /* Set up a temp identity mapping v:0 to p:0 and return to it. */
-#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
-#define M_IF_NEEDED	MAS2_M
-#else
-#define M_IF_NEEDED	0
-#endif
 	mtspr	SPRN_MAS0,r9
 
 	lis	r9,(MAS1_VALID|MAS1_IPROT)@h
 	ori	r9,r9,(MAS1_TSIZE(BOOK3E_PAGESZ_1GB))@l
 	mtspr	SPRN_MAS1,r9
 
-	LOAD_REG_IMMEDIATE(r9, 0x0 | M_IF_NEEDED)
+	LOAD_REG_IMMEDIATE(r9, 0x0 | MAS2_M_IF_NEEDED)
 	mtspr	SPRN_MAS2,r9
 
 	LOAD_REG_IMMEDIATE(r9, 0x0 | MAS3_SR | MAS3_SW | MAS3_SX)
-- 
2.17.2

