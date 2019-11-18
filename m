Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D16AC10095B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 17:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKRQlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 11:41:22 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32911 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfKRQlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:41:22 -0500
Received: by mail-ot1-f68.google.com with SMTP id u13so15085237ote.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 08:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vXwyD0ddcsazG3MxeN3cnLvJuWsUAB6zn4Igl6PaVxg=;
        b=lt9VvdJqFxXX1BzPCXSYEjJNQIg/ZlPCV3NIkHW02JbU89byowBnU+dQhwLpxGMmuf
         GccqTl5vM8Ky7OCyk329ajdRY5KtLQWTWcybS35isUfqk1AU7f+JEgb2NfkJ5wVCtNZo
         h57eaxTHxB8WZtGHnigj4Vn3U15tonrnsila/i4ggplclknTpQ7ju4AvNXsFdkzLCwZb
         YtYYEJ7qRvqwkiHr0+yNrB27ExdyVleFBpuUQBrIbVcawUNGW6GqYE5KhzQXF8GcnPWg
         5WElcq6j22AMvPp0dykbHqlg2/8VOq/+dRofdOv3GJ4eDgfO6ek7b0eKb19xxvCqpC5P
         297A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXwyD0ddcsazG3MxeN3cnLvJuWsUAB6zn4Igl6PaVxg=;
        b=meE04ORfWiB9CcdPZSyF2HppbzB35WHyqV5Cmrzzp7NdcwsJlmVD5oNPCMohKvDhoE
         Asw/nF0tUL2B7HLwQ3FDG3PnDqROv8GgPh5+7Qvxu6mf72teziM5DBYII98DXRus0wTg
         ywLjr/DMGX+ktzPzNUCxCComnGbUZh7km7MsB3X2DNyqkctsFAjozoQrHhTmWH+sgJyT
         rBTvCaa9Q+0wpYsSgMrl8px9Q9HyYKfvZ1Q9EPv7L0Ip8zGxrW9qoAyQ4h9WhGYOLy5K
         WUxTf/ZwPXTLVk/D6eHYTaF9W7wGRNAmAhL833e0sfelC1JZNkx1hF4kbioKOTkQsN/h
         nPoA==
X-Gm-Message-State: APjAAAWhDJNVTruOgkw4fqYfkVzQbktIpVzAArAZCBSTwcqFUM0/lrKw
        rG7zl6VMArCu+x+v+KtXSpudGIN3k6hYJ80v8SpY9A==
X-Google-Smtp-Source: APXvYqwUEdLf2kLpyp/3x/nsOh5SMSBuDcbD0LT2J8FxwNuTtYqwOt7lm62hIef7rrnexK2OiCZ86EQpadqMtYIJazs=
X-Received: by 2002:a9d:4801:: with SMTP id c1mr164337otf.32.1574095281350;
 Mon, 18 Nov 2019 08:41:21 -0800 (PST)
MIME-Version: 1.0
References: <20191115191728.87338-1-jannh@google.com> <20191115191728.87338-2-jannh@google.com>
 <20191118142144.GC6363@zn.tnic> <CACT4Y+bCOr=du1QEg8TtiZ-X6U+8ZPR4N07rJOeSCsd5h+zO3w@mail.gmail.com>
 <CAG48ez1AWW7FkvU31ahy=0ZiaAreSMz=FFA0u8-XkXT9hNdWKA@mail.gmail.com> <CACT4Y+bfF86YY_zEGWO1sK0NwuYgr8Cx0wFewRDq0WL_GBgO0Q@mail.gmail.com>
In-Reply-To: <CACT4Y+bfF86YY_zEGWO1sK0NwuYgr8Cx0wFewRDq0WL_GBgO0Q@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 18 Nov 2019 17:40:55 +0100
Message-ID: <CAG48ez1=Zwaf4eNW_nKMrJ5DJ31eVLgcRuLPntwm17AT5yatjg@mail.gmail.com>
Subject: error attribution for stalls [was: [PATCH v2 2/3] x86/traps: Print
 non-canonical address on #GP]
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 5:29 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Nov 18, 2019 at 5:20 PM 'Jann Horn' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> > On Mon, Nov 18, 2019 at 5:03 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > This exact form will confuse syzkaller crash parsing for Linux kernel:
> > > https://github.com/google/syzkaller/blob/1daed50ac33511e1a107228a9c3b80e5c4aebb5c/pkg/report/linux.go#L1347
> > > It expects a "general protection fault:" line for these crashes.
> > >
> > > A graceful way to update kernel crash messages would be to add more
> > > tests with the new format here:
> > > https://github.com/google/syzkaller/tree/1daed50ac33511e1a107228a9c3b80e5c4aebb5c/pkg/report/testdata/linux/report
> > > Update parsing code. Roll out new version. Update all other testing
> > > systems that detect and parse kernel crashes. Then commit kernel
> > > changes.
[...]
> > > An unfortunate consequence of offloading testing to third-party systems...
> >
> > And of not having a standard way to signal "this line starts something
> > that should be reported as a bug"? Maybe as a longer-term idea, it'd
> > help to have some sort of extra prefix byte that the kernel can print
> > to say "here comes a bug report, first line should be the subject", or
> > something like that, similar to how we have loglevels...
>
> This would be great.
> Also a way to denote crash end.
> However we have lots of special logic for subjects, not sure if kernel
> could provide good subject:
> https://github.com/google/syzkaller/blob/1daed50ac33511e1a107228a9c3b80e5c4aebb5c/pkg/report/linux.go#L537-L1588
> Probably it could, but it won't be completely trivial. E.g. if there
> is a stall inside of a timer function, it should give the name of the
> actual timer callback as identity ("stall in timer_subsystem_foo"). Or
> for syscalls we use more disambiguation b/c "in sys_ioclt" is not much
> different than saying "there is a bug in kernel" :)

Maybe I'm overthinking things, and maybe this is too much effort
relative to the benefit it brings, but here's a crazy idea:

For the specific case of stalls, it might help if the kernel could put
markers on the stack on the first stall warning (e.g. assuming that
ORC is enabled, by walking the stack and replacing all saved
instruction pointers with a pointer to some magic trampoline that
jumps back to the original caller using some sort of shadow stack),
then wait a few seconds, and then check how far on the stack the
markers have been cleared. Then hopefully you'd know exactly in which
function you're looping.
