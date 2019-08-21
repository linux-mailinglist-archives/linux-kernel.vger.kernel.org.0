Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7E7197F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 17:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfHUPsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 11:48:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728459AbfHUPsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:48:37 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LFlxWv061321;
        Wed, 21 Aug 2019 11:48:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uh88da239-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 11:48:06 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7LFm5hM061893;
        Wed, 21 Aug 2019 11:48:06 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uh88da1v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 11:48:05 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7LFjTdf023320;
        Wed, 21 Aug 2019 15:47:55 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma05wdc.us.ibm.com with ESMTP id 2ue9764ust-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 15:47:55 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7LFltZF52887930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 15:47:55 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64E96B205F;
        Wed, 21 Aug 2019 15:47:55 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36928B2064;
        Wed, 21 Aug 2019 15:47:55 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 21 Aug 2019 15:47:55 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DE51416C1775; Wed, 21 Aug 2019 08:47:55 -0700 (PDT)
Date:   Wed, 21 Aug 2019 08:47:55 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v2] rcu/tree: Try to invoke_rcu_core() if in_irq() during
 unlock
Message-ID: <20190821154755.GH28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190819012153.GR28441@linux.ibm.com>
 <20190819014143.GB160903@google.com>
 <20190819014623.GC160903@google.com>
 <20190819022927.GS28441@linux.ibm.com>
 <20190819125757.GA6946@linux.ibm.com>
 <20190819143314.GT28441@linux.ibm.com>
 <20190819154143.GA18470@linux.ibm.com>
 <20190821143841.GC147977@google.com>
 <20190821145617.GD147977@google.com>
 <20190821152638.GF147977@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821152638.GF147977@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 11:26:38AM -0400, Joel Fernandes wrote:
