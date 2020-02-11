Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4BC315882F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 03:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgBKCWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 21:22:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727493AbgBKCWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 21:22:25 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC18920714;
        Tue, 11 Feb 2020 02:22:23 +0000 (UTC)
Date:   Mon, 10 Feb 2020 21:22:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
Message-ID: <20200210212222.59a8c519@rorschach.local.home>
In-Reply-To: <576504045.617212.1581381032132.JavaMail.zimbra@efficios.com>
References: <20200210170643.3544795d@gandalf.local.home>
        <576504045.617212.1581381032132.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 19:30:32 -0500 (EST)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Feb 10, 2020, at 5:06 PM, rostedt rostedt@goodmis.org wrote:
> 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>  
> 
> Hi Steven,

Hi Mathieu!

> 
> > because perf only uses rcu to synchronize trace points.  
> 
> That last part seems inaccurate. The tracepoint synchronization is two-fold:
> one part is internal to tracepoint.c (see rcu_free_old_probes()), and the other
> is only needed if the probes are within modules which can be unloaded (see
> tracepoint_synchronize_unregister()). AFAIK, perf never implements probe callbacks
> within modules, so the latter is not needed by perf.
> 
> The culprit of the problem here is that perf issues "rcu_read_lock()" and
> "rcu_read_unlock()" within the probe callbacks it registers to the tracepoints,
> including the rcuidle ones. Those require that RCU is "watching", which is
> triggering the regression when we remove the calls to rcu_irq_enter/exit_irqson()
> from the rcuidle tracepoint instrumentation sites.

100% agree. I guess I need to clarify what I meant with "rcu to
synchronize trace points". I meant its trace point *callbacks*, not the
trace point code itself.

> 
> Which brings a question about handling of NMIs: in the proposed patch, if
> a NMI nests over rcuidle context, AFAIU it will be in a state
> !rcu_is_watching() && in_nmi(), which is handled by this patch with a simple
> "return", meaning important NMIs doing hardware event sampling can be
> completely lost.
> 
> Considering that we cannot use rcu_irq_enter/exit_irqson() from NMI context,
> is it at all valid to use rcu_read_lock/unlock() as perf does from NMI handlers,
> considering that those can be nested on top of rcuidle context ?
> 

Note, in the __DO_TRACE macro, we've had this for a long time:

		/* srcu can't be used from NMI */			\
		WARN_ON_ONCE(rcuidle && in_nmi());			\

With nothing triggering.

-- Steve

