Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4901076E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 19:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKVSBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 13:01:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35446 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVSBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 13:01:44 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iYDFU-0003BN-NB; Fri, 22 Nov 2019 19:01:40 +0100
Date:   Fri, 22 Nov 2019 19:01:40 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH RT] locking: Make spinlock_t and rwlock_t a RCU section
 on RT
Message-ID: <20191122180140.bspcwv6xtrwqhmu7@linutronix.de>
References: <20191119084640.wgsxghvc62mxlqc3@linutronix.de>
 <20191119092149.06fd8f87@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191119092149.06fd8f87@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-19 09:21:49 [-0500], Steven Rostedt wrote:
> On Tue, 19 Nov 2019 09:46:40 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On !RT a locked spinlock_t and rwlock_t disables preemption which
> > implies a RCU read section. There is code that relies on that behaviour.
> > 
> > Add an explicit RCU read section on RT while a sleeping lock (a lock
> > which would disables preemption on !RT) acquired.
> 
> I know that there was some work to merge the RCU flavors of
> rcu_read_lock and rcu_read_lock_sched, I'm assuming this depends on
> that behavior. That is, a synchronize_rcu() will wait for all CPUs to
> schedule and all grace periods to finish, which means that those using
> rcu_read_lock() and those using all CPUs to schedule can be
> interchangeable. That is, on !RT, it's likely that rcu_read_lock()
> waiters will end up waiting for all CPUs to schedule, and on RT, this
> makes it where those waiting for all CPUs to schedule, will also wait
> for all rcu_read_lock()s grace periods to finish. If that's the case,
> then this change is fine. But it depends on that being the case, which
> it wasn't in older kernels, and we need to be careful about backporting
> this.

Let me give you an example how I got into this:

do_sigaction() acquires p->sighand->siglock and then iterates over list
via for_each_thread() which is a list_for_each_entry_rcu(). No RCU lock
is held, just the siglock.
On removal side, __unhash_process() removes a task from the list but
while doing so it holds the siglock and tasklist_lock. So it is
perfectly fine.
Later, we have:
|do_exit()
| -> exit_notify()
|   -> write_lock_irq(&tasklist_lock);
|   -> forget_original_parent()
|      -> find_child_reaper()
|        -> find_alive_thread()
|           -> for_each_thread()

find_alive_thread() does the for_each_thread() and checks PF_EXITING.
it might be enough for not operating on "removed" task_struct. It
dereferences task_struct->flags while looking for PF_EXITING. At this
point only tasklist_lock is acquired.
I have *no* idea if the whole synchronisation based on siglock/
PF_EXITING/ tasklist_lock is enough and RCU simply doesn't matter. It
seems so.

I am a little worried if this construct here (or somewhere else) assumes
that holding one of those locks, which disable preemption, is the same
as rcu_read_lock() (or rcu_read_lock_sched()).

> -- Steve

Sebastian
