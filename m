Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C84A12AD78
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 06:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfE0ECm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 00:02:42 -0400
Received: from foss.arm.com ([217.140.101.70]:54464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfE0ECl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 00:02:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F0F2A78;
        Sun, 26 May 2019 21:02:39 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CE1763F690;
        Sun, 26 May 2019 21:02:36 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] arm64/mm: Drop BUG_ON() from [pmd|pud]_set_huge()
Date:   Mon, 27 May 2019 09:32:14 +0530
Message-Id: <1558929734-20051-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no callers for the functions which will pass unaligned physical
addresses. Hence just drop these BUG_ON() checks which are not required.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/mm/mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 22c2e4f0768f..629011c6238d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -978,7 +978,6 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 				   pud_val(new_pud)))
 		return 0;
 
-	BUG_ON(phys & ~PUD_MASK);
 	set_pud(pudp, new_pud);
 	return 1;
 }
@@ -992,7 +991,6 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 				   pmd_val(new_pmd)))
 		return 0;
 
-	BUG_ON(phys & ~PMD_MASK);
 	set_pmd(pmdp, new_pmd);
 	return 1;
 }
-- 
2.20.1

