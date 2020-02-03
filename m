Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD0CE150A54
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 16:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgBCPzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 10:55:02 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45377 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgBCPy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:54:59 -0500
Received: by mail-oi1-f196.google.com with SMTP id v19so15165385oic.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 07:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgf71URhUKo2b+JGoC+JLVlsL/X5hBwyfojNmfsCYOE=;
        b=Yo3ATNA0fsuI7QjC1JZ3Q3rmuAp3lsDLGlP3bTGe1BG3puDi0Ccm+P4BpEHT3x7i+Y
         cmrF/ZvZM/7FcMIsG7h1eYOeEart4fDBof2CUozfgJCz0ObpEG8s6LjrtOsPoYNswGXO
         KbPumgE2Qgz23VpgAm2UkqgHdwFM5Z9Vy/M+6f9i5ogcOweFv2DwvZtc+1SgdVcgkroz
         C+uv/h6aKSs4J3cj9DVUEbfctPkIV4634t+3DZ2AGh1whCe5/WXE7qwwOMCqACSoB5C9
         XxjAd3tjalgrtDXmItBSa5njGkbRf8aijyhurnAV8KW7gJAV59sEZJPMCjpFUUXfXw93
         9J4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgf71URhUKo2b+JGoC+JLVlsL/X5hBwyfojNmfsCYOE=;
        b=uPndRMm6FNkDi/l7jZr3XBKqEqP1StMZFFv54GiBUbhrKbB9VXHe9eZwgOvA8fQgXr
         UuraByUechxAjOAm2XiAZ6OQVDWQINdjP0YGUo3YZDCZ4g/EvVCJ1WkMISUoohEwC6YQ
         8FcfKDXWWV/PjurVj79PG4I8gYVSFixOtuhcPBecc/FBEt8D/fQCkXZG1bhorxoyJz0i
         SVg5GvDlko5PS1OuASIgJ5+emYhx4NPB7WPcn7Y4cOxJVYWZoAvzFbEXDvuAvmosaF1B
         MAt1rvZlvumdiWXPARVXEKmn/P14wT5fo6ydLDkyk7Ly601X0VFzkGPucRF5IhnE0gXW
         lQ9A==
X-Gm-Message-State: APjAAAW7eJLYLvWoPOoB16cxnrCqYHETbm3kP2HIysbakbwoCjnQ3VlM
        qw3pfz81ojcNafG/UqeL7O1GFxfHSlbkrhPM1rBnXw==
X-Google-Smtp-Source: APXvYqyKKc70OaT8UMs3uai3fU3zUSEujYZM/nuqWBuvVV/WutNpjFsZxAsdqNVwSshj1nNF2u2aHTW/qSlgO15Us5k=
X-Received: by 2002:aca:b183:: with SMTP id a125mr15332483oif.83.1580745298563;
 Mon, 03 Feb 2020 07:54:58 -0800 (PST)
MIME-Version: 1.0
References: <20200131164308.GA5175@willie-the-truck> <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131184322.GA11457@worktop.programming.kicks-ass.net>
 <CANn89iLBL1qbrEucm2FU02oNbf=x3_4K93TmZ3yS2ZNWm8Qrsg@mail.gmail.com>
 <CANn89i+pExLRqJxbamGv=uDi2kWY-1CKsh1DcAgfdh9DjpQx3A@mail.gmail.com> <26258e70c35e4c108173a27317e64a0b@AcuMS.aculab.com>
In-Reply-To: <26258e70c35e4c108173a27317e64a0b@AcuMS.aculab.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 3 Feb 2020 16:54:47 +0100
Message-ID: <CANpmjNNVstV4AJHtf0aht1xyj+_a-Kj4so4Mi1DpOWDPYN=-2Q@mail.gmail.com>
Subject: Re: Confused about hlist_unhashed_lockless()
To:     David Laight <David.Laight@aculab.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Mon, 3 Feb 2020 at 16:45, David Laight <David.Laight@aculab.com> wrote:
>
> From: Eric Dumazet
> > Sent: 31 January 2020 18:53
> >
> > On Fri, Jan 31, 2020 at 10:48 AM Eric Dumazet <edumazet@google.com> wrote:
> > >
> >
> > > This is nice, now with have data_race()
> > >
> > > Remember these patches were sent 2 months ago, at a time we were
> > > trying to sort out things.
> > >
> > > data_race() was merged a few days ago.
> >
> > Well, actually data_race() is not there yet anyway.
>
> Shouldn't it be NO_DATA_RACE() ??

Various options were considered, and based on feedback from Linus,
decided 'data_race(..)' is the best option:
  https://lore.kernel.org/linux-fsdevel/CAHk-=wg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDnFqbY7HL5AB2g@mail.gmail.com/

It's meant to be as unobtrusive as possible, and an all-caps macro was
ruled out.

Second, the "NO_" prefix would be incorrect, since it'd be the
opposite of what it is. The macro is meant to document and mark a
deliberate data race.

Thanks,
-- Marco
