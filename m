Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9C5114708
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 19:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfLESlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 13:41:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:4158 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729935AbfLESlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 13:41:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 10:41:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,282,1571727600"; 
   d="scan'208";a="214263547"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga003.jf.intel.com with ESMTP; 05 Dec 2019 10:41:10 -0800
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 3/3] x86/fpu/xstate: Invalidate fpregs when __fpu_restore_sig() fails
Date:   Thu,  5 Dec 2019 10:26:48 -0800
Message-Id: <20191205182648.32257-4-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205182648.32257-1-yu-cheng.yu@intel.com>
References: <20191205182648.32257-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __fpu_restore_sig(),'init_fpstate.xsave' and part of 'fpu->state.xsave'
are restored separately to xregs.  However, as stated in __cpu_invalidate_
fpregs_state(),

  Any code that clobbers the FPU registers or updates the in-memory
  FPU state for a task MUST let the rest of the kernel know that the
  FPU registers are no longer valid for this task.

and this code violates that rule.  Should the restoration fail, the other
task's context is corrupted.

This problem does not occur very often because copy_*_to_xregs() succeeds
most of the time.  It occurs, for instance, in copy_user_to_fpregs_
zeroing() when the first half of the restoration succeeds and the other
half fails.  This can be triggered by running glibc tests, where a non-
present user stack page causes the XRSTOR to fail.

The introduction of supervisor xstates and CET, while not contributing to
the problem, makes it more detectable.  After init_fpstate and the Shadow
Stack pointer have been restored to xregs, the XRSTOR from user stack
fails and fpu_fpregs_owner_ctx is not updated.  The task currently owning
fpregs then uses the corrupted Shadow Stack pointer and triggers a control-
protection fault.

Fix it by adding __cpu_invalidate_fpregs_state() to functions that copy
fpstate to fpregs:
  copy_*_to_xregs_*(), copy_*_to_fxregs_*(), and copy_*_to_fregs_*().
The alternative is to hit all of the call sites themselves.

The function __cpu_invalidate_fpregs_state() is chosen over fpregs_
deactivate() as it is called under fpregs_lock() protection.

In addition to sigreturn, also checked all call sites of these functions:

- copy_init_fpstate_to_fpregs();
- copy_kernel_to_fpregs();
- ex_handler_fprestore();
- fpu__save(); and
- fpu__copy().

In fpu__save() and fpu__copy(), fpregs are re-activated because they are
considered valid in both cases.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/include/asm/fpu/internal.h | 14 ++++++++++++++
 arch/x86/kernel/fpu/core.c          | 15 +++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 4c95c365058a..cd380d14e4e2 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -142,6 +142,8 @@ extern void fpstate_sanitize_xstate(struct fpu *fpu);
 		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_fprestore)	\
 		     : output : input)
 
+static inline void __cpu_invalidate_fpregs_state(void);
+
 static inline int copy_fregs_to_user(struct fregs_state __user *fx)
 {
 	return user_insn(fnsave %[fx]; fwait,  [fx] "=m" (*fx), "m" (*fx));
@@ -158,6 +160,8 @@ static inline int copy_fxregs_to_user(struct fxregs_state __user *fx)
 
 static inline void copy_kernel_to_fxregs(struct fxregs_state *fx)
 {
+	__cpu_invalidate_fpregs_state();
+
 	if (IS_ENABLED(CONFIG_X86_32))
 		kernel_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 	else
@@ -166,6 +170,8 @@ static inline void copy_kernel_to_fxregs(struct fxregs_state *fx)
 
 static inline int copy_kernel_to_fxregs_err(struct fxregs_state *fx)
 {
+	__cpu_invalidate_fpregs_state();
+
 	if (IS_ENABLED(CONFIG_X86_32))
 		return kernel_insn_err(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 	else
@@ -174,6 +180,8 @@ static inline int copy_kernel_to_fxregs_err(struct fxregs_state *fx)
 
 static inline int copy_user_to_fxregs(struct fxregs_state __user *fx)
 {
+	__cpu_invalidate_fpregs_state();
+
 	if (IS_ENABLED(CONFIG_X86_32))
 		return user_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 	else
@@ -182,16 +190,19 @@ static inline int copy_user_to_fxregs(struct fxregs_state __user *fx)
 
 static inline void copy_kernel_to_fregs(struct fregs_state *fx)
 {
+	__cpu_invalidate_fpregs_state();
 	kernel_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
 static inline int copy_kernel_to_fregs_err(struct fregs_state *fx)
 {
+	__cpu_invalidate_fpregs_state();
 	return kernel_insn_err(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
 static inline int copy_user_to_fregs(struct fregs_state __user *fx)
 {
+	__cpu_invalidate_fpregs_state();
 	return user_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
@@ -340,6 +351,7 @@ static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 
+	__cpu_invalidate_fpregs_state();
 	XSTATE_XRESTORE(xstate, lmask, hmask);
 }
 
@@ -382,6 +394,7 @@ static inline int copy_user_to_xregs(struct xregs_state __user *buf, u64 mask)
 	u32 hmask = mask >> 32;
 	int err;
 
+	__cpu_invalidate_fpregs_state();
 	stac();
 	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
 	clac();
@@ -399,6 +412,7 @@ static inline int copy_kernel_to_xregs_err(struct xregs_state *xstate, u64 mask)
 	u32 hmask = mask >> 32;
 	int err;
 
+	__cpu_invalidate_fpregs_state();
 	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
 
 	return err;
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 12c70840980e..743ff5ea4076 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -127,7 +127,12 @@ void fpu__save(struct fpu *fpu)
 
 	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		if (!copy_fpregs_to_fpstate(fpu)) {
+			/*
+			 * copy_kernel_to_fpregs deactivates fpregs;
+			 * re-activate fpregs after that.
+			 */
 			copy_kernel_to_fpregs(&fpu->state);
+			fpregs_activate(fpu);
 		}
 	}
 
@@ -191,11 +196,17 @@ int fpu__copy(struct task_struct *dst, struct task_struct *src)
 	 *   register contents so we have to load them back. )
 	 */
 	fpregs_lock();
-	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+	if (test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		memcpy(&dst_fpu->state, &src_fpu->state, fpu_kernel_xstate_size);
 
-	else if (!copy_fpregs_to_fpstate(dst_fpu))
+	} else if (!copy_fpregs_to_fpstate(dst_fpu)) {
+		/*
+		 * copy_kernel_to_fpregs deactivates fpregs;
+		 * re-activate fpregs after that.
+		 */
 		copy_kernel_to_fpregs(&dst_fpu->state);
+		fpregs_activate(src_fpu);
+	}
 
 	fpregs_unlock();
 
-- 
2.17.1

