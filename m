Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6954FF82FD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 23:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfKKWgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 17:36:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60056 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfKKWfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:35:47 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUIHh-0000um-Sp; Mon, 11 Nov 2019 23:35:46 +0100
Message-Id: <20191111223052.509914905@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 11 Nov 2019 23:03:24 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V2 10/16] x86/ioperm: Remove bitmap if all permissions dropped
References: <20191111220314.519933535@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ioperm() results in a bitmap with all bits set (no permissions to any
I/O port), then handling that bitmap on context switch and exit to user
mode is pointless. Drop it.

Move the bitmap exit handling to the ioport code and reuse it for both the
thread exit path and dropping it. This allows to reuse this code for the
upcoming iopl() emulation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/iobitmap.h |    2 ++
 arch/x86/kernel/ioport.c        |   20 +++++++++++++++++++-
 arch/x86/kernel/process.c       |   15 ++-------------
 3 files changed, 23 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/iobitmap.h
+++ b/arch/x86/include/asm/iobitmap.h
@@ -13,6 +13,8 @@ struct io_bitmap {
 	};
 };
 
+void io_bitmap_exit(void);
+
 void tss_update_io_bitmap(void);
 
 #endif
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -16,6 +16,18 @@
 
 static atomic64_t io_bitmap_sequence;
 
+void io_bitmap_exit(void)
+{
+	struct io_bitmap *iobm = current->thread.io_bitmap;
+
+	preempt_disable();
+	current->thread.io_bitmap = NULL;
+	clear_thread_flag(TIF_IO_BITMAP);
+	tss_update_io_bitmap();
+	preempt_enable();
+	kfree(iobm);
+}
+
 /*
  * this changes the io permissions bitmap in the current task.
  */
@@ -62,12 +74,18 @@ long ksys_ioperm(unsigned long from, uns
 	 * Search for a (possibly new) maximum. This is simple and stupid,
 	 * to keep it obviously correct:
 	 */
-	max_long = 0;
+	max_long = UINT_MAX;
 	for (i = 0; i < IO_BITMAP_LONGS; i++) {
 		if (iobm->bits[i] != ~0UL)
 			max_long = i;
 	}
 
+	/* All permissions dropped? */
+	if (max_long == UINT_MAX) {
+		io_bitmap_exit();
+		return 0;
+	}
+
 	iobm->io_bitmap_max = (max_long + 1) * sizeof(unsigned long);
 
 	/* Update the sequence number to force an update in switch_to() */
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -102,21 +102,10 @@ int arch_dup_task_struct(struct task_str
 void exit_thread(struct task_struct *tsk)
 {
 	struct thread_struct *t = &tsk->thread;
-	struct io_bitmap *bm = t->io_bitmap;
 	struct fpu *fpu = &t->fpu;
-	struct tss_struct *tss;
 
-	if (bm) {
-		preempt_disable();
-		tss = this_cpu_ptr(&cpu_tss_rw);
-
-		t->io_bitmap = NULL;
-		clear_thread_flag(TIF_IO_BITMAP);
-		/* Invalidate the io bitmap base in the TSS */
-		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
-		preempt_enable();
-		kfree(bm);
-	}
+	if (test_thread_flag(TIF_IO_BITMAP))
+		io_bitmap_exit();
 
 	free_vm86(t);
 


