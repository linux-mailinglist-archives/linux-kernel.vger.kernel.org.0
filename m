Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 094466EE38
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 09:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfGTHck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jul 2019 03:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfGTHck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 03:32:40 -0400
Received: from devnote2 (72.65.214.202.bf.2iij.net [202.214.65.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED4C220644;
        Sat, 20 Jul 2019 07:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563607959;
        bh=VvlwVVYw0AYiQp3KGjA3u/8HBvxH/UFD5XmZWTT+i4s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fb1SJyIYD2QW9MJU129mUeNXY672MYyi18IPneV3j3zTgNPjjNCQtyn9r3sKhBA7J
         vnjNvJjLQ9bbEJT5Iu+9rWu/KNKXzobh4GAKdu5PrINoLCa7WprronhuPwUB7zh0Re
         UExXiLJNuk3scbSB+0wmQis4dMvNjvrBF+gIXYS4=
Date:   Sat, 20 Jul 2019 16:32:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     James Morse <james.morse@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>
Subject: Re: [PATCH 3/3] arm64: debug: Remove rcu_read_lock from debug
 exception
Message-Id: <20190720163232.49f80bc0e53afb893e7a82e6@kernel.org>
In-Reply-To: <536ba068-50de-963e-c3a7-0440da56943a@arm.com>
References: <156342860634.8565.14804606041960884732.stgit@devnote2>
        <156342863822.8565.7624877983728871995.stgit@devnote2>
        <20190718062215.GG14271@linux.ibm.com>
        <20190718092022.GA3625@blommer>
        <20190718233133.146065f668da6297e57e52ef@kernel.org>
        <536ba068-50de-963e-c3a7-0440da56943a@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, 19 Jul 2019 09:42:05 +0100
James Morse <james.morse@arm.com> wrote:

> Hi,
> 
> On 7/18/19 3:31 PM, Masami Hiramatsu wrote:
> > On Thu, 18 Jul 2019 10:20:23 +0100
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> >> On Wed, Jul 17, 2019 at 11:22:15PM -0700, Paul E. McKenney wrote:
> >>> On Thu, Jul 18, 2019 at 02:43:58PM +0900, Masami Hiramatsu wrote:
> >>>> Remove rcu_read_lock()/rcu_read_unlock() from debug exception
> >>>> handlers since the software breakpoint can be hit on idle task.
> >>
> >> Why precisely do we need to elide these? Are we seeing warnings today?
> > 
> > Yes, unfortunately, or fortunately. Naresh reported that warns when
> > ftracetest ran. I confirmed that happens if I probe on default_idle_call too.
> > 
> > /sys/kernel/debug/tracing # echo p default_idle_call >> kprobe_events
> > /sys/kernel/debug/tracing # echo 1 > events/kprobes/enable
> > /sys/kernel/debug/tracing # [  135.122237]
> > [  135.125035] =============================
> > [  135.125310] WARNING: suspicious RCU usage
> 
> > [  135.132224] Call trace:
> > [  135.132491]  dump_backtrace+0x0/0x140
> > [  135.132806]  show_stack+0x24/0x30
> > [  135.133133]  dump_stack+0xc4/0x10c
> > [  135.133726]  lockdep_rcu_suspicious+0xf8/0x108
> > [  135.134171]  call_break_hook+0x170/0x178
> > [  135.134486]  brk_handler+0x28/0x68
> > [  135.134792]  do_debug_exception+0x90/0x150
> > [  135.135051]  el1_dbg+0x18/0x8c
> > [  135.135260]  default_idle_call+0x0/0x44
> > [  135.135516]  cpu_startup_entry+0x2c/0x30
> > [  135.135815]  rest_init+0x1b0/0x280
> > [  135.136044]  arch_call_rest_init+0x14/0x1c
> > [  135.136305]  start_kernel+0x4d4/0x500
> 
> >>> The exception entry and exit use irq_enter() and irq_exit(), in this
> >>> case, correct?  Otherwise RCU will be ignoring this CPU.
> >>
> >> This is missing today, which sounds like the underlying bug.
> > 
> > Agreed. I'm not so familier with how debug exception is handled on arm64,
> > would it be a kind of NMI or IRQ?
> 
> Debug exceptions can interrupt both SError (think: machine check) and 
> pseudo-NMI, which both in turn interrupt interrupt-masked code. So they 
> are a kind of NMI. But, be careful not to call 'nmi_enter()' twice, see 
> do_serror() for how we work around this...

OK. I think we can use rcu_nmi_enter/exit() as same as x86.

> > Anyway, it seems that normal irqs are also not calling irq_enter/exit
> > except for arch/arm64/kernel/smp.c
> drivers/irqchip/irq-gic.c:gic_handle_irq() either calls 
> handle_domain_irq() or handle_IPI(). The enter/exit calls live in those 
> functions.

Ah, I see.
Would you think we need to put rcu_nmi_enter/exit() as similar to x86
on do_mem_abort() and do_sp_pc_abort() too?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
