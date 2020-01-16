Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0D7613DE22
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 15:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgAPOzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 09:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgAPOzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:55:10 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B73820748;
        Thu, 16 Jan 2020 14:55:08 +0000 (UTC)
Date:   Thu, 16 Jan 2020 09:55:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, notify@kernel.org
Subject: Re: [PATCH 1/1] timer: Warn about schedule_timeout() called for
 tasks in TASK_RUNNING state
Message-ID: <20200116095507.6f164a0a@gandalf.local.home>
In-Reply-To: <20200116095220.7368a604@gandalf.local.home>
References: <20200116140218.1328022-1-alex.popov@linux.com>
        <20200116095220.7368a604@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 09:52:20 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > --- a/kernel/time/timer.c
> > +++ b/kernel/time/timer.c
> > @@ -1887,6 +1887,11 @@ signed long __sched schedule_timeout(signed long timeout)
> >  		}
> >  	}
> >  
> > +#ifdef CONFIG_SCHED_DEBUG
> > +	WARN_ONCE(current->state == TASK_RUNNING,
> > +			"schedule_timeout for TASK_RUNNING\n");
> > +#endif
> > +  
> 
> But this can trigger false warnings. For example, if we are waiting on
> an event with a timeout:


Also, there are helpers here that you can use:

schedule_timeout_interruptible(signed long timeout);
schedule_timeout_uninterruptible(signed long timeout)

-- Steve
