Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53A02FD880
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 10:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfKOJLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 04:11:24 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:32904 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727257AbfKOJLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:11:05 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4112C8B9E5F47883C282;
        Fri, 15 Nov 2019 17:11:03 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 15 Nov 2019
 17:10:54 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <diana.craciun@nxp.com>, <christophe.leroy@c-s.fr>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>
CC:     <linux-kernel@vger.kernel.org>, <oss@buserror.net>,
        Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 3/6] powerpc/fsl_booke/64: implement KASLR for fsl_booke64
Date:   Fri, 15 Nov 2019 17:32:06 +0800
Message-ID: <20191115093209.26434-4-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191115093209.26434-1-yanaijie@huawei.com>
References: <20191115093209.26434-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation for Freescale BookE64 is similar as BookE32. One
difference is that Freescale BookE64 set up a TLB mapping of 1G during
booting. Another difference is that ppc64 needs the kernel to be
64K-aligned. So we can randomize the kernel in this 1G mapping and make
it 64K-aligned. This can save some code to creat another TLB map at
early boot. The disadvantage is that we only have about 1G/64K = 16384
slots to put the kernel in.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Cc: Scott Wood <oss@buserror.net>
Cc: Diana Craciun <diana.craciun@nxp.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/Kconfig                 |  2 +-
 arch/powerpc/kernel/setup_64.c       |  4 +++-
 arch/powerpc/mm/nohash/kaslr_booke.c | 29 ++++++++++++++++++++++++++--
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 4c4a0fcd1674..3e563a07cb67 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -553,7 +553,7 @@ config RELOCATABLE
 
 config RANDOMIZE_BASE
 	bool "Randomize the address of the kernel image"
-	depends on (FSL_BOOKE && FLATMEM && PPC32)
+	depends on (PPC_FSL_BOOK3E && FLATMEM)
 	depends on RELOCATABLE
 	help
 	  Randomizes the virtual address at which the kernel image is
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index d2af4c228970..b7e4f1e92c7e 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -65,7 +65,7 @@
 #include <asm/hw_irq.h>
 #include <asm/feature-fixups.h>
 #include <asm/kup.h>
-
+#include <mm/mmu_decl.h>
 #include "setup.h"
 
 int spinning_secondaries;
@@ -299,6 +299,8 @@ void __init early_setup(unsigned long dt_ptr)
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
 
+	kaslr_early_init(__va(dt_ptr), 0);
+
 	udbg_printf(" -> %s(), dt_ptr: 0x%lx\n", __func__, dt_ptr);
 
 	/*
diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
index 07b036e98353..513f4616e92a 100644
--- a/arch/powerpc/mm/nohash/kaslr_booke.c
+++ b/arch/powerpc/mm/nohash/kaslr_booke.c
@@ -265,14 +265,14 @@ static unsigned long __init kaslr_legal_offset(void *dt_ptr, unsigned long rando
 {
 	unsigned long koffset = 0;
 	unsigned long start;
-	unsigned long index;
 	unsigned long offset;
 
+#ifdef CONFIG_PPC32
 	/*
 	 * Decide which 64M we want to start
 	 * Only use the low 8 bits of the random seed
 	 */
-	index = random & 0xFF;
+	unsigned long index = random & 0xFF;
 	index %= regions.linear_sz / SZ_64M;
 
 	/* Decide offset inside 64M */
@@ -287,6 +287,15 @@ static unsigned long __init kaslr_legal_offset(void *dt_ptr, unsigned long rando
 			break;
 		index--;
 	}
+#else
+	/* Decide kernel offset inside 1G */
+	offset = random % (SZ_1G - regions.kernel_size);
+	offset = round_down(offset, SZ_64K);
+
+	start = memstart_addr;
+	offset = memstart_addr + offset;
+	koffset = get_usable_address(dt_ptr, start, offset);
+#endif
 
 	if (koffset != 0)
 		koffset -= memstart_addr;
@@ -325,6 +334,7 @@ static unsigned long __init kaslr_choose_location(void *dt_ptr, phys_addr_t size
 	else
 		pr_warn("KASLR: No safe seed for randomizing the kernel base.\n");
 
+#ifdef CONFIG_PPC32
 	ram = min_t(phys_addr_t, __max_low_memory, size);
 	ram = map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM, true);
 	linear_sz = min_t(unsigned long, ram, SZ_512M);
@@ -332,6 +342,7 @@ static unsigned long __init kaslr_choose_location(void *dt_ptr, phys_addr_t size
 	/* If the linear size is smaller than 64M, do not randmize */
 	if (linear_sz < SZ_64M)
 		return 0;
+#endif
 
 	/* check for a reserved-memory node and record its cell sizes */
 	regions.reserved_mem = fdt_path_offset(dt_ptr, "/reserved-memory");
@@ -363,6 +374,18 @@ notrace void __init kaslr_early_init(void *dt_ptr, phys_addr_t size)
 	unsigned long offset;
 	unsigned long kernel_sz;
 
+#ifdef CONFIG_PPC64
+	unsigned int *__run_at_load = (unsigned int *)(KERNELBASE + 0x5c);
+
+	if (*__run_at_load == 1)
+		return;
+
+	*__run_at_load = 1;
+
+	/* Setup flat device-tree pointer */
+	initial_boot_params = dt_ptr;
+#endif
+
 	kernel_sz = (unsigned long)_end - (unsigned long)_stext;
 
 	offset = kaslr_choose_location(dt_ptr, size, kernel_sz);
@@ -372,6 +395,7 @@ notrace void __init kaslr_early_init(void *dt_ptr, phys_addr_t size)
 	kernstart_virt_addr += offset;
 	kernstart_addr += offset;
 
+#ifdef CONFIG_PPC32
 	is_second_reloc = 1;
 
 	if (offset >= SZ_64M) {
@@ -381,6 +405,7 @@ notrace void __init kaslr_early_init(void *dt_ptr, phys_addr_t size)
 		/* Create kernel map to relocate in */
 		create_kaslr_tlb_entry(1, tlb_virt, tlb_phys);
 	}
+#endif
 
 	/* Copy the kernel to it's new location and run */
 	memcpy((void *)kernstart_virt_addr, (void *)_stext, kernel_sz);
-- 
2.17.2

