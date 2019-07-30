Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0916D7A224
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 09:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfG3HZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 03:25:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3213 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728938AbfG3HZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:25:36 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 17527BA55DB46FC03DF6;
        Tue, 30 Jul 2019 15:25:35 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 30 Jul 2019
 15:25:25 +0800
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
Subject: [PATCH v2 04/10] powerpc/fsl_booke/32: introduce create_tlb_entry() helper
Date:   Tue, 30 Jul 2019 15:42:19 +0800
Message-ID: <20190730074225.39544-5-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190730074225.39544-1-yanaijie@huawei.com>
References: <20190730074225.39544-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new helper create_tlb_entry() to create a tlb entry by the virtual
and physical address. This is a preparation to support boot kernel at a
randomized address.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Cc: Diana Craciun <diana.craciun@nxp.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/kernel/head_fsl_booke.S | 29 ++++++++++++++++++++++++++++
 arch/powerpc/mm/mmu_decl.h           |  1 +
 2 files changed, 30 insertions(+)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index adf0505dbe02..04d124fee17d 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -1114,6 +1114,35 @@ __secondary_hold_acknowledge:
 	.long	-1
 #endif
 
+/*
+ * Create a 64M tlb by address and entry
+ * r3/r4 - physical address
+ * r5 - virtual address
+ * r6 - entry
+ */
+_GLOBAL(create_tlb_entry)
+	lis     r7,0x1000               /* Set MAS0(TLBSEL) = 1 */
+	rlwimi  r7,r6,16,4,15           /* Setup MAS0 = TLBSEL | ESEL(r6) */
+	mtspr   SPRN_MAS0,r7            /* Write MAS0 */
+
+	lis     r6,(MAS1_VALID|MAS1_IPROT)@h
+	ori     r6,r6,(MAS1_TSIZE(BOOK3E_PAGESZ_64M))@l
+	mtspr   SPRN_MAS1,r6            /* Write MAS1 */
+
+	lis     r6,MAS2_EPN_MASK(BOOK3E_PAGESZ_64M)@h
+	ori     r6,r6,MAS2_EPN_MASK(BOOK3E_PAGESZ_64M)@l
+	and     r6,r6,r5
+	ori	r6,r6,MAS2_M@l
+	mtspr   SPRN_MAS2,r6            /* Write MAS2(EPN) */
+
+	ori     r8,r4,(MAS3_SW|MAS3_SR|MAS3_SX)
+	mtspr   SPRN_MAS3,r8            /* Write MAS3(RPN) */
+
+	tlbwe                           /* Write TLB */
+	isync
+	sync
+	blr
+
 /*
  * Create a tlb entry with the same effective and physical address as
  * the tlb entry used by the current running code. But set the TS to 1.
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 32c1a191c28a..a09f89d3aa0f 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -142,6 +142,7 @@ extern unsigned long calc_cam_sz(unsigned long ram, unsigned long virt,
 extern void adjust_total_lowmem(void);
 extern int switch_to_as1(void);
 extern void restore_to_as0(int esel, int offset, void *dt_ptr, int bootcpu);
+void create_tlb_entry(phys_addr_t phys, unsigned long virt, int entry);
 #endif
 extern void loadcam_entry(unsigned int index);
 extern void loadcam_multi(int first_idx, int num, int tmp_idx);
-- 
2.17.2

