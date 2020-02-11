Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B95E8159283
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 16:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgBKPGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 10:06:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgBKPGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:06:18 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [193.85.242.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D93182082F;
        Tue, 11 Feb 2020 15:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581433578;
        bh=YYyt2OCC9eBuYsDoh3tr+CDHOzpZLf/SDjdzf6+ew/s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rqpQZa8+kqwP6emgG6WeQ319BmyuH15Fd/uuaF9ut4XDsUYwERE+HG6uf0GG/BS2x
         OW7oOf1Jf23/mGXlfTT7h530Eock1yzjC6E6D7pAe6Sh+ZHfZNF3003yp3/LWYyN5/
         yWjQaNwfL/pe3ob4zIuAH2W8AMdQ7IuykBOvpvT4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B2DEB3520CBE; Tue, 11 Feb 2020 07:06:15 -0800 (PST)
Date:   Tue, 11 Feb 2020 07:06:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
Message-ID: <20200211150615.GK2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200210170643.3544795d@gandalf.local.home>
 <20200211114954.GK14914@hirez.programming.kicks-ass.net>
 <20200211090503.68c0d70f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211090503.68c0d70f@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 09:05:03AM -0500, Steven Rostedt wrote:
> On Tue, 11 Feb 2020 12:49:54 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Feb 10, 2020 at 05:06:43PM -0500, Steven Rostedt wrote:
> > > +	if (!rcu_watching) {						\
> > > +		/* Can not use RCU if rcu is not watching and in NMI */	\
> > > +		if (in_nmi())						\
> > > +			return;						\
> > > +		rcu_irq_enter_irqson();					\
> > > +	}								\  
> > 
> > I saw the same weirdness in __trace_stack(), and I'm confused by it.
> > 
> > How can we ever get to: in_nmi() && !rcu_watching() ? That should be a
> > BUG.  In particular, nmi_enter() has rcu_nmi_enter().
> > 
> > Paul, can that really happen?
> 
> The stack tracer connects to the function tracer and is called at all
> the places that function tracing can be called from. As I like being
> able to trace RCU internal functions (especially as they are complex),
> I don't want to set them all to notrace. But, for callbacks that
> require RCU to be watching, we need this check, because there's some
> internal state that we can be in an NMI and RCU is not watching (as
> there's some places in nmi_enter that can be traced!).
> 
> And if we are tracing preempt_enable and preempt_disable (as Joel added
> trace events there), it may be the case for trace events too.

Ah, thank you for the reminder!

Should Documentation/RCU/Design/Requirements/Requirements.rst be
updated to include this?

And I have to ask...  What happens if we are very early in from-idle
NMI entry (or very late in NMI exit), such that both in_nmi() and
rcu_is_watching() are returning false?  Or did I miss a turn somewhere?

							Thanx, Paul
