Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6BDADC247
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 12:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633365AbfJRKNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 06:13:35 -0400
Received: from [217.140.110.172] ([217.140.110.172]:60896 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2633351AbfJRKNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:13:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 647664B2;
        Fri, 18 Oct 2019 03:13:12 -0700 (PDT)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D00983F6C4;
        Fri, 18 Oct 2019 03:13:09 -0700 (PDT)
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
Subject: [PATCH v12 04/22] arm64: mm: Add p?d_leaf() definitions
Date:   Fri, 18 Oct 2019 11:12:30 +0100
Message-Id: <20191018101248.33727-5-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018101248.33727-1-steven.price@arm.com>
References: <20191018101248.33727-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information will be provided by the
p?d_leaf() functions/macros.

For arm64, we already have p?d_sect() macros which we can reuse for
p?d_leaf().

pud_sect() is defined as a dummy function when CONFIG_PGTABLE_LEVELS < 3
or CONFIG_ARM64_64K_PAGES is defined. However when the kernel is
configured this way then architecturally it isn't allowed to have a
large page at this level, and any code using these page walking macros
is implicitly relying on the page size/number of levels being the same as
the kernel. So it is safe to reuse this for p?d_leaf() as it is an
architectural restriction.

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will@kernel.org>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7576df00eb50..fe1da5010b18 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -462,6 +462,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				 PMD_TYPE_TABLE)
 #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
 				 PMD_TYPE_SECT)
+#define pmd_leaf(pmd)		pmd_sect(pmd)
 
 #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
 static inline bool pud_sect(pud_t pud) { return false; }
@@ -546,6 +547,7 @@ static inline void pte_unmap(pte_t *pte) { }
 #define pud_none(pud)		(!pud_val(pud))
 #define pud_bad(pud)		(!(pud_val(pud) & PUD_TABLE_BIT))
 #define pud_present(pud)	pte_present(pud_pte(pud))
+#define pud_leaf(pud)		pud_sect(pud)
 #define pud_valid(pud)		pte_valid(pud_pte(pud))
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
-- 
2.20.1

