Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 181AF1619CB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 19:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgBQSiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 13:38:15 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45718 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbgBQSiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:38:14 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so17026833otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 10:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yE9JpGydxhTrvHtUNPWenRESsALy+y19qiL+5XXZ+WI=;
        b=AsQ8I2Jxxpx/75ew7nRBlKw4gLClrRxJLsI6d1vpbHVswX6XLbjnPVo7U3iXxvUYgm
         mbhNKLFaz9bOtEsafO4o9ZHDvXBN/JdO+EFL2N42T0HkEW0oCLjkOPQohp4hegOLpBoV
         qUxU4DejQmu4vswU2zS9+qvMMYreryT0arhK4JIlUxwmvt04tO8S+AUU9fv3veWfmFOH
         qSz7jwZOiOfVIYp7oq0EaeN8d8bXg1TrgtBZ1IM/KOEFtqlMxq0Q2gjan2YXozg3OVYc
         giwIASRVAvY5lj0mWIStI3dkCBqdg2edyHeUQeNGQHsHcJqtE9UdkTo4CK31RqqgqQnl
         D4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yE9JpGydxhTrvHtUNPWenRESsALy+y19qiL+5XXZ+WI=;
        b=ApAXptHPe/GJFdHQcCN8b+TT2xjB+JXUgXsIpwqK4t3tURSoRGOsyurh+CNADHQOja
         APGRawri2gIj8S32iKA1UOgOV/Qjjl6y6ThaAaM2M++9fFyv5xtuee9gEihxVKxmVh59
         q4/KJbFmzq1bAp0PI/NDOdWqJnsUpriWrNsFOfB6Dl1xVw3LeBuJlUkcDDXBdodbfj/Y
         rQwyMvwN3+cTjFt7LMx5yt9cCsh0KALME/AQ9JwAMZZaaNXroVcOYMu2vyvJyTPARE4g
         DKvCGwY+5i6DGQg4zy8yMIyUD2jeKTlSF2aFe/3sg96waIyvZehqrMXoqnLhRh1ZnDcp
         b7ng==
X-Gm-Message-State: APjAAAXRLP7nHp+vt7yQkmzUZIH3l3Gvgck2HGIS59H+FBdU/UdJEln1
        4TG2ii7qKBcROtL8uu6TgE+776LZtABKP76SdOJAmQ==
X-Google-Smtp-Source: APXvYqxVZKOxf5Ejwvg68BPxpbCBXma6P59tHHodhcgo3GDtWunYqUaqCFn1oFNvt93tgrBoUz8ouqURwyyLzLPnxXg=
X-Received: by 2002:a9d:7410:: with SMTP id n16mr13525473otk.23.1581964693125;
 Mon, 17 Feb 2020 10:38:13 -0800 (PST)
MIME-Version: 1.0
References: <20200215002446.GA15663@paulmck-ThinkPad-P72> <20200215002520.15746-1-paulmck@kernel.org>
 <20200217123851.GR14914@hirez.programming.kicks-ass.net> <20200217182302.GD112239@google.com>
In-Reply-To: <20200217182302.GD112239@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 17 Feb 2020 19:38:01 +0100
Message-ID: <CANpmjNPci1HwEdKB9=AsZ0+UJ9Wgk9Z7ATpUXyVpiJCqSGf_Eg@mail.gmail.com>
Subject: Re: [PATCH tip/core/rcu 1/3] rcu-tasks: *_ONCE() for rcu_tasks_cbs_head
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, dipankar@in.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>, fweisbec@gmail.com,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 at 19:23, Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Mon, Feb 17, 2020 at 01:38:51PM +0100, Peter Zijlstra wrote:
> > On Fri, Feb 14, 2020 at 04:25:18PM -0800, paulmck@kernel.org wrote:
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > >
> > > The RCU tasks list of callbacks, rcu_tasks_cbs_head, is sampled locklessly
> > > by rcu_tasks_kthread() when waiting for work to do.  This commit therefore
> > > applies READ_ONCE() to that lockless sampling and WRITE_ONCE() to the
> > > single potential store outside of rcu_tasks_kthread.
> > >
> > > This data race was reported by KCSAN.  Not appropriate for backporting
> > > due to failure being unlikely.
> >
> > What failure is possible here? AFAICT this is (again) one of them
> > load-complare-against-constant-discard patterns that are impossible to
> > mess up.
>
> You mean that because we are only testing for NULL, so load/store tearing of
> rcu_tasks_cbs_head is not an issue right?
>
> I agree. Even with invented stores, worst case we have a false-wakeup and go
> right back to sleep. Or, we read a partial rcu_tasks_cbs_head, and then go
> acquire the lock and read the whole thing correctly under lock.
>
> I wonder if we can teach KCSAN to actually ignore this kind of situation so
> we don't need to employ READ_ONCE() for no reason. Basically ask it to not
> bother if the read was only NULL-testing. +Marco since it is KCSAN related.

This came up before. It requires somehow making the compiler tell us
what type of operation we're doing and in what context:
https://lore.kernel.org/lkml/CANpmjNNZQsatHexXHm4dXvA0na6r9xMgVD5R+-8d7VXEBRi32w@mail.gmail.com/

In particular:

> > This particular rule relies on semantic analysis that is beyond what
> > the TSAN instrumentation currently supports. Right now we support GCC
> > and Clang; changing the compiler probably means we'd end up with only
> > one (probably Clang), and many more years before the change has
> > propagated to the majority of used compiler versions. It'd be good if
> > we can do this purely as a change in the kernel's codebase.

Load/store tearing might not be an issue, but we also have to be aware
of things like load fusing, e.g. in a loop.

That being said, there may be ways to get similar results without yet
changing the compiler.

Thanks,
-- Marco

> thanks,
>
>  - Joel
>
>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  kernel/rcu/update.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > > index 6c4b862..a27df76 100644
> > > --- a/kernel/rcu/update.c
> > > +++ b/kernel/rcu/update.c
> > > @@ -528,7 +528,7 @@ void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
> > >     rhp->func = func;
> > >     raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
> > >     needwake = !rcu_tasks_cbs_head;
> > > -   *rcu_tasks_cbs_tail = rhp;
> > > +   WRITE_ONCE(*rcu_tasks_cbs_tail, rhp);
> > >     rcu_tasks_cbs_tail = &rhp->next;
> > >     raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
> > >     /* We can't create the thread unless interrupts are enabled. */
> > > @@ -658,7 +658,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
> > >             /* If there were none, wait a bit and start over. */
> > >             if (!list) {
> > >                     wait_event_interruptible(rcu_tasks_cbs_wq,
> > > -                                            rcu_tasks_cbs_head);
> > > +                                            READ_ONCE(rcu_tasks_cbs_head));
> > >                     if (!rcu_tasks_cbs_head) {
> > >                             WARN_ON(signal_pending(current));
> > >                             schedule_timeout_interruptible(HZ/10);
> > > --
> > > 2.9.5
> > >
