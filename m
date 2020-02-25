Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B56B16F323
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 00:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgBYXZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 18:25:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55460 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbgBYXZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:25:44 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jZz-0004WC-Rl; Wed, 26 Feb 2020 00:25:32 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id ED06910408C;
        Wed, 26 Feb 2020 00:25:28 +0100 (CET)
Message-Id: <20200225220216.720335354@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 22:36:42 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 06/10] x86/traps: Remove redundant declaration of do_double_fault()
References: <20200225213636.689276920@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/traps.h |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -76,13 +76,6 @@ dotraplinkage void do_coprocessor_segmen
 dotraplinkage void do_invalid_TSS(struct pt_regs *regs, long error_code);
 dotraplinkage void do_segment_not_present(struct pt_regs *regs, long error_code);
 dotraplinkage void do_stack_segment(struct pt_regs *regs, long error_code);
-#ifdef CONFIG_X86_64
-dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long address);
-asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
-asmlinkage __visible notrace
-struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s);
-void __init trap_init(void);
-#endif
 dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code);
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
@@ -94,6 +87,13 @@ dotraplinkage void do_iret_error(struct
 #endif
 dotraplinkage void do_mce(struct pt_regs *regs, long error_code);
 
+#ifdef CONFIG_X86_64
+asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
+asmlinkage __visible notrace
+struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s);
+void __init trap_init(void);
+#endif
+
 static inline int get_si_code(unsigned long condition)
 {
 	if (condition & DR_STEP)

