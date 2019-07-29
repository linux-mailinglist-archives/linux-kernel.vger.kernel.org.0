Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D31E178A41
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 13:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbfG2LP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 07:15:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387565AbfG2LPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iRguG2CZusyFDzgShkGspQeon0LR1kv8Se6OmN4lTgo=; b=r9LLI6KpwoFwIA7MpizL4+Htm
        bnPXnf4oOUj2Moaj7/hN3pdND5+PxyqJMUil299UJTV67gVxGk2IkHpmDfXVwHO55OfshfxIyOhJ8
        LSqj0sfbQDw8vteGHcAgUQnb+2BzWLTg944fa1Zu+/aJiv+Rgs63PmqzNkloMTDhA5qacDG8P0akd
        VM4RSy5Mnx+3m4aYrYohokk20mfCzjainF5MUmo/K8u6nMO2t/vZ7oN4XRm1DumXsIpu8QugEhd1s
        wBrthAkhGIhK8oIDtsjUgzroA4jvMP/eTiONyUULfykeSWE52QrNFTe4lo2JJYZ+szuv871eSOU6g
        KMdUorRig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs3cV-0001G5-Np; Mon, 29 Jul 2019 11:15:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B63820B516F5; Mon, 29 Jul 2019 13:15:10 +0200 (CEST)
Date:   Mon, 29 Jul 2019 13:15:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 04/13] sched/{rt,deadline}: Fix set_next_task vs
 pick_next_task
Message-ID: <20190729111510.GD31398@hirez.programming.kicks-ass.net>
References: <20190726145409.947503076@infradead.org>
 <20190726161357.579899041@infradead.org>
 <20190729092519.GR25636@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729092519.GR25636@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:25:19AM +0200, Juri Lelli wrote:
> Hi,
> 
> On 26/07/19 16:54, Peter Zijlstra wrote:
> > Because pick_next_task() implies set_curr_task() and some of the
> > details haven't matter too much, some of what _should_ be in
> > set_curr_task() ended up in pick_next_task, correct this.
> > 
> > This prepares the way for a pick_next_task() variant that does not
> > affect the current state; allowing remote picking.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/sched/deadline.c |   23 ++++++++++++-----------
> >  kernel/sched/rt.c       |   27 ++++++++++++++-------------
> >  2 files changed, 26 insertions(+), 24 deletions(-)
> > 
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1694,12 +1694,21 @@ static void start_hrtick_dl(struct rq *r
> >  }
> >  #endif
> >  
> > -static inline void set_next_task(struct rq *rq, struct task_struct *p)
> > +static void set_next_task_dl(struct rq *rq, struct task_struct *p)
> >  {
> >  	p->se.exec_start = rq_clock_task(rq);
> >  
> >  	/* You can't push away the running task */
> >  	dequeue_pushable_dl_task(rq, p);
> > +
> > +	if (hrtick_enabled(rq))
> > +		start_hrtick_dl(rq, p);
> > +
> > +	if (rq->curr->sched_class != &dl_sched_class)
> > +		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
> > +
> > +	if (rq->curr != p)
> > +		deadline_queue_push_tasks(rq);
> 
> It's a minor thing, but I was wondering why you added the check on curr.
> deadline_queue_push_tasks() already checks if are there pushable tasks,
> plus curr can still be of a different class at this point?

Hmm, so by moving that code into set_next_task() it is exposed to the:

  if (queued)
    deuque_task();
  if (running)
    put_prev_task();

  /* do stuff */

  if (queued)
    enqueue_task();
  if (running)
    set_next_task();

patter from core.c; and in that case nothing changes. That said; I
might've gotten it wrong.
