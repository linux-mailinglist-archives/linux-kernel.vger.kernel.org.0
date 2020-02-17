Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8306A161DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 00:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgBQXDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 18:03:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgBQXDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 18:03:04 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B99620801;
        Mon, 17 Feb 2020 23:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581980583;
        bh=vw19dXoeTDHzqK+VBLov6WbJoLsfc1LeV9oIiYW493o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=1uBa8oW2JeQpzH6zBpqaq7dGPK+XTEgxIF20aoNtC1vzkN2uJUZEDP+PRSvkBGdHG
         vROKxCfEuNKCf8p4fDTwt/nlOUeuu24K5uPbsZf1EciyZzWFBF59XmLMPO5AoPHFta
         X+chGjHFqXD+O9RXKQhnWWIhXDu7qT+DPUzx2KPM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6289335227A8; Mon, 17 Feb 2020 15:03:03 -0800 (PST)
Date:   Mon, 17 Feb 2020 15:03:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH tip/core/rcu 22/30] rcu: Don't flag non-starting GPs
 before GP kthread is running
Message-ID: <20200217230303.GZ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
 <20200214235607.13749-22-paulmck@kernel.org>
 <20200214225305.48550d6a@oasis.local.home>
 <20200215110111.GZ2935@paulmck-ThinkPad-P72>
 <20200215134208.GA9879@paulmck-ThinkPad-P72>
 <20200217152517.26cc11ea@gandalf.local.home>
 <20200217220356.GY2935@paulmck-ThinkPad-P72>
 <20200217172131.1f4c48d2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217172131.1f4c48d2@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 05:21:31PM -0500, Steven Rostedt wrote:
> On Mon, 17 Feb 2020 14:03:56 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > And what is a day without micro-optimization of a slowpath?  :-)
> 
> A day you have off, but still find yourself working ;-)
> 
> > 
> > OK, let's see...
> > 
> > Grace-period kthread wakeups are normally mediated by rcu_start_this_gp(),
> > which uses a funnel lock to consolidate concurrent requests to start
> > a grace period.  If a grace period is already in progress, it refrains
> > from doing a wakeup because that means that the grace-period kthread
> > will check for another grace period being needed at the end of the
> > current grace period.
> > 
> > Exceptions include:
> > 
> > o	The wakeup reporting the last quiescent state of the current
> > 	grace period.
> > 
> > o	Emergency situations such as callback overloads and RCU CPU stalls.
> > 
> > So on a busy system that is not overloaded, the common case is that
> > rcu_gp_kthread_wake() is invoked only once per grace period because there
> > is no emergency and there is a grace period in progress.  If this system
> > has short idle periods and a fair number of quiescent states, a reasonable
> > amount of idle time, then the last quiescent state will not normally be
> > detected by the grace-period kthread.  But workloads can of course vary.
> > 
> > The "!t" holds only during early boot.  So we could put a likely() around
> > the "t".  But more to the point, at runtime, "!t" would always be false,
> > so it really should be last in the list of "||" clauses.  This isn't
> > enough of a fastpath for a static branch to make sense.
> 
> Hey! Does that mean we can add a static branch for that check?
> 
> 
> struct static_key rcu_booting = STATIC_KEY_INIT_TRUE;
> 
> [...]
> 
> 	if (READ_ONCE(rcu_state.gp_flags) ||
> 	    (current == t && !in_irq() && !in_serving_softirq())
> 		return;
> 
> 	if (static_branch_unlikely(&rcu_booting) && !t)
> 		return;
> 
> At end of boot:
> 
> 	static_key_disable(&rcu_booting);
> 
> That way we can really micro-optimize the slow path, and it basically
> becomes a nop!

;-) ;-) ;-)

There might be some place where static branches would be of use in RCU,
but unfortunately none that I can think of on the read side.  Though I
am once again making progress on Lai Jiangshan's patchset, which might
one day result in inlining of __rcu_read_lock() and __rcu_read_unlock()
in PREEMPT=y kernels.

							Thanx, Paul

> -- Steve
> 
> > 
> > The "!READ_ONCE(rcu_state.gp_flags)" will normally hold, though it is
> > false often enough to pay for itself.  Or has been in the past, anyway.
> > I suspect that access to the global variable rcu_state.gp_flags is not
> > always fast either.
> > 
> > So I am having difficulty talking myself into modifying this one given
> > the frequency of operations.
> > 
> > 							Thanx, Paul
> 
