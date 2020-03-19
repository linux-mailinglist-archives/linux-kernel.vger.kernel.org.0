Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6B6C18AA5D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 02:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgCSBhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 21:37:20 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38216 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSBhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 21:37:20 -0400
Received: by mail-qk1-f195.google.com with SMTP id h14so749094qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 18:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gHZYTOD+PQNMsCm216MAHEqvZKYzACoaRY/8c4QoDks=;
        b=WLHyhwrQRzyCJjXf0lDxZ0n65C3Q0H9F5QmWq3yeDyG61fXriXrP6avIoRjUvP+8dU
         /PhwFrFt9tfaGRG17cX7HyKcfNviaylx/v0tZYOrsuFqI0uYP11QMIVI3kRyl5c9d478
         4pMqrnhrbfcEkkDeXQ0tsXYbAQchJXwDO1PRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gHZYTOD+PQNMsCm216MAHEqvZKYzACoaRY/8c4QoDks=;
        b=BWO6Xz23bJmhnsAn7wkv24T3rfRNiOM6GSDMXlnHdq6fpm/db8hkSC5ansl8yAFuMZ
         z0SxNpvDVTuzsdHuw6pgKTwBtsmThIk/VGva6qzxvCjG8TCBMXeR5WPXXEJuS/1JDnQI
         tZqcxDk1l6SRCLjZbtBhtjqVX+8Y6gYVLCHJefUUa7eo4i6eDJDU6kJTqexrC/Jl9C+C
         5nAY4gdVhmEIaaonCGWpmyLZ5vKQuSdUOrZ6Nt9qB9bqYyxqH2N5s0Qfv2fXvGoIFasZ
         uB/miJMBjwbBg66s4y9+j8dVDHXxDirUI9XsMERXxL0FOlzyVM9VfnTokJswzgw8n1Z4
         4yAQ==
X-Gm-Message-State: ANhLgQ2s8uB7lZM8PDYnitLS4AepGdx3OpiOe7bq6f9ZwYhKXpOII4mt
        Iva+Xqi3W9meybGqWkRSD4LYEA==
X-Google-Smtp-Source: ADFU+vspGrm3gwdpRMgH5Cc2SMI+xrC5B6wB8M4gkQJoevLyCw6JdSvoOrKZCCLBD/ccUTSIkhx7Bw==
X-Received: by 2002:a37:aec3:: with SMTP id x186mr732289qke.419.1584581838153;
        Wed, 18 Mar 2020 18:37:18 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z18sm450031qtz.77.2020.03.18.18.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 18:37:17 -0700 (PDT)
Date:   Wed, 18 Mar 2020 21:37:17 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH RFC v2 tip/core/rcu 14/22] rcu-tasks: Add an RCU Tasks
 Trace to simplify protection of tracing hooks
Message-ID: <20200319013717.GA221152@google.com>
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
 <20200319001100.24917-14-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319001100.24917-14-paulmck@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 05:10:52PM -0700, paulmck@kernel.org wrote:
