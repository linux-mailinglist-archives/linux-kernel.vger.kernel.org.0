Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 021C618DDE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 18:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfEIQTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 12:19:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50563 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfEIQTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:19:41 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hOllW-00029d-0c; Thu, 09 May 2019 18:19:26 +0200
Date:   Thu, 9 May 2019 18:19:25 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     minyard@acm.org
Cc:     linux-rt-users@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190509161925.kul66w54wpjcinuc@linutronix.de>
References: <20190508205728.25557-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190508205728.25557-1-minyard@acm.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please:
 - add some RT developers on Cc:
 - add lkml
 - use [PATCH RT] instead just [PATCH] so it is visible that you target
   the RT tree.

On 2019-05-08 15:57:28 [-0500], minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> The function call do_wait_for_common() has a race condition that
> can result in lockups waiting for completions.  Adding the thread
> to (and removing the thread from) the wait queue for the completion
> is done outside the do loop in that function.  However, if the thread
> is woken up, the swake_up_locked() function will delete the entry
> from the wait queue.  If that happens and another thread sneaks
> in and decrements the done count in the completion to zero, the
> loop will go around again, but the thread will no longer be in the
> wait queue, so there is no way to wake it up.
> 
> Fix it by adding/removing the thread to/from the wait queue inside
> the do loop.

So you are saying:
	T0			T1			    T2
	wait_for_completion()
	 do_wait_for_common()
	  __prepare_to_swait()
	   schedule()
	    		       complete()
			        x->done++ (0 -> 1)
				raw_spin_lock_irqsave()
				 swake_up_locked()           wait_for_completion()
				  wake_up_process(T0)
				  list_del_init()
				raw_spin_unlock_irqrestore()
	                                                      raw_spin_lock_irq(&x->wait.lock)
	 raw_spin_lock_irq(&x->wait.lock)                      x->done != UINT_MAX, 1 -> 0
							       return 1
							      raw_spin_unlock_irq(&x->wait.lock)
	 while (!x->done && timeout),
	 continue loop, not enqueued
	 on &x->wait

The difference compared to the non-swait based implementation is that
swake_up_locked() removes woken up tasks from the list while the other
implementation (wait_queue_entry based, default_wake_function()) does
not. Buh

One question for the upstream completion implementation:
completion_done() returns true if there are no waiters. It acquires the
wait.lock to ensure that complete()/complete_all() is done. However,
once complete releases the lock it is guaranteed that the wake_up() (for
the waiter) occurred. The waiter task still needs to be remove itself
from the wait-queue before the completion can be removed.
Do I miss something?

> Fixes: a04ff6b4ec4ee7e ("completion: Use simple wait queues")
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
> I sent the wrong version of this, I had spotted this before but didn't
> fix it here.  Adding the thread to the wait queue needs to come after
> the signal check.  Sorry about the noise.
> 
>  kernel/sched/completion.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
> index 755a58084978..4f9b4cc0c95a 100644
> --- a/kernel/sched/completion.c
> +++ b/kernel/sched/completion.c
> @@ -70,20 +70,20 @@ do_wait_for_common(struct completion *x,
>  		   long (*action)(long), long timeout, int state)
>  {
>  	if (!x->done) {
> -		DECLARE_SWAITQUEUE(wait);
> -
> -		__prepare_to_swait(&x->wait, &wait);

you can keep DECLARE_SWAITQUEUE remove just __prepare_to_swait()

>  		do {
> +			DECLARE_SWAITQUEUE(wait);
> +
>  			if (signal_pending_state(state, current)) {
>  				timeout = -ERESTARTSYS;
>  				break;
>  			}
> +			__prepare_to_swait(&x->wait, &wait);

add this, yes and you are done.

>  			__set_current_state(state);
>  			raw_spin_unlock_irq(&x->wait.lock);
>  			timeout = action(timeout);
>  			raw_spin_lock_irq(&x->wait.lock);
> +			__finish_swait(&x->wait, &wait);
>  		} while (!x->done && timeout);
> -		__finish_swait(&x->wait, &wait);
>  		if (!x->done)
>  			return timeout;
>  	}

Sebastian
