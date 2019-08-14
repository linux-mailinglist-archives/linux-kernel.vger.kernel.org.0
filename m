Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68DD98E051
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 00:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfHNWGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 18:06:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727975AbfHNWGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 18:06:05 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7EM48sZ084687;
        Wed, 14 Aug 2019 18:05:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ucsmfa8r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Aug 2019 18:05:16 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7EM4Fki085258;
        Wed, 14 Aug 2019 18:05:16 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ucsmfa8qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Aug 2019 18:05:15 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7EM0fHO005221;
        Wed, 14 Aug 2019 22:05:15 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 2u9nj65ufp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Aug 2019 22:05:14 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7EM5EF050790680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 22:05:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39E4BB2091;
        Wed, 14 Aug 2019 22:05:14 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07779B2094;
        Wed, 14 Aug 2019 22:05:14 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 14 Aug 2019 22:05:13 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 154F216C1049; Wed, 14 Aug 2019 15:05:16 -0700 (PDT)
Date:   Wed, 14 Aug 2019 15:05:16 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH RFC tip/core/rcu 14/14] rcu/nohz: Make multi_cpu_stop()
 enable tick on all online CPUs
Message-ID: <20190814220516.GY28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-14-paulmck@linux.ibm.com>
 <20190812210232.GA3648@lenoir>
 <20190812232316.GT28441@linux.ibm.com>
 <20190813123016.GA11455@lenoir>
 <20190813144809.GB28441@linux.ibm.com>
 <20190814175546.GB68498@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814175546.GB68498@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 01:55:46PM -0400, Joel Fernandes wrote:
