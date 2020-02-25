Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C55416F32C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 00:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgBYX0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 18:26:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55654 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbgBYX0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:07 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jZz-0004W6-K6; Wed, 26 Feb 2020 00:25:33 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 81E76104089;
        Wed, 26 Feb 2020 00:25:28 +0100 (CET)
Message-Id: <20200225220216.518575042@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 22:36:40 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch 04/10] x86/traps: Remove pointless irq enable from do_spurious_interrupt_bug()
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

From: Thomas Gleixner <tglx@linutronix.de>

That function returns immediately after conditionally reenabling interrupts which
is more than pointless and requires the ASM code to disable interrupts again.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20191023123117.871608831@linutronix.de

---
 arch/x86/kernel/traps.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -862,7 +862,6 @@ do_simd_coprocessor_error(struct pt_regs
 dotraplinkage void
 do_spurious_interrupt_bug(struct pt_regs *regs, long error_code)
 {
-	cond_local_irq_enable(regs);
 }
 
 dotraplinkage void

