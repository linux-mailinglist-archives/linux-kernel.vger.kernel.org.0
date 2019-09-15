Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB4B3B308E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2019 16:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbfIOOle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 10:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfIOOle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 10:41:34 -0400
Received: from paulmck-ThinkPad-P72 (96-84-246-146-static.hfc.comcastbusiness.net [96.84.246.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81845214C6;
        Sun, 15 Sep 2019 14:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568558492;
        bh=/15SybyxxBw7u3kKp+XT+9KlhE86WWRUHZUYKh2/29I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=wnkspCitkysxjreEK7MF4CdkCEfYxkww+0jL3SGSaC3wZqSLAxIxaE7ZgZu4b+oif
         4wCjPMZPdPnBMq62Zna2yrDNdHz9ykei4mr2+YoJrEgi1uhXZ5hh1kM8FXgy4ztFfG
         aEO/oCzSWoF85Gv4mLBlRCdP1/sDA0/KVIU4G9Hc=
Date:   Sun, 15 Sep 2019 07:41:29 -0700
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
Subject: Re: [PATCH v2 4/4] task: RCUify the assignment of rq->curr
Message-ID: <20190915144129.GL30224@paulmck-ThinkPad-P72>
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
 <87ftkzdpjd.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftkzdpjd.fsf_-_@x220.int.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 07:35:02AM -0500, Eric W. Biederman wrote:
> 
> The current task on the runqueue is currently read with rcu_dereference().
> 
> To obtain ordinary rcu semantics for an rcu_dereference of rq->curr it needs
> to be paird with rcu_assign_pointer of rq->curr.  Which provides the
> memory barrier necessary to order assignments to the task_struct
> and the assignment to rq->curr.
> 
> Unfortunately the assignment of rq->curr in __schedule is a hot path,
> and it has already been show that additional barriers in that code
> will reduce the performance of the scheduler.  So I will attempt to
> describe below why you can effectively have ordinary rcu semantics
> without any additional barriers.
> 
> The assignment of rq->curr in init_idle is a slow path called once
> per cpu and that can use rcu_assign_pointer() without any concerns.
> 
> As I write this there are effectively two users of rcu_dereference on
> rq->curr.  There is the membarrier code in kernel/sched/membarrier.c
> that only looks at "->mm" after the rcu_dereference.  Then there is
> task_numa_compare() in kernel/sched/fair.c.  My best reading of the
> code shows that task_numa_compare only access: "->flags",
> "->cpus_ptr", "->numa_group", "->numa_faults[]",
> "->total_numa_faults", and "->se.cfs_rq".
> 
> The code in __schedule() essentially does:
> 	rq_lock(...);
> 	smp_mb__after_spinlock();
> 
> 	next = pick_next_task(...);
> 	rq->curr = next;
> 
> 	context_switch(prev, next);
> 
> At the start of the function the rq_lock/smp_mb__after_spinlock
> pair provides a full memory barrier.  Further there is a full memory barrier
> in context_switch().
> 
> This means that any task that has already run and modified itself (the
> common case) has already seen two memory barriers before __schedule()
> runs and begins executing.  A task that modifies itself then sees a
> third full memory barrier pair with the rq_lock();
> 
> For a brand new task that is enqueued with wake_up_new_task() there
> are the memory barriers present from the taking and release the
> pi_lock and the rq_lock as the processes is enqueued as well as the
> full memory barrier at the start of __schedule() assuming __schedule()
> happens on the same cpu.
> 
> This means that by the time we reach the assignment of rq->curr
> except for values on the task struct modified in pick_next_task
> the code has the same guarantees as if it used rcu_assign_pointer.
> 
> Reading through all of the implementations of pick_next_task it
> appears pick_next_task is limited to modifying the task_struct fields
> "->se", "->rt", "->dl".  These fields are the sched_entity structures
> of the varies schedulers.

s/varies/various/ for whatever that is worth.

> Further "->se.cfs_rq" is only changed in cgroup attach/move operations
> initialized by userspace.
> 
> Unless I have missed something this means that in practice that the
> users of "rcu_dereerence(rq->curr)" get normal rcu semantics of
> rcu_dereference() for the fields the care about, despite the
> assignment of rq->curr in __schedule() ot using rcu_assign_pointer.

The reasoning makes sense.  I have not double-checked all the code.

> Link: https://lore.kernel.org/r/20190903200603.GW2349@hirez.programming.kicks-ass.net
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/sched/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 69015b7c28da..668262806942 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3857,7 +3857,11 @@ static void __sched notrace __schedule(bool preempt)
>  
>  	if (likely(prev != next)) {
>  		rq->nr_switches++;
> -		rq->curr = next;
> +		/*
> +		 * RCU users of rcu_dereference(rq->curr) may not see
> +		 * changes to task_struct made by pick_next_task().
> +		 */
> +		RCU_INIT_POINTER(rq->curr, next);
>  		/*
>  		 * The membarrier system call requires each architecture
>  		 * to have a full memory barrier after updating
> @@ -5863,7 +5867,8 @@ void init_idle(struct task_struct *idle, int cpu)
>  	__set_task_cpu(idle, cpu);
>  	rcu_read_unlock();
>  
> -	rq->curr = rq->idle = idle;
> +	rq->idle = idle;
> +	rcu_assign_pointer(rq->curr, idle);
>  	idle->on_rq = TASK_ON_RQ_QUEUED;
>  #ifdef CONFIG_SMP
>  	idle->on_cpu = 1;
> -- 
> 2.21.0.dirty

So this looks good in and of itself, but I still do not see what prevents
the unfortunate sequence of events called out in my previous email.
On the other hand, if ->rcu and ->rcu_users were not allocated on top
of each other by a union, I would be happy to provide a Reviewed-by.

And I am fundamentally distrusting of a refcount_dec_and_test() that
is immediately followed by code that clobbers the now-zero value.
Yes, this does have valid use cases, but it has a lot more invalid
use cases.  The valid use cases have excluded all increments somehow
else, so that the refcount_dec_and_test() call's only job is to
synchronize between concurrent calls to put_task_struct_rcu_user().
But I am not seeing the "excluded all increments somehow".

So, what am I missing here?

							Thanx, Paul
