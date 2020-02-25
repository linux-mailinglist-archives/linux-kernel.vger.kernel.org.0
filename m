Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954E316F32B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 00:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgBYX0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 18:26:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55614 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729757AbgBYX0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:02 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jaF-0004eW-BC; Wed, 26 Feb 2020 00:25:47 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 82FDF1039F7;
        Wed, 26 Feb 2020 00:25:37 +0100 (CET)
Message-Id: <20200225222648.682036985@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:16:11 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 05/24] x86/entry/32: Provide macro to emit IDT entry stubs
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

32 and 64 bit have unnecessary different ways to populate the exception
entry code. Provide a idtentry macro which allows to consolidate all of
that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -44,6 +44,7 @@
 #include <asm/asm.h>
 #include <asm/smap.h>
 #include <asm/frame.h>
+#include <asm/trapnr.h>
 #include <asm/nospec-branch.h>
 
 #include "calling.h"
@@ -726,6 +727,47 @@
 
 .Lend_\@:
 .endm
+
+#ifdef CONFIG_X86_INVD_BUG
+.macro idtentry_push_func vector cfunc
+	.if \vector == X86_TRAP_XF
+		/* AMD 486 bug: invd from userspace calls exception 19 instead of #GP */
+		ALTERNATIVE "pushl	$do_general_protection",	\
+			    "pushl	$do_simd_coprocessor_error",	\
+			    X86_FEATURE_XMM
+	.else
+		pushl $\cfunc
+	.endif
+.endm
+#else
+.macro idtentry_push_func vector cfunc
+	pushl $\cfunc
+.endm
+#endif
+
+/**
+ * idtentry - Macro to generate entry stubs for simple IDT entries
+ * @vector:		Vector number
+ * @asmsym:		ASM symbol for the entry point
+ * @cfunc:		C function to be called
+ * @has_error_code:	Hardware pushed error code on stack
+ */
+.macro idtentry vector asmsym cfunc has_error_code:req
+SYM_CODE_START(\asmsym)
+	ASM_CLAC
+	cld
+
+	.if \has_error_code == 0
+		pushl	$0		/* Clear the error code */
+	.endif
+
+	/* Push the C-function address into the GS slot */
+	idtentry_push_func \vector \cfunc
+	/* Invoke the common exception entry */
+	jmp	common_exception
+SYM_CODE_END(\asmsym)
+.endm
+
 /*
  * %eax: prev task
  * %edx: next task

