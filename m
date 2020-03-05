Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870A017A750
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 15:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgCEOWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 09:22:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:57816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgCEOWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:22:46 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACFAB2073D;
        Thu,  5 Mar 2020 14:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583418165;
        bh=TJrx6Vvx7IBPDbBVQ+OIz/BKikJsmMyfPgbEMTzoUJ8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=u7vjh0iKHd4Ot1+Kf4/5E1OvS+n+5cebbcrUIk2mcJNUkYzcCZljz23uOmj7LFN9U
         aw4mICHUMS87+HRBERcKpZBDlwRbKbctUZqI8V/x6kD6Z5rvdLw0qWlQiHGWoGX/M2
         jsM1qtZdlpJnYrWhdBeqnRv3vtS2KAxZzuynIxWg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7BBD435226D4; Thu,  5 Mar 2020 06:22:45 -0800 (PST)
Date:   Thu, 5 Mar 2020 06:22:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: Pinning down a blocked task to extract diagnostics
Message-ID: <20200305142245.GB2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200305005049.GA21120@paulmck-ThinkPad-P72>
 <20200305080755.GS2596@hirez.programming.kicks-ass.net>
 <20200305081337.GA2619@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305081337.GA2619@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 09:13:37AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 05, 2020 at 09:07:55AM +0100, Peter Zijlstra wrote:
> > On Wed, Mar 04, 2020 at 04:50:49PM -0800, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > Suppose that I need to extract diagnostics information from a blocked
> > > task, but that I absolutely cannot tolerate this task awakening in the
> > > midst of this extraction process.  Is the following code the right way
> > > to make this work given a task "t"?
> > > 
> > > 	raw_spin_lock_irq(&t->pi_lock);
> > > 	if (t->on_rq) {
> > > 		/* Task no longer blocked, so ignore it. */
> > > 	} else {
> > > 		/* Extract consistent diagnostic information. */
> > > 	}
> > > 	raw_spin_unlock_irq(&t->pi_lock);
> > > 
> > > It looks like all the wakeup paths acquire ->pi_lock, but I figured I
> > > should actually ask...
> > 
> > Close, the thing pi_lock actually guards is the t->state transition *to*
> > TASK_WAKING/TASK_RUNNING, so something like this:
> 
> Almost, we must indeed also check ->on_rq, otherwise it might change the
> state back itself.
> 
> > 
> > 	raw_spin_lock_irq(&t->pi_lock);
> > 	switch (t->state) {
> > 	case TASK_RUNNING:
> > 	case TASK_WAKING:
> > 		/* ignore */
> > 		break;
> > 
> > 	default:
> 		if (t->on_rq)
> 			break;
> 
> > 		/* Extract consistent diagnostic information. */
> > 		break;
> > 	}
> > 	raw_spin_unlock_irq(&t->pi_lock);
> > 
> > ought to work. But if you're going to do this, please add a reference to
> > that code in a comment on top of try_to_wake_up(), such that we can
> > later find all the code that relies on this.

How about if I add something like this, located right by try_to_wake_up()?

	bool try_to_keep_sleeping(struct task_struct *t)
	{
		raw_spin_lock_irq(&t->pi_lock);
		switch (t->state) {
		case TASK_RUNNING:
		case TASK_WAKING:
			raw_spin_unlock_irq(&t->pi_lock);
			return false;

		default:
			if (t->on_rq) {
				raw_spin_unlock_irq(&t->pi_lock);
				return false;
			}

			/* OK to extract consistent diagnostic information. */
			return true;
		}
		/* NOTREACHED */
	}

Then a use might look like this:

	if (try_to_keep_sleeping(t))
		/* Extract consistent diagnostic information. */
		raw_spin_unlock_irq(&t->pi_lock);
	} else {
		/* Woo-hoo!  It started running again!!! */
	}

Is there a better way to approach this?

							Thanx, Paul
