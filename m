Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8801594AD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 17:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbgBKQSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 11:18:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbgBKQSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:18:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A4222070A;
        Tue, 11 Feb 2020 16:18:30 +0000 (UTC)
Date:   Tue, 11 Feb 2020 11:18:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Subject: Re: [PATCH v2] tracing/perf: Move rcu_irq_enter/exit_irqson() to
 perf trace point hook
Message-ID: <20200211111828.48058768@gandalf.local.home>
In-Reply-To: <20200211153452.GW14914@hirez.programming.kicks-ass.net>
References: <20200211095047.58ddf750@gandalf.local.home>
        <20200211153452.GW14914@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020 16:34:52 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > +		if (unlikely(in_nmi()))
> > +			goto out;  
> 
> unless I'm mistaken, we can simply do rcu_nmi_enter() in this case, and
> rcu_nmi_exit() on the other end.
> 
> > +		rcu_irq_enter_irqson();

The thing is, I don't think this can ever happen. We've had in the
tracepoint.h:

		/* srcu can't be used from NMI */			\
		WARN_ON_ONCE(rcuidle && in_nmi());			\

And this has yet to trigger.

-- Steve
