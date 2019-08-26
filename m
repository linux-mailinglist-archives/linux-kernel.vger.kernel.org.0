Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC8E19D593
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 20:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbfHZSQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 14:16:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40911 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfHZSQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 14:16:07 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2JXA-0003Hh-A3; Mon, 26 Aug 2019 20:16:04 +0200
Date:   Mon, 26 Aug 2019 20:16:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 28/38] posix-cpu-timers: Restructure expiry array
In-Reply-To: <20190826163204.GA14309@lenoir>
Message-ID: <alpine.DEB.2.21.1908262014260.1939@nanos.tec.linutronix.de>
References: <20190821190847.665673890@linutronix.de> <20190821192921.895254344@linutronix.de> <20190826163204.GA14309@lenoir>
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

On Mon, 26 Aug 2019, Frederic Weisbecker wrote:
> On Wed, Aug 21, 2019 at 09:09:15PM +0200, Thomas Gleixner wrote:
> >  /**
> > - * task_cputimers_expired - Compare two task_cputime entities.
> > + * task_cputimers_expired - Check whether posix CPU timers are expired
> >   *
> >   * @samples:	Array of current samples for the CPUCLOCK clocks
> > - * @expiries:	Array of expiry values for the CPUCLOCK clocks
> > + * @pct:	Pointer to a posix_cputimers container
> >   *
> > - * Returns true if any mmember of @samples is greater than the corresponding
> > - * member of @expiries if that member is non zero. False otherwise
> > + * Returns true if any member of @samples is greater than the corresponding
> > + * member of @pct->bases[CLK].nextevt. False otherwise
> >   */
> > -static inline bool task_cputimers_expired(const u64 *sample, const u64 *expiries)
> > +static inline bool
> > +task_cputimers_expired(const u64 *sample, struct posix_cputimers *pct)
> >  {
> >  	int i;
> >  
> >  	for (i = 0; i < CPUCLOCK_MAX; i++) {
> > -		if (expiries[i] && sample[i] >= expiries[i])
> > +		if (sample[i] >= pct->bases[i].nextevt)
> 
> You may have false positive here if you don't check if pct->bases[i].nextevt
> is 0. Probably no big deal by the end of the series since you change that 0
> for KTIME_MAX later but right now it might hurt bisection with performance
> issues (locking sighand at every tick...).

Hrm. That should have stayed until the patch  which removes that 0 state

> [...]
> 
> > @@ -1176,7 +1182,7 @@ void run_posix_cpu_timers(void)
> >  void set_process_cpu_timer(struct task_struct *tsk, unsigned int clkid,
> >  			   u64 *newval, u64 *oldval)
> >  {
> > -	u64 now, *expiry = tsk->signal->posix_cputimers.expiries + clkid;
> > +	u64 now, *nextevt = &tsk->signal->posix_cputimers.bases[clkid].nextevt;
> 
> You're dereferencing the pointer before checking clkid sanity below.

Urgh. Yes.
 
Thanks,

	tglx
