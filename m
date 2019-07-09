Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A029B6372B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 15:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfGINmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 09:42:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38640 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGINmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iqcAiKYT4gA3rRqHSRay8KcZmspIO/HAMHELnfctPNU=; b=C6E2IXvkLucSzRjvmxW7AvezT
        hHZ5tFdWyohw28iCmr6u2OXylUVkQUrZmjM6R/jrTFLAEnRXriRt/usru/tjwIyOOonfGh5MAyB78
        KGUVmMHeDMCPlzhv+Omayd9frO6RLyW4aEre6eXMj1dmkK3XFrYBhOG43dYzbOHMoWzG5asjZ5MC7
        85zoPE6/T5asqQIlJd1PgoNL5Yim5xfnZwBkXifRttu5wQ+APhLv5/C/lx5lOPJalW6+vWFyEF5VC
        a0+vKLU6KsiFdjmUcyZlja8oIDMrXoKHcM8BLdOR1Mw3OMrjaA1z2pDYu1KMt14C5ku/ETglE0UJC
        5ehwBatvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkqNf-0006sb-Sv; Tue, 09 Jul 2019 13:42:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 247A520976D63; Tue,  9 Jul 2019 15:42:00 +0200 (CEST)
Date:   Tue, 9 Jul 2019 15:42:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC PATCH 3/6] sched/dl: Try better placement even for deadline
 tasks that do not block
Message-ID: <20190709134200.GD3402@hirez.programming.kicks-ass.net>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-4-luca.abeni@santannapisa.it>
 <20190708135536.GK3402@hirez.programming.kicks-ass.net>
 <20190709152436.51825f98@luca64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709152436.51825f98@luca64>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 03:24:36PM +0200, luca abeni wrote:
> Hi Peter,
> 
> On Mon, 8 Jul 2019 15:55:36 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, May 06, 2019 at 06:48:33AM +0200, Luca Abeni wrote:
> > > @@ -1223,8 +1250,17 @@ static void update_curr_dl(struct rq *rq)
> > >  			dl_se->dl_overrun = 1;
> > >  
> > >  		__dequeue_task_dl(rq, curr, 0);
> > > -		if (unlikely(dl_se->dl_boosted
> > > || !start_dl_timer(curr)))
> > > +		if (unlikely(dl_se->dl_boosted
> > > || !start_dl_timer(curr))) { enqueue_task_dl(rq, curr,
> > > ENQUEUE_REPLENISH); +#ifdef CONFIG_SMP
> > > +		} else if (dl_se->dl_adjust) {
> > > +			if (rq->migrating_task == NULL) {
> > > +				queue_balance_callback(rq,
> > > &per_cpu(dl_migrate_head, rq->cpu), migrate_dl_task);  
> > 
> > I'm not entirely sure about this one.
> > 
> > That is, we only do those callbacks from:
> > 
> >   schedule_tail()
> >   __schedule()
> >   rt_mutex_setprio()
> >   __sched_setscheduler()
> > 
> > and the above looks like it can happen outside of those.
> 
> Sorry, I did not know the constraints or requirements for using
> queue_balance_callback()...
> 
> I used it because I wanted to trigger a migration from
> update_curr_dl(), but invoking double_lock_balance() from this function
> obviously resulted in a warning. So, I probably misunderstood the
> purpose of the balance callback API, and I misused it.
> 
> What would have been the "right way" to trigger a migration for a task
> when it is throttled?

I'm thinking we'll end up in schedule() pretty soon after a throttle to
make 'current' go away, right? We could put the queue_balance_callback()
in dequeue_task_dl() or something.
