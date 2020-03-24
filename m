Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8D7191700
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 17:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgCXQw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 12:52:58 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42283 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgCXQw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:52:58 -0400
Received: by mail-qk1-f193.google.com with SMTP id e11so19949777qkg.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X70HFJUJ8UBP2puE+4Pj/8Ffpu/zNV0pZe3tHi3ELyo=;
        b=Pvm7RYTCtHAH9sMzgFZ1SrpEviFMtXMGRtXzAfU0f7w4htIjfwtomnoookRoWLaQzj
         zdLnqaa9pUW1X+U83Ew7VNozcn8y+vfL+UZHu9VfPzY1w7nQD1ocdFi0SmTg1Ir8Mxxn
         ABnAEoLDabKZuvfN43/KaaDvmdsjLAJIg4d2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X70HFJUJ8UBP2puE+4Pj/8Ffpu/zNV0pZe3tHi3ELyo=;
        b=n1DVXxoddg5NWNyxHuz+xSMbqx7rTISJCjDaeN8NVczze1TstmK5BV6hOtVi2REc+d
         DpI4Ho/zgDWdnFeNz2UZuC6yl9LhFWMjeI8Jt3emNiQXwEVWFoqqYMyXpeUUrlxADYwU
         gK5P9Pvjyo1eJGyJKDltd15EYsP0XTRnAYu4BezgSgkwX/WItKycboh5IbJkom40sMGJ
         ZfUpbaDpx+ciy5Bq2gYyD+wXofx8RR3h+/47QAtLgb4v6MjBGtLO/yYz1aGwAq/RbNzx
         r/IvNYJEkkUfaZOtPjOu/X+ycIe9B5hQSF1bFEjhUcuxKR3BRd3wMhSg8rpWFvT0KODR
         l6lw==
X-Gm-Message-State: ANhLgQ0q1MGaWUAcRRdgZ46Qc1oVxB9PrX1gpweoIj422QlOEcsm/nF6
        t1ZfWZV0HhMIpG5FcPnMPuWwEQ==
X-Google-Smtp-Source: ADFU+vuxk2fU8o/h44zPLHBVcdInqjTDwHMcau9NBCsn9rJc0M8OWFuDgHMv71xrgc9BIbPT2rMHDg==
X-Received: by 2002:a37:7a46:: with SMTP id v67mr26301949qkc.87.1585068776697;
        Tue, 24 Mar 2020 09:52:56 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v75sm13831625qkb.22.2020.03.24.09.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 09:52:56 -0700 (PDT)
Date:   Tue, 24 Mar 2020 12:52:55 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        vpillai@digitalocean.com
Subject: Re: [PATCH RFC v2 tip/core/rcu 01/22] sched/core: Add function to
 sample state of locked-down task
Message-ID: <20200324165255.GA242454@google.com>
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
 <20200319001100.24917-1-paulmck@kernel.org>
 <20200319132238.75a034c3@gandalf.local.home>
 <20200319173525.GI3199@paulmck-ThinkPad-P72>
 <20200320024943.GA29649@paulmck-ThinkPad-P72>
 <20200324000639.GA29340@google.com>
 <20200324154822.GC19865@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324154822.GC19865@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 08:48:22AM -0700, Paul E. McKenney wrote:
[..] 
> > 
> > > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > > index 44edd0a..43991a4 100644
> > > --- a/kernel/rcu/tree.h
> > > +++ b/kernel/rcu/tree.h
> > > @@ -455,6 +455,8 @@ static void rcu_bind_gp_kthread(void);
> > >  static bool rcu_nohz_full_cpu(void);
> > >  static void rcu_dynticks_task_enter(void);
> > >  static void rcu_dynticks_task_exit(void);
> > > +static void rcu_dynticks_task_trace_enter(void);
> > > +static void rcu_dynticks_task_trace_exit(void);
> > >  
> > >  /* Forward declarations for tree_stall.h */
> > >  static void record_gp_stall_check_time(void);
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index 9355536..f4a344e 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -2553,3 +2553,21 @@ static void rcu_dynticks_task_exit(void)
> > >  	WRITE_ONCE(current->rcu_tasks_idle_cpu, -1);
> > >  #endif /* #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL) */
> > >  }
> > > +
> > > +/* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
> > > +static void rcu_dynticks_task_trace_enter(void)
> > > +{
> > > +#ifdef CONFIG_TASKS_RCU_TRACE
> > > +	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
> > > +		current->trc_reader_special.b.need_mb = true;
> > 
> > If this is every called from middle of a reader section (that is we
> > transition from IPI-mode to using heavier reader-sections), then is a memory
> > barrier needed here just to protect the reader section that already started?
> 
> That memory barrier is provided by the memory ordering in the callers
> of rcu_dynticks_task_trace_enter() and rcu_dynticks_task_trace_exit(),
> namely, those callers' atomic_add_return() invocations.  These barriers
> pair with the pair of smp_rmb() calls in rcu_dynticks_zero_in_eqs(),
> which is in turn invoked from the function formerly known as
> trc_inspect_reader_notrunning(), AKA trc_inspect_reader().
> 
> This same pair of smp_rmb() calls also pair with the conditional smp_mb()
> calls in rcu_read_lock_trace() and rcu_read_unlock_trace().
> 
> In your scenario, the calls in rcu_read_lock_trace() and
> rcu_read_unlock_trace() wouldn't happen, but in that case the ordering
> from atomic_add_return() would suffice.
> 
> Does that work?  Or is there an ordering bug in there somewhere?

Thanks for explaining. Could the following scenario cause a problem?

If we consider the litmus test:

{
int x = 1;
int *y = &x;
int z = 1;
}

P0(int *x, int *z, int **y)
{
	int *r0;
	int r1;

	dynticks_eqs_trace_enter();

	rcu_read_lock();
	r0 = rcu_dereference(*y);

	dynticks_eqs_trace_exit(); // cut-off reader's mb wings :)

	r1 = READ_ONCE(*r0); // Reordering of this beyond the unlock() is bad.
	rcu_read_unlock();
}

P1(int *x, int *z, int **y)
{
	rcu_assign_pointer(*y, z);
	synchronize_rcu();
	WRITE_ONCE(*x, 0);
}

exists (0:r0=x /\ 0:r1=0)

Then the following situation can happen?

	READER					UPDATER

						y = &z;

	eqs_enter(); // full-mb

	rcu_read_lock(); // full-mb
	// r0 = x;
						// GP-start
						// ..zero_in_eqs() notices eqs, no IPI
	eqs_exit(); // full-mb

	// actual r1 = *x but will reorder

	rcu_read_unlock(); // no-mb
						// GP-finish as notices nesting = 0
						x = 0;
	// reordered r1 = *x = 0;


Basically r0=x /\ r1=0 happened because r1=0. Or did I miss something that
prevents it?

thanks,

 - Joel




> > thanks,
> > 
> >  - Joel
> > 
> > 
> > > +#endif /* #ifdef CONFIG_TASKS_RCU_TRACE */
> > > +}
> > > +
> > > +/* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
> > > +static void rcu_dynticks_task_trace_exit(void)
> > > +{
> > > +#ifdef CONFIG_TASKS_RCU_TRACE
> > > +	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
> > > +		current->trc_reader_special.b.need_mb = false;
> > > +#endif /* #ifdef CONFIG_TASKS_RCU_TRACE */
> > > +}
