Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4B8CCBA1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 19:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfJERVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 13:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfJERVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 13:21:32 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E859222C0;
        Sat,  5 Oct 2019 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570296091;
        bh=P+A+B/vAX7FWF7rY8J0O5Q3WyY/wMB/KN9IVikAAJEM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=W71fxnXlylJd5Hi9X5SDa0MZfJO2tCUu5VfPVuuOY3ZFB4WgVSRmjEUbHusiher1B
         qwtIwwqRW3YhTxgk0SJhcn+MyrdcEvQ2K9asEZcwpUHLm9VBdEh9G9OS4SI39a31/Q
         SgngeuJJh3wC6ZvLIL0Rbj5lIvn2PVubgrd9OcP0=
Date:   Sat, 5 Oct 2019 10:21:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 08/12] rcu: Force tick on for nohz_full CPUs
 not reaching quiescent states
Message-ID: <20191005172129.GL2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
 <20191003013903.13079-8-paulmck@kernel.org>
 <20191003145054.GC27555@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003145054.GC27555@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 04:50:55PM +0200, Frederic Weisbecker wrote:
> On Wed, Oct 02, 2019 at 06:38:59PM -0700, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@linux.ibm.com>
> > 
> > CPUs running for long time periods in the kernel in nohz_full mode
> > might leave the scheduling-clock interrupt disabled for then full
> > duration of their in-kernel execution.  This can (among other things)
> > delay grace periods.  This commit therefore forces the tick back on
> > for any nohz_full CPU that is failing to pass through a quiescent state
> > upon return from interrupt, which the resched_cpu() will induce.
> > 
> > Reported-by: Joel Fernandes <joel@joelfernandes.org>
> > [ paulmck: Clear ->rcu_forced_tick as reported by Joel Fernandes testing. ]
> > [ paulmck: Apply Joel Fernandes TICK_DEP_MASK_RCU->TICK_DEP_BIT_RCU fix. ]
> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > ---
> >  kernel/rcu/tree.c | 38 +++++++++++++++++++++++++++++++-------
> >  kernel/rcu/tree.h |  1 +
> >  2 files changed, 32 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 74bf5c65..621cc06 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -650,6 +650,12 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
> >  	 */
> >  	if (rdp->dynticks_nmi_nesting != 1) {
> >  		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
> > +		if (tick_nohz_full_cpu(rdp->cpu) &&
> > +		    rdp->dynticks_nmi_nesting == 2 &&
> > +		    rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> > +			rdp->rcu_forced_tick = true;
> > +			tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> 
> I understand rdp->cpu is always smp_processor_id() here, right? Because calling
> tick_dep_set_cpu() to a remote CPU while in NMI wouldn't be safe. It would warn anyway.

Yes, this is always invoked on the CPU whose ID is rdp->cpu, but thank
you for checking!

							Thanx, Paul
