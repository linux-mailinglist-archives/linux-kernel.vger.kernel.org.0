Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB20BEB2C9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 15:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfJaObV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 10:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727905AbfJaObV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:31:21 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D68D02087E;
        Thu, 31 Oct 2019 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572532279;
        bh=kFk+rWG7J2BMqNZJiollmdbDl2nEfZWnzteJj+4Ol8M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PEFFdBRHlenux1jomkA3Ry8xxPtd3d+2c+vVHiCR3143rhz/XZmWrNpkfzmz6Yaqv
         7YdMvWm3+TnD6TXRATiOjEQuShvrP6Erp+kL00fNLTOl3doW1XAuou6SjjEvZsqWVe
         Emm40IDsVwkW5kHIyFzQgLBAC5O1WiRYp57Yjb6U=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AA77D3520744; Thu, 31 Oct 2019 07:31:19 -0700 (PDT)
Date:   Thu, 31 Oct 2019 07:31:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 02/11] rcu: fix bug when rcu_exp_handler() in nested
 interrupt
Message-ID: <20191031143119.GA15954@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-3-laijs@linux.alibaba.com>
 <20191031134731.GP20975@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031134731.GP20975@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 06:47:31AM -0700, Paul E. McKenney wrote:
> On Thu, Oct 31, 2019 at 10:07:57AM +0000, Lai Jiangshan wrote:
> > These is a possible bug (although which I can't triger yet)
> > since 2015 8203d6d0ee78
> > (rcu: Use single-stage IPI algorithm for RCU expedited grace period)
> > 
> >  rcu_read_unlock()
> >   ->rcu_read_lock_nesting = -RCU_NEST_BIAS;
> >   interrupt(); // before or after rcu_read_unlock_special()
> >    rcu_read_lock()
> >     fetch some rcu protected pointers
> >     // exp GP starts in other cpu.
> >     some works
> >     NESTED interrupt for rcu_exp_handler();

Also, which platforms support nested interrupts?  Last I knew, this was
prohibited.

> >       report exp qs! BUG!
> 
> Why would a quiescent state for the expedited grace period be reported
> here?  This CPU is still in an RCU read-side critical section, isn't it?

And I now see what you were getting at here.  Yes, the current code
assumes that interrupt-disabled regions, like hardware interrupt
handlers, cannot be interrupted.  But if interrupt-disabled regions such
as hardware interrupt handlers can be interrupted (as opposed to being
NMIed), wouldn't that break a whole lot of stuff all over the place in
the kernel?  So that sounds like an arch bug to me.

							Thanx, Paul

> >     // exp GP completes and pointers are freed in other cpu
> >     some works with the pointers. BUG
> >    rcu_read_unlock();
> >   ->rcu_read_lock_nesting = 0;
> > 
> > Although rcu_sched_clock_irq() can be in nested interrupt,
> > there is no such similar bug since special.b.need_qs
> > can only be set when ->rcu_read_lock_nesting > 0
> > 
> > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > ---
> >  kernel/rcu/tree_exp.h    | 5 +++--
> >  kernel/rcu/tree_plugin.h | 9 ++++++---
> >  2 files changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index 6dec21909b30..c0d06bce35ea 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -664,8 +664,9 @@ static void rcu_exp_handler(void *unused)
> >  	 * Otherwise, force a context switch after the CPU enables everything.
> >  	 */
> >  	rdp->exp_deferred_qs = true;
> > -	if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
> > -	    WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs())) {
> > +	if (rcu_preempt_need_deferred_qs(t) &&
> > +	    (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
> > +	    WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs()))) {
> >  		rcu_preempt_deferred_qs(t);
> >  	} else {
> >  		set_tsk_need_resched(t);
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index d4c482490589..59ef10da1e39 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -549,9 +549,12 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
> >   */
> >  static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
> >  {
> > -	return (__this_cpu_read(rcu_data.exp_deferred_qs) ||
> > -		READ_ONCE(t->rcu_read_unlock_special.s)) &&
> > -	       t->rcu_read_lock_nesting <= 0;
> > +	return (__this_cpu_read(rcu_data.exp_deferred_qs) &&
> > +		(!t->rcu_read_lock_nesting ||
> > +		 t->rcu_read_lock_nesting == -RCU_NEST_BIAS))
> > +		||
> > +		(READ_ONCE(t->rcu_read_unlock_special.s) &&
> > +		 t->rcu_read_lock_nesting <= 0);
> >  }
> >  
> >  /*
> > -- 
> > 2.20.1
> > 
