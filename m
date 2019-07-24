Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6099C7295E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 10:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfGXIAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 04:00:42 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:42090 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725826AbfGXIAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:00:42 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 24 Jul 2019 17:00:29 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.151 with ESMTP; 24 Jul 2019 17:00:29 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Wed, 24 Jul 2019 16:59:20 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190724075919.GB14712@X58A-UD3R>
References: <20190713174111.GG26519@linux.ibm.com>
 <CAEXW_YTcL-nOfJXkChGhvQtqqfSLpAYr327PLu1SmGEEADCevw@mail.gmail.com>
 <20190719003942.GA28226@X58A-UD3R>
 <CAEXW_YQij-N2-NFjUQtsmYxVLtWxcQk_Kb16fGBzzPAZtWg+sg@mail.gmail.com>
 <20190719074329.GY14271@linux.ibm.com>
 <CANrsvRM7ehvqcPtKMV7RyRCiXwe_R_TsLZiNtxBPY_qnSg2LNQ@mail.gmail.com>
 <20190719195728.GF14271@linux.ibm.com>
 <CAEXW_YQADrPRtJW7yJZyROH1_d2yOA7_1HVgm50wxpOC80+=Wg@mail.gmail.com>
 <20190723110521.GA28883@X58A-UD3R>
 <20190723134717.GT14271@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723134717.GT14271@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 06:47:17AM -0700, Paul E. McKenney wrote:
> On Tue, Jul 23, 2019 at 08:05:21PM +0900, Byungchul Park wrote:
> > On Fri, Jul 19, 2019 at 04:33:56PM -0400, Joel Fernandes wrote:
> > > On Fri, Jul 19, 2019 at 3:57 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > > >
> > > > On Fri, Jul 19, 2019 at 06:57:58PM +0900, Byungchul Park wrote:
> > > > > On Fri, Jul 19, 2019 at 4:43 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > > > > >
> > > > > > On Thu, Jul 18, 2019 at 08:52:52PM -0400, Joel Fernandes wrote:
> > > > > > > On Thu, Jul 18, 2019 at 8:40 PM Byungchul Park <byungchul.park@lge.com> wrote:
> > > > > > > [snip]
> > > > > > > > > - There is a bug in the CPU stopper machinery itself preventing it
> > > > > > > > > from scheduling the stopper on Y. Even though Y is not holding up the
> > > > > > > > > grace period.
> > > > > > > >
> > > > > > > > Or any thread on Y is busy with preemption/irq disabled preventing the
> > > > > > > > stopper from being scheduled on Y.
> > > > > > > >
> > > > > > > > Or something is stuck in ttwu() to wake up the stopper on Y due to any
> > > > > > > > scheduler locks such as pi_lock or rq->lock or something.
> > > > > > > >
> > > > > > > > I think what you mentioned can happen easily.
> > > > > > > >
> > > > > > > > Basically we would need information about preemption/irq disabled
> > > > > > > > sections on Y and scheduler's current activity on every cpu at that time.
> > > > > > >
> > > > > > > I think all that's needed is an NMI backtrace on all CPUs. An ARM we
> > > > > > > don't have NMI solutions and only IPI or interrupt based backtrace
> > > > > > > works which should at least catch and the preempt disable and softirq
> > > > > > > disable cases.
> > > > > >
> > > > > > True, though people with systems having hundreds of CPUs might not
> > > > > > thank you for forcing an NMI backtrace on each of them.  Is it possible
> > > > > > to NMI only the ones that are holding up the CPU stopper?
> > > > >
> > > > > What a good idea! I think it's possible!
> > > > >
> > > > > But we need to think about the case NMI doesn't work when the
> > > > > holding-up was caused by IRQ disabled.
> > > > >
> > > > > Though it's just around the corner of weekend, I will keep thinking
> > > > > on it during weekend!
> > > >
> > > > Very good!
> > > 
> > > Me too will think more about it ;-) Agreed with point about 100s of
> > > CPUs usecase,
> > > 
> > > Thanks, have a great weekend,
> > 
> > BTW, if there's any long code section with irq/preemption disabled, then
> > the problem would be not only about RCU stall. And we can also use
> > latency tracer or something to detect the bad situation.
> > 
> > So in this case, sending ipi/nmi to the CPUs where the stoppers cannot
> > to be scheduled does not give us additional meaningful information.
> > 
> > I think Paul started to think about this to solve some real problem. I
> > seriously love to help RCU and it's my pleasure to dig deep into kind of
> > RCU stuff, but I've yet to define exactly what problem is. Sorry.
> > 
> > Could you share the real issue? I think you don't have to reproduce it.
> > Just sharing the issue that you got inspired from is enough. Then I
> > might be able to develop 'how' with Joel! :-) It's our pleasure!
> 
> It is unfortunately quite intermittent.  I was hoping to find a way
> to make it happen more often.  Part of the underlying problem appears
> to be lock contention, in that reducing contention made it even more
> intermittent.  Which is good in general, but not for exercising the
> CPU-stopper issue.
> 
> But perhaps your hardware will make this happen more readily than does
> mine.  The repeat-by is simple, namely run TREE04 on branch "dev" on an
> eight-CPU system.  It appear that the number of CPUs used by the test
> should match the number available on the system that you are running on,
> though perhaps affinity could allow mismatches.
> 
> So why not try it and see what happens?

Thank you. I'll try it too.

