Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEED161983
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 19:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgBQSQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 13:16:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbgBQSQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:16:17 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 340C52070B;
        Mon, 17 Feb 2020 18:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581963376;
        bh=6RH9h+HX+UEiJD8EUBKaev+n34U09RB7JZESfSpYDEE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jtfA0j+j1J7Hr4gG1UnYK+WXv1HfNxPZmXShn1YCBVr3L+zBqNM4sjLSCHjEhc7Qk
         qt8PupyrSPu+s7eTRpv+MFljo5upBdWePJxkVs693yWBHJVVe2wV68/AjKYVK9yS0P
         fTtOWJaqU2uxc5M69z8fq0EzwmgizWEoDuYFSyK8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0708F352273C; Mon, 17 Feb 2020 10:16:16 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:16:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/3] rcu-tasks: *_ONCE() for
 rcu_tasks_cbs_head
Message-ID: <20200217181615.GP2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200215002446.GA15663@paulmck-ThinkPad-P72>
 <20200215002520.15746-1-paulmck@kernel.org>
 <20200217123851.GR14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217123851.GR14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 01:38:51PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 14, 2020 at 04:25:18PM -0800, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > The RCU tasks list of callbacks, rcu_tasks_cbs_head, is sampled locklessly
> > by rcu_tasks_kthread() when waiting for work to do.  This commit therefore
> > applies READ_ONCE() to that lockless sampling and WRITE_ONCE() to the
> > single potential store outside of rcu_tasks_kthread.
> > 
> > This data race was reported by KCSAN.  Not appropriate for backporting
> > due to failure being unlikely.
> 
> What failure is possible here? AFAICT this is (again) one of them
> load-complare-against-constant-discard patterns that are impossible to
> mess up.

First, please keep in mind that this is RCU code.  Rather uncomplicated
for RCU, to be sure, but still RCU code.

The failure modes are thus as follows:

o	I produce a patch for which KCSAN gives a legitimate warning,
	but this warning is obscured by a pile of other warnings.
	Yes, we should continue improving KCSAN's ability to adapt
	to the users desired compiler-optimization risk level, but
	in RCU's case that risk level is set quite low.

	In RCU, what others are calling false positives are therefore
	addressed.  Yes, this does cost me a bit of work, but it is
	trivial compared to the work required to track down a real bug.

o	Someone optimizes or otherwise changes the wait/wakeup code,
	which inadvertently gives the compiler more scope for mischief.

In short, within RCU, I am handling all KCSAN complaints.  This is looking
to be an extremely inexpensive insurance policy for RCU.  Other subsystems
are of course free to make their own tradeoffs, and subsystems having
less-aggressive concurrency control might be well-advised to take a
different path than the one I am taking.

							Thanx, Paul

> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/update.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > index 6c4b862..a27df76 100644
> > --- a/kernel/rcu/update.c
> > +++ b/kernel/rcu/update.c
> > @@ -528,7 +528,7 @@ void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
> >  	rhp->func = func;
> >  	raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
> >  	needwake = !rcu_tasks_cbs_head;
> > -	*rcu_tasks_cbs_tail = rhp;
> > +	WRITE_ONCE(*rcu_tasks_cbs_tail, rhp);
> >  	rcu_tasks_cbs_tail = &rhp->next;
> >  	raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
> >  	/* We can't create the thread unless interrupts are enabled. */
> > @@ -658,7 +658,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
> >  		/* If there were none, wait a bit and start over. */
> >  		if (!list) {
> >  			wait_event_interruptible(rcu_tasks_cbs_wq,
> > -						 rcu_tasks_cbs_head);
> > +						 READ_ONCE(rcu_tasks_cbs_head));
> >  			if (!rcu_tasks_cbs_head) {
> >  				WARN_ON(signal_pending(current));
> >  				schedule_timeout_interruptible(HZ/10);
> > -- 
> > 2.9.5
> > 
