Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 498FC16F36E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 00:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgBYX3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 18:29:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55647 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbgBYX0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:05 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jaG-0004dD-Qy; Wed, 26 Feb 2020 00:25:49 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id D7A7C10408C;
        Wed, 26 Feb 2020 00:25:36 +0100 (CET)
Message-Id: <20200225222648.395059616@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:16:08 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 02/24] x86/entry/64: Avoid pointless code when CONTEXT_TRACKING=n
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

GAS cannot optimize out the test and conditional jump when context tracking
is disabled and CALL_enter_from_user_mode is an empty macro.

Wrap it in #ifdeffery. Will go away once all this is moved to C.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -884,12 +884,14 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
 	TRACE_IRQS_OFF
 	.endif
 
+#ifdef CONFIG_CONTEXT_TRACKING
 	.if \paranoid == 0
 	testb	$3, CS(%rsp)
 	jz	.Lfrom_kernel_no_context_tracking_\@
 	CALL_enter_from_user_mode
 .Lfrom_kernel_no_context_tracking_\@:
 	.endif
+#endif
 
 	movq	%rsp, %rdi			/* pt_regs pointer */
 

