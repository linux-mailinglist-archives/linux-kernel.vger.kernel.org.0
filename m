Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 335F21902A3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 01:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgCXAPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 20:15:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38372 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgCXAPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 20:15:52 -0400
Received: by mail-qt1-f196.google.com with SMTP id z12so13617214qtq.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 17:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xp57GNNl2/m70SgPCC/O9ysmzgGyeQ7o6EsTbTVdno4=;
        b=Y4SW7kXh0GRmnQoFn1ToSIKQwUtvqNyyzfdLz+vuW2i3UYkjQY2lpZY91kdKrKHwNI
         zGip72/lICXwIw1PLF+vZmuo/X4RNsVPGX3Nigsjmll9LicS0nLdmYfIpi/g+1xxutFh
         JuC8RUgWOy8T03FDbTUKGFZTfgMPZDADgo6ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xp57GNNl2/m70SgPCC/O9ysmzgGyeQ7o6EsTbTVdno4=;
        b=RjShXjkGRyKV6PpF7BoplONuQRa9ZpKcdCygpXkmPnE9LbqZo4ITx/lEYji1pYBRIj
         +UkP08R1FlTVokekSNDRJ7YrC5Kdk2ZFfitpE5QQelVwHhvS3etHyqw6PPf2R39h98aW
         q8DwomG8735dgogNQq1CKgO4DGbEdR+lg7hlylT9wrjOLBCtQsx613hJuLZ3r5+bIi3h
         KOGYs8ax/5D5bOjxJV12QXYwP+bIlIgjpS9/h2OAe8Wj8MGxL48RhZiXIa0TlKI1l7U8
         pUMjZxITxsjq62RglAwgg4Pqptp72k60eZ5PmZlhCyMkj/u5iW4og8RIc5fJDq85XLjP
         0X0A==
X-Gm-Message-State: ANhLgQ3l4DVLYeMkFnFOWBXRu/pZnmtzZHrJGOPfOMxJxjneHKW4ut/B
        FMyV8lJ39xh3vCEhnXzJwoQvYg==
X-Google-Smtp-Source: ADFU+vuJrBR29jFtyUgrr8Tw9HPoe0t8aNBO0ZgOMW08wWWxOkwfHxZ/4c2GPbPkNhUlLzrjpdHI0Q==
X-Received: by 2002:ac8:b8d:: with SMTP id h13mr24027292qti.298.1585008950876;
        Mon, 23 Mar 2020 17:15:50 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m1sm13081188qtk.16.2020.03.23.17.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 17:15:50 -0700 (PDT)
Date:   Mon, 23 Mar 2020 20:15:49 -0400
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
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH RFC v2 tip/core/rcu 01/22] sched/core: Add function to
 sample state of locked-down task
Message-ID: <20200324001549.GB42910@google.com>
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
 <20200319001100.24917-1-paulmck@kernel.org>
 <20200319132238.75a034c3@gandalf.local.home>
 <20200319173525.GI3199@paulmck-ThinkPad-P72>
 <20200320024943.GA29649@paulmck-ThinkPad-P72>
 <20200324000639.GA29340@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324000639.GA29340@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 08:06:39PM -0400, Joel Fernandes wrote:
