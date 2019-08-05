Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1828C81244
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 08:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfHEG1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 02:27:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4169 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727386AbfHEG0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 02:26:44 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2D11D5AC1884040C1DD1;
        Mon,  5 Aug 2019 14:26:42 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 5 Aug 2019
 14:26:32 +0800
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
Subject: [PATCH v4 08/10] powerpc/fsl_booke/kaslr: clear the original kernel if randomized
Date:   Mon, 5 Aug 2019 14:43:33 +0800
Message-ID: <20190805064335.19156-9-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190805064335.19156-1-yanaijie@huawei.com>
References: <20190805064335.19156-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original kernel still exists in the memory, clear it now.

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
 arch/powerpc/kernel/kaslr_booke.c  | 11 +++++++++++
 arch/powerpc/mm/mmu_decl.h         |  2 ++
 arch/powerpc/mm/nohash/fsl_booke.c |  1 +
 3 files changed, 14 insertions(+)

diff --git a/arch/powerpc/kernel/kaslr_booke.c b/arch/powerpc/kernel/kaslr_booke.c
index 97250cad71de..4b3f19a663fc 100644
--- a/arch/powerpc/kernel/kaslr_booke.c
+++ b/arch/powerpc/kernel/kaslr_booke.c
@@ -400,3 +400,14 @@ notrace void __init kaslr_early_init(void *dt_ptr, phys_addr_t size)
 
 	reloc_kernel_entry(dt_ptr, kimage_vaddr);
 }
+
+void __init kaslr_late_init(void)
+{
+	/* If randomized, clear the original kernel */
+	if (kimage_vaddr != KERNELBASE) {
+		unsigned long kernel_sz;
+
+		kernel_sz = (unsigned long)_end - kimage_vaddr;
+		memzero_explicit((void *)KERNELBASE, kernel_sz);
+	}
+}
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 9332772c8a66..f0a461482dba 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -150,8 +150,10 @@ extern void loadcam_multi(int first_idx, int num, int tmp_idx);
 
 #ifdef CONFIG_RANDOMIZE_BASE
 void kaslr_early_init(void *dt_ptr, phys_addr_t size);
+void kaslr_late_init(void);
 #else
 static inline void kaslr_early_init(void *dt_ptr, phys_addr_t size) {}
+static inline void kaslr_late_init(void) {}
 #endif
 
 struct tlbcam {
diff --git a/arch/powerpc/mm/nohash/fsl_booke.c b/arch/powerpc/mm/nohash/fsl_booke.c
index 8d25a8dc965f..e88fcc367600 100644
--- a/arch/powerpc/mm/nohash/fsl_booke.c
+++ b/arch/powerpc/mm/nohash/fsl_booke.c
@@ -269,6 +269,7 @@ notrace void __init relocate_init(u64 dt_ptr, phys_addr_t start)
 	kernstart_addr = start;
 	if (is_second_reloc) {
 		virt_phys_offset = PAGE_OFFSET - memstart_addr;
+		kaslr_late_init();
 		return;
 	}
 
-- 
2.17.2

