Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFEE8180992
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 21:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgCJUxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 16:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgCJUxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:53:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72A67215A4;
        Tue, 10 Mar 2020 20:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583873599;
        bh=X38RRtVqyUT4CN0WqneduuxullKycoYkG3EBJHKN4ak=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=otUuKkQNvFiyLqR/B+XGEmxu//oczmU3atnGXA1MrlE91xln8IY/iQ+1EPsJbSZyO
         YV5vURZINH6wAoJH9PZlABqmmtqgRMN/HoJ6BXmbYmjLvRPBl081ga2ErdmFs2wudf
         8J0Pse6uOdyHU4K1m2kBwWMSpm8Jm20vNaiTjYxQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4964E35229CC; Tue, 10 Mar 2020 13:53:19 -0700 (PDT)
Date:   Tue, 10 Mar 2020 13:53:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] tracepoint: rcuidle: use rcu_is_watching() and tree-rcu
Message-ID: <20200310205319.GH2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200310202054.5880-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310202054.5880-1-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 04:20:54PM -0400, Mathieu Desnoyers wrote:
> commit e6753f23d961 ("tracepoint: Make rcuidle tracepoint callers use
> SRCU") aimed at improving performance of rcuidle tracepoints by using
> SRCU rather than temporarily enabling tree-rcu every time.
> 
> commit 865e63b04e9b ("tracing: Add back in rcu_irq_enter/exit_irqson()
> for rcuidle tracepoints") adds back the high-overhead enabling of
> tree-rcu because perf expects RCU to be watching when called from
> rcuidle tracepoints.
> 
> It turns out that by using "rcu_is_watching()" and conditionally
> calling the high-overhead rcu_irq_enter/exit_irqson(), the original
> motivation for using SRCU in the first place disappears.

Adding Alexei on CC for his thoughts, given that these were his
benchmarks.  I believe that he also has additional use cases.

But given the use cases you describe, this seems plausible.  This does
mean that tracepoints cannot be attached to the CPU-hotplug code that
runs on the incoming/outgoing CPU early/late in that process, though
that might be OK.

						Thanx, Paul

> I suspect that the original benchmarks justifying the introduction
> of SRCU to handle rcuidle tracepoints was caused by preempt/irq
> tracepoints, which are typically invoked from contexts that have
> RCU watching.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Joel Fernandes <joel@joelfernandes.org>
> CC: "Paul E. McKenney" <paulmck@kernel.org>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Frederic Weisbecker <fweisbec@gmail.com>
> CC: Ingo Molnar <mingo@kernel.org>
> ---
>  include/linux/tracepoint.h | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 1fb11daa5c53..8e0e94fee29a 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -165,25 +165,22 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		void *it_func;						\
>  		void *__data;						\
>  		int __maybe_unused __idx = 0;				\
> +		bool __exit_rcu = false;				\
>  									\
>  		if (!(cond))						\
>  			return;						\
>  									\
> -		/* srcu can't be used from NMI */			\
> -		WARN_ON_ONCE(rcuidle && in_nmi());			\
> -									\
> -		/* keep srcu and sched-rcu usage consistent */		\
> -		preempt_disable_notrace();				\
> -									\
>  		/*							\
> -		 * For rcuidle callers, use srcu since sched-rcu	\
> -		 * doesn't work from the idle path.			\
> +		 * For rcuidle callers, temporarily enable RCU if	\
> +		 * it is not currently watching.			\
>  		 */							\
> -		if (rcuidle) {						\
> -			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
> +		if (rcuidle && !rcu_is_watching()) {			\
>  			rcu_irq_enter_irqson();				\
> +			__exit_rcu = true;				\
>  		}							\
>  									\
> +		preempt_disable_notrace();				\
> +									\
>  		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
>  									\
>  		if (it_func_ptr) {					\
> @@ -194,12 +191,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  			} while ((++it_func_ptr)->func);		\
>  		}							\
>  									\
> -		if (rcuidle) {						\
> -			rcu_irq_exit_irqson();				\
> -			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
> -		}							\
> -									\
>  		preempt_enable_notrace();				\
> +									\
> +		if (__exit_rcu)						\
> +			rcu_irq_exit_irqson();				\
>  	} while (0)
>  
>  #ifndef MODULE
> -- 
> 2.17.1
> 
