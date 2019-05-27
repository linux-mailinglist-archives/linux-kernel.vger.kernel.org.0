Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF8F62AF22
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 09:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfE0HEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 03:04:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56960 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfE0HEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:04:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF7A7374;
        Mon, 27 May 2019 00:04:04 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 840713F59C;
        Mon, 27 May 2019 00:04:02 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH V2] arm64/mm: Change BUG_ON() to VM_BUG_ON() in [pmd|pud]_set_huge()
Date:   Mon, 27 May 2019 12:33:29 +0530
Message-Id: <1558940609-30872-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no callers for the functions which will pass unaligned physical
addresses. Hence just change these BUG_ON() checks into VM_BUG_ON() which
gets compiled out unless CONFIG_VM_DEBUG is enabled.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
Changes in V2:

- Use VM_BUG_ON() instead of BUG_ON() as per Ard Biesheuvel

 arch/arm64/mm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a1bfc44..2637ff3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -980,7 +980,7 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 				   pud_val(new_pud)))
 		return 0;
 
-	BUG_ON(phys & ~PUD_MASK);
+	VM_BUG_ON(phys & ~PUD_MASK);
 	set_pud(pudp, new_pud);
 	return 1;
 }
@@ -996,7 +996,7 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 				   pmd_val(new_pmd)))
 		return 0;
 
-	BUG_ON(phys & ~PMD_MASK);
+	VM_BUG_ON(phys & ~PMD_MASK);
 	set_pmd(pmdp, new_pmd);
 	return 1;
 }
-- 
2.7.4

