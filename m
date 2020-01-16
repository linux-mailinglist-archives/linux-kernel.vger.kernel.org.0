Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A49E013FBC9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 22:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387900AbgAPV5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 16:57:17 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33202 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387718AbgAPV5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:57:17 -0500
Received: by mail-qk1-f196.google.com with SMTP id d71so20798784qkc.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 13:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2xuhFUNXht7fcfEH+3ztlqzjosMro36By5h4pXdIHc=;
        b=Aod3SYFVPozEToTjnYF/YiRqPUPQyOs89E5qi9CDjvx1TxXnza6a/fgZ6irmTnQt4m
         Fb3MVyT4sHRpVo3xNsrMfO96EWiIZ0DlApUvn8E4JEsBQ0mWcFW1osKcYKdA5Qwuq8iS
         HUH5QtPX06IEKYllmnlLc/9+z6lQT4LJ+I7GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2xuhFUNXht7fcfEH+3ztlqzjosMro36By5h4pXdIHc=;
        b=YpCPbgiRq3Prq2W+BAThvkkeJMxo6SQAjM8wwASKCGJ0th/4hJ/IT+h6AQ/nbCdzmb
         RsWVxVCHwssMYTIvGy9c//rVUPJ7wTlaPOOYC31TAM4N+sn56Rg9WHlWwLoV8s10tXfb
         XGKkTagQB1Zn7dc1KhzODPs0QLh3D7Rw3c6f3IeJvyUcyxCPvxGiQpXPLntJ5HulA827
         Eaaj0d3Sw0kiCFyAvd3o3sHDIuSampx7zIMahA+/PK8he4fEwoBFgl6YrEvfxJWvwFyy
         Nl/baCRWYvOsRnl2wFWL3G0y/1/Seqb7cX1rGJL/739yjvB+21qeOtb4ilbgRb+z4H1j
         Cd5g==
X-Gm-Message-State: APjAAAVevEjcrJjZyoVOtRkh6nhfS8qsnzCgdumTxOk2DcW2t0aDntdQ
        VChNG6ZHtXJ1XzR2l11Llc0TaP9qq/OZxDtq1wR+9w==
X-Google-Smtp-Source: APXvYqwy0IyiHirF5i1IcksR3wA9s3xZ6I9TI5yFROp2tDU1qUGmXAIsqH+a8/E5utq4wNqF047xga5FoevcUgRlqCA=
X-Received: by 2002:a37:6d47:: with SMTP id i68mr1496273qkc.228.1579211836142;
 Thu, 16 Jan 2020 13:57:16 -0800 (PST)
MIME-Version: 1.0
References: <20191004145741.118292-1-joel@joelfernandes.org> <20191004154102.GA20945@redhat.com>
In-Reply-To: <20191004154102.GA20945@redhat.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 16 Jan 2020 16:57:05 -0500
Message-ID: <CAEXW_YS20r3shEwk8GCTY9NcQB+duzTc82ROo5xgWakJwvKRRQ@mail.gmail.com>
Subject: Re: [PATCH] Remove GP_REPLAY state from rcu_sync
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 11:41 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 10/04, Joel Fernandes (Google) wrote:
> >
> > But this is not always true if you consider the following events:
>
> I'm afraid I missed your point, but...
>
> > ---------------------->
> > GP num         111111     22222222222222222222222222222222233333333
> > GP state  i    e     p    x                 r              rx     i
> > CPU0 :         rse      rsx
> > CPU1 :                         rse     rsx
> > CPU2 :                                         rse     rsx
> >
> > Here, we had 3 grace periods that elapsed, 1 for the rcu_sync_enter(),
> > and 2 for the rcu_sync_exit(s).
>
> But this is fine?
>
> We only need to ensure that we have a full GP pass between the "last"
> rcu_sync_exit() and GP_XXX -> GP_IDLE transition.
>
> > However, we had 3 rcu_sync_exit()s, not 2. In other words, the
> > rcu_sync_exit() got batched.
> >
> > So my point here is, rcu_sync_exit() does not really always cause a new
> > GP to happen
>
> See above, it should not.
>
> > Then what is the point of the GP_REPLAY state at all if it does not
> > always wait for a new GP?
>
> Again, I don't understand... GP_REPLAY ensures that we will have a full GP
> before rcu_sync_func() sets GP_IDLE, note that it does another "recursive"
> call_rcu() if it sees GP_REPLAY.

I finally got back to this (meanwhile life, job things happened). You
are right, only the last one needs a full GP and it does get one here.
Probably a comment in rcu_sync_exit() explaining this might help the
future reader.

Basically you are saying, if rcu_sync_exit() happens and GP_REPLAY is
already set, we need not worry about starting a new GP because
GP_REPLAY->GP_EXIT->GP_IDLE transition will involve a full GP anyway.
And only if, GP_EXIT is already set, then we must set GP_REPLAY and
wait for a full GP.  This ensures the last rcu_sync_exit() gets a full
GP. I think that was what I was missing. Some reason I thought that
every rcu_sync_exit() needs to start a full GP.

thanks!

- Joel
