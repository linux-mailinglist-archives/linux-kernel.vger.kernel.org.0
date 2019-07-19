Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB02C6EC70
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 00:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfGSWYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 18:24:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33046 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfGSWYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 18:24:14 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hobHp-0006IG-Ng; Sat, 20 Jul 2019 00:23:34 +0200
Date:   Sat, 20 Jul 2019 00:23:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eiichi Tsukata <devel@etsukata.com>, edwintorok@gmail.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] x86/stacktrace: Do not access user space memory
 unnecessarily
In-Reply-To: <20190719202836.GB13680@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1907200018050.1782@nanos.tec.linutronix.de>
References: <20190702053151.26922-1-devel@etsukata.com> <20190702072821.GX3419@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1907021400350.1802@nanos.tec.linutronix.de> <20190702113355.5be9ebfe@gandalf.local.home> <20190702133905.1482b87e@gandalf.local.home>
 <20190719202836.GB13680@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2019, Sean Christopherson wrote:
> On Tue, Jul 02, 2019 at 01:39:05PM -0400, Steven Rostedt wrote:
> 
> I'm hitting a similar panic that bisects to commit
> 
>   a0d14b8909de ("x86/mm, tracing: Fix CR2 corruption")
> 
> except I'm experiencing death immediately after starting init.
> 
> Through sheer dumb luck, I tracked (pun intended) this down to forcing
> context tracking:
> 
>   CONFIG_CONTEXT_TRACKING=y
>   CONFIG_CONTEXT_TRACKING_FORCE=y
>   CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
> 
> I haven't attempted to debug further and I'll be offline for most of the
> next few days.  Hopefully this is enough to root cause the badness.
> 
> [    0.680477] Run /sbin/init as init process
> [    0.682116] init[1]: segfault at 2926a7ef ip 00007f98a49d9c30 sp 00007fffd83e6af0 error 14 in ld-2.23.so[7f98a49d9000+26000]

That's because the call into the context tracking muck clobbers RDX which
contains the CR2 value on pagefault. So the pagefault resolves to crap and
kills init.

Brute force fix below. That needs to be conditional on read_cr2 but for now
it does the job.

Thanks,

	tglx

8<------------
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -887,7 +887,9 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
 	.if \paranoid == 0
 	testb	$3, CS(%rsp)
 	jz	.Lfrom_kernel_no_context_tracking_\@
+	pushq	%rdx
 	CALL_enter_from_user_mode
+	popq	%rdx
 .Lfrom_kernel_no_context_tracking_\@:
 	.endif
 



