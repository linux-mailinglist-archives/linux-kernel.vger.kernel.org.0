Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21503520C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 04:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbfFYCu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 22:50:56 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:35130 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbfFYCuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 22:50:55 -0400
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.51 with ESMTP; 25 Jun 2019 11:50:53 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.126 with ESMTP; 25 Jun 2019 11:50:53 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Tue, 25 Jun 2019 11:50:15 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [RFC] rcu: Warn that rcu ktheads cannot be spawned
Message-ID: <20190625025015.GB10912@X58A-UD3R>
References: <1561364852-5113-1-git-send-email-byungchul.park@lge.com>
 <20190624164624.GA41314@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624164624.GA41314@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 12:46:24PM -0400, Joel Fernandes wrote:
> On Mon, Jun 24, 2019 at 05:27:32PM +0900, Byungchul Park wrote:
> > Hello rcu folks,
> > 
> > I thought it'd better to announce it if those spawnings fail because of
> > !rcu_scheduler_fully_active.
> > 
> > Of course, with the current code, it never happens though.
> > 
> > Thoughts?
> 
> It seems in the right spirit, but with your patch a warning always fires.
> rcu_prepare_cpu() is called multiple times, once from rcu_init() and then
> from hotplug paths.

I'm sorry bothering you.

I sent the patch to ask how you guys think about the direction coz I'm
not sure if the current code w/o warning on it is intended or not.

However from now on, I think I need to test it first even if it's RFC :)

Thank you very much for the information.

Thanks,
Byungchul

> Warning splat stack looks like:
> 
> [    0.398767] Call Trace:                                                                                                        
> [    0.398775]  rcu_init+0x6aa/0x724                                             
> [    0.398779]  start_kernel+0x220/0x4a2                                    
> [    0.398780]  ? copy_bootdata+0x12/0xac                                                                                                                                   
> [    0.398782]  secondary_startup_64+0xa4/0xb0    
> 
> 
> > 
> > Thanks,
> > Byungchul
> > 
> > ---8<---
> > From 58a33a85c70f82c406319b4752af95cf6ceb73a3 Mon Sep 17 00:00:00 2001
> > From: Byungchul Park <byungchul.park@lge.com>
> > Date: Mon, 24 Jun 2019 17:08:26 +0900
> > Subject: [RFC] rcu: Warn that rcu ktheads cannot be spawned
> > 
> > In case that rcu ktheads cannot be spawned due to
> > !rcu_scheduler_fully_active, it'd be better to anounce it.
> > 
> > While at it, because the return value of rcu_spawn_one_boost_kthread()
> > is not used any longer, changed the return type from int to void.
> > 
> > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > ---
> >  kernel/rcu/tree_plugin.h | 31 +++++++++++++++++++------------
> >  1 file changed, 19 insertions(+), 12 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 1102765..7d74193 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -1131,7 +1131,7 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
> >   * already exist.  We only create this kthread for preemptible RCU.
> >   * Returns zero if all is well, a negated errno otherwise.
> >   */
> > -static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> > +static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> >  {
> >  	int rnp_index = rnp - rcu_get_root();
> >  	unsigned long flags;
> > @@ -1139,25 +1139,24 @@ static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> >  	struct task_struct *t;
> >  
> >  	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
> > -		return 0;
> > +		return;
> >  
> > -	if (!rcu_scheduler_fully_active || rcu_rnp_online_cpus(rnp) == 0)
> > -		return 0;
> > +	if (rcu_rnp_online_cpus(rnp) == 0)
> > +		return;
> >  
> >  	rcu_state.boost = 1;
> >  	if (rnp->boost_kthread_task != NULL)
> > -		return 0;
> > +		return;
> >  	t = kthread_create(rcu_boost_kthread, (void *)rnp,
> >  			   "rcub/%d", rnp_index);
> >  	if (IS_ERR(t))
> > -		return PTR_ERR(t);
> > +		return;
> >  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> >  	rnp->boost_kthread_task = t;
> >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >  	sp.sched_priority = kthread_prio;
> >  	sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
> >  	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
> > -	return 0;
> >  }
> >  
> >  static void rcu_cpu_kthread_setup(unsigned int cpu)
> > @@ -1264,8 +1263,12 @@ static void __init rcu_spawn_boost_kthreads(void)
> >  		per_cpu(rcu_data.rcu_cpu_has_work, cpu) = 0;
> >  	if (WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec), "%s: Could not start rcub kthread, OOM is now expected behavior\n", __func__))
> >  		return;
> > +
> > +	if (WARN_ON(!rcu_scheduler_fully_active))
> > +		return;
> > +
> >  	rcu_for_each_leaf_node(rnp)
> > -		(void)rcu_spawn_one_boost_kthread(rnp);
> > +		rcu_spawn_one_boost_kthread(rnp);
> >  }
> >  
> >  static void rcu_prepare_kthreads(int cpu)
> > @@ -1273,9 +1276,11 @@ static void rcu_prepare_kthreads(int cpu)
> >  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> >  	struct rcu_node *rnp = rdp->mynode;
> >  
> > +	if (WARN_ON(!rcu_scheduler_fully_active))
> > +		return;
> > +
> >  	/* Fire up the incoming CPU's kthread and leaf rcu_node kthread. */
> > -	if (rcu_scheduler_fully_active)
> > -		(void)rcu_spawn_one_boost_kthread(rnp);
> > +	rcu_spawn_one_boost_kthread(rnp);
> >  }
> >  
> >  #else /* #ifdef CONFIG_RCU_BOOST */
> > @@ -2198,8 +2203,10 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
> >   */
> >  static void rcu_spawn_cpu_nocb_kthread(int cpu)
> >  {
> > -	if (rcu_scheduler_fully_active)
> > -		rcu_spawn_one_nocb_kthread(cpu);
> > +	if (WARN_ON(!rcu_scheduler_fully_active))
> > +		return;
> > +
> > +	rcu_spawn_one_nocb_kthread(cpu);
> >  }
> >  
> >  /*
> > -- 
> > 1.9.1
> > 
