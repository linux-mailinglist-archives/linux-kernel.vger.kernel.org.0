Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C8D18FC76
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 19:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgCWSKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 14:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbgCWSKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:10:11 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A09E32072D;
        Mon, 23 Mar 2020 18:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584987010;
        bh=ZxtzdYe1aySc/6Zcb6xeiWHSi3BhCPzFQ2KAylMKIZk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bRusqA49OlMA7lZIKSsJ2ujROUYz5EoGJkPgKqB6RugLyf6F0HRjIxIPJLBf8vuWy
         D/g7cuyJAh8X2mEKV8YfxBESIIbx4F1ApLmEdaGSFFYYlab6RE60nZrS0i2NgDCCiI
         zrJ9sPqn7WSTrP1EZVHqdLxm9GdeZZvqzVrKiKVY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7318335226E4; Mon, 23 Mar 2020 11:10:10 -0700 (PDT)
Date:   Mon, 23 Mar 2020 11:10:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Hit WARN_ON() in rcutorture.c:1055
Message-ID: <20200323181010.GN3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200323154309.nah44so2556ee56g@e107158-lin.cambridge.arm.com>
 <20200323155731.GK3199@paulmck-ThinkPad-P72>
 <20200323170609.w64xrfahd2snfz6h@e107158-lin.cambridge.arm.com>
 <20200323171751.GL3199@paulmck-ThinkPad-P72>
 <20200323174147.lneh4rp4tazhtm6x@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323174147.lneh4rp4tazhtm6x@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 05:41:48PM +0000, Qais Yousef wrote:
> On 03/23/20 10:17, Paul E. McKenney wrote:
> > On Mon, Mar 23, 2020 at 05:06:10PM +0000, Qais Yousef wrote:
> > > On 03/23/20 08:57, Paul E. McKenney wrote:
> > > > On Mon, Mar 23, 2020 at 03:43:09PM +0000, Qais Yousef wrote:
> > > > > Hi
> > > > > 
> > > > > I hit the following warning while running rcutorture tests. It only happens
> > > > > when I try to hibernate the system (arm64 Juno-r2).
> > > > 
> > > > Hibernating the system during rcutorture tests.  Now that is gutsy!  ;-)
> > > 
> > > Hehe was just a side effect of testing the cpu hotplug stuff :-)
> > > 
> > > > 
> > > > > Let me know if you need additional info.
> > > > 
> > > > 1.	Do you need this to work?  If so, please tell me your use case.
> > > 
> > > Nope. It just happened while trying to stress the cpu hotplug series I just
> > > posted.
> > > 
> > > > 2.	What is line 1055 of your rcutorture.c?  Here is my guess:
> > > 
> > > It's 5.6-rc6, sorry should have mentioned in the report.
> > > 
> > > 		/* Cycle through nesting levels of rcu_expedite_gp() calls. */
> > > 		if (can_expedite &&
> > > 		    !(torture_random(&rand) & 0xff & (!!expediting - 1))) {
> > > 			WARN_ON_ONCE(expediting == 0 && rcu_gp_is_expedited());
> > > 			if (expediting >= 0)
> > > 				rcu_expedite_gp();
> > > 			else
> > > 				rcu_unexpedite_gp();
> > > 			if (++expediting > 3)
> > > 				expediting = -expediting;
> > > 		} else if (!can_expedite) { /* Disabled during boot, recheck. */
> > > 
> > > If it's something you don't care about, then I don't care about too. I just
> > > thought I'd report it in case it uncovered something worthwhile.
> > 
> > Well, my guess was wrong.  ;-)
> > 
> > This is instead rcutorture being surprised by the fact that RCU grace
> > periods are expedited during the hibernate process.  I could fix this
> > particular situation, but I bet that there are a number of others,
> > including my guess above.
> > 
> > One approach would be to halt rcutorture testing just before hibernating
> > and restart it just after resuming.
> > 
> > Thoughts?
> 
> {register, unregister}_pm_notifier() don't seem to be too hard to use.

That part is easy.  It would also be necessary to find all the affected
warnings in rcutorture and suppress them, not only during this time,
but also for some period of time afterwards.  Maybe this is the only one,
but that would be surprising.  ;-)

> But if it's not that simple, then it's not worthwhile I'd say. The report
> lives in LKML as a documentation of this missing support :-P

It might at some point be necessary for rcutorture to handle suspends
and hibernates in midstream, and yes, it could be done, but first I need
to see some reason why it provides significant help.

							Thanx, Paul
