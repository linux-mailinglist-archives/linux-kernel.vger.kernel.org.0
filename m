Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E1F94A11
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 18:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfHSQcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 12:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbfHSQcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:32:31 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82CA522CEB;
        Mon, 19 Aug 2019 16:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566232350;
        bh=mxD0wC7LhsikH/97K6xxAQa61OvUyEe+giJRqBAhtXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F6QD4SSAe2j4I/49H+9zpHfa9rJlLyCjnGvO0Xc093z9I1YD9OxMlqeSUxV4zi2CP
         hWBcdQVXbq6vnS6tKU3qB0AWlBZxtUinKUB/MD1KShSqNIv94FGqoOPDoTabN2bLG7
         t1suHwS+qzyr1DvSIlctMO0bR0Q7Jo/7v9QXPtTM=
Date:   Mon, 19 Aug 2019 18:32:27 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH -rcu dev 1/3] rcu/tree: tick_dep_set/clear_cpu should
 accept bits instead of masks
Message-ID: <20190819163226.GE27088@lenoir>
References: <20190816025311.241257-1-joel@joelfernandes.org>
 <20190819123837.GC27088@lenoir>
 <20190819144632.GW28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819144632.GW28441@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 07:46:32AM -0700, Paul E. McKenney wrote:
> On Mon, Aug 19, 2019 at 02:38:38PM +0200, Frederic Weisbecker wrote:
> > On Thu, Aug 15, 2019 at 10:53:09PM -0400, Joel Fernandes (Google) wrote:
> > > This commit fixes the issue.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/tree.c | 29 +++++++++++++++++------------
> > >  1 file changed, 17 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 0512de9ead20..322b1b57967c 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -829,7 +829,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> > >  		   !rdp->dynticks_nmi_nesting &&
> > >  		   rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> > >  		rdp->rcu_forced_tick = true;
> > > -		tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> > > +		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
> > 
> > Did I suggest you to use the _MASK_ value? That was a bit mean.
> > Sorry for all that lost debugging time :-(
> 
> At some point, I should have looked at the other calls to these
> functions.  :-/
> 
> But would the following patch make sense?  This would not help for (say)
> use of TICK_MASK_BIT_POSIX_TIMER instead of TICK_DEP_BIT_POSIX_TIMER, but
> would help for any new values that might be added later on.  And currently
> for TICK_DEP_MASK_CLOCK_UNSTABLE and TICK_DEP_MASK_RCU.

I'd rather make the TICK_DEP_MASK_* values private to kernel/time/tick-sched.c but
that means I need to re-arrange a bit include/trace/events/timer.h

I'm looking into it. Meanwhile, your below patch that checks for the max value is
still valuable.

Thanks.

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index 39eb44564058..4ed788ce5762 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -111,6 +111,7 @@ enum tick_dep_bits {
>  	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3,
>  	TICK_DEP_BIT_RCU		= 4
>  };
> +#define TICK_DEP_BIT_MAX TICK_DEP_BIT_RCU
>  
>  #define TICK_DEP_MASK_NONE		0
>  #define TICK_DEP_MASK_POSIX_TIMER	(1 << TICK_DEP_BIT_POSIX_TIMER)
> @@ -215,24 +216,28 @@ extern void tick_nohz_dep_clear_signal(struct signal_struct *signal,
>   */
>  static inline void tick_dep_set(enum tick_dep_bits bit)
>  {
> +	WARN_ON_ONCE(bit > TICK_DEP_BIT_MAX);
>  	if (tick_nohz_full_enabled())
>  		tick_nohz_dep_set(bit);
>  }
>  
>  static inline void tick_dep_clear(enum tick_dep_bits bit)
>  {
> +	WARN_ON_ONCE(bit > TICK_DEP_BIT_MAX);
>  	if (tick_nohz_full_enabled())
>  		tick_nohz_dep_clear(bit);
>  }
>  
>  static inline void tick_dep_set_cpu(int cpu, enum tick_dep_bits bit)
>  {
> +	WARN_ON_ONCE(bit > TICK_DEP_BIT_MAX);
>  	if (tick_nohz_full_cpu(cpu))
>  		tick_nohz_dep_set_cpu(cpu, bit);
>  }
>  
>  static inline void tick_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
>  {
> +	WARN_ON_ONCE(bit > TICK_DEP_BIT_MAX);
>  	if (tick_nohz_full_cpu(cpu))
>  		tick_nohz_dep_clear_cpu(cpu, bit);
>  }
> @@ -240,24 +245,28 @@ static inline void tick_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
>  static inline void tick_dep_set_task(struct task_struct *tsk,
>  				     enum tick_dep_bits bit)
>  {
> +	WARN_ON_ONCE(bit > TICK_DEP_BIT_MAX);
>  	if (tick_nohz_full_enabled())
>  		tick_nohz_dep_set_task(tsk, bit);
>  }
>  static inline void tick_dep_clear_task(struct task_struct *tsk,
>  				       enum tick_dep_bits bit)
>  {
> +	WARN_ON_ONCE(bit > TICK_DEP_BIT_MAX);
>  	if (tick_nohz_full_enabled())
>  		tick_nohz_dep_clear_task(tsk, bit);
>  }
>  static inline void tick_dep_set_signal(struct signal_struct *signal,
>  				       enum tick_dep_bits bit)
>  {
> +	WARN_ON_ONCE(bit > TICK_DEP_BIT_MAX);
>  	if (tick_nohz_full_enabled())
>  		tick_nohz_dep_set_signal(signal, bit);
>  }
>  static inline void tick_dep_clear_signal(struct signal_struct *signal,
>  					 enum tick_dep_bits bit)
>  {
> +	WARN_ON_ONCE(bit > TICK_DEP_BIT_MAX);
>  	if (tick_nohz_full_enabled())
>  		tick_nohz_dep_clear_signal(signal, bit);
>  }
