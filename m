Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A993E14F2A0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 20:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgAaTUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 14:20:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33181 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgAaTUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 14:20:30 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so7667510otp.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 11:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T8WeVLJFFFH8djnVi87maSBmRCBApkHIBoZpRfNccoA=;
        b=nR79PYohsTzCz5cNfXYRIt+l41EBsbUtCbXHzZjbEV5q1HUmVDODMN5msNQWs0oZh3
         HiIoaNVPyw7sto/w6aKrfxjhLbLqp361cl9yA4/nFOsUCOqd8SOEp1DLhfnK6p/67OJf
         w69BApYbgyJhvL+lKOn2r1C5hYqJmmbsIjYYnJYlHfp4SAUNDVJObo6YOFrIcS0vi7AO
         0FNcc0+6u5dW/1KW+MoxjqMp8kcJTaOomCgGqsHzSJCtHvFHpt/SDIANe8hJ+hXzYJDs
         Y+gJjKNjku4VTleEsmHEoTynXe57gx22LRi+h95L+TyfhFxcGhc7MlntWITpVu2Ra9mq
         ry0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8WeVLJFFFH8djnVi87maSBmRCBApkHIBoZpRfNccoA=;
        b=oKKUfijss/JTQB9J9LdGzHykxZCcmmmUwtZneaQ1URpw0dusqAroZ5Lb67E+gBwxH8
         TF8t4GdL9revzKiEJoB/gyei96yXXC4/bAXMB09uO81Bu6fXZ9oyo6rIYND0T3VW4sC9
         6R3/OTJS235vdg1xd1OchgZ5ZiG3xJo+XsusAR7mGcMuECV4qL/7qPKYUuDbwPZTrFsY
         6sMEbwH+YuWM+SWP/v7sQmM+kmEW0naj4jzH5SUN45WidSRCxNzb8yCMPAzbXJ2zDp0A
         0gUIEULOfO3Ic8TetSr3OGqI/I5M6itaxfm5urfh2Q6CUrieS9qnOo7kdgM/nysPRnnM
         yCuA==
X-Gm-Message-State: APjAAAWpiRK8Mbheh+L5/0o6HtgQ8iFr4m+q0PJFL74Ex8P4l11PQiEz
        e2wjZwlYuncoRkmtWOY7UsdhZV9OPeyDH5pf2l6swg==
X-Google-Smtp-Source: APXvYqyLD9SmHKsx9hJOeVrwFaMJ4AuOhEOcW5R9F69KGJpPU72g4f9ctu6rfU5Ke5ARd/RN+59l7xRoo9qUpdfbqZ4=
X-Received: by 2002:a9d:7410:: with SMTP id n16mr9027520otk.23.1580498429740;
 Fri, 31 Jan 2020 11:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20200131164308.GA5175@willie-the-truck> <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131184322.GA11457@worktop.programming.kicks-ass.net> <CANn89iLBL1qbrEucm2FU02oNbf=x3_4K93TmZ3yS2ZNWm8Qrsg@mail.gmail.com>
In-Reply-To: <CANn89iLBL1qbrEucm2FU02oNbf=x3_4K93TmZ3yS2ZNWm8Qrsg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 31 Jan 2020 20:20:17 +0100
Message-ID: <CANpmjNPb8vsNd=P3f0xASWf4i6d_9KHGWGGWGD2p+GViubQDPA@mail.gmail.com>
Subject: Re: Confused about hlist_unhashed_lockless()
To:     Eric Dumazet <edumazet@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 at 19:48, Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Jan 31, 2020 at 10:43 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Jan 31, 2020 at 08:48:05AM -0800, Eric Dumazet wrote:
> > >     BUG: KCSAN: data-race in del_timer / detach_if_pending
> >
> > > diff --git a/include/linux/timer.h b/include/linux/timer.h
> > > index 1e6650ed066d5d28251b0bd385fc37ef94c96532..0dc19a8c39c9e49a7cde3d34bfa4be8871cbc1c2
> > > 100644
> > > --- a/include/linux/timer.h
> > > +++ b/include/linux/timer.h
> > > @@ -164,7 +164,7 @@ static inline void destroy_timer_on_stack(struct
> > > timer_list *timer) { }
> > >   */
> > >  static inline int timer_pending(const struct timer_list * timer)
> > >  {
> > > - return timer->entry.pprev != NULL;
> > > + return !hlist_unhashed_lockless(&timer->entry);
> > >  }
> >
> > That's just completely wrong.
> >
> > Aside from any memory barrier issues that might or might not be there
> > (I'm waaaay to tired atm to tell), the above code is perfectly fine.
> >
> > In fact, this is a KCSAN compiler infrastructure 'bug'.
> >
> > Any load that is only compared to zero is immune to load-tearing issues.

We're not just fighting load-tearing, but also other compiler
optimizations. Eric pointed out the loop case:

while (!timer_pending(..)) { }

Without a READ_ONCE, the compiler can turn this into:

if (!timer_pending(..)) {
  while (true) { }
}

So, unless we can enumerate all possible cases in which a compare to 0
data race can occur, and prove they're all safe for all compiler
optimizations, could we plase not claim it's a general KCSAN compiler
infrastructure bug.

This also makes me second-guess if the osq_lock case is safe (looking
at it, I think it's still safe, but only because the surrounding ops
imply compiler barriers and the compiler then won't mess up the loop).

> > The correct thing to do here is something like:
> >
> > static inline int timer_pending(const struct timer_list *timer)
> > {
> >         /*
> >          * KCSAN compiler infrastructure is insuffiently clever to
> >          * realize that a 'load compared to zero' is immune to
> >          * load-tearing.
> >          */

I could agree with this if we knew the context in which this is used.
Unfortunately we do not know the context (unlike osq_lock), and for
all we know it could be used in a loop.

> >         return data_race(timer->entry.pprev != NULL);
> > }
>
>
> This is nice, now with have data_race()

Again, if you use 'data_race()' you'll have to prove that it'll be
safe in all cases, for all compiler versions current and present. The
READ_ONCE would take that burden from you.

Thanks,
-- Marco

> Remember these patches were sent 2 months ago, at a time we were
> trying to sort out things.
>
> data_race() was merged a few days ago.
