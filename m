Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA3C21619A5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 19:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgBQSSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 13:18:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgBQSSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:18:03 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FEC6207FD;
        Mon, 17 Feb 2020 18:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581963482;
        bh=338v2vpL74mCpLaYTTw92AbQMD7tUxezoo/j14+a184=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DjxYBzoxfz0WGvHd/F4riFm7IGF1zVkk/BNkix7v7sAAZFJujAydEAxTG6SaUA8Nj
         OcVQGT2+8clUW4+2CIlM7iLxaH39nKh7inAKnHePTbMqdIOIyItYc3Tx3wbJBijXxW
         GFCVFB5gt/JWVBBvrk6ylcuhTY8zeWx1RnRCCCSA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7930B352273C; Mon, 17 Feb 2020 10:18:02 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:18:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/4] srcu: Fix __call_srcu()/process_srcu()
 datarace
Message-ID: <20200217181802.GQ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200215002907.GA15895@paulmck-ThinkPad-P72>
 <20200215002932.15976-1-paulmck@kernel.org>
 <20200217124231.GS14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217124231.GS14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 01:42:31PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 14, 2020 at 04:29:29PM -0800, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > The srcu_node structure's ->srcu_gp_seq_needed_exp field is accessed
> > locklessly, so updates must use WRITE_ONCE().  This commit therefore
> > adds the needed WRITE_ONCE() invocations.
> > 
> > This data race was reported by KCSAN.  Not appropriate for backporting
> > due to failure being unlikely.
> 
> This does indeed look like there can be a failure; but this Changelog
> fails to describe an actual problem.

As before, within RCU, the mere fact of a KCSAN report motivates a change.
I am not going to waste time brainstorming overly creative compiler
optimizations, present or future.

							Thanx, Paul

> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/srcutree.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 657e6a7..b1edac9 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -550,7 +550,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> >  		snp->srcu_have_cbs[idx] = gpseq;
> >  		rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
> >  		if (ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, gpseq))
> > -			snp->srcu_gp_seq_needed_exp = gpseq;
> > +			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
> >  		mask = snp->srcu_data_have_cbs[idx];
> >  		snp->srcu_data_have_cbs[idx] = 0;
> >  		spin_unlock_irq_rcu_node(snp);
> > @@ -660,7 +660,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> >  		if (snp == sdp->mynode)
> >  			snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
> >  		if (!do_norm && ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, s))
> > -			snp->srcu_gp_seq_needed_exp = s;
> > +			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, s);
> >  		spin_unlock_irqrestore_rcu_node(snp, flags);
> >  	}
> >  
> > -- 
> > 2.9.5
> > 
