Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6491817D705
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 00:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgCHXX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 19:23:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57227 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgCHXXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:23:52 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jB5Ga-00033Q-UE; Mon, 09 Mar 2020 00:23:29 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 63673104097;
        Mon,  9 Mar 2020 00:23:28 +0100 (CET)
Message-Id: <20200308222609.125574449@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 08 Mar 2020 23:24:01 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [patch part-II V2 02/13] x86/entry: Mark enter_from_user_mode() notrace and NOKPROBE
References: <20200308222359.370649591@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the callers in the low level ASM code and __context_tracking_exit()
which is invoked from enter_from_user_mode() via user_exit_irqoff() are
marked NOKPROBE. Allowing enter_from_user_mode() to be probed is
inconsistent at best.

Aside of that while function tracing per se is safe the function trace
entry/exit points can be used via BPF as well which is not safe to use
before context tracking has reached CONTEXT_KERNEL and adjusted RCU.

Mark it notrace and NOKROBE.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -40,11 +40,12 @@
 
 #ifdef CONFIG_CONTEXT_TRACKING
 /* Called on entry from user mode with IRQs off. */
-__visible inline void enter_from_user_mode(void)
+__visible inline notrace void enter_from_user_mode(void)
 {
 	CT_WARN_ON(ct_state() != CONTEXT_USER);
 	user_exit_irqoff();
 }
+NOKPROBE_SYMBOL(enter_from_user_mode);
 #else
 static inline void enter_from_user_mode(void) {}
 #endif

