Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD5F1931F2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 21:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCYUb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 16:31:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45832 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgCYUb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 16:31:27 -0400
Received: by mail-io1-f67.google.com with SMTP id a24so3122659iol.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 13:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/Soi+AtCkjv5EFY6mwxhlnaHyokmI6akGeDjAoTVAs=;
        b=HYnKrF+a2u3hfvTx7gQjR+7/E/YBo5PxyiRtgdtM9UvcD4ide7K9CNcG/v2diCIAgN
         ER2EkAeGcFoG0hW5Rn7sMaxyU+b3fNBhZjp5R/uzK+s0/+V6mpQ+RmiXknky3qnuOiwc
         rXxmtnONFlxV+MqWv+3vzwFJIgcp1GrUpxW3iH8nZRTwK/d6S/csrunkcoKjz4+H8pqW
         hafRUtn5dtagnGI0w/H+wb+K7KXTnaW89J7XVqmT8WK256JYwKPDNi+mtZj+JC8IfTZo
         GH/6PWvhUGbybFOw0O3nwQvdyZ9eFtbCldUjTYwXjcRJsoE2nU8Q8vzKwj4A5YfNKn2B
         14Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/Soi+AtCkjv5EFY6mwxhlnaHyokmI6akGeDjAoTVAs=;
        b=Nlh2KlPoJAOsPdXy+ahDGBAPydrsBZhxUm3ysFRd1y7TrHTWeKrTeOqF2NQLgbZfnz
         y5sLfKKWvAcM120SqHLpWL4aJKfx0EGNUBChL4VP7gaYFRf5TO/G9LhlGg621MWOXgUv
         QNiImWINkx/Q7i1TNlYPxVxbfRvDaDkA6U8fRkjeSK/H8WhD1xpCyPtZ9MRm1pfjzKrR
         knJePfGeM9I0s22ckmtOzOP8gb2mb0mOf088qHgcnBfRy3hCxDoAHAAZ/BlYIl5NL/bu
         iVmlse4LNLzhw2uFshiucq6D0mcg2kNjs1oaQtMvxeBlmd2TTX/UUcBY0OUkiT19m3oS
         gU8Q==
X-Gm-Message-State: ANhLgQ3nPL4JL/YSNn3yHZurYPDjctsvBer0NJzKZ79n2glFbYKfSY4d
        RFET2QIpeY8nEsUXYNwCaxjZsoH11FK76pSERSc=
X-Google-Smtp-Source: ADFU+vvNc2VgwoG4BJuCJvV3x6LVdOY904h0sXv46d26aZgKLgc3y0Y9jPtJWwNiqj52gnFYWjXrBVaMFy/xTBgXW0A=
X-Received: by 2002:a02:9288:: with SMTP id b8mr4752194jah.59.1585168286345;
 Wed, 25 Mar 2020 13:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <1581618066-187262-1-git-send-email-zhe.he@windriver.com>
 <20200216222148.GA161771@krava> <8cc46abf-208d-4aa4-8d0d-4922106bee6e@windriver.com>
 <20200325133012.GC14102@kernel.org> <CAGn10uVQdP32PNqyBm_dCxvRisj5tw4GU1f8j6Rq=Q6bmjmaAw@mail.gmail.com>
 <20200325192640.GI14102@kernel.org>
