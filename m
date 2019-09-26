Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 068CFBF333
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 14:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfIZMmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 08:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbfIZMmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:42:36 -0400
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B2AF21655;
        Thu, 26 Sep 2019 12:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569501755;
        bh=ATCs9gmxEWO8JXMRcvMbab/iMeSeAaiX73ZBo1CkExE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AF8G9NhOzIq9cR1iHEOav8ljMppq/CxztN5okPvbm0MeGfMWQS4vtVa9nZb3ArpR0
         6nVTOp3Dga0kF468UtwaBHrPBjFz8TBi3Ts3fBfXXkR1D+gnbqUOVj2EUpTqmSDrYa
         Q6dnEEnXVhK4uWDaVZxs78JlTzGP7hQGe50DjeGA=
Date:   Thu, 26 Sep 2019 14:42:32 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
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
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 4/4] task: RCUify the assignment of rq->curr
Message-ID: <20190926124231.GA25572@lenoir>
References: <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org>
 <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
 <87muf7f4bf.fsf_-_@x220.int.ebiederm.org>
 <87ftkzdpjd.fsf_-_@x220.int.ebiederm.org>
 <20190920230247.GA6449@lenoir>
 <87k19vyggy.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k19vyggy.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 08:49:17PM -0500, Eric W. Biederman wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > On Sat, Sep 14, 2019 at 07:35:02AM -0500, Eric W. Biederman wrote:
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index 69015b7c28da..668262806942 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -3857,7 +3857,11 @@ static void __sched notrace __schedule(bool preempt)
> >>  
> >>  	if (likely(prev != next)) {
> >>  		rq->nr_switches++;
> >> -		rq->curr = next;
> >> +		/*
> >> +		 * RCU users of rcu_dereference(rq->curr) may not see
> >> +		 * changes to task_struct made by pick_next_task().
> >> +		 */
> >> +		RCU_INIT_POINTER(rq->curr, next);
> >
> > It would be nice to have more explanations in the comments as to why we
> > don't use rcu_assign_pointer() here (the very fast-path issue) and why
> > it is expected to be fine (the rq_lock() + post spinlock barrier) under
> > which condition. Some short summary of the changelog. Because that line
> > implies way too many subtleties.
> 
> Crucially that line documents the standard rules don't apply,
> and it documents which guarantees a new user of the code can probably
> count on.  I say probably because the comment may go stale before I new
> user of rcu appears.  I have my hopes things are simple enough at that
> location that if the comment needs to be changed it can be.

At least I can't understand that line without referring to the changelog.

> 
> If it is not obvious from reading the code that calls
> "task_rcu_dereference(rq->curr)" now "rcu_dereference(rq->curr)" why we
> don't need the guarantees from rcu_assign_pointet() my sense is that
> it should be those locations that document what guarantees they need.

Both sides should probably have comments.

> 
> Of the several different locations that use this my sense is that they
> all have different requirements.
> 
> - The rcuwait code just needs the lifetime change as it never dereferences
>   rq->curr.
> 
> - The membarrier code just looks at rq->curr->mm for a moment so it
>   hardly needs anything.  I suspect we might be able to make the rcu
>   critical section smaller in that code.
> 
> - I don't know the code in task_numa_compare() well enough even to make an
>   educated guess.  Peter asserts (if I read his reply correctly) it is
>   all just a heuristic so stale values should not matter.
> 
>   My reading of the code strongly suggests that we have the ordinary
>   rcu_assign_pointer() guarantees there.  The few fields that are not
>   covered by the ordinary guarantees do not appear to be read.  So even
>   if Peter is wrong RCU_INIT_POINTER appears safe to me.
> 
>   I also don't think we will have confusion with people reading the
>   code and expecting ordinary rcu_dereference semantics().
> 
> I can't possibly see putting the above several lines in a meaningful
> comment where RCU_INIT_POINTER is called.  Especially in a comment
> that will survive changes to any of those functions.  My experience
> is comments that try that are almost always overlooked when someone
> updates the code.

That's ok, it's the nature of comments, they get out of date. But at
least they provide a link to history so we can rewind to find the initial
how and why for a tricky line.

I bet nobody wants git blame as a base for their text editors.

> 
> I barely found all of the comments that depended upon the details of
> task_rcu_dereference and updated them in my patchset, when I removed
> the need for task_rcu_dereference.
> 
> I don't think it would be wise to put a comment that is a wall of words
> in the middle of __schedule().  I think it will become inaccurate with
> time and because it is a lot of words I think it will be ignored.
> 
> 
> As for the __schedule: It is the heart of the scheduler.  It is
> performance code.  It is clever code.  It is likely to stay that way
> because it is the scheduler.  There are good technical reasons for the
> code is the way it is, and anyone changing the scheduler in a
> responsible manner that includes benchmarking should find those
> technical reasons quickly enough.
> 
> 
> So I think a quick word to the wise is enough.  Comments are certainly
> not enough to prevent people being careless and making foolish mistakes.

Well it's not even about preventing anything, it's only about making
a line of cryptic code understandable for reviewers. No need for thorough
details, indeed anyone making use of that code or modifying it has to dive
into the deep guts anyway.

So how about that:

/*
 * Avoid rcu_dereference() in this very fast path.
 * Instead rely on full barrier implied by rq_lock() + smp_mb__after_spinlock().
 * Warning: In-between writes may be missed by readers (eg: pick_next_task())
 */

Thanks.
