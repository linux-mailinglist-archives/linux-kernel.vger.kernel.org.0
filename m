Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 240AC163992
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 02:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgBSBsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 20:48:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbgBSBsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:48:53 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAE0524654;
        Wed, 19 Feb 2020 01:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582076931;
        bh=jHP0jc8ZveGDUmMSCOUaHBQdMWzeqy4r4osM0AUbe7I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uJzJNiSGMJcopQUCcyMLao3w9RpheF4zsJ6Kie0KIxr+Z2DDHoj4jqVKp7yj638bG
         IMw8CVmYFFp7r2jj521OGV8yHpdcZ4zn6uJpDqRRuR/657XEQxDtAsEguqz37t+RX4
         A+sPRds7GKSYUGreAFltwhCvXZIZ058EZveRcuJc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 86A3C3520856; Tue, 18 Feb 2020 17:48:51 -0800 (PST)
Date:   Tue, 18 Feb 2020 17:48:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 1/3] rcu-tasks: *_ONCE() for
 rcu_tasks_cbs_head
Message-ID: <20200219014851.GQ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200217181615.GP2935@paulmck-ThinkPad-P72>
 <20200218075648.GW14914@hirez.programming.kicks-ass.net>
 <20200218162719.GE2935@paulmck-ThinkPad-P72>
 <20200218201142.GF11457@worktop.programming.kicks-ass.net>
 <20200218202226.GJ2935@paulmck-ThinkPad-P72>
 <20200218174503.3d4e4750@gandalf.local.home>
 <20200218225455.GN2935@paulmck-ThinkPad-P72>
 <20200219000144.GA26663@google.com>
 <20200219001640.GP2935@paulmck-ThinkPad-P72>
 <20200219011359.GA29762@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219011359.GA29762@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 08:13:59PM -0500, Joel Fernandes wrote:
> On Tue, Feb 18, 2020 at 04:16:40PM -0800, Paul E. McKenney wrote:
> > On Tue, Feb 18, 2020 at 07:01:44PM -0500, Joel Fernandes wrote:
> > > On Tue, Feb 18, 2020 at 02:54:55PM -0800, Paul E. McKenney wrote:
> > > > On Tue, Feb 18, 2020 at 05:45:03PM -0500, Steven Rostedt wrote:
> > > > > On Tue, 18 Feb 2020 12:22:26 -0800
> > > > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > > 
> > > > > > On Tue, Feb 18, 2020 at 09:11:42PM +0100, Peter Zijlstra wrote:
> > > > > > > On Tue, Feb 18, 2020 at 08:27:19AM -0800, Paul E. McKenney wrote:  
> > > > > > > > On Tue, Feb 18, 2020 at 08:56:48AM +0100, Peter Zijlstra wrote:  
> > > > > > >   
> > > > > > > > > I just took offence at the Changelog wording. It seems to suggest there
> > > > > > > > > actually is a problem, there is not.  
> > > > > > > > 
> > > > > > > > Quoting the changelog: "Not appropriate for backporting due to failure
> > > > > > > > being unlikely."  
> > > > > > > 
> > > > > > > That implies there is failure, however unlikely.
> > > > > > > 
> > > > > > > In this particular case there is absolutely no failure, except perhaps
> > > > > > > in KCSAN. This patch is a pure annotation such that KCSAN can understand
> > > > > > > the code.
> > > > > > > 
> > > > > > > Like said, I don't object to the actual patch, but I do think it is
> > > > > > > important to call out false negatives or to describe the actual problem
> > > > > > > found.  
> > > > > > 
> > > > > > I don't feel at all comfortable declaring that there is absolutely
> > > > > > no possibility of failure.
> > > > > 
> > > > > Perhaps wording it like so:
> > > > > 
> > > > > "There's know known issue with the current code, but the *_ONCE()
> > > > > annotations here makes KCSAN happy, allowing us to focus on KCSAN
> > > > > warnings that can help bring about known issues in other code that we
> > > > > can fix, without being distracted by KCSAN warnings that we do not see
> > > > > a problem with."
> > > > > 
> > > > > ?
> > > > 
> > > > That sounds more like something I might put in rcutodo.html as a statement
> > > > of the RCU approach to KCSAN reports.
> > > > 
> > > > But switching to a different situation (for variety, if nothing else),
> > > > what about the commit shown below?
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > commit 35bc02b04a041f32470ae6d959c549bcce8483db
> > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > Date:   Tue Feb 18 13:41:02 2020 -0800
> > > > 
> > > >     rcutorture: Mark data-race potential for rcu_barrier() test statistics
> > > >     
> > > >     The n_barrier_successes, n_barrier_attempts, and
> > > >     n_rcu_torture_barrier_error variables are updated (without access
> > > >     markings) by the main rcu_barrier() test kthread, and accessed (also
> > > >     without access markings) by the rcu_torture_stats() kthread.  This of
> > > >     course can result in KCSAN complaints.
> > > >     
> > > >     Because the accesses are in diagnostic prints, this commit uses
> > > >     data_race() to excuse the diagnostic prints from the data race.  If this
> > > >     were to ever cause bogus statistics prints (for example, due to store
> > > >     tearing), any misleading information would be disambiguated by the
> > > >     presence or absence of an rcutorture splat.
> > > >     
> > > >     This data race was reported by KCSAN.  Not appropriate for backporting
> > > >     due to failure being unlikely and due to the mild consequences of the
> > > >     failure, namely a confusing rcutorture console message.
> > > >     
> > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > 
> > > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > > index 5453bd5..b3301f3 100644
> > > > --- a/kernel/rcu/rcutorture.c
> > > > +++ b/kernel/rcu/rcutorture.c
> > > > @@ -1444,9 +1444,9 @@ rcu_torture_stats_print(void)
> > > >  		atomic_long_read(&n_rcu_torture_timers));
> > > >  	torture_onoff_stats();
> > > >  	pr_cont("barrier: %ld/%ld:%ld\n",
> > > > -		n_barrier_successes,
> > > > -		n_barrier_attempts,
> > > > -		n_rcu_torture_barrier_error);
> > > > +		data_race(n_barrier_successes),
> > > > +		data_race(n_barrier_attempts),
> > > > +		data_race(n_rcu_torture_barrier_error));
> > > 
> > > Would it be not worth just fixing the data-race within rcutorture itself?
> > 
> > I could use WRITE_ONCE() for updates and READ_ONCE() for statistics.
> > However, my current rule is that diagnostic code that is not participating
> > in the core synchronization uses data_race().  That way, if I do a typo
> > and write to (say) n_barrier_attempts in some other thread, KCSAN will
> > know to yell at me.
> 
> Oh, ok. That makes sense.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Applied, thank you!

							Thanx, Paul
