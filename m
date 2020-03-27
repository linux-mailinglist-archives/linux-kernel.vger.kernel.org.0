Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5B02194F03
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 03:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgC0Ccg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 22:32:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48054 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgC0CcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:32:11 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHen1-003hSo-MN; Fri, 27 Mar 2020 02:32:07 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 21/22] x86: unsafe_put-style macro for sigmask
Date:   Fri, 27 Mar 2020 02:32:04 +0000
Message-Id: <20200327023205.881896-21-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327023205.881896-1-viro@ZenIV.linux.org.uk>
References: <20200327023007.GS23230@ZenIV.linux.org.uk>
 <20200327023205.881896-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

regularizes things a bit

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/signal.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 38b359325291..1215fc7da0ba 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -203,6 +203,11 @@ do {									\
 		goto label;						\
 } while(0);
 
+#define unsafe_put_sigmask(set, frame, label) \
+	unsafe_put_user(*(__u64 *)(set), \
+			(__u64 __user *)&(frame)->uc.uc_sigmask, \
+			label)
+
 /*
  * Set up a signal frame.
  */
@@ -392,8 +397,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	 */
 	unsafe_put_user(*((u64 *)&rt_retcode), (u64 *)frame->retcode, Efault);
 	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-	unsafe_put_user(*(__u64 *)set,
-			(__u64 __user *)&frame->uc.uc_sigmask, Efault);
+	unsafe_put_sigmask(set, frame, Efault);
 	user_access_end();
 	
 	if (copy_siginfo_to_user(&frame->info, &ksig->info))
@@ -458,7 +462,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	   already in userspace.  */
 	unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);
 	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-	unsafe_put_user(set->sig[0], &frame->uc.uc_sigmask.sig[0], Efault);
+	unsafe_put_sigmask(set, frame, Efault);
 	user_access_end();
 
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
@@ -537,7 +541,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 	restorer = ksig->ka.sa.sa_restorer;
 	unsafe_put_user(restorer, (unsigned long __user *)&frame->pretcode, Efault);
 	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-	unsafe_put_user(*(__u64 *)set, (__u64 __user *)&frame->uc.uc_sigmask, Efault);
+	unsafe_put_sigmask(set, frame, Efault);
 	user_access_end();
 
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
-- 
2.11.0

