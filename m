Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCE8666A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 07:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfGLFt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 01:49:29 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:52555 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725807AbfGLFt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 01:49:28 -0400
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.52 with ESMTP; 12 Jul 2019 14:49:25 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.127 with ESMTP; 12 Jul 2019 14:49:25 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Fri, 12 Jul 2019 14:48:28 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190712054828.GA7702@X58A-UD3R>
References: <1562565609-12482-1-git-send-email-byungchul.park@lge.com>
 <20190708125013.GG26519@linux.ibm.com>
 <20190708130359.GA42888@google.com>
 <20190709055815.GA19459@X58A-UD3R>
 <20190709124102.GR26519@linux.ibm.com>
 <20190710012025.GA20711@X58A-UD3R>
 <20190711123052.GI26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711123052.GI26519@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 05:30:52AM -0700, Paul E. McKenney wrote:
> > > If there is a real need, something needs to be provided to meet that
> > > need.  But in the absence of a real need, past experience has shown
> > > that speculative tuning knobs usually do more harm than good.  ;-)
> > 
> > It makes sense, "A speculative tuning knobs do more harm than good".
> > 
> > Then, it would be better to leave jiffies_till_{first,next}_fqs tunnable
> > but jiffies_till_sched_qs until we need it.
> > 
> > However,
> > 
> > (1) In case that jiffies_till_sched_qs is tunnable:
> > 
> > 	We might need all of jiffies_till_{first,next}_qs,
> > 	jiffies_till_sched_qs and jiffies_to_sched_qs because
> > 	jiffies_to_sched_qs can be affected by any of them. So we
> > 	should be able to read each value at any time.
> > 
> > (2) In case that jiffies_till_sched_qs is not tunnable:
> > 
> > 	I think we don't have to keep the jiffies_till_sched_qs any
> > 	longer since that's only for setting jiffies_to_sched_qs at
> > 	*booting time*, which can be done with jiffies_to_sched_qs too.
> > 	It's meaningless to keep all of tree variables.
> > 
> > The simpler and less knobs that we really need we have, the better.
> > 
> > what do you think about it?
> > 
> > In the following patch, I (1) removed jiffies_till_sched_qs and then
> > (2) renamed jiffies_*to*_sched_qs to jiffies_*till*_sched_qs because I
> > think jiffies_till_sched_qs is a much better name for the purpose. I
> > will resend it with a commit msg after knowing your opinion on it.

Hi Paul,

> I will give you a definite "maybe".
> 
> Here are the two reasons for changing RCU's embarrassingly large array
> of tuning parameters:
> 
> 1.	They are causing a problem in production.  This would represent a
> 	bug that clearly must be fixed.  As you say, this change is not
> 	in this category.
> 
> 2.	The change simplifies either RCU's code or the process of tuning
> 	RCU, but without degrading RCU's ability to run everywhere and
> 	without removing debugging tools.

Agree.

> The change below clearly simplifies things by removing a few lines of
> code, and it does not change RCU's default self-configuration.  But are
> we sure about the debugging aspect?  (Please keep in mind that many more

I'm sorry I don't get it. I don't think this patch affect any debugging
ability. What do you think it hurts? Could you explain it more?

> sites are willing to change boot parameters than are willing to patch
> their kernels.)

Right.

> What do you think?
> 
> Finally, I urge you to join with Joel Fernandes and go through these
> grace-period-duration tuning parameters.  Once you guys get your heads
> completely around all of them and how they interact across the different
> possible RCU configurations, I bet that the two of you will have excellent
> ideas for improvement.

Great. I'd be happy if I join the improvement and with Joel. I might
need to ask you exactly what you expect in detail maybe. Anyway I will
willingly go with it. :)

Thanks,
Byungchul

