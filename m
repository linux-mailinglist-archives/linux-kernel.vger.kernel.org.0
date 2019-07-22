Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B6F70421
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 17:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfGVPmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 11:42:53 -0400
Received: from foss.arm.com ([217.140.110.172]:40264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729797AbfGVPmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:42:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE1BE15A2;
        Mon, 22 Jul 2019 08:42:50 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 430953F694;
        Mon, 22 Jul 2019 08:42:48 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 09/21] x86: mm: Add p?d_leaf() definitions
Date:   Mon, 22 Jul 2019 16:41:58 +0100
Message-Id: <20190722154210.42799-10-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722154210.42799-1-steven.price@arm.com>
References: <20190722154210.42799-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_leaf() functions/macros.

For x86 we already have p?d_large() functions, so simply add macros to
provide the generic p?d_leaf() names for the generic code.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/x86/include/asm/pgtable.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 0bc530c4eb13..6986a451619e 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -239,6 +239,7 @@ static inline unsigned long pgd_pfn(pgd_t pgd)
 	return (pgd_val(pgd) & PTE_PFN_MASK) >> PAGE_SHIFT;
 }
 
+#define p4d_leaf	p4d_large
 static inline int p4d_large(p4d_t p4d)
 {
 	/* No 512 GiB pages yet */
@@ -247,6 +248,7 @@ static inline int p4d_large(p4d_t p4d)
 
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 
+#define pmd_leaf	pmd_large
 static inline int pmd_large(pmd_t pte)
 {
 	return pmd_flags(pte) & _PAGE_PSE;
@@ -874,6 +876,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
 	return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(address);
 }
 
+#define pud_leaf	pud_large
 static inline int pud_large(pud_t pud)
 {
 	return (pud_val(pud) & (_PAGE_PSE | _PAGE_PRESENT)) ==
@@ -885,6 +888,7 @@ static inline int pud_bad(pud_t pud)
 	return (pud_flags(pud) & ~(_KERNPG_TABLE | _PAGE_USER)) != 0;
 }
 #else
+#define pud_leaf	pud_large
 static inline int pud_large(pud_t pud)
 {
 	return 0;
@@ -1233,6 +1237,7 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 	return (((ptr & ~PAGE_MASK) / sizeof(pgd_t)) < PGD_KERNEL_START);
 }
 
+#define pgd_leaf	pgd_large
 static inline int pgd_large(pgd_t pgd) { return 0; }
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
-- 
2.20.1

