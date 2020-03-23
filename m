Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB11318FCC7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 19:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgCWSiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 14:38:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46668 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbgCWSiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:38:23 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGRxs-001354-Ar; Mon, 23 Mar 2020 18:38:20 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 03/22] x86: switch sigframe sigset handling to explict __get_user()/__put_user()
Date:   Mon, 23 Mar 2020 18:38:00 +0000
Message-Id: <20200323183819.250124-3-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
References: <20200323183620.GD23230@ZenIV.linux.org.uk>
 <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... and consolidate the definition of sigframe_ia32->extramask - it's
always a 1-element array of 32bit unsigned.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/ia32/ia32_signal.c     | 16 +++++-----------
 arch/x86/include/asm/sigframe.h |  6 +-----
 arch/x86/kernel/signal.c        | 20 ++++++++------------
 3 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index a3aefe9b9401..c72025d615f8 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -126,10 +126,7 @@ COMPAT_SYSCALL_DEFINE0(sigreturn)
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
 	if (__get_user(set.sig[0], &frame->sc.oldmask)
-	    || (_COMPAT_NSIG_WORDS > 1
-		&& __copy_from_user((((char *) &set.sig) + 4),
-				    &frame->extramask,
-				    sizeof(frame->extramask))))
+	    || __get_user(((__u32 *)&set)[1], &frame->extramask[0]))
 		goto badframe;
 
 	set_current_blocked(&set);
@@ -153,7 +150,7 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
-	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
+	if (__get_user(set.sig[0], (__u64 __user *)&frame->uc.uc_sigmask))
 		goto badframe;
 
 	set_current_blocked(&set);
@@ -277,11 +274,8 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	if (ia32_setup_sigcontext(&frame->sc, fpstate, regs, set->sig[0]))
 		return -EFAULT;
 
-	if (_COMPAT_NSIG_WORDS > 1) {
-		if (__copy_to_user(frame->extramask, &set->sig[1],
-				   sizeof(frame->extramask)))
-			return -EFAULT;
-	}
+	if (__put_user(set->sig[1], &frame->extramask[0]))
+		return -EFAULT;
 
 	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
 		restorer = ksig->ka.sa.sa_restorer;
@@ -381,7 +375,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	err |= __copy_siginfo_to_user32(&frame->info, &ksig->info, false);
 	err |= ia32_setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
 				     regs, set->sig[0]);
-	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
+	err |= __put_user(*(__u64 *)set, (__u64 __user *)&frame->uc.uc_sigmask);
 
 	if (err)
 		return -EFAULT;
diff --git a/arch/x86/include/asm/sigframe.h b/arch/x86/include/asm/sigframe.h
index f176114c04d4..84eab2724875 100644
--- a/arch/x86/include/asm/sigframe.h
+++ b/arch/x86/include/asm/sigframe.h
@@ -33,11 +33,7 @@ struct sigframe_ia32 {
 	 * legacy application accessing/modifying it.
 	 */
 	struct _fpstate_32 fpstate_unused;
-#ifdef CONFIG_IA32_EMULATION
-	unsigned int extramask[_COMPAT_NSIG_WORDS-1];
-#else /* !CONFIG_IA32_EMULATION */
-	unsigned long extramask[_NSIG_WORDS-1];
-#endif /* CONFIG_IA32_EMULATION */
+	unsigned int extramask[1];
 	char retcode[8];
 	/* fp state follows here */
 };
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 8a29573851a3..53ac66b3fd9b 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -326,11 +326,8 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	if (setup_sigcontext(&frame->sc, fpstate, regs, set->sig[0]))
 		return -EFAULT;
 
-	if (_NSIG_WORDS > 1) {
-		if (__copy_to_user(&frame->extramask, &set->sig[1],
-				   sizeof(frame->extramask)))
-			return -EFAULT;
-	}
+	if (__put_user(set->sig[1], &frame->extramask[0]))
+		return -EFAULT;
 
 	if (current->mm->context.vdso)
 		restorer = current->mm->context.vdso +
@@ -489,7 +486,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	} put_user_catch(err);
 
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, fp, regs, set->sig[0]);
-	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
+	err |= __put_user(set->sig[0], &frame->uc.uc_sigmask.sig[0]);
 
 	if (err)
 		return -EFAULT;
@@ -575,7 +572,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
 				regs, set->sig[0]);
-	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
+	err |= __put_user(*(__u64 *)set, (__u64 __user *)&frame->uc.uc_sigmask);
 
 	if (err)
 		return -EFAULT;
@@ -613,9 +610,8 @@ SYSCALL_DEFINE0(sigreturn)
 
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
-	if (__get_user(set.sig[0], &frame->sc.oldmask) || (_NSIG_WORDS > 1
-		&& __copy_from_user(&set.sig[1], &frame->extramask,
-				    sizeof(frame->extramask))))
+	if (__get_user(set.sig[0], &frame->sc.oldmask) ||
+	    __get_user(set.sig[1], &frame->extramask[0]))
 		goto badframe;
 
 	set_current_blocked(&set);
@@ -645,7 +641,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	frame = (struct rt_sigframe __user *)(regs->sp - sizeof(long));
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
-	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
+	if (__get_user(*(__u64 *)&set, (__u64 __user *)&frame->uc.uc_sigmask))
 		goto badframe;
 	if (__get_user(uc_flags, &frame->uc.uc_flags))
 		goto badframe;
@@ -870,7 +866,7 @@ asmlinkage long sys32_x32_rt_sigreturn(void)
 
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
-	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
+	if (__get_user(set.sig[0], (__u64 __user *)&frame->uc.uc_sigmask))
 		goto badframe;
 	if (__get_user(uc_flags, &frame->uc.uc_flags))
 		goto badframe;
-- 
2.11.0

