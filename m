Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D09E817619C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 18:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgCBRwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 12:52:42 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35397 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBRwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:52:42 -0500
Received: by mail-yw1-f66.google.com with SMTP id a132so645432ywb.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 09:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1IOLrEITmD2P6VvJiuWxnVZVe415X+z+1kv5oi6Hs5w=;
        b=Ob7ugNbolYcPYQ1RvjJtJ0j6ieNXbuDYZuyXXFLie3EM4zIZNEuw/jW+FdJJFwdv52
         84g3Wvq7rGW3EoP8iKyZqhcJROlzHsUXVtSD1R1ltJqSdjF+8A/z6QeYocl9NrBNpx3R
         Flc957tzuSZgDdYcTO8nL15zW1KM/5W+deBWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1IOLrEITmD2P6VvJiuWxnVZVe415X+z+1kv5oi6Hs5w=;
        b=D7+2TiQetq/CPb3DAFUVIv/8JjsbXVtxsWT9m6ix4O0spA+/x7AtFC4V3sS5PDnnFz
         zWVnVQK4TtKYywxgckXWalkqQYy/Wdeurei914fKPk5E2GzqzQZEye/WhYS7gaPpGDQ/
         z6vBhfFMO3jniCGW/o2keAp7xXJLy4MCvk53DlkHx4dbrqeC32Y72Id8TVdQgisMe3O5
         w2eL75wn+XugB48isspzMNtdEH9CD0Sw7jT1aRkwIgRqqaq+I/Zq5cCHWoV4zNP3LMdI
         gA66oHKfWcC+VVtyJk5/vqw2SBgo17benrvrAU8rew4YTU++FW7O8yqb+GVfC8C5pgsm
         VuJg==
X-Gm-Message-State: ANhLgQ1lbnRAnsCvhoAz6JLHNgqLWfYi3EE2D1Adz/PrNTVCrMEzejtT
        1Tu4aNDhMQfJVadJwPQW/4FNIxsRmy8=
X-Google-Smtp-Source: ADFU+vuNfnK7htyJl7tX+JzVLxk2ROoEUm47TqFnAtS9v2ulbTMi0Hs8+EQY9xANeWA32ZQx6kcMDA==
X-Received: by 2002:a25:a281:: with SMTP id c1mr142590ybi.327.1583171559070;
        Mon, 02 Mar 2020 09:52:39 -0800 (PST)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id h124sm3106458ywc.83.2020.03.02.09.52.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 09:52:37 -0800 (PST)
Received: by mail-yw1-f51.google.com with SMTP id h6so594535ywc.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 09:52:37 -0800 (PST)
X-Received: by 2002:a81:3888:: with SMTP id f130mr517632ywa.138.1583171556864;
 Mon, 02 Mar 2020 09:52:36 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com>
 <CACT4Y+Z_fGz2zVpco4kuGOVeCK=jv4zH0q9Uj5Hv5TAFxY3yRg@mail.gmail.com>
 <CAKFsvULZqJT3-NxYLsCaHpxemBCdyZN7nFTuQM40096UGqVzgQ@mail.gmail.com> <CACT4Y+YTNZRfKLH1=FibrtGj34MY=naDJY6GWVnpMvgShSLFhg@mail.gmail.com>
In-Reply-To: <CACT4Y+YTNZRfKLH1=FibrtGj34MY=naDJY6GWVnpMvgShSLFhg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Mar 2020 09:52:25 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKbpbH4sm4sv-74iHa+VzWuvF5v3ci7R-KVt+StRpMESg@mail.gmail.com>
Message-ID: <CAGXu5jKbpbH4sm4sv-74iHa+VzWuvF5v3ci7R-KVt+StRpMESg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] Port KASAN Tests to KUnit
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 10:39 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sat, Feb 29, 2020 at 2:56 AM Patricia Alfonso
> <trishalfonso@google.com> wrote:
> > On Thu, Feb 27, 2020 at 6:19 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > .On Thu, Feb 27, 2020 at 3:44 AM Patricia Alfonso
> > > > -       pr_info("out-of-bounds in copy_from_user()\n");
> > > > -       unused = copy_from_user(kmem, usermem, size + 1);
> > >
> > > Why is all of this removed?
> > > Most of these tests are hard earned and test some special corner cases.
> > >
> > I just moved it inside IS_MODULE(CONFIG_TEST_KASAN) instead because I
> > don't think there is a way to rewrite this without it being a module.
>
> You mean these are unconditionally crashing the machine? If yes,
> please add a comment about this.
>
> Theoretically we could have a notion of "death tests" similar to gunit:
> https://stackoverflow.com/questions/3698718/what-are-google-test-death-tests
> KUnit test runner wrapper would need to spawn a separete process per
> each such test. Under non-KUnit test runner these should probably be
> disabled by default and only run if specifically requested (a-la
> --gunit_filter/--gunit_also_run_disabled_tests).
> Could also be used to test other things that unconditionally panic,
> e.g. +Kees may be happy for unit tests for some of the
> hardening/fortification features.
> I am not asking to bundle this with this change of course.

A bunch of LKDTM tests can kill the system too. I collected the list
when building the selftest script for LKDTM:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/lkdtm/tests.txt

I'm all for unittests (I have earlier kind-of-unit-tests in
lib/test_user_copy.c lib/test_overflow.c etc), but most of LKDTM is
designed to be full system-behavior testing ("does the system correct
BUG the current thread, when some deeper system state is violated?")

-- 
Kees Cook
