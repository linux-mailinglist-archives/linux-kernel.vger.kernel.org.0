Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 760D696ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 22:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfHTUsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 16:48:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729833AbfHTUsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:48:07 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCBC722DD3;
        Tue, 20 Aug 2019 20:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566334086;
        bh=nqXqcwkwUYZSgLgaalJwI6LSL9l3GM5NS8UsYbR8b7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBYPNYRqcTGM02pYLSV8LRlUC93z2y/9pGUoOX8rduvZ+ezOy3X3xcgAkCZUQuICn
         gd1+gsJfRPuSwPXFJNpqpAaBKVp9vf0AjQKrjQfUtHFrtf4IkpV6jh6nAcFk3MXEPN
         3Aig42Jau35TCxD+yT+R1jaAMfXd04o+dLk5shzg=
Date:   Tue, 20 Aug 2019 22:48:03 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 04/44] posix-cpu-timers: Fixup stale comment
Message-ID: <20190820204803.GH2093@lenoir>
References: <20190819143141.221906747@linutronix.de>
 <20190819143801.747233612@linutronix.de>
 <20190820142658.GG2093@lenoir>
 <alpine.DEB.2.21.1908201946320.2223@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908201946320.2223@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 07:57:37PM +0200, Thomas Gleixner wrote:
> On Tue, 20 Aug 2019, Frederic Weisbecker wrote:
> > On Mon, Aug 19, 2019 at 04:31:45PM +0200, Thomas Gleixner wrote:
> > >  /*
> > > - * Clean out CPU timers still ticking when a thread exited.  The task
> > > - * pointer is cleared, and the expiry time is replaced with the residual
> > > - * time for later timer_gettime calls to return.
> > > + * Clean out CPU timers which are still armed when a thread exits. The
> > > + * timers are only removed from the list. No other updates are done. The
> > > + * corresponding posix timers are still accessible, but cannot be rearmed.
> > > + *
> > >   * This must be called with the siglock held.
> > >   */
> > >  static void cleanup_timers(struct list_head *head)
> > 
> > Indeed and I believe we could avoid that step. We remove the sighand at the same
> > time so those can't be accessed anymore anyway.
> > 
> > exit_itimers() takes care of the last call release and could force remove from
> > the list (although it might be taken care of in your series, haven't checked yet):
> 
> No. The posix timer is not necessarily owned by the exiting task or
> process. It can be owned by a different entity which has permissions,
> e.g. parent.
> 
> So those are not in the posix timer list of the exiting task, which gets
> cleaned up in exit_itimers(). Those are in the list of the task which armed
> the timer. The timer is merily queued in the 'active timers' list of the
> exiting task and posix_cpu_timers_exit()/posix_cpu_timers_exit_group()
> remove it before the task/signal structs go away.

Sure, I understand there's two distinct things here: the owner that queues
timers in owner->sig->posix_timers (cleaned in exit_itimers()) and the target that queues
in target->[signal->]cputime_expires (cleaned in posix_cpu_timers_exit[_group]().

So I'm wondering why we bother with posix_cpu_timers_exit[_group]() at all
when exit_itimers() could handle the list deletion from target->[signal]->cputime_expires
throughout posix_cpu_timer_del() as it already does on targets that still have
their sighands.

It would make things more simple to delete the timer off the target from
the same caller and place and we could remove posix_cpu_timers_exit*().

Or is there something I'm awkwardly missing as usual? :-) 