[...]
> +/* Initialize for a new RCU-tasks-trace grace period. */
> +static void rcu_tasks_trace_pregp_step(void)
> +{
> +	int cpu;
> +
> +	// Wait for CPU-hotplug paths to complete.
> +	cpus_read_lock();
> +	cpus_read_unlock();
> +
> +	// Allow for fast-acting IPIs.
> +	atomic_set(&trc_n_readers_need_end, 1);
> +
> +	// There shouldn't be any old IPIs, but...
> +	for_each_possible_cpu(cpu)
> +		WARN_ON_ONCE(per_cpu(trc_ipi_to_cpu, cpu));
> +}
> +
> +/* Do first-round processing for the specified task. */
> +static void rcu_tasks_trace_pertask(struct task_struct *t,
> +				    struct list_head *hop)
> +{
> +	WRITE_ONCE(t->trc_reader_need_end, false);
> +	t->trc_reader_checked = false;
> +	t->trc_ipi_to_cpu = -1;
> +	trc_wait_for_one_reader(t, hop);
> +}
> +
> +/* Do intermediate processing between task and holdout scans. */
> +static void rcu_tasks_trace_postscan(void)
> +{
> +	// Wait for late-stage exiting tasks to finish exiting.
> +	// These might have passed the call to exit_tasks_rcu_finish().
> +	synchronize_rcu();
> +	// Any tasks that exit after this point will set ->trc_reader_checked.
> +}
> +
> +/* Do one scan of the holdout list. */
> +static void check_all_holdout_tasks_trace(struct list_head *hop,
> +					  bool ndrpt, bool *frptp)
> +{
> +	struct task_struct *g, *t;
> +
> +	list_for_each_entry_safe(t, g, hop, trc_holdout_list) {
> +		// If safe and needed, try to check the current task.
> +		if (READ_ONCE(t->trc_ipi_to_cpu) == -1 &&
> +		    !READ_ONCE(t->trc_reader_checked))
> +			trc_wait_for_one_reader(t, hop);

Just some questions:

1. How are we ensuring on the reader-side that we are executing memory
barriers that are sufficient to ensure that all update-side memory operations
in reader section is visible to code executing after the grace period?

2. Is it possible that a hold-out task is removed from the hold-out list and is
not waited on in the updater side, before the reader side got a chance to
indirectly execute such memory barriers?

3. If a reader sees updates that were done before the grace period started, it
should not see any updates that happen after the grace period ends. Is that
guaranteed with this RCU-Trace?

If its Ok, it would be nice to mention more about memory ordering aspect in
the changelog.

thanks!

 - Joel


> +
> +		// If check succeeded, remove this task from the list.
> +		if (READ_ONCE(t->trc_reader_checked))
> +			trc_del_holdout(t);
> +	}
> +}
> +
> +/* Wait for grace period to complete and provide ordering. */
> +static void rcu_tasks_trace_postgp(void)
> +{
> +	// Remove the safety count.
> +	smp_mb__before_atomic();  // Order vs. earlier atomics
> +	atomic_dec(&trc_n_readers_need_end);
> +	smp_mb__after_atomic();  // Order vs. later atomics
> +
> +	// Wait for readers.
> +	wait_event_idle_exclusive(trc_wait,
> +				  atomic_read(&trc_n_readers_need_end) == 0);
> +
> +	smp_mb(); // Caller's code must be ordered after wakeup.
> +}
> +
> +/* Report any needed quiescent state for this exiting task. */
> +void exit_tasks_rcu_finish_trace(struct task_struct *t)
> +{
> +	WRITE_ONCE(t->trc_reader_checked, true);
> +	WARN_ON_ONCE(t->trc_reader_nesting);
> +	WRITE_ONCE(t->trc_reader_nesting, 0);
> +	if (WARN_ON_ONCE(READ_ONCE(t->trc_reader_need_end)))
> +		rcu_read_unlock_trace_special(t);
> +}
> +
> +void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
> +DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
> +		 "RCU Tasks Trace");
> +
> +/**
> + * call_rcu_tasks_trace() - Queue a callback trace task-based grace period
> + * @rhp: structure to be used for queueing the RCU updates.
> + * @func: actual callback function to be invoked after the grace period
> + *
> + * The callback function will be invoked some time after a full grace
> + * period elapses, in other words after all currently executing RCU
> + * read-side critical sections have completed. call_rcu_tasks_trace()
> + * assumes that the read-side critical sections end at context switch,
> + * cond_resched_rcu_qs(), or transition to usermode execution.  As such,
> + * there are no read-side primitives analogous to rcu_read_lock() and
> + * rcu_read_unlock() because this primitive is intended to determine
> + * that all tasks have passed through a safe state, not so much for
> + * data-strcuture synchronization.
> + *
> + * See the description of call_rcu() for more detailed information on
> + * memory ordering guarantees.
> + */
> +void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func)
> +{
> +	call_rcu_tasks_generic(rhp, func, &rcu_tasks_trace);
> +}
> +EXPORT_SYMBOL_GPL(call_rcu_tasks_trace);
> +
> +/**
> + * synchronize_rcu_tasks_trace - wait for a trace rcu-tasks grace period
> + *
> + * Control will return to the caller some time after a trace rcu-tasks
> + * grace period has elapsed, in other words after all currently
> + * executing rcu-tasks read-side critical sections have elapsed.  These
> + * read-side critical sections are delimited by calls to schedule(),
> + * cond_resched_tasks_rcu_qs(), userspace execution, and (in theory,
> + * anyway) cond_resched().
> + *
> + * This is a very specialized primitive, intended only for a few uses in
> + * tracing and other situations requiring manipulation of function preambles
> + * and profiling hooks.  The synchronize_rcu_tasks_trace() function is not
> + * (yet) intended for heavy use from multiple CPUs.
> + *
> + * See the description of synchronize_rcu() for more detailed information
> + * on memory ordering guarantees.
> + */
> +void synchronize_rcu_tasks_trace(void)
> +{
> +	RCU_LOCKDEP_WARN(lock_is_held(&rcu_trace_lock_map), "Illegal synchronize_rcu_tasks_trace() in RCU Tasks Trace read-side critical section");
> +	synchronize_rcu_tasks_generic(&rcu_tasks_trace);
> +}
> +EXPORT_SYMBOL_GPL(synchronize_rcu_tasks_trace);
> +
> +/**
> + * rcu_barrier_tasks_trace - Wait for in-flight call_rcu_tasks_trace() callbacks.
> + *
> + * Although the current implementation is guaranteed to wait, it is not
> + * obligated to, for example, if there are no pending callbacks.
> + */
> +void rcu_barrier_tasks_trace(void)
> +{
> +	/* There is only one callback queue, so this is easy.  ;-) */
> +	synchronize_rcu_tasks_trace();
> +}
> +EXPORT_SYMBOL_GPL(rcu_barrier_tasks_trace);
> +
> +static int __init rcu_spawn_tasks_trace_kthread(void)
> +{
> +	rcu_tasks_trace.pregp_func = rcu_tasks_trace_pregp_step;
> +	rcu_tasks_trace.pertask_func = rcu_tasks_trace_pertask;
> +	rcu_tasks_trace.postscan_func = rcu_tasks_trace_postscan;
> +	rcu_tasks_trace.holdouts_func = check_all_holdout_tasks_trace;
> +	rcu_tasks_trace.postgp_func = rcu_tasks_trace_postgp;
> +	rcu_spawn_tasks_kthread_generic(&rcu_tasks_trace);
> +	return 0;
> +}
> +core_initcall(rcu_spawn_tasks_trace_kthread);
> +
> +#else /* #ifdef CONFIG_TASKS_TRACE_RCU */
> +void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
> +#endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
> -- 
> 2.9.5
> 
