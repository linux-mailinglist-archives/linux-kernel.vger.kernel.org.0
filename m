Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34D2E2DD35
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 14:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfE2Meq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 08:34:46 -0400
Received: from foss.arm.com ([217.140.101.70]:45032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfE2Mep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:34:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B81BA78;
        Wed, 29 May 2019 05:34:45 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.41.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6A3943F59C;
        Wed, 29 May 2019 05:34:42 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 1/4] arm64/mm: Drop mmap_sem before calling __do_kernel_fault()
Date:   Wed, 29 May 2019 18:04:42 +0530
Message-Id: <1559133285-27986-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559133285-27986-1-git-send-email-anshuman.khandual@arm.com>
References: <1559133285-27986-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an inconsistency between down_read_trylock() success and failure
paths while dealing with kernel access for non exception table areas where
it calls __do_kernel_fault(). In case of failure it just bails out without
holding mmap_sem but when it succeeds it does so while holding mmap_sem.
Fix this inconsistency by just dropping mmap_sem in success path as well.

__do_kernel_fault() calls die_kernel_fault() which then calls show_pte().
show_pte() in this path might become bit more unreliable without holding
mmap_sem. But there are already instances [1] in do_page_fault() where
die_kernel_fault() gets called without holding mmap_sem. show_pte() can
be made more robust independently but in a later patch.

[1] Conditional block for (is_ttbr0_addr && is_el1_permission_fault)

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/fault.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index a30818e..dc1cf32 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -503,8 +503,10 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		 */
 		might_sleep();
 #ifdef CONFIG_DEBUG_VM
-		if (!user_mode(regs) && !search_exception_tables(regs->pc))
+		if (!user_mode(regs) && !search_exception_tables(regs->pc)) {
+			up_read(&mm->mmap_sem);
 			goto no_context;
+		}
 #endif
 	}
 
-- 
2.7.4

