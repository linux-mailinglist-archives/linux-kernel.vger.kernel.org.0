Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDDCC2507
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 18:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbfI3QYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 12:24:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfI3QYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:24:07 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B415F18CB8ED;
        Mon, 30 Sep 2019 16:24:06 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DFF119C6A;
        Mon, 30 Sep 2019 16:24:00 +0000 (UTC)
Message-ID: <9acc5f1bd0fe06acb2b7b518c5ef1f082e89ad63.camel@redhat.com>
Subject: Re: [PATCH RT 5/8] sched/deadline: Reclaim cpuset bandwidth in
 .migrate_task_rq()
From:   Scott Wood <swood@redhat.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Mon, 30 Sep 2019 11:24:00 -0500
In-Reply-To: <20190930071233.GE31660@localhost.localdomain>
References: <20190727055638.20443-1-swood@redhat.com>
         <20190727055638.20443-6-swood@redhat.com>
         <20190927081141.GB31660@localhost.localdomain>
         <9a4cc499e6de4690c682c03c0c880363fe3c9307.camel@redhat.com>
         <20190930071233.GE31660@localhost.localdomain>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Mon, 30 Sep 2019 16:24:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-30 at 09:12 +0200, Juri Lelli wrote:
> On 27/09/19 11:40, Scott Wood wrote:
> > On Fri, 2019-09-27 at 10:11 +0200, Juri Lelli wrote:
> > > Hi Scott,
> > > 
> > > On 27/07/19 00:56, Scott Wood wrote:
> > > > With the changes to migrate disabling, ->set_cpus_allowed() no
> > > > longer
> > > > gets deferred until migrate_enable().  To avoid releasing the
> > > > bandwidth
> > > > while the task may still be executing on the old CPU, move the
> > > > subtraction
> > > > to ->migrate_task_rq().
> > > > 
> > > > Signed-off-by: Scott Wood <swood@redhat.com>
> > > > ---
> > > >  kernel/sched/deadline.c | 67 +++++++++++++++++++++++---------------
> > > > ----
> > > > -------
> > > >  1 file changed, 31 insertions(+), 36 deletions(-)
> > > > 
> > > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > > > index c18be51f7608..2f18d0cf1b56 100644
> > > > --- a/kernel/sched/deadline.c
> > > > +++ b/kernel/sched/deadline.c
> > > > @@ -1606,14 +1606,42 @@ static void yield_task_dl(struct rq *rq)
> > > >  	return cpu;
> > > >  }
> > > >  
> > > > +static void free_old_cpuset_bw_dl(struct rq *rq, struct task_struct
> > > > *p)
> > > > +{
> > > > +	struct root_domain *src_rd = rq->rd;
> > > > +
> > > > +	/*
> > > > +	 * Migrating a SCHED_DEADLINE task between exclusive
> > > > +	 * cpusets (different root_domains) entails a bandwidth
> > > > +	 * update. We already made space for us in the destination
> > > > +	 * domain (see cpuset_can_attach()).
> > > > +	 */
> > > > +	if (!cpumask_intersects(src_rd->span, p->cpus_ptr)) {
> > > > +		struct dl_bw *src_dl_b;
> > > > +
> > > > +		src_dl_b = dl_bw_of(cpu_of(rq));
> > > > +		/*
> > > > +		 * We now free resources of the root_domain we are
> > > > migrating
> > > > +		 * off. In the worst case, sched_setattr() may
> > > > temporary
> > > > fail
> > > > +		 * until we complete the update.
> > > > +		 */
> > > > +		raw_spin_lock(&src_dl_b->lock);
> > > > +		__dl_sub(src_dl_b, p->dl.dl_bw,
> > > > dl_bw_cpus(task_cpu(p)));
> > > > +		raw_spin_unlock(&src_dl_b->lock);
> > > > +	}
> > > > +}
> > > > +
> > > >  static void migrate_task_rq_dl(struct task_struct *p, int new_cpu
> > > > __maybe_unused)
> > > >  {
> > > >  	struct rq *rq;
> > > >  
> > > > -	if (p->state != TASK_WAKING)
> > > > +	rq = task_rq(p);
> > > > +
> > > > +	if (p->state != TASK_WAKING) {
> > > > +		free_old_cpuset_bw_dl(rq, p);
> > > 
> > > What happens if a DEADLINE task is moved between cpusets while it was
> > > sleeping? Don't we miss removing from the old cpuset if the task gets
> > > migrated on wakeup?
> > 
> > In that case set_task_cpu() is called by ttwu after setting state to
> > TASK_WAKING.
> 
> Right.
> 
> > I guess it could be annoying if the task doesn't wake up for a
> > long time and therefore doesn't release the bandwidth until then.
> 
> Hummm, I was actually more worried about the fact that we call free_old_
> cpuset_bw_dl() only if p->state != TASK_WAKING.

Oh, right. :-P  Not sure what I had in mind there; we want to call it
regardless.

I assume we need rq->lock in free_old_cpuset_bw_dl()?  So something like
this:

	if (p->state == TASK_WAITING)
		raw_spin_lock(&rq->lock);
	free_old_cpuset_bw_dl(rq, p);
	if (p->state != TASK_WAITING)
		return;

	if (p->dl.dl_non_contending) {
	....	

BTW, is the full cpumask_intersects() necessary or would it suffice to see
that the new cpu is not in the old span?

-Scott


