Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4664153499
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 16:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgBEPtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 10:49:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbgBEPtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:49:51 -0500
Received: from oasis.local.home (unknown [212.187.182.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 054F920730;
        Wed,  5 Feb 2020 15:49:49 +0000 (UTC)
Date:   Wed, 5 Feb 2020 10:49:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amol Grover <frextrite@gmail.com>
Subject: Re: [for-next][PATCH 4/4] ftrace: Add comment to why
 rcu_dereference_sched() is open coded
Message-ID: <20200205104945.4a6f85de@oasis.local.home>
In-Reply-To: <20200205154212.GC142103@google.com>
References: <20200205104929.313040579@goodmis.org>
        <20200205105113.283672584@goodmis.org>
        <20200205063349.4c3df2c0@oasis.local.home>
        <20200205141915.GA194021@google.com>
        <20200205092847.0b650972@oasis.local.home>
        <20200205154212.GC142103@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2020 10:42:12 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Wed, Feb 05, 2020 at 09:28:47AM -0500, Steven Rostedt wrote:
> > On Wed, 5 Feb 2020 09:19:15 -0500
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> >   
> > > Could you paste the stack here when RCU is not watching? In trace event code
> > > IIRC we call rcu_enter_irqs_on() to have RCU temporarily watch, since that
> > > code can be called from idle loop. Should we doing the same here as well?  
> > 
> > Unfortunately I lost the stack trace. And the last time we tried to use
> > rcu_enter_irqs_on() for ftrace, we couldn't find a way to do this
> > properly. Ftrace is much more invasive then going into idle. The
> > problem is that ftrace traces RCU itself, and calling
> > "rcu_enter_irqs_on()" in pretty much any place in the RCU code caused
> > lots of bugs ;-)
> > 
> > This is why we have the schedule_on_each_cpu(ftrace_sync) hack.  
> 
> The "schedule a task on each CPU" trick works on !PREEMPT though right?

It works on both, as I care more about the PREEMPT=y case then
the !PREEMPT, and the PREEMPT_RT which is even more preemptive than
PREEMPT!

> 
> Because it is possible in PREEMPT=y to get preempted in the middle of a
> read-side critical section, switch to the worker thread executing the
> ftrace_sync() and then switch back. But RCU still has to watch that CPU since
> the read-side critical section was not completed.
> 
> Or is there a subtlety here with ftrace that I missed?
> 

Hence Amol's patch:

> +       notrace_hash = rcu_dereference_protected(ftrace_graph_notrace_hash,
> +                                                !preemptible());

It checks to make sure preemption is off. There is no chance of being
preempted in the read side critical section.

-- Steve
