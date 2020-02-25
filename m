Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6DA16F359
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 00:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbgBYX2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 18:28:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55834 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730226AbgBYX03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:29 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jad-0004sg-3U; Wed, 26 Feb 2020 00:26:12 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id C7D61104083;
        Wed, 26 Feb 2020 00:25:44 +0100 (CET)
Message-Id: <20200225224144.421221583@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:33:24 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 03/16] x86/idtentry: Provide IDTENTRY_XEN for XEN/PV
References: <20200225223321.231477305@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XEN/PV has special wrappers for NMI and DB exceptions. They redirect these
exceptions through regular IDTENTRY points. Provide the necessary IDTENTRY
macros to make this work

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/idtentry.h |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -163,6 +163,18 @@ static __always_inline void __##func(str
 #define DECLARE_IDTENTRY_DEBUG		DECLARE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_DEBUG		DEFINE_IDTENTRY_IST
 
+/**
+ * DECLARE_IDTENTRY_XEN - Declare functions for XEN redirect IDT entry points
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Used for xennmi and xendebug redirections. No DEFINE as this is all
+ * indirection magic.
+ */
+#define DECLARE_IDTENTRY_XEN(vector, func)			\
+	asmlinkage void xen_asm_exc_xen##func(void);		\
+	asmlinkage void asm_exc_xen##func(void)
+
 #else /* !__ASSEMBLY__ */
 
 /* Defines for ASM code to construct the IDT entries */
@@ -191,7 +203,11 @@ static __always_inline void __##func(str
 #endif
 
 /* No ASM code emitted for NMI */
-# define DECLARE_IDTENTRY_NMI(vector, func)
+#define DECLARE_IDTENTRY_NMI(vector, func)
+
+/* XEN NMI and DB wrapper */
+#define DECLARE_IDTENTRY_XEN(vector, func)			\
+	idtentry vector asm_exc_xen##func exc_##func has_error_code=0
 
 #endif /* __ASSEMBLY__ */
 

