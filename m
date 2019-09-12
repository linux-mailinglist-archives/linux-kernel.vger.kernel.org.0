Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A23BAB1511
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 22:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfILUII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 16:08:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:35554 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727342AbfILUH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 16:07:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 13:07:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="336688251"
Received: from chang-linux-3.sc.intel.com ([172.25.66.185])
  by orsmga004.jf.intel.com with ESMTP; 12 Sep 2019 13:07:56 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     ravi.v.shankar@intel.com, chang.seok.bae@intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH v8 11/17] x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit
Date:   Thu, 12 Sep 2019 13:06:52 -0700
Message-Id: <1568318818-4091-12-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568318818-4091-1-git-send-email-chang.seok.bae@intel.com>
References: <1568318818-4091-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without FSGSBASE, user space cannot change GS base other than through a
PRCTL. The kernel enforces that the user space GS base value is positive
as negative values are used for detecting the kernel space GS base value
in the paranoid entry code.

If FSGSBASE is enabled, user space can set arbitrary GS base values without
kernel intervention, including negative ones, which breaks the paranoid
entry assumptions.

To avoid this, paranoid entry needs to unconditionally save the current
GS base value independent of the interrupted context, retrieve and write
the kernel GS base and unconditionally restore the saved value on exit.
The restore happens either in paranoid exit or in the special exit path of
the NMI low level code.

All other entry code paths which use unconditional SWAPGS are not affected
as they do not depend on the actual content.

The new logic for paranoid entry, when FSGSBASE is enabled, removes SWAPGS
and replaces with unconditional WRGSBASE. Hence no fences are needed.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Vegard Nossum <vegard.nossum@oracle.com>
---

Changes from v7:
* Rebased paranoid exit changes on the precedent cleanup patch
* Massaged changelog and comment by Thomas
* Added comments related to the SWAPGS mitigation
* Used 'GS base' consistently, instead of 'GSBASE'
---
 arch/x86/entry/calling.h  |  6 ++++
 arch/x86/entry/entry_64.S | 78 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index c222302..673d086 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -340,6 +340,12 @@ For 32-bit we have the following conventions - kernel is built with
 #endif
 .endm
 
+.macro SAVE_AND_SET_GSBASE scratch_reg:req save_reg:req
+	rdgsbase \save_reg
+	GET_PERCPU_BASE \scratch_reg
+	wrgsbase \scratch_reg
+.endm
+
 #endif /* CONFIG_X86_64 */
 
 .macro STACKLEAK_ERASE
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index edb4160..d554754 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -38,6 +38,7 @@
 #include <asm/export.h>
 #include <asm/frame.h>
 #include <asm/nospec-branch.h>
+#include <asm/fsgsbase.h>
 #include <linux/err.h>
 
 #include "calling.h"
@@ -1210,9 +1211,14 @@ idtentry machine_check		do_mce			has_error_code=0	paranoid=1
 #endif
 
 /*
- * Save all registers in pt_regs, and switch gs if needed.
- * Use slow, but surefire "are we in kernel?" check.
- * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
+ * Save all registers in pt_regs. Return GS base related information
+ * in EBX depending on the availability of the FSGSBASE instructions:
+ *
+ * FSGSBASE	R/EBX
+ *     N        0 -> SWAPGS on exit
+ *              1 -> no SWAPGS on exit
+ *
+ *     Y        GS base value at entry, must be restored in paranoid_exit
  */
 ENTRY(paranoid_entry)
 	UNWIND_HINT_FUNC
@@ -1237,7 +1243,29 @@ ENTRY(paranoid_entry)
 	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
-	/* EBX = 1 -> kernel GSBASE active, no restore required */
+	/*
+	 * Handling GS base depends on the availability of FSGSBASE.
+	 *
+	 * Without FSGSBASE the kernel enforces that negative GS base
+	 * values indicate kernel GS base. With FSGSBASE no assumptions
+	 * can be made about the GS base value when entering from user
+	 * space.
+	*/
+	ALTERNATIVE "jmp .Lparanoid_entry_checkgs", "", X86_FEATURE_FSGSBASE
+
+	/*
+	 * Read the current GS base and store it in %rbx unconditionally,
+	 * retrieve and set the current CPUs kernel GS base. The stored value
+	 * has to be restored in paranoid_exit unconditionally.
+	 *
+	 * This unconditional write of GS base ensures no subsequent load
+	 * based on a mispredicted GS base.
+	 */
+	SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
+	ret
+
+.Lparanoid_entry_checkgs:
+	/* EBX = 1 -> kernel GS base active, no restore required */
 	movl	$1, %ebx
 	/*
 	 * The kernel-enforced convention is a negative GS base indicates
@@ -1264,10 +1292,17 @@ END(paranoid_entry)
  *
  * We may be returning to very strange contexts (e.g. very early
  * in syscall entry), so checking for preemption here would
- * be complicated.  Fortunately, we there's no good reason
- * to try to handle preemption here.
+ * be complicated.  Fortunately, there's no good reason to try
+ * to handle preemption here.
+ *
+ * R/EBX contains the GS base related information depending on the
+ * availability of the FSGSBASE instructions:
+ *
+ * FSGSBASE	R/EBX
+ *     N        0 -> SWAPGS on exit
+ *              1 -> no SWAPGS on exit
  *
- * On entry, ebx is "no swapgs" flag (1: don't need swapgs, 0: need it)
+ *     Y        User space GS base, must be restored unconditionally
  */
 ENTRY(paranoid_exit)
 	UNWIND_HINT_REGS
@@ -1284,7 +1319,15 @@ ENTRY(paranoid_exit)
 	TRACE_IRQS_OFF_DEBUG
 	RESTORE_CR3	scratch_reg=%rax save_reg=%r14
 
-	/* If EBX is 0, SWAPGS is required */
+	/* Handle the three GS base cases */
+	ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "", X86_FEATURE_FSGSBASE
+
+	/* With FSGSBASE enabled, unconditionally resotre GS base */
+	wrgsbase	%rbx
+	jmp	restore_regs_and_return_to_kernel
+
+.Lparanoid_exit_checkgs:
+	/* On non-FSGSBASE systems, conditionally do SWAPGS */
 	testl	%ebx, %ebx
 	jnz	restore_regs_and_return_to_kernel
 
@@ -1698,10 +1741,27 @@ end_repeat_nmi:
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
 
-	testl	%ebx, %ebx			/* swapgs needed? */
+	/*
+	 * The above invocation of paranoid_entry stored the GS base
+	 * related information in R/EBX depending on the availability
+	 * of FSGSBASE.
+	 *
+	 * If FSGSBASE is enabled, restore the saved GS base value
+	 * unconditionally, otherwise take the conditional SWAPGS path.
+	 */
+	ALTERNATIVE "jmp nmi_no_fsgsbase", "", X86_FEATURE_FSGSBASE
+
+	wrgsbase	%rbx
+	jmp	nmi_restore
+
+nmi_no_fsgsbase:
+	/* EBX == 0 -> invoke SWAPGS */
+	testl	%ebx, %ebx
 	jnz	nmi_restore
+
 nmi_swapgs:
 	SWAPGS_UNSAFE_STACK
+
 nmi_restore:
 	POP_REGS
 
-- 
2.7.4

