Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12EBBD17AF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 20:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbfJISny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 14:43:54 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:48738 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728804AbfJISny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 14:43:54 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A8F42C0161;
        Wed,  9 Oct 2019 18:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1570646633; bh=z/IWOeKhq4peAhuuLCtaYHRBzB8hgA55HCXWFihVAJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+c3tq+5m56Mv/qT4UTC2Ab9/9O4fRh9+OIZx/tFgTUVDPb4WnJWXrsfDr01itju7
         +m7+BbfTjV1ovUbeg0yEtktwkujtLbUB3DL+JR9KQPYfZ/csuoulLUqJuGhT1JvlQO
         lUiIPS0/o5L+rim9+MfoOQCEa3lupHVO3LbWkgwLgAC9pVQxpfTcTQUVW8+Tash/jx
         3/MDMAZkbqHhMOXTN2dZYnOpfu3Hr6X236pQ30oDvW10PnTfs5bcflja1NtWQbvT1L
         yr2Td7dfjdbKUc8732j6Hc/aG6QHCH2D+Lq9YtISpetf/tRK7QmaStRWkPNOMUMjYC
         78Xmzw/ugkKtA==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.61])
        by mailhost.synopsys.com (Postfix) with ESMTP id 94C19A006B;
        Wed,  9 Oct 2019 18:43:52 +0000 (UTC)
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v2] ARC: mm: remove __ARCH_USE_5LEVEL_HACK
Date:   Wed,  9 Oct 2019 11:43:50 -0700
Message-Id: <20191009184350.18323-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <adaa82a2-b143-d49f-f38c-24ef52a200b8@gmail.com>
References: <adaa82a2-b143-d49f-f38c-24ef52a200b8@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the intermediate p4d accessors to make it 5 level compliant.

This is a non-functional change anyways since ARC has software page walker
with 2 lookup levels (pgd -> pte)

There is slight code bloat due to pulling in needless p*d_free_tlb()
macros which needs to be addressed seperately.

| bloat-o-meter2 vmlinux-with-5LEVEL_HACK vmlinux-patched
| add/remove: 0/0 grow/shrink: 2/0 up/down: 128/0 (128)
| function                                     old     new   delta
| free_pgd_range                               546     656    +110
| p4d_clear_bad                                  2      20     +18
| Total: Before=4137148, After=4137276, chg 0.000000%

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
v2 <- v1:
  - fix highmem code
---
 arch/arc/include/asm/pgtable.h |  1 -
 arch/arc/mm/fault.c            | 10 ++++++++--
 arch/arc/mm/highmem.c          |  4 +++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index 976b5931372e..902d45428cea 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -33,7 +33,6 @@
 #define _ASM_ARC_PGTABLE_H
 
 #include <linux/bits.h>
-#define __ARCH_USE_5LEVEL_HACK
 #include <asm-generic/pgtable-nopmd.h>
 #include <asm/page.h>
 #include <asm/mmu.h>	/* to propagate CONFIG_ARC_MMU_VER <n> */
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 3861543b66a0..fb86bc3e9b35 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -30,6 +30,7 @@ noinline static int handle_kernel_vaddr_fault(unsigned long address)
 	 * with the 'reference' page table.
 	 */
 	pgd_t *pgd, *pgd_k;
+	p4d_t *p4d, *p4d_k;
 	pud_t *pud, *pud_k;
 	pmd_t *pmd, *pmd_k;
 
@@ -39,8 +40,13 @@ noinline static int handle_kernel_vaddr_fault(unsigned long address)
 	if (!pgd_present(*pgd_k))
 		goto bad_area;
 
-	pud = pud_offset(pgd, address);
-	pud_k = pud_offset(pgd_k, address);
+	p4d = p4d_offset(pgd, address);
+	p4d_k = p4d_offset(pgd_k, address);
+	if (!p4d_present(*p4d_k))
+		goto bad_area;
+
+	pud = pud_offset(p4d, address);
+	pud_k = pud_offset(p4d_k, address);
 	if (!pud_present(*pud_k))
 		goto bad_area;
 
diff --git a/arch/arc/mm/highmem.c b/arch/arc/mm/highmem.c
index a4856bfaedf3..69397c884a7b 100644
--- a/arch/arc/mm/highmem.c
+++ b/arch/arc/mm/highmem.c
@@ -111,12 +111,14 @@ EXPORT_SYMBOL(__kunmap_atomic);
 static noinline pte_t * __init alloc_kmap_pgtable(unsigned long kvaddr)
 {
 	pgd_t *pgd_k;
+	p4d_t *p4d_k;
 	pud_t *pud_k;
 	pmd_t *pmd_k;
 	pte_t *pte_k;
 
 	pgd_k = pgd_offset_k(kvaddr);
-	pud_k = pud_offset(pgd_k, kvaddr);
+	p4d_k = p4d_offset(pgd_k, address);
+	pud_k = pud_offset(p4d_k, kvaddr);
 	pmd_k = pmd_offset(pud_k, kvaddr);
 
 	pte_k = (pte_t *)memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
-- 
2.20.1