> On Wed, Aug 21, 2019 at 10:56:17AM -0400, Joel Fernandes wrote:
> > On Wed, Aug 21, 2019 at 10:38:41AM -0400, Joel Fernandes wrote:
> > > On Mon, Aug 19, 2019 at 08:41:43AM -0700, Paul E. McKenney wrote:
> > > > On Mon, Aug 19, 2019 at 07:33:14AM -0700, Paul E. McKenney wrote:
> > > > > On Mon, Aug 19, 2019 at 05:57:57AM -0700, Paul E. McKenney wrote:
> > > > > > On Sun, Aug 18, 2019 at 07:29:27PM -0700, Paul E. McKenney wrote:
> > > > > > > On Sun, Aug 18, 2019 at 09:46:23PM -0400, Joel Fernandes wrote:
> > > > > > > > On Sun, Aug 18, 2019 at 09:41:43PM -0400, Joel Fernandes wrote:
> > > > > > > > > On Sun, Aug 18, 2019 at 06:21:53PM -0700, Paul E. McKenney wrote:
> > > > > > > > [snip]
> > > > > > > > > > > > Also, your commit log's point #2 is "in_irq() implies in_interrupt()
> > > > > > > > > > > > which implies raising softirq will not do any wake ups."  This mention
> > > > > > > > > > > > of softirq seems a bit odd, given that we are going to wake up a rcuc
> > > > > > > > > > > > kthread.  Of course, this did nothing to quell my suspicions.  ;-)
> > > > > > > > > > > 
> > > > > > > > > > > Yes, I should delete this #2 from the changelog since it is not very relevant
> > > > > > > > > > > (I feel now). My point with #2 was that even if were to raise a softirq
> > > > > > > > > > > (which we are not), a scheduler wakeup of ksoftirqd is impossible in this
> > > > > > > > > > > path anyway since in_irq() implies in_interrupt().
> > > > > > > > > > 
> > > > > > > > > > Please!  Could you also add a first-principles explanation of why
> > > > > > > > > > the added condition is immune from scheduler deadlocks?
> > > > > > > > > 
> > > > > > > > > Sure I can add an example in the change log, however I was thinking of this
> > > > > > > > > example which you mentioned:
> > > > > > > > > https://lore.kernel.org/lkml/20190627173831.GW26519@linux.ibm.com/
> > > > > > > > > 
> > > > > > > > > 	previous_reader()
> > > > > > > > > 	{
> > > > > > > > > 		rcu_read_lock();
> > > > > > > > > 		do_something(); /* Preemption happened here. */
> > > > > > > > > 		local_irq_disable(); /* Cannot be the scheduler! */
> > > > > > > > > 		do_something_else();
> > > > > > > > > 		rcu_read_unlock();  /* Must defer QS, task still queued. */
> > > > > > > > > 		do_some_other_thing();
> > > > > > > > > 		local_irq_enable();
> > > > > > > > > 	}
> > > > > > > > > 
> > > > > > > > > 	current_reader() /* QS from previous_reader() is still deferred. */
> > > > > > > > > 	{
> > > > > > > > > 		local_irq_disable();  /* Might be the scheduler. */
> > > > > > > > > 		do_whatever();
> > > > > > > > > 		rcu_read_lock();
> > > > > > > > > 		do_whatever_else();
> > > > > > > > > 		rcu_read_unlock();  /* Must still defer reporting QS. */
> > > > > > > > > 		do_whatever_comes_to_mind();
> > > > > > > > > 		local_irq_enable();
> > > > > > > > > 	}
> > > > > > > > > 
> > > > > > > > > One modification of the example could be, previous_reader() could also do:
> > > > > > > > > 	previous_reader()
> > > > > > > > > 	{
> > > > > > > > > 		rcu_read_lock();
> > > > > > > > > 		do_something_that_takes_really_long(); /* causes need_qs in
> > > > > > > > > 							  the unlock_special_union to be set */
> > > > > > > > > 		local_irq_disable(); /* Cannot be the scheduler! */
> > > > > > > > > 		do_something_else();
> > > > > > > > > 		rcu_read_unlock();  /* Must defer QS, task still queued. */
> > > > > > > > > 		do_some_other_thing();
> > > > > > > > > 		local_irq_enable();
> > > > > > > > > 	}
> > > > > > > > 
> > > > > > > > The point you were making in that thread being, current_reader() ->
> > > > > > > > rcu_read_unlock() -> rcu_read_unlock_special() would not do any wakeups
> > > > > > > > because previous_reader() sets the deferred_qs bit.
> > > > > > > > 
> > > > > > > > Anyway, I will add all of this into the changelog.
> > > > > > > 
> > > > > > > Examples are good, but what makes it so that there are no examples of
> > > > > > > its being unsafe?
> > > > > > > 
> > > > > > > And a few questions along the way, some quick quiz, some more serious.
> > > > > > > Would it be safe if it checked in_interrupt() instead of in_irq()?
> > > > > > > If not, should the in_interrupt() in the "if" condition preceding the
> > > > > > > added "else if" be changed to in_irq()?  Would it make sense to add an
> > > > > > > "|| !irqs_were_disabled" do your new "else if" condition?  Would the
> > > > > > > body of the "else if" actually be executed in current mainline?
> > > > > > > 
> > > > > > > In an attempt to be at least a little constructive, I am doing some
> > > > > > > testing of this patch overnight, along with a WARN_ON_ONCE() to see if
> > > > > > > that invoke_rcu_core() is ever reached.
> > > > > > 
> > > > > > And that WARN_ON_ONCE() never triggered in two-hour rcutorture runs of
> > > > > > TREE01, TREE02, TREE03, and TREE09.  (These are the TREE variants in
> > > > > > CFLIST that have CONFIG_PREEMPT=y.)
> > > > > > 
> > > > > > This of course raises other questions.  But first, do you see that code
> > > > > > executing in your testing?
> > > > > 
> > > > > Never mind!  Idiot here forgot the "--bootargs rcutree.use_softirq"...
> > > > 
> > > > So this time I ran the test this way:
> > > > 
> > > > tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 10 --configs "TREE01 TREE02 TREE03 TREE09" --bootargs "rcutree.use_softirq=0"
> > > > 
> > > > Still no splats.  Though only 10-minute runs instead of the two-hour runs
> > > > I did last night.  (Got other stuff I need to do, sorry!)
> > > > 
> > > > My test version of your patch is shown below.  Please let me know if I messed
> > > > something up.
> > > 
> > > I think you also need to pass rcutorture.irqreader=1 ?
> > > 
> > > Otherwise seems all readers happen in process context AFAICS.
> > 
> > Which is the default setting for that, so that's not the issue.
> > 
> > I think one reason could be, in_irq() is false when the timer callback
> > executes, since the timer callback is executing after a grace-period. The
> > stack is as follows:
> > 
> > Any reason why we cannot both test for call_rcu() and execute the RCU
> > callback from the timer hardirq handler?
> > 
> > In fact, I guess on use_nosoftirq systems, the callback will not even run
> > in softirq context.
> > 
> > [   20.553361]  => rcu_torture_timer_cb
> > [   20.553361]  => rcu_do_batch
> > [   20.553361]  => rcu_core
> > [   20.553361]  => __do_softirq
> > [   20.553361]  => do_softirq_own_stack
> > [   20.553361]  => do_softirq.part.16
> > [   20.553361]  => __local_bh_enable_ip
> > [   20.553361]  => rcutorture_one_extend
> > [   20.553361]  => rcu_torture_one_read
> > [   20.553361]  => rcu_torture_reader
> > [   20.553361]  => kthread
> > [   20.553361]  => ret_from_fork
> 
> Oops! wrong stack trace, this is the one where it shows that the timer handler
> is running from softirq, not hardirq. Both the rcu_torture_timer() and
> rcu_torture_timer_cb() run from softirq context. ftrace confirms:
> 
> [   27.949671] rcu_tort-182     8..s1 7268705us : <stack trace>
> [   27.949671]  => __ftrace_trace_stack
> [   27.949671]  => rcu_torture_timer
> [   27.949671]  => call_timer_fn
> [   27.949671]  => run_timer_softirq
> [   27.949671]  => __do_softirq
> [   27.949671]  => irq_exit
> [   27.949671]  => smp_apic_timer_interrupt
> [   27.949671]  => apic_timer_interrupt
> [   27.949671]  => rcutorture_one_extend
> [   27.949671]  => rcu_torture_one_read
> [   27.949671]  => rcu_torture_reader
> [   27.949671]  => kthread
> [   27.949671]  => ret_from_fork
> 
> So looks like torture testing modifications are called for, to run them in
> hard interrupt context as well to provide this additional coverage.. Or am I
> way off in the woods?

That actually might be worth doing.

The reason I didn't bother is that in the common case, timer softirq
generates exactly the same race conditions as would a hard interrupt
handler.  You can see this in your stack trace, where the call is
coming from irq_exit(), that is, from the trailing edge of a hardware
interrupt.

							Thanx, Paul
