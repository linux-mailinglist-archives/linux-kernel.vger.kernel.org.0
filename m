Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F66175171
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 02:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgCBBKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 20:10:21 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40974 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgCBBKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 20:10:21 -0500
Received: by mail-qk1-f194.google.com with SMTP id b5so8568932qkh.8
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 17:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ak4xhRTNGLPFYUIccVBSL7a8+9B1JWMD28S10CklEbI=;
        b=Zr+lvoxa8+9hKdkiQAmVvVUkvUqv0SYpKBW16OpBTf+y40qkpZYbBdybpfAPryiKii
         ShaOvN5Rd4xcHNaymar8o4z2Y/dv8W1ZHZ0LFALp9XyDPosWcmUheYeY62+jEFgdMS+C
         XL6q1ZVfbppw6+5Ikic69m4LraEQ2b2TbaW3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ak4xhRTNGLPFYUIccVBSL7a8+9B1JWMD28S10CklEbI=;
        b=sT//a9caJEvyMn2sLR9gnRBVwM5vLq90A+7qc0DtJUI7cYiRDVsNMgS+jBrXctv1NT
         amWUEdelLpeZjxtHsO1d+H64cmavkXhe6ZpUrrGG61rs4jU6Bxciv6qEpAKKEzvu8Lqp
         XkPGKevZpwGxLWOvZc7RLJPTaX+ssu3H4PtAO08ArEXpb6vatuAXSl3GE0ZusKnLEP3y
         4r5tipJhyBSmjkGEpQwLoV602UkEYdMA7//wjfn4BNkXLcRIp4qvL376CHFRvjn0Bjyn
         3Tw83L+LL1G/+xZumaqgsgnBFOg/Y1eEEpG1OMcYVpN23xHNLQjZcglwXzkkORhT0Pmy
         JjRQ==
X-Gm-Message-State: APjAAAVm3nVWKZG79mPeLjXSa63c9JHGnPTbe/YnTc/5UAnJVDG2Zl0q
        DUR2+T/Cb22aFSJ3NaYd7EQdXQ==
X-Google-Smtp-Source: APXvYqwBbdankEEtRcHLqyFdag8V3+7dl5PAmfCVL3gkPa+/XhfbcMpr0TD+BHCm2JgcUjEAlJsJDA==
X-Received: by 2002:a37:bfc2:: with SMTP id p185mr12788506qkf.428.1583111419830;
        Sun, 01 Mar 2020 17:10:19 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v12sm7800338qti.84.2020.03.01.17.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 17:10:19 -0800 (PST)
Date:   Sun, 1 Mar 2020 20:10:18 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to
 C-code
Message-ID: <20200302011018.GA161499@google.com>
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
User-Agent: Mutt/1.12.2 (2019-09-21)
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
> >
> 
> Are we okay if we somehow ensure that all the entry code before
> enter_from_user_mode() only does rcuidle tracing variants and has
> kprobes off?  Including for BPF use cases?
> 
> It would be *really* nice if we could statically verify this, as has
> been mentioned elsewhere in the thread.  It would also probably be
> good enough if we could do it at runtime.  Maybe with lockdep on, we
> verify rcu state in tracepoints even if the tracepoint isn't active?
> And we could plausibly have some widget that could inject something
> into *every* kprobeable function to check rcu state.

You are talking about verifying that a non-rcuidle tracepoint is not called
into when RCU is not watching right? I think that's fine, though I feel
lockdep kernels should not be slowed down any more than they already are. I
feel over time if we add too many checks to lockdep enabled kernels, then it
becomes too slow even for "debug" kernels. May be it is time for a
CONFIG_LOCKDEP_SLOW or some such? And then anyone who wants to go crazy on
runtime checking can do so. I myself want to add a few.

Note that the checking is being added into "non rcu-idle" tracepoints many of
which are probably always called when RCU is watching, making such checking
useless for those tracepoints (and slowing them down however less).

Also another note would be that the whole reason we are getting rid of the
"make RCU watch when rcuidle" logic in DO_TRACE is because it is slow for
tracepoints that are frequently called into. Another reason to do it is
because tracepoint callbacks are expected to know what they are doing and
turn on RCU watching as appropriate (as consensus on the matter suggests).

thanks,

 - Joel

