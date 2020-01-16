Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB7A13D69A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 10:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbgAPJSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 04:18:38 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46001 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgAPJSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:18:38 -0500
Received: by mail-qv1-f67.google.com with SMTP id l14so8734878qvu.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 01:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6aUm9IZBoyzrmlaZrE7sKzVINYzfYj5bNqwcb9Va7iI=;
        b=SYYbnAVSUXIa9qjPlD9vE1jh2fCqbJAF0lK3PwmNSVGUE7fZ33KjX8Jp/FflTWJ3X3
         WibzlMsnD5C7Lt1GTydrGs3zVxD8rnwiOHiHoAqyvYvBPqP+yN8skqAviLHJbytc34rv
         r1N+iQyRTkh4D60kFtO93fnagprGQQ5hdkH4p3eNquV3KT22+JlLvIVEGK+Qfg3Cqtud
         YwSEufB3R8cxmXBfTlzweLnBxfWw4pN4N+aUud8u7/3DBko8z2RIlzUQuZ5ZlFpc51wW
         YGQ0KyakrxLSLYaMN/REc/+8bH2bZEvxQJlQfK6XAmp7Y9HFCC7PWOPxaSvQeqFWXvcK
         jD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6aUm9IZBoyzrmlaZrE7sKzVINYzfYj5bNqwcb9Va7iI=;
        b=uar4rZGfQIP5bicmGmceh+kd8dkScuuDbY8OQVBYKwLICWw4/ynELRcyAwCWiMgHCA
         ICbrabSHu0sziSLlFKGbO+ELdk7Afre1jCUHPSh5dkYaWt2oBOtCf4OUf/AFq9J2yHm8
         0FM+F0GY3U642QO8K2acskBNi4xtjC2XdaqsYy4M0dzC00StxeMDOz61INBHc52QWcbI
         ak9Q61J1uDd6OgbkvFX2eDme6bCOkJVKqopSvrnNT90ZNE7EBg0JdCFkGhFPEATmruCJ
         JUvj6X/VuuQGf8Tn2KmN7BBhbB+bkObB99alFLGjN+RW248nPlOcN812YNVZ/wlcqYit
         B3lA==
X-Gm-Message-State: APjAAAU4Xj04o1bqbp0ucYBa0XHiqoEgW++cS3RTN0Cx8Nvovkfb0C4s
        IKEIvdKlJyg8m83jAYJ2Gll0226nQXm+3ohesnBArX2WtLg=
X-Google-Smtp-Source: APXvYqy8Op/c5GLfMYnJNdYmkCHYv+E4mN5Di6Wm/C4K++nSC7o+Ugdr1I5vYW/3smKnFkB3fD9x/EAI4aY8HUteVFQ=
X-Received: by 2002:a05:6214:1103:: with SMTP id e3mr1646963qvs.159.1579166316797;
 Thu, 16 Jan 2020 01:18:36 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
 <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
 <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
 <4f382794416c023b6711ed2ca645abe4fb17d6da.camel@sipsolutions.net> <b55720804de8e56febf48c7c3c11b578d06a8c9f.camel@sipsolutions.net>
In-Reply-To: <b55720804de8e56febf48c7c3c11b578d06a8c9f.camel@sipsolutions.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Jan 2020 10:18:25 +0100
Message-ID: <CACT4Y+brqD-o-u3Vt=C-PBiS2Wz+wXN3Q3RqBhf3XyRYaRoZJw@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, David Gow <davidgow@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        anton.ivanov@cambridgegreys.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 9:03 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Thu, 2020-01-16 at 08:57 +0100, Johannes Berg wrote:
> >
> > And if I remember from looking at KASAN, some of the constructors there
> > depended on initializing after the KASAN data structures were set up (or
> > at least allocated)? It may be that you solved that by allocating the
> > shadow so very early though.
>
> Actually, no ... it's still after main(), and the constructors run
> before.
>
> So I _think_ with the CONFIG_CONSTRUCTORS revert, this will no longer
> work (but happy to be proven wrong!), if so then I guess we do have to
> find a way to initialize the KASAN things from another (somehow
> earlier?) constructor ...
>
> Or find a way to fix CONFIG_CONSTRUCTORS and not revert, but I looked at
> it quite a bit and didn't.

Looking at this problem and at the number of KASAN_SANITIZE := n in
Makefiles (some of which are pretty sad, e.g. ignoring string.c,
kstrtox.c, vsprintf.c -- that's where the bugs are!), I think we
initialize KASAN too late. I think we need to do roughly what we do in
user-space asan (because it is user-space asan!). Constructors run
before main and it's really good, we need to initialize KASAN from
these constructors. Or if that's not enough in all cases, also add own
constructor/.preinit array entry to initialize as early as possible.
All we need to do is to call mmap syscall, there is really no
dependencies on anything kernel-related.
This should resolve the problem with constructors (after they
initialize KASAN, they can proceed to do anything they need) and it
should get rid of most KASAN_SANITIZE (in particular, all of
lib/Makefile and kernel/Makefile) and should fix stack instrumentation
(in case it does not work now). The only tiny bit we should not
instrument is the path from constructor up to mmap call.