> On Tue, Aug 13, 2019 at 07:48:09AM -0700, Paul E. McKenney wrote:
> > On Tue, Aug 13, 2019 at 02:30:19PM +0200, Frederic Weisbecker wrote:
> > > On Mon, Aug 12, 2019 at 04:23:16PM -0700, Paul E. McKenney wrote:
> > > > On Mon, Aug 12, 2019 at 11:02:33PM +0200, Frederic Weisbecker wrote:
> > > > > On Fri, Aug 02, 2019 at 08:15:01AM -0700, Paul E. McKenney wrote:
> > > > > Looks like it's not the right fix but, should you ever need to set an
> > > > > all-CPUs (system wide) tick dependency in the future, you can use tick_set_dep().
> > > > 
> > > > Indeed, I have dropped this patch, but I now do something similar in
> > > > RCU's CPU-hotplug notifiers.  Which does have an effect, especially on
> > > > the system that isn't subject to the insane-latency cpu_relax().
> > > > 
> > > > Plus I am having to put a similar workaround into RCU's quiescent-state
> > > > forcing logic.
> > > > 
> > > > But how should this really be done?
> > > > 
> > > > Isn't there some sort of monitoring of nohz_full CPUs for accounting
> > > > purposes?  If so, would it make sense for this monitoring to check for
> > > > long-duration kernel execution and enable the tick in this case?  The
> > > > RCU dyntick machinery can be used to remotely detect the long-duration
> > > > kernel execution using something like the following:
> > > > 
> > > > 	int nohz_in_kernel_snap = rcu_dynticks_snap_cpu(cpu);
> > > > 
> > > > 	...
> > > > 
> > > > 	if (rcu_dynticks_in_eqs_cpu(cpu, nohz_in_kernel_snap)
> > > > 		nohz_in_kernel_snap = rcu_dynticks_snap_cpu(cpu);
> > > > 	else
> > > > 		/* Turn on the tick! */
> > > > 
> > > > I would supply rcu_dynticks_snap_cpu() and rcu_dynticks_in_eqs_cpu(),
> > > > which would be simple wrappers around RCU's private rcu_dynticks_snap()
> > > > and rcu_dynticks_in_eqs() functions.
> > > > 
> > > > Would this make sense as a general solution, or am I missing a corner
> > > > case or three?
> > > 
> > > Oh I see. Until now we considered than running into the kernel (between user/guest/idle)
> > > is supposed to be short but there can be specific places where it doesn't apply.
> > > 
> > > I'm wondering if, more than just providing wrappers, this shouldn't be entirely
> > > driven by RCU using the tick_set_dep_cpu()/tick_clear_dep_cpu() at appropriate timings.
> > > 
> > > I don't want to sound like I'm trying to put all the work on you :p  It's just that
> > > the tick shouldn't know much about RCU, it's rather RCU that is a client for the tick and
> > > is probably better suited to determine when a CPU becomes annoying with its extended grace
> > > period.
> > > 
> > > Arming a CPU timer could also be an alternative to tick_set_dep_cpu() for that.
> > > 
> > > What do you think?
> > 
> > Left to itself, RCU would take action only when a given nohz_full
> > in-kernel CPU was delaying a grace period, which is what the (lightly
> > tested) patch below is supposed to help with.  If that is all that is
> > needed, well and good!
> > 
> > But should we need long-running in-kernel nohz_full CPUs to turn on
> > their ticks when they are not blocking an RCU grace period, for example,
> > when RCU is idle, more will be needed.  To that point, isn't there some
> > sort of monitoring that checks up on nohz_full CPUs ever second or so?
> 
> Wouldn't such monitoring need to be more often than a second, given that
> rcu_urgent_qs and rcu_need_heavy_qs are configured typically to be sooner
> (200-300 jiffies on my system).

Either it would have to be more often than once per second, or RCU would
need to retain its more frequent checks.  But note that RCU isn't going
to check unless there is a grace period in progress.

> > If so, perhaps that monitoring could periodically invoke an RCU function
> > that I provide for deciding when to turn the tick on.  We would also need
> > to work out how to turn the tick off in a timely fashion once the CPU got
> > out of kernel mode, perhaps in rcu_user_enter() or rcu_nmi_exit_common().
> > 
> > If this would be called only every second or so, the separate grace-period
> > checking is still needed for its shorter timespan, though.
> > 
> > Thoughts?
> 
> Do you want me to test the below patch to see if it fixes the issue with my
> other test case (where I had a nohz full CPU holding up a grace period).

Please!

> 2 comments below:
> 
> > ------------------------------------------------------------------------
> > 
> > commit 1cb89508804f6f2fdb79a1be032b1932d52318c4
> > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > Date:   Mon Aug 12 16:14:00 2019 -0700
> > 
> >     rcu: Force tick on for nohz_full CPUs not reaching quiescent states
> >     
> >     CPUs running for long time periods in the kernel in nohz_full mode
> >     might leave the scheduling-clock interrupt disabled for then full
> >     duration of their in-kernel execution.  This can (among other things)
> >     delay grace periods.  This commit therefore forces the tick back on
> >     for any nohz_full CPU that is failing to pass through a quiescent state
> >     upon return from interrupt, which the resched_cpu() will induce.
> >     
> >     Reported-by: Joel Fernandes <joel@joelfernandes.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 8c494a692728..8b8f5bffdc5a 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -651,6 +651,12 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
> >  	 */
> >  	if (rdp->dynticks_nmi_nesting != 1) {
> >  		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
> > +		if (tick_nohz_full_cpu(rdp->cpu) &&
> > +		    rdp->dynticks_nmi_nesting == 2 &&
> > +		    rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> > +			rdp->rcu_forced_tick = true;
> > +			tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> > +		}
> >  		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
> >  			   rdp->dynticks_nmi_nesting - 2);
> >  		return;
> > @@ -886,6 +892,16 @@ void rcu_irq_enter_irqson(void)
> >  	local_irq_restore(flags);
> >  }
> >  
> > +/*
> > + * If the scheduler-clock interrupt was enabled on a nohz_full CPU
> > + * in order to get to a quiescent state, disable it.
> > + */
> > +void rcu_disable_tick_upon_qs(struct rcu_data *rdp)
> > +{
> > +	if (tick_nohz_full_cpu(rdp->cpu) && rdp->rcu_forced_tick)
> > +		tick_dep_clear_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> > +}
> > +
> >  /**
> >   * rcu_is_watching - see if RCU thinks that the current CPU is not idle
> >   *
> > @@ -1980,6 +1996,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
> >  		if (!offloaded)
> >  			needwake = rcu_accelerate_cbs(rnp, rdp);
> >  
> > +		rcu_disable_tick_upon_qs(rdp);
> >  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
> >  		/* ^^^ Released rnp->lock */
> >  		if (needwake)
> > @@ -2269,6 +2286,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
> >  	int cpu;
> >  	unsigned long flags;
> >  	unsigned long mask;
> > +	struct rcu_data *rdp;
> >  	struct rcu_node *rnp;
> >  
> >  	rcu_for_each_leaf_node(rnp) {
> > @@ -2293,8 +2311,11 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
> >  		for_each_leaf_node_possible_cpu(rnp, cpu) {
> >  			unsigned long bit = leaf_node_cpu_bit(rnp, cpu);
> >  			if ((rnp->qsmask & bit) != 0) {
> > -				if (f(per_cpu_ptr(&rcu_data, cpu)))
> > +				rdp = per_cpu_ptr(&rcu_data, cpu);
> > +				if (f(rdp)) {
> >  					mask |= bit;
> > +					rcu_disable_tick_upon_qs(rdp);
> > +				}
> 
> I am guessing this was the earlier thing you corrected, cool!!

Like I said, stupid error on my part.  The usual kind.  ;-)

> >  			}
> >  		}
> >  		if (mask != 0) {
> > @@ -2322,7 +2343,7 @@ void rcu_force_quiescent_state(void)
> >  	rnp = __this_cpu_read(rcu_data.mynode);
> >  	for (; rnp != NULL; rnp = rnp->parent) {
> >  		ret = (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) ||
> > -		      !raw_spin_trylock(&rnp->fqslock);
> > +		       !raw_spin_trylock(&rnp->fqslock);
> >  		if (rnp_old != NULL)
> >  			raw_spin_unlock(&rnp_old->fqslock);
> >  		if (ret)
> > @@ -2855,7 +2876,7 @@ static void rcu_barrier_callback(struct rcu_head *rhp)
> >  {
> >  	if (atomic_dec_and_test(&rcu_state.barrier_cpu_count)) {
> >  		rcu_barrier_trace(TPS("LastCB"), -1,
> > -				   rcu_state.barrier_sequence);
> > +				  rcu_state.barrier_sequence);
> >  		complete(&rcu_state.barrier_completion);
> >  	} else {
> >  		rcu_barrier_trace(TPS("CB"), -1, rcu_state.barrier_sequence);
> > @@ -2879,7 +2900,7 @@ static void rcu_barrier_func(void *unused)
> >  	} else {
> >  		debug_rcu_head_unqueue(&rdp->barrier_head);
> >  		rcu_barrier_trace(TPS("IRQNQ"), -1,
> > -				   rcu_state.barrier_sequence);
> > +				  rcu_state.barrier_sequence);
> >  	}
> >  	rcu_nocb_unlock(rdp);
> >  }
> > @@ -2906,7 +2927,7 @@ void rcu_barrier(void)
> >  	/* Did someone else do our work for us? */
> >  	if (rcu_seq_done(&rcu_state.barrier_sequence, s)) {
> >  		rcu_barrier_trace(TPS("EarlyExit"), -1,
> > -				   rcu_state.barrier_sequence);
> > +				  rcu_state.barrier_sequence);
> >  		smp_mb(); /* caller's subsequent code after above check. */
> >  		mutex_unlock(&rcu_state.barrier_mutex);
> >  		return;
> > @@ -2938,11 +2959,11 @@ void rcu_barrier(void)
> >  			continue;
> >  		if (rcu_segcblist_n_cbs(&rdp->cblist)) {
> >  			rcu_barrier_trace(TPS("OnlineQ"), cpu,
> > -					   rcu_state.barrier_sequence);
> > +					  rcu_state.barrier_sequence);
> >  			smp_call_function_single(cpu, rcu_barrier_func, NULL, 1);
> >  		} else {
> >  			rcu_barrier_trace(TPS("OnlineNQ"), cpu,
> > -					   rcu_state.barrier_sequence);
> > +					  rcu_state.barrier_sequence);
> >  		}
> >  	}
> >  	put_online_cpus();
> > @@ -3168,6 +3189,7 @@ void rcu_cpu_starting(unsigned int cpu)
> >  	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
> >  	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
> >  	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
> > +		rcu_disable_tick_upon_qs(rdp);
> >  		/* Report QS -after- changing ->qsmaskinitnext! */
> >  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
> 
> Just curious about the existing code. If a CPU is just starting up (after
> bringing it online), how can RCU be waiting on it? I thought RCU would not be
> watching offline CPUs.

Well, neither grace periods nor CPU-hotplug operations are atomic,
and each can take significant time to complete.

So suppose we have a large system with multiple leaf rcu_node structures
(not that 17 CPUs is all that many these days, but please bear with me).
Suppose just after a new grace period initializes a given leaf rcu_node
structure, one of its CPUs goes offline (yes, that CPU would have to
have waited on a grace period, but that might have been the previous
grace period).  But before the FQS scan notices that RCU is waiting on
an offline CPU, the CPU comes back online.

That situation is exactly what the above code is intended to handle.

Without that code, RCU can give false-positive splats at various points
in its processing.  ("Wait!  How can a task be blocked waiting on a
grace period that hasn't even started yet???")

							Thanx, Paul
