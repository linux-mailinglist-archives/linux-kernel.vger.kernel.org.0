Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C6B167E1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 18:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfEGQ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 12:29:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41674 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfEGQ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:29:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id d12so2752006wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c5+HOOPjtVbBo+8gy8vNmbmMcaHMqGZxYXAym2RjAtc=;
        b=v+8Aj1+Gzh9xAnJJxTKBz5IK7NFM9zFnPBDBO6Jm8AvvbnH1v7/uyOpfFqno1rg2Zy
         fWlzgtf4P3z9BwjWzOPCVXxpfYQLRYcUGluLq7rfauxlh27T1igPdhO2PnmRmDrIzUZb
         33S/UPvcIKxDgySDvLphqkCw3nx66UVkzdh2llSzJaaZDYeQjUp1GcwIRKMf4Fd2qexE
         pdGjzUCJ0cl2KrpuTdYemEjJKYL6rrWeGL4OEu6CfqNZbV6vGok2PFHNRvDxGe1TFozQ
         Qc+ua3Dhgf5+4cL3nsEmG5URl479U6yNuIsdqC58anKp1C+pQdCb7goL/K4F1m96V0sQ
         DdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c5+HOOPjtVbBo+8gy8vNmbmMcaHMqGZxYXAym2RjAtc=;
        b=RT5sWV7/c984A5woM29zzo0nIN3jjzXIbUipdL82ew1d200PA4u6DuFDxMID/6C1h+
         ijosiOPjLCsJmLmdkRLwz5Vu3IiW9cq1GeRgn4PPm72AN4k6jNDTmKwnYwEM5843A8xU
         XBpovXGCS9wfhvhacFR6reZhWzmOtrHGkf0YB11UpZJk9BIisenuOHNYLTwShZn3gEIT
         QtZbVJwFo/zgTu4x8rBJuZGpzLFW5QhGuXamaBynYnXD48yP0Zy4ipLE3WSH4xUHCZkO
         B00uF+N88L1yXlX5H+Gn4tyUft6B3nK+y5FO2dMGAp2GLTA6UB42QH2fTLqrG25pVZ75
         LbRA==
X-Gm-Message-State: APjAAAWNY/xlRULZQNKtgyL9+tnxCnsgWoS6Pa9+2kpgr7tMNnV9tsLc
        EjmjuNlHNPP9sMFW+/flNJIAjr5lqWl5pMM51bNSJg==
X-Google-Smtp-Source: APXvYqym1S8ixk/XT+rtdrTBe5tWrchiuDfbT6Q3mS29Rpb1RGpNAAYDcvRlOaaUxs5q8h8UIab6C7KWUWz1lN8rgvo=
X-Received: by 2002:a5d:60cd:: with SMTP id x13mr3984822wrt.291.1557246540040;
 Tue, 07 May 2019 09:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190318235052.GA65315@google.com> <20190319221415.baov7x6zoz7hvsno@brauner.io>
 <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
 <20190319231020.tdcttojlbmx57gke@brauner.io> <20190320015249.GC129907@google.com>
 <20190507021622.GA27300@sultan-box.localdomain> <20190507070430.GA24150@kroah.com>
 <20190507072721.GA4364@sultan-box.localdomain> <20190507074334.GB26478@kroah.com>
 <20190507081236.GA1531@sultan-box.localdomain> <20190507105826.oi6vah6x5brt257h@brauner.io>
In-Reply-To: <20190507105826.oi6vah6x5brt257h@brauner.io>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 7 May 2019 09:28:47 -0700
Message-ID: <CAJuCfpFeOVzDUq5O_cVgVGjonWDWjVVR192On6eB5gf==_uPKw@mail.gmail.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
To:     Christian Brauner <christian@brauner.io>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Daniel Colascione <dancol@google.com>,
        Todd Kjos <tkjos@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Martijn Coenen <maco@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@amacapital.net>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian@brauner.io>
Date: Tue, May 7, 2019 at 3:58 AM
To: Sultan Alsawaf
Cc: Greg Kroah-Hartman, open list:ANDROID DRIVERS, Daniel Colascione,
Todd Kjos, Kees Cook, Peter Zijlstra, Martijn Coenen, LKML, Tim
Murray, Michal Hocko, Suren Baghdasaryan, linux-mm, Arve Hj=C3=B8nnev=C3=A5=
g,
Ingo Molnar, Steven Rostedt, Oleg Nesterov, Joel Fernandes, Andy
Lutomirski, kernel-team

