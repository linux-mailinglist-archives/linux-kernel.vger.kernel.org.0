Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1230674788
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 08:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfGYG4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 02:56:24 -0400
Received: from foss.arm.com ([217.140.110.172]:52700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfGYG4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:56:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 080FB152D;
        Wed, 24 Jul 2019 23:56:23 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.42.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 765A53F71F;
        Wed, 24 Jul 2019 23:58:22 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <Mark.Brown@arm.com>,
        Steven Price <Steven.Price@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Matthew Wilcox <willy@infradead.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC] mm/pgtable/debug: Add test validating architecture page table helpers
Date:   Thu, 25 Jul 2019 12:25:23 +0530
Message-Id: <1564037723-26676-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564037723-26676-1-git-send-email-anshuman.khandual@arm.com>
References: <1564037723-26676-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a test module which will validate architecture page table helpers
and accessors regarding compliance with generic MM semantics expectations.
This will help various architectures in validating changes to the existing
page table helpers or addition of new ones.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Brown <Mark.Brown@arm.com>
Cc: Steven Price <Steven.Price@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sri Krishna chowdary <schowdary@nvidia.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 lib/Kconfig.debug       |  14 +++
 lib/Makefile            |   1 +
 lib/test_arch_pgtable.c | 290 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 lib/test_arch_pgtable.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5960e29..a27fe8d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1719,6 +1719,20 @@ config TEST_SORT
 
 	  If unsure, say N.
 
+config TEST_ARCH_PGTABLE
+	tristate "Test arch page table helpers for semantics compliance"
+	depends on MMU
+	depends on DEBUG_KERNEL || m
+	help
+	  This options provides a kernel module which can be used to test
+	  architecture page table helper functions on various platform in
+	  verifing if they comply with expected generic MM semantics. This
+	  will help architectures code in making sure that any changes or
+	  new additions of these helpers will still conform to generic MM
+	  expeted semantics.
+
+	  If unsure, say N.
+
 config KPROBES_SANITY_TEST
 	bool "Kprobes sanity tests"
 	depends on DEBUG_KERNEL
diff --git a/lib/Makefile b/lib/Makefile
index 095601c..0806d61 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
 obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
 obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
 obj-$(CONFIG_TEST_SORT) += test_sort.o
+obj-$(CONFIG_TEST_ARCH_PGTABLE) += test_arch_pgtable.o
 obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
