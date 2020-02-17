Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41145161DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 00:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgBQXKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 18:10:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgBQXKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 18:10:45 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D6620725;
        Mon, 17 Feb 2020 23:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581981045;
        bh=IlqVkbwn4RNuULuX2RYl0Y7FZw236aKOJdaJutAiaQ0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=n/6vnVzMGQwVLBp4PNaPUzcfn77ztU9CwSpfl5XJL0vJ4cTHwnacI3VbELAnLKp39
         37cAD9Jnq2h/Lhu6BqQ1V4R1gbnzKi1612RVqQ7m2BM8vVaU5/qTpKm40hXgikLAec
         rCOFLdOKMOEtgccwHKpHKxVpNxN6XUKSekTwub1Y=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0D6E335227A8; Mon, 17 Feb 2020 15:10:45 -0800 (PST)
Date:   Mon, 17 Feb 2020 15:10:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, Jules Irenge <jbi.octave@gmail.com>
Subject: Re: [PATCH tip/core/rcu 2/3] rcu: Add missing annotation for
 exit_tasks_rcu_start()
Message-ID: <20200217231045.GA2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200215002446.GA15663@paulmck-ThinkPad-P72>
 <20200215002520.15746-2-paulmck@kernel.org>
 <20200217144452.GA145700@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217144452.GA145700@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 09:44:52AM -0500, Joel Fernandes wrote:
> On Fri, Feb 14, 2020 at 04:25:19PM -0800, paulmck@kernel.org wrote:
> > From: Jules Irenge <jbi.octave@gmail.com>
> > 
> > Sparse reports a warning at exit_tasks_rcu_start(void)
> > 
> > |warning: context imbalance in exit_tasks_rcu_start() - wrong count at exit
> > 
> > To fix this, this commit adds an __acquires(&tasks_rcu_exit_srcu).
> > Given that exit_tasks_rcu_start() does actually call __srcu_read_lock(),
> > this not only fixes the warning but also improves on the readability of
> > the code.
> 
> For patch 1/3 and 2/3:
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Applied, thank you!

> Though IMO it would be good to squash both the patches.

Fair point, but I will leave them be.  ;-)

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/update.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > index a27df76..a04fe54 100644
> > --- a/kernel/rcu/update.c
> > +++ b/kernel/rcu/update.c
> > @@ -801,7 +801,7 @@ static int __init rcu_spawn_tasks_kthread(void)
> >  core_initcall(rcu_spawn_tasks_kthread);
> >  
> >  /* Do the srcu_read_lock() for the above synchronize_srcu().  */
> > -void exit_tasks_rcu_start(void)
> > +void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
> >  {
> >  	preempt_disable();
> >  	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
> > -- 
> > 2.9.5
> > 
