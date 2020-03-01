Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D10174F2F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 20:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgCATaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 14:30:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgCATae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 14:30:34 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4777B246B6;
        Sun,  1 Mar 2020 19:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583091034;
        bh=9tKt8foKsUFCIIDZ/yJF5cCzikyQ5cEBa8oVZoxAlic=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rq3sVfWaAdC8yXrFQnpYeKbKcDEb5+Tn+ciCuiwkic+v87s5c5w4uQkevdKReNzAT
         mLZrp2l0m5mNe9dFKKq7lUF2kuwbMinfaMDO3GQ2Bh38sUNfrzFh2IR2HV1daCQ20I
         99USvfpXqUJMONmpNEznFIqF0TQRxV7FmnXyIGzQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1CEDA352272F; Sun,  1 Mar 2020 11:30:34 -0800 (PST)
Date:   Sun, 1 Mar 2020 11:30:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to
 C-code
Message-ID: <20200301193034.GY2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <87imjofkhx.fsf@nanos.tec.linutronix.de>
 <AED99B11-8739-450F-932C-EF38C20D44CA@amacapital.net>
 <87d09wf6dw.fsf@nanos.tec.linutronix.de>
 <CALCETrVNcpoubrpVrtGjXSQrod8jzjweszEPX_WSJM747xr8wQ@mail.gmail.com>
 <878skkeygm.fsf@nanos.tec.linutronix.de>
 <20200301182605.GT2935@paulmck-ThinkPad-P72>
 <CALCETrVfXmKLN9AxOeizr1mHTA9CSG5-_UgoH8hruTMrrA-0vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVfXmKLN9AxOeizr1mHTA9CSG5-_UgoH8hruTMrrA-0vA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 10:54:23AM -0800, Andy Lutomirski wrote:
> On Sun, Mar 1, 2020 at 10:26 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Sun, Mar 01, 2020 at 07:12:25PM +0100, Thomas Gleixner wrote:
> > > Andy Lutomirski <luto@kernel.org> writes:
> > > > On Sun, Mar 1, 2020 at 7:21 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >> Andy Lutomirski <luto@amacapital.net> writes:
> > > >> >> On Mar 1, 2020, at 2:16 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >> >> Ok, but for the time being anything before/after CONTEXT_KERNEL is unsafe
> > > >> >> except trace_hardirq_off/on() as those trace functions do not allow to
> > > >> >> attach anything AFAICT.
> > > >> >
> > > >> > Can you point to whatever makes those particular functions special?  I
> > > >> > failed to follow the macro maze.
> > > >>
> > > >> Those are not tracepoints and not going through the macro maze. See
> > > >> kernel/trace/trace_preemptirq.c
> > > >
> > > > That has:
> > > >
> > > > void trace_hardirqs_on(void)
> > > > {
> > > >         if (this_cpu_read(tracing_irq_cpu)) {
> > > >                 if (!in_nmi())
> > > >                         trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> > > >                 tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
> > > >                 this_cpu_write(tracing_irq_cpu, 0);
> > > >         }
> > > >
> > > >         lockdep_hardirqs_on(CALLER_ADDR0);
> > > > }
> > > > EXPORT_SYMBOL(trace_hardirqs_on);
> > > > NOKPROBE_SYMBOL(trace_hardirqs_on);
> > > >
> > > > But this calls trace_irq_enable_rcuidle(), and that's the part of the
> > > > macro maze I got lost in.  I found:
> > > >
> > > > #ifdef CONFIG_TRACE_IRQFLAGS
> > > > DEFINE_EVENT(preemptirq_template, irq_disable,
> > > >              TP_PROTO(unsigned long ip, unsigned long parent_ip),
> > > >              TP_ARGS(ip, parent_ip));
> > > >
> > > > DEFINE_EVENT(preemptirq_template, irq_enable,
> > > >              TP_PROTO(unsigned long ip, unsigned long parent_ip),
> > > >              TP_ARGS(ip, parent_ip));
> > > > #else
> > > > #define trace_irq_enable(...)
> > > > #define trace_irq_disable(...)
> > > > #define trace_irq_enable_rcuidle(...)
> > > > #define trace_irq_disable_rcuidle(...)
> > > > #endif
> > > >
> > > > But the DEFINE_EVENT doesn't have the "_rcuidle" part.  And that's
> > > > where I got lost in the macro maze.  I looked at the gcc asm output,
> > > > and there is, indeed:
> > >
> > > DEFINE_EVENT
> > >   DECLARE_TRACE
> > >     __DECLARE_TRACE
> > >        __DECLARE_TRACE_RCU
> > >          static inline void trace_##name##_rcuidle(proto)
> > >             __DO_TRACE
> > >                if (rcuidle)
> > >                   ....
> > >
> > > > But I also don't see why this is any different from any other tracepoint.
> > >
> > > Indeed. I took a wrong turn at some point in the macro jungle :)
> > >
> > > So tracing itself is fine, but then if you have probes or bpf programs
> > > attached to a tracepoint these use rcu_read_lock()/unlock() which is
> > > obviosly wrong in rcuidle context.
> >
> > Definitely, any such code needs to use tricks similar to that of the
> > tracing code.  Or instead use something like SRCU, which is OK with
> > readers from idle.  Or use something like Steve Rostedt's workqueue-based
> > approach, though please be very careful with this latter, lest the
> > battery-powered embedded guys come after you for waking up idle CPUs
> > too often.  ;-)
> 
> Are we okay if we somehow ensure that all the entry code before
> enter_from_user_mode() only does rcuidle tracing variants and has
> kprobes off?  Including for BPF use cases?

That would work, though if BPF used SRCU instead of RCU, this would
be unnecessary.  Sadly, SRCU has full memory barriers in each of
srcu_read_lock() and srcu_read_unlock(), but we are working on it.
(As always, no promises!)

> It would be *really* nice if we could statically verify this, as has
> been mentioned elsewhere in the thread.  It would also probably be
> good enough if we could do it at runtime.  Maybe with lockdep on, we
> verify rcu state in tracepoints even if the tracepoint isn't active?
> And we could plausibly have some widget that could inject something
> into *every* kprobeable function to check rcu state.

Or just have at least one testing step that activates all tracepoints,
but with lockdep enabled?

							Thanx, Paul