In-Reply-To: <20200325192640.GI14102@kernel.org>
From:   Sam Lunt <samueljlunt@gmail.com>
Date:   Wed, 25 Mar 2020 15:31:15 -0500
Message-ID: <CAGn10uXpBUnSx8fsL79oMzX5bRLyhqckvxXTLg5JxDARsjFpDw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf: Be compatible with all python versions when
 fetching ldflags
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     He Zhe <zhe.he@windriver.com>, Jiri Olsa <jolsa@redhat.com>,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 2:26 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Mar 25, 2020 at 09:40:34AM -0500, Sam Lunt escreveu:
> > On Wed, Mar 25, 2020 at 8:30 AM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Mon, Feb 17, 2020 at 10:24:27AM +0800, He Zhe escreveu:
> > > >
> > > >
> > > > On 2/17/20 6:22 AM, Jiri Olsa wrote:
> > > > > On Fri, Feb 14, 2020 at 02:21:05AM +0800, zhe.he@windriver.com wrote:
> > > > >> From: He Zhe <zhe.he@windriver.com>
> > > > >>
> > > > >> Since Python v3.8.0, with the following commit
> > > > >> 0a8e57248b91 ("bpo-36721: Add --embed option to python-config (GH-13500)"),
> > > > > we got similar change recently.. might have not been picked up yet
> > > > >
> > > > >   https://lore.kernel.org/lkml/20200131181123.tmamivhq4b7uqasr@gmail.com/
> > > >
> > > > Thanks for pointing out.
> > >
> > > So, just with your patch:
> > >
> > > [acme@five perf]$ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
> > > [acme@five perf]$ make PYTHON=python3 -C tools/perf O=/tmp/build/perf install-bin |& grep python
> > > ...                     libpython: [ OFF ]
> > > Makefile.config:750: No 'Python.h' (for Python 2.x support) was found: disables Python support - please install python-devel/python-dev
> > >   CC       /tmp/build/perf/tests/python-use.o
> > > [acme@five perf]$
> > >
> > > [acme@five perf]$ rpm -q python2-devel python3-devel python-devel
> > > package python2-devel is not installed
> > > python3-devel-3.7.6-2.fc31.x86_64
> > > package python-devel is not installed
> > > [acme@five perf]$
> > >
> > > [acme@five perf]$ cat /tmp/build/perf/feature/test-libpython.make.output
> > > /bin/sh: --configdir: command not found
> > > [acme@five perf]$ cat /tmp/build/perf/feature/test-libpython
> > > test-libpython.make.output          test-libpython-version.make.output
> > > [acme@five perf]$ cat /tmp/build/perf/feature/test-libpython-version.make.output
> > > /bin/sh: --configdir: command not found
> > > [acme@five perf]$
> > >
> > >
> > > Without your patch:
> > >
> > > [acme@five perf]$ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
> > > [acme@five perf]$ make PYTHON=python3 -C tools/perf O=/tmp/build/perf install-bin |& grep python
> > > ...                     libpython: [ on  ]
> > >   GEN      /tmp/build/perf/python/perf.so
> > >   MKDIR    /tmp/build/perf/scripts/python/Perf-Trace-Util/
> > >   CC       /tmp/build/perf/scripts/python/Perf-Trace-Util/Context.o
> > >   LD       /tmp/build/perf/scripts/python/Perf-Trace-Util/perf-in.o
> > >   CC       /tmp/build/perf/tests/python-use.o
> > >   CC       /tmp/build/perf/util/scripting-engines/trace-event-python.o
> > >   INSTALL  python-scripts
> > > [acme@five perf]$
> > >
> > > [acme@five perf]$ ldd /tmp/build/perf/perf |& grep python
> > >         libpython3.7m.so.1.0 => /lib64/libpython3.7m.so.1.0 (0x00007f11dd1ee000)
> > > [acme@five perf]$ perf -vv |& grep -i python
> > >              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> > > [acme@five perf]$
> > >
> > > What am I missing?
> >
> > It looks like you are using python3.7, but the change in behavior for
> > python-config happened in version 3.8
>
> Humm, but shouldn't this continue to work with python3.7?

Oh, my mistake, I didn't read the output carefully. It should
obviously still work with old versions, yes. I actually submitted a
similar patch, and it seemed to work when I used python 3.7. I wonder
if the issue is the "||" operator in the subshell.

https://lore.kernel.org/lkml/20200131181123.tmamivhq4b7uqasr@gmail.com/


> - Arnaldo
>
> > > [acme@five perf]$ cat /etc/redhat-release
> > > Fedora release 31 (Thirty One)
> > > [acme@five perf]$
> > >
> > > - Arnaldo
>
> --
>
> - Arnaldo