diff --git a/lib/test_arch_pgtable.c b/lib/test_arch_pgtable.c
new file mode 100644
index 0000000..1396664
--- /dev/null
+++ b/lib/test_arch_pgtable.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This kernel module validates architecture page table helpers &
+ * accessors and helps in verifying their continued compliance with
+ * generic MM semantics.
+ *
+ * Copyright (C) 2019 ARM Ltd.
+ *
+ * Author: Anshuman Khandual <anshuman.khandual@arm.com>
+ */
+#define pr_fmt(fmt) "test_arch_pgtable: %s " fmt, __func__
+
+#include <linux/kernel.h>
+#include <linux/hugetlb.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/mm_types.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/pfn_t.h>
+#include <linux/gfp.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+
+/*
+ * Basic operations
+ *
+ * mkold(entry)			= An old and not an young entry
+ * mkyoung(entry)		= An young and not an old entry
+ * mkdirty(entry)		= A dirty and not a clean entry
+ * mkclean(entry)		= A clean and not a dirty entry
+ * mkwrite(entry)		= An write and not an write protected entry
+ * wrprotect(entry)		= An write protected and not an write entry
+ * pxx_bad(entry)		= A mapped and non-table entry
+ * pxx_same(entry1, entry2)	= Both entries hold the exact same value
+ */
+#define VMA_TEST_FLAGS (VM_READ|VM_WRITE|VM_EXEC)
+
+static struct vm_area_struct vma;
+static struct mm_struct mm;
+static struct page *page;
+static pgprot_t prot;
+static unsigned long pfn, addr;
+
+static void pte_basic_tests(void)
+{
+	pte_t pte;
+
+	pte = mk_pte(page, prot);
+	WARN_ON(!pte_same(pte, pte));
+	WARN_ON(!pte_young(pte_mkyoung(pte)));
+	WARN_ON(!pte_dirty(pte_mkdirty(pte)));
+	WARN_ON(!pte_write(pte_mkwrite(pte)));
+	WARN_ON(pte_young(pte_mkold(pte)));
+	WARN_ON(pte_dirty(pte_mkclean(pte)));
+	WARN_ON(pte_write(pte_wrprotect(pte)));
+}
+
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE
+static void pmd_basic_tests(void)
+{
+	pmd_t pmd;
+
+	pmd = mk_pmd(page, prot);
+	WARN_ON(!pmd_same(pmd, pmd));
+	WARN_ON(!pmd_young(pmd_mkyoung(pmd)));
+	WARN_ON(!pmd_dirty(pmd_mkdirty(pmd)));
+	WARN_ON(!pmd_write(pmd_mkwrite(pmd)));
+	WARN_ON(pmd_young(pmd_mkold(pmd)));
+	WARN_ON(pmd_dirty(pmd_mkclean(pmd)));
+	WARN_ON(pmd_write(pmd_wrprotect(pmd)));
+	/*
+	 * A huge page does not point to next level page table
+	 * entry. Hence this must qualify as pmd_bad().
+	 */
+	WARN_ON(!pmd_bad(pmd_mkhuge(pmd)));
+}
+#else
+static void pmd_basic_tests(void) { }
+#endif
+
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+static void pud_basic_tests(void)
+{
+	pud_t pud;
+
+	pud = pfn_pud(pfn, prot);
+	WARN_ON(!pud_same(pud, pud));
+	WARN_ON(!pud_young(pud_mkyoung(pud)));
+	WARN_ON(!pud_write(pud_mkwrite(pud)));
+	WARN_ON(pud_write(pud_wrprotect(pud)));
+	WARN_ON(pud_young(pud_mkold(pud)));
+
+#if !defined(__PAGETABLE_PMD_FOLDED) && !defined(__ARCH_HAS_4LEVEL_HACK)
+	/*
+	 * A huge page does not point to next level page table
+	 * entry. Hence this must qualify as pud_bad().
+	 */
+	WARN_ON(!pud_bad(pud_mkhuge(pud)));
+#endif
+}
+#else
+static void pud_basic_tests(void) { }
+#endif
+
+static void p4d_basic_tests(void)
+{
+	pte_t pte;
+	p4d_t p4d;
+
+	pte = mk_pte(page, prot);
+	p4d = (p4d_t) { (pte_val(pte)) };
+	WARN_ON(!p4d_same(p4d, p4d));
+}
+
+static void pgd_basic_tests(void)
+{
+	pte_t pte;
+	pgd_t pgd;
+
+	pte = mk_pte(page, prot);
+	pgd = (pgd_t) { (pte_val(pte)) };
+	WARN_ON(!pgd_same(pgd, pgd));
+}
+
+#if !defined(__PAGETABLE_PMD_FOLDED) && !defined(__ARCH_HAS_4LEVEL_HACK)
+static void pud_clear_tests(void)
+{
+	pud_t pud;
+
+	pud_clear(&pud);
+	WARN_ON(!pud_none(pud));
+}
+
+static void pud_populate_tests(void)
+{
+	pmd_t pmd;
+	pud_t pud;
+
+	/*
+	 * This entry points to next level page table page.
+	 * Hence this must not qualify as pud_bad().
+	 */
+	pmd_clear(&pmd);
+	pud_clear(&pud);
+	pud_populate(&mm, &pud, &pmd);
+	WARN_ON(pud_bad(pud));
+}
+#else
+static void pud_clear_tests(void) { }
+static void pud_populate_tests(void) { }
+#endif
+
+#if !defined(__PAGETABLE_PUD_FOLDED) && !defined(__ARCH_HAS_5LEVEL_HACK)
+static void p4d_clear_tests(void)
+{
+	p4d_t p4d;
+
+	p4d_clear(&p4d);
+	WARN_ON(!p4d_none(p4d));
+}
+
+static void p4d_populate_tests(void)
+{
+	pud_t pud;
+	p4d_t p4d;
+
+	/*
+	 * This entry points to next level page table page.
+	 * Hence this must not qualify as p4d_bad().
+	 */
+	pud_clear(&pud);
+	p4d_clear(&p4d);
+	p4d_populate(&mm, &p4d, &pud);
+	WARN_ON(p4d_bad(p4d));
+}
+#else
+static void p4d_clear_tests(void) { }
+static void p4d_populate_tests(void) { }
+#endif
+
+#ifndef __PAGETABLE_P4D_FOLDED
+static void pgd_clear_tests(void)
+{
+	pgd_t pgd;
+
+	pgd_clear(&pgd);
+	WARN_ON(!pgd_none(pgd));
+}
+
+static void pgd_populate_tests(void)
+{
+	pgd_t p4d;
+	pgd_t pgd;
+
+	/*
+	 * This entry points to next level page table page.
+	 * Hence this must not qualify as pgd_bad().
+	 */
+	p4d_clear(&p4d);
+	pgd_clear(&pgd);
+	pgd_populate(&mm, &pgd, &p4d);
+	WARN_ON(pgd_bad(pgd));
+}
+#else
+static void pgd_clear_tests(void) { }
+static void pgd_populate_tests(void) { }
+#endif
+
+static void pxx_clear_tests(void)
+{
+	pte_t pte;
+	pmd_t pmd;
+
+	pte_clear(NULL, 0, &pte);
+	WARN_ON(!pte_none(pte));
+
+	pmd_clear(&pmd);
+	WARN_ON(!pmd_none(pmd));
+
+	pud_clear_tests();
+	p4d_clear_tests();
+	pgd_clear_tests();
+}
+
+static void pxx_populate_tests(void)
+{
+	pmd_t pmd;
+
+	/*
+	 * This entry points to next level page table page.
+	 * Hence this must not qualify as pmd_bad().
+	 */
+	memset(page, 0, sizeof(*page));
+	pmd_clear(&pmd);
+	pmd_populate(&mm, &pmd, page);
+	WARN_ON(pmd_bad(pmd));
+
+	pud_populate_tests();
+	p4d_populate_tests();
+	pgd_populate_tests();
+}
+
+static int variables_alloc(void)
+{
+	vma_init(&vma, &mm);
+	prot = vm_get_page_prot(VMA_TEST_FLAGS);
+	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page) {
+		pr_err("Test struct page allocation failed\n");
+		return 1;
+	}
+	pfn = page_to_pfn(page);
+	addr = 0;
+	return 0;
+}
+
+static void variables_free(void)
+{
+	free_page((unsigned long)page_address(page));
+}
+
+static int __init arch_pgtable_tests_init(void)
+{
+	int ret;
+
+	ret = variables_alloc();
+	if (ret) {
+		pr_err("Test resource initialization failed\n");
+		return 1;
+	}
+
+	pte_basic_tests();
+	pmd_basic_tests();
+	pud_basic_tests();
+	p4d_basic_tests();
+	pgd_basic_tests();
+	pxx_clear_tests();
+	pxx_populate_tests();
+	variables_free();
+	return 0;
+}
+
+static void __exit arch_pgtable_tests_exit(void) { }
+
+module_init(arch_pgtable_tests_init);
+module_exit(arch_pgtable_tests_exit);
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

