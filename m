Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC7896826
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 19:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfHTR5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 13:57:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52780 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfHTR5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:57:41 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i08O2-0004Cu-W2; Tue, 20 Aug 2019 19:57:39 +0200
Date:   Tue, 20 Aug 2019 19:57:37 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 04/44] posix-cpu-timers: Fixup stale comment
In-Reply-To: <20190820142658.GG2093@lenoir>
Message-ID: <alpine.DEB.2.21.1908201946320.2223@nanos.tec.linutronix.de>
References: <20190819143141.221906747@linutronix.de> <20190819143801.747233612@linutronix.de> <20190820142658.GG2093@lenoir>
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

On Tue, 20 Aug 2019, Frederic Weisbecker wrote:
> On Mon, Aug 19, 2019 at 04:31:45PM +0200, Thomas Gleixner wrote:
> >  /*
> > - * Clean out CPU timers still ticking when a thread exited.  The task
> > - * pointer is cleared, and the expiry time is replaced with the residual
> > - * time for later timer_gettime calls to return.
> > + * Clean out CPU timers which are still armed when a thread exits. The
> > + * timers are only removed from the list. No other updates are done. The
> > + * corresponding posix timers are still accessible, but cannot be rearmed.
> > + *
> >   * This must be called with the siglock held.
> >   */
> >  static void cleanup_timers(struct list_head *head)
> 
> Indeed and I believe we could avoid that step. We remove the sighand at the same
> time so those can't be accessed anymore anyway.
> 
> exit_itimers() takes care of the last call release and could force remove from
> the list (although it might be taken care of in your series, haven't checked yet):

No. The posix timer is not necessarily owned by the exiting task or
process. It can be owned by a different entity which has permissions,
e.g. parent.

So those are not in the posix timer list of the exiting task, which gets
cleaned up in exit_itimers(). Those are in the list of the task which armed
the timer. The timer is merily queued in the 'active timers' list of the
exiting task and posix_cpu_timers_exit()/posix_cpu_timers_exit_group()
remove it before the task/signal structs go away.

Thanks,

	tglx

 
