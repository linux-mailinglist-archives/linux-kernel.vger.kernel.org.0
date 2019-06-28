Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3E45916C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 04:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfF1CoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 22:44:23 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:57211 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726476AbfF1CoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:44:23 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 28 Jun 2019 11:44:20 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.151 with ESMTP; 28 Jun 2019 11:44:20 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Fri, 28 Jun 2019 11:43:39 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v2] rcu: Change return type of
 rcu_spawn_one_boost_kthread()
Message-ID: <20190628024339.GA13650@X58A-UD3R>
References: <1561619266-8850-1-git-send-email-byungchul.park@lge.com>
 <20190627134240.GB215968@google.com>
 <20190627205703.GF26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627205703.GF26519@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 01:57:03PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 27, 2019 at 09:42:40AM -0400, Joel Fernandes wrote:
> > On Thu, Jun 27, 2019 at 04:07:46PM +0900, Byungchul Park wrote:
> > > Hello,
> > > 
> > > I tested if the WARN_ON_ONCE() is fired with my box and it was ok.
> > 
> > Looks pretty safe to me and nice clean up!
> > 
> > Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Agreed, but I still cannot find where this applies.  I did try rcu/next,
> which is currently here:
> 
> commit b989ff070574ad8b8621d866de0a8e9a65d42c80 (rcu/rcu/next, rcu/next)
> Merge: 4289ee7d5a83 11ca7a9d541d
> Author: Paul E. McKenney <paulmck@linux.ibm.com>
> Date:   Mon Jun 24 09:12:39 2019 -0700
> 
>     Merge LKMM and RCU commits
> 
> Help?

commit 204d7a60670f3f6399a4d0826667ab7863b3e429

     Merge LKMM and RCU commits

I made it on top of the above. And could you tell me which branch I'd
better use when developing. I think it's been changing sometimes.

Thank you for the answer in advance!

Thanks,
Byungchul

> 							Thanx, Paul
> 
> >  - Joel
> > 
> > > 
> > > Thanks,
> > > Byungchul
> > > 
> > > Changes from v1
> > > -. WARN_ON_ONCE() on failing to create rcu_boost_kthread.
> > > -. Changed title and commit message a bit.
> > > 
> > > ---8<---
> > > From 7100fcf82202f063f70f45def208ea5198412f5a Mon Sep 17 00:00:00 2001
> > > From: Byungchul Park <byungchul.park@lge.com>
> > > Date: Thu, 27 Jun 2019 15:58:10 +0900
> > > Subject: [PATCH v2] rcu: Change return type of rcu_spawn_one_boost_kthread()
> > > 
> > > The return value of rcu_spawn_one_boost_kthread() is not used any
> > > longer. Change return type of that function from int to void.
> > > 
> > > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > > ---
> > >  kernel/rcu/tree_plugin.h | 17 ++++++++---------
> > >  1 file changed, 8 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index 1102765..3c8444e 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -1131,7 +1131,7 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
> > >   * already exist.  We only create this kthread for preemptible RCU.
> > >   * Returns zero if all is well, a negated errno otherwise.
> > >   */
> > > -static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> > > +static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> > >  {
> > >  	int rnp_index = rnp - rcu_get_root();
> > >  	unsigned long flags;
> > > @@ -1139,25 +1139,24 @@ static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> > >  	struct task_struct *t;
> > >  
> > >  	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
> > > -		return 0;
> > > +		return;
> > >  
> > >  	if (!rcu_scheduler_fully_active || rcu_rnp_online_cpus(rnp) == 0)
> > > -		return 0;
> > > +		return;
> > >  
> > >  	rcu_state.boost = 1;
> > >  	if (rnp->boost_kthread_task != NULL)
> > > -		return 0;
> > > +		return;
> > >  	t = kthread_create(rcu_boost_kthread, (void *)rnp,
> > >  			   "rcub/%d", rnp_index);
> > > -	if (IS_ERR(t))
> > > -		return PTR_ERR(t);
> > > +	if (WARN_ON_ONCE(IS_ERR(t)))
> > > +		return;
> > >  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > >  	rnp->boost_kthread_task = t;
> > >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > >  	sp.sched_priority = kthread_prio;
> > >  	sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
> > >  	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
> > > -	return 0;
> > >  }
> > >  
> > >  static void rcu_cpu_kthread_setup(unsigned int cpu)
> > > @@ -1265,7 +1264,7 @@ static void __init rcu_spawn_boost_kthreads(void)
> > >  	if (WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec), "%s: Could not start rcub kthread, OOM is now expected behavior\n", __func__))
> > >  		return;
> > >  	rcu_for_each_leaf_node(rnp)
> > > -		(void)rcu_spawn_one_boost_kthread(rnp);
> > > +		rcu_spawn_one_boost_kthread(rnp);
> > >  }
> > >  
> > >  static void rcu_prepare_kthreads(int cpu)
> > > @@ -1275,7 +1274,7 @@ static void rcu_prepare_kthreads(int cpu)
> > >  
> > >  	/* Fire up the incoming CPU's kthread and leaf rcu_node kthread. */
> > >  	if (rcu_scheduler_fully_active)
> > > -		(void)rcu_spawn_one_boost_kthread(rnp);
> > > +		rcu_spawn_one_boost_kthread(rnp);
> > >  }
> > >  
> > >  #else /* #ifdef CONFIG_RCU_BOOST */
> > > -- 
> > > 1.9.1
> > > 
