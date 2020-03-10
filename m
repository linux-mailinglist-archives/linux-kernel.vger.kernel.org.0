Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAB1D180A18
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 22:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbgCJVOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 17:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgCJVOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:14:14 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DCF0222C3;
        Tue, 10 Mar 2020 21:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583874853;
        bh=kOqE8zGCErI79fwsC2Z+2oEYNLpWijdwhWCVxRHeLFY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dqeXkVkQxbUYam1uaxDZNgGOh9wEm9cuNgYMwyXrOfjfE1N/ODlxQW7nTQJkKpyyI
         XNXDVaQR5QeE9z3el7g0CZcuKhz8P7J8aUZ7J/wQ0NVmsixcoSSeZyJgBLLW3SBzYT
         CP5NB2gHM+hBge85KteJq7BP3vnB42eq20BarFE0=
Message-ID: <c4ef31a663fbf7a3de349696e9f00f2f5c4ec89a.camel@kernel.org>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, yangerkun <yangerkun@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue, 10 Mar 2020 17:14:11 -0400
In-Reply-To: <878sk7vs8q.fsf@notabene.neil.brown.name>
References: <20200308140314.GQ5972@shao2-debian>
         <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org>
         <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com>
         <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org>
         <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org>
         <87blp5urwq.fsf@notabene.neil.brown.name>
         <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org>
         <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com>
         <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org>
         <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org>
         <878sk7vs8q.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-11 at 08:01 +1100, NeilBrown wrote:
