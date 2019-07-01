Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5146F5C27E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 20:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfGASBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 14:01:25 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:42193 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfGASBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:01:25 -0400
X-Originating-IP: 79.86.19.127
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 1EDB1240004;
        Mon,  1 Jul 2019 18:01:19 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Hanjun Guo <guohanjun@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v3 2/2] riscv: Introduce huge page support for 32/64bit kernel
Date:   Mon,  1 Jul 2019 13:59:00 -0400
Message-Id: <20190701175900.4034-3-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701175900.4034-1-alex@ghiti.fr>
References: <20190701175900.4034-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements both 4MB huge page support for 32bit kernel
and 2MB/1GB huge pages support for 64bit kernel.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/Kconfig               |  8 ++++++
 arch/riscv/include/asm/hugetlb.h | 18 +++++++++++++
 arch/riscv/include/asm/page.h    | 10 ++++++++
 arch/riscv/include/asm/pgtable.h |  8 ++++--
 arch/riscv/mm/Makefile           |  2 ++
 arch/riscv/mm/hugetlbpage.c      | 44 ++++++++++++++++++++++++++++++++
 6 files changed, 88 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/asm/hugetlb.h
 create mode 100644 arch/riscv/mm/hugetlbpage.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0c4b12205632..43395f640955 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -50,6 +50,8 @@ config RISCV
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_MMIOWB
 	select HAVE_EBPF_JIT if 64BIT
+	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 
 config MMU
 	def_bool y
@@ -64,6 +66,12 @@ config PAGE_OFFSET
 	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
 	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
 
+config ARCH_WANT_GENERAL_HUGETLB
+	def_bool y
+
+config SYS_SUPPORTS_HUGETLBFS
+	def_bool y
+
 config STACKTRACE_SUPPORT
 	def_bool y
 
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
new file mode 100644
index 000000000000..728a5db66597
--- /dev/null
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_HUGETLB_H
+#define _ASM_RISCV_HUGETLB_H
+
+#include <asm-generic/hugetlb.h>
+#include <asm/page.h>
+
+static inline int is_hugepage_only_range(struct mm_struct *mm,
+					 unsigned long addr,
+					 unsigned long len) {
+	return 0;
+}
+
+static inline void arch_clear_hugepage_flags(struct page *page)
+{
+}
+
+#endif /* _ASM_RISCV_HUGETLB_H */
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 8ddb6c7fedac..8551f69049ee 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -16,6 +16,16 @@
 #define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE - 1))
 
+#ifdef CONFIG_64BIT
+#define HUGE_MAX_HSTATE		2
+#else
+#define HUGE_MAX_HSTATE		1
+#endif
+#define HPAGE_SHIFT		PMD_SHIFT
+#define HPAGE_SIZE		(_AC(1, UL) << HPAGE_SHIFT)
+#define HPAGE_MASK              (~(HPAGE_SIZE - 1))
+#define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)
+
 /*
  * PAGE_OFFSET -- the first address of the first page of memory.
  * When not using MMU this corresponds to the first free page in
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index f7c3f7de15f2..18ea56fabba8 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -113,7 +113,6 @@ static inline void pmd_clear(pmd_t *pmdp)
 	set_pmd(pmdp, __pmd(0));
 }
 
-
 static inline pgd_t pfn_pgd(unsigned long pfn, pgprot_t prot)
 {
 	return __pgd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
@@ -250,6 +249,11 @@ static inline pte_t pte_mkspecial(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_SPECIAL);
 }
 
+static inline pte_t pte_mkhuge(pte_t pte)
+{
+	return pte;
+}
+
 /* Modify page protection bits */
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
@@ -409,7 +413,7 @@ static inline void pgtable_cache_init(void)
 #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
 
 /*
- * Task size is 0x40000000000 for RV64 or 0xb800000 for RV32.
+ * Task size is 0x4000000000 for RV64 or 0xb800000 for RV32.
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
  */
 #ifdef CONFIG_64BIT
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index fc51d3b7876e..74055e1d6f21 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -12,3 +12,5 @@ obj-y += ioremap.o
 obj-y += cacheflush.o
 obj-y += context.o
 obj-y += sifive_l2_cache.o
+
+obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
new file mode 100644
index 000000000000..0d4747e9d5b5
--- /dev/null
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/hugetlb.h>
+#include <linux/err.h>
+
+int pud_huge(pud_t pud)
+{
+	return pud_present(pud) &&
+		(pud_val(pud) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
+}
+
+int pmd_huge(pmd_t pmd)
+{
+	return pmd_present(pmd) &&
+		(pmd_val(pmd) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
+}
+
+static __init int setup_hugepagesz(char *opt)
+{
+	unsigned long ps = memparse(opt, &opt);
+
+	if (ps == HPAGE_SIZE) {
+		hugetlb_add_hstate(HPAGE_SHIFT - PAGE_SHIFT);
+	} else if (IS_ENABLED(CONFIG_64BIT) && ps == PUD_SIZE) {
+		hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
+	} else {
+		hugetlb_bad_size();
+		pr_err("hugepagesz: Unsupported page size %lu M\n", ps >> 20);
+		return 0;
+	}
+
+	return 1;
+}
+__setup("hugepagesz=", setup_hugepagesz);
+
+#ifdef CONFIG_CONTIG_ALLOC
+static __init int gigantic_pages_init(void)
+{
+	/* With CONTIG_ALLOC, we can allocate gigantic pages at runtime */
+	if (IS_ENABLED(CONFIG_64BIT) && !size_to_hstate(1UL << PUD_SHIFT))
+		hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
+	return 0;
+}
+arch_initcall(gigantic_pages_init);
+#endif
-- 
2.20.1

