Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC5D17B146
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 23:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgCEWNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 17:13:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgCEWNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:13:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35F2320801;
        Thu,  5 Mar 2020 22:13:46 +0000 (UTC)
Date:   Thu, 5 Mar 2020 17:13:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jann Horn <jannh@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] exit: Move preemption fixup up, move blocking
 operations down
Message-ID: <20200305171344.1f35d971@gandalf.local.home>
In-Reply-To: <20200305220657.46800-1-jannh@google.com>
References: <20200305220657.46800-1-jannh@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Mar 2020 23:06:57 +0100
Jann Horn <jannh@google.com> wrote:

> With CONFIG_DEBUG_ATOMIC_SLEEP=y and CONFIG_CGROUPS=y, kernel oopses in
> non-preemptible context look untidy; after the main oops, the kernel prints
> a "sleeping function called from invalid context" report because
> exit_signals() -> cgroup_threadgroup_change_begin() -> percpu_down_read()
> can sleep, and that happens before the preempt_count_set(PREEMPT_ENABLED)
> fixup.
> 
> It looks like the same thing applies to profile_task_exit() and
> kcov_task_exit().
> 
> Fix it by moving the preemption fixup up and the calls to
> profile_task_exit() and kcov_task_exit() down.
> 
> Fixes: 1dc0fffc48af ("sched/core: Robustify preemption leak checks")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---



> @@ -732,6 +736,16 @@ void __noreturn do_exit(long code)
>  	 */
>  	set_fs(USER_DS);
>  
> +	if (unlikely(in_atomic())) {
> +		pr_info("note: %s[%d] exited with preempt_count %d\n",
> +			current->comm, task_pid_nr(current),
> +			preempt_count());

This should be more than a pr_info. It should also probably state the
"Dazed and confused, best to reboot" message.

Because if something crashed in a non preempt section, it may likely be
holding a lock that it will never release, causing a soon to be deadlock!

-- Steve


> +		preempt_count_set(PREEMPT_ENABLED);
> +	}
> +
> +	profile_task_exit(tsk);
> +	kcov_task_exit(tsk);
> +
>  	ptrace_event(PTRACE_EVENT_EXIT, code);
>  
>  	validate_creds_for_do_exit(tsk);
> @@ -749,13 +763,6 @@ void __noreturn do_exit(long code)
>  
>  	exit_signals(tsk);  /* sets PF_EXITING */
>  
> -	if (unlikely(in_atomic())) {
> -		pr_info("note: %s[%d] exited with preempt_count %d\n",
> -			current->comm, task_pid_nr(current),
> -			preempt_count());
> -		preempt_count_set(PREEMPT_ENABLED);
> -	}
> -
>  	/* sync mm's RSS info before statistics gathering */
>  	if (tsk->mm)
>  		sync_mm_rss(tsk->mm);
> 
> base-commit: 9f65ed5fe41ce08ed1cb1f6a950f9ec694c142ad

