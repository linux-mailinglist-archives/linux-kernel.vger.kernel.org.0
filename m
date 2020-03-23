Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F16818FCD4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 19:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgCWSiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 14:38:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46776 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgCWSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:38:25 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGRxv-00137D-EW; Mon, 23 Mar 2020 18:38:23 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 19/22] x86: __setup_rt_frame(): consolidate uaccess areas
Date:   Mon, 23 Mar 2020 18:38:16 +0000
Message-Id: <20200323183819.250124-19-viro@ZenIV.linux.org.uk>
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

reorder copy_siginfo_to_user() calls a bit

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/signal.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 02b81784acc7..66bcb5539ae7 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -351,7 +351,6 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 {
 	struct rt_sigframe __user *frame;
 	void __user *restorer;
-	int err = 0;
 	void __user *fpstate = NULL;
 
 	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fpstate);
@@ -389,11 +388,11 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	if (setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
 				regs, set->sig[0]))
 		goto Efault;
+	unsafe_put_user(*(__u64 *)set,
+			(__u64 __user *)&frame->uc.uc_sigmask, Efault);
 	user_access_end();
 	
-	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
-	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
-	if (err)
+	if (copy_siginfo_to_user(&frame->info, &ksig->info))
 		return -EFAULT;
 
 	/* Set up registers for signal handler */
@@ -435,23 +434,14 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	struct rt_sigframe __user *frame;
 	void __user *fp = NULL;
 	unsigned long uc_flags;
-	int err = 0;
 
 	/* x86-64 should always use SA_RESTORER. */
 	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
 		return -EFAULT;
 
 	frame = get_sigframe(&ksig->ka, regs, sizeof(struct rt_sigframe), &fp);
-
-	if (!access_ok(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
-		if (copy_siginfo_to_user(&frame->info, &ksig->info))
-			return -EFAULT;
-	}
-
 	uc_flags = frame_uc_flags(regs);
+
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
@@ -465,11 +455,13 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);
 	if (setup_sigcontext(&frame->uc.uc_mcontext, fp, regs, set->sig[0]))
 		goto Efault;
+	unsafe_put_user(set->sig[0], &frame->uc.uc_sigmask.sig[0], Efault);
 	user_access_end();
-	err |= __put_user(set->sig[0], &frame->uc.uc_sigmask.sig[0]);
 
-	if (err)
-		return -EFAULT;
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
+		if (copy_siginfo_to_user(&frame->info, &ksig->info))
+			return -EFAULT;
+	}
 
 	/* Set up registers for signal handler */
 	regs->di = sig;
-- 
2.11.0

