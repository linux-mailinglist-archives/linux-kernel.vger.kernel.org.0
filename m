Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B298265CA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 16:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfEVOcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 10:32:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfEVOcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MgfRcQPjnsY1wifHPqVLHdT+O/gnT5z4QCcUTxImDHs=; b=n8MK6QduEiZi02JL8O8TprxOh
        5+3vvrVf2TGZYaX5e9yx6P9oqSUt9DGxk0uWhvSr2oSTC1LtcpJhb4lx8WYcoRNeMQs3C0Qb+A3Fo
        lYOYOlyRYiCkLGgtULR4zXtEAYJPisJ2+hxP2LIOQdNB+xsm8sPSd4GbMYUBFb6K1KAK7NDIBxnCR
        Nhm2aIXoqXEtnCOzS3V+AphooJrGcVe+qsdaK7qzLZEMXz/PmCEro0Oz9fs1ytgAg0HlSEM9Ztvc8
        phU0gbsmZc0FUqA5Z0tzVR+wT6vFlENEgWvT2IqLO2a53S3l/mtVF1Y5WXZ11fN0imstU4rMJ+DgG
        udOfxI5+A==;
Received: from [31.161.185.207] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTSHb-0000lq-QG; Wed, 22 May 2019 14:31:56 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E13A984E0B; Wed, 22 May 2019 16:31:50 +0200 (CEST)
Date:   Wed, 22 May 2019 16:31:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Viktor Rosendahl <viktor.rosendahl@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v4 1/4] ftrace: Implement fs notification for
 tracing_max_latency
Message-ID: <20190522143150.GF16275@worktop.programming.kicks-ass.net>
References: <20190517203430.6729-1-viktor.rosendahl@gmail.com>
 <20190517203430.6729-2-viktor.rosendahl@gmail.com>
 <20190521120142.186487e9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521120142.186487e9@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 12:01:42PM -0400, Steven Rostedt wrote:
> 
> [ Added Peter and Rafael ]

Thanks Steve,

> On Fri, 17 May 2019 22:34:27 +0200
> Viktor Rosendahl <viktor.rosendahl@gmail.com> wrote:

> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > index c8c7c7efb487..a1a1befea1c1 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -183,6 +183,46 @@ TRACE_EVENT(sched_switch,
> >  		__entry->next_comm, __entry->next_pid, __entry->next_prio)
> >  );
> >  
> > +/*
> > + * Tracepoint for entering __schedule():
> > + */
> > +TRACE_EVENT(sched_schedule_enter,
> > +
> > +	TP_PROTO(int cpu),
> > +
> > +	TP_ARGS(cpu),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(int, cpu)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->cpu = cpu;
> > +	),
> > +
> > +	TP_printk("cpu=%d", __entry->cpu)
> > +);
> > +
> > +/*
> > + * Tracepoint for exiting __schedule():
> > + */
> > +TRACE_EVENT(sched_schedule_exit,
> > +
> > +	TP_PROTO(int cpu),
> > +
> > +	TP_ARGS(cpu),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(int, cpu)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->cpu = cpu;
> > +	),
> > +
> > +	TP_printk("cpu=%d", __entry->cpu)
> > +);
> > +
> >  /*
> >   * Tracepoint for a task being migrated:
> >   */
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 102dfcf0a29a..c9d86fcc48f5 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3374,6 +3374,7 @@ static void __sched notrace __schedule(bool preempt)
> >  	int cpu;
> >  
> >  	cpu = smp_processor_id();
> > +	trace_sched_schedule_enter(cpu);
> >  	rq = cpu_rq(cpu);
> >  	prev = rq->curr;
> >  
> > @@ -3448,6 +3449,7 @@ static void __sched notrace __schedule(bool preempt)
> >  	}
> >  
> >  	balance_callback(rq);
> > +	trace_sched_schedule_exit(cpu);
> >  }
> >  
> >  void __noreturn do_task_dead(void)
> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index f5516bae0c1b..e328e045c6e8 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -224,6 +224,7 @@ static void cpuidle_idle_call(void)
> >  static void do_idle(void)
> >  {
> >  	int cpu = smp_processor_id();
> > +	trace_do_idle_enter(cpu);
> >  	/*
> >  	 * If the arch has a polling bit, we maintain an invariant:
> >  	 *
> > @@ -287,6 +288,7 @@ static void do_idle(void)
> >  
> >  	if (unlikely(klp_patch_pending(current)))
> >  		klp_update_patch_state(current);
> > +	trace_do_idle_exit(cpu);
> >  }
> >  
> >  bool cpu_in_idle(unsigned long pc)

NAK!
