Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA52176242
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 19:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgCBSRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 13:17:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50508 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBSRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:17:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so97497wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 10:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dkIKEunspbm7vvq6Vi7LSmhvIa5CNrgbE4fc3Br8gcw=;
        b=h9/BYT0VV2933Zm22oDgQkHPwM72o7HYQz9S7NzgkkgRrea96GrmK83XN6Dos7mqKs
         z4GsyLPp8KOMpPr6Qp7h0GIQUDd/oE7wFSAu3cZTEY1S/wneOyE1xhZZBGFe0IGKk0Ts
         qtwVg0tg/yQp8T9kt88RWKiynfu8Fmp9+rAZnaRihMEzD/ult8LcDzHiVjvkYYaTjTC3
         ZveMnddiHf7gGU9/jMOSKKManlXqEBYg1zO4ylD2sjOSUYsnkjiL6U79qox495/8jEvB
         aWAR/SBOK2sWQCLb8/6GdrKTuP7OUdoQUkbh6enUFhDMXtSbaiaVZozLzSlJlqFUFFUr
         wPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dkIKEunspbm7vvq6Vi7LSmhvIa5CNrgbE4fc3Br8gcw=;
        b=FLU2yhrY8WIffRhDPFmH5XInUyKyQKv/cPwXGB8RgdPUeFhhWvwjkYt+lt3ZvUHPSD
         K+MOLxzOmXICRKNOTZ+DHfJ9qJ6aD/VpT8n6weVzsgu9mftBCfr1IRnhigMRJNzHQKfD
         mdYZ7nvTn5Sio2539tJ/lD8j9aFR6MtgwH2Ry4S6syocLQOWJA0TkmAXt4BTRvenBY0d
         d2vDzE1MDI0ziP7gnI4XWr1ZcUzWAheaOLiDW+Mcq9sAHbJX7KRNire6EMteNr0cbJly
         A8KDnNo0DMJbTT5nNIQzRD5aY3/M6ciA7mPirYnGs7RQzberKbhjiKALHgvmFlWTukmM
         hPhw==
X-Gm-Message-State: ANhLgQ1Lvk+pyDHoxEcCPe1TP7WOlVZauwihGwIOpd7xq0mTYxt1L6N6
        5YLfw1ojdmPjcmWT/A1Z53rdLTPbOqJeBKCTbdQnJg==
X-Google-Smtp-Source: ADFU+vvJUfmM/0m2Kl1r0i8TEF6siBJ+sIaFFcE7R5SjUcp7lrhaI05WmNC97vrwgYF1aGK1og4oSP3PEBQrrbmvIW4=
X-Received: by 2002:a1c:e0d6:: with SMTP id x205mr122589wmg.29.1583173035221;
 Mon, 02 Mar 2020 10:17:15 -0800 (PST)
MIME-Version: 1.0
References: <20200302130430.201037-1-glider@google.com> <20200302130430.201037-2-glider@google.com>
 <0eaac427354844a4fcfb0d9843cf3024c6af21df.camel@perches.com>
 <CAG_fn=VNnxjD6qdkAW_E0v3faBQPpSsO=c+h8O=yvNxTZowuBQ@mail.gmail.com> <4cac10d3e2c03e4f21f1104405a0a62a853efb4e.camel@perches.com>
In-Reply-To: <4cac10d3e2c03e4f21f1104405a0a62a853efb4e.camel@perches.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 2 Mar 2020 19:17:02 +0100
Message-ID: <CAG_fn=XOyPGau9m7x8eCLJHy3m-H=nbMODewWVJ1xb2e+BPdFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] binder: do not initialize locals passed to copy_from_user()
To:     Joe Perches <joe@perches.com>
Cc:     Todd Kjos <tkjos@google.com>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 3:00 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-03-02 at 14:25 +0100, Alexander Potapenko wrote:
> > On Mon, Mar 2, 2020 at 2:11 PM Joe Perches <joe@perches.com> wrote:
> > > On Mon, 2020-03-02 at 14:04 +0100, glider@google.com wrote:
> > > > Certain copy_from_user() invocations in binder.c are known to
> > > > unconditionally initialize locals before their first use, like e.g. in
> > > > the following case:
> > > []
> > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > []
> > > > @@ -3788,7 +3788,7 @@ static int binder_thread_write(struct binder_proc *proc,
> > > >
> > > >               case BC_TRANSACTION_SG:
> > > >               case BC_REPLY_SG: {
> > > > -                     struct binder_transaction_data_sg tr;
> > > > +                     struct binder_transaction_data_sg tr __no_initialize;
> > > >
> > > >                       if (copy_from_user(&tr, ptr, sizeof(tr)))
> > >
> > > I fail to see any value in marking tr with __no_initialize
> > > when it's immediately written to by copy_from_user.
> >
> > This is being done exactly because it's immediately written to by copy_to_user()
> > Clang is currently unable to figure out that copy_to_user() initializes memory.
> > So building the kernel with CONFIG_INIT_STACK_ALL=y basically leads to
> > the following code:
> >
> >   struct binder_transaction_data_sg tr;
> >   memset(&tr, 0xAA, sizeof(tr));
> >   if (copy_from_user(&tr, ptr, sizeof(tr))) {...}
> >
> > This unnecessarily slows the code down, so we add __no_initialize to
> > prevent the compiler from emitting the redundant initialization.
>
> So?  CONFIG_INIT_STACK_ALL by design slows down code.
Correct.

> This marking would likely need to be done for nearly all
> 3000+ copy_from_user entries.
Unfortunately, yes. I was just hoping to do so for a handful of hot
cases that we encounter, but in the long-term a compiler solution must
supersede them.

> Why not try to get something done on the compiler side
> to mark the function itself rather than the uses?
This is being worked on in the meantime as well (see
http://lists.llvm.org/pipermail/cfe-dev/2020-February/064633.html)
Do you have any particular requisitions about how this should look on
the source level?
