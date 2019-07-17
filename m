Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC5E6B790
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 09:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfGQHt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 03:49:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2279 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727753AbfGQHtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 03:49:25 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DB25CE1F6348E98241FB;
        Wed, 17 Jul 2019 15:49:23 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 17 Jul 2019
 15:49:15 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <diana.craciun@nxp.com>, <christophe.leroy@c-s.fr>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>
CC:     <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <yebin10@huawei.com>, <thunder.leizhen@huawei.com>,
        <jingxiangfeng@huawei.com>, <fanchengyang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: [RFC PATCH 05/10] powerpc/fsl_booke/32: introduce reloc_kernel_entry() helper
Date:   Wed, 17 Jul 2019 16:06:16 +0800
Message-ID: <20190717080621.40424-6-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190717080621.40424-1-yanaijie@huawei.com>
References: <20190717080621.40424-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new helper reloc_kernel_entry() to jump back to the start of the
new kernel. After we put the new kernel in a randomized place we can use
this new helper to enter the kernel and begin to relocate again.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Cc: Diana Craciun <diana.craciun@nxp.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/kernel/head_fsl_booke.S | 16 ++++++++++++++++
 arch/powerpc/mm/mmu_decl.h           |  1 +
 2 files changed, 17 insertions(+)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index a57d44638031..ce40f96dae20 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -1144,6 +1144,22 @@ _GLOBAL(create_tlb_entry)
 	sync
 	blr
 
+/*
+ * Return to the start of the relocated kernel and run again
+ * r3 - virtual address of fdt
+ * r4 - entry of the kernel
+ */
+_GLOBAL(reloc_kernel_entry)
+	mfmsr	r7
+	li	r8,(MSR_IS | MSR_DS)
+	andc	r7,r7,r8
+
+	mtspr	SPRN_SRR0,r4
+	mtspr	SPRN_SRR1,r7
+	isync
+	sync
+	rfi
+
 /*
  * Create a tlb entry with the same effective and physical address as
  * the tlb entry used by the current running code. But set the TS to 1.
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index d7737cf97cee..dae8e9177574 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -143,6 +143,7 @@ extern void adjust_total_lowmem(void);
 extern int switch_to_as1(void);
 extern void restore_to_as0(int esel, int offset, void *dt_ptr, int bootcpu);
 extern void create_tlb_entry(phys_addr_t phys, unsigned long virt, int entry);
+extern void reloc_kernel_entry(void *fdt, int addr);
 #endif
 extern void loadcam_entry(unsigned int index);
 extern void loadcam_multi(int first_idx, int num, int tmp_idx);
-- 
2.17.2

