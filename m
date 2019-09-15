Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3EC7B3072
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2019 16:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbfIOOH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 10:07:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfIOOH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 10:07:56 -0400
Received: from paulmck-ThinkPad-P72 (96-84-246-146-static.hfc.comcastbusiness.net [96.84.246.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 099AA214D9;
        Sun, 15 Sep 2019 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568556475;
        bh=PtI1s93uz5LzjYrcHCO/m9JZsN2Yi2k5CexWbpm06yI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KxZIbqZvvznr+//k0fG6GMQiDZH9DGZwakms3gjcdll1vnWQwCWBns3/tbPOFx2Af
         YqrFFQ66M+yBvUxW/NYGgul3aCT0b+yeTGwKRozkHvoqoH7nPFhLQo7tUnJ4+FfIq1
         It4MNlI9Qq4lUhYWOQUcDmgS3xK2TnqWJYZY4xKg=
Date:   Sun, 15 Sep 2019 07:07:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 2/4] task: Ensure tasks are available for a grace
 period after leaving the runqueue
Message-ID: <20190915140752.GJ30224@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com>
 <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org>
 <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
 <87muf7f4bf.fsf_-_@x220.int.ebiederm.org>
 <87r24jdpl5.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r24jdpl5.fsf_-_@x220.int.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 07:33:58AM -0500, Eric W. Biederman wrote:
> 
> In the ordinary case today the rcu grace period for a task_struct is
> triggered when another process wait's for it's zombine and causes the
> kernel to call release_task().  As the waiting task has to receive a
> signal and then act upon it before this happens, typically this will
> occur after the original task as been removed from the runqueue.
> 
> Unfortunaty in some cases such as self reaping tasks it can be shown
> that release_task() will be called starting the grace period for
> task_struct long before the task leaves the runqueue.
> 
> Therefore use put_task_struct_rcu_user in finish_task_switch to
> guarantee that the there is a rcu lifetime after the task
> leaves the runqueue.
> 
> Besides the change in the start of the rcu grace period for the
> task_struct this change may cause perf_event_delayed_put and
> trace_sched_process_free.  The function perf_event_delayed_put boils
> down to just a WARN_ON for cases that I assume never show happen.  So
> I don't see any problem with delaying it.
> 
> The function trace_sched_process_free is a trace point and thus
> visible to user space.  Occassionally userspace has the strangest
> dependencies so this has a miniscule chance of causing a regression.
> This change only changes the timing of when the tracepoint is called.
> The change in timing arguably gives userspace a more accurate picture
> of what is going on.  So I don't expect there to be a regression.
> 
> In the case where a task self reaps we are pretty much guaranteed that
> the rcu grace period is delayed.  So we should get quite a bit of
> coverage in of this worst case for the change in a normal threaded
> workload.  So I expect any issues to turn up quickly or not at all.
> 
> I have lightly tested this change and everything appears to work
> fine.
> 
> Inspired-by: Linus Torvalds <torvalds@linux-foundation.org>
> Inspired-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/fork.c       | 11 +++++++----
>  kernel/sched/core.c |  2 +-
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9f04741d5c70..7a74ade4e7d6 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -900,10 +900,13 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>  	if (orig->cpus_ptr == &orig->cpus_mask)
>  		tsk->cpus_ptr = &tsk->cpus_mask;
>  
> -	/* One for the user space visible state that goes away when reaped. */
> -	refcount_set(&tsk->rcu_users, 1);
> -	/* One for the rcu users, and one for the scheduler */
> -	refcount_set(&tsk->usage, 2);
> +	/*
> +	 * One for the user space visible state that goes away when reaped.
> +	 * One for the scheduler.
> +	 */
> +	refcount_set(&tsk->rcu_users, 2);

OK, this would allow us to add a later decrement-and-test of
->rcu_users ...

> +	/* One for the rcu users */
> +	refcount_set(&tsk->usage, 1);
>  #ifdef CONFIG_BLK_DEV_IO_TRACE
>  	tsk->btrace_seq = 0;
>  #endif
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2b037f195473..69015b7c28da 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3135,7 +3135,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>  		/* Task is done with its stack. */
>  		put_task_stack(prev);
>  
> -		put_task_struct(prev);
> +		put_task_struct_rcu_user(prev);

... which is here.  And this looks to be invoked from the __schedule()
called from do_task_dead() at the very end of do_exit().

This looks plausible, but still requires that it no longer be possible to
enter an RCU read-side critical section that might increment ->rcu_users
after this point in time.  This might be enforced by a grace period
between the time that the task was removed from its lists and the current
time (seems unlikely, though, in that case why bother with call_rcu()?) or
by some other synchronization.

On to the next patch!

							Thanx, Paul

>  	}
>  
>  	tick_nohz_task_switch();
> -- 
> 2.21.0.dirty
> 