> On Tue, Mar 10 2020, Jeff Layton wrote:
> 
> > On Tue, 2020-03-10 at 08:52 -0400, Jeff Layton wrote:
> > 
> > [snip]
> > 
> > > On Tue, 2020-03-10 at 11:24 +0800, yangerkun wrote:
> > > > Something others. I think there is no need to call locks_delete_block 
> > > > for all case in function like flock_lock_inode_wait. What we should do 
> > > > as the patch '16306a61d3b7 ("fs/locks: always delete_block after 
> > > > waiting.")' describes is that we need call locks_delete_block not only 
> > > > for error equal to -ERESTARTSYS(please point out if I am wrong). And 
> > > > this patch may fix the regression too since simple lock that success or 
> > > > unlock will not try to acquire blocked_lock_lock.
> > > > 
> > > > 
> > > 
> > > Nice! This looks like it would work too, and it's a simpler fix.
> > > 
> > > I'd be inclined to add a WARN_ON_ONCE(fl->fl_blocker) after the if
> > > statements to make sure we never exit with one still queued. Also, I
> > > think we can do a similar optimization in __break_lease.
> > > 
> > > There are some other callers of locks_delete_block:
> > > 
> > > cifs_posix_lock_set: already only calls it in these cases
> > > 
> > > nlmsvc_unlink_block: I think we need to call this in most cases, and
> > > they're not going to be high-performance codepaths in general
> > > 
> > > nfsd4 callback handling: Several calls here, most need to always be
> > > called. find_blocked_lock could be reworked to take the
> > > blocked_lock_lock only once (I'll do that in a separate patch).
> > > 
> > > How about something like this (
> > > 
> > > ----------------------8<---------------------
> > > 
> > > From: yangerkun <yangerkun@huawei.com>
> > > 
> > > [PATCH] filelock: fix regression in unlock performance
> > > 
> > > '6d390e4b5d48 ("locks: fix a potential use-after-free problem when
> > > wakeup a waiter")' introduces a regression since we will acquire
> > > blocked_lock_lock every time locks_delete_block is called.
> > > 
> > > In many cases we can just avoid calling locks_delete_block at all,
> > > when we know that the wait was awoken by the condition becoming true.
> > > Change several callers of locks_delete_block to only call it when
> > > waking up due to signal or other error condition.
> > > 
> > > [ jlayton: add similar optimization to __break_lease, reword changelog,
> > > 	   add WARN_ON_ONCE calls ]
> > > 
> > > Fixes: 16306a61d3b7 ("fs/locks: always delete_block after waiting.")
> > > Fixes: 6d390e4b5d48 ("locks: fix a potential use-after-free problem when wakeup a waiter")
> > > Signed-off-by: yangerkun <yangerkun@huawei.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/locks.c | 29 ++++++++++++++++++++++-------
> > >  1 file changed, 22 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/fs/locks.c b/fs/locks.c
> > > index 426b55d333d5..b88a5b11c464 100644
> > > --- a/fs/locks.c
> > > +++ b/fs/locks.c
> > > @@ -1354,7 +1354,10 @@ static int posix_lock_inode_wait(struct inode *inode, struct file_lock *fl)
> > >  		if (error)
> > >  			break;
> > >  	}
> > > -	locks_delete_block(fl);
> > > +	if (error)
> > > +		locks_delete_block(fl);
> > > +	WARN_ON_ONCE(fl->fl_blocker);
> > > +
> > >  	return error;
> > >  }
> > >  
> > > @@ -1447,7 +1450,9 @@ int locks_mandatory_area(struct inode *inode, struct file *filp, loff_t start,
> > >  
> > >  		break;
> > >  	}
> > > -	locks_delete_block(&fl);
> > > +	if (error)
> > > +		locks_delete_block(&fl);
> > > +	WARN_ON_ONCE(fl.fl_blocker);
> > >  
> > >  	return error;
> > >  }
> > > @@ -1638,23 +1643,28 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
> > >  
> > >  	locks_dispose_list(&dispose);
> > >  	error = wait_event_interruptible_timeout(new_fl->fl_wait,
> > > -						!new_fl->fl_blocker, break_time);
> > > +						 !new_fl->fl_blocker,
> > > +						 break_time);
> > >  
> > >  	percpu_down_read(&file_rwsem);
> > >  	spin_lock(&ctx->flc_lock);
> > >  	trace_break_lease_unblock(inode, new_fl);
> > > -	locks_delete_block(new_fl);
> > >  	if (error >= 0) {
> > >  		/*
> > >  		 * Wait for the next conflicting lease that has not been
> > >  		 * broken yet
> > >  		 */
> > > -		if (error == 0)
> > > +		if (error == 0) {
> > > +			locks_delete_block(new_fl);
> > >  			time_out_leases(inode, &dispose);
> > > +		}
> > >  		if (any_leases_conflict(inode, new_fl))
> > >  			goto restart;
> > >  		error = 0;
> > > +	} else {
> > > +		locks_delete_block(new_fl);
> > >  	}
> > > +	WARN_ON_ONCE(fl->fl_blocker);
> > >  out:
> > >  	spin_unlock(&ctx->flc_lock);
> > >  	percpu_up_read(&file_rwsem);
> > > @@ -2126,7 +2136,10 @@ static int flock_lock_inode_wait(struct inode *inode, struct file_lock *fl)
> > >  		if (error)
> > >  			break;
> > >  	}
> > > -	locks_delete_block(fl);
> > > +	if (error)
> > > +		locks_delete_block(fl);
> > > +	WARN_ON_ONCE(fl->fl_blocker);
> > > +
> > >  	return error;
> > >  }
> > >  
> > > @@ -2403,7 +2416,9 @@ static int do_lock_file_wait(struct file *filp, unsigned int cmd,
> > >  		if (error)
> > >  			break;
> > >  	}
> > > -	locks_delete_block(fl);
> > > +	if (error)
> > > +		locks_delete_block(fl);
> > > +	WARN_ON_ONCE(fl->fl_blocker);
> > >  
> > >  	return error;
> > >  }
> > 
> > I've gone ahead and added the above patch to linux-next. Linus, Neil,
> > are you ok with this one? I think this is probably the simplest
> > approach.
> 
> I think this patch contains an assumption which is not justified.  It
> assumes that if a wait_event completes without error, then the wake_up()
> must have happened.  I don't think that is correct.
> 
> In the patch that caused the recent regression, the race described
> involved a signal arriving just as __locks_wake_up_blocks() was being
> called on another thread.
> So the waiting process was woken by a signal *after* ->fl_blocker was set
> to NULL, and *before* the wake_up().  If wait_event_interruptible()
> finds that the condition is true, it will report success whether there
> was a signal or not.
> 
> If you skip the locks_delete_block() after a wait, you get exactly the
> same race as the optimization - which only skipped most of
> locks_delete_block().
> 
> I have a better solution.  I did like your patch except that it changed
> too much code.  So I revised it to change less code.  See below.
> 
> NeilBrown
> 
> From: NeilBrown <neilb@suse.de>
> Date: Wed, 11 Mar 2020 07:39:04 +1100
> Subject: [PATCH] locks: restore locks_delete_lock optimization
> 
> A recent patch (see Fixes: below) removed an optimization which is
> important as it avoids taking a lock in a common case.
> 
> The comment justifying the optimisation was correct as far as it went,
> in that if the tests succeeded, then the values would remain stable and
> the test result will remain valid even without a lock.
> 
> However after the test succeeds the lock can be freed while some other
> thread might have only just set ->blocker to NULL (thus allowing the
> test to succeed) but has not yet called wake_up() on the wq in the lock.
> If the wake_up happens after the lock is freed, a use-after-free error
> occurs.
> 
> This patch restores the optimization and reorders code to avoid the
> use-after-free.  Specifically we move the list_del_init on
> fl_blocked_member to *after* the wake_up(), and add an extra test on
> fl_block_member() to locks_delete_lock() before deciding to avoid taking
> the spinlock.
> 
> As this involves breaking code out of __locks_delete_block(), we discard
> the function completely and open-code it in the two places it was
> called.
> 
> These lockless accesses do not require any memory barriers.  The failure
> mode from possible memory access reordering is that the test at the top
> of locks_delete_lock() will fail, and in that case we fall through into
> the locked region which provides sufficient memory barriers implicitly.
> 
> Fixes: 6d390e4b5d48 ("locks: fix a potential use-after-free problem when wakeup a waiter")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/locks.c | 42 ++++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 426b55d333d5..dc99ab2262ea 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -716,18 +716,6 @@ static void locks_delete_global_blocked(struct file_lock *waiter)
>  	hash_del(&waiter->fl_link);
>  }
>  
> -/* Remove waiter from blocker's block list.
> - * When blocker ends up pointing to itself then the list is empty.
> - *
> - * Must be called with blocked_lock_lock held.
> - */
> -static void __locks_delete_block(struct file_lock *waiter)
> -{
> -	locks_delete_global_blocked(waiter);
> -	list_del_init(&waiter->fl_blocked_member);
> -	waiter->fl_blocker = NULL;
> -}
> -
>  static void __locks_wake_up_blocks(struct file_lock *blocker)
>  {
>  	while (!list_empty(&blocker->fl_blocked_requests)) {
> @@ -735,11 +723,13 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
>  
>  		waiter = list_first_entry(&blocker->fl_blocked_requests,
>  					  struct file_lock, fl_blocked_member);
> -		__locks_delete_block(waiter);
> +		locks_delete_global_blocked(waiter);
> +		waiter->fl_blocker = NULL;
>  		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
>  			waiter->fl_lmops->lm_notify(waiter);
>  		else
>  			wake_up(&waiter->fl_wait);
> +		list_del_init(&waiter->fl_blocked_member);

Are you sure you don't need a memory barrier here? Could the
list_del_init be hoisted just above the if condition?

>  	}
>  }
>  
> @@ -753,11 +743,35 @@ int locks_delete_block(struct file_lock *waiter)
>  {
>  	int status = -ENOENT;
>  
> +	/*
> +	 * If fl_blocker is NULL, it won't be set again as this thread
> +	 * "owns" the lock and is the only one that might try to claim
> +	 * the lock.  So it is safe to test fl_blocker locklessly.
> +	 * Also if fl_blocker is NULL, this waiter is not listed on
> +	 * fl_blocked_requests for some lock, so no other request can
> +	 * be added to the list of fl_blocked_requests for this
> +	 * request.  So if fl_blocker is NULL, it is safe to
> +	 * locklessly check if fl_blocked_requests is empty.  If both
> +	 * of these checks succeed, there is no need to take the lock.
> +	 * We also check fl_blocked_member is empty.  This is logically
> +	 * redundant with the test of fl_blocker, but it ensure that
> +	 * __locks_wake_up_blocks() has finished the wakeup and will not
> +	 * access the lock again, so it is safe to return and free.
> +	 * There is no need for any memory barriers with these lockless
> +	 * tests as is the reads happen before the corresponding writes are
> +	 * seen, we fall through to the locked code.
> +	 */
> +	if (waiter->fl_blocker == NULL &&
> +	    list_empty(&waiter->fl_blocked_member) &&
> +	    list_empty(&waiter->fl_blocked_requests))
> +		return status;
>  	spin_lock(&blocked_lock_lock);
>  	if (waiter->fl_blocker)
>  		status = 0;
>  	__locks_wake_up_blocks(waiter);
> -	__locks_delete_block(waiter);
> +	locks_delete_global_blocked(waiter);
> +	list_del_init(&waiter->fl_blocked_member);
> +	waiter->fl_blocker = NULL;
>  	spin_unlock(&blocked_lock_lock);
>  	return status;
>  }

-- 
Jeff Layton <jlayton@kernel.org>

