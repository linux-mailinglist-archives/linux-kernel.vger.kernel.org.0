Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6022F16F371
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 00:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgBYX0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 18:26:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55592 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbgBYXZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:25:58 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6ja9-0004cY-PI; Wed, 26 Feb 2020 00:25:42 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id A2A7E10408B;
        Wed, 26 Feb 2020 00:25:36 +0100 (CET)
Message-Id: <20200225222648.285655538@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:16:07 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 01/24] x86/traps: Split trap numbers out in a seperate header
References: <20200225221606.511535280@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So they can be used in ASM code. For this it is also necessary to convert
them to defines. Will be used for the rework of the entry code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/trapnr.h |   31 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/traps.h  |   26 +-------------------------
 2 files changed, 32 insertions(+), 25 deletions(-)

--- /dev/null
+++ b/arch/x86/include/asm/trapnr.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_TRAPNR_H
+#define _ASM_X86_TRAPNR_H
+
+/* Interrupts/Exceptions */
+
+#define X86_TRAP_DE		 0	/* Divide-by-zero */
+#define X86_TRAP_DB		 1	/* Debug */
+#define X86_TRAP_NMI		 2	/* Non-maskable Interrupt */
+#define X86_TRAP_BP		 3	/* Breakpoint */
+#define X86_TRAP_OF		 4	/* Overflow */
+#define X86_TRAP_BR		 5	/* Bound Range Exceeded */
+#define X86_TRAP_UD		 6	/* Invalid Opcode */
+#define X86_TRAP_NM		 7	/* Device Not Available */
+#define X86_TRAP_DF		 8	/* Double Fault */
+#define X86_TRAP_OLD_MF		 9	/* Coprocessor Segment Overrun */
+#define X86_TRAP_TS		10	/* Invalid TSS */
+#define X86_TRAP_NP		11	/* Segment Not Present */
+#define X86_TRAP_SS		12	/* Stack Segment Fault */
+#define X86_TRAP_GP		13	/* General Protection Fault */
+#define X86_TRAP_PF		14	/* Page Fault */
+#define X86_TRAP_SPURIOUS	15	/* Spurious Interrupt */
+#define X86_TRAP_MF		16	/* x87 Floating-Point Exception */
+#define X86_TRAP_AC		17	/* Alignment Check */
+#define X86_TRAP_MC		18	/* Machine Check */
+#define X86_TRAP_XF		19	/* SIMD Floating-Point Exception */
+#define X86_TRAP_VE		20	/* Virtualization Exception */
+#define X86_TRAP_CP		21	/* Control Protection Exception */
+#define X86_TRAP_IRET		32	/* IRET Exception */
+
+#endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -7,6 +7,7 @@
 
 #include <asm/debugreg.h>
 #include <asm/siginfo.h>			/* TRAP_TRACE, ... */
+#include <asm/trapnr.h>
 
 #define dotraplinkage __visible
 
@@ -129,31 +130,6 @@ void __noreturn handle_stack_overflow(co
 				      unsigned long fault_address);
 #endif
 
-/* Interrupts/Exceptions */
-enum {
-	X86_TRAP_DE = 0,	/*  0, Divide-by-zero */
-	X86_TRAP_DB,		/*  1, Debug */
-	X86_TRAP_NMI,		/*  2, Non-maskable Interrupt */
-	X86_TRAP_BP,		/*  3, Breakpoint */
-	X86_TRAP_OF,		/*  4, Overflow */
-	X86_TRAP_BR,		/*  5, Bound Range Exceeded */
-	X86_TRAP_UD,		/*  6, Invalid Opcode */
-	X86_TRAP_NM,		/*  7, Device Not Available */
-	X86_TRAP_DF,		/*  8, Double Fault */
-	X86_TRAP_OLD_MF,	/*  9, Coprocessor Segment Overrun */
-	X86_TRAP_TS,		/* 10, Invalid TSS */
-	X86_TRAP_NP,		/* 11, Segment Not Present */
-	X86_TRAP_SS,		/* 12, Stack Segment Fault */
-	X86_TRAP_GP,		/* 13, General Protection Fault */
-	X86_TRAP_PF,		/* 14, Page Fault */
-	X86_TRAP_SPURIOUS,	/* 15, Spurious Interrupt */
-	X86_TRAP_MF,		/* 16, x87 Floating-Point Exception */
-	X86_TRAP_AC,		/* 17, Alignment Check */
-	X86_TRAP_MC,		/* 18, Machine Check */
-	X86_TRAP_XF,		/* 19, SIMD Floating-Point Exception */
-	X86_TRAP_IRET = 32,	/* 32, IRET Exception */
-};
-
 /*
  * Page fault error code bits:
  *

