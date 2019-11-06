Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 711EDF202E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 21:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732608AbfKFU4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 15:56:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45269 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732198AbfKFU4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:56:47 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSSM9-000333-QD; Wed, 06 Nov 2019 21:56:45 +0100
Message-Id: <20191106202806.333598601@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 06 Nov 2019 20:35:05 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch 6/9] x86/iopl: Fixup misleading comment
References: <20191106193459.581614484@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment for the sys_iopl() implementation is outdated and actively
misleading in some parts. Fix it up.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/ioport.c |   35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -22,7 +22,7 @@
 #include <asm/desc.h>
 
 /*
- * this changes the io permissions bitmap in the current task.
+ * This changes the io permissions bitmap in the current task.
  */
 long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 {
@@ -163,14 +163,24 @@ SYSCALL_DEFINE3(ioperm, unsigned long, f
 }
 
 /*
- * sys_iopl has to be used when you want to access the IO ports
- * beyond the 0x3ff range: to get the full 65536 ports bitmapped
- * you'd need 8kB of bitmaps/process, which is a bit excessive.
+ * The sys_iopl functionality depends on the level argument, which if
+ * granted for the task is used by the CPU to check I/O instruction and
+ * CLI/STI against the current priviledge level (CPL). If CPL is less than
+ * or equal the tasks IOPL level the instructions take effect. If not a #GP
+ * is raised. The default IOPL is 0, i.e. no permissions.
  *
- * Here we just change the flags value on the stack: we allow
- * only the super-user to do it. This depends on the stack-layout
- * on system-call entry - see also fork() and the signal handling
- * code.
+ * Setting IOPL to level 0-2 is disabling the userspace access. Only level
+ * 3 enables it. If set it allows the user space thread:
+ *
+ * - Unrestricted access to all 65535 I/O ports
+ * - The usage of CLI/STI instructions
+ *
+ * The advantage over ioperm is that the context switch does not require to
+ * update the I/O bitmap which is especially true when a large number of
+ * ports is accessed. But the allowance of CLI/STI in userspace is
+ * considered a major problem.
+ *
+ * IOPL is strictly per thread and inherited on fork.
  */
 SYSCALL_DEFINE1(iopl, unsigned int, level)
 {
@@ -191,9 +201,18 @@ SYSCALL_DEFINE1(iopl, unsigned int, leve
 		    security_locked_down(LOCKDOWN_IOPORT))
 			return -EPERM;
 	}
+	/*
+	 * Change the flags value on the return stack, which has been set
+	 * up on system-call entry. See also the fork and signal handling
+	 * code how this is handled.
+	 */
 	regs->flags = (regs->flags & ~X86_EFLAGS_IOPL) |
 		(level << X86_EFLAGS_IOPL_BIT);
+	/* Store the new level in the thread struct */
 	t->iopl = level << X86_EFLAGS_IOPL_BIT;
+	/*
+	 * X86_32 switches immediately and XEN handles it via emulation.
+	 */
 	set_iopl_mask(t->iopl);
 
 	return 0;


