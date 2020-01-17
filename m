Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 932FF1409BC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 13:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgAQMbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 07:31:22 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48402 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgAQMbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y7OrUKG84IY0L+tBNGtZ0PesKvrqAKx1boCrDm3c8aI=; b=aCfGSOvcFxmK5voqdOHyS7LwQ
        d6/wkVWqxbLNG/EW5oQidIwEV53Be3pazDy5aB/p87ZdU7G8EKWv93VV1fq8es4jVTFDNXFfEi7Jc
        7EoJkzlvlprHHNz1gyKk4odSdWvGevq0oowcsvhMWY/Yu7hWsFwHV21DLfoebPqSitaBFJ1aCWilj
        vDrgf1a8jZaEMc208qKbRiGuVr8gg4gOxVfUoIol5xtN7JRNPUw0zBBCj6dPkVOju6ELFHnYDFyqm
        vdlDyAa2R9fiyqu4kju8Qh0xrgov8SSP6SF/AZou9yai3dd/bYFYRLlhQlJtXzo1hQCd3q49ho+rv
        z1RWFn8IQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isQmI-0006vH-5F; Fri, 17 Jan 2020 12:31:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A10B1300F4B;
        Fri, 17 Jan 2020 13:29:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C89162020D908; Fri, 17 Jan 2020 13:31:03 +0100 (CET)
Date:   Fri, 17 Jan 2020 13:31:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com,
        kernel-team@android.com
Subject: Re: [Patch v8 4/7] sched/fair: Enable periodic update of average
 thermal pressure
Message-ID: <20200117123103.GB14879@hirez.programming.kicks-ass.net>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-5-git-send-email-thara.gopinath@linaro.org>
 <20200116151502.GQ2827@hirez.programming.kicks-ass.net>
 <20200117114045.GA219309@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117114045.GA219309@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 11:40:45AM +0000, Quentin Perret wrote:
> On Thursday 16 Jan 2020 at 16:15:02 (+0100), Peter Zijlstra wrote:
> > > @@ -10275,6 +10281,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
> > >  {
> > >  	struct cfs_rq *cfs_rq;
> > >  	struct sched_entity *se = &curr->se;
> > > +	unsigned long thermal_pressure = arch_cpu_thermal_pressure(cpu_of(rq));
> > >  
> > >  	for_each_sched_entity(se) {
> > >  		cfs_rq = cfs_rq_of(se);
> > > @@ -10286,6 +10293,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
> > >  
> > >  	update_misfit_status(curr, rq);
> > >  	update_overutilized_status(task_rq(curr));
> > > +	update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
> > >  }
> > 
> > I'm thinking this is the wrong place; should this not be in
> > scheduler_tick(), right before calling sched_class::task_tick() ? Surely
> > any execution will affect thermals, not only fair class execution.
> 
> Right, but right now only CFS takes action when we overheat. That is,
> only CFS uses capacity_of() which is where the thermal signal gets
> reflected.

Sure, but we should still track the thermals unconditionally, even if
only CFS consumes it.

> We definitely could (and maybe should) make RT and DL react to thermal
> pressure as well when they're both capacity-aware. But perhaps that's
> for later ? Thoughts ?

Yeah, that's later head-aches. Even determining what to do there, except
panic() is going to be 'interesting'.
