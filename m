Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02FEDCAEED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 21:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbfJCTJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 15:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733123AbfJCTJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:09:21 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C29EA215EA;
        Thu,  3 Oct 2019 19:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570129761;
        bh=HFi3I65GwEm7kiohh7XNT2J0aSZcJBD0h9Xxh8cjLD4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=1ho5YsHjFBe38K3RGlEG8jkJX77M01SzhaIXiQk/0j5ofvmpsMTTU5GLn7wkQVnbN
         q6JJO4iYhfRnD7XfERbe/nXt2dNMNHHFIcqBAXx1RHKcnE293EGM3JD5qE6luYuLJH
         MwI/ziWrQlR4lj09VXFPlsV1SwO4lm1l4C3UAQcU=
Date:   Thu, 3 Oct 2019 12:09:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Shane M Seymour <shane.seymour@hpe.com>,
        Martin <martin.petersen@oracle.com>
Subject: Re: [PATCH tip/core/rcu 1/9] rcu: Upgrade rcu_swap_protected() to
 rcu_replace()
Message-ID: <20191003190919.GA2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191003014153.GA13156@paulmck-ThinkPad-P72>
 <20191003014310.13262-1-paulmck@kernel.org>
 <644598334.955.1570120530976.JavaMail.zimbra@efficios.com>
 <20191003165220.GZ2689@paulmck-ThinkPad-P72>
 <618064891.1049.1570123274780.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <618064891.1049.1570123274780.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 01:21:14PM -0400, Mathieu Desnoyers wrote:
> ----- On Oct 3, 2019, at 12:52 PM, paulmck paulmck@kernel.org wrote:
> 
> > On Thu, Oct 03, 2019 at 12:35:30PM -0400, Mathieu Desnoyers wrote:
> >> ----- On Oct 2, 2019, at 9:43 PM, paulmck paulmck@kernel.org wrote:
> >> 
> >> > From: "Paul E. McKenney" <paulmck@kernel.org>
> >> > 
> >> > Although the rcu_swap_protected() macro follows the example of swap(),
> >> > the interactions with RCU make its update of its argument somewhat
> >> > counter-intuitive.  This commit therefore introduces an rcu_replace()
> >> > that returns the old value of the RCU pointer instead of doing the
> >> > argument update.  Once all the uses of rcu_swap_protected() are updated
> >> > to instead use rcu_replace(), rcu_swap_protected() will be removed.
> >> 
> >> We expose the rcu_xchg_pointer() API in liburcu (Userspace RCU) project.
> >> Any reason for not going that way and keep the kernel and user-space RCU
> >> APIs alike ?
> >> 
> >> It's of course fine if they diverge, but we might want to at least consider
> >> if using the same API name would be OK.
> > 
> > Different semantics.  An rcu_xchg_pointer() allows concurrent updates,
> > and rcu_replace() does not.
> > 
> > But yes, if someone needs the concurrent updates, rcu_xchg_pointer()
> > would certainly be my choice for the name.
> 
> Then considering that its assignment counterpart is "rcu_assign_pointer()"
> (and not "rcu_assign()"), would "rcu_replace_pointer()" be less ambiguous
> about its intended use ?

The sequence was rcu_swap_protected() -> rcu_swap() -> rcu_replace().
Because that rcu_replace(), unlike rcu_swap_protected(), returns a
value, the shorter name is valuable.

Maybe we should have used rcu_assign() instead of rcu_assign_pointer(),
but there is no point in that sort of change at this late date!

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> 
> > 
> >							Thanx, Paul
> > 
> >> Thanks,
> >> 
> >> Mathieu
> >> 
> >> 
> >> > 
> >> > Link:
> >> > https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
> >> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> >> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >> > Cc: Bart Van Assche <bart.vanassche@wdc.com>
> >> > Cc: Christoph Hellwig <hch@lst.de>
> >> > Cc: Hannes Reinecke <hare@suse.de>
> >> > Cc: Johannes Thumshirn <jthumshirn@suse.de>
> >> > Cc: Shane M Seymour <shane.seymour@hpe.com>
> >> > Cc: Martin K. Petersen <martin.petersen@oracle.com>
> >> > ---
> >> > include/linux/rcupdate.h | 18 ++++++++++++++++++
> >> > 1 file changed, 18 insertions(+)
> >> > 
> >> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> >> > index 75a2ede..3b73287 100644
> >> > --- a/include/linux/rcupdate.h
> >> > +++ b/include/linux/rcupdate.h
> >> > @@ -383,6 +383,24 @@ do {									      \
> >> > } while (0)
> >> > 
> >> > /**
> >> > + * rcu_replace() - replace an RCU pointer, returning its old value
> >> > + * @rcu_ptr: RCU pointer, whose old value is returned
> >> > + * @ptr: regular pointer
> >> > + * @c: the lockdep conditions under which the dereference will take place
> >> > + *
> >> > + * Perform a replacement, where @rcu_ptr is an RCU-annotated
> >> > + * pointer and @c is the lockdep argument that is passed to the
> >> > + * rcu_dereference_protected() call used to read that pointer.  The old
> >> > + * value of @rcu_ptr is returned, and @rcu_ptr is set to @ptr.
> >> > + */
> >> > +#define rcu_replace(rcu_ptr, ptr, c)					\
> >> > +({									\
> >> > +	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
> >> > +	rcu_assign_pointer((rcu_ptr), (ptr));				\
> >> > +	__tmp;								\
> >> > +})
> >> > +
> >> > +/**
> >> >  * rcu_swap_protected() - swap an RCU and a regular pointer
> >> >  * @rcu_ptr: RCU pointer
> >> >  * @ptr: regular pointer
> >> > --
> >> > 2.9.5
> >> 
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> > > http://www.efficios.com
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
