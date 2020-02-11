Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6478159282
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 16:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgBKPGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 10:06:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43572 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBKPGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kOVM19xgvEpzNbdc34dGz9f33pbISrxSA6jBH/Bi6So=; b=aQeCQQp0OxFOcoJ8vnnGz7DEKt
        oR7osXGRsXoca1k5+TmdiEJvRabVb6ElkP0ZmZrNG2BXx12YaCVHSVPuSPM59TaNmahz3nYnk+G3h
        bkrs1CrjM4b9Xrp8zOjk9PJZDQv4SGnm+HdsqQRNXl1aiAyCaHiX5GxkYjDN7n5VGAtwR3ZCy3vYN
        VUnK89EVOl+KiBNcmNZaDt9P+UMam1Tf0sWubBWzmveYa5B1PsT074ln+8T62ZpIMe+TjMR64cDte
        wMpCjFR1KytcQ3gi3AepbDSQrKrH0NntQdIJli72rwrftYJvCrL7O1ezIwbwZ4gNrIkDTC11uAkGE
        JrKESysQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1X6V-0006JB-RU; Tue, 11 Feb 2020 15:05:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5450430066E;
        Tue, 11 Feb 2020 16:03:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2D092B920EF1; Tue, 11 Feb 2020 16:05:32 +0100 (CET)
Date:   Tue, 11 Feb 2020 16:05:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
Message-ID: <20200211150532.GU14914@hirez.programming.kicks-ass.net>
References: <20200210170643.3544795d@gandalf.local.home>
 <20200211114954.GK14914@hirez.programming.kicks-ass.net>
 <20200211090503.68c0d70f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211090503.68c0d70f@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 09:05:03AM -0500, Steven Rostedt wrote:
> On Tue, 11 Feb 2020 12:49:54 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Feb 10, 2020 at 05:06:43PM -0500, Steven Rostedt wrote:
> > > +	if (!rcu_watching) {						\
> > > +		/* Can not use RCU if rcu is not watching and in NMI */	\
> > > +		if (in_nmi())						\
> > > +			return;						\
> > > +		rcu_irq_enter_irqson();					\
> > > +	}								\  
> > 
> > I saw the same weirdness in __trace_stack(), and I'm confused by it.
> > 
> > How can we ever get to: in_nmi() && !rcu_watching() ? That should be a
> > BUG.  In particular, nmi_enter() has rcu_nmi_enter().
> > 
> > Paul, can that really happen?
> 
> The stack tracer connects to the function tracer and is called at all
> the places that function tracing can be called from. As I like being
> able to trace RCU internal functions (especially as they are complex),
> I don't want to set them all to notrace. But, for callbacks that
> require RCU to be watching, we need this check, because there's some
> internal state that we can be in an NMI and RCU is not watching (as
> there's some places in nmi_enter that can be traced!).
> 
> And if we are tracing preempt_enable and preempt_disable (as Joel added
> trace events there), it may be the case for trace events too.

Bloody hell; what a trainwreck. Luckily there's comments around that
explain this!

So we haz:

| #define nmi_enter()						\
| 	do {							\
| 		arch_nmi_enter();				\

arm64 only, lets ignore for now

| 		printk_nmi_enter();				\

notrace

| 		lockdep_off();					\

notrace

| 		ftrace_nmi_enter();				\

!notrace !!!

| 		BUG_ON(in_nmi());				\
| 		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);\

lets make this __preempt_count_add() ASAP !

| 		rcu_nmi_enter();				\

are you _really_ sure you want to go trace that ?!?

| 		trace_hardirq_enter();				\
| 	} while (0)