> 							Thanx, Paul
> 
> > Thanks,
> > Byungchul
> > 
> > ---8<---
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index e72c184..94b58f5 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3792,10 +3792,6 @@
> >  			a value based on the most recent settings
> >  			of rcutree.jiffies_till_first_fqs
> >  			and rcutree.jiffies_till_next_fqs.
> > -			This calculated value may be viewed in
> > -			rcutree.jiffies_to_sched_qs.  Any attempt to set
> > -			rcutree.jiffies_to_sched_qs will be cheerfully
> > -			overwritten.
> >  
> >  	rcutree.kthread_prio= 	 [KNL,BOOT]
> >  			Set the SCHED_FIFO priority of the RCU per-CPU
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index a2f8ba2..ad9dc86 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -421,10 +421,8 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> >   * How long the grace period must be before we start recruiting
> >   * quiescent-state help from rcu_note_context_switch().
> >   */
> > -static ulong jiffies_till_sched_qs = ULONG_MAX;
> > +static ulong jiffies_till_sched_qs = ULONG_MAX; /* See adjust_jiffies_till_sched_qs(). */
> >  module_param(jiffies_till_sched_qs, ulong, 0444);
> > -static ulong jiffies_to_sched_qs; /* See adjust_jiffies_till_sched_qs(). */
> > -module_param(jiffies_to_sched_qs, ulong, 0444); /* Display only! */
> >  
> >  /*
> >   * Make sure that we give the grace-period kthread time to detect any
> > @@ -436,18 +434,13 @@ static void adjust_jiffies_till_sched_qs(void)
> >  {
> >  	unsigned long j;
> >  
> > -	/* If jiffies_till_sched_qs was specified, respect the request. */
> > -	if (jiffies_till_sched_qs != ULONG_MAX) {
> > -		WRITE_ONCE(jiffies_to_sched_qs, jiffies_till_sched_qs);
> > -		return;
> > -	}
> >  	/* Otherwise, set to third fqs scan, but bound below on large system. */
> >  	j = READ_ONCE(jiffies_till_first_fqs) +
> >  		      2 * READ_ONCE(jiffies_till_next_fqs);
> >  	if (j < HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV)
> >  		j = HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV;
> >  	pr_info("RCU calculated value of scheduler-enlistment delay is %ld jiffies.\n", j);
> > -	WRITE_ONCE(jiffies_to_sched_qs, j);
> > +	WRITE_ONCE(jiffies_till_sched_qs, j);
> >  }
> >  
> >  static int param_set_first_fqs_jiffies(const char *val, const struct kernel_param *kp)
> > @@ -1033,16 +1026,16 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
> >  
> >  	/*
> >  	 * A CPU running for an extended time within the kernel can
> > -	 * delay RCU grace periods: (1) At age jiffies_to_sched_qs,
> > -	 * set .rcu_urgent_qs, (2) At age 2*jiffies_to_sched_qs, set
> > +	 * delay RCU grace periods: (1) At age jiffies_till_sched_qs,
> > +	 * set .rcu_urgent_qs, (2) At age 2*jiffies_till_sched_qs, set
> >  	 * both .rcu_need_heavy_qs and .rcu_urgent_qs.  Note that the
> >  	 * unsynchronized assignments to the per-CPU rcu_need_heavy_qs
> >  	 * variable are safe because the assignments are repeated if this
> >  	 * CPU failed to pass through a quiescent state.  This code
> > -	 * also checks .jiffies_resched in case jiffies_to_sched_qs
> > +	 * also checks .jiffies_resched in case jiffies_till_sched_qs
> >  	 * is set way high.
> >  	 */
> > -	jtsq = READ_ONCE(jiffies_to_sched_qs);
> > +	jtsq = READ_ONCE(jiffies_till_sched_qs);
> >  	ruqp = per_cpu_ptr(&rcu_data.rcu_urgent_qs, rdp->cpu);
> >  	rnhqp = &per_cpu(rcu_data.rcu_need_heavy_qs, rdp->cpu);
> >  	if (!READ_ONCE(*rnhqp) &&
> > @@ -3383,7 +3376,8 @@ static void __init rcu_init_geometry(void)
> >  		jiffies_till_first_fqs = d;
> >  	if (jiffies_till_next_fqs == ULONG_MAX)
> >  		jiffies_till_next_fqs = d;
> > -	adjust_jiffies_till_sched_qs();
> > +	if (jiffies_till_sched_qs == ULONG_MAX)
> > +		adjust_jiffies_till_sched_qs();
> >  
> >  	/* If the compile-time values are accurate, just leave. */
> >  	if (rcu_fanout_leaf == RCU_FANOUT_LEAF &&
