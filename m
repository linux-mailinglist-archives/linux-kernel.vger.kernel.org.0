Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B77F7CC7A7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 06:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfJEERC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 00:17:02 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43965 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfJEERB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 00:17:01 -0400
Received: by mail-qk1-f194.google.com with SMTP id h126so7771654qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 21:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gR2Z2jLC/Tqbl5OOfY8ysoZnhqlSC5suivknCtmSIx4=;
        b=PFX3TwRaAaibzZJNUyiwU5FAiHFTwy2yNeG2opXmi52Jh4VJyKrllCPGh6DjmG0kCM
         8pqfMQozXnQXtaMz0MgubaXzco+Bbb6qtbWEbDs+YWYxnVnO/jooMizS9aZmYRF86sFq
         cH6zODJI5RgQ1rmElNOyh1fGblGGC8BEGY4uzA8/N2tVk/8+KBjbmNJiNUy4/aKYaBGO
         b+wNcghkFuZVeF+iNKIDu24t7ywl0jKozIekIXz5MKUraAryPzokN60ANcdCFGSklMs2
         y8Z7f8a+ItFLSvKnZOs+uadODV8p6l51wbiW3mA6kS08Z2CGctWK6lqvPkCqkW1fRGOO
         n02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gR2Z2jLC/Tqbl5OOfY8ysoZnhqlSC5suivknCtmSIx4=;
        b=Ri+N4bm5MirDZW7pAV+xi4aFQZMmTAlAztIGC6Bocq9sAaaUmhyQYNNi9cpIe7zu4P
         cymfYL/DOHLI+2/7mv12MfQO1Js0MVLmzuxX0K2rUuLfSYuCgE2RE/ghc3/OUppa+GmO
         sPdRjlhsu65qYm7KG3rUaAv5PBou/KNdjYrquTZiRiQeeNPtd76y4qzNphrEgoiLpcBS
         cukx9TxUz9ycVGqClMrZ9jKIwQLKynsJ1Jt/ZEEhwaEUmCJTFafZEDN7OIDD7kaM9qPt
         lLwcEPPdPEUpKFiOTB0JZlHCbu+ZyoQjui4b5ROP6yBv89AjlIsYxEqrpznW59gSPuOM
         nDTw==
X-Gm-Message-State: APjAAAWz8zC8mitYpAv4JTVGHhQGGenWYLkijzT9+9mYpkJQwRKvs+Yj
        AY1TDI1+oDBi5rgQbbxNluaAca2ZwaouKWCUJkv+2g==
X-Google-Smtp-Source: APXvYqyxji8x789Wk6fb99+fujT1fDYekIqggW8lvyLeWre+CgePvI/BL17qXzvvypDO6Q9uBTXDdw7TJsqZ9eJ2Gbg=
X-Received: by 2002:a37:9202:: with SMTP id u2mr13849869qkd.8.1570249020168;
 Fri, 04 Oct 2019 21:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20190920155420.rxiflqdrpzinncpy@willie-the-truck> <0715d98b-12e9-fd81-31d1-67bcb752b0a1@gmail.com>
In-Reply-To: <0715d98b-12e9-fd81-31d1-67bcb752b0a1@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 5 Oct 2019 06:16:48 +0200
Message-ID: <CACT4Y+bdPKQDGag1rZG6mCj2EKwEsgWdMuHZq_um2KuWOrog6Q@mail.gmail.com>
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Turner <pjt@google.com>, Daniel Axtens <dja@axtens.net>,
        Anatol Pomazau <anatol@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 2:58 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > This one is tricky. What I think we need to avoid is an onslaught of
> > patches adding READ_ONCE/WRITE_ONCE without a concrete analysis of the
> > code being modified. My worry is that Joe Developer is eager to get their
> > first patch into the kernel, so runs this tool and starts spamming
> > maintainers with these things to the point that they start ignoring KCSAN
> > reports altogether because of the time they take up.
> >
> > I suppose one thing we could do is to require each new READ_ONCE/WRITE_ONCE
> > to have a comment describing the racy access, a bit like we do for memory
> > barriers. Another possibility would be to use atomic_t more widely if
> > there is genuine concurrency involved.
> >
>
> About READ_ONCE() and WRITE_ONCE(), we will probably need
>
> ADD_ONCE(var, value)  for arches that can implement the RMW in a single instruction.
>
> WRITE_ONCE(var, var + value) does not look pretty, and increases register pressure.

FWIW modern compilers can handle this if we tell them what we are trying to do:

void foo(int *p, int x)
{
    x += __atomic_load_n(p, __ATOMIC_RELAXED);
    __atomic_store_n(p, x, __ATOMIC_RELAXED);
}

$ clang test.c -c -O2 && objdump -d test.o

0000000000000000 <foo>:
   0: 01 37                add    %esi,(%rdi)
   2: c3                    retq

We can have syntactic sugar on top of this of course.
