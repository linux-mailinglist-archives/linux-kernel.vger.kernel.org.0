Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D105E158F58
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 13:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgBKM7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 07:59:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgBKM7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:59:33 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [193.85.242.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9B592082F;
        Tue, 11 Feb 2020 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581425973;
        bh=0rHaHBnnUfEn3Zy5DgliLDcNN6ysnjPUQ6feM/fQNpk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=wcmnAI0OD3OSknN4KstP9i/qmivriVrC5AjJMidxuuiH63xPx8DoMP9skCW6dcfWz
         s+llSMQljp49V5l7CC4b8yWH5diLgishyA2lUOREsZioaPKhWlvCf2H372bx80rYC3
         YUMipcZSsPM/eKVmBljUzQYuhZXDGfk4h2D1Y/nI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8E3513520CB5; Tue, 11 Feb 2020 04:59:29 -0800 (PST)
Date:   Tue, 11 Feb 2020 04:59:29 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
Message-ID: <20200211125929.GG2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200210170643.3544795d@gandalf.local.home>
 <20200211114954.GK14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211114954.GK14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 12:49:54PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 10, 2020 at 05:06:43PM -0500, Steven Rostedt wrote:
> > +	if (!rcu_watching) {						\
> > +		/* Can not use RCU if rcu is not watching and in NMI */	\
> > +		if (in_nmi())						\
> > +			return;						\
> > +		rcu_irq_enter_irqson();					\
> > +	}								\
> 
> I saw the same weirdness in __trace_stack(), and I'm confused by it.
> 
> How can we ever get to: in_nmi() && !rcu_watching() ? That should be a
> BUG.  In particular, nmi_enter() has rcu_nmi_enter().
> 
> Paul, can that really happen?

Not sure what the current situation is, but if I remember correctly it
used to be possible to get to an NMI handler without RCU being informed.
If NMI handlers now unconditionally inform RCU, then like you, I don't
see that the "if (in_nmi()) return" is needed.

However, a quick grep for NMI_MASK didn't show me the NMI_MASK bit
getting set.  Help?

							Thanx, Paul
