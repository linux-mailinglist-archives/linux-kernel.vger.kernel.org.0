Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 785D6159506
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 17:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbgBKQfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 11:35:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728295AbgBKQfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:35:08 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0FD320708;
        Tue, 11 Feb 2020 16:35:06 +0000 (UTC)
Date:   Tue, 11 Feb 2020 11:35:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2] tracing/perf: Move rcu_irq_enter/exit_irqson() to
 perf trace point hook
Message-ID: <20200211113505.0a1b52e9@gandalf.local.home>
In-Reply-To: <698566505.617724.1581438456170.JavaMail.zimbra@efficios.com>
References: <20200211095047.58ddf750@gandalf.local.home>
        <20200211153452.GW14914@hirez.programming.kicks-ass.net>
        <20200211111828.48058768@gandalf.local.home>
        <698566505.617724.1581438456170.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020 11:27:36 -0500 (EST)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Feb 11, 2020, at 11:18 AM, rostedt rostedt@goodmis.org wrote:
> 
> > On Tue, 11 Feb 2020 16:34:52 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> >> > +		if (unlikely(in_nmi()))
> >> > +			goto out;  
> >> 
> >> unless I'm mistaken, we can simply do rcu_nmi_enter() in this case, and
> >> rcu_nmi_exit() on the other end.
> >>   
> >> > +		rcu_irq_enter_irqson();  
> > 
> > The thing is, I don't think this can ever happen. We've had in the
> > tracepoint.h:
> > 
> >		/* srcu can't be used from NMI */			\
> >		WARN_ON_ONCE(rcuidle && in_nmi());			\
> > 
> > And this has yet to trigger.  
> 
> But that "rcuidle" state is defined on a per-tracepoint basis, whereas
> "!rcu_is_watching()" is a state which depends on the current execution
> context. I don't follow how the fact that this WARN_ON_ONCE() never
> triggered allows us to infer anything about (!rcu_is_watching() && in_nmi()).
>

The "_rcuidle()" version of the tracepoint was to be used in places
that RCU may not be watching, otherwise you would get a lockdep splat.

As that "rcuidle" variable is a hardcoded constant, it would be
compiled out when rcuidle is zero. But, in all purposes, rcuidle is
basically equivalent to rcu_is_watching(), because if it wasn't you
would have lockdep splats.

-- Steve
