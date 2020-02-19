Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6A5E16435B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 12:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgBSL3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 06:29:33 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41116 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgBSL3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:29:33 -0500
Received: by mail-io1-f68.google.com with SMTP id m25so145149ioo.8;
        Wed, 19 Feb 2020 03:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LuClPZIuWjei2K8sqfy9paJrcrdXGttPmOM7+E9ZZhA=;
        b=MuXIpMj+BKaWePlr0r79/YIA9c8bnu8yVmlv0bEic4OfbkrG16vzHBsfSWaja7r9C9
         NNsJ/WHSr1kB0pa9HQhu+TlyTXemBGYIqgVec1jvrvK0lfp5hzg+NA7JBbuNOSYhhdyP
         xxTbKO5i4ZXM+5sFCMVEudqOzdpKN4B6WVI4QHMAIPD7yTJpZtHLj2LlPZuSxjekT0yQ
         b4GwkqhkBcxSagqV9WHdR2CoVTCzh1UPEjEyyTOWx2mdiMjL3SrtJ8JlHLYy7WouKO3E
         LjOhZhRojlkc/xrARk+NA62qTkbzPO/esLGQEeYsIpB4u21qteS5GHbGXtBf2LcKue8R
         bjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuClPZIuWjei2K8sqfy9paJrcrdXGttPmOM7+E9ZZhA=;
        b=acadANllUbP+IEL4zaC7ASNeZjOXzYBpqbyLvnickGNm94d2+TEa29PQjmkZCIaL4+
         z42nISYRUNskBx3cmE0k0FQM3mOBSFvNbo4Ki7jKlyr0UPHCc1o4Q+NeunXpcQq+s7lt
         oNR3uVKub9PYE1H21ssG+cLopXx8Dm6Olz4wwozNHDSH51VKjWwCgNb76rUaqy17hA0E
         NYmd1nc1mJdCBNnuifxQ1nBmzDD3E87NfUgK51YZdRWLMMeezg+BsHXpT2sEyQfRggBz
         IZa4/bbq8HZfC0c3DUg0HLak+YmQwxUAGGb/xm/vbmgcAbuhRmqUxzuAfr5ktV5Xyfzb
         Oxsw==
X-Gm-Message-State: APjAAAWUPAgAeYzJ6zLm/42kfxh6E5BKuNUCu+p0ZE9mnrKilubNFs1h
        2EyrtCjTdCLV+1svayhKFQP7BXaRBUcPHw5KOUo=
X-Google-Smtp-Source: APXvYqzuLHFnt+BCtcAzKjlrtbURkaiGkUv6G9ObC1IkOhRPC5qz8V31aEO3gZf6dnSp1x/m2HGoxvy3hVfIfUNc0Ao=
X-Received: by 2002:a02:8587:: with SMTP id d7mr20362995jai.39.1582111772680;
 Wed, 19 Feb 2020 03:29:32 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
 <20200219082155.6787-1-linux@rasmusvillemoes.dk> <CAOi1vP-4=QCSZ2A89g1po2p=6n_g09SXUCa0_r2SBJm2greRmw@mail.gmail.com>
 <CAHp75VeJm-hbbtVAu69ZbDCCjs9cUK922D=hhW-MVu5OxczDzg@mail.gmail.com>
In-Reply-To: <CAHp75VeJm-hbbtVAu69ZbDCCjs9cUK922D=hhW-MVu5OxczDzg@mail.gmail.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 19 Feb 2020 12:29:59 +0100
Message-ID: <CAOi1vP8e-RQ2DHFSDMBgod7Ug4yMMoJBwxGDYNXWA6UL68pixg@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: sanely handle NULL passed to %pe
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 12:25 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Feb 19, 2020 at 1:21 PM Ilya Dryomov <idryomov@gmail.com> wrote:
> > On Wed, Feb 19, 2020 at 9:21 AM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> > >
> > > Extend %pe to pretty-print NULL in addition to ERR_PTRs,
> > > i.e. everything IS_ERR_OR_NULL().
>
> ...
>
> > > +       [0] = "NULL",
>
> > > +       test("[NULL]", "[%pe]", NULL);
>
> > FWIW I was about to post a patch that just special cases NULL here.
> >
> > I think changing errname() to return "NULL" for 0 is overkill.
> > People will sooner or later discover that function and start using it
> > in contexts that don't have anything to do with pointers.  Returning
> > _some_ string for 0 (instead of NULL) makes it very close to standard
> > strerror(), and "NULL" for 0 (i.e. success) seems rather odd.
>
> %pe is specifically for _pointers_. I don't see a point in your comment.

%pe is for pointers, but errname() in lib/errname.c will likely grow
more users in the future.

Thanks,

                Ilya
