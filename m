Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1118F5853
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 21:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfKHUSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 15:18:02 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:34829 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfKHUSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:18:02 -0500
Received: by mail-il1-f194.google.com with SMTP id z12so6257548ilp.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 12:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FDDCgDX90thNxxfNAJr61/C3QsaQDVp61gK+9DADaCE=;
        b=GR0/8SrVdiMBYUxZ534C7fSRxxw3md46Vi65wd536ugg0UKVh9jxmRB2m+zW+t8wv0
         t13oNPqVr5XqneEG1AQf+FMgHV6CR8CFUqVwCWtsd0fadxpREq0ttBPzhHh5YSvqh0Zl
         DkKC6nqf3HbKLNmyZyA3VzPBWFgGXnNvmcCLiufmHELygQhP6GPvRU3xw2zRfIZNhgd+
         wS1zcSbZ8T54SMqCJhJAH3x5v7zxbw9nBcK0BFax4wqlm5mOSnFXox0CMJRqnXk2TIC4
         yWM36tBjzxpughTm7tytzKQCD5AupU263+QKvP/1D8B1Hf9tNb53DsPvx0IvbaipojRG
         X2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDDCgDX90thNxxfNAJr61/C3QsaQDVp61gK+9DADaCE=;
        b=tUEdnumQbR1F7qWEK8ben+kSsBRW35FDCYcdBSJUIQTVoCu1ZVCc58qlRkDIpUo4J8
         Nhctc3IuvzPg/RsslVfmuAcuCgnJ2q545QHRiEvtYNPj0qc5HDNNzfUd75b/Mg8qFyqr
         lZQOy8ZU1hcFZKEUdMWlUbMT9m1JQRByGOI/uRhdLUEWPXnZQTnSl7LzBhLxyGjXRXRG
         /ECYmO2s5dTDd4/WzY7MkCg0HgbVNcAZVFGD4hlX3De+8xUw/anQULhIyblMHgT01cXD
         3eg7GRybsu2pi+3gbR+HjBBB+IcGedtPaDFoCLP5YoDc74n6kuqD4a8yAcuXpl2/cd3H
         7xpQ==
X-Gm-Message-State: APjAAAVXh0Fs3S37W1irNSrKHWVKI0OyF9R+tSJrf0Al3KJ0I0mp/kkF
        TBz+TdeyqB7v2byOPndzEnTdUvGgGi3u798AYNBOFg==
X-Google-Smtp-Source: APXvYqyPmLFkUL1RSFnO3HUuXh27M5xTqmnGqEVN8d8xz0lfpM//maHYgBCFACYtGeCCNyY6Bxhcu7mB3jvpWSpWLFk=
X-Received: by 2002:a92:109c:: with SMTP id 28mr14803599ilq.142.1573244280924;
 Fri, 08 Nov 2019 12:18:00 -0800 (PST)
MIME-Version: 1.0
References: <20191107193738.195914-1-edumazet@google.com> <20191108192448.GB20975@paulmck-ThinkPad-P72>
In-Reply-To: <20191108192448.GB20975@paulmck-ThinkPad-P72>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 8 Nov 2019 12:17:49 -0800
Message-ID: <CANn89iKNLESN7U7BtyzkC6WLVn__Hm727A5cRm6PDuzG5+E4vA@mail.gmail.com>
Subject: Re: [PATCH 1/2] list: add hlist_unhashed_lockless()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 11:24 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Nov 07, 2019 at 11:37:37AM -0800, Eric Dumazet wrote:
> > We would like to use hlist_unhashed() from timer_pending(),
> > which runs without protection of a lock.
> >
> > Note that other callers might also want to use this variant.
> >
> > Instead of forcing a READ_ONCE() for all hlist_unhashed()
> > callers, add a new helper with an explicit _lockless suffix
> > in the name to better document what is going on.
> >
> > Also add various WRITE_ONCE() in __hlist_del(), hlist_add_head()
> > and hlist_add_before()/hlist_add_behind() to pair with
> > the READ_ONCE().
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
>
> I have queued this, but if you prefer it go some other way:
>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
>
> But shouldn't the uses in include/linux/rculist.h also be converted
> into the patch below?  If so, I will squash the following into your
> patch.
>
>                                                 Thanx, Paul
>
> ------------------------------------------------------------------------

Agreed, thanks for the addition of this Paul.
