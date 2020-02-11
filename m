Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88FD2158F68
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 14:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgBKNDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 08:03:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgBKNDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:03:06 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [193.85.242.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DACD20873;
        Tue, 11 Feb 2020 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581426184;
        bh=JKis2LEOlKNfcDha2Jb51pvIrz3he7V2mpruiYwhv5A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Bget1bYI25O+KYmzRlDKhn82HSd3aNWlzdIXLEwd/idtxGYAV67GBK2XBiegn6RNt
         +wjQ02B/3Jp1io5iLjMBxxKB+uvFedRsl0nrBEi9snIG4sOt1YZA/e1XQUrq2C5ZSn
         4rA+gSeiO2gNlPc/ERa6R6p8Jy0+xXIHLtr4rtyw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F14573520CB5; Tue, 11 Feb 2020 05:03:01 -0800 (PST)
Date:   Tue, 11 Feb 2020 05:03:01 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
Message-ID: <20200211130301.GH2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200210170643.3544795d@gandalf.local.home>
 <576504045.617212.1581381032132.JavaMail.zimbra@efficios.com>
 <20200211120015.GL14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211120015.GL14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 01:00:15PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 10, 2020 at 07:30:32PM -0500, Mathieu Desnoyers wrote:
> 
> > > because perf only uses rcu to synchronize trace points.
> > 
> > That last part seems inaccurate. The tracepoint synchronization is two-fold:
> > one part is internal to tracepoint.c (see rcu_free_old_probes()), and the other
> > is only needed if the probes are within modules which can be unloaded (see
> > tracepoint_synchronize_unregister()). AFAIK, perf never implements probe callbacks
> > within modules, so the latter is not needed by perf.
> > 
> > The culprit of the problem here is that perf issues "rcu_read_lock()" and
> > "rcu_read_unlock()" within the probe callbacks it registers to the tracepoints,
> > including the rcuidle ones. Those require that RCU is "watching", which is
> > triggering the regression when we remove the calls to rcu_irq_enter/exit_irqson()
> > from the rcuidle tracepoint instrumentation sites.
> 
> It is not the fact that perf issues rcu_read_lock() that is the problem.
> As we established yesterday, I can probably remove most rcu_read_lock()
> calls from perf today (yay RCU flavour unification).

Glad some aspect of this unification is actually helping you.  ;-)

> The problem is that the core perf code uses RCU managed data; and we
> need an existence guarantee for it. It would be BAD (TM) if the
> ring-buffer we're writing data to were to suddenly dissapear under our
> feet etc..
> 
> > Which brings a question about handling of NMIs: in the proposed patch, if
> > a NMI nests over rcuidle context, AFAIU it will be in a state
> > !rcu_is_watching() && in_nmi(), which is handled by this patch with a simple
> > "return", meaning important NMIs doing hardware event sampling can be
> > completely lost.
> > 
> > Considering that we cannot use rcu_irq_enter/exit_irqson() from NMI context,
> > is it at all valid to use rcu_read_lock/unlock() as perf does from NMI handlers,
> 
> Again, rcu_read_lock() itself really isn't the problem. But we need
> NMIs, just like regular interrupts, to imply rcu_read_lock(). That is,
> any observable (RCU managed) pointer must stay valid during the NMI/IRQ
> execution.
> 
> > considering that those can be nested on top of rcuidle context ?
> 
> As per nmi_enter() calling rcu_nmi_enter() I've always assumed that NMIs
> are fully covered by RCU.
> 
> If this isn't so, RCU it terminally broken :-)

All RCU can do is respond to calls to rcu_nmi_enter() and rcu_nmi_exit().
It has not yet figured out how to force people to add these calls where
they are needed.  ;-)

But yes, it would be very nice if architectures arranged things so
that all NMI handlers were visible to RCU.  And we no longer have
half-interrupts, so maybe there is hope...

							Thanx, Paul
