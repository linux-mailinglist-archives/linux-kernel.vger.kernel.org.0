Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10DFB876A7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 11:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406237AbfHIJwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 05:52:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406125AbfHIJwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:52:05 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 272EB2ECE5F4466CC0EA;
        Fri,  9 Aug 2019 17:52:03 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 9 Aug 2019
 17:51:53 +0800
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
Subject: [PATCH v6 05/12] powerpc/fsl_booke/32: introduce reloc_kernel_entry() helper
Date:   Fri, 9 Aug 2019 18:07:53 +0800
Message-ID: <20190809100800.5426-6-yanaijie@huawei.com>
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
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Diana Craciun <diana.craciun@nxp.com>
Tested-by: Diana Craciun <diana.craciun@nxp.com>
---
 arch/powerpc/kernel/head_fsl_booke.S | 13 +++++++++++++
 arch/powerpc/mm/mmu_decl.h           |  1 +
 2 files changed, 14 insertions(+)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 04d124fee17d..2083382dd662 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -1143,6 +1143,19 @@ _GLOBAL(create_tlb_entry)
 	sync
 	blr
 
+/*
+ * Return to the start of the relocated kernel and run again
+ * r3 - virtual address of fdt
+ * r4 - entry of the kernel
+ */
+_GLOBAL(reloc_kernel_entry)
+	mfmsr	r7
+	rlwinm	r7, r7, 0, ~(MSR_IS | MSR_DS)
+
+	mtspr	SPRN_SRR0,r4
+	mtspr	SPRN_SRR1,r7
+	rfi
+
 /*
  * Create a tlb entry with the same effective and physical address as
  * the tlb entry used by the current running code. But set the TS to 1.
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index a09f89d3aa0f..804da298beb3 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -143,6 +143,7 @@ extern void adjust_total_lowmem(void);
 extern int switch_to_as1(void);
 extern void restore_to_as0(int esel, int offset, void *dt_ptr, int bootcpu);
 void create_tlb_entry(phys_addr_t phys, unsigned long virt, int entry);
+void reloc_kernel_entry(void *fdt, int addr);
 #endif
 extern void loadcam_entry(unsigned int index);
 extern void loadcam_multi(int first_idx, int num, int tmp_idx);
-- 
2.17.2

