Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE77815919A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 15:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgBKOKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 09:10:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbgBKOKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:10:43 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68EC020675;
        Tue, 11 Feb 2020 14:10:42 +0000 (UTC)
Date:   Tue, 11 Feb 2020 09:10:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
Message-ID: <20200211091040.25d92244@gandalf.local.home>
In-Reply-To: <20200211122120.GM14914@hirez.programming.kicks-ass.net>
References: <20200210170643.3544795d@gandalf.local.home>
        <20200211122120.GM14914@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020 13:21:20 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > @@ -68,6 +78,9 @@ perf_trace_##call(void *__data, proto)					\
> >  	perf_trace_run_bpf_submit(entry, __entry_size, rctx,		\
> >  				  event_call, __count, __regs,		\
> >  				  head, __task);			\
> > +out:									\
> > +	if (!rcu_watching)						\
> > +		rcu_irq_exit_irqson();					\
> >  }  
> 
> It is probably okay to move that into perf_tp_event(), then this:
> 
> >  /*
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 1694a6b57ad8..3e6f07b62515 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -719,6 +719,7 @@ void rcu_irq_exit_irqson(void)
> >  	rcu_irq_exit();
> >  	local_irq_restore(flags);
> >  }
> > +EXPORT_SYMBOL_GPL(rcu_irq_exit_irqson);
> >  
> >  /*
> >   * Exit an RCU extended quiescent state, which can be either the
> > @@ -890,6 +891,7 @@ void rcu_irq_enter_irqson(void)
> >  	rcu_irq_enter();
> >  	local_irq_restore(flags);
> >  }
> > +EXPORT_SYMBOL_GPL(rcu_irq_enter_irqson);
> >  
> >  /*
> >   * If any sort of urgency was applied to the current CPU (for example,  
> 
> can go too. Those things really should not be exported.

Thanks, I'll send an updated patch.

-- Steve