> On Tue, May 07, 2019 at 01:12:36AM -0700, Sultan Alsawaf wrote:
> > On Tue, May 07, 2019 at 09:43:34AM +0200, Greg Kroah-Hartman wrote:
> > > Given that any "new" android device that gets shipped "soon" should b=
e
> > > using 4.9.y or newer, is this a real issue?
> >
> > It's certainly a real issue for those who can't buy brand new Android d=
evices
> > without software bugs every six months :)
> >

Hi Sultan,
Looks like you are posting this patch for devices that do not use
userspace LMKD solution due to them using older kernels or due to
their vendors sticking to in-kernel solution. If so, I see couple
logistical issues with this patch. I don't see it being adopted in
upstream kernel 5.x since it re-implements a deprecated mechanism even
though vendors still use it. Vendors on the other hand, will not adopt
it until you show evidence that it works way better than what
lowmemorykilled driver does now. You would have to provide measurable
data and explain your tests before they would consider spending time
on this.
On the implementation side I'm not convinced at all that this would
work better on all devices and in all circumstances. We had cases when
a new mechanism would show very good results until one usecase
completely broke it. Bulk killing of processes that you are doing in
your patch was a very good example of such a decision which later on
we had to rethink. That's why baking these policies into kernel is
very problematic. Another problem I see with the implementation that
it ties process killing with the reclaim scan depth. It's very similar
to how vmpressure works and vmpressure in my experience is very
unpredictable.

> > > And if it is, I'm sure that asking for those patches to be backported=
 to
> > > 4.4.y would be just fine, have you asked?
> > >
> > > Note that I know of Android Go devices, running 3.18.y kernels, do NO=
T
> > > use the in-kernel memory killer, but instead use the userspace soluti=
on
> > > today.  So trying to get another in-kernel memory killer solution add=
ed
> > > anywhere seems quite odd.
> >
> > It's even more odd that although a userspace solution is touted as the =
proper
> > way to go on LKML, almost no Android OEMs are using it, and even in tha=
t commit
>
> That's probably because without proper kernel changes this is rather
> tricky to use safely (see below).
>
> > I linked in the previous message, Google made a rather large set of
> > modifications to the supposedly-defunct lowmemorykiller.c not one month=
 ago.
> > What's going on?

If you look into that commit, it adds ability to report kill stats. If
that was a change in how that driver works it would be rejected.

> >
> > Qualcomm still uses lowmemorykiller.c [1] on the Snapdragon 845. If PSI=
 were
> > backported to 4.4, or even 3.18, would it really be used? I don't reall=
y
> > understand the aversion to an in-kernel memory killer on LKML despite t=
he rest
> > of the industry's attraction to it. Perhaps there's some inherently gre=
at cost
> > in using the userspace solution that I'm unaware of?

Vendors are cautious about adopting userspace solution and it is a
process to address all concerns but we are getting there.

> > Regardless, even if PSI were backported, a full-fledged LMKD using it h=
as yet to
> > be made, so it wouldn't be of much use now.
>
> This is work that is ongoing and requires kernel changes to make it
> feasible. One of the things that I have been working on for quite a
> while is the whole file descriptor for processes thing that is important
> for LMKD (Even though I never thought about this use-case when I started
> pitching this.). Joel and Daniel have joined in and are working on
> making LMKD possible.
> What I find odd is that every couple of weeks different solutions to the
> low memory problem are pitched. There is simple_lkml, there is LMKD, and
> there was a patchset that wanted to speed up memory reclaim at process
> kill-time by adding a new flag to the new pidfd_send_signal() syscall.
> That all seems - though related - rather uncoordinated.

I'm not sure why pidfd_wait and expedited reclaim is seen as
uncoordinated effort. All of them are done to improve userspace LMKD.

> Now granted,
> coordinated is usually not how kernel development necessarily works but
> it would probably be good to have some sort of direction and from what I
> have seen LMKD seems to be the most coordinated effort. But that might
> just be my impression.
>
> Christian

Thanks,
Suren.
