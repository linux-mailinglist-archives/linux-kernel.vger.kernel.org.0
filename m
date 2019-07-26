Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 158BB77361
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 23:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfGZVYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 17:24:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50445 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbfGZVYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:24:11 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr7hB-00031C-C8; Fri, 26 Jul 2019 23:24:09 +0200
Message-Id: <20190726212124.699136351@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 23:19:43 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [patch 7/8] x86/dumpstack: Indicate PREEMPT_RT in dumps
References: <20190726211936.226129163@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stack dumps print whether the kernel has preemption enabled or not. Extend
it so a PREEMPT_RT enabled kernel can be identified.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/dumpstack.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -367,13 +367,18 @@ NOKPROBE_SYMBOL(oops_end);
 
 int __die(const char *str, struct pt_regs *regs, long err)
 {
+	const char *pr = "";
+
 	/* Save the regs of the first oops for the executive summary later. */
 	if (!die_counter)
 		exec_summary_regs = *regs;
 
+	if (IS_ENABLED(CONFIG_PREEMPTION))
+		pr = IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
+
 	printk(KERN_DEFAULT
 	       "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff, ++die_counter,
-	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT"         : "",
+	       pr,
 	       IS_ENABLED(CONFIG_SMP)     ? " SMP"             : "",
 	       debug_pagealloc_enabled()  ? " DEBUG_PAGEALLOC" : "",
 	       IS_ENABLED(CONFIG_KASAN)   ? " KASAN"           : "",


