Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5882DD38
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 14:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfE2Mex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 08:34:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45062 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfE2Mew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:34:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E55A8A78;
        Wed, 29 May 2019 05:34:51 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.41.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 459E63F59C;
        Wed, 29 May 2019 05:34:48 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 3/4] arm64/mm: Consolidate page fault information capture
Date:   Wed, 29 May 2019 18:04:44 +0530
Message-Id: <1559133285-27986-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559133285-27986-1-git-send-email-anshuman.khandual@arm.com>
References: <1559133285-27986-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This consolidates page fault information capture and move them bit earlier.
While here it also adds an wrapper is_write_abort(). It also saves some
cycles by replacing multiple user_mode() calls into a single one earlier
during the fault.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com> 
Cc: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/fault.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index da02678..170c71f 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -435,6 +435,11 @@ static bool is_el0_instruction_abort(unsigned int esr)
 	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_LOW;
 }
 
+static bool is_write_abort(unsigned int esr)
+{
+	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
+}
+
 static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 				   struct pt_regs *regs)
 {
@@ -443,6 +448,9 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	vm_fault_t fault, major = 0;
 	unsigned long vm_flags = VM_READ | VM_WRITE;
 	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
+	bool is_user = user_mode(regs);
+	bool is_el0_exec = is_el0_instruction_abort(esr);
+	bool is_write = is_write_abort(esr);
 
 	if (notify_page_fault(regs, esr))
 		return 0;
@@ -454,12 +462,12 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	if (faulthandler_disabled() || !mm)
 		goto no_context;
 
-	if (user_mode(regs))
+	if (is_user)
 		mm_flags |= FAULT_FLAG_USER;
 
-	if (is_el0_instruction_abort(esr)) {
+	if (is_el0_exec) {
 		vm_flags = VM_EXEC;
-	} else if ((esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM)) {
+	} else if (is_write) {
 		vm_flags = VM_WRITE;
 		mm_flags |= FAULT_FLAG_WRITE;
 	}
@@ -487,7 +495,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	 * we can bug out early if this is from code which shouldn't.
 	 */
 	if (!down_read_trylock(&mm->mmap_sem)) {
-		if (!user_mode(regs) && !search_exception_tables(regs->pc))
+		if (!is_user && !search_exception_tables(regs->pc))
 			goto no_context;
 retry:
 		down_read(&mm->mmap_sem);
@@ -498,7 +506,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		 */
 		might_sleep();
 #ifdef CONFIG_DEBUG_VM
-		if (!user_mode(regs) && !search_exception_tables(regs->pc)) {
+		if (!is_user && !search_exception_tables(regs->pc)) {
 			up_read(&mm->mmap_sem);
 			goto no_context;
 		}
@@ -516,7 +524,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		 * in __lock_page_or_retry in mm/filemap.c.
 		 */
 		if (fatal_signal_pending(current)) {
-			if (!user_mode(regs))
+			if (!is_user)
 				goto no_context;
 			return 0;
 		}
@@ -561,7 +569,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	 * If we are in kernel mode at this point, we have no context to
 	 * handle this fault with.
 	 */
-	if (!user_mode(regs))
+	if (!is_user)
 		goto no_context;
 
 	if (fault & VM_FAULT_OOM) {
-- 
2.7.4

