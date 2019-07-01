Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40930596F7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 11:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfF1JL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 05:11:27 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:57385 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726702AbfF1JL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:11:26 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 28 Jun 2019 18:11:23 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.151 with ESMTP; 28 Jun 2019 18:11:23 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Fri, 28 Jun 2019 18:10:42 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Scott Wood <swood@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, kernel-team@lge.com
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190628091042.GA11339@X58A-UD3R>
References: <20190627153031.GA249127@google.com>
 <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
 <20190627203612.GD26519@linux.ibm.com>
 <20190628073138.GB13650@X58A-UD3R>
 <20190628074350.GA11214@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628074350.GA11214@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 04:43:50PM +0900, Byungchul Park wrote:
> On Fri, Jun 28, 2019 at 04:31:38PM +0900, Byungchul Park wrote:
> > On Thu, Jun 27, 2019 at 01:36:12PM -0700, Paul E. McKenney wrote:
> > > On Thu, Jun 27, 2019 at 03:17:27PM -0500, Scott Wood wrote:
> > > > On Thu, 2019-06-27 at 11:41 -0700, Paul E. McKenney wrote:
> > > > > On Thu, Jun 27, 2019 at 02:16:38PM -0400, Joel Fernandes wrote:
> > > > > > 
> > > > > > I think the fix should be to prevent the wake-up not based on whether we
> > > > > > are
> > > > > > in hard/soft-interrupt mode but that we are doing the rcu_read_unlock()
> > > > > > from
> > > > > > a scheduler path (if we can detect that)
> > > > > 
> > > > > Or just don't do the wakeup at all, if it comes to that.  I don't know
> > > > > of any way to determine whether rcu_read_unlock() is being called from
> > > > > the scheduler, but it has been some time since I asked Peter Zijlstra
> > > > > about that.
> > > > > 
> > > > > Of course, unconditionally refusing to do the wakeup might not be happy
> > > > > thing for NO_HZ_FULL kernels that don't implement IRQ work.
> > > > 
> > > > Couldn't smp_send_reschedule() be used instead?
> > > 
> > > Good point.  If current -rcu doesn't fix things for Sebastian's case,
> > > that would be well worth looking at.  But there must be some reason
> > > why Peter Zijlstra didn't suggest it when he instead suggested using
> > > the IRQ work approach.
> > > 
> > > Peter, thoughts?
> > 
> 
> +cc kernel-team@lge.com
> (I'm sorry for more noise on the thread.)
> 
> > Hello,
> > 
> > Isn't the following scenario possible?
> > 
> > The original code
> > -----------------
> > rcu_read_lock();
> > ...
> > /* Experdite */
> > WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
> > ...
> > __rcu_read_unlock();
> > 	if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
> > 		rcu_read_unlock_special(t);
> > 			WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
> > 			rcu_preempt_deferred_qs_irqrestore(t, flags);
> > 		barrier();  /* ->rcu_read_unlock_special load before assign */
> > 		t->rcu_read_lock_nesting = 0;
> > 
> > The reordered code by machine
> > -----------------------------
> > rcu_read_lock();
> > ...
> > /* Experdite */
> > WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
> > ...
> > __rcu_read_unlock();
> > 	if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
> > 		rcu_read_unlock_special(t);
> > 		t->rcu_read_lock_nesting = 0; <--- LOOK AT THIS!!!
> > 			WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
> > 			rcu_preempt_deferred_qs_irqrestore(t, flags);
> > 		barrier();  /* ->rcu_read_unlock_special load before assign */
> > 
> > An interrupt happens
> > --------------------
> > rcu_read_lock();
> > ...
> > /* Experdite */
> > WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
> > ...
> > __rcu_read_unlock();
> > 	if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
> > 		rcu_read_unlock_special(t);
> > 		t->rcu_read_lock_nesting = 0; <--- LOOK AT THIS!!!
> > <--- Handle an (any) irq
> > 	rcu_read_lock();
> > 	/* This call should be skipped */
> > 	rcu_read_unlock_special(t);
> > 			WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
> > 			rcu_preempt_deferred_qs_irqrestore(t, flags);
> > 		barrier();  /* ->rcu_read_unlock_special load before assign */

I was confused it was a LOAD access. The example should be changed a bit.



The original code
-----------------
rcu_read_lock();
...
/* Experdite */
WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
...
__rcu_read_unlock();
	if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
		rcu_read_unlock_special(t);
			WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
			rcu_preempt_deferred_qs_irqrestore(t, flags);
		barrier();  /* ->rcu_read_unlock_special load before assign */
		t->rcu_read_lock_nesting = 0;

The reordered code by machine
-----------------------------
rcu_read_lock();
...
/* Experdite */
WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
...
__rcu_read_unlock();
	if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
		rcu_read_unlock_special(t);
			rcu_preempt_deferred_qs_irqrestore(t, flags);
		barrier();  /* ->rcu_read_unlock_special load before assign */
		t->rcu_read_lock_nesting = 0;
			WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);

An interrupt happens
--------------------
rcu_read_lock();
...
/* Experdite */
WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
...
__rcu_read_unlock();
	if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
		rcu_read_unlock_special(t);
			rcu_preempt_deferred_qs_irqrestore(t, flags);
		barrier();  /* ->rcu_read_unlock_special load before assign */
		t->rcu_read_lock_nesting = 0;
<--- Handle an (any) irq
rcu_read_lock();
/* This call should be skipped */
rcu_read_unlock_special(t);
			WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);



Now that I re-made the example, I'm afraid it'd be no problem because
anyway it'd be within a cpu so it can see inside of the store-buffer of
the cpu.

I'm sorry. Please ignore my suggestion here.
