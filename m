Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E29DD6D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 08:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbfH0GIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 02:08:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42189 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfH0GIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 02:08:10 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2UeF-0002xs-2y; Tue, 27 Aug 2019 08:08:07 +0200
Date:   Tue, 27 Aug 2019 08:08:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 38/38] posix-cpu-timers: Utilize timerqueue for
 storage
In-Reply-To: <20190827004846.GM14309@lenoir>
Message-ID: <alpine.DEB.2.21.1908270807080.1939@nanos.tec.linutronix.de>
References: <20190821190847.665673890@linutronix.de> <20190821192922.835676817@linutronix.de> <20190827004846.GM14309@lenoir>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019, Frederic Weisbecker wrote:

> On Wed, Aug 21, 2019 at 09:09:25PM +0200, Thomas Gleixner wrote:
> >  /**
> > @@ -92,14 +130,10 @@ struct posix_cputimers {
> >  
> >  static inline void posix_cputimers_init(struct posix_cputimers *pct)
> >  {
> > -	pct->timers_active = 0;
> > -	pct->expiry_active = 0;
> 
> No more need to initialize these?
> 
> > +	memset(pct->bases, 0, sizeof(pct->bases));

memset() does that IIRC :)

> >  	pct->bases[0].nextevt = U64_MAX;
> >  	pct->bases[1].nextevt = U64_MAX;
> >  	pct->bases[2].nextevt = U64_MAX;
> > -	INIT_LIST_HEAD(&pct->bases[0].cpu_timers);
> > -	INIT_LIST_HEAD(&pct->bases[1].cpu_timers);
> > -	INIT_LIST_HEAD(&pct->bases[2].cpu_timers);
> >  }
> 
> [...]
> 
> > @@ -393,15 +395,15 @@ static int posix_cpu_timer_del(struct k_
> >  	sighand = lock_task_sighand(p, &flags);
> >  	if (unlikely(sighand == NULL)) {
> >  		/*
> > -		 * We raced with the reaping of the task.
> > -		 * The deletion should have cleared us off the list.
> > +		 * This raced with the reaping of the task. The exit cleanup
> > +		 * should have removed this timer from the timer queue.
> >  		 */
> > -		WARN_ON_ONCE(!list_empty(&timer->it.cpu.entry));
> > +		WARN_ON_ONCE(ctmr->head || timerqueue_node_queued(&ctmr->node));
> 
> Should we clear ctmr->head upon cleanup_timerqueue() ?

Probably.
 
