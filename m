Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0A97B54A1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 19:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfIQRyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 13:54:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfIQRyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:54:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F479882FB;
        Tue, 17 Sep 2019 17:54:11 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4026519C70;
        Tue, 17 Sep 2019 17:54:05 +0000 (UTC)
Message-ID: <e7ffe570911adffcbc69c05a26e5b670c1dcc3f6.camel@redhat.com>
Subject: Re: [PATCH RT 6/8] sched: migrate_enable: Set state to TASK_RUNNING
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Tue, 17 Sep 2019 12:54:04 -0500
In-Reply-To: <20190917153110.fgi6ilb6mpfkcwbr@linutronix.de>
References: <20190727055638.20443-1-swood@redhat.com>
         <20190727055638.20443-7-swood@redhat.com>
         <20190917153110.fgi6ilb6mpfkcwbr@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 17 Sep 2019 17:54:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-17 at 17:31 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-07-27 00:56:36 [-0500], Scott Wood wrote:
> > If migrate_enable() is called while a task is preparing to sleep
> > (state != TASK_RUNNING), that triggers a debug check in stop_one_cpu().
> > Explicitly reset state to acknowledge that we're accepting the spurious
> > wakeup.
> > 
> > Signed-off-by: Scott Wood <swood@redhat.com>
> > ---
> >  kernel/sched/core.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 38a9a9df5638..eb27a9bf70d7 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7396,6 +7396,14 @@ void migrate_enable(void)
> >  			unpin_current_cpu();
> >  			preempt_lazy_enable();
> >  			preempt_enable();
> > +
> > +			/*
> > +			 * Avoid sleeping with an existing non-running
> > +			 * state.  This will result in a spurious wakeup
> > +			 * for the calling context.
> > +			 */
> > +			__set_current_state(TASK_RUNNING);
> 
> Do you have an example for this?

Unfortunately I didn't save the traceback of where I originally saw it, but
I ran it again and hit the warning in prepare_to_wait_event().

>  I'm not too sure if we are not using a
> state by doing this. Actually we were losing it and get yelled at.  We do:
> > rt_spin_unlock()
> > {
> >         rt_spin_lock_fastunlock();
> >         migrate_enable();
> > }
> 
> So save the state as part of the locking process and lose it as part of
> migrate_enable() if the CPU mask was changed. I *think* we need to
> preserve that state until after the migration to the other CPU.

Preserving the state would be ideal, though in most cases occasionally
losing the state should be tolerable as long as it doesn't happen
persistently.  TASK_DEAD is an exception but that doesn't do anything before
schedule() that could end up here.  I suppose there could be some places
that use TASK_UNINTERRUPTIBLE without checking the actual condition after
schedule(), and which do something that can end up here before schedule()...

We can't use saved_state here though, because we can get here inside the
rtmutex code (e.g. from debug_rt_mutex_print_deadlock)... and besides, the
waker won't have WF_LOCK_SLEEPER and so saved_state will get cleared.

-Scott


