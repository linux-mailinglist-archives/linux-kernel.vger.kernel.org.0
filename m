Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 055A44B35A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 09:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbfFSHti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 03:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731267AbfFSHtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:49:35 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED8DC214AF;
        Wed, 19 Jun 2019 07:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560930574;
        bh=P7J40zDdVIIVBEKLCUV01XijVZSHIuu34tttSMG70s8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ili9stQb92UgNDJmlISC0Cmm5qsQbyVt95diC+B7hs2lAveaUv05v1Wpil27IvN+
         R0wKnMymchmd7qo39NPAuGqn1F3HENi8dOLAqVeQ0fDCw92UgMbc8ZirV/NUhOrCtC
         ebdwaLS3KTVKuCqXE4gaZsCpTtVsIIhlTESsoVWA=
From:   guoren@kernel.org
To:     julien.grall@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc:     linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 3/4] csky: Use generic asid algorithm to implement switch_mm
Date:   Wed, 19 Jun 2019 15:49:12 +0800
Message-Id: <1560930553-26502-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560930553-26502-1-git-send-email-guoren@kernel.org>
References: <1560930553-26502-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Use linux generic asid/vmid algorithm to implement csky
switch_mm function. The algorithm is from arm and it could
work with SMP system. It'll help reduce tlb flush for
switch_mm in task/vm switch.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Julien Grall <julien.grall@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/abiv1/inc/abi/ckmmu.h     |  6 +++++
 arch/csky/abiv2/inc/abi/ckmmu.h     | 10 ++++++++
 arch/csky/include/asm/mmu.h         |  1 +
 arch/csky/include/asm/mmu_context.h | 12 ++++++++--
 arch/csky/mm/Makefile               |  1 +
 arch/csky/mm/context.c              | 46 +++++++++++++++++++++++++++++++++++++
 6 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100644 arch/csky/mm/context.c

diff --git a/arch/csky/abiv1/inc/abi/ckmmu.h b/arch/csky/abiv1/inc/abi/ckmmu.h
index 81f3771..ba8eb58 100644
--- a/arch/csky/abiv1/inc/abi/ckmmu.h
+++ b/arch/csky/abiv1/inc/abi/ckmmu.h
@@ -78,6 +78,12 @@ static inline void tlb_invalid_all(void)
 	cpwcr("cpcr8", 0x04000000);
 }
 
+
+static inline void local_tlb_invalid_all(void)
+{
+	tlb_invalid_all();
+}
+
 static inline void tlb_invalid_indexed(void)
 {
 	cpwcr("cpcr8", 0x02000000);
diff --git a/arch/csky/abiv2/inc/abi/ckmmu.h b/arch/csky/abiv2/inc/abi/ckmmu.h
index e4480e6..73ded7c 100644
--- a/arch/csky/abiv2/inc/abi/ckmmu.h
+++ b/arch/csky/abiv2/inc/abi/ckmmu.h
@@ -85,6 +85,16 @@ static inline void tlb_invalid_all(void)
 #endif
 }
 
+static inline void local_tlb_invalid_all(void)
+{
+#ifdef CONFIG_CPU_HAS_TLBI
+	asm volatile("tlbi.all\n":::"memory");
+	sync_is();
+#else
+	tlb_invalid_all();
+#endif
+}
+
 static inline void tlb_invalid_indexed(void)
 {
 	mtcr("cr<8, 15>", 0x02000000);
diff --git a/arch/csky/include/asm/mmu.h b/arch/csky/include/asm/mmu.h
index 06f509a..b382a14 100644
--- a/arch/csky/include/asm/mmu.h
+++ b/arch/csky/include/asm/mmu.h
@@ -5,6 +5,7 @@
 #define __ASM_CSKY_MMU_H
 
 typedef struct {
+	atomic64_t	asid;
 	void *vdso;
 } mm_context_t;
 
diff --git a/arch/csky/include/asm/mmu_context.h b/arch/csky/include/asm/mmu_context.h
index 86dde48..0285b0a 100644
--- a/arch/csky/include/asm/mmu_context.h
+++ b/arch/csky/include/asm/mmu_context.h
@@ -20,20 +20,28 @@
 #define TLBMISS_HANDLER_SETUP_PGD_KERNEL(pgd) \
 	setup_pgd(__pa(pgd), true)
 
-#define init_new_context(tsk,mm)	0
+#define ASID_MASK		((1 << CONFIG_CPU_ASID_BITS) - 1)
+#define cpu_asid(mm)		(atomic64_read(&mm->context.asid) & ASID_MASK)
+
+#define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.asid, 0); 0; })
 #define activate_mm(prev,next)		switch_mm(prev, next, current)
 
 #define destroy_context(mm)		do {} while (0)
 #define enter_lazy_tlb(mm, tsk)		do {} while (0)
 #define deactivate_mm(tsk, mm)		do {} while (0)
 
+void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
+
 static inline void
 switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	  struct task_struct *tsk)
 {
+	unsigned int cpu = smp_processor_id();
+
 	if (prev != next)
-		tlb_invalid_all();
+		check_and_switch_context(next, cpu);
 
 	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
+	write_mmu_entryhi(next->context.asid.counter);
 }
 #endif /* __ASM_CSKY_MMU_CONTEXT_H */
diff --git a/arch/csky/mm/Makefile b/arch/csky/mm/Makefile
index 897368f..34cb5b1 100644
--- a/arch/csky/mm/Makefile
+++ b/arch/csky/mm/Makefile
@@ -12,3 +12,4 @@ obj-y +=			ioremap.o
 obj-y +=			syscache.o
 obj-y +=			tlb.o
 obj-y +=			asid.o
+obj-y +=			context.o
diff --git a/arch/csky/mm/context.c b/arch/csky/mm/context.c
new file mode 100644
index 0000000..28ae9f0
--- /dev/null
+++ b/arch/csky/mm/context.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/bitops.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+
+#include <asm/asid.h>
+#include <asm/mmu_context.h>
+#include <asm/smp.h>
+#include <asm/tlbflush.h>
+
+static DEFINE_PER_CPU(atomic64_t, active_asids);
+static DEFINE_PER_CPU(u64, reserved_asids);
+
+struct asid_info asid_info;
+
+void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
+{
+	asid_check_context(&asid_info, &mm->context.asid, cpu);
+}
+
+static void asid_flush_cpu_ctxt(void)
+{
+	local_tlb_invalid_all();
+}
+
+static int asids_init(void)
+{
+	BUG_ON((1 << CONFIG_CPU_ASID_BITS - 1) <= num_possible_cpus());
+
+	if (asid_allocator_init(&asid_info, CONFIG_CPU_ASID_BITS, 1,
+				asid_flush_cpu_ctxt))
+		panic("Unable to initialize ASID allocator for %lu ASIDs\n",
+		      NUM_ASIDS(&asid_info));
+
+	asid_info.active = &active_asids;
+	asid_info.reserved = &reserved_asids;
+
+	pr_info("ASID allocator initialised with %lu entries\n",
+		NUM_CTXT_ASIDS(&asid_info));
+
+	return 0;
+}
+early_initcall(asids_init);
-- 
2.7.4

