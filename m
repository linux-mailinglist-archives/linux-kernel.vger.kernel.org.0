Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D07F3BB679
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 16:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732641AbfIWORQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 10:17:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58672 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbfIWORQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:17:16 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iCP9O-0006iw-Hk; Mon, 23 Sep 2019 16:17:14 +0200
Date:   Mon, 23 Sep 2019 16:17:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 6/6] posix-cpu-timers: Make PID=0 and PID=self handling
 consistent
In-Reply-To: <20190923141324.GB10778@lenoir>
Message-ID: <alpine.DEB.2.21.1909231615200.2003@nanos.tec.linutronix.de>
References: <20190905120339.561100423@linutronix.de> <20190905120540.162032542@linutronix.de> <20190923141324.GB10778@lenoir>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019, Frederic Weisbecker wrote:

> On Thu, Sep 05, 2019 at 02:03:45PM +0200, Thomas Gleixner wrote:
> > If the PID encoded into the clock id is 0 then the target is either the
> > calling thread itself or the process to which it belongs.
> > 
> > If the current thread encodes its own PID on a process wide clock then
> > there is no reason not to treat it in the same way as the PID=0 case.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  kernel/time/posix-cpu-timers.c |    9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > --- a/kernel/time/posix-cpu-timers.c
> > +++ b/kernel/time/posix-cpu-timers.c
> > @@ -90,7 +90,14 @@ static struct task_struct *lookup_task(c
> >  
> >  	} else {
> >  		/*
> > -		 * For processes require that p is group leader.
> > +		 * Timer is going to be attached to a process. If p is
> > +		 * current then treat it like the PID=0 case above.
> > +		 */
> > +		if (p == current)
> > +			return current->group_leader;
> > +
> > +		/*
> > +		 * For foreign processes require that p is group leader.
> >  		 */
> >  		if (!has_group_leader_pid(p))
> >  			return NULL;
> 
> So, right after you should have that:
> 
>                 if (same_thread_group(p, current))
>                         return p;
> 
> Which I suggested to convert as:
> 
>                 if (p == current)
>                         return p;

Indeed :)


