Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37F641445C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 21:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgAUUUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 15:20:11 -0500
Received: from mga06.intel.com ([134.134.136.31]:7229 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729107AbgAUUUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 15:20:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 12:20:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="307313106"
Received: from yyu32-desk.sc.intel.com ([143.183.136.51])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2020 12:20:03 -0800
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
Subject: [PATCH v2 6/8] x86/fpu/xstate: Update sanitize_restored_xstate() for supervisor xstates
Date:   Tue, 21 Jan 2020 12:18:41 -0800
Message-Id: <20200121201843.12047-7-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200121201843.12047-1-yu-cheng.yu@intel.com>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function sanitize_restored_xstate() sanitizes user xstates of an XSAVE
buffer by setting the buffer's header->xfeatures to the input 'xfeatures',
effectively resetting features not in 'xfeatures' back to the init state.

When supervisor xstates are introduced, it is necessary to make sure only
user xstates are sanitized.  This patch ensures supervisor xstates are not
changed by ensuring supervisor bits stay set in header->xfeatures.

To make names clear, also:

- Rename the function to sanitize_restored_user_xstate().
- Rename input parameter 'xfeatures' to 'xfeatures_from_user'.
- In __fpu__restore_sig(), rename 'xfeatures' to 'xfeatures_user'.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/fpu/signal.c | 37 +++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 4afe61987e03..e3781a4a52a8 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -211,9 +211,9 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 }
 
 static inline void
-sanitize_restored_xstate(union fpregs_state *state,
-			 struct user_i387_ia32_struct *ia32_env,
-			 u64 xfeatures, int fx_only)
+sanitize_restored_user_xstate(union fpregs_state *state,
+			      struct user_i387_ia32_struct *ia32_env,
+			      u64 xfeatures_from_user, int fx_only)
 {
 	struct xregs_state *xsave = &state->xsave;
 	struct xstate_header *header = &xsave->header;
@@ -226,13 +226,22 @@ sanitize_restored_xstate(union fpregs_state *state,
 		 */
 
 		/*
-		 * Init the state that is not present in the memory
-		 * layout and not enabled by the OS.
+		 * 'xfeatures_from_user' might have bits clear which are
+		 * set in header->xfeatures. This represents features that
+		 * were in init state prior to a signal delivery, and need
+		 * to be reset back to the init state.  Clear any user
+		 * feature bits which are set in the kernel buffer to get
+		 * them back to the init state.
+		 *
+		 * Supervisor state is unchanged by input from userspace.
+		 * Ensure that supervisor state is not modified by ensuring
+		 * supervisor state bits stay set.
 		 */
 		if (fx_only)
 			header->xfeatures = XFEATURE_MASK_FPSSE;
 		else
-			header->xfeatures &= xfeatures;
+			header->xfeatures &= xfeatures_from_user |
+					     xfeatures_mask_supervisor();
 	}
 
 	if (use_fxsr()) {
@@ -280,7 +289,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	struct task_struct *tsk = current;
 	struct fpu *fpu = &tsk->thread.fpu;
 	struct user_i387_ia32_struct env;
-	u64 xfeatures = 0;
+	u64 xfeatures_user = 0;
 	int fx_only = 0;
 	int ret = 0;
 
@@ -313,7 +322,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			trace_x86_fpu_xstate_check_failed(fpu);
 		} else {
 			state_size = fx_sw_user.xstate_size;
-			xfeatures = fx_sw_user.xfeatures;
+			xfeatures_user = fx_sw_user.xfeatures;
 		}
 	}
 
@@ -348,7 +357,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		 */
 		fpregs_lock();
 		pagefault_disable();
-		ret = copy_user_to_fpregs_zeroing(buf_fx, xfeatures, fx_only);
+		ret = copy_user_to_fpregs_zeroing(buf_fx, xfeatures_user, fx_only);
 		pagefault_enable();
 		if (!ret) {
 			fpregs_mark_activate();
@@ -361,7 +370,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 
 
 	if (use_xsave() && !fx_only) {
-		u64 init_bv = xfeatures_mask_user() & ~xfeatures;
+		u64 init_bv = xfeatures_mask_user() & ~xfeatures_user;
 
 		if (using_compacted_format()) {
 			ret = copy_user_to_xstate(&fpu->state.xsave, buf_fx);
@@ -374,12 +383,13 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		if (ret)
 			goto err_out;
 
-		sanitize_restored_xstate(&fpu->state, envp, xfeatures, fx_only);
+		sanitize_restored_user_xstate(&fpu->state, envp, xfeatures_user,
+					      fx_only);
 
 		fpregs_lock();
 		if (unlikely(init_bv))
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-		ret = copy_kernel_to_xregs_err(&fpu->state.xsave, xfeatures);
+		ret = copy_kernel_to_xregs_err(&fpu->state.xsave, xfeatures_user);
 
 	} else if (use_fxsr()) {
 		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
@@ -388,7 +398,8 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			goto err_out;
 		}
 
-		sanitize_restored_xstate(&fpu->state, envp, xfeatures, fx_only);
+		sanitize_restored_user_xstate(&fpu->state, envp,
+					      xfeatures_user, fx_only);
 
 		fpregs_lock();
 		if (use_xsave()) {
-- 
2.21.0