> On Thu, Mar 19, 2020 at 07:49:43PM -0700, Paul E. McKenney wrote:
> [...] 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit e26a234c1205bf02b62b62cd7f15f8086fc0b13b
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Thu Mar 19 15:33:12 2020 -0700
> > 
> >     rcu-tasks: Avoid IPIing userspace/idle tasks if kernel is so built
> >     
> >     Systems running CPU-bound real-time task do not want IPIs sent to CPUs
> >     executing nohz_full userspace tasks.  Battery-powered systems don't
> >     want IPIs sent to idle CPUs in low-power mode.  Unfortunately, RCU tasks
> >     trace can and will send such IPIs in some cases.
> >     
> >     Both of these situations occur only when the target CPU is in RCU
> >     dyntick-idle mode, in other words, when RCU is not watching the
> >     target CPU.  This suggests that CPUs in dyntick-idle mode should use
> >     memory barriers in outermost invocations of rcu_read_lock_trace()
> >     and rcu_read_unlock_trace(), which would allow the RCU tasks trace
> >     grace period to directly read out the target CPU's read-side state.
> >     One challenge is that RCU tasks trace is not targeting a specific
> >     CPU, but rather a task.  And that task could switch from one CPU to
> >     another at any time.
> >     
> >     This commit therefore uses try_invoke_on_locked_down_task()
> >     and checks for task_curr() in trc_inspect_reader_notrunning().
> >     When this condition holds, the target task is running and cannot move.
> >     If CONFIG_TASKS_TRACE_RCU_READ_MB=y, the new rcu_dynticks_zero_in_eqs()
> >     function can be used to check if the specified integer (in this case,
> >     t->trc_reader_nesting) is zero while the target CPU remains in that same
> >     dyntick-idle sojourn.  If so, the target task is in a quiescent state.
> >     If not, trc_read_check_handler() must indicate failure so that the
> >     grace-period kthread can take appropriate action or retry after an
> >     appropriate delay, as the case may be.
> >     
> >     With this change, given CONFIG_TASKS_TRACE_RCU_READ_MB=y, if a given
> >     CPU remains idle or a given task continues executing in nohz_full mode,
> >     the RCU tasks trace grace-period kthread will detect this without the
> >     need to send an IPI.
> >     
> >     Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index e1089fd..296f926 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -501,6 +501,7 @@ void srcutorture_get_gp_data(enum rcutorture_type test_type,
> >  #endif
> >  
> >  #ifdef CONFIG_TINY_RCU
> > +static inline bool rcu_dynticks_zero_in_eqs(int cpu, int *vp) { return false; }
> >  static inline unsigned long rcu_get_gp_seq(void) { return 0; }
> >  static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
> >  static inline unsigned long
> > @@ -510,6 +511,7 @@ static inline void show_rcu_gp_kthreads(void) { }
> >  static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
> >  static inline void rcu_fwd_progress_check(unsigned long j) { }
> >  #else /* #ifdef CONFIG_TINY_RCU */
> > +bool rcu_dynticks_zero_in_eqs(int cpu, int *vp);
> >  unsigned long rcu_get_gp_seq(void);
> >  unsigned long rcu_exp_batches_completed(void);
> >  unsigned long srcu_batches_completed(struct srcu_struct *sp);
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index d31ed74..36f03d3 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -802,22 +802,38 @@ static void trc_read_check_handler(void *t_in)
> >  /* Callback function for scheduler to check non-running) task.  */
> >  static bool trc_inspect_reader_notrunning(struct task_struct *t, void *arg)
> 
> This function name is a bit confusing. The task could be running when this
> function is called. Below you are detecting that the task is running, by
> calling task_curr().
> 
> Maybe just trc_inspect_reader() is better?
> 
> [..]
> 
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index 44edd0a..43991a4 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -455,6 +455,8 @@ static void rcu_bind_gp_kthread(void);
> >  static bool rcu_nohz_full_cpu(void);
> >  static void rcu_dynticks_task_enter(void);
> >  static void rcu_dynticks_task_exit(void);
> > +static void rcu_dynticks_task_trace_enter(void);
> > +static void rcu_dynticks_task_trace_exit(void);
> >  
> >  /* Forward declarations for tree_stall.h */
> >  static void record_gp_stall_check_time(void);
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 9355536..f4a344e 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -2553,3 +2553,21 @@ static void rcu_dynticks_task_exit(void)
> >  	WRITE_ONCE(current->rcu_tasks_idle_cpu, -1);
> >  #endif /* #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL) */
> >  }
> > +
> > +/* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
> > +static void rcu_dynticks_task_trace_enter(void)
> > +{
> > +#ifdef CONFIG_TASKS_RCU_TRACE
> > +	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
> > +		current->trc_reader_special.b.need_mb = true;
> 
> If this is every called from middle of a reader section (that is we
> transition from IPI-mode to using heavier reader-sections), then is a memory
> barrier needed here just to protect the reader section that already started?

Forgot to add:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


