Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC9C8FBA52
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 22:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfKMVC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 16:02:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38878 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfKMVCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:02:20 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUzmI-00066F-9Y; Wed, 13 Nov 2019 22:02:14 +0100
Message-Id: <20191113210103.819769574@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 13 Nov 2019 21:42:41 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Subject: [patch V3 01/20] x86/ptrace: Prevent truncation of bitmap size
References: <20191113204240.767922595@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The active() callback of the IO bitmap regset divides the IO bitmap size by
the word size (32/64 bit). As the I/O bitmap size is in bytes the active
check fails for bitmap sizes of 1-3 bytes on 32bit and 1-7 bytes on 64bit.

Use DIV_ROUND_UP() instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andy Lutomirski <luto@kernel.org>


---
 arch/x86/kernel/ptrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -697,7 +697,7 @@ static int ptrace_set_debugreg(struct ta
 static int ioperm_active(struct task_struct *target,
 			 const struct user_regset *regset)
 {
-	return target->thread.io_bitmap_max / regset->size;
+	return DIV_ROUND_UP(target->thread.io_bitmap_max, regset->size);
 }
 
 static int ioperm_get(struct task_struct *target,






