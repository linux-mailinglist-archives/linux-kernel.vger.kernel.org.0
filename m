Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD567F1F6E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 21:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbfKFUA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 15:00:56 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:40759 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfKFUAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:00:55 -0500
Received: by mail-il1-f193.google.com with SMTP id d83so22937070ilk.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 12:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/3y/HsMnf3xjkCgZbJ75a/7ySpMXpDRsiX47kiV0kas=;
        b=eucGx3ixQjhVaCvF6gXziLvcJkw+l6DT+Q2wVTm+1guyoIEvME5ivibD3nG90DcL48
         /RPdlQxbnO9icQEWOrKZKL65lcRO/ZXPS4Kydrh8k4kcHLsBhUtDbF9YgQl43KJvHmaY
         Oi4BiUML2CSaZZDdjA+s36gFtX0TN3uKXSiNNkRB3D8ASzWP4yX8trfgXsRoczPEwUwo
         h7Gh0/1eoFhAKbmLQC+yjkje2G+gUDp1zE/q9A8fECmAxQXiBwxmMmQjmJlhEGpckqGx
         zI6XXMAJl2KB6y/wMFC8frqM3eSb2gP5zjb3jjv1QBS0kfKI4zlA+4OSOFQPJZbOgcjB
         8NtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/3y/HsMnf3xjkCgZbJ75a/7ySpMXpDRsiX47kiV0kas=;
        b=oou7NPs8zYoI9IlEQr/VVx7uwjyZloBUv7XiuohMGCLadQUifP9YnMOrbuaFNo+6Xw
         bvWKH5ON6mb4Etj9fAr9U+zNVeNDbWXf3UEWZtpUj1leM0/8dlDCczMossw3+s9RQHyv
         FdN2d0VLuZdEbmpDWZ8ipyGmaQi0dK5UB2ksQrXPveFBBEPnA1lviFVIreBiE7DxonM3
         BKe+AEIfJyIPRub/hAXX3YCg6QnMjqHL51mITtQiOEXFi3/6LIWYIUbdH2iWMOQ+mzK+
         6zYeKKOV4DdloqJkinXFy9MBKW31FBAgSaQ0KeLjqWyHLzL40CFkoX2UbHhdi5IVtmPm
         FRTw==
X-Gm-Message-State: APjAAAVLkr6ZnIhni6sRR21GxieQvMCyeYKSlPVxPdrnZxE16JJ+Ptfs
        NDsyCDkICQtQIsDh8Lm93eGtiv+TEw/wGQK+eq2M09tl
X-Google-Smtp-Source: APXvYqxzuW3h2H4ygtVCpGc8gJSsSyu+Opcy9pvD2+7FVap80uBzotktHcyZz55nwKcJx3XxCyODCD9OorXkwYezZUs=
X-Received: by 2002:a92:ca8d:: with SMTP id t13mr4636539ilo.58.1573070454269;
 Wed, 06 Nov 2019 12:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20191106174804.74723-1-edumazet@google.com> <alpine.DEB.2.21.1911061908070.1869@nanos.tec.linutronix.de>
 <CANn89iK12QGBagUiNr+j-ToawJ9J1behtySyL9vLattYPAD-7w@mail.gmail.com> <alpine.DEB.2.21.1911062002490.1869@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911062002490.1869@nanos.tec.linutronix.de>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 6 Nov 2019 12:00:42 -0800
Message-ID: <CANn89i+adxqR+L7ArTQhOmvryO0++ajf1FHt7bQcCnUkEkgu+g@mail.gmail.com>
Subject: Re: [PATCH] hrtimer: Annotate lockless access to timer->state
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 11:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, 6 Nov 2019, Eric Dumazet wrote:
> > On Wed, Nov 6, 2019 at 10:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > On Wed, 6 Nov 2019, Eric Dumazet wrote:
> > > > @@ -1013,8 +1013,9 @@ static void __remove_hrtimer(struct hrtimer *timer,
> > > >  static inline int
> > > >  remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base, bool restart)
> > > >  {
> > > > -     if (hrtimer_is_queued(timer)) {
> > > > -             u8 state = timer->state;
> > > > +     u8 state = timer->state;
> > >
> > > Shouldn't that be a read once then at least for consistency sake?
> >
> > We own the lock here, this is not really needed ?
> >
> > Note they are other timer->state reads I chose to leave unchanged.
> >
> > But no big deal if you prefer I can add a READ_ONCE()
>
> Nah. I can add it myself if at all.
>
> I know that the READ_ONCE() is not required there, but I really hate to
> twist my brain when staring at code why some places use it and some not.
>
> So at least some commentry helps to avoid that. Something like the
> below. If you have no objections I just queue the patch with this folded
> in.


This looks good to me, thanks !

>
> Thanks,
>
>         tglx
>
> 8<-------------
> --- a/include/linux/hrtimer.h
> +++ b/include/linux/hrtimer.h
> @@ -456,12 +456,18 @@ extern u64 hrtimer_next_event_without(co
>
>  extern bool hrtimer_active(const struct hrtimer *timer);
>
> -/*
> - * Helper function to check, whether the timer is on one of the queues
> +/**
> + * hrtimer_is_queued = check, whether the timer is on one of the queues
> + * @timer:     Timer to check
> + *
> + * Returns: True if the timer is queued, false otherwise
> + *
> + * The function can be used lockless, but it gives only a momentary snapshot.
>   */
> -static inline int hrtimer_is_queued(struct hrtimer *timer)
> +static inline bool hrtimer_is_queued(struct hrtimer *timer)
>  {
> -       return READ_ONCE(timer->state) & HRTIMER_STATE_ENQUEUED;
> +       /* The READ_ONCE pairs with the update functions of timer->state */
> +       return !!READ_ONCE(timer->state) & HRTIMER_STATE_ENQUEUED;
>  }
>
>  /*
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -966,6 +966,7 @@ static int enqueue_hrtimer(struct hrtime
>
>         base->cpu_base->active_bases |= 1 << base->index;
>
> +       /* Pairs with the lockless read in hrtimer_is_queued() */
>         WRITE_ONCE(timer->state, HRTIMER_STATE_ENQUEUED);
>
>         return timerqueue_add(&base->active, &timer->node);
> @@ -988,6 +989,7 @@ static void __remove_hrtimer(struct hrti
>         struct hrtimer_cpu_base *cpu_base = base->cpu_base;
>         u8 state = timer->state;
>
> +       /* Pairs with the lockless read in hrtimer_is_queued() */
>         WRITE_ONCE(timer->state, newstate);
>         if (!(state & HRTIMER_STATE_ENQUEUED))
>                 return;
